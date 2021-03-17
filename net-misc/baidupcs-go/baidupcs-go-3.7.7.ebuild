# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=(
	"github.com/qjfoidnh/Baidu-Login v1.4.0"
	"github.com/qjfoidnh/baidu-tools dfa5778abeede61f84ef0b927f8aea088b6e982e"
	"github.com/tidwall/gjson v1.6.4"
	"github.com/tidwall/match v1.0.1"
	"github.com/tidwall/pretty v1.0.2"
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

DEPEND=""
RDEPEND="${DEPEND}
	!net-misc/baidupcs-go-bin
"
BDEPEND=""

src_install() {
	newbin ${MY_PN} ${PN}
	dodoc src/${EGO_PN}/README*
}
