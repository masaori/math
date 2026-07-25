#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition("転送行列")[
  $V_1, V_2 in "Mat"(2^N, CC)$を以下のように定める。

  $mu, mu': {1, dots, N} -> {-1, 1}$を添え字として用いて、

  $
    (V_1)_(mu, mu')
    :&=
    delta_(mu = mu')
    exp(
      sum_(
        j &in {1, ..., N}
      ) (
        J mu(j) mu(j + 1)
      )
    )
    \
    (V_2)_(mu, mu')
    :&=
    exp(
      sum_(
        j &in {1, ..., N}
      ) (
        J' mu(j) mu'(j)
      )
    )
  $

  #note[

    $V_1$は、格子のある行内の横の相互作用を表している

    $V_2$は、それを縦に積み上げた時の隣り合う行同士の相互作用を表している

    また、$V_1$は対角行列になっている
  ]
]
