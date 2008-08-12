use Test::More tests => 2;

use Data::Trans;

{
    my $tr = Data::Trans->new({
        literal => sub {
            my ($tr, $data) = @_;
            return ucfirst $data;
        }
    });

    is($tr->trans('zigorou'), 'Zigorou');
}

{
    my $tr = Data::Trans->new;
    is($tr->trans('zigorou'), 'zigorou');
}
