#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$a(theta_mu)$])[
  $gamma_2(theta_mu) eq.not 0$の時、

  $
    alpha_1 :&= tanh K_1 tanh K_2^*
    \
    alpha_2 :&= (tanh K_1)^(-1) tanh K_2^*
    \
    a(theta_mu)
    :&=
    sqrt(
      (
        (1 - alpha_1 e^(sqrt(-1) theta_mu))
      )
      /
      (
        (1 - alpha_1 e^(-sqrt(-1) theta_mu))
      )
      dot.c
      (
        (1 - alpha_2^(-1) e^(sqrt(-1) theta_mu))
      )
      /
      (
        (1 - alpha_2^(-1) e^(-sqrt(-1) theta_mu))
      )
    )
  $

  と定めるとき、

  $
    a(theta_mu)
    &=
    sqrt(
      (gamma_2(theta_(mu)))
      /
      (gamma_2(-theta_(mu)))
    )
    \
    &=
    cases(
      (
        (
          sqrt(
            gamma_2(theta_(mu))
            gamma_2(-theta_(mu))
          )
        )
        /
        (
          gamma_2(-theta_(mu))
        )
      )
      &quad (0 <= arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi/2 or (3pi)/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
      -
      (
        (
          sqrt(
            gamma_2(theta_(mu))
            gamma_2(-theta_(mu))
          )
        )
        /
        (
          gamma_2(-theta_(mu))
        )
      )
      &quad (pi/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= (3pi)/2),
    )
  $

  #proof[
    $mu in cal(M)$ について、

    == Part A: $sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) dot.op (gamma_2(-theta_(mu)))^(-1)$ と $sqrt(gamma_2(theta_(mu)) dot.op (gamma_2(-theta_(mu)))^(-1))$ の関係

    === Step 1: $arg^([0, 2pi))((gamma_2(-theta_(mu)))^2)$の計算

    $
      arg^([0, 2pi))((gamma_2(-theta_(mu)))^2)
      =
      cases(
        2 arg^([0, 2pi))(gamma_2(-theta_(mu))) & quad (0 <= arg^([0, 2pi))(gamma_2(-theta_(mu))) < pi),
        2 arg^([0, 2pi))(gamma_2(-theta_(mu))) - 2pi & quad (pi <= arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
      )
      quad
      (because #ref(<range_of_args_of_square_of_complex_numbers>))
    $

    特に、

    $
      arg^([0, 2pi))((gamma_2(-theta_(mu)))^2) = 0 quad <==> quad arg^([0, 2pi))(gamma_2(-theta_(mu))) in {0, pi}
    $

    === Step 2: $arg^([0, 2pi))(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))$

    $#ref(<arg_of_gamma_2_mu>)$ より、

    $
      arg^([0, 2pi))(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) = pi
    $

    === Step 3: $arg^([0, 2pi))(1/((gamma_2(-theta_(mu)))^2))$の計算

    $#ref(<range_of_args_of_reciprocal_of_complex_numbers>)$ より、

    $
      arg^([0, 2pi))(
        1/((gamma_2(-theta_(mu)))^2)
      )
      &=
      cases(
        0 & quad (arg^([0, 2pi))((gamma_2(-theta_(mu)))^2) = 0),
        2pi - arg^([0, 2pi))((gamma_2(-theta_(mu)))^2) & quad (0 < arg^([0, 2pi))((gamma_2(-theta_(mu)))^2) < 2pi),
      )
    $

    Step 1の結果を代入すると、

    $
      arg^([0, 2pi))(
        1/((gamma_2(-theta_(mu)))^2)
      )
      =
      cases(
        0 & quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0),
        2pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) & quad (0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < pi),
        0 & quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = pi),
        4pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) & quad (pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
      )
    $

    === Step 4: $arg$の和の計算

    $
      &arg^([0, 2pi))(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      +
      arg^([0, 2pi))(1/((gamma_2(-theta_(mu)))^2))
      \
      &=
      pi
      +
      cases(
        0 & quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0),
        2pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) & quad (0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < pi),
        0 & quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = pi),
        4pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) & quad (pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
      )
      \
      &=
      cases(
        pi & quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0),
        3pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) & quad (0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < pi),
        pi & quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = pi),
        5pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) & quad (pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
      )
    $

    === Step 5: 和が$[0, 2pi)$と$[2pi, 4pi)$のどちらに入るかの判定

    $
      arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0
      &=>
      "sum" = pi in [0, 2pi)
    $
    $
      0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < pi/2
      &=>
      2pi < 3pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) < 3pi
      =>
      "sum" in [2pi, 4pi)
    $
    $
      arg^([0, 2pi))(gamma_2(-theta_(mu))) = pi/2
      &=>
      "sum" = 2pi in [2pi, 4pi)
    $
    $
      pi/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < pi
      &=>
      pi < 3pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi
      =>
      "sum" in [0, 2pi)
    $
    $
      arg^([0, 2pi))(gamma_2(-theta_(mu))) = pi
      &=>
      "sum" = pi in [0, 2pi)
    $
    $
      pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) < (3pi)/2
      &=>
      2pi < 5pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) < 3pi
      =>
      "sum" in [2pi, 4pi)
    $
    $
      arg^([0, 2pi))(gamma_2(-theta_(mu))) = (3pi)/2
      &=>
      "sum" = 2pi in [2pi, 4pi)
    $
    $
      (3pi)/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi
      &=>
      pi < 5pi - 2 arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi
      =>
      "sum" in [0, 2pi)
    $

    以上をまとめると、

    $
      cases(
        0 <= "sum" < 2pi
        & quad (
          arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0
          or pi/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi
          or (3pi)/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi
        ),
        2pi <= "sum" < 4pi
        & quad (
          0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi/2
          or pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= (3pi)/2
        ),
      )
    $

    === Step 6: $sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) dot.op sqrt(1/((gamma_2(-theta_(mu)))^2))$の計算

    $#ref(<condition_of_commutativity_of_sqrt_and_product>)$ より、

    $
      sqrt(
        gamma_2(theta_(mu))
        gamma_2(-theta_(mu))
      )
      sqrt(
        1
        /
        (
          (gamma_2(-theta_(mu)))^2
        )
      )
      &=
      cases(
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
          dot.op
          1
          /
          (
            (gamma_2(-theta_(mu)))^2
          )
        )
        &quad (0 <= "sum" < 2pi),
        -sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
          dot.op
          1
          /
          (
            (gamma_2(-theta_(mu)))^2
          )
        )
        &quad (2pi <= "sum" < 4pi),
      )
      quad
      (because #ref(<condition_of_commutativity_of_sqrt_and_product>))
      \
      &=
      cases(
        sqrt(
          (gamma_2(theta_(mu)))
          /
          (gamma_2(-theta_(mu)))
        )
        &quad (
          arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0
          or pi/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi
          or (3pi)/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi
        ),
        -sqrt(
          (gamma_2(theta_(mu)))
          /
          (gamma_2(-theta_(mu)))
        )
        &quad (
          0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi/2
          or pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= (3pi)/2
        ),
      )
    $

    === Step 7: $sqrt(1/((gamma_2(-theta_(mu)))^2))$と$1/(gamma_2(-theta_(mu)))$の関係

    $#ref(<square_of_sqrt>)$ より、

    $
      sqrt((gamma_2(-theta_(mu)))^2)
      =
      cases(
        gamma_2(-theta_(mu)) &quad (0 <= arg^([0, 2pi))(gamma_2(-theta_(mu))) < pi),
        -gamma_2(-theta_(mu)) &quad (pi <= arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
      )
    $

    また、$#ref(<inverse_of_sqrt_cc>)$より、

    $
      sqrt(
        1/((gamma_2(-theta_(mu)))^2)
      )
      =
      cases(
        1/(sqrt((gamma_2(-theta_(mu)))^2)) &quad (arg^([0, 2pi))((gamma_2(-theta_(mu)))^2) = 0),
        -(1/(sqrt((gamma_2(-theta_(mu)))^2))) &quad (0 < arg^([0, 2pi))((gamma_2(-theta_(mu)))^2) < 2pi),
      )
    $

    Step 1の結果と合わせて場合分けすると、

    $
      sqrt(
        1/((gamma_2(-theta_(mu)))^2)
      )
      =
      cases(
        1/(gamma_2(-theta_(mu))) &quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0),
        -1/(gamma_2(-theta_(mu))) &quad (0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < pi),
        -(1/(-gamma_2(-theta_(mu)))) &quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = pi),
        -(-(1/(-gamma_2(-theta_(mu))))) &quad (pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
      )
      \
      =
      cases(
        1/(gamma_2(-theta_(mu))) &quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0 or pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
        -1/(gamma_2(-theta_(mu))) &quad (0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi),
      )
    $

    === Step 8: $sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))/(gamma_2(-theta_(mu)))$の計算

    Step 6とStep 7の結果を組み合わせる。

    $
      (
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
        )
      )
      /
      (
        gamma_2(-theta_(mu))
      )
      =
      sqrt(
        gamma_2(theta_(mu))
        gamma_2(-theta_(mu))
      )
      dot.op
      sqrt(
        1
        /
        (
          (gamma_2(-theta_(mu)))^2
        )
      )
      dot.op
      (
        sqrt(
          1
          /
          (
            (gamma_2(-theta_(mu)))^2
          )
        )
        dot.op
        gamma_2(-theta_(mu))
      )^(-1)
    $

    ここで、Step 7の結果より、

    $
      sqrt(
        1
        /
        (
          (gamma_2(-theta_(mu)))^2
        )
      )
      dot.op
      gamma_2(-theta_(mu))
      =
      cases(
        1 &quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0 or pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
        -1 &quad (0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi),
      )
    $

    よって、Step 6の結果と合わせて、各場合を計算すると、

    $
      (
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
        )
      )
      /
      (
        gamma_2(-theta_(mu))
      )
      =
      cases(
        sqrt(
          (gamma_2(theta_(mu)))
          /
          (gamma_2(-theta_(mu)))
        )
        dot.op 1
        &quad (arg^([0, 2pi))(gamma_2(-theta_(mu))) = 0),
        -sqrt(
          (gamma_2(theta_(mu)))
          /
          (gamma_2(-theta_(mu)))
        )
        dot.op (-1)
        &quad (0 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi/2),
        sqrt(
          (gamma_2(theta_(mu)))
          /
          (gamma_2(-theta_(mu)))
        )
        dot.op (-1)
        &quad (pi/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi),
        -sqrt(
          (gamma_2(theta_(mu)))
          /
          (gamma_2(-theta_(mu)))
        )
        dot.op 1
        &quad (pi < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= (3pi)/2),
        sqrt(
          (gamma_2(theta_(mu)))
          /
          (gamma_2(-theta_(mu)))
        )
        dot.op 1
        &quad ((3pi)/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi),
      )
    $

    各場合の符号を計算すると、

    $
      (
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
        )
      )
      /
      (
        gamma_2(-theta_(mu))
      )
      =
      cases(
        sqrt(
          (gamma_2(theta_(mu)))
          /
          (gamma_2(-theta_(mu)))
        )
        &quad (
          0 <= arg^([0, 2pi))(gamma_2(-theta_(mu))) <= pi/2
          or (3pi)/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) < 2pi
        ),
        -sqrt(
          (gamma_2(theta_(mu)))
          /
          (gamma_2(-theta_(mu)))
        )
        &quad (pi/2 < arg^([0, 2pi))(gamma_2(-theta_(mu))) <= (3pi)/2),
      )
    $

    == Part B: $gamma_2(theta_(mu))/gamma_2(-theta_(mu))$ の $alpha_1, alpha_2$ 表式への変換

    以下では $gamma_2(theta_(mu))/gamma_2(-theta_(mu))$ が $a(theta_mu)$ の定義式の $sqrt$ の中身に等しいことを示す。

    === Step 9: $gamma_2$ の定義の代入

    $gamma_2$ の定義より、

    $
      (gamma_2(theta_(mu)))
      /
      (gamma_2(-theta_(mu)))
      &=
      (
        sqrt(-1)
        e^(sqrt(-1) theta_(mu))
        s_2^*
        (c_1 cos(theta_(mu)) - sqrt(-1) sin(theta_(mu)) - s_1 c_2)
      )
      /
      (
        sqrt(-1)
        e^(-sqrt(-1) theta_(mu))
        s_2^*
        (c_1 cos(-theta_(mu)) - sqrt(-1) sin(-theta_(mu)) - s_1 c_2)
      )
    $

    === Step 10: $cos(-theta) = cos(theta), sin(-theta) = -sin(theta)$ の適用

    $
      &=
      (
        sqrt(-1)
        e^(sqrt(-1) theta_(mu))
        s_2^*
        (c_1 cos(theta_(mu)) - sqrt(-1) sin(theta_(mu)) - s_1 c_2)
      )
      /
      (
        sqrt(-1)
        e^(-sqrt(-1) theta_(mu))
        s_2^*
        (c_1 cos(theta_(mu)) + sqrt(-1) sin(theta_(mu)) - s_1 c_2)
      )
    $

    === Step 11: $sqrt(-1) s_2^*$ の約分

    $
      &=
      (
        e^(sqrt(-1) theta_(mu))
        (c_1 cos(theta_(mu)) - sqrt(-1) sin(theta_(mu)) - s_1 c_2)
      )
      /
      (
        e^(-sqrt(-1) theta_(mu))
        (c_1 cos(theta_(mu)) + sqrt(-1) sin(theta_(mu)) - s_1 c_2)
      )
    $

    === Step 12: $cos(theta), sin(theta)$ のEuler表示

    $#ref(<euler_formula_cos_sin>)$ より、$cos(theta_(mu)) = (e^(sqrt(-1) theta_(mu)) + e^(-sqrt(-1) theta_(mu)))/2$、$sin(theta_(mu)) = (e^(sqrt(-1) theta_(mu)) - e^(-sqrt(-1) theta_(mu)))/(2 sqrt(-1))$ を用いると、

    $
      c_1 cos(theta_(mu)) - sqrt(-1) sin(theta_(mu))
      &=
      c_1
      (e^(sqrt(-1) theta_(mu)) + e^(-sqrt(-1) theta_(mu)))
      /
      2
      -
      sqrt(-1)
      dot.op
      (e^(sqrt(-1) theta_(mu)) - e^(-sqrt(-1) theta_(mu)))
      /
      (2 sqrt(-1))
      \
      &=
      c_1
      (e^(sqrt(-1) theta_(mu)) + e^(-sqrt(-1) theta_(mu)))
      /
      2
      -
      (e^(sqrt(-1) theta_(mu)) - e^(-sqrt(-1) theta_(mu)))
      /
      2
      \
      &=
      (
        (c_1 - 1) e^(sqrt(-1) theta_(mu))
        +
        (c_1 + 1) e^(-sqrt(-1) theta_(mu))
      )
      /
      2
    $

    同様に、

    $
      c_1 cos(theta_(mu)) + sqrt(-1) sin(theta_(mu))
      =
      (
        (c_1 + 1) e^(sqrt(-1) theta_(mu))
        +
        (c_1 - 1) e^(-sqrt(-1) theta_(mu))
      )
      /
      2
    $

    === Step 13: 分子分母への代入と整理

    Step 11の式にStep 12の結果を代入すると、

    $
      (gamma_2(theta_(mu)))
      /
      (gamma_2(-theta_(mu)))
      &=
      (
        e^(sqrt(-1) theta_(mu))
        (
          (
            (c_1 - 1) e^(sqrt(-1) theta_(mu))
            +
            (c_1 + 1) e^(-sqrt(-1) theta_(mu))
          )
          /
          2
          - s_1 c_2
        )
      )
      /
      (
        e^(-sqrt(-1) theta_(mu))
        (
          (
            (c_1 + 1) e^(sqrt(-1) theta_(mu))
            +
            (c_1 - 1) e^(-sqrt(-1) theta_(mu))
          )
          /
          2
          - s_1 c_2
        )
      )
      \
      &=
      (
        e^(sqrt(-1) theta_(mu))
        (
          (c_1 - 1) e^(sqrt(-1) theta_(mu))
          +
          (c_1 + 1) e^(-sqrt(-1) theta_(mu))
          -
          2 s_1 c_2
        )
      )
      /
      (
        e^(-sqrt(-1) theta_(mu))
        (
          (c_1 + 1) e^(sqrt(-1) theta_(mu))
          +
          (c_1 - 1) e^(-sqrt(-1) theta_(mu))
          -
          2 s_1 c_2
        )
      )
    $

    分子に $e^(sqrt(-1) theta_(mu))$ を、分母に $e^(-sqrt(-1) theta_(mu))$ を分配すると、

    $
      &=
      (
        (c_1 - 1) e^(2 sqrt(-1) theta_(mu))
        +
        (c_1 + 1)
        -
        2 s_1 c_2 e^(sqrt(-1) theta_(mu))
      )
      /
      (
        (c_1 + 1)
        +
        (c_1 - 1) e^(-2 sqrt(-1) theta_(mu))
        -
        2 s_1 c_2 e^(-sqrt(-1) theta_(mu))
      )
    $

    === Step 14: 二次式の係数の整理

    $x := e^(sqrt(-1) theta_(mu))$ とおくと、

    分子 $= (c_1 - 1) x^2 - 2 s_1 c_2 x + (c_1 + 1)$

    分母 $= (c_1 - 1) x^(-2) - 2 s_1 c_2 x^(-1) + (c_1 + 1)$

    $(c_1 + 1)$ でくくると、

    分子 $= (c_1 + 1) ((c_1 - 1)/(c_1 + 1) dot.op x^2 - (2 s_1 c_2)/(c_1 + 1) dot.op x + 1)$

    分母 $= (c_1 + 1) ((c_1 - 1)/(c_1 + 1) dot.op x^(-2) - (2 s_1 c_2)/(c_1 + 1) dot.op x^(-1) + 1)$

    === Step 15: $(c_1 - 1)/(c_1 + 1) = alpha_1 alpha_2^(-1)$ の証明

    $
      alpha_1 alpha_2^(-1)
      &=
      (tanh K_1 tanh K_2^*)
      dot.op
      ((tanh K_1)^(-1) tanh K_2^*)^(-1)
      \
      &=
      (tanh K_1 tanh K_2^*)
      dot.op
      (tanh K_1 (tanh K_2^*)^(-1))
      \
      &=
      (tanh K_1)^2
    $

    一方、

    $
      (c_1 - 1)
      /
      (c_1 + 1)
      &=
      (cosh(2 K_1) - 1)
      /
      (cosh(2 K_1) + 1)
      \
      &=
      (2 sinh^2(K_1))
      /
      (2 cosh^2(K_1))
      quad (because cosh(2x) - 1 = 2sinh^2(x), cosh(2x) + 1 = 2cosh^2(x))
      \
      &=
      (tanh K_1)^2
    $

    よって、

    $
      (c_1 - 1)/(c_1 + 1) = alpha_1 alpha_2^(-1) quad dots.c (star.op)
    $

    === Step 16: $(2 s_1 c_2)/(c_1 + 1) = alpha_1 + alpha_2^(-1)$ の証明

    まず $alpha_1 + alpha_2^(-1)$ を計算する。

    $
      alpha_1 + alpha_2^(-1)
      &=
      tanh K_1 tanh K_2^*
      +
      (tanh K_1)^(-1) (tanh K_2^*)^(-1)
      \
      &=
      tanh K_1 tanh K_2^*
      +
      (tanh K_1)/(tanh K_2^*)
      quad (because alpha_2^(-1) = ((tanh K_1)^(-1) tanh K_2^*)^(-1) = tanh K_1 (tanh K_2^*)^(-1))
      \
      &=
      tanh K_1
      dot.op
      (tanh K_2^* + (tanh K_2^*)^(-1))
    $

    ここで、

    $
      tanh K_2^* + (tanh K_2^*)^(-1)
      &=
      (sinh K_2^*)/(cosh K_2^*)
      +
      (cosh K_2^*)/(sinh K_2^*)
      \
      &=
      (sinh^2 K_2^* + cosh^2 K_2^*)
      /
      (sinh K_2^* cosh K_2^*)
      \
      &=
      (2 cosh(2 K_2^*))
      /
      (sinh(2 K_2^*))
      quad (because cosh^2(x) + sinh^2(x) = cosh(2x), 2sinh(x)cosh(x) = sinh(2x))
    $

    $K_2^* = -1/2 log(tanh K_2)$, すなわち $e^(-2 K_2^*) = tanh K_2$ より、

    $
      sinh(2 K_2^*)
      &=
      (e^(2 K_2^*) - e^(-2 K_2^*))
      /
      2
      \
      &=
      ((tanh K_2)^(-1) - tanh K_2)
      /
      2
      \
      &=
      ((cosh K_2)/(sinh K_2) - (sinh K_2)/(cosh K_2))
      /
      2
      \
      &=
      (cosh^2 K_2 - sinh^2 K_2)
      /
      (2 sinh K_2 cosh K_2)
      \
      &=
      (1)
      /
      (sinh(2 K_2))
    $

    $
      cosh(2 K_2^*)
      &=
      (e^(2 K_2^*) + e^(-2 K_2^*))
      /
      2
      \
      &=
      ((tanh K_2)^(-1) + tanh K_2)
      /
      2
      \
      &=
      ((cosh K_2)/(sinh K_2) + (sinh K_2)/(cosh K_2))
      /
      2
      \
      &=
      (cosh^2 K_2 + sinh^2 K_2)
      /
      (2 sinh K_2 cosh K_2)
      \
      &=
      (cosh(2 K_2))
      /
      (sinh(2 K_2))
    $

    よって、

    $
      (2 cosh(2 K_2^*))/(sinh(2 K_2^*))
      &=
      2 dot.op
      ((cosh(2 K_2))/(sinh(2 K_2)))
      /
      ((1)/(sinh(2 K_2)))
      \
      &=
      2 cosh(2 K_2)
    $

    したがって、

    $
      alpha_1 + alpha_2^(-1)
      =
      tanh K_1 dot.op 2 cosh(2 K_2)
      =
      2 tanh K_1 cosh(2 K_2)
    $

    一方、

    $
      (2 s_1 c_2)
      /
      (c_1 + 1)
      &=
      (2 sinh(2 K_1) cosh(2 K_2))
      /
      (cosh(2 K_1) + 1)
      \
      &=
      (2 dot.op 2 sinh K_1 cosh K_1 dot.op cosh(2 K_2))
      /
      (2 cosh^2 K_1)
      quad (because sinh(2x) = 2sinh(x)cosh(x), cosh(2x) + 1 = 2cosh^2(x))
      \
      &=
      (2 sinh K_1 cosh(2 K_2))
      /
      (cosh K_1)
      \
      &=
      2 tanh K_1 cosh(2 K_2)
    $

    よって、

    $
      (2 s_1 c_2)/(c_1 + 1) = alpha_1 + alpha_2^(-1) quad dots.c (star.op star.op)
    $

    === Step 17: 因数分解の検証

    $(1 - alpha_1 x)(1 - alpha_2^(-1) x)$ を展開すると、

    $
      (1 - alpha_1 x)(1 - alpha_2^(-1) x)
      &=
      1 - (alpha_1 + alpha_2^(-1)) x + alpha_1 alpha_2^(-1) x^2
    $

    $(star.op)$ と $(star.op star.op)$ を用いると、

    $
      &=
      1 - (2 s_1 c_2)/(c_1 + 1) dot.op x + (c_1 - 1)/(c_1 + 1) dot.op x^2
    $

    よって、

    $
      (c_1 + 1)(1 - alpha_1 x)(1 - alpha_2^(-1) x)
      =
      (c_1 + 1) - 2 s_1 c_2 x + (c_1 - 1) x^2
    $

    これはStep 14の分子と一致する（$x = e^(sqrt(-1) theta_(mu))$のとき）。

    同様に $y := e^(-sqrt(-1) theta_(mu)) = x^(-1)$ とおくと、

    $
      (c_1 + 1)(1 - alpha_1 y)(1 - alpha_2^(-1) y)
      =
      (c_1 + 1) - 2 s_1 c_2 y + (c_1 - 1) y^2
    $

    これはStep 14の分母と一致する。

    === Step 18: 結論

    Step 14とStep 17より、

    $
      (gamma_2(theta_(mu)))
      /
      (gamma_2(-theta_(mu)))
      &=
      (
        (c_1 + 1)(1 - alpha_1 e^(sqrt(-1) theta_(mu)))(1 - alpha_2^(-1) e^(sqrt(-1) theta_(mu)))
      )
      /
      (
        (c_1 + 1)(1 - alpha_1 e^(-sqrt(-1) theta_(mu)))(1 - alpha_2^(-1) e^(-sqrt(-1) theta_(mu)))
      )
      \
      &=
      (
        (1 - alpha_1 e^(sqrt(-1) theta_(mu)))(1 - alpha_2^(-1) e^(sqrt(-1) theta_(mu)))
      )
      /
      (
        (1 - alpha_1 e^(-sqrt(-1) theta_(mu)))(1 - alpha_2^(-1) e^(-sqrt(-1) theta_(mu)))
      )
    $

    したがって、$a(theta_mu)$ の定義より、

    $
      a(theta_mu)
      =
      sqrt(
        (
          (1 - alpha_1 e^(sqrt(-1) theta_mu))
        )
        /
        (
          (1 - alpha_1 e^(-sqrt(-1) theta_mu))
        )
        dot.c
        (
          (1 - alpha_2^(-1) e^(sqrt(-1) theta_mu))
        )
        /
        (
          (1 - alpha_2^(-1) e^(-sqrt(-1) theta_mu))
        )
      )
      =
      sqrt(
        (gamma_2(theta_(mu)))
        /
        (gamma_2(-theta_(mu)))
      )
    $

    Part AのStep 8の結果と合わせて、Claimのステートメントが示された。

    $qed$
  ]
// SageMath数値検証: sagemath/check/028_claim_a_theta_mu/
]<equation_of_a_theta_mu>
