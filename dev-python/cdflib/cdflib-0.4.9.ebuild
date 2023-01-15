# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="A python module for reading NASA's Common Data Format (cdf) files Resources"
HOMEPAGE="https://github.com/MAVENSDC/cdflib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	test? (
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mms1_fpi_brst_l2_des-moms_20151016130334_v3.3.0.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mms1_fpi_brst_l2_des-moms_20151016130334_v3.3.0.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mms2_epd-eis_srvy_l2_extof_20160809_v3.0.4.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mms2_epd-eis_srvy_l2_extof_20160809_v3.0.4.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mms2_fgm_srvy_l2_20160809_v4.47.0.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mms2_fgm_srvy_l2_20160809_v4.47.0.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/MGITM_LS180_F130_150615.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/dn_magn-l2-hires_g17_d20211219_v1-0-1.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/SABER_L2B_2021020_103692_02.07.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_euv_l3_minute_20201130_v14_r02.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_lpw_l2_lpiv_20180717_v02_r02.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_lpw_l2_lpiv_20180717_v02_r02.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_lpw_l2_lpnt_20180717_v03_r01.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_lpw_l2_lpnt_20180717_v03_r01.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_lpw_l2_mrgscpot_20180717_v02_r01.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_lpw_l2_mrgscpot_20180717_v02_r01.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_sep_l2_anc_20210501_v06_r00.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_sep_l2_s2-raw-svy-full_20191231_v04_r05.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_sta_l2_d1-32e4d16a8m_20201130_v02_r04.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_swe_l2_arc3d_20180717_v04_r02.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_swe_l2_arc3d_20180717_v04_r02.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_swe_l2_svyspec_20180718_v04_r04.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_swe_l2_svyspec_20180718_v04_r04.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_swi_l2_finearc3d_20180720_v01_r01.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_swi_l2_finearc3d_20180720_v01_r01.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_swi_l2_onboardsvyspec_20180720_v01_r01.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/mvn_swi_l2_onboardsvyspec_20180720_v01_r01.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/omni_hro2_1min_20151001_v01.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/omni_hro2_1min_20151001_v01.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/raids_nirs_20100823_v1.1.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/rbsp-a_magnetometer_1sec-gsm_emfisis-l3_20190122_v1.6.2.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/see__L3_2021009_012_01.ncdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/see__xps_L2A_2021006_012_02.ncdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/sgpsondewnpnC1.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/thc_l2_sst_20210709_v01.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/thc_l2_sst_20210709_v01.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/thg_l2_mag_amd_20070323_v01.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/thg_l2_mag_amd_20070323_v01.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/wi_elsp_3dp_20210115_v01.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/wi_elsp_3dp_20210115_v01.nc
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/wi_k0_spha_20210121_v01.cdf
		https://lasp.colorado.edu/maven/sdc/public/data/sdc/web/cdflib_testing/wi_k0_spha_20210121_v01.nc
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/netcdf4-python[${PYTHON_USEDEP}]
		dev-python/xarray[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/astropy dev-python/sphinx-automodapi dev-python/sphinx_rtd_theme

python_prepare_all() {
	use test && { cp "${DISTDIR}"/{*cdf,*nc} "${S}" || die ; }
	# remove dep on pytest-cov
	sed -i -e '/--cov/d' setup.cfg || die

	distutils-r1_python_prepare_all
}

python_test() {
	epytest --remote-data
}
