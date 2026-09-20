# Move 100 GiB from Fedora to Windows C:

The GParted Live ISO at `/home/khuongduy354/isos/gparted-live-1.8.1-6-amd64.iso`
passed SHA-256 verification. Its GRUB entry is installed. This plan has **not**
been applied to the partition table.

## Physical order on `/dev/nvme0n1` before changes

1. `p1`: Windows EFI, 100 MiB
2. `p2`: Microsoft reserved, 16 MiB
3. `p3`: Windows C:, NTFS, 240.2 GiB
4. `p5`: Fedora EFI, FAT32, 572 MiB
5. `p6`: Fedora `/boot`, ext4, 1 GiB
6. `p7`: Fedora `/`, Btrfs, 223 GiB
7. `p4`: Windows recovery, NTFS, 870 MiB

Desired order: `p3` → about 100 GiB unallocated → `p5` → `p6` → `p7` → `p4`.
Windows can then extend C: into the adjacent unallocated space.

## In GParted Live

1. Back up personal files you need. The GitHub repository contains configuration,
   not a full copy of the disk or your files.
2. Reboot and enter the ASUS NUC firmware with F2. Disable Secure Boot under
   Boot > Secure Boot, save with F10. At the Fedora GRUB menu, select
   `GParted Live 1.8.1-6 (from internal disk, load to RAM)`.
3. Select `/dev/nvme0n1` (465.8 GiB). Confirm `p5`, `p6`, and `p7` are unmounted.
4. Resize/move **`p7`**: set Free space preceding to **102400 MiB**,
   Free space following to **0 MiB**. Its new size should be about **126003 MiB**.
5. Move the whole **`p6`** partition to the far right of the new gap. Keep its
   1 GiB size. This places the gap between `p5` and `p6`.
6. Move the whole **`p5`** partition to the far right of that gap. Keep its
   572 MiB size. This places the gap directly after Windows `p3`.
7. Review the pending operations. `p1`, `p2`, `p3`, and `p4` should be untouched.
   Apply the operations and wait for them to complete without interruption.
8. **After Apply finishes, before rebooting**, open GParted Live's Terminal and
   paste this one command from this plan or chat. It creates a new Fedora boot
   entry using `p5`'s new location. Running it before step 7 would record the
   old location instead.

   ```sh
   sudo efibootmgr -c -d /dev/nvme0n1 -p 5 -L 'Fedora (moved)' -l '\EFI\fedora\shimx64.efi'
   ```

   Check that the output includes `Fedora (moved)`. If the command reports an
   error, stay in GParted Live and get help before rebooting.
9. Reboot into Fedora first and confirm it works. Then boot Windows and use
   Disk Management's **Extend Volume** on C:. Re-enable Secure Boot after both
   systems boot successfully if desired.
