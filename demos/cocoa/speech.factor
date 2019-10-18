! Copyright (C) 2006 Slava Pestov
! See http://factorcode.org/license.txt for BSD license.
IN: objc-classes
DEFER: NSSpeechSynthesizer

IN: cocoa-speech
USING: cocoa objc objc-classes kernel ;

"NSSpeechSynthesizer" f import-objc-class

: say ( string -- )
	NSSpeechSynthesizer -> alloc f -> initWithVoice: swap
    <NSString> -> startSpeakingString: drop ;

"Hello from Factor" say
