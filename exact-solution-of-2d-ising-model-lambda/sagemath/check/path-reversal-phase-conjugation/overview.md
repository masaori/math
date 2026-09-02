# SageMath Check: 経路反転による位相寄与の共役

**対象ラベル**: `claim_path_reversal_phase_conjugation`

経路反転 $\mathcal T(\varphi)=\iota\circ\varphi^{-1}\circ\iota$ が、置換の各軌道を
反転辺からなる逆順の軌道へ写し、位相寄与について

$$
\mathcal W^{a,b}_L\bigl(\mathcal T(\varphi)\bigr)
=\zeta_8^{-2\Theta(\varphi)}\mathcal W^{a,b}_L(\varphi)
$$

を満たすことを検査する。ここで $\Theta(\varphi)$ は動く辺上の一歩回転数の総和である。

- 実行: `sage sagemath/check/path-reversal-phase-conjugation/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 一辺 $L=2$ の非後退置換 $30{,}784$ 個と四つのスピン構造の全
  $123{,}136$ 件で等式を検査した。

計算は $\mathbb Q(\zeta_8)$ の厳密演算だけで行い、浮動小数点は使わない。
