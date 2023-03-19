# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="An implementation of chunked, compressed, N-dimensional arrays for Python"
HOMEPAGE="http://zarr.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"	# copybutton myst-nb no x86
IUSE="examples jupyter"
RESTRICT="test"	# Test phase runs with fails

RDEPEND="dev-python/asciitree[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.7[${PYTHON_USEDEP}]
	dev-python/fasteners[${PYTHON_USEDEP}]
	>=dev-python/numcodecs-0.10.0[${PYTHON_USEDEP}]
"
BDEPEND=">dev-python/setuptools-scm-1.5.4[${PYTHON_USEDEP}]
	jupyter? ( dev-python/notebook[${PYTHON_USEDEP}] )
	test? (
		dev-python/bsddb3[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/lmdb[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/numpydoc \
	dev-python/sphinx-copybutton \
	dev-python/sphinx-issues \
	dev-python/sphinx-rtd-theme

# Reported upsream
# https://github.com/zarr-developers/zarr-python/issues/961
EPYTEST_DESELECT=(
	zarr/tests/test_core.py::TestArray::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithPath::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithChunkStore::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithDirectoryStore::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithNestedDirectoryStore::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithDBMStore::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithDBMStoreBerkeleyDB::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithLMDBStore::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithLMDBStoreNoBuffers::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithSQLiteStore::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithNoCompressor::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithBZ2Compressor::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithBloscCompressor::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithLZMACompressor::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithCustomMapping::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithPathV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithChunkStoreV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithDirectoryStoreV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithDBMStoreV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithDBMStoreV3BerkeleyDB::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithLMDBStoreV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithLMDBStoreV3NoBuffers::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithSQLiteStoreV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithCustomMappingV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayNoCache::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayNoCacheV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithStoreCache::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithStoreCacheV3::test_object_arrays_vlen_bytes
	zarr/tests/test_sync.py::TestArray::test_object_arrays_vlen_bytes
	zarr/tests/test_sync.py::TestArrayWithThreadSynchronizer::test_object_arrays_vlen_bytes
	zarr/tests/test_sync.py::TestArrayWithProcessSynchronizer::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStore::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStoreFromFilesystem::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStorePartialRead::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStoreNested::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStoreNestedPartialRead::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStoreV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStoreV3FromFilesystem::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStoreV3PartialRead::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStoreV3Nested::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithFSStoreV3NestedPartialRead::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayV3::test_object_arrays_vlen_bytes
)

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/notebooks"
		docinto notebooks
		dodoc -r notebooks/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	ZARR_TEST_ABS=1 ZARR_TEST_MONGO=1 ZARR_TEST_REDIS=1 \
	ZARR_V3_EXPERIMENTAL_API=1 epytest
}
