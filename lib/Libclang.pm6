
use v6;

unit class Libclang;

use Libclang::Raw;

# Returns version string
method version returns Str {
  return clang_getClangVersion;
}
