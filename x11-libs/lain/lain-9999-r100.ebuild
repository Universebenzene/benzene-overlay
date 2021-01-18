# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..3} luajit )

inherit git-r3 lua-single

DESCRIPTION="Layouts, asynchronous widgets and utilities for Awesome WM"
HOMEPAGE="https://github.com/lcpz/lain"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="+curl test"
REQUIRED_USE="${LUA_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}
	x11-wm/awesome[${LUA_SINGLE_USEDEP}]
	curl? ( net-misc/curl )
"
BDEPEND="virtual/pkgconfig
	test? (
		$(lua_gen_cond_dep 'dev-lua/busted[${LUA_USEDEP}]')
		${RDEPEND}
	)
"

DOCS=( ISSUE_TEMPLATE.md README.rst )

src_test() {
	busted --lua=${ELUA} lain-scm-1.rockspec || die
}

src_install() {
	insinto $(lua_get_lmod_dir)/${PN}
	doins -r {icons,layout,util,widget,*.lua}
	einstalldocs
}
