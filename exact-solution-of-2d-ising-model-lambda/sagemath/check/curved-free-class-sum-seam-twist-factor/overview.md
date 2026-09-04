# 配向類の局所行列式和と選択項の継ぎ目符号

**対象ラベル**: `claim_winding_parity_symmetric_difference_additivity`,
`claim_selection_sum_character_evaluation`,
`claim_kac_ward_determinant_fiber_stratified_phase_sum`

一般の辺長で、配向類の局所行列式和と選択項はいずれも、未ねじれの値に
$(-1)^{a\varepsilon_{L,\mathrm h}(E)+b\varepsilon_{L,\mathrm v}(E)}$ を掛けた値になる。
局所行列式では継ぎ目符号を出る動辺の列ごとに括り出し、二重辺の二方向の
寄与が相殺することから従う。選択項では二つの偶部分グラフの対称差が $E$
であることから従う。従って四つのねじれの符号同定は未ねじれの場合へ帰着する。

- 実行: `sage sagemath/check/curved-free-class-sum-seam-twist-factor/check.sage`
- 状態: PASS（2026-09-04。一辺二の配向類 $2{,}952$ 件・選択項 $3{,}072$ 件と、
  一辺三の $D=\varnothing$ の配向類 $6{,}088$ 件・選択項 $12{,}544$ 件）
- 方法: 有限集合、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。浮動小数点は使わない。
