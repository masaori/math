# SageMath Check: 残余の位相和の符号付き数え上げ

**対象ラベル**: `claim_phase_contribution_sign_value`, `claim_residual_fiber_phase_signed_count`

一辺 $L=2$ の全非後退置換について、次を検査する。

- 位相寄与 $\mathcal W^{a,b}_L(\varphi)$ が四つのスピン構造の全てで $\{-1,1\}$ に属する。
- 標準対が切り替え不能な残余 $\mathcal R_L$ をファイバー $(D,E)$ に分け、その位相和が
  位相寄与 $1$ の置換の個数から位相寄与 $-1$ の置換の個数を引いた整数に等しい。

- 実行: `sage sagemath/check/residual-fiber-phase-signed-count/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 位相寄与の符号性 $123{,}136$ 件（非後退置換 $30{,}784$ 個×四スピン構造）と、
  残余 $18{,}755$ 個を含むファイバー×四スピン構造の全 $2{,}288$ 組の符号付き数え上げを検査した。

計算は整数と円分体 $\mathbb Q(\zeta_8)$ の厳密演算だけで行い、浮動小数点は使わない。
