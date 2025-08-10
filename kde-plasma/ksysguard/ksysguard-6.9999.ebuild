# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
ECM_TEST="forceoptional"
KFMIN=6.0.0
#PVCUT=$(ver_cut 1-3)
QTMIN=6.0.0

inherit ecm kde.org

DESCRIPTION="Network-enabled resource usage monitor (ported for KDE 6)"
HOMEPAGE="https://apps.kde.org/ksysguard/ https://userbase.kde.org/KSysGuard"

#EGIT_REPO_URI="https://github.com/jovaska1337/ksysguard6.git"
#EGIT_BRANCH="fix-plugins"
EGIT_REPO_URI="https://github.com/zvova7890/ksysguard6.git"
# currently all changes are in kf6 instead of master!
EGIT_BRANCH="kf6"

if [[ "${KDE_BUILD_TYPE}" == release ]]; then
	SRC_URI="https://github.com/zvova7890/ksysguard6/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="GPL-2+"
SLOT="6"
IUSE="+lm-sensors"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets,xml]
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kitemviews-${KFMIN}:6
	>=kde-frameworks/knewstuff-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-plasma/libksysguard-${KFMIN}:6
	lm-sensors? ( sys-apps/lm-sensors:= )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package lm-sensors Sensors)
	)
	ecm_src_configure
}
