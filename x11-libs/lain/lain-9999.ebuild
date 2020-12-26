# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="Layouts, asynchronous widgets and utilities for Awesome WM"
HOMEPAGE="https://github.com/lcpz/lain"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+curl luajit test"
RESTRICT="!test? ( test )"

DEPEND="!luajit? ( >=dev-lang/lua-5.1:0= )
	luajit? ( dev-lang/luajit:2= )
"
RDEPEND="${DEPEND}
	>=x11-wm/awesome-4.0[luajit=]
	curl? ( net-misc/curl )
"
BDEPEND="virtual/pkgconfig
	test? (
		${RDEPEND}
		dev-lua/busted
	)
"

DOCS=( ISSUE_TEMPLATE.md README.rst )

src_test() {
	busted -o gtest lain-scm-1.rockspec || die
}

src_install() {
	insinto "$($(tc-getPKG_CONFIG) --variable INSTALL_LMOD $(usex luajit 'luajit' 'lua'))"/${PN}
	doins -r {icons,layout,util,widget,*.lua}
	default
}
