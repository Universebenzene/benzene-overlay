# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="libpurple protocol support for oicq"
HOMEPAGE="https://github.com/axon-oicq/purple-oicq"
SRC_URI="https://github.com/axon-oicq/purple-oicq/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+libaxon"

RDEPEND="dev-libs/json-glib
	net-im/pidgin
	libaxon? ( net-libs/libaxon-bin[purple] )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
