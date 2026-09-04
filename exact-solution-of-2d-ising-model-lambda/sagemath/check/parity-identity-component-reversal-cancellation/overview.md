# 成分反転による内部側と切断線側の偶奇変化の相殺

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

曲がり型なし均衡配向の一つの辺連結成分を全反転すると、動辺数は変わらず、
「動辺数＋内部辺対＋局所位相」の変化と切断線辺対の変化は $\mathbb F_2$
で等しい。従って二つの変化は全体で相殺する。一辺二の全対象と一辺三の
$D=\varnothing$ の自明文字対象について、全配向・全成分反転を検査した。

- 実行: `sage sagemath/check/parity-identity-component-reversal-cancellation/check.sage`
- 状態: PASS（2026-09-04。一辺二 770 反転・非零変化 64 件、
  一辺三 1,866 反転・非零変化 168 件）
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。
