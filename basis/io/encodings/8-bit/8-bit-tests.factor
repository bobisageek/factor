USING: arrays io.encodings.string io.encodings.8-bit
io.encodings.8-bit.private strings tools.test ;

{ B{ CHAR: f CHAR: o CHAR: o } } [ "foo" latin1 encode ] unit-test
[ { 256 } >string latin1 encode ] must-fail
{ B{ 255 } } [ { 255 } >string latin1 encode ] unit-test

{ "bar" } [ "bar" latin1 decode ] unit-test
{ { CHAR: b 233 CHAR: r } } [ B{ CHAR: b 233 CHAR: r } latin1 decode >array ] unit-test
{ { 0xfffd 0x20AC } } [ B{ 0x81 0x80 } windows-1252 decode >array ] unit-test

{ t } [ \ latin1 8-bit-encoding? ] unit-test
{ "bar" } [ "bar" \ latin1 decode ] unit-test

{ { 0x221a 0x00b1 0x0040 } } [ B{ 0xfb 0xf1 0x40 } cp437 decode >array ] unit-test
