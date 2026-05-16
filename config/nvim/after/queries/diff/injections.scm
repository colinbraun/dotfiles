; extends

; Matches added (+) lines and treats the content as C
(changes 
  _ @injection.content
  (#set! injection.language "rust"))
  ; (#gsub! @injection.content "^[+-](.*)$" "%1"))
  ; (#offset! @injection.content 0 1 0 0))
