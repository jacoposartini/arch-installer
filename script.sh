// Set the keyboard layout
loadkeys it

// Update the system clock
timedatectl set-ntp true

//Partition the disks
// TODO
// sda1 -> FS
// sda2 -> Swap

// Format the partitions
mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2

// Mount the file systems
mount /dev/sda1 /mnt

// Install essential packages
pacstrap /mnt base linux linux-firmware

// Fstab
genfstab -U /mnt >> /mnt/etc/fstab

// Chroot
arch-chroot /mnt

// Time zone
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc

// Localization
echo "it_IT.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=it" > /etc/vconsole.conf
locale-gen

// Network configuration
echo "
127.0.0.1   localhost
::1         localhost
127.0.1.1   arch
"

// Initramfs
mkinitcpio -P

passwd
