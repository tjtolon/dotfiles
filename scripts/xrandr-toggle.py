#!/usr/bin/python
# Copyright 2009 David Smith. GNU GPLv2 or, at your option, a later version.

"""Fn-F7 toggle script for xrandr.

How does it work?

First, it's stateless, so it runs xrandr -q and parses the output into a
RandRState object. The RandRState object defines attributes and methods to
query and set xrandr options.

Second, it proceeds through the state machine toggling to the next state in
order. The RandRStateMachine controls the transitions (i.e. it defines the
states).

These steps are executed by the RandRToggleCommand that parses command line
arguments, instantiates the RandRState and RandRStateMachine instances, and
handles errors.

This is one of those programs that should have existed eons ago...
"""
# ... it's a bit over engineered, I guess

__author__ = 'david.daniel.smith@gmail.com (David Smith)'

import logging
import subprocess
import re
import sys


# noinspection SpellCheckingInspection
def vec_sum(*vecs):
    # promise to never send me different sized vectors, ok?
    size = len(vecs[0])
    result = []
    for i in range(0, size):
        result.append(sum([vec[i] for vec in vecs]))
    return result


def vec_scale(scalar, vec):
    return [el * scalar for el in vec]


class RandRState(object):
    """XRandR state representation."""

    # TODO: implement reflections, too, someday
    REFLECT_NORMAL = 'reflect_normal'
    REFLECT_X = 'reflect_x'
    REFLECT_Y = 'reflect_y'
    REFLECT_XY = 'reflect_xy'
    ROTATE_NORMAL = 'rotate_normal'
    ROTATE_INVERTED = 'rotate_inverted'
    ROTATE_LEFT = 'rotate_left'
    ROTATE_RIGHT = 'rotate_right'

    LEFT_OF = 'left_of'
    RIGHT_OF = 'right_of'
    ABOVE = 'above'
    BELOW = 'below'
    SAME_AS = 'same_as'

    def __init__(self):
        """Constructor."""
        self._displays = set()  # the list of display names
        self._connected = set()  # set of connected display names
        self._position = {}  # display -> (x,y)
        self._resolution = {}  # display -> (x,y)

    def _IterDisplays(self):
        return iter(self._displays)

    def _SetDisplays(self, displays):
        self._displays = set(displays)

    displays = property(_IterDisplays, _SetDisplays, None, 'display names')

    def AddDisplay(self, display):
        self._displays.add(display)

    def RemoveDisplay(self, display):
        self._displays.remove(display)

    def IsConnected(self, display):
        return display in self._connected

    def SetConnected(self, connected):
        self._connected = set(connected)

    def NumConnections(self):
        return len(self._connected)

    def GetPosition(self, display):
        result = self._position.get(display, None)
        return result and tuple(result) or None

    def AddConnected(self, display):
        self._connected.add(display)

    def RemoveConnected(self, display):
        self._connected.remove(display)

    def SetPosition(self, display, position):
        self._position[display] = tuple(position)

    def SetRelativePosition(self, display, relative_display, position):
        logging.debug('setting %s %s %s' % (display, position, relative_display))
        rel_pos = self.GetPosition(relative_display)
        rel_res = self.GetResolution(relative_display)
        dis_res = self.GetResolution(display)
        if position is self.LEFT_OF:
            dis_pos, rel_pos = rel_pos, vec_sum((dis_res[0], rel_pos[1]),
                                                (rel_pos[0], 0))
        elif position is self.ABOVE:
            dis_pos, rel_pos = rel_pos, vec_sum((rel_pos[0], dis_res[1]),
                                                (0, rel_pos[1]))
        elif position is self.RIGHT_OF:
            dis_pos = (rel_res[0], rel_pos[0])
        elif position is self.BELOW:
            dis_pos = (rel_pos[0], rel_res[1])
        elif position is self.SAME_AS:
            dis_pos = rel_pos
        else:
            raise RuntimeError('invalid position')
        self.SetPosition(display, dis_pos)
        self.SetPosition(relative_display, rel_pos)

    def GetResolution(self, display):
        result = self._resolution.get(display, None)
        return result and tuple(result) or None

    def SetResolution(self, display, resolution):
        self._resolution[display] = tuple(resolution)

    def __str__(self):
        result = 'XRandR State:\n'
        for display in self.displays:
            connected = ['disconnected', 'connected'][self.IsConnected(display)]
            geometry = ''
            resolution = self.GetResolution(display)
            position = self.GetPosition(display)
            if resolution is not None:
                geometry += '%dx%d' % resolution
            if position is not None:
                geometry += '+%d+%d' % position
            result += ' * ' + ' '.join((display, connected, geometry)) + '\n'
        return result.strip()

    def Commit(self):
        logging.info('Commiting %s' % self)
        args = ['xrandr']
        for display in self.displays:
            if self.IsConnected(display):
                args.extend(['--output', display,
                             '--pos', '%dx%d' % self.GetPosition(display),
                             '--mode', '%dx%d' % self.GetResolution(display)])
            else:
                args.extend(['--output', display, '--off'])
        logging.debug('running "%s"' % ' '.join(args))
        proc = subprocess.Popen(' '.join(args), stderr=subprocess.PIPE, shell=1)
        if proc.wait():
            error_msg = proc.stderr.read()
            logging.error(error_msg)
            raise RuntimeError(error_msg)

    @classmethod
    def ParseXRandROutput(cls, xrandr_output):
        screen_re = re.compile(r'^Screen')
        display_re = re.compile(r'^(?P<name>\S+)\s+((?P<disconnected>dis))?'
                                + r'connected\s+((?P<primary>primary)\s+)?'
                                + r'((?P<res_x>\d+)x(?P<res_y>\d+)'
                                + r'\+(?P<pos_x>\d+)\+(?P<pos_y>\d+))?')
        mode_re = re.compile(r'^\s+(?P<res_x>\d+)x(?P<res_y>\d+)\s+\d+')
        state = cls()
        line = xrandr_output.readline()
        while line:
            # look for a display line
            match = display_re.search(line.decode("utf-8"))
            if not match:
                line = xrandr_output.readline()
                continue
            # parse out the name and connection status
            display = match.group('name')
            connected = not bool(match.group('disconnected'))
            logging.debug('Found %s display %s' %
                          (['disconnected', 'connected'][connected],
                           display))
            state.AddDisplay(display)
            res = tuple((int(match.group(x) or 0) for x in ('res_x', 'res_y')))
            pos = tuple((int(match.group(x) or 0) for x in ('pos_x', 'pos_y')))
            if connected and res != (0, 0):
                state.AddConnected(display)
                state.SetResolution(display, res)
                state.SetPosition(display, pos)
                # skip until the next display line
                line = xrandr_output.readline()
                while line and not display_re.search(line.decode("utf-8")):
                    line = xrandr_output.readline()
            # else, look for a mode line and set the res to that
            else:
                while True:
                    line = xrandr_output.readline()
                    match = mode_re.match(line.decode("utf-8"))
                    # if no mode lines, give up
                    if not match:
                        break
                    res = tuple((int(match.group(x)) for x in ('res_x', 'res_y')))
                    state.AddConnected(display)
                    state.SetResolution(display, res)
                    # only need one so might as well end the loop here
                    break
        logging.debug('Parsed %s' % state)
        return state


