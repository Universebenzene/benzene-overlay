# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module-vendor

DESCRIPTION="YouDao Console Version (YDCV) - go portation"
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
	read -p "   Input your App ID (YDAppID): " -t 30 YDAPPID || die "Please enter your App ID!"
	read -p "   Input your App Spec (YDAppSpec): " -t 30 YDAPPSPEC || die "Please enter your App Spec!"
	if [[ -n ${YDAPPID} ]] && [[ -n ${YDAPPSPEC} ]]; then
		einfo "Your App ID is ${YDAPPID}, App Spec is ${YDAPPSPEC}. Continue building..."
	else
		ewarn
		ewarn "Your App ID or App Spec is empty. Ydgo may not work properly."
		ewarn
	fi

	ego build -mod vendor -x \
		-ldflags="-s -w -X main.VERSION=${PV} -X main.YDAppId=${YDAPPID} -X main.YDAppSec=${YDAPPSPEC}"
}

src_install() {
	default
	dobin ${PN}
}

pkg_postinst() {
	if [[ -z ${YDAPPID} ]] || [[ -z ${YDAPPSPEC} ]]; then
		ewarn
		ewarn "Your App ID or App Spec is empty. Ydgo may not work properly."
		ewarn
	fi
}
