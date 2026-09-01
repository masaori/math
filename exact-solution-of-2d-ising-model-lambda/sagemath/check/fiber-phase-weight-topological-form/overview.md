# SageMath Check: ファイバーの位相付き寄与の位相形

**対象ラベル**: `claim_fiber_phase_weight_topological_form`

$L=2$ のトーラスと四つのスピン構造 $(a,b)$、全ての非空ファイバー $\mathcal N_L(D,E)$ について、次を $\mathbb{Q}(\zeta_8)$ で厳密検査する。

- 遷移行列の成分による定義
  $\mathcal K^{a,b}_L(D,E)=\sum_\varphi\prod_C\bigl(-\prod_{\vec e\in C}M^{a,b}_{\vec e,\varphi(\vec e)}\bigr)$ と、
  位相形 $\sum_\varphi\prod_C\bigl(-(-1)^{a\,h(\gamma^\varphi_C)+b\,v(\gamma^\varphi_C)}\zeta_8^{t_\circ(\gamma^\varphi_C)}\bigr)$ の一致、
- 位相形の値が基点の選び方に依らないこと（各軌道列を一つ回した基点で再計算して比較）。

- 実行: `sage sagemath/check/fiber-phase-weight-topological-form/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 非後退置換 $30{,}784$ 個・非空ファイバー $609$ 個・スピン構造 4 件、検査 $2{,}436$ 件。

計算はすべて円分体 $\mathbb{Q}(\zeta_8)$ の厳密計算であり、浮動小数点は使わない。
