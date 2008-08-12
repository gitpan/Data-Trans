use Test::More tests => 2;

use Data::Trans;

{
    my $tr = Data::Trans->new({
        scalar => sub {
            my ($tr, $data) = @_;
            my $new_data = ucfirst $$data;
            return \$new_data;
        }
    });

    is(${$tr->trans(\'zigorou')}, 'Zigorou');
}

{
    my $tr = Data::Trans->new();

    is(${$tr->trans(\'zigorou')}, 'zigorou');
}
