DESCRIPTION="Minimalistic C client library for the Redis database"
HOMEPAGE="https://github.com/redis/hiredis"

SRC_URI="https://github.com/redis/hiredis/archive/refs/tags/v${HIREDIS_VERSION}.tar.gz"

LICENSE="BSD-3"
SLOT="2.3.2"
KEYWORDS="~arm ~arm64 ~ppc ~ppc64 ~x86 ~x86_64"
IUSE="ssl"

RDEPEND=">=dev-libs/libssl-dev:2.10"
DEPEND="${RDEPEND}
        virtual/pkgconfig"

EAPI="7"

CMAKE_SETUP="
    cmake-files
    -DCMAKE_INSTALL_PREFIX=/usr
    -DHIREDIS_STATIC=ON
    -DHIREDIS_TEST=OFF
    ${USE_SSL:+--DHIREDIS_SSL=ON}"

CMAKE_ARGS="
    -j$(portage.jobs.get_job_count)
    --target install"

pkg_check_module() {
    if [ $? -ne 0 ]; then
        einfo "Package \"\${PKG_CHECK_MODULE}\" not found. Installing dependency..."
        emerge "${PKG_CHECK_MODULE}"
    fi
}

pkg_check_module() {
    if [ $? -ne 0 ]; then
        einfo "Package \"\${PKG_CHECK_MODULE}\" not found. Installing dependency..."
        emerge "${PKG_CHECK_MODULE}"
    fi
}

install() {
    emake install
    install-libdir $(libdir)/libhiredis*.so.a
    install-libdir $(libdir)/libhiredis*.so
    install-includedir $(includedir)/hiredis
    docdir="/usr/share/doc/hiredis-${HIREDIS_VERSION}"
    if [ -d "${S}" ]; then
        cp -rf "${S}" "${docdir}"
    fi
}

post_install() {
    if [ -f "${docdir}/README.md" ]; then
        eset "PKG_DOCS" "${docdir}/README.md"
    fi
}
