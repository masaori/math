#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition([角度表現の切断])[
  $s_([0, 2pi)) : RR \/ ~_(angle) -> [0, 2pi)$ を以下のように定める。

  $[theta]_(~_(angle)) in RR \/ ~_(angle)$ に対して、

  $n in ZZ$ で、

  $
    0 <= theta - 2n pi < 2pi
  $

  を満たすようなものがただ一つ存在して、(証明略)

  この $n$ を用いて、

  $
    s_([0, 2pi))([theta]_(~_(angle))) := theta - 2n pi
  $

  と定める。
]
