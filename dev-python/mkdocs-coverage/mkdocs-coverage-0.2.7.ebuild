# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="MkDocs plugin to integrate your coverage HTML report into your site"
HOMEPAGE="https://pawamoy.github.io/mkdocs-coverage"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	#  FileNotFoundError: [Errno 2] No such file or directory: 'pdm.lock'

RDEPEND=">=dev-python/mkdocs-1.2[${PYTHON_USEDEP}]"

#distutils_enable_tests pytest

python_prepare_all() {
	sed -i -e 's/pdm-backend/pdm-pep517/' -e 's/pdm.backend/pdm.pep517.api/' pyproject.toml || die

	distutils-r1_python_prepare_all
}
