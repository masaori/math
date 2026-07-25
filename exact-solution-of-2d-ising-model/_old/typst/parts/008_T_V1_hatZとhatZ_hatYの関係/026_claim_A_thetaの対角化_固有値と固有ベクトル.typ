#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$A(theta)$の対角化])[

  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $mu in cal(M)$について、

  $theta_(mu) := (2 pi mu) / M$ とおくとき、

  $A(theta_(mu))$の固有値$lambda_(plus.minus, mu) in RR$は
  $
    lambda_(plus, mu)
    &:=
    (
      gamma_1(theta_(mu))
    )
    plus
    sqrt(
      -
      (
        gamma_2(theta_(mu))
      )
      (
        gamma_2(-theta_(mu))
      )
    )
    \
    lambda_(minus, mu)
    &:=
    (
      gamma_1(theta_(mu))
    )
    minus
    sqrt(
      -
      (
        gamma_2(theta_(mu))
      )
      (
        gamma_2(-theta_(mu))
      )
    )
  $

  で、$lambda_(plus, mu)$に対応する固有ベクトル $v_(plus, mu)$、$lambda_(minus, mu)$に対応する固有ベクトル $v_(minus, mu) in CC^2 without { mat(0; 0) }$は

  1) $gamma_2(theta_mu) = 0$ のとき、
  $
    v_(mu) "は任意のベクトル" in CC^2 without { mat(0; 0) }
  $

  2) $gamma_2(theta_mu) eq.not 0$ のとき、

  $c in CC^(times)$ として、

  $
    v_(mu)
    :=
    c
    mat(
      plus.minus
      sqrt(
        -1
      )
      sqrt(
        gamma_2(theta_(mu))
        gamma_2(-theta_(mu))
      );
      gamma_2(-theta_(mu))
    )
    in CC^2 without { mat(0; 0) }
  $
  
  である

  #proof[
    $
      A(theta_(mu))
      :&=
      mat(
        c_1 c_2^*
        -
        s_1 s_2^* cos theta_(mu),
        sqrt(-1) e^(sqrt(-1) theta_(mu)) s_2^* (c_1 cos theta_(mu) - sqrt(-1) sin theta_(mu) - s_1 c_2);
        - sqrt(-1) e^(-sqrt(-1) theta_(mu)) s_2^* (c_1 cos theta_(mu) + sqrt(-1) sin theta_(mu) - s_1 c_2),
        c_1 c_2^*
        -
        s_1 s_2^* cos theta_(mu);
      )   
    $

    $gamma_1(theta_(mu)) := c_1 c_2^* - s_1 s_2^* cos theta_(mu)$
    
    $gamma_2(theta_(mu)) := sqrt(-1) e^(sqrt(-1) theta_(mu)) s_2^* (c_1 cos theta_(mu) - i sin theta_(mu) - s_1 c_2)$

    とおくと、

    $
      A(theta_(mu))
      =
      mat(
        gamma_1(theta_(mu)),
        gamma_2(theta_(mu));
        - gamma_2(-theta_(mu)),
        gamma_1(theta_(mu));
      )
    $

    とかける。
    
    であるから、$A(theta_(mu))$の固有方程式は$lambda in CC$として、

    $
      abs(A(theta_(mu)) - lambda I) &= 0
    $

    $
      "(左辺)"
      &=
      mat(
        delim: "|",
        gamma_1(theta_(mu)) - lambda,
        gamma_2(theta_(mu));
        - gamma_2(-theta_(mu)),
        gamma_1(theta_(mu)) - lambda;
      )
      \
      &=
      (
        gamma_1(theta_(mu)) - lambda
      )
      (
        gamma_1(theta_(mu)) - lambda
      )
      -
      (
        gamma_2(theta_(mu))
      )
      (
        -gamma_2(-theta_(mu))
      )
      \
      &=
      (
        gamma_1(theta_(mu))
      )^2
      -
      2
      lambda
      (
        gamma_1(theta_(mu))
      )
      +
      lambda^2
      +
      (
        gamma_2(theta_(mu))
      )
      (
        gamma_2(-theta_(mu))
      )
    $

    $
      lambda^2
      -
      2
      lambda
      (
        gamma_1(theta_(mu))
      )
      +
      (
        gamma_1(theta_(mu))
      )^2
      +
      (
        gamma_2(theta_(mu))
      )
      (
        gamma_2(-theta_(mu))
      )
      =
      0
    $

    より、

    $
      lambda
      &=
      (
        2
        (
          gamma_1(theta_(mu))
        )
        plus.minus
        sqrt(
          (
            -
            2
            (
              gamma_1(theta_(mu))
            )
          )^2
          -
          4
          (
            (
              gamma_1(theta_(mu))
            )^2
            +
            (
              gamma_2(theta_(mu))
            )
            (
              gamma_2(-theta_(mu))
            )
          )
        )
      )
      /
      2
      \
      &=
      (
        2
        (
          gamma_1(theta_(mu))
        )
        plus.minus
        sqrt(
          4
          (
            (
              gamma_1(theta_(mu))
            )
          )^2
          -
          4
          (
            (
              gamma_1(theta_(mu))
            )^2
            +
            (
              gamma_2(theta_(mu))
            )
            (
              gamma_2(-theta_(mu))
            )
          )
        )
      )
      /
      2
      \
      &=
      (
        2
        (
          gamma_1(theta_(mu))
        )
        plus.minus
        2
        sqrt(
          (
            (
              gamma_1(theta_(mu))
            )
          )^2
          -
          (
            (
              gamma_1(theta_(mu))
            )^2
            +
            (
              gamma_2(theta_(mu))
            )
            (
              gamma_2(-theta_(mu))
            )
          )
        )
      )
      /
      2
      \
      &=
      (
        gamma_1(theta_(mu))
      )
      plus.minus
      sqrt(
        -
        (
          gamma_2(theta_(mu))
        )
        (
          gamma_2(-theta_(mu))
        )
      )
    $

    対応する固有ベクトルは、$v := mat(v_1; v_2) in CC^2$ として

    $
      A(theta_(mu)) v &= lambda v
      \
      mat(
        gamma_1(theta_(mu)),
        gamma_2(theta_(mu));
        - gamma_2(-theta_(mu)),
        gamma_1(theta_(mu));
      )
      v
      &=
      lambda
      v
      \
      mat(
        gamma_1(theta_(mu)),
        gamma_2(theta_(mu));
        - gamma_2(-theta_(mu)),
        gamma_1(theta_(mu));
      )
      v
      &=
      (
        (
          gamma_1(theta_(mu))
        )
        plus.minus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        )
      )
      v
      \
      mat(
        gamma_1(theta_(mu)),
        gamma_2(theta_(mu));
        - gamma_2(-theta_(mu)),
        gamma_1(theta_(mu));
      )
      mat(v_1; v_2)
      &=
      (
        (
          gamma_1(theta_(mu))
        )
        plus.minus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        )
      )
      mat(v_1; v_2)
      \
      I
      dot.c
      mat(
        gamma_1(theta_(mu)),
        gamma_2(theta_(mu));
        - gamma_2(-theta_(mu)),
        gamma_1(theta_(mu));
      )
      mat(v_1; v_2)
      &=
      I
      dot.c
      (
        (
          gamma_1(theta_(mu))
        )
        plus.minus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        )
      )
      mat(v_1; v_2)
      \
      mat(
        gamma_1(theta_(mu)),
        gamma_2(theta_(mu));
        - gamma_2(-theta_(mu)),
        gamma_1(theta_(mu));
      )
      mat(v_1; v_2)
      &=
      mat(
        (
          gamma_1(theta_(mu))
        )
        plus.minus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        ),
        0;
        0,
        (
          gamma_1(theta_(mu))
        )
        plus.minus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        )
      )
      mat(v_1; v_2)
      \
      mat(
        gamma_1(theta_(mu))
        -
        (
          (
            gamma_1(theta_(mu))
          )
          plus.minus
          sqrt(
            -
            (
              gamma_2(theta_(mu))
            )
            (
              gamma_2(-theta_(mu))
            )
          )
        ),
        gamma_2(theta_(mu));
        - gamma_2(-theta_(mu)),
        gamma_1(theta_(mu))
        -
        (
          (
            gamma_1(theta_(mu))
          )
          plus.minus
          sqrt(
            -
            (
              gamma_2(theta_(mu))
            )
            (
              gamma_2(-theta_(mu))
            )
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      \
      mat(
        minus.plus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        ),
        gamma_2(theta_(mu));
        - gamma_2(-theta_(mu)),
        minus.plus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      quad
      dots.c
      (*)
    $

    1) $gamma_2(theta_mu) = 0$ のとき、

    // このような場合が起きるK_1,K_2の組み合わせがありうるかを検討する
    // (追記)どうやら$gamma_2(theta_mu)=0$の時は常に$gamma_1(theta_mu)=1$になるっぽい↓ので、この分岐は不要そう
    // ############################################
    // # 1. 変数と「K₂ の制約」を設定
    // ############################################
    // K1 = var('K1')                        # K₁ はシンボル
    // K2 = 1/2 * acosh(coth(2*K1))          # K₂ = ½ acosh(coth(2K₁))

    // ############################################
    // # 2. 双対結合 ( * は単なる添字 )
    // ############################################
    // K1_star = -1/2 * log(tanh(K1))
    // K2_star = -1/2 * log(tanh(K2))

    // ############################################
    // # 3. c_i, s_i と c_i★, s_i★
    // ############################################
    // c1, s1       = cosh(2*K1), sinh(2*K1)
    // c2_star      = cosh(2*K2_star)
    // s2_star      = sinh(2*K2_star)

    // ############################################
    // # 4. θ_μ と目的の式
    // #    条件 μ = M ⇒ θ_μ = 2π, したがって cos θ_μ = 1
    // ############################################
    // expr = (c1*c2_star - s1*s2_star)      # cos(2*pi) = 1 を直接代入

    // ############################################
    // # 5. 簡約・表示
    // ############################################
    // expr_simplified = expr.simplify_full()   # 結果は 1 になる
    // show(expr_simplified)

    // ############################################
    // # 6. 数値テスト（任意の K₁ で 1 になるか確認）
    // ############################################
    // for k in (0.2, 0.7, 1.3, 100):
    // print("K1 =", k, "→", expr_simplified.subs(K1=k).n())

    $(*)$は、

    $
      mat(
        0, 0;
        0, 0;
      )
      mat(v_1; v_2)
      &=
      0
    $

    より、$v$は任意の値をとる

    （この時 $A(theta_mu) = I$（$2 times 2$ 単位行列）となる。証明は $#ref(<A_theta_is_identity_when_gamma2_zero>)$ を参照）

    2) $gamma_2(theta_mu) eq.not 0$ のとき、

    $sqrt(
      -
      (
        gamma_2(theta_(mu))
      )
      (
        gamma_2(-theta_(mu))
      )
    ) eq.not 0$
    だから、
    $(*)$は、
    $
      mat(
        minus.plus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        )
        (
          (gamma_2(-theta_(mu)))
          /
          (
            minus.plus
            sqrt(
              -
              (
                gamma_2(theta_(mu))
              )
              (
                gamma_2(-theta_(mu))
              )
            )
          )
        ),
        gamma_2(theta_(mu))
        (
          (gamma_2(-theta_(mu)))
          /
          (
            minus.plus
            sqrt(
              -
              (
                gamma_2(theta_(mu))
              )
              (
                gamma_2(-theta_(mu))
              )
            )
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        minus.plus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      quad
      (because "行列の基本変形")
      \
      mat(
        gamma_2(-theta_(mu)),
        (
          (
            (gamma_2(theta_(mu)))
            (gamma_2(-theta_(mu)))
          )
          /
          (
            minus.plus
            sqrt(
              -
              (
                gamma_2(theta_(mu))
              )
              (
                gamma_2(-theta_(mu))
              )
            )
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        minus.plus
        sqrt(
          -
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      \
      mat(
        gamma_2(-theta_(mu)),
        (
          (
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
          )
          /
          (
            minus.plus
            sqrt(
              -1_(CC)
              dot.op
              (
                gamma_2(theta_(mu))
              )
              (
                gamma_2(-theta_(mu))
              )
            )
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        minus.plus
        sqrt(
          -1_(CC)
          dot.op
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      \
      mat(
        gamma_2(-theta_(mu)),
        (
          (
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
          )
          /
          (
            minus.plus
            (
              -
              sqrt(
                -1_(CC)
              )
              sqrt(
                (
                  gamma_2(theta_(mu))
                )
                (
                  gamma_2(-theta_(mu))
                )
              )
            )
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        minus.plus
        (
          -
          sqrt(
            -1_(CC)
          )
          sqrt(
            (
              gamma_2(theta_(mu))
            )
            (
              gamma_2(-theta_(mu))
            )
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      quad
      (
        because
        arg^([0, 2pi))(-1)_(CC)
        +
        arg^([0, 2pi))((
          gamma_2(theta_(mu))
        )
        (
          gamma_2(-theta_(mu))
        ))
        =
        2pi
        "かつ"
        #ref(<condition_of_commutativity_of_sqrt_and_product>)
      )
      \
      mat(
        gamma_2(-theta_(mu)),
        (
          (
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
          )
          /
          (
            plus.minus
            sqrt(
              -1_(CC)
            )
            sqrt(
              (
                gamma_2(theta_(mu))
              )
              (
                gamma_2(-theta_(mu))
              )
            )
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        plus.minus
        sqrt(
          -1_(CC)
        )
        sqrt(
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      \
      mat(
        gamma_2(-theta_(mu)),
        (
          (
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
          )
          /
                    (
            plus.minus
            sqrt(
              -1_(CC)
            )
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        plus.minus
        sqrt(
          -1_(CC)
        )
        sqrt(
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      quad
      (
        because "約分"
      )
      \
      mat(
        gamma_2(-theta_(mu)),
        plus.minus
        (
          (
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
          )
          (
            (
              1_(CC)
            )
            /
            (
              sqrt(
                -1_(CC)
              )
            )
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        plus.minus
        sqrt(
          -1_(CC)
        )
        sqrt(
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      \
      mat(
        gamma_2(-theta_(mu)),
        plus.minus
        (
          (
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
          )
          (
            -
            sqrt(
              1_(CC)
              /
              (
                -1_(CC)
              )
            )
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        plus.minus
        sqrt(
          -1_(CC)
        )
        sqrt(
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      quad
      (
        because #ref(<inverse_of_sqrt_cc>) "かつ" 0 < arg^([0, 2pi))(-1_(CC)) = pi < 2pi
      )
      \
      mat(
        gamma_2(-theta_(mu)),
        minus.plus
        (
          (
            sqrt(
              (
                gamma_2(theta_(mu))
                gamma_2(-theta_(mu))
              )
            )
          )
          (
            sqrt(
              - 1_(CC)
            )
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        plus.minus
        sqrt(
          -1_(CC)
        )
        sqrt(
          (
            gamma_2(theta_(mu))
          )
          (
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
      \
      mat(
        gamma_2(-theta_(mu)),
        minus.plus
        sqrt(
          - 1
        )
        sqrt(
          (
            gamma_2(theta_(mu))
            gamma_2(-theta_(mu))
          )
        )
        ;
        - gamma_2(-theta_(mu)),
        plus.minus
        sqrt(
          - 1
        )
        sqrt(
          (
            gamma_2(theta_(mu))
            gamma_2(-theta_(mu))
          )
        );
      )
      mat(v_1; v_2)
      &=
      0
    $

    よって、$c in CC^(times)$として、

    $
      v
      &= 
      c
      mat(
        plus.minus
        sqrt(
          -1
        )
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
        );
        gamma_2(-theta_(mu))
      )
    $
  ]
]<eigenvector_of_A_theta>
