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

#definition([第1座標, 第2座標])[
  $(r, theta) in "(極座標表現)"$について、

  $
    #mapDef([第1座標 $"pr"_1$], "(極座標表現)", $RR_(>=0)$, $[(r, theta)]_(~)$, $r$, "")
  $

  $$

  $
    #mapDef(
      [第2座標 $"pr"_2$],
      "(極座標表現)",
      "(角度表現)",
      $[(r, theta)]_(~)$, 
      $
        cases(
          [0]_(~_(angle)) & quad (r = 0),
          [theta]_(~_(angle)) & quad (r != 0),
        )
      $, "")
  $
]
