use strict;
use warnings;
use Test::More tests => 68;
use Digest::JH qw(jh_512 jh_512_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::JH->new(512)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            jh_512_hex($data), $digest,
            "jh_512_hex: $len bits of $msg"
        );
        ok(
            jh_512($data) eq pack('H*', $digest),
            "jh_512: $len bits of $msg"
        );
    }

    my $md = Digest::JH->new(512)->add_bits($data, $len)
        ->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $len bits of $msg");
}
continue { $len++ }

__DATA__
00|96D728DD0C96091D228C962B5013A9E4248AF4A6EEE112D71EE02930A62C8A9A0ADCD4F710E297C8F6C24342106EF276F8E4CF45D220E0CC39AED85BD071C31F
00|C779A62BD80E67F356D4A8DEB1D1E8E39E0043DF49B411ECC9D4D420D29A1A997E6C56A6A07121C55524D1B2965D2A79ADBD40F472A97C8BD780D341FD45EE8F
C0|D1A20D4865C27696C0DAAD3D1815E3DBDFC92285A28D508E038197C8C4E3F022F7F45041EF7C3888F556EF7F329EBC7F1508DD5E393867FEF3BECC9C8385BD90
C0|6E8FF17744D90470A877887BF3F947EC8C04194C0FC3BE58531F772460EF44CAC171D6264617860285B32182519143CA358289B92FD1EBF59B6C972E241EFDFE
80|117AE44944AE535455DABA6F494C6F7AC96BD021BCA1C209A0FFE6CF1E7CDEE0C500A111120415B2CE1F6CF65B13CFA2192F4C68B529DB875398BC7C1ED735F8
48|A5BFBF03CD1950E279FED8A10476D2C6FE557151BFB51628C036C1914E44C249B2AB64C516B508AF655C2FAE647EA564B683A616605DA56C594C44075724A4A2
50|8709E69B3A0E8E518EFF47C616BA80F8D6B460B272FA8D1D19FA8C91432CAC264CEA653D02B1C62A219ADC541901F66888827DF1C71D2B28891D480E0D3B685C
98|B5E55C713697F97C8DFD77434FB676E83DD2C0AD90E565EC1BF1FA0619B50A843A923A31A7AAA74F89313DDA6F96315F9615EE9F4D42E3C46EF521B9003AD51E
CC|D8CAF839DAFB5E9947B69295DA973EFA7F11E5227D8329D90DCB822EA43EB4DF2231C0A984D80AB2F2540E5D740F7E10FBE535D0A2473FD42A7F64C6D037EA21
9800|3AE0A543842CD630D188AFEFB994E4036923A62BF17AA1BD4BAB9EA453E9BA0BEE1CD5DB69A7D94CDAA2605B1F4FA37F3DB76071CAA81CC2C171B4B2CB04BE18
9D40|C98A992277C1D33086E36C2123B166E97FA3506A48969F02FD14DECA9DF160E027BD8EB488D448D03A1351F6198FA88A5328305EA07E6A100313C4D0E758AE70
AA80|A9C47D2CC755C5F9781A2562FD3B04E99CC8F0071DDC878209C1F571210AF6AB269A994D456BBA75D19C27AF01382C33A1477F511B65DFB00C4B8A12E8381D09
9830|57E255E51D951A8BD575BDE2678DD367A3C69DD66E7D65B864F639286B9BB36906E029531B22CBA2C5C0B2EA0B0671DD4AAE123D9B6910E99AC56BF657349862
5030|069B98EEC3CC5E17124D395847479705A64537AEBDAF7510825ED8BA9AB81A0BED12AC0B62C52A0622FA208825BD265C8FE96AAEA30FE5BC7AC014BD2A6DA796
4D24|8BB2805FAC9B758E8B972E470226D84BD8AFA75C07080665360AFE4B34FA361F7DA7799782E853C5D91C68586F43C7D9CC273459A6576019BC0B1AB8686E6836
CBDE|C0E9256567E27D321236F039117CFDAAB82A2536B7D822C24DAEE4067EFC1CABA1E7A73FA60A3A265AF3860F627241D8DB700FCEBCDB3E7D1F03ED3C3A51102E
41FB|9D5273D2F42C85C2E9EC67DECA1781771AE1C4F249D6647E4103891CFCF74D0D573E58C5691D31F387BF826BF4DED65D1A4C9140AE67AAFD9387F359913C7112
4FF400|F794F578E12D38193F2F282C0762B2439DEB72C84798027B21E6DAC265189B7DF46A84D206DF9E15864AF12502F2C2E5D7666E0C9631CE8DBFAEB365683F1923
FD0440|4224E65D8349A832DEB199C101477E50C975524F152E237154CA27E301B587F5081078FAABBABE463F09F37BAC904C8E3E456645886BFDA2BA88D66206169C28
424D00|1FAA40BB712F15CB8D00C9CE3FE8DD3B82EB57EA8A2FCF53EB862EC5BF8E59C294F5469ECF41A307E433919B327A86ED5D3D94E7DB06CBBBD353F9DBFFA08D82
3FDEE0|B68FEA5EE51435AACDF977CBC7224F777EB057D071FCFFB94047558F82EFE7154FC76AE038F4BB08EB02A91C608B753B4A3469A589CFFA2F8829FC10EEE7E084
335768|75DD3254C3ECF440B634B135ABAC5CD600F62FEAF63D577DDE974EF27DBB2F835E7729013DD09CA219F8FF18BDCE7D894979D1531EDFDBCC43584F2E44A9604B
051E7C|D99AF36D3A5507196F867E968D38768BC4E767868B4B10555E7AEC8C279B55BB81233846A87999767EC525C0479279B72AD2D5D6D5FE371EFD03E983120CF90F
717F8C|25A42B63BF1F3E2A0CEEB5C09D1B5AD6BFAA0CFD185776A4FC893FCDD9CF2F3F25E67BD62FA2E4C42690DE7FCACF5F03F7CA01FD1AB68ECBD90E5238CB23677A
1F877C|7F18E014A456CB898274766F112FEECFC6944FEE9C97045807FC5AF830407ABB1B10A3EECC5DC784D516DC705D31014228C580F957DA06EB9F140279F44C6568
EB35CF80|BDF39394CC8D152F3607AAEE061746ADF272FBDBA668A8FBF67E89BC3F697055E9238390AABF9EBDBA6A64E888CC8CA8317F82099A56228C8997C8F39F3B2670
B406C480|A1EE87FD8E8DECE013EB7E538859A45F494B79AB5EAB0C1932D666C8D19357D48A1BF0CBC8A3D7A4F387FAC760061A1FB913DF2CCB37AC4F3650715250821F59
CEE88040|2E74BFD4301571BB7DC6E1CA3AF6EC6A4489066F2725464CD49732BEF3D56448AA12DEB2C9B906A08DC2B812461D459A31327E3A8043C04E5C3F850CC6F977EC
C584DB70|1E1DCB831EF849813427F7AD007A0415E5926712477AA03B9985462E4CDE5890FFBC6F6EAC33FE1A9387A36DC9A0905B4658FAABD2CC95114A77952C621C019D
53587BC8|B0F072E01C0378AC3249354A80EED72E7D084EC35BA3BC7A3B2A3CD8E2FC8C5AE59DA2B99D0CB0EDEF77A46464BF7CB949E7B36AB83C0F754B279018F3A94DC8
69A305B0|7D51171C2AFD18641CBACAC7AD19335BE7028D4F6B35CCA1FED48C6F46AAC7753554DB225E589759D8A61BB881F4AAEFD6C52D72657367AC834AC8323C6F5FD1
C9375ECE|CC904C37BD663C9CEA0C5547D3F3DCB7CB19BC33A30DFBD0B9DE6CF7FF710CD8ABCF66759E8AF50E42B4E56541FDAD4522E4056E608104596F490FA7733B0419
C1ECFDFC|D016BF94BDF61FB67C3BF3E19FF043761237F988CEA42558CE734F8DA1886FD389FAB85CB13B8E251F76FC576B4030B5CF9B8B1BFC8AE789614D74EA62148ED4
8D73E8A280|A64A44B3BE08FFA3574DE4B5FED07DBF164EE48DD521E8176A298FE0F7E3FBF71EBD63139A90F099C8CA421E520F8512339E7B3A822D06E48655A89D12DFBE29
06F2522080|D734196F17F145A81160761D3836C4EB4BB78179C45689C052EA53595225DB09A20AC29DEFD4BA18EFD0C140F4E9C4FD1C7F224155F442E6576FDEF98AD197FD
3EF6C36F20|0074BD3CE1C60499A5CEDF598BBCD8FE406376C501F87DF1D7E98A85F92E4B56543E0F8B795B8CADD2894E6A1A0939C12EDFA2A0E937B3AF7BC774B6A2172C6C
0127A1D340|2F34CFE55BAF1779BD2DFC18F3ECD27D4C512F34E5E3496C7778EDC9B5FD7CF52096A70C2142F6B25080299CE912BC3AF11F950753AFEF715443020C9F41EBD3
6A6AB6C210|A3AD3F6873C1FB8C13114DFC21C9D8D872557A66BA1B35E54575980F2B6AC4ACED5F3A5A83C53C2C6D27C800C1B617038128FC9644BEA167ADF277E49BE683B3
AF3175E160|C6F66E4854752FB1CB58263D2E8179E1066D5BFFC9C25F24B0D60C735A9ED3439C22747A81F385D6AA1F54A71A843972FC9A45BB63411215EEA35641F5B6BEAC
B66609ED86|2B0217B796768D626F002CB01C5B898DFCCD68310217EE60DD173139BAFD31D08B0B8CF6E0B79C2A57B82D9BED5DCA8E93026D9CC5E7C1799AF5BCB9B6546819
21F134AC57|574D2EDE019D7F83CF47C2CC34C0BA0FBF20008160C163F2AE4F0C421D3BB052253C78A7EB7451F001172EA116DA4A15289FECF38AEDA74F8ED58F5B8CB5244C
3DC2AADFFC80|AA7764B3B5281E788DBAD7FC5E3874318F0546A0C8841E59BA1BD4C4B0B25B2A18ECF56D5CF3E9F0C9257F8ADD86244CCDB634A12A7522E33A842167A3ADCDB3
9202736D2240|08925470EF0CC6E785FC1CBEF6DB29A07B4EEE4637B42913153057C18921CDD68EB3985A2E5A9D3E3C3CDA9B2F47A8C5E60C8B87DAA856419DA2CC6DE59BF9D5
F219BD629820|A63F14B40131ECA0C2DCADB5C046BB333DE710C94DA895738594D233888019716ED677EB030D0D140A5C36AA8456AF54B819E083EF3173A561F5E622E68158E6
F3511EE2C4B0|21C07D3FA18651E31E5ECEAA49CC475D6E7931DC2F234BAF48B6B9977035A6B25845594D08824E39E1601DFADBD065B2EF844D2539BF509486486A25BAF42CED
3ECAB6BF7720|7A4F567BF39898DB0B0340F68B9856B422FE9CABC6B8C7E8B47B8A67DD37FD3CAE5B97DBB27B77D56B02D6056719215C3864C41FAD865AC9F08BE4808965BFE0
CD62F688F498|7C4208171B415E601CEF01BF6C72098F71AB47EE4CE040BDA6115E19DA149A52EE684C26668DAE5CB9BBFD2B0B21C20C1AEAD297F7D0F658A890666BED2A12E7
C2CBAA33A9F8|3A817428B543860C5D02F57564B242FEBAA4F6CABD18A1BA84D5240FC7A1BC119599E263DADA6440F1792DA30FB701B8BBAFE26774B19D33E716B3DCF10A8959
C6F50BB74E29|8A0A4233066EA064D5F9BBF4C3C6CE91F7A4B189AD1873DC738B0E2A10668AB8ABE3C840596B1B2BC9AE276AD9A614E07A20DBD103DB4AD1401C84B7D1CDE96D
79F1B4CCC62A00|CF3DD2D69A73D44B1248CF5A9E257F8DE7F8D03943EE6920C3B3C46E534661796318E87CE8ED1FC56E750319C9E93EA7CDF1E910469194B0103919AD6AD76C13