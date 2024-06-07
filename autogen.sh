#! /bin/sh

srcdir=`dirname "$0"`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd "$srcdir"

# on some platforms, you have "g" versions of some of these tools instead,
# ie glibtoolize instead of libtoolize..
find_tool() {
	which $1 2> /dev/null || which g$1 2> /dev/null
}

aclocal=`find_tool aclocal`
libtoolize=`find_tool libtoolize`
automake=`find_tool automake`
autoconf=`find_tool autoconf`
autoheader=`find_tool autoheader`

mkdir -p config && $aclocal && $autoheader && $libtoolize --copy --force && $automake --copy --add-missing --foreign && $autoconf

test -n "$NOCONFIGURE" && {
  echo "skipping configure stage as requested."
  echo "autogen.sh done."
  exit 0
}

cd "$ORIGDIR"

CONFIGURE_DEF_OPT="--enable-maintainer-mode"
echo $srcdir/configure $CONFIGURE_DEF_OPT $*
$srcdir/configure $CONFIGURE_DEF_OPT $* || {
        echo "  configure failed"
        exit 1
}

echo "Now type 'make' to compile"
