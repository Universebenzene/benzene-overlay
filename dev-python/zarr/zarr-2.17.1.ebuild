# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="An implementation of chunked, compressed, N-dimensional arrays for Python"
HOMEPAGE="http://zarr.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples jupyter"
RESTRICT="test"	# Test phase runs with fails

RDEPEND="dev-python/asciitree[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.21.1[${PYTHON_USEDEP}]
	dev-python/fasteners[${PYTHON_USEDEP}]
	>=dev-python/numcodecs-0.10.0[${PYTHON_USEDEP}]
	jupyter? (
		>=dev-python/ipywidgets-8.0.0[${PYTHON_USEDEP}]
		dev-python/notebook[${PYTHON_USEDEP}]
	)
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/bsddb3[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/lmdb[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/pymongo[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/numpydoc \
	dev-python/sphinx-automodapi \
	dev-python/sphinx-copybutton \
	dev-python/sphinx-issues \
	dev-python/sphinx-design \
	dev-python/pydata-sphinx-theme

# No module named 'azure'
EPYTEST_DESELECT=(
	zarr/tests/test_core.py::TestArrayWithABSStore::test_0len_dim_1d
	zarr/tests/test_core.py::TestArrayWithABSStore::test_0len_dim_2d
	zarr/tests/test_core.py::TestArrayWithABSStore::test_append_1d
	zarr/tests/test_core.py::TestArrayWithABSStore::test_append_2d
	zarr/tests/test_core.py::TestArrayWithABSStore::test_append_2d_axis
	zarr/tests/test_core.py::TestArrayWithABSStore::test_append_bad_shape
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_0d
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_1d
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_1d_fill_value
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_1d_selections
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_1d_set_scalar
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_2d
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_2d_edge_case
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_2d_partial
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_dtype_shape
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_init
	zarr/tests/test_core.py::TestArrayWithABSStore::test_array_order
	zarr/tests/test_core.py::TestArrayWithABSStore::test_attributes
	zarr/tests/test_core.py::TestArrayWithABSStore::test_compressors
	zarr/tests/test_core.py::TestArrayWithABSStore::test_dtypes
	zarr/tests/test_core.py::TestArrayWithABSStore::test_endian
	zarr/tests/test_core.py::TestArrayWithABSStore::test_hexdigest
	zarr/tests/test_core.py::TestArrayWithABSStore::test_islice
	zarr/tests/test_core.py::TestArrayWithABSStore::test_iter
	zarr/tests/test_core.py::TestArrayWithABSStore::test_iteration_exceptions
	zarr/tests/test_core.py::TestArrayWithABSStore::test_nchunks_initialized
	zarr/tests/test_core.py::TestArrayWithABSStore::test_np_ufuncs
	zarr/tests/test_core.py::TestArrayWithABSStore::test_object_arrays
	zarr/tests/test_core.py::TestArrayWithABSStore::test_object_arrays_danger
	zarr/tests/test_core.py::TestArrayWithABSStore::test_object_arrays_vlen_array
	zarr/tests/test_core.py::TestArrayWithABSStore::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithABSStore::test_object_arrays_vlen_text
	zarr/tests/test_core.py::TestArrayWithABSStore::test_object_codec_warnings
	zarr/tests/test_core.py::TestArrayWithABSStore::test_pickle
	zarr/tests/test_core.py::TestArrayWithABSStore::test_read_only
	zarr/tests/test_core.py::TestArrayWithABSStore::test_resize_1d
	zarr/tests/test_core.py::TestArrayWithABSStore::test_resize_2d
	zarr/tests/test_core.py::TestArrayWithABSStore::test_setitem_data_not_shared
	zarr/tests/test_core.py::TestArrayWithABSStore::test_store_has_binary_values
	zarr/tests/test_core.py::TestArrayWithABSStore::test_store_has_bytes_values
	zarr/tests/test_core.py::TestArrayWithABSStore::test_store_has_text_keys
	zarr/tests/test_core.py::TestArrayWithABSStore::test_structured_array
	zarr/tests/test_core.py::TestArrayWithABSStore::test_structured_array_contain_object
	zarr/tests/test_core.py::TestArrayWithABSStore::test_structured_array_nested
	zarr/tests/test_core.py::TestArrayWithABSStore::test_structured_array_subshapes
	zarr/tests/test_core.py::TestArrayWithABSStore::test_structured_with_object
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_0len_dim_1d
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_0len_dim_2d
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_append_1d
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_append_2d
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_append_2d_axis
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_append_bad_shape
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_0d
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_1d
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_1d_fill_value
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_1d_selections
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_1d_set_scalar
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_2d
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_2d_edge_case
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_2d_partial
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_dtype_shape
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_init
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_array_order
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_attributes
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_compressors
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_dtypes
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_endian
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_hexdigest
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_islice
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_iter
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_iteration_exceptions
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_nbytes_stored
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_nchunks_initialized
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_np_ufuncs
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_object_arrays
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_object_arrays_danger
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_object_arrays_vlen_array
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_object_arrays_vlen_bytes
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_object_arrays_vlen_text
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_object_codec_warnings
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_pickle
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_read_only
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_resize_1d
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_resize_2d
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_setitem_data_not_shared
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_store_has_binary_values
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_store_has_bytes_values
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_store_has_text_keys
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_structured_array
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_structured_array_contain_object
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_structured_array_nested
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_structured_array_subshapes
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_structured_with_object
	zarr/tests/test_core.py::TestArrayWithABSStoreV3::test_view
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_array_creation
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_context_manager
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_create_dataset
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_create_errors
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_create_group
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_create_overwrite
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_delitem
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_double_counting_group_v3
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_empty_getitem_contains_iterators
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_getattr
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_getitem_contains_iterators
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_group_init_1
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_group_init_2
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_group_init_errors_1
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_group_init_errors_2
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_group_repr
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_iterators_recurse
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_move
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_paths
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_pickle
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_require_dataset
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_require_group
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_rmdir_group_and_array_metadata_files
	zarr/tests/test_hierarchy.py::TestGroupWithABSStore::test_setitem
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_array_creation
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_context_manager
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_create_dataset
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_create_errors
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_create_group
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_create_overwrite
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_delitem
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_double_counting_group_v3
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_empty_getitem_contains_iterators
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_getattr
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_getitem_contains_iterators
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_group_init_1
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_group_init_2
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_group_init_errors_1
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_group_init_errors_2
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_group_repr
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_iterators_recurse
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_move
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_paths
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_pickle
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_require_dataset
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_require_group
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_rmdir_group_and_array_metadata_files
	zarr/tests/test_hierarchy.py::TestGroupV3WithABSStore::test_setitem
	zarr/tests/test_storage.py::TestABSStore::test_context_manager
	zarr/tests/test_storage.py::TestABSStore::test_get_set_del_contains
	zarr/tests/test_storage.py::TestABSStore::test_set_invalid_content
	zarr/tests/test_storage.py::TestABSStore::test_clear
	zarr/tests/test_storage.py::TestABSStore::test_pop
	zarr/tests/test_storage.py::TestABSStore::test_popitem
	zarr/tests/test_storage.py::TestABSStore::test_writeable_values
	zarr/tests/test_storage.py::TestABSStore::test_update
	zarr/tests/test_storage.py::TestABSStore::test_iterators
	zarr/tests/test_storage.py::TestABSStore::test_init_array
	zarr/tests/test_storage.py::TestABSStore::test_init_array_overwrite
	zarr/tests/test_storage.py::TestABSStore::test_init_array_overwrite_path
	zarr/tests/test_storage.py::TestABSStore::test_init_array_overwrite_chunk_store
	zarr/tests/test_storage.py::TestABSStore::test_init_group_overwrite
	zarr/tests/test_storage.py::TestABSStore::test_init_group_overwrite_path
	zarr/tests/test_storage.py::TestABSStore::test_init_group_overwrite_chunk_store
	zarr/tests/test_storage.py::TestABSStore::test_init_array_path
	zarr/tests/test_storage.py::TestABSStore::test_init_array_overwrite_group
	zarr/tests/test_storage.py::TestABSStore::test_init_array_compat
	zarr/tests/test_storage.py::TestABSStore::test_init_group
	zarr/tests/test_storage.py::TestABSStore::test_non_client_deprecated
	zarr/tests/test_storage.py::TestABSStore::test_iterators_with_prefix
	zarr/tests/test_storage.py::TestABSStore::test_getsize
	zarr/tests/test_storage.py::TestABSStore::test_hierarchy
	zarr/tests/test_storage.py::TestABSStore::test_pickle
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_context_manager
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_get_set_del_contains
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_set_invalid_content
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_clear
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_pop
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_popitem
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_writeable_values
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_update
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_iterators
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_init_array
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_init_array_overwrite
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_init_array_overwrite_path
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_init_array_overwrite_chunk_store
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_init_group_overwrite_path
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_init_array_path
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_init_array_overwrite_group
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_init_array_compat
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_init_group
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_list_prefix
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_equal
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_rename_nonexisting
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_get_partial_values
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_set_partial_values
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_non_client_deprecated
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_iterators_with_prefix
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_getsize
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_hierarchy
	zarr/tests/test_storage_v3.py::TestABSStoreV3::test_pickle
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
	ZARR_V3_EXPERIMENTAL_API=1 ZARR_V3_SHARDING=1 epytest
}
