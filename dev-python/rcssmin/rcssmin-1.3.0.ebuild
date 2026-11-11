# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,{13..15}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Fast CSS minifier for Python"
HOMEPAGE="https://opensource.perlig.de/rcssmin"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_configure() {
	export SETUP_CEXT_REQUIRED=1
}
