
use v6;

unit class Libclang::Cursor;

use Libclang::Raw;
use NativeCall;

has Pointer $.cursor;

method spelling {
  die "Cursor is undefined" unless $!cursor.defined;
  clang_getCursorSpelling($!cursor);
}

method kind {
  die "Cursor is undefined" unless $!cursor.defined;
  clang_getCursorKind($!cursor);
}

method kind-spelling {
  die "Cursor is undefined" unless $!cursor.defined;
  clang_getCursorKindSpelling(self.kind);
}

method visit-children(&visitor-callback) {
  die "Cursor is undefined"   unless $!cursor.defined;
  die "Callback is undefined" unless &visitor-callback.defined;

  sub visitChildren(Pointer[CXCursor] $cursor, Pointer[CXCursor] $parent) {
    my $spelling      = clang_getCursorSpelling($cursor);
    my $kind          = clang_getCursorKind($cursor);
    my $kind-spelling = clang_getCursorKindSpelling($kind);
    printf("Cursor '%s' of kind '%s'\n", $spelling, $kind-spelling);
    return CXChildVisit_Recurse;
  }

  clang_visitChildren($!cursor, &visitChildren);
}

method destroy {
  die "Cursor is undefined" unless $!cursor.defined;
  free_cursor($!cursor);
}
