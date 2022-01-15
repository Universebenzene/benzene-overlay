multilib_src_install() {
	dodir /usr/$(get_libdir)/pkgconfig
	sed -e '/PREFIX/s/{{PREFIX}}/\/usr/' -e "/ROOTLIBDIR/s/{{ROOTLIBDIR}}/\${prefix}\/$(get_libdir)/" \
		-e "/INCLUDE_DIR/s/{{INCLUDE_DIR}}/\${prefix}\/include/" -e "/URL/s/{{PROJECT_URL}}/${HOMEPAGE//\//\\/}/" \
		-e "/Version/s/{{PROJECT_VERSION}}/${PV%.*}/" "${S}"/src/libsystemd/libsystemd.pc.in > \
		${ED%/}/usr/$(get_libdir)/pkgconfig/libsystemd.pc || die
	#use split-usr ...
}
