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

#definition([絶対値, 偏角])[
  $z in CC$ について、

  $|dot|: CC -> RR_(>=0)$ を

  $
    |z| := "pr"_1(phi_("polar")(z))
  $

  と定め、zの絶対値と呼ぶ

  $arg^([0, 2pi)): CC -> RR$ を

  $
    arg^([0, 2pi))(z) := s_([0, 2pi))("pr"_2(phi_("polar")(z)))
  $

  と定め、zの偏角と呼ぶ
]
