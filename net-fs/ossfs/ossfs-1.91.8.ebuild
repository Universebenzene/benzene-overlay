# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Export s3fs for aliyun oss"
HOMEPAGE="https://github.com/aliyun/ossfs
	https://help.aliyun.com/zh/oss/developer-reference/use-ossfs-to-mount-an-oss-bucket-to-the-local-directories-of-an-ecs-instance
"
SRC_URI="https://github.com/aliyun/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/libxml2-2.6:2
	>=net-misc/curl-7.0
	>=sys-fs/fuse-2.8.4:0
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}
