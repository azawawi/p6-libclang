
use v6;

unit class Libclang;

use Libclang::Raw;

# Returns a hash map of version information
method version returns Hash {

  my Str $version = clang_getClangVersion;

  # Parse version parts
  my ($major, $minor, $patch);
  if $version ~~ /(\d+) '.' (\d+) '.' (\d+)/ {
    # Version parsed as major.minor.patch
    ($major, $minor, $patch) = (+$/[0], +$/[1], +$/[2]);
  } else {
    # Fail if parsing version parts from version string
    die "Cannot parse version parts from '$version'";
  }

  # Return version hash
  {
    string => $version,
    major  => $major,
    minor  => $minor,
    patch  => $patch,
  }

}
