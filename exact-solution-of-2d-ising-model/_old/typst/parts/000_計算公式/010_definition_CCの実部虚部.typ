#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#let mapDef(f, A, B, a, b, comment) = {
  $
  #grid(
    columns: 6,
    gutter: 5pt,
    $#f$, $:$, $#A$, $->$, $#B$, $#comment$,
    "", "", rotate(-90deg, $in$), "", rotate(-90deg, $in$), "",
    "", "", $#a$, $|->$, $#b$,  ""
  )
  $
}

#definition([$CC$の実部/虚部])[
  $x, y in RR, (x, y) in CC$について、

  #mapDef(
    $Re$, 
    $CC$, $RR$,
    $(x, y)$, 
    $x$,
    ""
  )

  #mapDef(
    $Im$, 
    $CC$, $RR$,
    $(x, y)$, 
    $y$,
    ""
  )

  を定め、 $Re(z), Im(z)$ をそれぞれ $z$ の実部、虚部と呼ぶ。
]
