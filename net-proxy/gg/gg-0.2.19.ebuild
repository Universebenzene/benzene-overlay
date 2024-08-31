# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module-vendor bash-completion-r1

DESCRIPTION="Command-line tool for one-click proxy without v2ray or others (A.k.a. go-craft)."
HOMEPAGE="https://github.com/mzz2017/gg"
LICENSE="AGPL-3"
SLOT="0"

EGIT_REPO_URI="${HOMEPAGE}.git"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3

	src_unpack() {
		git-r3_src_unpack
		go-module-vendor_live_vendor
	}
else
	KEYWORDS="~amd64 ~arm ~arm64"
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Universebenzene/ebuild-vendors/archive/refs/tags/${P}.tar.gz -> ${P}-vendor.tar.gz"
fi

DEPEND=""
RDEPEND="${DEPEND}
	!net-proxy/gg-bin
"

src_compile() {
	export CGO_CPPFLAGS="${CPPFLAGS}"
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CXXFLAGS="${CXXFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"
	export GOFLAGS="-buildmode=pie -trimpath -mod=readonly -modcacherw"
	ego build -mod vendor -v -x -ldflags="-X github.com/mzz2017/gg/cmd.Version=${PV} -linkmode=external" -o . ./...
}

src_test() {
	ego test ./...
}

src_install() {
	default
	dobin ${PN}
	dobashcomp completion/bash/${PN}
	for compdir in zsh/site-functions fish/vendor_completions.d; do
		insinto /usr/share/${compdir}
		doins completion/${compdir%/*}/*
	done
}

pkg_postinst() {
	elog
	elog "If you get any problems like \"operation not permitted\" while running with gg,"
	elog "try setting correct capabilites by the following command:"
	elog "# setcap cap_net_raw,cap_sys_ptrace+ep /usr/bin/gg"
	elog
}
