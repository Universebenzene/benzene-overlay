# Copyright 2011-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )

# Avoid QA warnings
TMPFILES_OPTIONAL=1

QA_PKGCONFIG_VERSION=$(ver_cut 1)

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/systemd/systemd.git"
	inherit git-r3
else
	MY_PV=${PV/_/-}
	MY_P=systemd-${MY_PV}
	S=${WORKDIR}/${MY_P}
	SRC_URI="https://github.com/systemd/systemd/archive/refs/tags/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

	if [[ ${PV} != *rc* ]] ; then
		KEYWORDS="~alpha ~amd64 ~arm arm64 ~hppa ~loong ~m68k ~mips ~ppc ppc64 ~riscv ~s390 ~sparc ~x86"
	fi
fi

inherit bash-completion-r1 linux-info meson-multilib ninja-utils pam python-single-r1

inherit secureboot toolchain-funcs #systemd udev usr-ldscript

DESCRIPTION="A standalone package to provide libsystemd.so without systemd"
HOMEPAGE="https://systemd.io/"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0/2"
IUSE="
	acl apparmor audit boot cgroup-hybrid cryptsetup curl +dns-over-tls elfutils
	fido2 +gcrypt gnutls homed http idn importd iptables +kernel-install +kmod
	+lz4 lzma +openssl pam pcre pkcs11 policykit pwquality qrcode
	+resolvconf +seccomp selinux split-usr +sysv-utils test tpm ukify vanilla xkb +zstd
"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	dns-over-tls? ( || ( gnutls openssl ) )
	fido2? ( cryptsetup openssl )
	homed? ( cryptsetup pam openssl )
	importd? ( curl lzma || ( gcrypt openssl ) )
	pwquality? ( homed )
	boot? ( kernel-install )
	ukify? ( boot )
"
RESTRICT="!test? ( test )"

MINKV="4.15"

COMMON_DEPEND="
	>=sys-apps/util-linux-2.32:0=[${MULTILIB_USEDEP}]
	sys-libs/libcap:0=[${MULTILIB_USEDEP}]
	virtual/libcrypt:=[${MULTILIB_USEDEP}]
	acl? ( sys-apps/acl:0= )
	apparmor? ( >=sys-libs/libapparmor-2.13:0= )
	audit? ( >=sys-process/audit-2:0= )
	cryptsetup? ( >=sys-fs/cryptsetup-2.0.1:0= )
	curl? ( >=net-misc/curl-7.32.0:0= )
	elfutils? ( >=dev-libs/elfutils-0.158:0= )
	fido2? ( dev-libs/libfido2:0= )
	gcrypt? ( >=dev-libs/libgcrypt-1.4.5:0=[${MULTILIB_USEDEP}] )
	gnutls? ( >=net-libs/gnutls-3.6.0:0= )
	http? ( >=net-libs/libmicrohttpd-0.9.33:0=[epoll(+)] )
	idn? ( net-dns/libidn2:= )
	importd? (
		app-arch/bzip2:0=
		sys-libs/zlib:0=
	)
	kmod? ( >=sys-apps/kmod-15:0= )
	lz4? ( >=app-arch/lz4-0_p131:0=[${MULTILIB_USEDEP}] )
	lzma? ( >=app-arch/xz-utils-5.0.5-r1:0=[${MULTILIB_USEDEP}] )
	iptables? ( net-firewall/iptables:0= )
	openssl? ( >=dev-libs/openssl-1.1.0:0= )
	pam? ( sys-libs/pam:=[${MULTILIB_USEDEP}] )
	pkcs11? ( >=app-crypt/p11-kit-0.23.3:0= )
	pcre? ( dev-libs/libpcre2 )
	pwquality? ( >=dev-libs/libpwquality-1.4.1:0= )
	qrcode? ( >=media-gfx/qrencode-3:0= )
	seccomp? ( >=sys-libs/libseccomp-2.3.3:0= )
	selinux? ( >=sys-libs/libselinux-2.1.9:0= )
	tpm? ( app-crypt/tpm2-tss:0= )
	xkb? ( >=x11-libs/libxkbcommon-0.4.1:0= )
	zstd? ( >=app-arch/zstd-1.4.0:0=[${MULTILIB_USEDEP}] )
"

# Newer linux-headers needed by ia64, bug #480218
DEPEND="${COMMON_DEPEND}
	>=sys-kernel/linux-headers-${MINKV}
"

PEFILE_DEPEND='dev-python/pefile[${PYTHON_USEDEP}]'

# baselayout-2.2 has /run
RDEPEND="${COMMON_DEPEND}
	ukify? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep "${PEFILE_DEPEND}")
	)
	!sys-apps/systemd
"

