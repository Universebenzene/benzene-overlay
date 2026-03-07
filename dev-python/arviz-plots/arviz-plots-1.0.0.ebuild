# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="ArviZ-plots provides ready to use and composable plots for Bayesian Workflow."
HOMEPAGE="https://python.arviz.org/projects/plots"
SRC_URI="https://github.com/arviz-devs/arviz-plots/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bokeh matplotlib plotly"

RDEPEND=">=dev-python/arviz-base-1.0[${PYTHON_USEDEP}]
	>=dev-python/arviz-stats-1.0[${PYTHON_USEDEP},xarray]
	bokeh? ( >=dev-python/bokeh-3.4[${PYTHON_USEDEP}] )
	matplotlib? ( >=dev-python/matplotlib-3.9[${PYTHON_USEDEP}] )
	plotly? (
		>=dev-python/plotly-5.19[${PYTHON_USEDEP}]
		dev-python/webcolors[${PYTHON_USEDEP}]
	)
"
BDEPEND="test? (
		dev-python/bokeh[${PYTHON_USEDEP}]
		dev-python/einops[${PYTHON_USEDEP}]
		|| ( dev-python/h5netcdf[${PYTHON_USEDEP},h5py] dev-python/netcdf4[${PYTHON_USEDEP}] )
		dev-python/plotly[${PYTHON_USEDEP}]
		dev-python/webcolors[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( hypothesis )
distutils_enable_tests pytest
