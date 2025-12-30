#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.60)
AC_INIT([xlibre-xf86-video-omap],
        [25.0.0],
        [https://github.com/X11Libre/xf86-video-omap/issues],
        [xlibre-xf86-video-omap])
AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR(.)

AM_INIT_AUTOMAKE([dist-xz])

# Require xorg-macros: XORG_DEFAULT_OPTIONS
m4_ifndef([XORG_MACROS_VERSION],
          [m4_fatal([must install xorg-macros 1.4 or later before running autoconf/autogen])])
XORG_MACROS_VERSION(1.4)
XORG_DEFAULT_OPTIONS

# Checks for programs.
AC_DISABLE_STATIC
AC_PROG_LIBTOOL
AC_PROG_CC

AC_CHECK_HEADERS([sys/ioctl.h])

AH_TOP([#include "xorg-server.h"])

PKG_PROG_PKG_CONFIG([0.25])
AC_ARG_WITH(xorg-module-dir,
            AS_HELP_STRING([--with-xorg-module-dir=DIR],
                           [Default xorg module directory]),
            [moduledir="$withval"],
            [moduledir=`$PKG_CONFIG --variable=moduledir xorg-server`])

# Checks for extensions
XORG_DRIVER_CHECK_EXT(RANDR, randrproto)
XORG_DRIVER_CHECK_EXT(RENDER, renderproto)
XORG_DRIVER_CHECK_EXT(XV, videoproto)
XORG_DRIVER_CHECK_EXT(DPMSExtension, xextproto)

# Checks for pkg-config packages
PKG_CHECK_MODULES(XORG, [xorg-server >= 25.0.0] xproto fontsproto [libdrm >= 2.4.36] libdrm_omap xf86driproto $REQUIRED_MODULES)
sdkdir=$(pkg-config --variable=sdkdir xorg-server)

# Checks for header files.
AC_HEADER_STDC

AM_CONDITIONAL(VIDEO_DEBUG, test x$VIDEO_DEBUG = xyes)
if test "$VIDEO_DEBUG" = yes; then
	AC_DEFINE(VIDEO_DEBUG,1,[Enable debug support])
fi

AC_SUBST([moduledir])

AC_OUTPUT([Makefile src/Makefile man/Makefile])
