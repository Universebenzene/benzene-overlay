# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Jupyter notebooks as Markdown documents, Julia, Python or R scripts"
HOMEPAGE="https://jupytext.readthedocs.io"
SRC_URI="https://github.com/mwouts/jupytext/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	$(pypi_wheel_url)
	doc? ( https://github.com/mwouts/${PN}/raw/v1.16.0.rc0/jupyterlab/packages/jupyterlab-jupytext-extension/ui-tests/tests/jupytext-menu.spec.ts-snapshots/opened-jupytext-menu-jupytext-pair-notebook-jupytext-linux.png -> 1.16.0_rc0-opened-jupytext-menu-jupytext-pair-notebook-jupytext-linux.png )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/markdown-it-py-1.0.0[${PYTHON_USEDEP}]
	dev-python/mdit-py-plugins[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/tomli[${PYTHON_USEDEP}]' python3_10)
"
BDEPEND="test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/autopep8[${PYTHON_USEDEP}]
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/gitpython[${PYTHON_USEDEP}]
		dev-python/isort[${PYTHON_USEDEP}]
		dev-python/myst-parser[${PYTHON_USEDEP}]
		dev-python/nbconvert[${PYTHON_USEDEP}]
		dev-python/notebook[${PYTHON_USEDEP}]
		>=dev-python/sphinx-gallery-0.8[${PYTHON_USEDEP}]
		virtual/pandoc
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton dev-python/myst-parser

EPYTEST_IGNORE=( tests/external/pre_commit )

python_prepare_all() {
	use doc && { cp {"${DISTDIR}"/1.16.0_rc0-,"${S}"/jupyterlab/packages/jupyterlab-jupytext-extension/ui-tests/tests/jupytext-menu.spec.ts-snapshots/}opened-jupytext-menu-jupytext-pair-notebook-jupytext-linux.png || die ; }
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/$(pypi_wheel_name)"
}

python_install_all() {
	distutils-r1_python_install_all
	mv "${ED%/}"/{usr/,}etc || die
}
