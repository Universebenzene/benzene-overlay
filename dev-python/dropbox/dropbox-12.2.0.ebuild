# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..15},{13..15}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..15}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="The Official Dropbox API V2 SDK for Python"
HOMEPAGE="https://www.dropbox.com/developers https://github.com/dropbox/dropbox-sdk-python"
SRC_URI+=" test? (
		https://github.com/dropbox/dropbox-sdk-python/raw/refs/tags/v${PV}/test/unit/test_content_hash.py -> ${P}-test_content_hash.py
		https://github.com/dropbox/dropbox-sdk-python/raw/refs/tags/v${PV}/test/unit/test_dropbox_unit.py -> ${P}-test_dropbox_unit.py
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	>=dev-python/stone-3.5.1[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest

python_prepare_all() {
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/test/}test_content_hash.py || die ;
		cp {"${DISTDIR}"/${P}-,"${S}"/test/}test_dropbox_unit.py || die ;
		sed -i 's/import mock/from unittest import mock/' test/test_dropbox_unit.py || die ;
	}

	distutils-r1_python_prepare_all
}
