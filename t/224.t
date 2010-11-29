use strict;
use warnings;
use Test::More tests => 68;
use Digest::JH qw(jh_224 jh_224_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::JH->new(224)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            jh_224_hex($data), $digest,
            "jh_224_hex: $len bits of $msg"
        );
        ok(
            jh_224($data) eq pack('H*', $digest),
            "jh_224: $len bits of $msg"
        );
    }

    my $md = Digest::JH->new(224)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $len bits of $msg");
}
continue { $len++ }

__DATA__
00|12C53596FB61AD2865C0A39B7EFE88166F9EB1F5FC5B434B9C45057E
00|2D84A7D8F235D2EE0B2E6780C6755CD01B473E76610A836A3F8C59B1
C0|7E481E03E1EA6E35D4CE75535713F2EA4277511ED80686F1CB3EE482
C0|E35E75438A880724487FB8939DD4E775591CEBB04D6B49C4B7A88452
80|F262C1A1B41E54944F2205E17B7F540B1CA270D5D1C8B9C3FD7FC1CE
48|59B92AC5A13FC35F58FBAB2F05DCA21FF507309B1910AED5620E4CB9
50|DF19D8E76E0D2D7AED9894839874FCAC445EAF9FF6220B77DD78C8E7
98|33820AF6FC8BA1F360391A8DCBE2E415ABAAD10D06C74C1CF7286594
CC|8300E3279E2F28F1FF33AB3EF52EA9F8B8B7CF917A8197A0BCE76D99
9800|42ACCAFFAEC2B7A7FEC1EE3BCC59F9E475E194BB6D98D2DCF846057B
9D40|0C413D430F63BF32EA6077941663EAC5F49761618C8B1900FB65D446
AA80|669F295427A11F15DC491547E858A7013893F86A5B79578145928D1D
9830|A5465F27A705383FE8FAF4F495EE047B5A4960AC65643C59D3D8C1CE
5030|8D0509ABA4AFBD463776520B4560C31A7026517B35D1B1156E86C9A2
4D24|71F97CCC9984C2BD016C703BCB52A5E5A21CA23275F8808193A63355
CBDE|3B7AC54AFB6914FF190C23FBEAE57024628C8529579CFB22B60696C9
41FB|C401D7771B13B2B819BF0220EEBF689B49AA5BDBC38B754941B67082
4FF400|51C6E601EDD1A5E7F9076F0F2CEF660594076349ED3B51702884CE6E
FD0440|31DA6ED989D482C1E145983962CAB1B1F006D7CD33542B94379736E2
424D00|94DDC339C2C23AA0820BAE97483907AAAC2D2676C2B1133D3BCD0AA8
3FDEE0|F48ED8E3223DD33646AD6B6F25DE4B590F85BBF0676D18D60E4E1129
335768|9E91AA85220E84502F8260964CAD633F2259F126B766F4522908E5E4
051E7C|D9E469114FC126BCDE537D6C79D2646D34AEE0E47F6A858FC2FC1801
717F8C|0F7F3DA7FEE6985853C2DE6160D036E732BB1036BE385E1C82089E2D
1F877C|DC53343FD039D6EE90F9BBADF00EDF5408839B7D1F843705066E0344
EB35CF80|8B30B056CEBECE1C04693FAF3D2C8AF7B3CC4A4221130BFABE9CB37F
B406C480|34CF08833F1D70481A8395621B76187B989F3C25B89B4E7BA8077EC6
CEE88040|8F6D22ABB8323465016F6180D779C03E9DCDB9237F0DE86004138727
C584DB70|EF206DDEEC20C05C8AF228103975F426612414C9AD876B27FECBF104
53587BC8|D87B37DC9DDA3F97223A62F025E5991D7687720F763DA7C6469975A6
69A305B0|D9B301FF793490BC2917D7ACE8F7CB8530D15D91AA87BEFE126B0E63
C9375ECE|47FCC25272BCF4BB531DDE9F2AEE24E676113E9ABFCD9B391D719E6F
C1ECFDFC|809BBAAF595E22998AAC14D50C35E2B51D087272267F6F64DCAF0FBB
8D73E8A280|11F205EB502B34DC4F36F33D7307311560E902014540CBBBD66EECD6
06F2522080|15CC163F913BA9A3152309CA9B8E1B04FB4CD2A52F87241019343B27
3EF6C36F20|927347A24A032EB96D51E2E34073BA326F4D5806128DF438FFAAE87E
0127A1D340|5185DAC3DD7ACDFF56E9066D68CF41957538FAB585EEF26D3C96951A
6A6AB6C210|2B6DC444AF744D2C279257CB13632A6AD01C2096C3281191AF0E41DD
AF3175E160|79DF475EF81849EE69A606A355BA3042721964D4BE3BEBA248E0B0ED
B66609ED86|6312CEC3376A592CDA9A36D64C7468BB3920A662A33721C0E97A8396
21F134AC57|9C43C34439045BAEE9E3952E0484E3835B86BA840905FA7F381E55BC
3DC2AADFFC80|CFFCEFD206846DF3E976683290887B6840F62AB558C49ED7BBC171B1
9202736D2240|F188F438B53D1267CAB0EEC0F5FE685A737C1CC1A677DC0B905F1C60
F219BD629820|E4B3E4CC031AD84FE0E077A5B4FE7A9D38F9018100BA9E2BE17751CD
F3511EE2C4B0|076638BB3C1751F210C762321000B845C4A7B8239F2BECA2F7AF0562
3ECAB6BF7720|29F7BC061AAE272B191D01DBD0A8860BC8B7552FC1DEA914EBC2AB8C
CD62F688F498|B9BA1B0A3016F17E0E5409CEF0B1EF4539D97A2D0A834624CB8F6B79
C2CBAA33A9F8|D90EEEA129714DDD7C0D667462A0B2093E7B5AB5D998F8E4BBA02535
C6F50BB74E29|A9FFB7F69EDFF48354F1D340717FF4AD9AF373F548FF9F73136E4933
79F1B4CCC62A00|5540436ABBE42B56875A3203C39C09C41B35AC388FC84010DE757AD5