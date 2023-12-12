# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker qmake-utils desktop xdg

QT5_MIN="5.15.8:5"
DESCRIPTION="Wemeet - Tencent Video Conferencing. A.k.a Tencent Meeting"
HOMEPAGE="https://meeting.tencent.com"
SRC_URI="amd64? ( https://updatecdn.meeting.qq.com/cos/bb4001c715553579a8b3e496233331d4/TencentMeeting_0300000000_${PV}_x86_64_default.publish.deb -> ${P}_x86_64.deb )
	arm64? ( https://updatecdn.meeting.qq.com/cos/0f96a97b0aaea9b9d5d2c2b912ede656/TencentMeeting_0300000000_${PV}_arm64_default.publish.deb -> ${P}_arm64.deb )"

LICENSE="TencentMeetingDeclare"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE="ibus wayland bundled-libs bundled-qt pipewire"
REQUIRED_USE="bundled-libs? ( bundled-qt )"

RDEPEND="dev-libs/nss
	x11-libs/libX11
	!bundled-libs? (
		app-crypt/p11-kit[libffi]
		|| ( dev-libs/openssl-compat:1.1.1 <dev-libs/openssl-3 )
		dev-libs/libbsd
		dev-libs/libgcrypt:0
		dev-libs/libpcre:3
		dev-libs/libxml2
		dev-libs/openssl:=
		|| ( media-libs/flac-compat:8.3.0 media-libs/flac:0/0 )
		media-libs/libglvnd
		media-libs/libjpeg-turbo
		media-libs/libsndfile
		media-libs/libvorbis
		media-libs/libpulse[X,asyncns]
		media-libs/tiff-compat:4
		sys-apps/dbus
		sys-apps/tcp-wrappers
		sys-libs/libunwind
		sys-libs/zlib[minizip]
		virtual/udev
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libxkbcommon
		x11-libs/xcb-util
	)
	!bundled-qt? (
		dev-libs/icu
		>=dev-qt/designer-${QT5_MIN}
		>=dev-qt/qtcore-${QT5_MIN}
		>=dev-qt/qtconcurrent-${QT5_MIN}
		>=dev-qt/qtdbus-${QT5_MIN}
		>=dev-qt/qtdeclarative-${QT5_MIN}
		>=dev-qt/qthelp-${QT5_MIN}
		>=dev-qt/qtgui-${QT5_MIN}[X,eglfs,jpeg,ibus?,linuxfb,vnc,wayland?]
		>=dev-qt/qtlocation-${QT5_MIN}
		>=dev-qt/qtnetwork-${QT5_MIN}
		>=dev-qt/qtnetworkauth-${QT5_MIN}
		>=dev-qt/qtopengl-${QT5_MIN}
		>=dev-qt/qtprintsupport-${QT5_MIN}[cups]
		>=dev-qt/qtquickcontrols2-${QT5_MIN}
		>=dev-qt/qtscript-${QT5_MIN}[scripttools]
		>=dev-qt/qtsql-${QT5_MIN}
		>=dev-qt/qtscxml-${QT5_MIN}
		>=dev-qt/qtsvg-${QT5_MIN}
		>=dev-qt/qtspeech-${QT5_MIN}
		>=dev-qt/qtx11extras-${QT5_MIN}
		>=dev-qt/qtxml-${QT5_MIN}
		>=dev-qt/qtxmlpatterns-${QT5_MIN}
		>=dev-qt/qtwebchannel-${QT5_MIN}
		>=dev-qt/qtwebengine-${QT5_MIN}
		>=dev-qt/qtwebsockets-${QT5_MIN}
		>=dev-qt/qtwebview-${QT5_MIN}
		>=dev-qt/qtwidgets-${QT5_MIN}
	)
	pipewire? ( media-video/pipewire[sound-server] )
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="opt/${PN}/*"

src_prepare() {
	sed	-e '$i Comment=Tencent Meeting Linux Client\nComment[zh_CN]=腾讯会议Linux客户端\nKeywords=wemeet;tencent;meeting;' \
		-e "/Exec/c Exec=${PN} %u" -e "/Icon/c Icon=${PN}" -i usr/share/applications/${PN}app.desktop || die
	default
}

install_libs() {
	if use bundled-qt; then
		if use arm64; then
			doins -r opt/${PN}/lib/lib{ui*,wemeet*,xcast*,xnn*,desktop*,ImSDK.so,nxui*,icu*,Qt5*,qt_*,tms*,service*,Tencent*}
		else
			doins -r opt/${PN}/lib/lib{ui*,wemeet*,xcast*,xnn*,desktop*,ImSDK.so,nxui*,icu*,Qt5*,qt_*,tms*,service*,bugly*,crbase*,Tencent*}
		fi
	else
		if use arm64; then
			doins -r opt/${PN}/lib/lib{ui*,wemeet*,xcast*,xnn*,desktop*,ImSDK.so,nxui*,qt_*,tms*,service*,Tencent*}
		else
			doins -r opt/${PN}/lib/lib{ui*,wemeet*,xcast*,xnn*,desktop*,ImSDK.so,nxui*,qt_*,tms*,service*,bugly*,crbase*,Tencent*}
		fi
	fi
}

src_install() {
	insinto /opt/${PN}
	doins -r opt/${PN}/{bin,${PN}.svg}
	newins "${FILESDIR}"/$(usex bundled-qt 'bundled-' '')${PN}$(usex pipewire '-pipewire' '')-3.8.0.2-app.sh ${PN}app.sh

	use bundled-qt && { use bundled-libs && { doins -r opt/${PN}/{icons,lib,plugins,resources,translations}; fperms +x \
		/opt/${PN}/bin/QtWebEngineProcess ; } || { fperms +x /opt/${PN}/bin/QtWebEngineProcess ; doins -r \
		opt/${PN}/{plugins,resources,translations} ; insinto /opt/${PN}/lib ; install_libs ; } ; } \
		|| { rm "${ED%/}"/opt/${PN}/bin/{QtWebEngineProcess,qt.conf} || die ; insinto /opt/${PN}/lib ; install_libs ; }
	fperms +x /opt/${PN}/{${PN}app.sh,bin/${PN}app}
	dosym -r /opt/${PN}/${PN}app.sh /usr/bin/${PN}
	dosym {raw,/opt/${PN}/bin}/xcast.conf

	doicon -s scalable opt/${PN}/${PN}.svg
	for si in 16 32 64 128 256; do
		newicon -s ${si} opt/${PN}/icons/hicolor/${si}x${si}/mimetypes/${PN}app.png ${PN}.png
	done
	domenu usr/share/applications/${PN}app.desktop
}
