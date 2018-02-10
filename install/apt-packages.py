#!/usr/bin/env python3
import apt
apt_packages = [
    "i3",
    "rofi",
    "zsh",
    "keepass2",
    "emacs",
    "stow",
    "feh",
    # Required for polybar compiling
    "cmake",
    "cmake-data",
    "libcairo2-dev",
    "libxcb1-dev",
    "libxcb-ewmh-dev",
    "libxcb-icccm4-dev",
    "libxcb-image0-dev",
    "libxcb-randr0-dev",
    "libxcb-util0-dev",
    "libxcb-xkb-dev",
    "pkg-config",
    "python-xcbgen",
    "xcb-proto",
    # Enables support for getting values from the X resource db
    "libxcb-xrm-dev",
    # Enables support for the `cursor-click` and `cursor-scroll` settings
    "libxcb-cursor-dev",
    # Enables the internal i3 module
    "i3-wm",
    # Enables the internal volume module
    "libasound2-dev",
    # Enables the internal mpd module
    "libmpdclient-dev",
    # Enables the internal network module
    "libiw-dev",
    # Enables the internal github module
    "libcurl4-openssl-dev",

    "ttf-unifont",
    "silversearcher-ag",
    "curl"
]

if __name__ == '__main__':
    cache = apt.Cache()
    print("Updating APT cache")
    cache.update()

    for pkg_name in apt_packages:
        if pkg_name in cache:
            pkg = cache[pkg_name]
            if pkg.is_installed:
                print("{:10} has been installed already".format(pkg.name))
            else:
                print("{:10} will be installed".format(pkg.name))
                pkg.mark_install()
        else:
            print("{:10} is a nonexistent package".format(pkg_name))
    print("Starting to install")
    cache.commit()
    print("APT packages have been installed")
