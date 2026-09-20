# Fedora configuration backup

Selected settings from the Fedora 44 installation of `khuongduy354`, captured September 2026. `home/` mirrors paths under the home directory; `system/` mirrors selected paths under `/etc`. The `manifests/` directory records installed RPM package names and a text export of dconf preferences.

This is a settings backup, not a full system image. Development files, games, installed applications, browser profiles, cookies, passwords, SSH keys, cloud credentials, Sunshine pairing keys, and authentication state are excluded.

The device-specific [GParted partition plan](docs/PARTITION-PLAN.md) records the
planned 100 GiB transfer from Fedora to Windows C:. It is a reference for this
disk layout, not a restore procedure for other computers.

## Restoring

1. Install Fedora and the applications you want. `manifests/rpm-packages.txt` is an inventory, not a command to install every package. External repositories are listed under `system/etc/yum.repos.d/`.
2. Review files in `home/` and copy the desired ones to the matching paths in your home directory. Keep executable permissions on scripts in `home/.local/bin/`.
3. Review `manifests/dconf-settings.ini` and apply selected preferences with `dconf load /` if appropriate. It may contain device or network-specific identifiers.
4. Treat `system/etc/` as reference material. Review hardware names, UUIDs, boot parameters, autologin settings, and repository URLs before making any system changes. In particular, do not blindly replace `/etc/fstab`, `/etc/default/grub`, or `/etc/kernel/cmdline` on another installation.
5. Reauthenticate GitHub, cloud tools, browsers, and Sunshine on the restored system.

The `.gitignore` blocks common credential and runtime paths if this repository is expanded later. Add new files deliberately and review staged content before pushing.
