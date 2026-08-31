# SageMath Check: 一セルを追加したときの Euler 数の増分

**対象ラベル**: `claim_cell_complex_one_cell_increment`

有限セル集合 $S$ とそれに属さないセル $x$ について、Euler 数の増分等式
$\chi_{\square}(S\cup\{x\})=\chi_{\square}(S)+1+e_x(S)-v_x(S)$ を、
$3\times3$ と $2\times4$ の二つの有限窓のすべての部分集合とすべての追加セルにわたって検査する。
あわせて $\chi_{\square}(\varnothing)=0$ と、単一セルの頂点集合・辺集合の元の個数が $4$ であることも検査する。

- 実行: `sage sagemath/check/cell-complex-one-cell-increment/check.sage`
- 状態: PASS（2026-08-31）。一セル追加の増分等式 3,328 件、単一セルの頂点数・辺数 17 件を検査した。
- 計算: 有限集合の合併・共通部分の数え上げと `ZZ` の四則だけ。浮動小数点は使わない。
