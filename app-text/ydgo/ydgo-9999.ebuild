# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module-vendor

DESCRIPTION="YouDao Console Version (YDCV) - go"
HOMEPAGE="https://github.com/boypt/ydgo"
LICENSE="MIT"
SLOT="0"
PROPERTIES="interactive"

EGIT_REPO_URI="${HOMEPAGE}.git"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3

	src_unpack() {
		git-r3_src_unpack
		go-module-vendor_live_vendor
	}
else
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Universebenzene/ebuild-vendors/archive/refs/tags/${P}.tar.gz -> ${P}-vendor.tar.gz"
fi

RDEPEND="${DEPEND}"

src_compile() {
	ewarn
	ewarn "You need to apply your own API Key for building and using ydgo!"
	ewarn "See here for more details: https://github.com/felixonmars/ydcv#%E6%B3%A8%E6%84%8F"
	ewarn
	elog "Input your App ID (YDAppID):"
	read YDAPPID
	elog "Input your App Spec (YDAppSpec):"
	read YDAPPSPEC
	einfo "Your App ID is ${YDAPPID}, App Spec is ${YDAPPSPEC}. Continue building..."

	ego build -mod vendor -x \
		-ldflags="-s -w -X main.VERSION=${PV} -X main.YDAppId=${YDAPPID} -X main.YDAppSec=${YDAPPSPEC}"
}

src_install() {
	default
	dobin ${PN}
}

pkg_postinst() {
	ewarn
	ewarn "As the building process of ydgo needs interactive inputing for API Keys,"
	ewarn "this will HANG ON INFINITIVELY if you aren't available for the inputing."
	ewarn "In ordor not to disturb your emerging process,"
	ewarn "it is STRONGLY RECOMMENDED to add '--exclude ydgo' to your emerge parameters."
	ewarn "e.g. while upgrading system:"
	ewarn "# emerge --update --deep -newuse @world --exclude app-text/ydgo"
	ewarn
}
