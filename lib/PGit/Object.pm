#!/usr/bin/env perl

package PGit::Object;

use PGit::Common qw($PGIT_DIR $OBJECTS_DIR);
use File::Path 'make_path';
use strict;
use warnings;

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
