! Copyright (C) 2006 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays sequences kernel gadgets-panes definitions
prettyprint gadgets-theme gadgets-borders gadgets
generic gadgets-scrolling math io words models styles
namespaces gadgets-tracks gadgets-presentations gadgets-grids
gadgets-frames help gadgets-buttons ;
IN: gadgets-browser

TUPLE: definitions showing ;

: find-definitions ( gadget -- definitions )
    [ definitions? ] find-parent ;

: definition-index ( definition definitions -- n )
    definitions-showing index ;

: close-definition ( gadget definition -- )
    over find-definitions definitions-showing delete
    unparent ;

C: definitions ( -- gadget )
    <pile> over set-delegate
    { 2 2 } over set-pack-gap
    V{ } clone over set-definitions-showing ;

TUPLE: tile definition gadget ;

: find-tile [ tile? ] find-parent ;

: close-tile ( tile -- )
    dup tile-definition over find-definitions
    definitions-showing delete
    unparent ;

: <tile-toolbar> ( -- gadget )
    {
        { "Close" [ close-tile ] }
        { "Help" [ tile-definition help ] }
        { "Callers" [ tile-definition usage. ] }
        { "Edit" [ tile-definition edit ] }
        { "Reload" [ tile-definition reload ] }
        { "Watch" [ tile-definition watch ] }
    } [ first2 \ find-tile add* <bevel-button> ] map
    make-shelf ;

: <tile-content> ( definition -- gadget )
    [ see ] make-pane <tile-toolbar> 2array
    make-pile { 5 5 } over set-pack-gap
    <default-border> dup faint-boundary ;

C: tile ( definition -- gadget )
    [ set-tile-definition ] 2keep
    [ >r <tile-content> r> set-gadget-delegate ] keep ;

: show-definition ( definition definitions -- )
    2dup definition-index dup 0 >= [
        over nth-gadget swap scroll>rect drop
    ] [
        drop 2dup definitions-showing push
        swap <tile> over add-gadget
        scroll>bottom
    ] if ;

: <list-control> ( model quot -- gadget )
    [ map [ first2 write-object terpri ] each ] curry
    <pane-control> ;

TUPLE: navigator vocab ;

: <vocab-list> ( -- gadget )
    vocabs <model> [ dup <vocab-link> 2array ]
    <list-control> ;

: <word-list> ( model -- gadget )
    gadget get navigator-vocab
    [ words natural-sort ] <filter>
    [ dup word-name swap 2array ]
    <list-control> ;

C: navigator ( -- gadget )
    f <model> over set-navigator-vocab
    {
        { [ <vocab-list> ] f [ <scroller> ] 1/2 }
        { [ <word-list> ] f [ <scroller> ] 1/2 }
    } { 1 0 } make-track* ;

TUPLE: browser navigator definitions ;

C: browser ( -- gadget )
    {
        { [ <navigator> ] set-browser-navigator f 1/4 }
        { [ <definitions> ] set-browser-definitions [ <scroller> ] 3/4 }
    } { 0 1 } make-track* ;

M: browser gadget-title drop "Browser" <model> ;

: show-vocab ( vocab browser -- )
    browser-navigator navigator-vocab set-model ;

: show-word ( word browser -- )
    over word-vocabulary over show-vocab
    browser-definitions show-definition ;
