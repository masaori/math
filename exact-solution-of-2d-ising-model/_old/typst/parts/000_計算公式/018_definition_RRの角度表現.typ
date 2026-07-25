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

#definition([$RR$の角度表現])[
  $RR$の (角度表現) を、 $RR \/ ~_(angle)$ に、

  #mapDef(
    $"和" +$,
    $RR \/ ~_(angle) times RR \/ ~_(angle)$,
    $RR \/ ~_(angle)$,
    $([theta]_(~_(angle)), [theta^prime]_(~_(angle)))$,
    $[theta + theta^prime]_(~_(angle))$,
    ""
  )

  #mapDef(
    $"実数倍" dot.op_("real")$,
    $RR times RR \/ ~_(angle)$,
    $RR \/ ~_(angle)$,
    $(a, [theta]_(~_(angle)))$,
    $[a dot.op s_([0, 2pi))([theta]_(~_(angle)))]_(~_(angle))$,
    ""
  )

  を入れたものとして定める

  #note[

    この積$dot.op_("real")$は、例えば、

    $
      1/2 dot.op_("real") (-2 dot.op_("real") [pi/2]_(~_(angle)))
      &=
      [1/2 dot.op s_([0, 2pi))[-2 dot.op s_([0, 2pi))([pi/2]_(~_(angle)))]_(~_(angle))]_(~_(angle))
      \
      &=
        [1/2 dot.op s_([0, 2pi))[-2 dot.op pi/2]_(~_(angle))]_(~_(angle))
      \
      &=
        [1/2 dot.op s_([0, 2pi))[- pi]_(~_(angle))]_(~_(angle))
      \
      &=
        [1/2 dot.op pi]_(~_(angle))
      \
      &=
        pi/2
    $

    $
      (1/2 dot.op -2) dot.op_("real") [pi/2]_(~_(angle))
      &=
        [-1 dot.op s_([0, 2pi))([pi/2]_(~_(angle)))]_(~_(angle))
      \
      &=
        [-1 dot.op pi/2]_(~_(angle))
      \
      &=
        -pi/2
    $

    より、スカラー積とはならない

  ]
]
