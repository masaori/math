# SageMath Check: 行列式の位相和は反転対と単純通過で層別される

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

$L=2$ のトーラスで、四つのスピン構造 $(a,b)$ それぞれについて次を厳密検査する。

- 非後退置換 $30{,}784$ 個をファイバー $\mathcal N_L(D,E)$ へ分割できること
  （像は互いに素で、個数の総和が全置換数に一致すること）、
- 各置換の軌道長総和が $2|D(\varphi)|+|E_1(\varphi)|$ に等しいこと、
- 各軌道の遷移成分積が切断線偶奇の符号と回転位相の冪
  $(-1)^{a h+b v}\zeta_8^{t_\circ}$ に一致すること、
- ファイバーの位相付き寄与 $\mathcal K^{a,b}_L(D,E)$ を
  $x^{2|D|+|E|}$ に掛けた総和が $\det(I-xM^{a,b})$ の直接計算に一致すること。

- 実行: `sage sagemath/check/kac-ward-determinant-fiber-stratification/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 非空ファイバー $609$ 個、スピン構造 $4$ 件すべてで両辺の
  $\mathbb Q(\zeta_8)[x]$ の多項式が一致した。

計算はすべて円分体 $\mathbb Q(\zeta_8)$ 上の厳密計算であり、浮動小数点は使わない。
