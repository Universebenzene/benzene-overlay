# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Random Access Read-Only Tar Mount Library"
HOMEPAGE="https://pypi.org/project/ratarmountcore"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bzip2 +full +gzip +rar +xz +zstd"
REQUIRED_USE="full? ( bzip2 gzip rar xz zstd )"

RDEPEND="bzip2? ( >=dev-python/indexed_bzip2-1.3.1[${PYTHON_USEDEP}] )
	gzip? ( >=dev-python/indexed_gzip-1.6.3[${PYTHON_USEDEP}] )
	rar? ( >=dev-python/rarfile-4.0[${PYTHON_USEDEP}] )
	xz? ( >=dev-python/python-xz-0.4.0[${PYTHON_USEDEP}] )
	zstd? ( >=dev-python/indexed_zstd-1.2.2[${PYTHON_USEDEP}] )
"

distutils_enable_tests nose
