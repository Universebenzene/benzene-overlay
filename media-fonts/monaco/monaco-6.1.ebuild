# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font vcs-snapshot

COMMIT="d258639b562cab674da79e9e3316998e709e8960"

DESCRIPTION="The Monaco monospaced sans-serif typeface with special characters added"
HOMEPAGE="https://github.com/taodongl/monaco.ttf"
SRC_URI="https://github.com/taodongl/monaco.ttf/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc ppc64 x86"

FONT_SUFFIX="ttf"
