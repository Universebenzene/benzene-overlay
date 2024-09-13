# Copyright 2011-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Provide standalone libsystemd.so without systemd by linking libelogind.so"
HOMEPAGE="http://systemd.io https://github.com/elogind/elogind"

LICENSE="CC0-1.0 GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0/2"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"
IUSE="split-usr"

RDEPEND="!sys-apps/systemd
	sys-auth/elogind
	!sys-libs/libsystemd
"

S="${WORKDIR}"

src_install() {
	local EDLIB=$(usex split-usr "/$(get_libdir)" "/usr/$(get_libdir)")

	dosym libelogind.so.0 ${EDLIB}/libsystemd.so.0
	dosym libsystemd.so.0 ${EDLIB}/libsystemd.so
	use split-usr && dosym -r /$(get_libdir)/libsystemd.so.0 /usr/$(get_libdir)/libsystemd.so
}
