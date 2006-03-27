! Copyright (C) 2005, 2006 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
IN: help
USING: arrays generic kernel namespaces prettyprint sequences
words ;

M: word article-title
    [
        "The " % dup word-name % class? " class" " word" ? %
    ] "" make ;

M: word article-name word-name ;

: word-article ( word -- article ) "help" word-prop ;

: word-help ( word -- )
    dup word-article [
        % drop
    ] [
        "predicating" word-prop [
            \ $predicate swap 2array ,
        ] when*
    ] if* ;

M: word article-content
    [
        \ $synopsis over 2array ,
        dup word-help
        \ $definition swap 2array ,
    ] { } make ;
