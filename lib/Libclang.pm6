
use v6;

unit class Libclang;

use Libclang::Cursor;
use Libclang::Index;
use Libclang::Raw;
use Libclang::TranslationUnit;

# Returns version string
method version returns Str {
  return clang_getClangVersion;
}
