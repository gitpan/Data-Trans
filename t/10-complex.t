use Test::More tests => 6;

use Data::Trans;

my $tr = Data::Trans->new({
    array => sub {
        my ($tr, $data) = @_;
        return [ reverse @$data ];
    },
    hash => sub {
        my ($tr, $data) = @_;
        my $new_data = {};
        for my $key (keys %$data) {
            $new_data->{join('', reverse split(//, $key))} = $tr->trans($data->{$key});
        }
        return $new_data;
    }
});

my $data = {
    'abc' => {
        'foo' => 1
    },
    'xyz' => [
        0,
        'a',
        'gf'
    ]
};

my $new_data = $tr->trans($data);

ok(exists $new_data->{cba});
ok(exists $new_data->{zyx});

is($new_data->{cba}->{oof}, 1);
is($new_data->{zyx}->[0], 'gf');
is($new_data->{zyx}->[1], 'a');
is($new_data->{zyx}->[2], 0);
