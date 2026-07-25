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

#definition("Lie Groups, Lie Algebras, and Representations Definition 3.32")[
  // $G$ : Matrix Lie群, $frak(g)$ : $G$のLie環
  $G$ : Matrix Lie群

  $g in G$について、
  #mapDef($"Ad"_g$, $G$, $G$, $h$, $g h g^(-1)$, "")

  // $X in frak(g)$について、
  // #mapDef($"ad"_X$, $frak(g)$, $frak(g)$, $Y$, $[X, Y]$, "")
  $X in M(n, CC)$について、
  #mapDef($"ad"_X$, $M(n, CC)$, $M(n, CC)$, $Y$, $[X, Y]$, "")
]
