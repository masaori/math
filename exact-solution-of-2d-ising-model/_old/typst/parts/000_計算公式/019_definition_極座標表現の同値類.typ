#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition([極座標表現の同値類])[
  $RR_(>=0) times RR$ の同値関係 $~$ を $(r, theta), (r^prime, theta^prime) in RR_(>=0) times RR$ に対して、
  $
    (r, theta) ~ (r^prime, theta^prime)
    attach(<=>, t:"def")
    r = r^prime = 0 or (r = r^prime and theta ~_(angle) theta^prime)
  $
  と定めると、商集合 $(RR_(>=0) times RR) \/ ~$ が定まる。

  $(r, theta) in RR_(>=0) times RR$の $(RR_(>=0) times RR) \/ ~$ における同値類を

  $
    [(r, theta)]_(~) in (RR_(>=0) times RR) \/ ~
  $

  と書く
]
