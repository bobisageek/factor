IN: io
USING: generic kernel ;

! Wrap your stream in this to avoid implementing the extended
! protocol.
TUPLE: plain-writer ;

C: plain-writer ( stream -- stream ) [ set-delegate ] keep ;

M: plain-writer stream-terpri CHAR: \n swap stream-write1 ;
M: plain-writer stream-terpri* stream-terpri ;
M: plain-writer stream-format nip stream-write ;
M: plain-writer with-nested-stream ( quot style stream -- )
    nip swap with-stream* ;
