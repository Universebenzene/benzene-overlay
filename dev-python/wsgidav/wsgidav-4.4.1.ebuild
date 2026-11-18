# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Generic and extendable WebDAV server based on WSGI"
HOMEPAGE="https://wsgidav.readthedocs.io"
SRC_URI="https://github.com/mar10/wsgidav/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bcrypt htpasswd pam"

RDEPEND="dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/json5[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	bcrypt? ( dev-python/bcrypt[${PYTHON_USEDEP}] )
	htpasswd? ( dev-python/libpass[${PYTHON_USEDEP}] )
	pam? ( dev-python/python-pam[${PYTHON_USEDEP}] )
"

BDEPEND="doc? ( media-gfx/graphviz )
	test? (
		dev-python/cheroot[${PYTHON_USEDEP}]
		dev-python/libpass[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/python-pam[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/webtest[${PYTHON_USEDEP}]
		dev-vcs/mercurial[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinxcontrib-googleanalytics \
	dev-python/sphinxcontrib-mermaid \
	dev-python/furo
