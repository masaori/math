#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim($T_((V))"の"hat(Z), hat(Y)"への作用"$)[

  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $mu in cal(M)$について、
  
  $
    (T_((V))(hat(Z)_mu^((minus))), T_((V))(hat(Y)_mu))
    &=
    (
      hat(Z)_mu^((minus)),
      hat(Y)_mu
    )
    dot.op
    A((2 pi mu) / M)
    \
    &=
    mat(
      (
        c_1 c_2^*
        -
        s_1 s_2^* cos ((2 pi mu) / M)
      )
      hat(Z)_mu^((minus))
      +
      (
        - sqrt(-1) exp(-sqrt(-1) (2 pi mu) / M) s_2^* (c_1 cos ((2 pi mu) / M) + sqrt(-1) sin ((2 pi mu) / M) - s_1 c_2)
      )
      hat(Y)_mu,
      (
        sqrt(-1) exp(sqrt(-1) (2 pi mu) / M) s_2^* (c_1 cos ((2 pi mu) / M) - sqrt(-1) sin ((2 pi mu) / M) - s_1 c_2)
      )
      hat(Z)_mu^((minus))
      +
      (
        c_1 c_2^*
        -
        s_1 s_2^* cos ((2 pi mu) / M)
      )
      hat(Y)_mu
    )
  $

  #proof[

    (z) $T_((V))(hat(Z)_mu^((minus)))$について、

    $
    T_((V))(hat(Z)_mu^((minus)))
    &=
    T_((V_1^((plus.minus)))^(1/2))(
      T_((V_2))(
        T_((V_1^((plus.minus)))^(1/2))(
          hat(Z)_mu^((minus))
        )
      )
    )
    \
    &=
    T_((V_1^((plus.minus)))^(1/2))(
      T_((V_2))(
        cosh(K_1)
        dot
        hat(Z)_mu^((minus))
        +
        sqrt(-1)
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        sinh(K_1)
        dot
        hat(Y)_mu
      )
    )
    \
    &=
    T_((V_1^((plus.minus)))^(1/2))(
      mat(
        T_((V_2))(hat(Z)_mu^((minus))),
        T_((V_2))(hat(Y)_mu)
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
      )
    )
    \ & quad
    quad (
      because #ref(<linearity_of_T>)
    )
    \
    &=
    T_((V_1^((plus.minus)))^(1/2))(
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
      mat(
        cosh(K_1);
        sqrt(-1)
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        sinh(K_1);
      )
    )
    \ & quad
    (
      because #ref(<calc_of_TxT_hatZxhatY>)
    )
    \
    &=
    mat(
      T_((V_1^((plus.minus)))^(1/2))(hat(Z)_mu^((minus))),
      T_((V_1^((plus.minus)))^(1/2))(hat(Y)_mu),
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
    mat(
      cosh(K_1);
      sqrt(-1)
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      sinh(K_1);
    )
    \
    &=
    mat(
      hat(Z)_mu^((minus)),
      hat(Y)_mu,
    )
    mat(
      cosh(K_1),
      sqrt(-1)
      exp(
        -
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
    \ & quad quad quad
    mat(
      cosh(2 K_2^*),
      sqrt(-1)
      sinh(2 K_2^*);
      -
      sqrt(-1)
      sinh(2 K_2^*),
      cosh(2 K_2^*);
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
    )
    $

    $(y) T_((V))(hat(Y)_mu)$について、

    $
    T_((V))(hat(Y)_mu)
    &=
    T_((V_1^((plus.minus)))^(1/2))(
      T_((V_2))(
        T_((V_1^((plus.minus)))^(1/2))(
          hat(Y)_mu
        )
      )
    )
    \
    &=
    T_((V_1^((plus.minus)))^(1/2))(
      T_((V_2))(
        - sqrt(-1)
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        sinh(K_1)
        dot.op
        hat(Z)_mu^((minus))
        +
        cosh(K_1)
        dot.op
        hat(Y)_mu
      )
    )
    \
    &=
    T_((V_1^((plus.minus)))^(1/2))(
      mat(
        T_((V_2))(hat(Z)_mu^((minus))),
        T_((V_2))(hat(Y)_mu)
      )
      mat(
        - sqrt(-1)
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        sinh(K_1);
        cosh(K_1);
      )
    )
    \ & quad
    quad (
      because #ref(<linearity_of_T>)
    )
    \
    &=
    T_((V_1^((plus.minus)))^(1/2))(
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
      mat(
        - sqrt(-1)
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        sinh(K_1);
        cosh(K_1);
      )
    )
    \ & quad
    (
      because #ref(<calc_of_TxT_hatZxhatY>)
    )
    \
    &=
    mat(
      T_((V_1^((plus.minus)))^(1/2))(hat(Z)_mu^((minus))),
      T_((V_1^((plus.minus)))^(1/2))(hat(Y)_mu),
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
    mat(
      sqrt(-1)
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      sinh(K_1);
      cosh(K_1);
    )
    \
    &=
    mat(
      hat(Z)_mu^((minus)),
      hat(Y)_mu,
    )
    mat(
      cosh(K_1),
      sqrt(-1)
      exp(
        -
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
    \ & quad quad quad
    mat(
      cosh(2 K_2^*),
      sqrt(-1)
      sinh(2 K_2^*);
      -
      sqrt(-1)
      sinh(2 K_2^*),
      cosh(2 K_2^*);
    )
    mat(
      sqrt(-1)
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      sinh(K_1);
      cosh(K_1);
    )
    
    $

    よって、

    $
      mat(
        T_((V))(hat(Z)_mu^((minus))),
        T_((V))(hat(Y)_mu)
      )
      &=
      mat(
        mat(
          hat(Z)_mu^((minus)),
          hat(Y)_mu,
        )
        mat(
          cosh(K_1),
          -
          sqrt(-1)
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

        mat(
          cosh(2 K_2^*),
          sqrt(-1)
          sinh(2 K_2^*);
          -
          sqrt(-1)
          sinh(2 K_2^*),
          cosh(2 K_2^*);
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
          cosh(K_1),
           -
          sqrt(-1)
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

        mat(
          cosh(2 K_2^*),
          sqrt(-1)
          sinh(2 K_2^*);
          -
          sqrt(-1)
          sinh(2 K_2^*),
          cosh(2 K_2^*);
        )
        mat(
           -
          sqrt(-1)
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
        mat(
          cosh(K_1),
          -
          sqrt(-1)
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
        mat(
          cosh(2 K_2^*),
          sqrt(-1)
          sinh(2 K_2^*);
          -
          sqrt(-1)
          sinh(2 K_2^*),
          cosh(2 K_2^*);
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
          cosh(K_1),
          sqrt(-1)
          exp(
            -
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

        mat(
          cosh(2 K_2^*),
          sqrt(-1)
          sinh(2 K_2^*);
          -
          sqrt(-1)
          sinh(2 K_2^*),
          cosh(2 K_2^*);
        )
        mat(
           -
          sqrt(-1)
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
        -
        sqrt(-1)
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
        cosh(K_1)
        ;
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
      mat(
        cosh(K_1),
        -
        sqrt(-1)
        exp(
          sqrt(-1)
          (2 pi mu) / M
        )
        sinh(K_1)
        ;
        sqrt(-1)
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        sinh(K_1),
        cosh(K_1)
        ;
      )
      


    $

    TODO: mathematicaに計算させたらステートメントは正しいことはわかったので、一旦具体の計算は飛ばす (0426)

  ]
]<T_V_hatZ_hatY>
