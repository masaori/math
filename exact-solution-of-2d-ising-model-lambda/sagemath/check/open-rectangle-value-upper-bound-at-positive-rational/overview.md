# SageMath Check: 開境界長方形の正の有理点での値の上からの評価

## 対象

**対象ラベル**: `claim_open_rectangle_value_upper_bound_at_positive_rational`

- 実行日: 2026-08-16
- 状態: PASS（形 11 通り、正の有理点 9 点。準備の第五 3637 件、式変形の各行と主張 33140 件、合計 36777 件）
- 帰属: `ZZ`/`QQ` の厳密計算。浮動小数点・ball 算術は使わない（主張は $\mathbb Q$ で閉じている）。

## 検査内容

形 $(a,b)\in\{(1,1),(1,2),(2,1),(2,2),(1,3),(3,1),(2,3),(3,2),(3,3),(2,4),(4,2)\}$ と
正の有理数 $q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ について、

- 準備の第五: $E^{\mathrm{op}}_{a,b,\mathrm h}$ と $E^{\mathrm{op}}_{a,b,\mathrm v}$ が交わらないこと、
  $|E^{\mathrm{op}}_{a,b}|=|E^{\mathrm{op}}_{a,b,\mathrm h}|+|E^{\mathrm{op}}_{a,b,\mathrm v}|=a(b-1)+(a-1)b\le ab+ab=2ab$、
  各配位 $\sigma$ で $B^{\mathrm{op}}_{a,b}(\sigma)\subseteq E^{\mathrm{op}}_{a,b}$、$b^{\mathrm{op}}_{a,b}(\sigma)=|B^{\mathrm{op}}_{a,b}(\sigma)|\le|E^{\mathrm{op}}_{a,b}|$、$b^{\mathrm{op}}_{a,b}(\sigma)\le2ab$。
- 準備の第一〜第三は本体で使う組だけ（各 $\sigma$ で $0<q^{b^{\mathrm{op}}(\sigma)}$、$q^{b^{\mathrm{op}}(\sigma)}\le(1+q)^{b^{\mathrm{op}}(\sigma)}$、
  $(1+q)^{b^{\mathrm{op}}(\sigma)}\le(1+q)^{2ab}$）。一般形は周期境界の `partition-value-upper-bound-at-positive-rational` で検査済み。
- 式変形の各行: $|\Sigma^{\mathrm{op}}_{a,b}|=2^{ab}$、$q\le1+q$、$1\le1+q$、
  $Z^{\mathrm{op}}_{a,b}(q)=\sum_\sigma q^{b^{\mathrm{op}}(\sigma)}$（全配位から組んだ $\mathbb Z[x]$ の分配多項式への代入）、$\le\sum_\sigma(1+q)^{b^{\mathrm{op}}(\sigma)}$、
  $\le\sum_\sigma(1+q)^{2ab}$、$=|\Sigma^{\mathrm{op}}_{a,b}|\cdot(1+q)^{2ab}$、$=2^{ab}\cdot(1+q)^{2ab}$、そして主張
  $Z^{\mathrm{op}}_{a,b}(q)\le2^{ab}(1+q)^{2ab}$（$a=b$ では正方形の形 $2^{L^2}(1+q)^{2L^2}$ も見る）。

有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## Lean

具体版 `openBrokenBondCount_le_two_mul`・`openPartitionValueRat_le_upperBound`
（`lean/Ising2DLambda/ThermodynamicLimit/OpenRectangleValueUpperBoundRational.lean`）、
必要十分版は周期境界の `sum_pow_le_uniform_bound_necSuf` を共有、導出版
`openPartitionValueRat_le_upperBound_from_necSuf`（`OpenRectangleValueUpperBoundRationalFromNecSuf.lean`）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-rectangle-value-upper-bound-at-positive-rational/check.sage
```
