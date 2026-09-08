iso_name="hackarch"
iso_label="HACKARCH_LIVE"
iso_publisher="ZodiakDrinker"
iso_application="HackArch Live Pentesting OS"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=(
  'bios.syslinux'
  'uefi.systemd-boot'
)
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86')
hostname="hackarch"

file_permissions=(
  ["/etc/profile.d/create-user.sh"]="0:0:755"
  ["/usr/local/bin"]="0:0:755"
  ["/etc/shadow"]="0:0:400"
)
