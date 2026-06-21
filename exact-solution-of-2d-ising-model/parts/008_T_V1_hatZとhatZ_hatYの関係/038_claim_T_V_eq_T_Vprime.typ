#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$T_((V)) = T_((V'))$])[
  $
    T_((V)) = T_((V'))
  $

  すなわち、任意の $x in "Mat"(2, CC)^(times.o M)$ に対して $T_((V))(x) = T_((V'))(x)$ である。

  #proof[
    === Step 1: $T_((V))$ と $T_((V'))$ は単位的環準同型かつ線型である

    $#ref(<def_T_V>)$ より、任意の $X in "Mat"(2, CC)^(times.o M)$ について

    $
      T_((V))(X)
      =
      T_((V_1^((plus.minus)))^(1/2))(
        T_((V_2))(
          T_((V_1^((plus.minus)))^(1/2))(
            X
          )
        )
      )
    $

    である。すなわち $T_((V)) = T_((V_1^((plus.minus)))^(1/2)) compose T_((V_2)) compose T_((V_1^((plus.minus)))^(1/2))$ である。各因子 $T_((V_1^((plus.minus)))^(1/2)), T_((V_2))$ は $T_g$（$#ref(<def_T_g>)$）の形であり、$#ref(<def_T_V>)$ で $T_g$ が用いられている時点で $(V_1^((plus.minus)))^(1/2), V_2$ は可逆である。

    $
      V := (V_1^((plus.minus)))^(1/2) V_2 (V_1^((plus.minus)))^(1/2)
    $

    とおく。可逆行列の積は可逆だから $V$ は可逆である。$#ref(<conjugation_is_ring_homomorphism>)$ の合成則を2回適用すると、

    $
      T_((V))
      &=
      T_((V_1^((plus.minus)))^(1/2)) compose T_((V_2)) compose T_((V_1^((plus.minus)))^(1/2))
      quad (because #ref(<def_T_V>))
      \
      &=
      T_((V_1^((plus.minus)))^(1/2) V_2) compose T_((V_1^((plus.minus)))^(1/2))
      quad (because #ref(<conjugation_is_ring_homomorphism>))
      \
      &=
      T_((V_1^((plus.minus)))^(1/2) V_2 (V_1^((plus.minus)))^(1/2))
      quad (because #ref(<conjugation_is_ring_homomorphism>))
      \
      &=
      T_(V)
    $

    が成り立つ。よって $T_((V)) = T_(V)$ であり、$V$ は可逆だから $#ref(<conjugation_is_ring_homomorphism>)$ より $T_((V))$ は乗法的かつ単位的（$T_((V))(I) = I$）であり、$#ref(<mat_conj>)$ より線型である。

    $T_((V'))$ は $T_g$（$#ref(<def_T_g>)$）の $g = V'$ の場合であり、$#ref(<def_Vprime>)$ より $V'$ は可逆である。したがって $#ref(<conjugation_is_ring_homomorphism>)$ より $T_((V'))$ は乗法的かつ単位的であり、$#ref(<mat_conj>)$ より線型である。

    === Step 2: $T_((V))$ と $T_((V'))$ は各 $Z_m, Y_m$ 上で一致する

    各 $m in {1, dots, M}$ について、$#ref(<recover_Z_Y_from_hatZ_hatY>)$ より $c_m := cases(-1 "if" m = 1, 1 "if" m != 1)$ として

    $
      Z_m
      =
      c_m/M
      sum_(mu=1)^M (
        hat(Z)_mu^((minus))
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
      ),
      quad
      Y_m
      =
      1/M
      sum_(mu=1)^M (
        hat(Y)_mu
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
      )
    $

    が成り立つ。$T_((V)), T_((V'))$ は線型（Step 1）であり、$#ref(<T_V_eq_T_Vprime_on_hatZ_hatY>)$ より各 $mu in cal(M)$ で $T_((V))(hat(Z)_mu^((minus))) = T_((V'))(hat(Z)_mu^((minus)))$ かつ $T_((V))(hat(Y)_mu) = T_((V'))(hat(Y)_mu)$ であるから、

    $
      T_((V))(Z_m)
      &=
      T_((V))(
        c_m/M
        sum_(mu=1)^M (
          hat(Z)_mu^((minus))
          exp(
            sqrt(-1)
            m
            (2 pi mu) / M
          )
        )
      )
      quad (because #ref(<recover_Z_Y_from_hatZ_hatY>))
      \
      &=
      c_m/M
      sum_(mu=1)^M (
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
        T_((V))(hat(Z)_mu^((minus)))
      )
      quad (because T_((V)) "の線型性")
      \
      &=
      c_m/M
      sum_(mu=1)^M (
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
        T_((V'))(hat(Z)_mu^((minus)))
      )
      quad (because #ref(<T_V_eq_T_Vprime_on_hatZ_hatY>))
      \
      &=
      T_((V'))(
        c_m/M
        sum_(mu=1)^M (
          hat(Z)_mu^((minus))
          exp(
            sqrt(-1)
            m
            (2 pi mu) / M
          )
        )
      )
      quad (because T_((V')) "の線型性")
      \
      &=
      T_((V'))(Z_m)
      quad (because #ref(<recover_Z_Y_from_hatZ_hatY>))
    $

    が成り立つ。同様に、

    $
      T_((V))(Y_m)
      &=
      T_((V))(
        1/M
        sum_(mu=1)^M (
          hat(Y)_mu
          exp(
            sqrt(-1)
            m
            (2 pi mu) / M
          )
        )
      )
      quad (because #ref(<recover_Z_Y_from_hatZ_hatY>))
      \
      &=
      1/M
      sum_(mu=1)^M (
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
        T_((V))(hat(Y)_mu)
      )
      quad (because T_((V)) "の線型性")
      \
      &=
      1/M
      sum_(mu=1)^M (
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
        T_((V'))(hat(Y)_mu)
      )
      quad (because #ref(<T_V_eq_T_Vprime_on_hatZ_hatY>))
      \
      &=
      T_((V'))(
        1/M
        sum_(mu=1)^M (
          hat(Y)_mu
          exp(
            sqrt(-1)
            m
            (2 pi mu) / M
          )
        )
      )
      quad (because T_((V')) "の線型性")
      \
      &=
      T_((V'))(Y_m)
      quad (because #ref(<recover_Z_Y_from_hatZ_hatY>))
    $

    が成り立つ。よってすべての $m in {1, dots, M}$ について

    $
      T_((V))(Z_m) = T_((V'))(Z_m),
      quad
      T_((V))(Y_m) = T_((V'))(Y_m)
    $

    である。

    === Step 3: 一致する元の集合は部分多元環をなす

    集合

    $
      cal(E) := { x in "Mat"(2, CC)^(times.o M) : T_((V))(x) = T_((V'))(x) }
    $

    を考える。$cal(E)$ が $"Mat"(2, CC)^(times.o M)$ の $CC$-部分多元環（$CC$-線型結合と積について閉じ、単位元を含む）であることを示す。

    (加法・スカラー倍について閉じる) $x, y in cal(E)$ と $alpha, beta in CC$ について、$T_((V)), T_((V'))$ は線型（Step 1）であるから

    $
      T_((V))(alpha x + beta y)
      &=
      alpha T_((V))(x) + beta T_((V))(y)
      quad (because T_((V)) "の線型性")
      \
      &=
      alpha T_((V'))(x) + beta T_((V'))(y)
      quad (because x, y in cal(E))
      \
      &=
      T_((V'))(alpha x + beta y)
      quad (because T_((V')) "の線型性")
    $

    ゆえ $alpha x + beta y in cal(E)$ である。

    (積について閉じる) $x, y in cal(E)$ について、$T_((V)), T_((V'))$ は乗法的（Step 1）であるから

    $
      T_((V))(x y)
      &=
      T_((V))(x) T_((V))(y)
      quad (because T_((V)) "の乗法性、" #ref(<conjugation_is_ring_homomorphism>))
      \
      &=
      T_((V'))(x) T_((V'))(y)
      quad (because x, y in cal(E))
      \
      &=
      T_((V'))(x y)
      quad (because T_((V')) "の乗法性、" #ref(<conjugation_is_ring_homomorphism>))
    $

    ゆえ $x y in cal(E)$ である。

    (単位元を含む) $T_((V))(I) = I = T_((V'))(I)$（Step 1 の単位性）より $I in cal(E)$ である。

    以上より $cal(E)$ は単位元を含み、$CC$-線型結合と積について閉じるから、$"Mat"(2, CC)^(times.o M)$ の $CC$-部分多元環である。

    === Step 4: 結論

    Step 2 より $Z_1, dots, Z_M, Y_1, dots, Y_M in cal(E)$ である。$cal(E)$ は $S := { Z_1, dots, Z_M, Y_1, dots, Y_M }$ を含む $CC$-部分多元環（Step 3）であるから、$S$ を含む最小の $CC$-部分多元環 $cal(A)$ について $cal(A) subset.eq cal(E)$ である。$#ref(<Z_Y_generate_algebra>)$ より $cal(A) = "Mat"(2, CC)^(times.o M)$ であるから、

    $
      "Mat"(2, CC)^(times.o M)
      =
      cal(A)
      subset.eq
      cal(E)
      subset.eq
      "Mat"(2, CC)^(times.o M)
      quad (because #ref(<Z_Y_generate_algebra>))
    $

    すなわち $cal(E) = "Mat"(2, CC)^(times.o M)$ である。これは、任意の $x in "Mat"(2, CC)^(times.o M)$ について $T_((V))(x) = T_((V'))(x)$、すなわち

    $
      T_((V)) = T_((V'))
    $

    が成り立つことを意味する。

    $qed$
  ]
]<T_V_eq_T_Vprime>
