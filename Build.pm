
use v6;

unit class Build;

method build($workdir) {

    if $*DISTRO.is-win {
        # On windows, let us install the bundled DLL version, module installer
        # will copy the DLL for us.
        die "Windows is not supported at the moment";

        # Success
        return 1;
    }

    # on Unix, let us try to make it
    my $makefiledir = "$workdir/src";
    my $destdir = "$workdir/resources";
    $destdir.IO.mkdir;

    # Create empty resources files for all platforms so that package managers
    # do not complain
    for <dll dylib so> -> $ext {
        "$destdir/libclang-perl6.$ext".IO.spurt("");
    }

    my @libs = <clang-3.8>;
    my $libs = @libs.map( { "-l$_" } ).join(' ');
    my $libname = sprintf($*VM.config<dll>, "libclang-perl6");
    if $*DISTRO.name eq "macosx" {
        shell("gcc -Wall -shared -fPIC -I/usr/local/include -L/usr/local/lib -I /usr/lib/llvm-3.8/include libclang-perl6.c -o $destdir/$libname  $libs")
    } else {
        shell("gcc -Wall -shared -fPIC libclang-perl6.c -I /usr/lib/llvm-3.8/include -o $destdir/$libname src/libclang-perl6.c $libs");
    }

}
