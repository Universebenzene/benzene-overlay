# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="YouDao Console Version - Simple wrapper for Youdao online translate service API"
HOMEPAGE="https://github.com/felixonmars/ydcv"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/felixonmars/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/felixonmars/ydcv/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="pkg-info"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	pkg-info? (
		dev-python/setuptools-markdown[${PYTHON_USEDEP}]
		dev-python/pypandoc[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
	use pkg-info || eapply "${FILESDIR}/${PN}-disable_setuptools_markdown.patch"

	distutils-r1_python_prepare_all
}

python_install_all() {
	insinto /usr/share/zsh/site-functions
	newins contrib/zsh_completion _${PN}

	distutils-r1_python_install_all
}
