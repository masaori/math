# SageMath Check: 倍数辺との平方の差の評価

## 対象

**対象ラベル**: `claim_square_difference_from_multiple_side_bound`

- 実行日: 2026-08-16
- 状態: PASS（$a,k\in\{1,\dots,8\}$、$L\in\{ka,\dots,ka+a\}$ の全組。2816 検査）
- 帰属: `ZZ` による厳密計算。浮動小数点は使わない。

## 検査内容

各組について、主張 $(ka)^2\le L^2$、$L^2-(ka)^2\le2aL$ と、証明の七段の鎖
$L^2=L\cdot L\le(ka+a)L=kaL+aL\le ka(ka+a)+aL=(ka)^2+a\cdot ka+aL\le(ka)^2+aL+aL=(ka)^2+2aL$
を一段ずつ確かめる。有限標本の検査であり、普遍量化された主張の証明ではない（それは Lean が担う）。

## 実行方法

```sh
sage sagemath/check/square-difference-from-multiple-side-bound/check.sage
```
