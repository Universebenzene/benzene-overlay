# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VIM_PLUGIN_VIM_VERSION="7.2"

inherit vim-plugin

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/preservim/vim-indent-guides.git"
	inherit git-r3
else
	SRC_URI="https://github.com/preservim/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="vim plugin: visually displaying indent levels in code"
HOMEPAGE="https://www.vim.org/scripts/script.php?script_id=3361 https://github.com/preservim/vim-indent-guides"
LICENSE="MIT"

VIM_PLUGIN_HELPFILES="indent_guides.txt"
