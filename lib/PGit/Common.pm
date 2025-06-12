#!/usr/bin/env perl

package PGit::Common;

use Exporter qw(import);
our @EXPORT_OK = qw($PGIT_DIR $OBJECTS_DIR $INDEX_PATH $REFS_DIR get_head update_head get_current_commit get_branch_by_name);
use Cwd;
use strict;
use warnings;

# to add to pgit-<cmd>
# use FindBin '$Bin';
# use lib "$Bin/../lib";

our $PGIT_DIR = "@{[getcwd()]}/.pgit";
our $INDEX_PATH = "$PGIT_DIR/index";
our $OBJECTS_DIR = "$PGIT_DIR/objects";
our $REFS_DIR = "$PGIT_DIR/refs";

sub get_head {
  open my $head_file, '<', "$PGIT_DIR/HEAD" or die "$PGIT_DIR/HEAD: $!\n";
  (split(' ', scalar <$head_file>))[1];
}

# update head with given sha1hex
sub update_head {
  my ($commit_sha) = @_;
  my $branch_path = "$PGIT_DIR/@{[get_head]}";
  open my $branch_file, '>', $branch_path or die "$branch_path: $!\n";
  print $branch_file $commit_sha;
}

# follow HEAD to find current commit
sub get_current_commit {
  my $branch_path = "$PGIT_DIR/@{[get_head]}";
  open my $branch_file, '<', $branch_path or return undef;
  scalar <$branch_file>;
}

# return sha1hex from branch
sub get_branch_by_name {
  my ($branch_name) = @_;
  open my $branch, '<', "$PGIT_DIR/refs/heads/$branch_name" or return undef;
  scalar <$branch>;
}

1;
