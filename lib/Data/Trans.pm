package Data::Trans;

use strict;
use warnings;

use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw/literal scalar array hash code glob blessed/);

use Clone qw(clone);
use Scalar::Util qw(blessed reftype);

=head1 NAME

Data::Trans - Simple data transformer

=head1 SYNOPSYS

  use Data::Trans;

  my $tr = Data::Trans->new({
    array => sub {
      my ($tr, $data) = @_;
      [ map { $_ * 2 } @$data ]
    }
  });

  $tr->trans([0..9]); # [ 0, 2, 4, 6, 8, 10, 12, 14, 16, 18 ]

=head1 VERSION

version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

=head1 METHODS

=head2 new(\%args)

Constructor. The each keys are callback names. 
The each value is callback sub routine.

=over 

=item literal

=item scalar

=item array

=item hash

=item code

=item glob

=item blessed

=back

=head2 trans($data)

=cut

sub trans {
    my ($self, $data) = @_;
    my $new_data;

    if (blessed $data && $self->blessed) {
        if ($self->blessed) {
            $new_data = $self->blessed->($self, $data);
        }
        else {
            $new_data = clone($new_data);
        }
    }
    else {
        my $reftype = reftype($data);
        if (!defined $reftype) { # scalar
            if ($self->literal) { $new_data = $self->literal->($self, $data); }
            else { $new_data = $data; }
        }
        else {
            my $callback = lc $reftype;
            if ($self->$callback) {
                $new_data = $self->$callback->($self, $data);
            }
            else {
                $new_data = clone($data);
            }
        }
    }

    return $new_data;
}

=head1 AUTHOR

Toru Yamaguchi, C<< <zigorou@cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-data-trans@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically be
notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2008 Toru Yamaguchi, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Data::Trans
