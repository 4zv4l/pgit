#!/usr/bin/env perl

package PGit::Object;

use Cwd;
use File::Path 'make_path';
use Data::Printer;

our $PGIT_DIR    = "@{[getcwd()]}/.pgit";
our $OBJECTS_DIR = "$PGIT_DIR/objects";

sub new {
  my ($pkg, $sha) = @_;
  bless {sha => $sha}, $pkg;
}

# create object file and write $str to it
sub write {
  my ($self, $str) = @_;
  my @sha          = split '', $self->{sha};
  my $object_dir   = "$OBJECTS_DIR/" . join('', @sha[0,1]);
  make_path($object_dir);
  my $blob_path    = "$object_dir/" . join('', @sha[2..$#sha]);
  open my $blob_file, '>:raw', $blob_path or die "$blob_path: $!\n";
  print $blob_file $str;
}

1;
