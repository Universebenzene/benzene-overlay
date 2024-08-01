# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Sphinx extension to show tooltips with content embedded when hover a reference"
HOMEPAGE="https://sphinx-version-warning.readthedocs.io"
SRC_URI="https://github.com/readthedocs/sphinx-hoverxref/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/sphinx-5[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-jquery[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/sphinxcontrib-bibtex[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
# exception: [Errno 13] Permission denied: '/usr/lib/python3.12/site-packages/versionwarning/_static/data'
#distutils_enable_sphinx docs dev-python/sphinx-autoapi \
#	dev-python/sphinx-notfound-page \
#	dev-python/sphinx-prompt \
#	dev-python/sphinx-tabs \
#	dev-python/sphinx-version-warning \
#	dev-python/sphinxcontrib-bibtex \
#	dev-python/sphinxcontrib-jquery \
#	dev-python/sphinxemoji

#python_prepare_all() {
#	use doc && { sed -i 's/sphinx-prompt/sphinx_prompt/' docs/conf.py || die ; }
#
#	distutils-r1_python_prepare_all
#}

#python_compile_all() {
#	# Bug #883189
#	# SANDBOX ACCESS DENIED:  mkdir: /usr/lib/python3.12/site-packages/versionwarning/_static/data
#	addpredict $(python_get_sitedir)
#	sphinx_compile_all
#}
