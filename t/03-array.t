use Test::More tests => 22;

use Data::Trans;

{
    my $tr = Data::Trans->new({
        array => sub {
            my ($tr, $data) = @_;
            my $new_data = [map { $_ * 2 } @$data];
            return $new_data;
        }
    });

    my $data = [0..9];
    my $new_data = $tr->trans($data);
    
    is(scalar(@$new_data), scalar(@$data));
    for (my $i = 0; $i < scalar(@$data); $i++) {
        is($new_data->[$i], $data->[$i] * 2);
    }
}

{
    my $tr = Data::Trans->new;

    my $data = [0..9];
    my $new_data = $tr->trans($data);
    
    is(scalar(@$new_data), scalar(@$data));
    for (my $i = 0; $i < scalar(@$data); $i++) {
        is($new_data->[$i], $data->[$i]);
    }
}
