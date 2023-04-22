# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

MY_PN="ExifRead"
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="Easy to use Python module to extract Exif metadata from digital image files"
HOMEPAGE="https://github.com/ianare/exif-py"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests nose
