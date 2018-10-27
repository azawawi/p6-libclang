
use v6;
use lib 'lib';
use Libclang::Index;
use Libclang::Raw;

my $index = Libclang::Index.new;
LEAVE $index.destroy if $index.defined;

say $index.global-opts;
$index.global-opts(CXGlobalOpt_ThreadBackgroundPriorityForAll);
say $index.global-opts;