class RandRStateMachine(object):
    """State manipulator."""

    def __init__(self, state):
        """Constructor."""
        self._state = state

    def GetCurrentState(self):
        return self._state

    def NextState(self):
        # if we have a clone, then next pair to the left
        if self.IsClone():
            logging.info('CLONE -> PAIR_LEFT')
            self.SetPairExtLeft()
        # if we have a pair to the left, then next pair to the right
        elif self.IsPairExtLeft():
            logging.info('PAIR_LEFT -> PAIR_RIGHT')
            self.SetPairExtRight()
        # else, just set cloning
        else:
            logging.info('UNKNOWN (or PAIR_RIGHT) -> CLONE')
            self.SetClone()

    def IsClone(self):
        found_origin_count = 0
        for disp in self._state.displays:
            if not self._state.IsConnected(disp):
                continue
            if self._state.GetPosition(disp) == (0, 0):
                found_origin_count += 1
        return found_origin_count >= 2

    def SetClone(self):
        for disp in self._state.displays:
            logging.info('Cloning display %s' % disp)
            if not self._state.IsConnected(disp):
                logging.info('Skipping disconnected display %s' % disp)
                continue
            self._state.SetPosition(disp, (0, 0))
        self._state.Commit()

    def _IsPairCmp(self):
        if self._state.NumConnections() < 2:
            return 0
        for disp in self._state.displays:
            if not self._state.IsConnected(disp):
                continue
            if disp.startswith('DP'):
                if self._state.GetPosition(disp) == (0, 0):
                    return 1
                else:
                    return -1
        return 0

    def IsPairExtLeft(self):
        return self._IsPairCmp() < 0

    def IsPairExtRight(self):
        return self._IsPairCmp() > 0

    def _SetPairExt(self, direction):
        dp = ''
        ext = ''
        for disp in self._state.displays:
            if not self._state.IsConnected(disp):
                continue
            if disp.startswith('DP'):
                dp = disp
            else:
                ext = disp
        self._state.SetRelativePosition(ext, dp, direction)
        self._state.Commit()

    def SetPairExtLeft(self):
        self._SetPairExt(self._state.LEFT_OF)

    def SetPairExtRight(self):
        for disp in self._state.displays:
            if disp.startswith('DP'):
                self._state.SetPosition(disp, (0, 0))
                self._state.Commit()
        self._SetPairExt(self._state.RIGHT_OF)


def main():
    logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)
    xrandr = subprocess.Popen('xrandr -q', stdout=subprocess.PIPE, shell=True)
    xrandr.wait()
    state = RandRState.ParseXRandROutput(xrandr.stdout)
    sm = RandRStateMachine(state)
    sm.NextState()


if __name__ == '__main__':
    main()
