# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python's filesystem abstraction layer"
HOMEPAGE="https://pyfilesystem2.readthedocs.io
	https://www.pyfilesystem.org
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/appdirs-1.4.3[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/six-1.10[${PYTHON_USEDEP}]
"

BDEPEND="test? (
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/pyftpdlib[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${P}-py312-test-fix.patch"
	"${FILESDIR}/${P}-fix-pyftpdlib-compatibility.patch"
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-rtd-theme dev-python/recommonmark

EPYTEST_DESELECT=(
	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-fs/-/blob/main/PKGBUILD
	# TestFTPFS needs to be updated to use the asyncio module
	tests/test_ftpfs.py::TestFTPFS
	# Not compatible with pyftpdlib 2.0+, see:
	# https://github.com/PyFilesystem/pyfilesystem2/pull/595
	tests/test_ftpfs.py::TestAnonFTPFS
	# Fails with Python 3.14, see:
	# https://github.com/PyFilesystem/pyfilesystem2/issues/596
	tests/test_osfs.py::TestOSFS::test_complex_geturl
	tests/test_subfs.py::TestOSFS::test_complex_geturl
	tests/test_subfs.py::TestSubFS::test_complex_geturl
	tests/test_tarfs.py::TestReadTarFS::test_geturl_for_fs
	tests/test_tarfs.py::TestReadTarFSMem::test_geturl_for_fs
	tests/test_tempfs.py::TestOSFS::test_complex_geturl
	tests/test_tempfs.py::TestTempFS::test_complex_geturl
	tests/test_zipfs.py::TestReadZipFS::test_geturl_for_fs
	tests/test_zipfs.py::TestReadZipFSMem::test_geturl_for_fs
)

python_prepare_all() {
	use doc && { mkdir -p docs/source/_static || die ; }

	distutils-r1_python_prepare_all
}
