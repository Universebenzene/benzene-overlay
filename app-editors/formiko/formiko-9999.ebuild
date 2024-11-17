# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 optfeature xdg

DESCRIPTION="reStructuredText editor and live previewer"
HOMEPAGE="https://github.com/ondratu/formiko"

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

RDEPEND="app-text/gtkspell:3
	dev-libs/gobject-introspection
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	|| ( net-libs/webkit-gtk:4.1 net-libs/webkit-gtk:4 )
	x11-libs/gtk+:3
	x11-libs/gtksourceview:4
	vim? ( app-editors/vim )
"

python_prepare_all() {
	sed -e 's/1.gz/1/g' -e "s|doc/${PN}|doc/${PF}|" -i setup.py || die

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "Common Mark support (MarkDown)" dev-python/recommonmark
	optfeature "syntax color in html output code blocks" dev-python/pygments
}
