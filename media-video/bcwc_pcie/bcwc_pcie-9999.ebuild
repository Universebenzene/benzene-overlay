# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod git-r3

DESCRIPTION="Reverse engineered Linux driver for the Broadcom 1570 PCIe webcam"
HOMEPAGE="https://github.com/patjak/bcwc_pcie"

EGIT_REPO_URI="https://github.com/patjak/bcwc_pcie"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-video/facetimehd-firmware
	media-libs/libv4l
"

BUILD_TARGETS="all"
MODULE_NAMES="facetimehd()"
CONFIG_CHECK="VIDEO_V4L2 VIDEOBUF2_CORE VIDEOBUF2_DMA_SG"

src_unpack() {
	kernel_is -ge 4 8 && {
		EGIT_BRANCH="master"
	}
	git-r3_src_unpack
}

src_prepare() {
	sed -i "s#KDIR := /lib/modules/\$(KVERSION)/build#KDIR := ${KERNEL_DIR}#" Makefile || die

	default
}
