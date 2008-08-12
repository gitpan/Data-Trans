use Test::More tests => 8;

use Data::Trans;

{
    my $tr = Data::Trans->new(
        {   hash => sub {
                my ( $tr, $data ) = @_;
                my $new_data = {};
                for my $key ( keys %$data ) {
                    $new_data->{ uc $key } = $data->{$key};
                }
                return $new_data;
                }
        }
    );

    my $data = { abc => 1, xyz => 2 };
    my $new_data = $tr->trans($data);

    for my $key ( keys %$data ) {
        is( $new_data->{ uc $key }, $data->{$key} );
        ok( !exists $new_data->{$key} );
    }
}

{
    my $tr = Data::Trans->new;

    my $data = { abc => 1, xyz => 2 };
    my $new_data = $tr->trans($data);
    for my $key ( keys %$data ) {
        is( $new_data->{$key}, $data->{$key} );
        ok( exists $new_data->{$key} );
    }
}
