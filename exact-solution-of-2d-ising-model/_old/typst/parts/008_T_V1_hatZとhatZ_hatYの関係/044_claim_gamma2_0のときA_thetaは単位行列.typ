#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$gamma_2(theta_mu) = 0$ のとき $A(theta_mu) = I$])[
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $mu in cal(M)$ が $gamma_2(theta_mu) = 0$ を満たすとき、

  $
    A(theta_mu) = I
    quad ("2次単位行列")
  $

  #proof[
    $gamma_2(theta_mu) = 0$ を満たす $mu in cal(M)$ を固定する。

    === Step 1: $gamma_2(-theta_mu) = 0$

    $#ref(<relation_of_gamma_2>)$ より $gamma_2(-theta_mu) = -overline(gamma_2(theta_mu))$ であるから、

    $
      gamma_2(-theta_mu)
      &=
      -overline(gamma_2(theta_mu))
      quad (because #ref(<relation_of_gamma_2>))
      \
      &=
      -overline(0)
      quad (because gamma_2(theta_mu) = 0)
      \
      &=
      0
    $

    である。

    === Step 2: $gamma_1(theta_mu) = 1$

    $#ref(<det_A_theta>)$ より $gamma_1(theta_mu)^2 + gamma_2(theta_mu) gamma_2(-theta_mu) = 1$ であるから、

    $
      gamma_1(theta_mu)^2
      &=
      1 - gamma_2(theta_mu) gamma_2(-theta_mu)
      \
      &=
      1 - 0 dot.op 0
      quad (because gamma_2(theta_mu) = 0 "、Step 1")
      \
      &=
      1
    $

    である。$#ref(<gamma1_geq_1>)$ より $gamma_1(theta_mu) >= 1 > 0$ であるから、$gamma_1(theta_mu)^2 = 1$ と合わせて $gamma_1(theta_mu) = 1$ を得る。

    === Step 3: $A(theta_mu) = I$

    $#ref(<det_A_theta>)$ の証明中で確認したとおり、$A(theta_mu)$ は $gamma_1(theta_mu), gamma_2(theta_mu), gamma_2(-theta_mu)$ を用いて

    $
      A(theta_mu)
      =
      mat(
        gamma_1(theta_mu),
        gamma_2(theta_mu);
        - gamma_2(-theta_mu),
        gamma_1(theta_mu);
      )
    $

    と表される（$#ref(<def_A_theta>)$ の各成分の $gamma_1, gamma_2$ による書き換え）。Step 1, Step 2 の結果を代入すると、

    $
      A(theta_mu)
      &=
      mat(
        gamma_1(theta_mu),
        gamma_2(theta_mu);
        - gamma_2(-theta_mu),
        gamma_1(theta_mu);
      )
      \
      &=
      mat(
        1,
        0;
        -0,
        1;
      )
      quad (because gamma_1(theta_mu) = 1 "（Step 2）、" gamma_2(theta_mu) = 0 "、" gamma_2(-theta_mu) = 0 "（Step 1）")
      \
      &=
      mat(
        1,
        0;
        0,
        1;
      )
      \
      &=
      I
    $

    である。

    $qed$
  ]
]<A_theta_is_identity_when_gamma2_zero>
