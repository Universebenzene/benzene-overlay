# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Layouts, asynchronous widgets and utilities for Awesome WM"
HOMEPAGE="https://github.com/lcpz/lain"
EGIT_REPO_URI="${HOMEPAGE}.git"

inherit git-r3 toolchain-funcs

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+curl"

DEPEND=">=dev-lang/lua-5.1:="
RDEPEND="${DEPEND}
	>=x11-wm/awesome-4.0
	curl? ( net-misc/curl )
"
BDEPEND=""

DOCS=( ISSUE_TEMPLATE.md README.rst )

src_install() {
	insinto "$($(tc-getPKG_CONFIG) --variable INSTALL_LMOD lua)"/${PN}
	doins -r {icons,layout,util,widget,*.lua}
	default
}
