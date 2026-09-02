# SageMath Check: ファイバー位相和の実二次整数への所属

**対象ラベル**: `claim_fiber_phase_weight_real_quadratic_integrality`

補題 `claim_phase_contribution_signed_rotation_power` も同じ実行で検査する。

一辺 $L=2$ の全非後退置換について、

1. 位相寄与と回転位相冪の比 $\mathcal W^{a,b}_L(\varphi)\cdot\zeta_8^{-\Theta(\varphi)}$ が
   $\{-1,1\}$ に属すること（符号付き回転位相冪）、
2. 全ファイバー $(D,E)$ と四つのスピン構造について、ファイバー位相和が
   $\mathcal K^{a,b}_L(D,E)=u+v\,(\zeta_8-\zeta_8^3)$（$u,v\in\mathbb Z$）の形に
   なること（冪基底の係数が $a_2=0$、$a_3=-a_1$、$a_0,a_1\in\mathbb Z$）

を検査する。

- 実行: `sage sagemath/check/fiber-phase-weight-real-quadratic-integrality/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 符号付き回転位相冪は非後退置換 $30{,}784$ 個×四スピン構造の全 $123{,}136$ 件、
  格子への所属は $609$ ファイバー×四スピン構造の全 $2{,}436$ 件で検査した。
- 観察: 一辺 $L=2$ では $\zeta_8-\zeta_8^3$ の係数が全 $2{,}436$ 組で零であり、
  ファイバー位相和はすべて有理整数だった。本文の主張（$\mathbb Z+\mathbb Z(\zeta_8-\zeta_8^3)$
  への所属）より強いこの整数性は $L=2$ の観察であり、一般の $L$ では未証明である。

計算は $\mathbb Q(\zeta_8)$ の厳密演算だけで行い、浮動小数点は使わない。
