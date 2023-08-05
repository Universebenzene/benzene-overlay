# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/Yggdroot/indentLine.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Yggdroot/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="vim plugin: display the indention levels with thin vertical lines"
HOMEPAGE="https://www.vim.org/scripts/script.php?script_id=4354 https://github.com/Yggdroot/indentLine"
LICENSE="MIT"

VIM_PLUGIN_HELPFILES="${PN}.txt"
