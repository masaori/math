# SageMath Check: 部分体を係数とする多項式と部分体上の次数

## 対象

**対象ラベル**: `claim_subfield_contains_rationals`, `def_subfield_coefficient_polynomials`, `claim_subfield_coefficient_vanishing_polynomial_exists`, `def_degree_over_subfield`

- 実行日: 2026-11-17
- 結果: 全検査通過（有理数 200 個、代数的数 8 個で $F=\mathbb Q$ と $F=\mathbb Q(s)$ の二つの部分体）
- 帰属: `QQ`・数体・`QQbar` の厳密計算。浮動小数点を使わない（出力の小数表示は `QQbar` の表示であって計算ではない）。

## 何を確かめるか

本文の証明の段を、行ごとに次で確かめる。普遍量化された主張の証明ではない。

- 有理数の所属: 自然数の帰納法の段（$n+1$ を和で作る）、整数の符号反転の段、商 $a/b$ の段を $F=\mathbb Q(s)$（$s\cdot s=2$）で確かめる。
- 零化多項式の存在: 各 $\alpha$ の有理係数の最小多項式 $p$ について、係数が有理数で $F$ に属すること、$p\ne0$、$p(\alpha)=0$、最大の係数番号 $d_0$ が上界になること。
- 次数の定義: $D_F(\alpha)$ の最小元を「$1,\alpha,\dots,\alpha^{d}$ が $F$ 上一次従属になる最小の $d$」として $\mathbb Q$ 上の線型代数で求め、$F=\mathbb Q$ では最小多項式の次数、$F=\mathbb Q(s)$ では $p$ の $\mathbb Q(s)$ 上の因子のうち $\alpha$ を根とするものの次数と一致すること。最小元が $d_0$ 以下であること。

## 実行方法

```sh
sage check.sage
```
