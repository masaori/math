# SageMath Check: 標準対の回転差が正負四である部分集合上の位相保存対合

**対象ラベル**: `claim_non_phase_reversing_standard_smoothing_involution`

標準接触対が切り替え可能で、その回転差が $-4$ または $4$ である置換の集合
$\mathcal A_L^{(-4)}$ と $\mathcal A_L^{(4)}$ を作る。標準対平滑化が両集合を交換し、
二回適用で元へ戻り、不動点を持たず、$M$・$D$・$E_1$ と四つのスピン構造の
位相寄与 $\mathcal W^{a,b}_L$ を保つことを検査する。

- 実行: `sage sagemath/check/non-phase-reversing-standard-smoothing-involution/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 一辺 $L=2$ で $\mathcal A_L^{(-4)}$ と $\mathcal A_L^{(4)}$ は各 $3{,}616$ 個だった。
  標準対平滑化による両集合の交換・対合・不動点なし・ファイバー保存・位相寄与保存を
  全数検査した（位相寄与の検査 $28{,}928$ 件）。

計算は円分体 $\mathbb Q(\zeta_8)$ と整数だけで行い、浮動小数点は使わない。
