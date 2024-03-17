# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=(
	"github.com/aliyun/aliyun-oss-go-sdk v2.2.9"
	"github.com/alyu/configparser 744e9a66e7bcb83ea09084b979ddd1efc1f2f418"
	"github.com/droundy/goopt 48d6390ad4d19add7307a279e1bc89b689216321"
	"github.com/syndtr/goleveldb v1.0.0"
	"github.com/golang/snappy 2e65f85255dbc3072edf28d6b5b8efc472979f5a"
	"golang.org/x/time e5dcc9cfc0b9553953e355dde5bdf4ff9f82f742 github.com/golang/time"
	"golang.org/x/crypto 630584e8d5aaa1472863b49679b2d5548d80dcba github.com/golang/crypto"
	"golang.org/x/term 7de9c90e9dd184706b838f536a1cbf40a296ddb7 github.com/golang/term"
	"golang.org/x/sys 665e8c7367d1ecf644cea2d163019ef59c13d554 github.com/golang/sys"
)

EGO_PN="github.com/aliyun/${PN}"

if [[ ${PV} == *9999 ]]; then
	inherit golang-build golang-vcs
else
	inherit golang-build golang-vcs-snapshot

	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${EGO_VENDOR_URI}"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

DESCRIPTION="A user friendly command line tool to access AliCloud OSS."
HOMEPAGE="https://help.aliyun.com/zh/oss/developer-reference/ossutil-1
	https://github.com/aliyun/ossutil
"
LICENSE="MIT"
SLOT="0"

RDEPEND="${DEPEND}
	!net-misc/ossutil-bin
"

src_install() {
	dobin ${PN}
	dodoc src/${EGO_PN}/README*
}
