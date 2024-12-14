# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=(
	"github.com/GeertJohan/go.incremental v1.0.0"
	"github.com/GeertJohan/go.rice v1.0.2"
	"github.com/daaku/go.zipexe v1.0.2"
	"github.com/fatih/color v1.10.0"
	"github.com/golang/protobuf v1.4.3"
	"google.golang.org/protobuf v1.23.0 github.com/protocolbuffers/protobuf-go"
	"github.com/json-iterator/go v1.1.10"
	"github.com/modern-go/concurrent bacd9c7ef1dd9b15be4a9909b8ac7a4e313eec94"
	"github.com/modern-go/reflect2 v1.0.1"
	"github.com/kardianos/osext 2bc1f35cddc0cc527b4bc3dce8578fc2a6c11384"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/oleiade/lane v1.0.1"
	"github.com/olekukonko/tablewriter v0.0.4"
	"github.com/peterh/liner v1.2.1"
	"github.com/qjfoidnh/Baidu-Login v1.4.1"
	"github.com/astaxie/beego v1.12.3"
	"github.com/qjfoidnh/baidu-tools v1.2.0"
	"github.com/bitly/go-simplejson v0.5.0"
	"github.com/tidwall/gjson v1.6.4"
	"github.com/tidwall/match v1.0.1"
	"github.com/tidwall/pretty v1.0.2"
	"github.com/urfave/cli v1.22.5"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0 github.com/cpuguy83/go-md2man"
)

MY_PN="BaiduPCS-Go"
EGO_PN="github.com/qjfoidnh/${MY_PN}"

if [[ ${PV} == *9999 ]]; then
	inherit golang-build golang-vcs
else
	inherit golang-build golang-vcs-snapshot

	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${EGO_VENDOR_URI}"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

DESCRIPTION="The terminal utility for Baidu Network Disk (Golang Version)."
HOMEPAGE="https://github.com/qjfoidnh/BaiduPCS-Go"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="${DEPEND}
	!net-misc/baidupcs-go-bin
"

EGO_BUILD_FLAGS="-ldflags=-s"

src_prepare() {
	pushd src/${EGO_PN} || die
	eapply "${FILESDIR}/${P}-fix-go-1.23.patch"
	popd || die
	default
}

src_install() {
	newbin ${MY_PN} ${PN}
	dodoc src/${EGO_PN}/README*
}
