#!perl

use strict;
use warnings;

use Test::More tests => 513;
use t::Util    qw[throws_ok];

BEGIN {
    use_ok('Unicode::UTF8', qw[ encode_utf8 ]);
}

my @SUPER = ();
{
    for (my $i = 0x8000_0000; $i < 0xFFFF_FFFF; $i += 0x400000) {
        push @SUPER, $i;
    }
}

foreach my $cp (@SUPER) {
    my $name = sprintf 'encode_utf8("\\x{%.4X}") super U-%.8X',
      $cp, $cp;

    my $string = do { no warnings 'utf8'; pack('U', $cp) };

    throws_ok { encode_utf8($string) } qr/Can't map super code point/, $name;
}