BDEPEND="
	app-arch/xz-utils:0
	dev-util/gperf
	>=dev-build/meson-0.46
	>=sys-apps/coreutils-8.16
	sys-devel/gettext
	virtual/pkgconfig
	test? (
		app-text/tree
		dev-lang/perl
		sys-apps/dbus
	)
	app-text/docbook-xml-dtd:4.2
	app-text/docbook-xml-dtd:4.5
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt:0
	${PYTHON_DEPS}
	$(python_gen_cond_dep "
		dev-python/jinja2[\${PYTHON_USEDEP}]
		dev-python/lxml[\${PYTHON_USEDEP}]
		boot? (
			>=dev-python/pyelftools-0.30[\${PYTHON_USEDEP}]
			test? ( ${PEFILE_DEPEND} )
		)
	")
"

QA_FLAGS_IGNORED="usr/lib/systemd/boot/efi/.*"
QA_EXECSTACK="usr/lib/systemd/boot/efi/*"

check_cgroup_layout() {
	# https://bugs.gentoo.org/935261
	[[ ${MERGE_TYPE} != buildonly ]] || return
	[[ -z ${ROOT} ]] || return
	[[ -e /sys/fs/cgroup/unified ]] || return
	grep -q 'SYSTEMD_CGROUP_ENABLE_LEGACY_FORCE=1' /proc/cmdline && return

	eerror "This system appears to be booted with the 'hybrid' cgroup layout."
	eerror "This layout obsolete and is disabled in systemd."

	if grep -qF 'systemd.unified_cgroup_hierarchy'; then
		eerror "Remove the systemd.unified_cgroup_hierarchy option"
		eerror "from the kernel command line and reboot."
		die "hybrid cgroup layout detected"
	fi
}

pkg_pretend() {
	check_cgroup_layout

	if use cgroup-hybrid; then
		eerror "Disable the 'cgroup-hybrid' USE flag."
		eerror "Rebuild any initramfs images after rebuilding systemd."
		die "cgroup-hybrid is no longer supported"
	fi

	if [[ ${MERGE_TYPE} != buildonly ]]; then
		local CONFIG_CHECK="~BLK_DEV_BSG ~CGROUPS
			~CGROUP_BPF ~DEVTMPFS ~EPOLL ~FANOTIFY ~FHANDLE
			~INOTIFY_USER ~IPV6 ~NET ~NET_NS ~PROC_FS ~SIGNALFD ~SYSFS
			~TIMERFD ~TMPFS_XATTR ~UNIX ~USER_NS
			~CRYPTO_HMAC ~CRYPTO_SHA256 ~CRYPTO_USER_API_HASH
			~!GRKERNSEC_PROC ~!IDE ~!SYSFS_DEPRECATED
			~!SYSFS_DEPRECATED_V2"

		use acl && CONFIG_CHECK+=" ~TMPFS_POSIX_ACL"
		use seccomp && CONFIG_CHECK+=" ~SECCOMP ~SECCOMP_FILTER"

		if kernel_is -ge 5 10 20; then
			CONFIG_CHECK+=" ~KCMP"
		else
			CONFIG_CHECK+=" ~CHECKPOINT_RESTORE"
		fi

		if kernel_is -ge 4 18; then
			CONFIG_CHECK+=" ~AUTOFS_FS"
		else
			CONFIG_CHECK+=" ~AUTOFS4_FS"
		fi

		if linux_config_exists; then
			local uevent_helper_path=$(linux_chkconfig_string UEVENT_HELPER_PATH)
			if [[ -n ${uevent_helper_path} ]] && [[ ${uevent_helper_path} != '""' ]]; then
				ewarn "It's recommended to set an empty value to the following kernel config option:"
				ewarn "CONFIG_UEVENT_HELPER_PATH=${uevent_helper_path}"
			fi
			if linux_chkconfig_present X86; then
				CONFIG_CHECK+=" ~DMIID"
			fi
		fi

		if kernel_is -lt ${MINKV//./ }; then
			ewarn "Kernel version at least ${MINKV} required"
		fi

		check_extra_config
	fi
}

pkg_setup() {
	use boot && secureboot_pkg_setup
}

src_unpack() {
	default
	[[ ${PV} != 9999 ]] || git-r3_src_unpack
}

src_prepare() {
	local PATCHES=(
		"${FILESDIR}/systemd-test-process-util.patch"
	)

	if ! use vanilla; then
		PATCHES+=(
			"${FILESDIR}/gentoo-journald-audit-r1.patch"
		)
	fi

	# Fails with split-usr.
	sed -i -e '2i exit 77' test/test-rpm-macros.sh || die

	default
}

src_configure() {
	# Prevent conflicts with i686 cross toolchain, bug 559726
	tc-export AR CC NM OBJCOPY RANLIB

	python_setup

	multilib-minimal_src_configure
}

multilib_src_configure() {
	local myconf=(
		--localstatedir="${EPREFIX}/var"
		# default is developer, bug 918671
		-Dmode=release
		-Dsupport-url="https://gentoo.org/support/"
		-Dpamlibdir="$(getpam_mod_dir)"
		# avoid bash-completion dep
		-Dbashcompletiondir="$(get_bashcompdir)"
		# make sure we get /bin:/sbin in PATH
		$(meson_use split-usr)
		$(meson_use split-usr split-bin)
		-Drootprefix="$(usex split-usr "${EPREFIX:-/}" "${EPREFIX}/usr")"
		-Drootlibdir="${EPREFIX}/usr/$(get_libdir)"
		# Disable compatibility with sysvinit
		-Dsysvinit-path=
		-Dsysvrcnd-path=
		# no deps
		-Dima=true
		# Match /etc/shells, bug 919749
		-Ddebug-shell="${EPREFIX}/bin/sh"
		-Ddefault-user-shell="${EPREFIX}/bin/bash"
		# Optional components/dependencies
		$(meson_native_use_feature acl)
		$(meson_native_use_feature apparmor)
		$(meson_native_use_feature audit)
		$(meson_native_use_feature boot bootloader)
		$(meson_native_use_feature cryptsetup libcryptsetup)
		$(meson_native_use_feature curl libcurl)
		$(meson_native_use_bool dns-over-tls dns-over-tls)
		$(meson_native_use_feature elfutils)
		$(meson_native_use_feature fido2 libfido2)
		$(meson_feature gcrypt)
		$(meson_native_use_feature gnutls)
		$(meson_native_use_feature homed)
		$(meson_native_use_feature http microhttpd)
		$(meson_native_use_bool idn)
		$(meson_native_use_feature importd)
		$(meson_native_use_feature importd bzip2)
		$(meson_native_use_feature importd zlib)
		$(meson_native_use_bool kernel-install)
		$(meson_native_use_feature kmod)
		$(meson_feature lz4)
		$(meson_feature lzma xz)
		$(meson_use test tests)
		$(meson_feature zstd)
		$(meson_native_use_feature iptables libiptc)
		$(meson_native_use_feature openssl)
		$(meson_feature pam)
		$(meson_native_use_feature pkcs11 p11kit)
		$(meson_native_use_feature pcre pcre2)
		$(meson_native_use_feature policykit polkit)
		$(meson_native_use_feature pwquality)
		$(meson_native_use_feature qrcode qrencode)
		$(meson_native_use_feature seccomp)
		$(meson_native_use_feature selinux)
		$(meson_native_use_feature tpm tpm2)
		$(meson_native_use_feature test dbus)
		$(meson_native_use_feature ukify)
		$(meson_native_use_feature xkb xkbcommon)
		-Dntp-servers="0.gentoo.pool.ntp.org 1.gentoo.pool.ntp.org 2.gentoo.pool.ntp.org 3.gentoo.pool.ntp.org"
		# Breaks screen, tmux, etc.
		-Ddefault-kill-user-processes=false
		-Dcreate-log-dirs=false

		# multilib options
		$(meson_native_true backlight)
		$(meson_native_true binfmt)
		$(meson_native_true coredump)
		$(meson_native_true environment-d)
		$(meson_native_true firstboot)
		$(meson_native_true hibernate)
		$(meson_native_true hostnamed)
		$(meson_native_true ldconfig)
		$(meson_native_true localed)
		$(meson_native_enabled man)
		$(meson_native_true networkd)
		$(meson_native_true quotacheck)
		$(meson_native_true randomseed)
		$(meson_native_true rfkill)
		$(meson_native_true sysusers)
		$(meson_native_true timedated)
		$(meson_native_true timesyncd)
		$(meson_native_true tmpfiles)
		$(meson_native_true vconsole)
	)

	case $(tc-arch) in
		amd64|arm|arm64|ppc|ppc64|s390|x86)
			# src/vmspawn/vmspawn-util.h: QEMU_MACHINE_TYPE
			myconf+=( $(meson_native_enabled vmspawn) ) ;;
		*)
			myconf+=( -Dvmspawn=disabled ) ;;
	esac

	meson_src_configure "${myconf[@]}"
}

multilib_src_test() {
	eninja test
}

multilib_src_compile() {
	local libsystemd=$(readlink libsystemd.so.0)
	local targets=(
		${libsystemd}
	)
	eninja "${targets[@]}"
}

multilib_src_install() {
	use split-usr && into /
	dolib.so libsystemd.so{,*.0}

	use split-usr && dosym ../../$(get_libdir)/libsystemd.so.0 /usr/$(get_libdir)/libsystemd.so
}

pkg_preinst() {
	if ! use boot && has_version "sys-libs/libsystemd[gnuefi(-)]"; then
		ewarn "The 'gnuefi' USE flag has been renamed to 'boot'."
		ewarn "Make sure to enable the 'boot' USE flag if you use systemd-boot."
	fi
}
