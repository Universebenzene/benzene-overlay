# Copyright 2011-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

# Avoid QA warnings
TMPFILES_OPTIONAL=1

QA_PKGCONFIG_VERSION=$(ver_cut 1)

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/systemd/systemd.git"
	inherit git-r3
else
	if [[ ${PV} == *.* ]]; then
		MY_PN=systemd-stable
	else
		MY_PN=systemd
	fi
	MY_PV=${PV/_/-}
	MY_P=${MY_PN}-${MY_PV}
	S=${WORKDIR}/${MY_P}
	SRC_URI="https://github.com/systemd/${MY_PN}/archive/v${MY_PV}/${MY_P}.tar.gz"
	KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~mips ppc ppc64 ~riscv ~s390 sparc x86"
fi

inherit bash-completion-r1 flag-o-matic linux-info meson-multilib ninja-utils pam python-any-r1 toolchain-funcs #systemd udev usr-ldscript

DESCRIPTION="A standalone package to provide libsystemd.so without systemd"
HOMEPAGE="http://systemd.io/"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0/2"
IUSE="
	acl apparmor audit build cgroup-hybrid cryptsetup curl +dns-over-tls elfutils
	fido2 +gcrypt gnuefi gnutls homed http idn importd iptables +kmod
	+lz4 lzma +openssl pam pcre pkcs11 policykit pwquality qrcode
	+resolvconf +seccomp selinux split-usr +sysv-utils test tpm vanilla xkb +zstd
"

REQUIRED_USE="
	dns-over-tls? ( || ( gnutls openssl ) )
	homed? ( cryptsetup pam openssl )
	importd? ( curl lzma || ( gcrypt openssl ) )
	pwquality? ( homed )
"
RESTRICT="!test? ( test )"

MINKV="3.11"

COMMON_DEPEND="
	>=sys-apps/util-linux-2.30:0=[${MULTILIB_USEDEP}]
	sys-libs/libcap:0=[${MULTILIB_USEDEP}]
	virtual/libcrypt:=[${MULTILIB_USEDEP}]
	acl? ( sys-apps/acl:0= )
	apparmor? ( sys-libs/libapparmor:0= )
	audit? ( >=sys-process/audit-2:0= )
	cryptsetup? ( >=sys-fs/cryptsetup-2.0.1:0= )
	curl? ( net-misc/curl:0= )
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
	pkcs11? ( app-crypt/p11-kit:0= )
	pcre? ( dev-libs/libpcre2 )
	pwquality? ( dev-libs/libpwquality:0= )
	qrcode? ( media-gfx/qrencode:0= )
	seccomp? ( >=sys-libs/libseccomp-2.3.3:0= )
	selinux? ( sys-libs/libselinux:0= )
	tpm? ( app-crypt/tpm2-tss:0= )
	xkb? ( >=x11-libs/libxkbcommon-0.4.1:0= )
	zstd? ( >=app-arch/zstd-1.4.0:0=[${MULTILIB_USEDEP}] )
"

# Newer linux-headers needed by ia64, bug #480218
DEPEND="${COMMON_DEPEND}
	>=sys-kernel/linux-headers-${MINKV}
	gnuefi? ( >=sys-boot/gnu-efi-3.0.2 )
"

# baselayout-2.2 has /run
RDEPEND="${COMMON_DEPEND}
	!sys-apps/systemd
"

BDEPEND="
	app-arch/xz-utils:0
	dev-util/gperf
	>=dev-util/meson-0.46
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
	$(python_gen_any_dep 'dev-python/jinja[${PYTHON_USEDEP}]')
	$(python_gen_any_dep 'dev-python/lxml[${PYTHON_USEDEP}]')
"

python_check_deps() {
	has_version -b "dev-python/jinja[${PYTHON_USEDEP}]" &&
	has_version -b "dev-python/lxml[${PYTHON_USEDEP}]"
}

QA_FLAGS_IGNORED="usr/lib/systemd/boot/efi/.*"
QA_EXECSTACK="usr/lib/systemd/boot/efi/*"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != buildonly ]]; then
		if use test && has pid-sandbox ${FEATURES}; then
			ewarn "Tests are known to fail with PID sandboxing enabled."
			ewarn "See https://bugs.gentoo.org/674458."
		fi

		local CONFIG_CHECK=" ~BINFMT_MISC ~BLK_DEV_BSG ~CGROUPS
			~DEVTMPFS ~EPOLL ~FANOTIFY ~FHANDLE
			~INOTIFY_USER ~IPV6 ~NET ~NET_NS ~PROC_FS ~SIGNALFD ~SYSFS
			~TIMERFD ~TMPFS_XATTR ~UNIX ~USER_NS
			~CRYPTO_HMAC ~CRYPTO_SHA256 ~CRYPTO_USER_API_HASH
			~!GRKERNSEC_PROC ~!IDE ~!SYSFS_DEPRECATED
			~!SYSFS_DEPRECATED_V2"

		use acl && CONFIG_CHECK+=" ~TMPFS_POSIX_ACL"
		use seccomp && CONFIG_CHECK+=" ~SECCOMP ~SECCOMP_FILTER"
		kernel_is -lt 3 7 && CONFIG_CHECK+=" ~HOTPLUG"
		kernel_is -lt 4 7 && CONFIG_CHECK+=" ~DEVPTS_MULTIPLE_INSTANCES"
		kernel_is -ge 4 10 && CONFIG_CHECK+=" ~CGROUP_BPF"

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
	:
}

