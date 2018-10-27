
use v6;

unit class Libclang::Cursor;

use NativeCall;
use Libclang::Raw;

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

method destroy {
  die "Cursor is undefined" unless $!cursor.defined;
  free_cursor($!cursor);
}
