#!/usr/bin/env python3
import apt
apt_packages = [
    "i3",
    "rofi",
    "zsh",
    "keepass2",
    "emacs",
    "stow"
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
