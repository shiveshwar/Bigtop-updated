set -ex
usage() {
  echo "
usage: $0 <options>
  Required not-so-options:
     --distro-dir=DIR            path to distro specific files (debian/RPM)
     --build-dir=DIR             path to build directory
     --prefix=PREFIX             path to install into
  "
  exit 1
}
OPTS=$(getopt \
  -n $0 \
  -o '' \
  -l 'prefix:' \
  -l 'distro-dir:' \
  -l 'build-dir:' \
  -- "$@")
if [ $? != 0 ] ; then
    usage
fi
eval set -- "$OPTS"
while true ; do
    case "$1" in
        --prefix)
        PREFIX=$2 ; shift 2
        ;;
        --distro-dir)
        DISTRO_DIR=$2 ; shift 2
        ;;
        --build-dir)
        BUILD_DIR=$2 ; shift 2
        ;;
        --)
        shift ; break
        ;;
        *)
        echo "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
done
install -d -p -m 755 $DISTRO_DIR/presto/usr/lib/presto/
install -p -m 644 $DISTRO_DIR/presto.txt $DISTRO_DIR/presto/usr/lib/presto/
# install -p -m 755 $BUILD_DIR/presto.sh $DISTRO_DIR/presto/usr/lib/presto/
