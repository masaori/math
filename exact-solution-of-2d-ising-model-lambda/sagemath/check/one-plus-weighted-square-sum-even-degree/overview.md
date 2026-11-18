# SageMath Check: 正錐を係数とする平方和に一を足した多項式は偶数次である

## 対象

**対象ラベル**: `claim_subfield_positive_cone_contains_nonzero_squares`, `claim_qbar_poly_square_top_coefficient`, `claim_one_plus_weighted_square_sum_polynomial_even_degree`

- 実行日: 2026-11-18
- 結果: 全検査通過（PASS 800。$F=\mathbb Q(s)$、$s\cdot s=2$。零でない元の平方 200 件、平方の係数 200 件、$P=1+\sum\widehat{c(i)}\,g(i)^2$ の 400 件。うち約四分の一は全ての $g(i)$ が零の場合）
- 帰属: 数体 $\mathbb Q(s)$ と $\mathbb Q(s)[t]$ の厳密計算。等号はすべて数体の中で判定する。
- 浮動小数点の使用: 正錐の例として $C_F=\{z\in F\mid s\mapsto\sqrt2\ \text{の埋め込みでの値が正}\}$ を取り、その所属の判定だけに区間演算（`RIF`）を使う。本文の主張は任意の正錐についてであり、この判定は検査用の一例を作るためだけのもの。

## 何を確かめるか

本文の証明の段を、行ごとに次で確かめる。普遍量化された主張の証明ではない。

- 零でない元の平方: 三分法の被覆、$(-a)(-a)=a\cdot a$、$a\cdot a\in C_F$、$1\in C_F$。
- 平方の係数: 係数の上界 $m$、積の係数の和、番号 $m$ の項を分けた和、$i\ne m$ の項が零であること、$\mathrm{ac}_{2m}(f\cdot f)=\mathrm{ac}_m(f)^2$。
- 主張: 準備の式（和の係数と定数多項式との積の係数）、全て零の場合の $P=1$、$m$ と $j$ の取り方の三性質、$k>2m$ での平方の係数の消滅、$u(i)$ が零か $C_F$ の元であること、$u(j)\in C_F$、$r$ が零か $C_F$ の元であること、$\mathrm{ac}_{2m}(P)$ の鎖、$\mathrm{ac}_{2m}(P)\in C_F$、$k>2m$ で $\mathrm{ac}_k(P)=0$、$P\ne0$。

## 実行方法

```sh
sage check.sage
```
