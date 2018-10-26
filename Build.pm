
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

    sub find-libclang-config {
      my @versions = <3.4 3.8>;
      for @versions -> $version {
        my $include-dir = "/usr/lib/llvm-$version/include";
        if $include-dir.IO ~~ :d {
          return {
            includes => "-I $include-dir",
            libs     => "-lclang-$version"
          }
        }
      }
      return
    }

    my @libs = <clang-3.8>;
    my $libs = @libs.map( { "-l$_" } ).join(' ');
    my $libname = sprintf($*VM.config<dll>, "clang-perl6");
    if $*DISTRO.name eq "macosx" {
      shell("clang --shared -fPIC -I/usr/local/include -L/usr/local/lib -I /usr/local/Cellar/llvm/7.0.0/include src/libclang-perl6.c -o $destdir/$libname  $libs")
    } else {
      my $libclang-config = find-libclang-config;
      die "Unable to detect clang config" unless $libclang-config.defined;

      my $includes        = $libclang-config<includes>;
      my $libs            = $libclang-config<libs>;
      shell("clang --shared -fPIC src/libclang-perl6.c -o $destdir/$libname $includes -I /usr/lib/llvm-3.8/include $libs")
    }

}
