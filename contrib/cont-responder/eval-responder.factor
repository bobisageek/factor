! Copyright (C) 2004 Chris Double.
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
!
! An httpd responder that allows executing simple definitions.
!
IN: eval-responder
USE: cont-html
USE: html
USE: cont-responder
USE: cont-utils
USE: stack
USE: stdio
USE: namespaces
USE: streams
USE: parser
USE: lists
USE: errors
USE: strings
USE: logic
USE: combinators
USE: live-updater
USE: prettyprint
USE: vocabularies

: <evaluator> ( stack msg history -- )
  #! Create an 'evaluator' object that holds
  #! the current stack, output and history for
  #! do-eval.
  <namespace> [
    "history" set
    "output" set
    "stack" set
  ] extend ;

: display-eval-form ( url -- )
  #! Display the components for allowing entry of 
  #! factor words to be evaluated.
  <form name= "main" method= "post" action= form>     
    [
      [
        <textarea name= "eval" rows= "10" cols= "40" textarea> 
          "" write 
        </textarea>
      ]
      [
        <input type= "submit" value= "Evaluate" accesskey= "e" input/>  
      ]
    ] vertical-layout
  </form> 
  "<script language='javascript'>document.forms.main.eval.focus()</script>" write ;

: escape-quotes ( string -- string )
  #! Replace occurrences of single quotes with
  #! backslash quote.
  [ dup [ [ "'" | "\\'" ] [ "\"" | "\\\"" ] ] assoc dup rot ? ] str-map ;
 
: make-eval-javascript ( string -- string )
  #! Give a string return some javascript that when
  #! executed will set the eval textarea to that string.
  <% "document.forms.main.eval.value=\"" % escape-quotes % "\"" % %> ;

: write-eval-link ( string -- )
  #! Given text to evaluate, create an A HREF link which when
  #! clicked sets the eval textarea to that value.
  <a href= "#" onclick= dup make-eval-javascript a> write </a> ;

: display-stack ( list -- )
  #! Write out html to display the stack.
  <table border= "1" table> 
    <tr> <th> "Callstack" write </th> </tr>
    [ <tr> <td> write-eval-link </td> </tr> ] each
  </table> ;

: display-clear-history-link ( -- )
  #! Write out html to display a link that will clear
  #! the history list.
  " (" write  
  "Clear" [ [ ] "history" set ] quot-href
  ")" write ;

: display-history ( list -- )
  #! Write out html to display the history.
  <table border= "1" table> 
    <tr> <th> "History" write display-clear-history-link </th> </tr>
    [ <tr> <td> write-eval-link </td> </tr> ] each
  </table> ;

: html-for-word-source ( word-string -- )
  #! Return an html fragment dispaying the source
  #! of the given word.
  dup dup
  <namespace> [
    "responder" "inspect" put
    <table border= "1" table> 
      <tr> <th colspan= "2" th> "Source" write </th> </tr>
      <tr> <td colspan= "2" td> [ see ] with-simple-html-output </td> </tr>
      <tr> <th> "Apropos" write </th> <th> "Usages" write </th> </tr>
      <tr> <td valign= "top" td> [ apropos. ] with-simple-html-output </td> 
           <td valign= "top" td> [ usages. ] with-simple-html-output </td>
      </tr>
    </table>
  ] bind ;

: display-word-see-form ( url -- )
  #! Write out the html for code that accepts
  #! the name of a word, and displays the source
  #! code of that word.
  <form method= "post" action= "." form> 
    [
      [ 
        "Enter the name of a word: " write
        "see" [ html-for-word-source ] live-search
      ]
      [
        <div id= "see" div> "" write </div>
      ]
    ] vertical-layout
  </form> ;

: display-last-output ( string -- )
  #! Write out html to display the last output.
  <table border= "1" table> 
    <tr> <th> "Last Output" write </th> </tr>
    <tr> <td> <pre> write </pre> </td> </tr>
  </table> ;
  

: get-expr-to-eval (  -- string )
  #! Show a page to the user requesting the form to be
  #! evaluated. Return the form as a string. Assumes
  #! an evaluator is on the namestack.
  [ 
    <html> 
      <head> 
        <title> "Factor Evaluator" write </title>
        include-live-updater-js
      </head>        
      <body> 
        "Use Alt+E to evaluate, or press 'Evaluate'" paragraph
        [
          [ display-eval-form ]
          [ "stack" get display-stack ]
          [ "history" get display-history ]
        ] horizontal-layout
	display-word-see-form
        "output" get display-last-output
      </body>
    </html>
  ] show [
    "eval" get
  ] bind ;
   
: do-eval ( list string -- list )
  #! Evaluate the expression in 'string' using 'list' as
  #! the datastack. Return the resulting stack as a list.
  parse unit append restack call unstack ;

: do-eval-to-string ( list string -- list string )
  #! Evaluate expression using 'list' as the current callstack.
  #! All output should go to a string which is returned on the
  #! callstack along with the resulting datastack as a list.
  <namespace> [ 
    "inspect" "responder" set
    1024 <string-output-stream> dup >r <html-stream> [
      do-eval 
    ] with-stream r> stream>str 
  ] bind ;

: run-eval-requester ( evaluator -- )
  #! Enter a loop request an expression to
  #! evaluate, and displaying the results. 
  [
    [
      get-expr-to-eval dup "history" cons@
      "stack" get swap do-eval-to-string 
      "output" set "stack" set
    ] forever 
  ] bind ;
  
: eval-responder ( evaluator -- )
  #! Run an eval-responder using the given evaluation details.
  [
    [ 
      run-eval-requester 
    ] [
      show-message-page
    ] catch 
  ] forever ;

"eval" [ [ ] "None" [ ] <evaluator> eval-responder ] install-cont-responder
