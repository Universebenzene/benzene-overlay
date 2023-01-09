# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Firmware for the Broadcom 1570 PCIe webcam"
HOMEPAGE="https://github.com/patjak/facetimehd-firmware"

EGIT_REPO_URI="https://github.com/patjak/${PN}.git"

LICENSE="APPLE_LICENSE"
SLOT="0"
RESTRICT="bindist mirror"

BDEPEND="app-arch/cpio
	app-arch/gzip
	app-arch/xz-utils
	net-misc/curl
	sys-apps/coreutils
"

src_unpack() {
	git-r3_src_unpack
	emake -C "${S}"
}

src_install() {
	insinto "/lib/firmware/facetimehd"
	doins firmware.bin
}
