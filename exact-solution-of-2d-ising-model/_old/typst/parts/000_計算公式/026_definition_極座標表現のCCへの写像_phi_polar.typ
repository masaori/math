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

#definition([極座標表現の$CC$への写像])[
    $phi_("polar") : CC -> "(極座標表現)"$を以下のように定める。

    $
      phi_("polar")(x, y)
      :=
      cases(
        [(sqrt(x^2 + y^2)^(RR_(>=0)), arctan(y/x))]_(~) & quad (x > 0),
        [(sqrt(x^2 + y^2)^(RR_(>=0)), arctan(y/x) + pi)]_(~) & quad (x < 0, y >= 0),
        [(sqrt(x^2 + y^2)^(RR_(>=0)), arctan(y/x) - pi)]_(~) & quad (x < 0, y < 0),
        [(y, pi / 2)]_(~) & quad (x = 0 and y > 0),
        [(-y, -pi / 2)]_(~) & quad (x = 0 and y < 0),
        [(0, 0)]_(~) & quad (x = 0 and y = 0)
      )
    $
]
