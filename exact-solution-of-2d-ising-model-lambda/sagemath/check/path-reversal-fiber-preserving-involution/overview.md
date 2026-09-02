# SageMath Check: 経路反転のファイバー保存対合性

**対象ラベル**: `claim_path_reversal_fiber_preserving_involution`

経路反転 $\mathcal T(\varphi)=\iota\circ\varphi^{-1}\circ\iota$ が、非後退置換を
非後退置換へ写し、二回適用で元へ戻り、動く辺の集合を反転写像による像
$\iota(M(\varphi))$ へ写し、反転対の辺集合 $D$ と単純通過の辺集合 $E_1$ を
保つ（したがって各ファイバー $\mathcal N_L(D,E)$ を保つ）ことを検査する。

- 実行: `sage sagemath/check/path-reversal-fiber-preserving-involution/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 一辺 $L=2$ の非後退置換 $30{,}784$ 個の全数で、経路反転の非後退性・
  対合性・動く辺の反転像・$D$ と $E_1$ の保存を検査した。

計算は有限集合の等号だけで行い、浮動小数点は使わない。
