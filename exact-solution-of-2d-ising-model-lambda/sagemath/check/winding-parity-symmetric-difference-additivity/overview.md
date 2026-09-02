# SageMath Check: 巻き付き偶奇の対称差加法性

**対象ラベル**: `claim_winding_parity_symmetric_difference_additivity`

一辺 $L=2$ の全ての辺集合対 $(X,Y)$（$2^8\times2^8=65{,}536$ 組）について、

$$
\varepsilon_{L,\mathrm h}(X\mathbin\triangle Y)\equiv\varepsilon_{L,\mathrm h}(X)+\varepsilon_{L,\mathrm h}(Y)\pmod2,\qquad
\varepsilon_{L,\mathrm v}(X\mathbin\triangle Y)\equiv\varepsilon_{L,\mathrm v}(X)+\varepsilon_{L,\mathrm v}(Y)\pmod2
$$

を全対で検査する（`def_torus_winding_parities` の境界横断辺の個数の法 2 の値を、
辺の番号付けの代わりに種類と座標の三つ組で表して数える）。

- 実行: `sage sagemath/check/winding-parity-symmetric-difference-additivity/check.sage`
- 状態: PASS（2026-09-03。主張を本文へ追加した tick で実行）
- 方法: 有限集合と $\mathbb Z$ の合同だけ。浮動小数点は使わない。
- 結果: 全 $65{,}536$ 組で二つの合同式が成立した。
