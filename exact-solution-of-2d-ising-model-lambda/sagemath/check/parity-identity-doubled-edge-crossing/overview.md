# 偶奇恒等式の二重辺つき鍵での交差対項の検査（一辺三）

**対象ラベル**: `claim_selection_sum_character_evaluation`,
`claim_kac_ward_determinant_fiber_stratified_phase_sum`

未ねじれの符号同定を還元した $\mathbb F_2$ 偶奇恒等式のうち、交差対項
$\langle D\cup C_0,E\rangle$ は、一辺三ではこれまで $D=\varnothing$ の
自明文字対象でしか検査されておらず恒等的に零だった。巻き付き偶奇が
非零の自明文字 $E$ に二重辺 $D=\{d\}$ を付け、選択集合を $\mathrm{GF}(2)$
の接続行列の線型方程式で構成して、交差対項が $1$ の鍵と $0$ の鍵の
両方で恒等式を照合した。

- 実行: `sage sagemath/check/parity-identity-doubled-edge-crossing/check.sage`
- 状態: PASS（2026-09-04。交差対 $1$ の鍵 $336$ 件、交差対 $0$ の鍵 $324$ 件）
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。
