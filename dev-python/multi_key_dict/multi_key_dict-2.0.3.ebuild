# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Multi key dictionary implementation"
HOMEPAGE="https://github.com/formiaczek/multi_key_dict"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/formiaczek/${PN}.git"
	inherit git-r3
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

#distutils_enable_tests nose
