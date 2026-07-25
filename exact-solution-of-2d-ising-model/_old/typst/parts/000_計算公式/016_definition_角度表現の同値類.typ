#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition([角度表現の同値類])[
  $RR$ の同値関係 $~_(angle)$ を $theta, theta^prime in RR$に対して、

  $
    theta ~_(angle) theta^prime
    attach(<=>, t:"def")
    exists n in ZZ "s.t." (theta - theta^prime) = 2n pi
  $

  と定めると、商集合 $RR \/ ~_(angle)$ が定まる。

  $theta in RR$ の$RR \/ ~_(angle)$における同値類を

  $
    [theta]_(~_(angle)) in RR \/ ~_(angle)
  $

  と書く。
]
