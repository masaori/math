#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$phi_("cartesian")$の同型性])[
  (TODO: 体として同型であることを示した方が良い)

  $[(r, theta)]_(~), [(r^prime, theta^prime)]_(~) in "(極座標表現)"$に対して、

  + $phi_("cartesian")([(r, theta)]_(~) dot.op [(r^prime, theta^prime)]_(~)) = phi_("cartesian")[(r, theta)]_(~) dot.op phi_("cartesian")[(r^prime, theta^prime)]_(~) quad "(モノイド準同型)"$ 
  + $phi_("cartesian")$は全単射

  #proof[
    1. 
    $[(r, theta)]_(~), [(r^prime, theta^prime)]_(~) in "(極座標表現)"$に対して、
    $
      phi_("cartesian")([(r, theta)]_(~) dot.op [(r^prime, theta^prime)]_(~))
      &=
      phi_("cartesian")([(r r^prime, theta + theta^prime)]_(~))
      \
      &=
      (r r^prime cos(theta + theta^prime), r r^prime sin(theta + theta^prime))
    $

    また、

    $
      phi_("cartesian")[(r, theta)]_(~) dot.op phi_("cartesian")[(r^prime, theta^prime)]_(~)
      &=
      (r cos(theta), r sin(theta)) dot.op (r^prime cos(theta^prime), r^prime sin(theta^prime))
      \
      &=
      (r r^prime cos(theta) cos(theta^prime) - r r^prime sin(theta) sin(theta^prime),
        r r^prime cos(theta) sin(theta^prime) + r r^prime sin(theta) cos(theta^prime))
      \
      \
      &=
      (r r^prime (cos(theta) cos(theta^prime) - sin(theta) sin(theta^prime)),
        r r^prime (cos(theta) sin(theta^prime) + sin(theta) cos(theta^prime)))
      \
      &=
      (r r^prime cos(theta + theta^prime), r r^prime sin(theta + theta^prime))
    $

    $qed$

    #note[

      $(-1/2, sqrt(3)/2)$

      $
        sin(arctan(y / x))
        &=
        sin(arctan((sqrt(3)^(RR_(>=0))/2) / (-1/2)))
        \
        &=
        sin(arctan(-sqrt(3)^(RR_(>=0))))
        \
        &=
        sin(arcsin(-sqrt(3)^(RR_(>=0)) / sqrt(1 + (-sqrt(3))^2)^(RR_(>=0))))
        \
        &=
        -sqrt(3)^(RR_(>=0)) / sqrt(1 + (-sqrt(3)^(RR_(>=0)))^2)^(RR_(>=0))
        \
        &=
        -sqrt(3)^(RR_(>=0)) / sqrt(1 + 3)^(RR_(>=0))
        \
        &=
        -sqrt(3)^(RR_(>=0)) / sqrt(4)^(RR_(>=0))
        \
        &=
        -sqrt(3)^(RR_(>=0)) / 2^(RR_(>=0))
      $
      
      $
        sin(arctan(y / x))
        &=
        sin(arcsin((y/x) / sqrt(1 + ((y/x))^2)^(RR_(>=0))))
        \
        &=
        (y/x) / sqrt(1 + (y/x)^2)^(RR_(>=0))
        \
        &=
        y / (x sqrt(1 + (y/x)^2)^(RR_(>=0)))
        \
        &=
        y / (-sqrt((-x)^2)^(RR_(>=0)) sqrt(1 + (y/x)^2)^(RR_(>=0)))
        \
        &=
        y / (-sqrt(x^2)^(RR_(>=0)) sqrt(1 + (y/x)^2)^(RR_(>=0)))
        \
        &=
        -y / (sqrt((x^2)(1 + (y/x)^2))^(RR_(>=0)))
        \
        &=
        -y / sqrt(x^2 + y^2)^(RR_(>=0))
      $

      $
        x < 0
        \
        -sqrt(a)^(RR_(>=0)) = x "になるような" a
        \
        sqrt(a)^(RR_(>=0)) = -x
        \
        ("自乗して"a"になる実数のうち" a > 0 "のもの") = -x
        \
        ("自乗して"a"になる実数のうち" a > 0 "のもの")^2 = (-x)^2
        \
        a = (-x)^2
        \
        x = -sqrt((-x)^2)^(RR_(>=0))
      $

      $
          cos(arctan(y / x) + pi)
          &=
          -cos(arctan(y / x))
          \
          &=
          -cos(arctan((sqrt(3)^(RR_(>=0))/2) / (-1/2)))
          \
          &=
          -cos(arctan(-sqrt(3)^(RR_(>=0))))
          \
          &=
          -cos(arcsin(-sqrt(3)^(RR_(>=0)) / sqrt(1 + (-sqrt(3)^(RR_(>=0)))^2)^(RR_(>=0))))
          \
          &=
          -sqrt(1 - (sin(arcsin(-sqrt(3)^(RR_(>=0)) / sqrt(1 + (-sqrt(3)^(RR_(>=0)))^2)^(RR_(>=0))))^2))^(RR_(>=0))
          \
          &=
          -sqrt(1 - (-sqrt(3)^(RR_(>=0)) / sqrt(1 + (-sqrt(3)^(RR_(>=0)))^2)^(RR_(>=0)))^2)^(RR_(>=0))
          \
          &=
          -sqrt(1 - (3 / (1 + (-sqrt(3)^(RR_(>=0)))^2)))^(RR_(>=0))
          \
          &=
          -sqrt(1 - (3 / (1 + 3)))^(RR_(>=0))
          \
          &=
          -sqrt(1 - (3 / 4))^(RR_(>=0))
          \
          &=
          -sqrt(1 / 4)^(RR_(>=0))
          \
          &=
          -1/2
          

      $
    ]

    2.
    $
      phi_("cartesian") o phi_("polar") (x, y)
      &=
      phi_("cartesian")(
        cases(
          [(sqrt(x^2 + y^2)^(RR_(>=0)), arctan(y/x))]_(~) & quad (x > 0),
          [(sqrt(x^2 + y^2)^(RR_(>=0)), arctan(y/x) + pi)]_(~) & quad (x < 0, y >= 0),
          [(sqrt(x^2 + y^2)^(RR_(>=0)), arctan(y/x) - pi)]_(~) & quad (x < 0, y < 0),
          [(y, pi / 2)]_(~) & quad (x = 0 and y > 0),
          [(-y, -pi / 2)]_(~) & quad (x = 0 and y < 0),
          [(0, 0)]_(~) & quad (x = 0 and y = 0)
        )
      )
      \
      &=
      cases(
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) cos(arctan(y/x)),
          sqrt(x^2 + y^2)^(RR_(>=0)) sin(arctan(y/x))
        ) & quad (x > 0),
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) cos(arctan(y/x) + pi),
          sqrt(x^2 + y^2)^(RR_(>=0)) sin(arctan(y/x) + pi)
        ) & quad (x < 0, y >= 0),
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) cos(arctan(y/x) - pi),
          sqrt(x^2 + y^2)^(RR_(>=0)) sin(arctan(y/x) - pi)
        ) & quad (x < 0, y < 0),
        (y cos(pi / 2), y sin(pi / 2)) & quad (x = 0 and y > 0),
        (-y cos(-pi / 2), -y sin(-pi / 2)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      )
      \
      &=
      cases(
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) cos(arctan(y/x)),
          sqrt(x^2 + y^2)^(RR_(>=0)) sin(arctan(y/x))
        ) & quad (x > 0),
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) (-cos(arctan(y/x))),
          sqrt(x^2 + y^2)^(RR_(>=0)) (-sin(arctan(y/x)))
        ) & quad (x < 0, y >= 0),
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) (-cos(arctan(y/x))),
          sqrt(x^2 + y^2)^(RR_(>=0)) (-sin(arctan(y/x)))
        ) & quad (x < 0, y < 0),
        (y cos(pi / 2), y sin(pi / 2)) & quad (x = 0 and y > 0),
        (-y cos(-pi / 2), -y sin(-pi / 2)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      )
      \
      &=
      cases(
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) cos(arctan(y/x)),
          sqrt(x^2 + y^2)^(RR_(>=0)) sin(arctan(y/x))
        ) & quad (x > 0),
        (
          - sqrt(x^2 + y^2)^(RR_(>=0)) cos(arctan(y/x)),
          - sqrt(x^2 + y^2)^(RR_(>=0)) sin(arctan(y/x))
        ) & quad (x < 0),
        (y cos(pi / 2), y sin(pi / 2)) & quad (x = 0 and y > 0),
        (-y cos(-pi / 2), -y sin(-pi / 2)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      )
      \
      &=
      cases(
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) 1 / sqrt(1 + (y/x)^2)^(RR_(>=0)),
          sqrt(x^2 + y^2)^(RR_(>=0)) (y/x) / sqrt(1 + (y/x)^2)^(RR_(>=0))
        ) & quad (x > 0),
        (
          - sqrt(x^2 + y^2)^(RR_(>=0)) 1 / sqrt(1 + (y/x)^2)^(RR_(>=0)),
          - sqrt(x^2 + y^2)^(RR_(>=0)) (y/x) / sqrt(1 + (y/x)^2)^(RR_(>=0))
        ) & quad (x < 0),
        (y cos(pi / 2), y sin(pi / 2)) & quad (x = 0 and y > 0),
        (-y cos(-pi / 2), -y sin(-pi / 2)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      ) quad (because #ref(<cos_arctan_sin_arctan>))
      \
      &=
      cases(
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) x / (x sqrt(1 + (y/x)^2)^(RR_(>=0))),
          sqrt(x^2 + y^2)^(RR_(>=0)) (x (y/x)) / (x sqrt(1 + (y/x)^2)^(RR_(>=0)))
        ) & quad (x > 0),
        (
          - sqrt(x^2 + y^2)^(RR_(>=0)) x / (x sqrt(1 + (y/x)^2)^(RR_(>=0))),
          - sqrt(x^2 + y^2)^(RR_(>=0)) (x (y/x)) / (x sqrt(1 + (y/x)^2)^(RR_(>=0)))
        ) & quad (x < 0),
        (y cos(pi / 2), y sin(pi / 2)) & quad (x = 0 and y > 0),
        (-y cos(-pi / 2), -y sin(-pi / 2)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      )
      \
      &=
      cases(
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) x / (sqrt(x^2)^(RR_(>=0)) sqrt(1 + (y/x)^2)^(RR_(>=0))),
          sqrt(x^2 + y^2)^(RR_(>=0)) y / (sqrt(x^2)^(RR_(>=0)) sqrt(1 + (y/x)^2)^(RR_(>=0)))
        ) & quad (x > 0),
        (
          - sqrt(x^2 + y^2)^(RR_(>=0)) x / (-sqrt((-x)^2)^(RR_(>=0)) sqrt(1 + (y/x)^2)^(RR_(>=0))),
          - sqrt(x^2 + y^2)^(RR_(>=0)) y / (-sqrt((-x)^2)^(RR_(>=0)) sqrt(1 + (y/x)^2)^(RR_(>=0)))
        ) & quad (x < 0),
        (y cos(pi / 2), y sin(pi / 2)) & quad (x = 0 and y > 0),
        (-y cos(-pi / 2), -y sin(-pi / 2)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      ) quad (because #ref(<negative_number_to_sqrt>))
      \
      &=
      cases(
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) x / (sqrt(x^2(1 + (y/x)^2))^(RR_(>=0))),
          sqrt(x^2 + y^2)^(RR_(>=0)) y / (sqrt(x^2(1 + (y/x)^2))^(RR_(>=0)))
        ) & quad (x > 0),
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) x / (sqrt((-x)^2(1 + (y/x)^2))^(RR_(>=0))),
          sqrt(x^2 + y^2)^(RR_(>=0)) y / (sqrt((-x)^2(1 + (y/x)^2))^(RR_(>=0)))
        ) & quad (x < 0),
        (y cos(pi / 2), y sin(pi / 2)) & quad (x = 0 and y > 0),
        (-y cos(-pi / 2), -y sin(-pi / 2)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      )
      \
      &=
      cases(
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) x / (sqrt(x^2 + y^2)^(RR_(>=0))),
          sqrt(x^2 + y^2)^(RR_(>=0)) y / (sqrt(x^2 + y^2)^(RR_(>=0)))
        ) & quad (x > 0),
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) x / (sqrt((-x)^2 + y^2)^(RR_(>=0))),
          sqrt(x^2 + y^2)^(RR_(>=0)) y / (sqrt((-x)^2 + y^2)^(RR_(>=0)))
        ) & quad (x < 0),
        (y cos(pi / 2), y sin(pi / 2)) & quad (x = 0 and y > 0),
        (-y cos(-pi / 2), -y sin(-pi / 2)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      )
      \
      &=
      cases(
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) x / (sqrt(x^2 + y^2)^(RR_(>=0))),
          sqrt(x^2 + y^2)^(RR_(>=0)) y / (sqrt(x^2 + y^2)^(RR_(>=0)))
        ) & quad (x > 0),
        (
          sqrt(x^2 + y^2)^(RR_(>=0)) x / (sqrt(x^2 + y^2)^(RR_(>=0))),
          sqrt(x^2 + y^2)^(RR_(>=0)) y / (sqrt(x^2 + y^2)^(RR_(>=0)))
        ) & quad (x < 0),
        (y cos(pi / 2), y sin(pi / 2)) & quad (x = 0 and y > 0),
        (-y cos(-pi / 2), -y sin(-pi / 2)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      )
      \
      &=
      cases(
        (
           x,
           y
        ) & quad (x > 0),
        (
           x,
           y
        ) & quad (x < 0),
        (y dot.op 0, y dot.op 1) & quad (x = 0 and y > 0),
        (-y dot.op 0, -y dot.op (-1)) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      )
      \
      &=
      cases(
        (
           x,
           y
        ) & quad (x > 0),
        (
           x,
           y
        ) & quad (x < 0),
        (0, y) & quad (x = 0 and y > 0),
        (0, y) & quad (x = 0 and y < 0),
        (0, 0) & quad (x = 0 and y = 0)
      )
      \
      &=
      (x, y)
    $
  ]
]
