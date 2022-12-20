# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker qmake-utils desktop xdg

# bundled 5.15.8
QT5_MIN="5.15.5:5"
DESCRIPTION="Wemeet - Tencent Video Conferencing. A.k.a Tencent Meeting"
HOMEPAGE="https://meeting.tencent.com"
SRC_URI="https://updatecdn.meeting.qq.com/cos/249fc9a44733d846162296934bbf52fa/TencentMeeting_0300000000_${PV}_x86_64_default.publish.deb -> ${P}_x86_64.deb"

LICENSE="TencentMeetingDeclare"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="ibus wayland bundled-libs bundled-qt pipewire"
REQUIRED_USE="bundled-libs? ( bundled-qt )"

RDEPEND="dev-libs/nss
	dev-libs/wayland
	media-sound/pulseaudio
	x11-libs/libX11
	!bundled-libs? (
		app-crypt/p11-kit[asn1,libffi]
		dev-libs/glib:2
		dev-libs/libbsd
		dev-libs/libxslt[crypt]
		dev-libs/openssl:=
		|| ( media-libs/flac-compat:8.3.0 media-libs/flac:0/0 )
		media-libs/libglvnd
		media-libs/libjpeg-turbo
		media-libs/libvorbis
		media-libs/libpulse[X,asyncns]
		|| ( media-libs/tiff-compat:4 media-libs/tiff:0/0 )
		net-dns/avahi[dbus]
		net-print/cups[dbus,ssl]
		sys-apps/tcp-wrappers
		sys-libs/libapparmor
		sys-libs/libunwind
		sys-libs/zlib[minizip]
		virtual/krb5
		virtual/udev
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libxkbcommon
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
		>=dev-qt/qtnetwork-${QT5_MIN}[connman]
		>=dev-qt/qtnetworkauth-${QT5_MIN}
		>=dev-qt/qtopengl-${QT5_MIN}
		>=dev-qt/qtprintsupport-${QT5_MIN}[cups]
		>=dev-qt/qtquickcontrols2-${QT5_MIN}
		>=dev-qt/qtscript-${QT5_MIN}[scripttools]
		>=dev-qt/qtsql-${QT5_MIN}[sqlite]
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

src_install() {
	insinto /opt/${PN}
	doins -r opt/${PN}/{bin,${PN}.svg}
	newins "${FILESDIR}"/$(usex bundled-qt 'bundled-' '')${PN}$(usex pipewire '-pipewire' '')-3.8.0.2-app.sh ${PN}app.sh

	use bundled-qt && { use bundled-libs && { doins -r opt/${PN}/{icons,lib,plugins,resources,translations}; fperms +x \
		/opt/${PN}/bin/QtWebEngineProcess ; } || { fperms +x /opt/${PN}/bin/QtWebEngineProcess ; doins -r \
		opt/${PN}/{plugins,resources,translations} ; insinto /opt/${PN}/lib ; doins -r \
		opt/${PN}/lib/lib{ui*,wemeet*,xcast*,xnn*,desktop*,ImSDK.so,nxui*,icu*,Qt5*,qt_*,bugly*,crbase*} ; } ; } \
		|| { rm "${ED%/}"/opt/${PN}/bin/{QtWebEngineProcess,qt.conf} || die ; insinto /opt/${PN}/lib ; \
		doins -r opt/${PN}/lib/lib{ui*,wemeet*,xcast*,xnn*,desktop_common.so,ImSDK.so,nxui*,qt_*,bugly*,crbase*} ; }
	fperms +x /opt/${PN}/{${PN}app.sh,bin/${PN}app}
	dosym -r /opt/${PN}/${PN}app.sh /usr/bin/${PN}
	dosym {raw,/opt/${PN}/bin}/xcast.conf

	doicon -s scalable opt/${PN}/${PN}.svg
	for si in 16 32 64 128 256; do
		newicon -s ${si} opt/${PN}/icons/hicolor/${si}x${si}/mimetypes/${PN}app.png ${PN}.png
	done
	domenu usr/share/applications/${PN}app.desktop
}
