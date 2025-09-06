# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for libsystemd.so"

SLOT="0/2"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 ~sparc x86"
IUSE="systemd"

RDEPEND="
	!systemd? ( || (
		sys-libs/elogind-libsystemd:0/2
		sys-libs/libsystemd:0/2
	) )
	systemd? ( sys-apps/systemd:0/2 )
"
