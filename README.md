# Libclang

 [![Build Status](https://travis-ci.org/azawawi/p6-libclang.svg?branch=master)](https://travis-ci.org/azawawi/p6-libclang) [![Build status](https://ci.appveyor.com/api/projects/status/github/azawawi/p6-libclang?svg=true)](https://ci.appveyor.com/project/azawawi/p6-libclang/branch/master)

Perl 6 bindings for [`libclang`](https://clang.llvm.org/doxygen/group__CINDEX.html)

**Note: This is currently experimental and API may change. Please DO NOT use in
a production environment.**

## Example

```perl6
use v6;

#TODO add example
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

## Author

Ahmad M. Zawawi, [azawawi](https://github.com/azawawi/) on #perl6.

## License

[MIT License](LICENSE)