src_unpack() {
	default
	[[ ${PV} != 9999 ]] || git-r3_src_unpack
}

src_prepare() {
	# Do NOT add patches here
	local PATCHES=()

	[[ -d "${WORKDIR}"/patches ]] && PATCHES+=( "${WORKDIR}"/patches )

	# Add local patches here
	PATCHES+=(
	)

	if ! use vanilla; then
		PATCHES+=(
			"${FILESDIR}/gentoo-generator-path-r2.patch"
			"${FILESDIR}/gentoo-systemctl-disable-sysv-sync-r1.patch"
			"${FILESDIR}/gentoo-journald-audit.patch"
		)
	fi

	default
}

src_configure() {
	# Prevent conflicts with i686 cross toolchain, bug 559726
	tc-export AR CC NM OBJCOPY RANLIB

	# Broken with FORTIFY_SOURCE=3 without a patch. And the patch
	# wasn't backported to 250.x, but it turns out to break Clang
	# anyway:  bug #841770.
	#
	# Our toolchain sets F_S=2 by default w/ >= -O2, so we need
	# to unset F_S first, then explicitly set 2, to negate any default
	# and anything set by the user if they're choosing 3 (or if they've
	# modified GCC to set 3).
	#
	if is-flagq '-O[23]' || is-flagq '-Ofast' ; then
		# We can't unconditionally do this b/c we fortify needs
		# some level of optimisation.
		filter-flags -D_FORTIFY_SOURCE=3
		append-cppflags -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
	fi

	python_setup

	multilib-minimal_src_configure
}

multilib_src_configure() {
	local myconf=(
		--localstatedir="${EPREFIX}/var"
		-Dsupport-url="https://gentoo.org/support/"
		-Dpamlibdir="$(getpam_mod_dir)"
		# avoid bash-completion dep
		-Dbashcompletiondir="$(get_bashcompdir)"
		# make sure we get /bin:/sbin in PATH
		$(meson_use split-usr)
		-Dsplit-bin=true
		-Drootprefix="$(usex split-usr "${EPREFIX:-/}" "${EPREFIX}/usr")"
		-Drootlibdir="${EPREFIX}/usr/$(get_libdir)"
		# Avoid infinite exec recursion, bug 642724
		-Dtelinit-path="${EPREFIX}/lib/sysvinit/telinit"
		# no deps
		-Dima=true
		-Ddefault-hierarchy=$(usex cgroup-hybrid hybrid unified)
		# Optional components/dependencies
		$(meson_native_use_bool acl)
		$(meson_native_use_bool apparmor)
		$(meson_native_use_bool audit)
		$(meson_native_use_bool cryptsetup libcryptsetup)
		$(meson_native_use_bool curl libcurl)
		$(meson_native_use_bool dns-over-tls dns-over-tls)
		$(meson_native_use_bool elfutils)
		$(meson_native_use_bool fido2 libfido2)
		$(meson_use gcrypt)
		$(meson_native_use_bool gnuefi gnu-efi)
		$(meson_native_use_bool gnutls)
		-Defi-includedir="${ESYSROOT}/usr/include/efi"
		-Defi-libdir="${ESYSROOT}/usr/$(get_libdir)"
		$(meson_native_use_bool homed)
		$(meson_native_use_bool http microhttpd)
		$(meson_native_use_bool idn)
		$(meson_native_use_bool importd)
		$(meson_native_use_bool importd bzip2)
		$(meson_native_use_bool importd zlib)
		$(meson_native_use_bool kmod)
		$(meson_use lz4)
		$(meson_use lzma xz)
		$(meson_use zstd)
		$(meson_native_use_bool iptables libiptc)
		$(meson_native_use_bool openssl)
		$(meson_use pam)
		$(meson_native_use_bool pkcs11 p11kit)
		$(meson_native_use_bool pcre pcre2)
		$(meson_native_use_bool policykit polkit)
		$(meson_native_use_bool pwquality)
		$(meson_native_use_bool qrcode qrencode)
		$(meson_native_use_bool seccomp)
		$(meson_native_use_bool selinux)
		$(meson_native_use_bool tpm tpm2)
		$(meson_native_use_bool test dbus)
		$(meson_native_use_bool xkb xkbcommon)
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
		$(meson_native_true man)
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

	use split-usr && dosym -r /$(get_libdir)/libsystemd.so.0 /usr/$(get_libdir)/libsystemd.so
}
