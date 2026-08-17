# SageMath Check: 零点密度の挟み込み $N_L\le N^{\mathrm{mult}}_L\le2L^2$

**対象ラベル**: `claim_fisher_zero_count_le_mult_count`, `claim_fisher_zero_mult_count_le_edge_bound`

本文の 2 つの主張（1 個ずつ数えた個数は重複度付きの個数以下／重複度付きの個数は $2L^2$ 以下）を
厳密計算（`QQbar`・`AA`・`ZZ`）で確かめる。浮動小数点は使わない。

- 円板内の各零点の重複度が 1 以上であること（$\mathrm{aev}_\xi(\widehat{Z_L}^{\,F})=0$ から）。
- $N_L(c,r)\le N^{\mathrm{mult}}_L(c,r)$（各項が 1 以上と有限和の単調性）。
- $N^{\mathrm{mult}}_L(c,r)\le2L^2$（$2L^2$ より上の番号の係数が零であることからの和の上界）。
- 円板を全体に取った場合（全零点の重複度の和）も $2L^2$ 以下であること。
- 格子点数で割った密度が、どちらの数え方でも上界 $2$ を持つこと。

$L=1,2$（$L=3$ は `AA` の厳密比較が長すぎるので除く。既存の
`check/fisher-zero-density-in-rational-disc-le-two` と同じ範囲）、
中心 3 つ × 半径 3 つの有理円板 9 組。重複度は $(t-\xi)^k$ で割り切れる $k$ の最大元として計算する。

```sh
sage sagemath/check/fisher-zero-mult-count-squeeze/check.sage
```

**2026-08-17 実行: すべて通過。**
