! :folding=indent:collapseFolds=1:

! $Id$
!
! Copyright (C) 2003 Slava Pestov.
! 
! Redistribution and use in source and binary forms, with or without
! modification, are permitted provided that the following conditions are met:
! 
! 1. Redistributions of source code must retain the above copyright notice,
!    this list of conditions and the following disclaimer.
! 
! 2. Redistributions in binary form must reproduce the above copyright notice,
!    this list of conditions and the following disclaimer in the documentation
!    and/or other materials provided with the distribution.
! 
! THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
! INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
! FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
! DEVELOPERS AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
! SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
! PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
! OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
! WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
! OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
! ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

IN: threads

USE: combinators
USE: continuations
USE: kernel
USE: stack

: <thread> ( runnable -- thread )
    [ "java.lang.Runnable" ] "java.lang.Thread" jnew ;

: current-thread ( -- thread )
    [ ] "java.lang.Thread" "currentThread" jinvoke-static ;

: start-thread ( thread -- )
    [ ] "java.lang.Thread" "start" jinvoke ;

: clone-interpreter ( interp1 interp2 -- )
    #! Copy the state of interp1 into interp2.
    [ "factor.FactorInterpreter" ]
    "factor.FactorInterpreter"
    "init" jinvoke ;

: <interpreter> ( -- interpreter )
    #! Clone the current interpreter. Note that it will be
    #! pointing to exactly the same point of execution!
    [ ] "factor.FactorInterpreter" jnew ;

: fork* ( current new -- thread )
    dup <thread> [ clone-interpreter ] dip ; interpret-only

: fork ( -- ? )
    #! Spawn a new thread. In the original thread, push f.
    #! In the new thread, push t.
    interpreter <interpreter> fork* dup current-thread = [
        drop t
    ] [
        start-thread f
    ] ifte ; interpret-only

: in-thread ( quot -- )
    #! Execute a quotation in a new thread.
    fork [ call toplevel ] [ drop ] ifte ; interpret-only
