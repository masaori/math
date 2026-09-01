# SageMath Check: 標準対平滑化の位相反転部分集合上の符号反転対合

**対象ラベル**: `claim_phase_reversing_standard_smoothing_involution`

標準接触対が切り替え可能な置換の集合 $\mathcal A_L$ の中で、標準対が位相反転接触対
（二接続の回転数和が平滑化前後で等しい）である部分集合 $\mathcal B_L$ を作り、
標準対平滑化 $S$ が $\mathcal B_L$ に留まり、二回適用で元へ戻り、不動点を持たず、
$M$・$D$・$E_1$ を保ち、四つのスピン構造すべてで位相寄与
$\mathcal W^{a,b}_L$ の符号を反転することを検査する。

- 実行: `sage sagemath/check/phase-reversing-standard-smoothing-involution/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 一辺 $L=2$ の非後退置換 $30{,}784$ 個中、$\mathcal A_L$ は $11{,}980$ 個、
  $\mathcal B_L$ は $4{,}748$ 個だった。$\mathcal B_L$ の全数で符号反転対合・不動点なし・
  ファイバー保存を検査した（符号反転の検査 $18{,}992$ 件）。

計算は円分体 $\mathbb Q(\zeta_8)$ と整数だけで行い、浮動小数点は使わない。
