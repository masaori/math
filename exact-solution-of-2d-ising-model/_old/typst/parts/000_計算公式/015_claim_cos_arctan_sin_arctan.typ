#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$cos(arctan(x)), sin(arctan(x))$])[
  $x in RR$について、$-1 <= x / sqrt(1 + x^2)^(RR_(>=0)) <= 1$であるから、
  
  $
    cos(arctan(x))
    &=
    cos(arcsin(x / sqrt(1 + x^2)^(RR_(>=0))))
    \
    &=
    sqrt(
      1
      -
      (
        sin(
          arcsin(x / sqrt(1 + x^2)^(RR_(>=0)))
        )
      )
      ^2
    )^(RR_(>=0))
    \
    &=
    sqrt(
      1
      -
      (
        x / sqrt(1 + x^2)^(RR_(>=0))
      )
      ^2
    )^(RR_(>=0))
    \
    &=
    sqrt(
      1
      -
      (
        x^2 / (1 + x^2)
      )
    )^(RR_(>=0))
    \
    &=
    sqrt(
      (
        (1 + x^2) - x^2
      )
      /
      (1 + x^2)
    )^(RR_(>=0))
    \
    &=
    sqrt(
      1
      /
      (1 + x^2)
    )^(RR_(>=0))
    \
    &=
    1
    /
    sqrt(
      1 + x^2
    )^(RR_(>=0))
  $

  $
    sin(arctan(x))
    &=
    sin(arcsin(x / sqrt(1 + x^2)^(RR_(>=0))))
    \
    &=
    x / sqrt(1 + x^2)^(RR_(>=0))
  $
]<cos_arctan_sin_arctan>
