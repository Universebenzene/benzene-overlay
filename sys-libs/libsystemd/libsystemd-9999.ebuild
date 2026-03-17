# Copyright 2011-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..14} )

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
		KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
	fi
fi

inherit branding linux-info meson-multilib ninja-utils pam python-single-r1

inherit secureboot shell-completion toolchain-funcs #systemd udev usr-ldscript

DESCRIPTION="A standalone package to provide libsystemd.so without systemd"
HOMEPAGE="https://systemd.io/"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0/2"
IUSE="
	acl apparmor audit boot cryptsetup +curl +dns-over-tls elfutils
	fido2 +gcrypt gnutls homed +http idn +importd +kernel-install +kmod
	+lz4 +lzma +openssl pam passwdqc pcre pkcs11 policykit pwquality qrcode
	+resolvconf +seccomp selinux split-usr sysv-utils test tpm ukify vanilla xkb +zstd
"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	dns-over-tls? ( openssl )
	fido2? ( cryptsetup openssl )
	homed? ( cryptsetup pam openssl )
	importd? ( curl lzma openssl )
	?? ( passwdqc pwquality )
	passwdqc? ( homed )
	pwquality? ( homed )
	boot? ( kernel-install )
	ukify? ( boot )
"
RESTRICT="!test? ( test )"

MINKV="5.10"

COMMON_DEPEND="
	>=sys-apps/util-linux-2.37
	acl? ( sys-apps/acl )
	apparmor? ( >=sys-libs/libapparmor-2.13 )
	audit? ( >=sys-process/audit-2 )
	cryptsetup? ( >=sys-fs/cryptsetup-2.4.0:0= )
	curl? ( >=net-misc/curl-7.32.0:0= )
	elfutils? ( >=dev-libs/elfutils-0.177 )
	elibc_glibc? (
		>=sys-libs/glibc-2.34
		>=sys-libs/libxcrypt-4.4.0
	)
	elibc_musl? (
		>=sys-libs/musl-1.2.5-r8
		virtual/libcrypt
	)
	fido2? (
		dev-libs/libfido2
	)
	gcrypt? ( >=dev-libs/libgcrypt-1.4.5 )
	gnutls? ( >=net-libs/gnutls-3.6.0:0= )
	http? ( >=net-libs/libmicrohttpd-0.9.33:0=[epoll(+)] )
	idn? ( net-dns/libidn2 )
	importd? (
		app-arch/bzip2:0=
		virtual/zlib:=
	)
	kmod? ( >=sys-apps/kmod-15:0= )
	lz4? ( >=app-arch/lz4-0_p131:0= )
	lzma? ( >=app-arch/xz-utils-5.0.5-r1:0= )
	openssl? ( >=dev-libs/openssl-3.0.0:0= )
	pam? ( sys-libs/pam:=[${MULTILIB_USEDEP}] )
	passwdqc? ( sys-auth/passwdqc )
	pkcs11? ( >=app-crypt/p11-kit-0.23.3 )
	pcre? ( dev-libs/libpcre2 )
	pwquality? ( >=dev-libs/libpwquality-1.4.1 )
	qrcode? ( >=media-gfx/qrencode-3:0= )
	seccomp? ( >=sys-libs/libseccomp-2.4.0 )
	selinux? ( >=sys-libs/libselinux-2.1.9 )
	tpm? ( app-crypt/tpm2-tss )
	xkb? ( >=x11-libs/libxkbcommon-0.4.1 )
	zstd? ( >=app-arch/zstd-1.4.0:0= )
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

