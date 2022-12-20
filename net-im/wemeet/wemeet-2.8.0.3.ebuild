# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker qmake-utils desktop xdg

DESCRIPTION="Wemeet - Tencent Video Conferencing. A.k.a Tencent Meeting"
HOMEPAGE="https://meeting.tencent.com"
SRC_URI="amd64? ( https://updatecdn.meeting.qq.com/cos/3cdd365cd90f221fb345ab73c4746e1f/TencentMeeting_0300000000_${PV}_x86_64_default.publish.deb -> ${P}_x86_64.deb )
	arm64? ( https://updatecdn.meeting.qq.com/cos/1584cf78c2285b450a4bc9d0b3bb8720/TencentMeeting_0300000000_${PV}_arm64_default.publish.deb -> ${P}_arm64.deb )"

LICENSE="TencentMeetingDeclare"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE="ibus wayland bundled-libs"

RDEPEND="dev-libs/nss
	dev-libs/wayland
	media-sound/pulseaudio
	x11-libs/libX11
	!bundled-libs? (
		app-crypt/p11-kit[asn1,libffi]
		dev-lang/orc
		dev-libs/boost[icu]
		dev-libs/capnproto
		dev-libs/glib:2
		dev-libs/libbsd
		dev-libs/libxslt[crypt]
		dev-libs/openssl:=
		dev-libs/protobuf
		media-libs/alsa-lib
		media-libs/libglvnd
		media-libs/libjpeg-turbo
		media-libs/libpng
		media-plugins/gst-plugins-meta:1.0[flac,vorbis]
		|| ( media-libs/libpulse[X,asyncns] media-sound/pulseaudio[X,asyncns,orc,ssl,tcpd,udev,zeroconf] )
		|| ( media-libs/tiff-compat:4 media-libs/tiff:0/0 )
		net-dns/avahi[dbus]
		net-libs/libproxy
		net-print/cups[dbus,ssl]
		sys-apps/tcp-wrappers
		sys-libs/libapparmor
		sys-libs/zlib
		virtual/krb5
		virtual/udev
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libxkbcommon
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtdeclarative:5
		dev-qt/qtgui:5[X,eglfs,jpeg,ibus?,linuxfb,wayland?]
		dev-qt/qtnetwork:5[connman]
		dev-qt/qtopengl:5
		dev-qt/qtprintsupport:5[cups]
		dev-qt/qtsql:5[sqlite]
		dev-qt/qtsvg:5
		dev-qt/qtx11extras:5
		dev-qt/qtwebkit:5
		dev-qt/qtwidgets:5
	)
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="opt/${PN}/*"

src_prepare() {
	sed	-e '$i Comment=Tencent Meeting Linux Client\nComment[zh_CN]=腾讯会议Linux客户端\nKeywords=wemeet;tencent;meeting;' \
		-e "/Exec/c Exec=${PN} %u" -e "/Icon/c Icon=${PN}" -i usr/share/applications/${PN}app.desktop || die
	use bundled-libs || { sed "/QT_PLUGIN/c export QT_PLUGIN_PATH=\"$(qt5_get_plugindir)\"" -i opt/${PN}/${PN}app.sh || die ; \
		sed "/^Prefix/c Prefix = $(qt5_get_libdir)/qt5" -i opt/${PN}/bin/qt.conf || die ; }
	sed '/QT_PLUGIN/a export QT_AUTO_SCREEN_SCALE_FACTOR=1\nexport QT_STYLE_OVERRIDE=fusion' -i opt/${PN}/${PN}app.sh || die
	use wayland && { sed '/QT_PLUGIN/a export XDG_SESSION_TYPE=x11\nexport QT_QPA_PLATFORM=xcb\nunset WAYLAND_DISPLAY' \
		-i opt/${PN}/${PN}app.sh || die ; }
	default
}

src_install() {
	insinto /opt/${PN}
	doins -r opt/${PN}/{bin,${PN}.svg,${PN}app.sh}

	use bundled-libs && doins -r opt/${PN}/{icons,lib,plugins} || { insinto /opt/${PN}/lib ; \
		doins -r opt/${PN}/lib/{libtquic.so,libwemeet*,libxcast.so,libxnn*} ; }
	fperms +x /opt/${PN}/{${PN}app.sh,bin/{crashpad_handler,${PN}app}}
	dosym -r /opt/${PN}/${PN}app.sh /usr/bin/${PN}
	dosym {raw,/opt/${PN}/bin}/xcast.conf

	doicon -s scalable opt/${PN}/${PN}.svg
	for si in 16 32 64 128 256; do
		newicon -s ${si} opt/${PN}/icons/hicolor/${si}x${si}/mimetypes/${PN}app.png ${PN}.png
	done
	domenu usr/share/applications/${PN}app.desktop
}
