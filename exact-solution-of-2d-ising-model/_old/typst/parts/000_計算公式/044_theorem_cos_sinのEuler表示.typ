#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem([$cos, sin$のEuler表示])[
  $forall theta in RR$

  $
    cos(theta) = (e^(sqrt(-1) theta) + e^(-sqrt(-1) theta))/2
  $

  $
    sin(theta) = (e^(sqrt(-1) theta) - e^(-sqrt(-1) theta))/(2 sqrt(-1))
  $

  #proof[
    Eulerの公式 $e^(sqrt(-1) theta) = cos(theta) + sqrt(-1) sin(theta)$ より、

    $
      e^(sqrt(-1) theta) &= cos(theta) + sqrt(-1) sin(theta) \
      e^(-sqrt(-1) theta) &= cos(-theta) + sqrt(-1) sin(-theta) = cos(theta) - sqrt(-1) sin(theta)
    $

    辺々加えると、

    $
      e^(sqrt(-1) theta) + e^(-sqrt(-1) theta) = 2 cos(theta)
    $

    辺々引くと、

    $
      e^(sqrt(-1) theta) - e^(-sqrt(-1) theta) = 2 sqrt(-1) sin(theta)
    $

    $qed$
  ]
]<euler_formula_cos_sin>
