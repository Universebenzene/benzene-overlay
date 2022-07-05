# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="libpurple protocol support for oicq"
HOMEPAGE="https://codeberg.org/goodspeed/purple-oicq"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://codeberg.org/goodspeed/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://codeberg.org/goodspeed/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64"
	S="${WORKDIR}/${PN}"
fi

LICENSE="Unlicense"
SLOT="0"
IUSE="+libaxon"

RDEPEND="dev-libs/json-glib
	net-im/pidgin
	libaxon? ( net-libs/libaxon-bin[purple] )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
