# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{10..13} )

GIT_RAW_URI="https://github.com/skyfielders/python-skyfield/raw/${PV}"

inherit distutils-r1 pypi

DESCRIPTION="Elegant astronomy for Python"
HOMEPAGE="https://github.com/skyfielders/python-skyfield"
SRC_URI+=" doc? (
		${GIT_RAW_URI}/skyfield/documentation/conf.py -> ${P}-d-conf.py
		${GIT_RAW_URI}/skyfield/documentation/bright_stars.png -> ${P}-d-bright_stars.png
		${GIT_RAW_URI}/skyfield/documentation/_sphinx_ext/pretty_protos.py -> ${P}-dp-pretty_protos.py
		${GIT_RAW_URI}/skyfield/documentation/_templates/layout.html -> ${P}-dt-layout.html
		${GIT_RAW_URI}/skyfield/documentation/_static/Circular_179.pdf -> ${P}-ds-Circular_179.pdf
		${GIT_RAW_URI}/skyfield/documentation/_static/Dosis-Medium.ttf -> ${P}-ds-Dosis-Medium.ttf
		${GIT_RAW_URI}/skyfield/documentation/_static/goce-reentry.png -> ${P}-ds-goce-reentry.png
		${GIT_RAW_URI}/skyfield/documentation/_static/logo.png -> ${P}-ds-logo.png
		${GIT_RAW_URI}/skyfield/documentation/_static/mars-elongation.png -> ${P}-ds-mars-elongation.png
		${GIT_RAW_URI}/skyfield/documentation/_static/mars-quadrature-undersampled.png -> ${P}-ds-mars-quadrature-undersampled.png
		${GIT_RAW_URI}/skyfield/documentation/_static/mars-quadrature.png -> ${P}-ds-mars-quadrature.png
		${GIT_RAW_URI}/skyfield/documentation/_static/neowise-finder-chart.png -> ${P}-ds-neowise-finder-chart.png
		${GIT_RAW_URI}/skyfield/documentation/_static/style.css -> ${P}-ds-style.css
		${GIT_RAW_URI}/skyfield/documentation/_static/venus-elongation-undersampled.png -> ${P}-ds-venus-elongation-undersampled.png
		${GIT_RAW_URI}/skyfield/documentation/_static/venus-elongation.png -> ${P}-ds-venus-elongation.png
		${GIT_RAW_URI}/skyfield/documentation/_static/venus_evening_chart.png -> ${P}-ds-venus_evening_chart.png
		${GIT_RAW_URI}/CHANGELOG.rst -> ${P}-o-CHANGELOG.rst
		${GIT_RAW_URI}/design/broadcasting.py -> ${P}-od-broadcasting.py
		${GIT_RAW_URI}/design/calendar_matches.py -> ${P}-od-calendar_matches.py
		${GIT_RAW_URI}/design/delta_t.py -> ${P}-od-delta_t.py
		${GIT_RAW_URI}/design/eclipses_lunar.py -> ${P}-od-eclipses_lunar.py
		${GIT_RAW_URI}/design/mpc_load_times.py -> ${P}-od-mpc_load_times.py
		${GIT_RAW_URI}/design/mpc_make_excerpt.py -> ${P}-od-mpc_make_excerpt.py
		${GIT_RAW_URI}/design/nutation_table.py -> ${P}-od-nutation_table.py
		${GIT_RAW_URI}/design/planet_tilts.py -> ${P}-od-planet_tilts.py
		${GIT_RAW_URI}/design/resolution.py -> ${P}-od-resolution.py
		${GIT_RAW_URI}/design/satellite_is_sunlit.py -> ${P}-od-satellite_is_sunlit.py
		${GIT_RAW_URI}/design/satellite_passes.py -> ${P}-od-satellite_passes.py
		${GIT_RAW_URI}/design/sexagesimal.py -> ${P}-od-sexagesimal.py
		${GIT_RAW_URI}/design/ssb_gm.py -> ${P}-od-ssb_gm.py
		${GIT_RAW_URI}/design/subpoint_accuracy.py -> ${P}-od-subpoint_accuracy.py
		${GIT_RAW_URI}/design/sunrise.py -> ${P}-od-sunrise.py
		${GIT_RAW_URI}/design/time_precision.py -> ${P}-od-time_precision.py
		${GIT_RAW_URI}/examples/comet_neowise_chart.py -> ${P}-e-comet_neowise_chart.py
		${GIT_RAW_URI}/examples/goce_reentry_chart.py -> ${P}-e-goce_reentry_chart.py
		${GIT_RAW_URI}/examples/venus_evening_chart.py -> ${P}-e-venus_evening_chart.py
	)
	test? (
		https://ssd.jpl.nasa.gov/ftp/eph/planets/bsp/de405.bsp
		https://ssd.jpl.nasa.gov/ftp/eph/planets/bsp/de421.bsp
		https://naif.jpl.nasa.gov/pub/naif/generic_kernels/fk/satellites/moon_080317.tf
		https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/moon_pa_de421_1900-2050.bpc
		https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/a_old_versions/pck00008.tpc
		${GIT_RAW_URI}/ci/finals2000A.all -> ${P}-t-finals2000A.all
		${GIT_RAW_URI}/ci/hip_main.dat.gz -> ${P}-t-hip_main.dat.gz
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">dev-python/certifi-2017.4.17[${PYTHON_USEDEP}]
	>=dev-python/jplephem-2.13[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/sgp4-2.2[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/assay[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx skyfield/documentation dev-python/pandas

python_prepare_all() {
	local SDD="skyfield/documentation"
	use doc && { mkdir -p "${S}"/{design,examples,${SDD}/{_sphinx_ext,_static,_templates}} || die ; \
		touch ${SDD}/_sphinx_ext/__init__.py || die ; \
		for ddat in "${DISTDIR}"/*-d-*; do { cp ${ddat} "${S}"/${SDD}/${ddat##*-d-} || die ; } ; done ; \
		for dp in "${DISTDIR}"/*-dp-*; do { cp ${dp} "${S}"/${SDD}/_sphinx_ext/${dp##*-dp-} || die ; } ; done ; \
		for dt in "${DISTDIR}"/*-dt-*; do { cp ${dt} "${S}"/${SDD}/_templates/${dt##*-dt-} || die ; } ; done ; \
		for ds in "${DISTDIR}"/*-ds-*; do { cp ${ds} "${S}"/${SDD}/_static/${ds##*-ds-} || die ; } ; done ; \
		for odat in "${DISTDIR}"/*-o-*; do { cp ${odat} "${S}"/${odat##*-o-} || die ; } ; done ; \
		for od in "${DISTDIR}"/*-od-*; do { cp ${od} "${S}"/design/${od##*-od-} || die ; } ; done ; \
		for edat in "${DISTDIR}"/*-e-*; do { cp ${edat} "${S}"/examples/${edat##*-e-} || die ; } ; done ; }

	use test && { cp "${DISTDIR}"/{*.bsp,*.tf,*pc} "${S}" || die ; \
		for tdata in "${DISTDIR}"/*-t-*; do { cp ${tdata} "${S}"/${tdata##*-t-} || die ; } ; done ; }

	distutils-r1_python_prepare_all
}
