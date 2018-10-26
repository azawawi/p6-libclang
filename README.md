# Libclang

 [![Build Status](https://travis-ci.org/azawawi/p6-libclang.svg?branch=master)](https://travis-ci.org/azawawi/p6-libclang) [![Build status](https://ci.appveyor.com/api/projects/status/github/azawawi/p6-libclang?svg=true)](https://ci.appveyor.com/project/azawawi/p6-libclang/branch/master)

Perl 6 bindings for [`libclang`](https://clang.llvm.org/doxygen/group__CINDEX.html)

**Note: This is currently experimental and API may change. Please DO NOT use in
a production environment.**

## Example

```perl6
use v6;

use NativeCall;
use Libclang;

sub visitChildren(Pointer[CXCursor] $cursor, Pointer[CXCursor] $parent) {
  my $spelling      = clang_getCursorSpelling($cursor);
  my $kind          = clang_getCursorKind($cursor);
  my $kind-spelling = clang_getCursorKindSpelling($kind);
  printf("Cursor '%s' of kind '%s'\n", $spelling, $kind-spelling);
  return CXChildVisit_Recurse;
}

printf("libclang version '%s'\n", clang_getClangVersion);

my $index = clang_createIndex(0, 0);
LEAVE clang_disposeIndex($index);

my $null-ptr = Pointer.new;
my $unit = clang_parseTranslationUnit(
  $index,
  $*SPEC.catfile($*PROGRAM.IO.parent, "header.hpp"),
  $null-ptr,
  0,
  $null-ptr,
  0,
  CXTranslationUnit_None
);
die "Unable to parse translation unit. Quitting."
  unless $unit.defined;
LEAVE clang_disposeTranslationUnit($unit) if $unit.defined;

my $cursor-ptr = clang_getTranslationUnitCursor($unit);

LEAVE free_cursor($cursor-ptr) if $cursor-ptr.defined;

clang_visitChildren($cursor-ptr, &visitChildren);
```

## Installation

- Install this module using [zef](https://github.com/ugexe/zef):

```
$ zef install Libclang
```

## Testing

- To run tests:
```
$ prove -ve "perl6 -Ilib"
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ AUTHOR_TESTING=1 prove -e "perl6 -Ilib"
```

## See Also
- https://gist.githubusercontent.com/raphaelmor/3150866/raw/4f722b922ae19c9d6c328d79d5a5ca8cb018fb77/clanglib.c
- https://shaharmike.com/cpp/libclang/


## Author

Ahmad M. Zawawi, [azawawi](https://github.com/azawawi/) on #perl6.

## License

[MIT License](LICENSE)
