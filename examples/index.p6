
use v6;
use lib 'lib';
use Libclang;
use Libclang::Raw;

my $index = Libclang::Index.new;
LEAVE $index.destroy if $index.defined;

say $index.global-opts;
$index.global-opts(CXGlobalOpt_ThreadBackgroundPriorityForAll);
say $index.global-opts;

my $file-name        = $*SPEC.catfile($*PROGRAM.IO.parent, "header.hpp");
my $translation-unit = Libclang::TranslationUnit.new($index, $file-name);
LEAVE $translation-unit.destroy if $translation-unit.defined;

my $cursor = $translation-unit.cursor;
say $cursor;
