#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition([$CC$の極座標表現への写像])[
  $phi_("cartesian"): "(極座標表現)" -> CC$ を、以下のように定める。

  $
    phi_("cartesian")([(r, theta)]_(~)) := (r cos(theta), r sin(theta))
  $

  #note[

    $
      [theta]_(~_(angle)) = [theta^(prime)]_(~_(angle))
      \
      &=> exists n in ZZ "s.t." (theta - theta^prime) = 2n pi
      \
      &=> cos(theta) = cos(theta^prime) and sin(theta) = sin(theta^prime)
    $

  ]
]
