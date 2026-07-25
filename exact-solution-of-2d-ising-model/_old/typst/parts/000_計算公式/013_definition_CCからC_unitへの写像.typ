#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition([$CC -> C_("unit")$])[
  $c_("unit") : CC without {(0, 0)} -> C_("unit")$ を以下のように定める。

  $forall (x, y) in CC without {(0, 0)}$ について、

  以下を満たすような、$r in RR_(>0) と (x_(c), y_(c)) in C_("unit")$ が ただ一つずつ存在する

  $
    r x_(c) = x and r y_(c) = y
  $

  これを用いて、

  $
    c_("unit")(x, y) := (x_(c), y_(c))
  $
]
