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

#definition([極座標表現の演算])[
  $(RR_(>=0) times RR) \/ ~$ に、二項演算

  #mapDef(
    $dot.op$,
    [$(RR_(>=0) times RR) \/ ~ times (RR_(>=0) times RR) \/ ~$],
    $(RR_(>=0) times RR) \/ ~$,
    $([(r, theta)]_(~), [(r^prime, theta^prime)]_(~))$,
    $[(r r^prime, theta + theta^prime)]_(~)$,
    ""
  )

  を入れたものを (極座標表現) と呼ぶ
]