pkg_pretend() {
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
	)

	if ! use vanilla; then
		PATCHES+=(
			"${FILESDIR}/gentoo-journald-audit-r4.patch"
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
		-Dmode=release # default is developer, bug 918671
		-Dlibc=$(usex elibc_musl musl glibc)
		-Dsupport-url="${BRANDING_OS_SUPPORT_URL}"
		-Dpamlibdir="$(getpam_mod_dir)"
		-Dbashcompletiondir="$(get_bashcompdir)"
		-Dzshcompletiondir="$(get_zshcompdir)"
		# make sure we get /bin:/sbin in PATH
		$(meson_use split-usr split-bin)
		-Dima=true # no deps
		-Ddebug-shell="${EPREFIX}/bin/sh" # Match /etc/shells, bug 919749
		-Ddefault-user-shell="${EPREFIX}/bin/bash"
		-Dntp-servers="0.gentoo.pool.ntp.org 1.gentoo.pool.ntp.org 2.gentoo.pool.ntp.org 3.gentoo.pool.ntp.org"
		# Breaks screen, tmux, etc.
		-Ddefault-kill-user-processes=false
		-Dcreate-log-dirs=false
		-Dlibcrypt=enabled
		-Dcompat-mutable-uid-boundaries=true

		# options affecting multilib
		$(meson_use !elibc_musl nss-myhostname)
		$(meson_feature !elibc_musl nss-mymachines)
		$(meson_feature !elibc_musl nss-resolve)
		$(meson_use !elibc_musl nss-systemd)
		$(meson_feature pam)
	)

	# workaround for bug 969103
	if [[ ${CHOST} == riscv32* ]] ; then
		myconf+=( -Dtests=true )
	else
		myconf+=( $(meson_use test tests) )
	fi

	if multilib_is_native_abi; then
		myconf+=(
			--auto-features=enabled
			-Dman=enabled
			-Dxenctrl=disabled

			# Optional components/dependencies
			$(meson_feature acl)
			$(meson_feature apparmor)
			$(meson_feature audit)
			$(meson_feature boot bootloader)
			-Dbpf-framework=disabled
#			$(meson_feature cryptsetup libcryptsetup)
			-Dlibcryptsetup=enabled
			$(meson_feature curl libcurl)
			$(meson_use dns-over-tls dns-over-tls)
			$(meson_feature elfutils)
			$(meson_feature fido2 libfido2)
			$(meson_feature gcrypt)
			$(meson_feature gnutls)
			$(meson_feature http microhttpd)
			$(meson_feature homed)
			$(meson_use idn)
			$(meson_feature importd)
			$(meson_feature importd bzip2)
			$(meson_feature importd zlib)
			$(meson_use kernel-install)
			$(meson_feature kmod)
			$(meson_feature lz4)
			$(meson_feature lzma xz)
			$(meson_feature zstd)
			$(meson_feature openssl)
			$(meson_feature passwdqc)
			$(meson_feature pkcs11 p11kit)
			$(meson_feature pcre pcre2)
			$(meson_feature policykit polkit)
			$(meson_feature pwquality)
			$(meson_feature qrcode qrencode)
			$(meson_feature seccomp)
			$(meson_feature selinux)
			$(meson_feature tpm tpm2)
			$(meson_feature test dbus)
			$(meson_feature ukify)
			$(meson_feature xkb xkbcommon)
		)

		case $(tc-arch) in
			amd64|arm|arm64|loong|ppc|ppc64|riscv|s390|x86)
				# src/vmspawn/vmspawn-util.h: QEMU_MACHINE_TYPE
				myconf+=( $(meson_native_enabled vmspawn) ) ;;
			*)
				myconf+=( -Dvmspawn=disabled ) ;;
		esac
	else
		myconf+=(
			--auto-features=disabled
		)
	fi

	meson_src_configure "${myconf[@]}"
}

multilib_src_test() {
	local args=( --timeout-multiplier=10 )
	if ! multilib_is_native_abi; then
		args+=(
			--suite libsystemd --suite libudev
			$(usex elibc_musl '' '--suite nss')
			$(usex pam '--suite pam' '')
		)
	fi
	eninja test "${args[@]}"
}

multilib_src_compile() {
	local libsystemd=$(readlink libsystemd.so.0)
	local targets=(
		${libsystemd}
	)
	local args=()
	if ! multilib_is_native_abi; then
		args+=(
			devel libsystemd libudev
			$(usex elibc_musl '' nss)
			$(usev pam)
		)
	fi
	eninja "${targets[@]}" "${args[@]}"
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
