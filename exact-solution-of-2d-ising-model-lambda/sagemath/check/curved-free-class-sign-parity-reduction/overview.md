# 未ねじれの配向類符号の偶奇恒等式への還元

**対象ラベル**: `claim_selection_sum_character_evaluation`,
`claim_kac_ward_determinant_fiber_stratified_phase_sum`

曲がり型のない均衡配向について、配向類の局所行列式和から絶対値
$2^{n_4(E)}$ を除いた符号を、動辺数、終点別の行順序への置換、始点別の
列順序への置換、局所行列式積の正規化位相という四つの偶奇へ分解する。
これにより未ねじれの一般符号同定は、その和が

$$arepsilon_{L,\mathrm h}(E)+\varepsilon_{L,\mathrm v}(E)
+\varepsilon_{L,\mathrm h}(E)\varepsilon_{L,\mathrm v}(E)
+\langle D\cup C_0,E\rangle\pmod 2$$

に等しいという一つの $\mathbb F_2$ 恒等式へ還元される。

- 実行: `sage sagemath/check/curved-free-class-sign-parity-reduction/check.sage`
- 状態: PASS（2026-09-04。一辺二 $738$ 配向、一辺三 $1{,}522$ 配向）
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。
