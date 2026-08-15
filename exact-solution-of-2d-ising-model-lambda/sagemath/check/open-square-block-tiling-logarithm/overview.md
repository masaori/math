# SageMath Check: ブロック敷き詰め評価の対数化

## 対象

**対象ラベル**: `claim_open_square_block_tiling_logarithm`

- 実行日: 2026-08-15
- 結果: 有限標本検査がすべて通過
- 帰属: 分配多項式の値と係数の約分は厳密計算。実対数を含む不等式だけ
  `RealBallField(256)`（丸め誤差を包含する ball 算術）を使う。

## 何を確かめるか

- 正の有理点 7 点と $(a,k)$ の 5 組について、
  $0<t\le1$ と $1\le t$ の二場合の
  $\psi^{\mathrm{op}}_{ka}(t)$ の上下評価を ball の端点で分離して検査する。等号の場合は
  差の ball が零を含み、半径が $2^{-200}$ 未満であることを整合検査する。
- $(ka)^{-2}\,2(k-1)ka=2(k-1)/(ka)$ と
  $(ka)^{-2}k^2=a^{-2}$ を有理数として厳密に検査する。

## 浮動小数点（ball 算術）を使う理由

実対数の値は一般に超越的であり、可算側の厳密な閉形式には入らない。そこで実対数を含む
順序比較だけ ball 算術を使う。比較は左右の ball が分離した場合に限って成功させる。
可算側の値と係数の約分には浮動小数点を使わない。

## 範囲の注記

有限標本検査であり、普遍量化された主張の証明ではない。Lean は未着手である。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-block-tiling-logarithm/check.sage
```
