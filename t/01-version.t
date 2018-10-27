use v6;
use Test;

plan 5;

use Libclang;

my %version = Libclang.version;
diag %version.perl;
ok %version ~~ Hash, "Version hash";
ok %version<string> ~~ Str, "Version string";
ok %version<major> ~~ Int,  "Integer major version";
ok %version<minor> ~~ Int,  "Integer minor version";
ok %version<patch> ~~ Int,  "Integer patch version";
