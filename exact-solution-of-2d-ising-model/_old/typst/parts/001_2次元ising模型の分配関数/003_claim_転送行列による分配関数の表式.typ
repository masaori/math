#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim("転送行列による分配関数の表式")[
  $
    Z(J, J') = tr((V_1 V_2)^(M))
  $

  #proof[
    $mu ,mu': {1, dots, N} -> {-1, 1}$に対して、
    $
      (V_1 V_2)_(mu, mu')
      &=
      sum_(nu: {1, dots, N} -> {-1, 1}) (
        (V_1)_(mu, nu)
        (V_2)_(nu, mu')
      )
      \
      &=
      sum_(nu: {1, dots, N} -> {-1, 1}) (
        delta_(mu = nu)
        exp(
          sum_(
            j &in {1, ..., N}
          ) (
            J mu(j) mu(j + 1)
          )
        )
        exp(
          sum_(
            j &in {1, ..., N}
          ) (
            J' nu(j) mu'(j)
          )
        )
      )
      \
      &=
      exp(
        sum_(
          j &in {1, ..., N}
        ) (
          J mu(j) mu(j + 1)
        )
      )
      exp(
        sum_(
          j &in {1, ..., N}
        ) (
          J' mu(j) mu'(j)
        )
      )
      \
      &=
      exp(
        sum_(
          j &in {1, ..., N}
        ) (
          J mu(j) mu(j + 1)
        )
        +
        sum_(
          j &in {1, ..., N}
        ) (
          J' mu(j) mu'(j)
        )
      )
      \
      &=
      exp(
        sum_(
          j &in {1, ..., N}
        ) (
          J mu(j) mu(j + 1)
          +
          J' mu(j) mu'(j)
        )
      )
    $


  ]
]
