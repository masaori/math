#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim(none)[
  $
    (
      T_((V_1^((plus.minus)))^(1/2)) times T_((V_1^((plus.minus)))^(1/2))
    )
    (
      hat(Z)_mu^((minus)),
      hat(Y)_mu
    )
    &=
    mat(
      mat(
        hat(Z)_mu^((minus)),
        hat(Y)_mu,
      )
      mat(
        cosh(K_1);
        sqrt(-1)
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        sinh(K_1);
      ),
      mat(
        hat(Z)_mu^((minus)),
        hat(Y)_mu,
      )
      mat(
        - sqrt(-1)
        exp(
          sqrt(-1)
          (2 pi mu) / M
        )
        sinh(K_1);
        cosh(K_1);
      )
    )
    \
    &=
    mat(
      hat(Z)_mu^((minus)),
      hat(Y)_mu,
    )
    mat(
      cosh(K_1),
      - sqrt(-1)
      exp(
        sqrt(-1)
        (2 pi mu) / M
      )
      sinh(K_1);
      sqrt(-1)
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      sinh(K_1),
      cosh(K_1);
    )
    \
    (
      T_((V_2)) times T_((V_2))
    )
    (
      hat(Z)_mu^((minus)),
      hat(Y)_mu
    )
    &=
    mat(
      mat(
        hat(Z)_mu^((minus)),
        hat(Y)_mu,
      )
      mat(
        cosh(2 K_2^*);
        - sqrt(-1)
        sinh(2 K_2^*);
      ),
      mat(
        hat(Z)_mu^((minus)),
        hat(Y)_mu,
      )
      mat(
        sqrt(-1)
        sinh(2 K_2^*);
        cosh(2 K_2^*);
      )
    )
    \
    &=
    mat(
      hat(Z)_mu^((minus)),
      hat(Y)_mu,
    )
    mat(
      cosh(2 K_2^*),
      sqrt(-1)
      sinh(2 K_2^*);
      -
      sqrt(-1)
      sinh(2 K_2^*),
      cosh(2 K_2^*);
    )
  $
]<calc_of_TxT_hatZxhatY>
