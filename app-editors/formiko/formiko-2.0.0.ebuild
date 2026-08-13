# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..15} )

inherit distutils-r1 optfeature xdg

DESCRIPTION="reStructuredText editor and live previewer"
HOMEPAGE="https://formiko.zeropage.cz"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/ondratu/${PN}.git"
	inherit git-r3
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE="vim"

BDEPEND=">=dev-python/docutils-0.12[${PYTHON_USEDEP}]"
RDEPEND="app-text/libspelling:1
	dev-libs/gobject-introspection
	>=dev-python/docutils-0.12[${PYTHON_USEDEP}]
	dev-python/jsonpath-ng[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	gui-libs/gtk:4
	gui-libs/gtksourceview:5
	gui-libs/libadwaita:1
	net-libs/webkit-gtk:6
	vim? ( app-editors/vim )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_prepare_all() {
	sed -e 's/1.gz/1/g' -e "s|doc/${PN}|doc/${PF}|" -i setup.py || die

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "syntax color in html output code blocks" dev-python/pygments
}
