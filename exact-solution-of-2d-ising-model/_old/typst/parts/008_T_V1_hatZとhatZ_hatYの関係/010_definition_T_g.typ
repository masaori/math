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

#definition($T_g$)[

  $g in ("Mat"(2, CC)^(times.o M))^(times)$ について、

  #mapDef($T_g$, $"Mat"(2, CC)^(times.o M)$, $"Mat"(2, CC)^(times.o M)$, $h$, $g dot.op h dot.op g^(-1)$, "")

  と定める
]<def_T_g>
