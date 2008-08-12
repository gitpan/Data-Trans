use strict;
use warnings;
use inc::Module::Install;

name('Data-Trans');
author('Toru Yamaguchi <zigorou@cpan.org>');
all_from('lib/Data/Trans.pm');
license('perl');

requires('Class::Accessor::Fast');
requires('Clone');
requires('Scalar::Util');

use_test_base;

auto_include;
auto_install;

WriteAll;
