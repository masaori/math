#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition([$CC$の逆三角関数の定義])[
  $A := (1, 0) in CC$ と定める。


  i) $arcsin : {y in RR | -1 <= y <= 1} -> {theta in RR | -pi/2 <= theta <= pi/2}$ を以下のように定める。

  $y in RR, 0 <= y <= 1$ について、 $P := (sqrt(1 - y^2)^(RR_(>=0)), y) in C_("unit")$ とおき、

  $
    arcsin(y) := l(A P)
  $

  と定め、

  $y^prime in RR, -1 <= y^prime <= 0$ について、

  $
    arcsin(y^prime) := -arcsin(-y^prime)
  $

  と定める。

  ii) $arctan : RR -> {theta in RR | -pi/2 <= theta <= pi/2}$ を以下のように定める.

  $x in RR$ について、$-1 <= x / sqrt(1 + x^2)^(RR_(>=0)) <= 1$ であるから、

  $
    arctan(x) := arcsin(x / sqrt(1 + x^2)^(RR_(>=0)))
  $

  iii) $sin: { theta in RR | - pi / 2 <= theta <= pi / 2 } -> {x in RR | -1 <= x <= 1}$ を以下のように定める.

  $arcsin$は${x in RR | -1 <= x <= 1}$において単調増加かつ連続(証明:齋藤命題2.1.5)であり、値域が ${x in RR | - pi / 2 <= x <= pi / 2}$ であるから、

  $arcsin$の逆関数が存在し、これを$sin$と定める。

  iv) $cos: { theta in RR | - pi / 2 <= theta <= pi / 2 } -> {x in RR | -1 <= x <= 1}$ を以下のように定める.

  $- pi / 2 <= theta <= pi / 2$ で $-1 <= sin(theta) <= 1$ であるから、

  $
    cos(theta) := sqrt(1 - (sin(theta))^2)^(RR_(>=0))
  $

  と定める。
]
