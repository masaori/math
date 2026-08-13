# SageMath Check: 一と s の一次独立性

## 対象

**対象ラベル**: `claim_one_s_linearly_independent`

- 実行日: 2026-08-13
- 結果: 通過（$s\cdot s=2$ を満たす `QQbar` の 2 根 × 有理数の標本で、
  $(a,b)\ne(0,0)$ の 4416 組すべてで $a+b\cdot s\ne0$、$b\ne0$ の鎖 4324 組、
  $b=0$ の段 92 組を厳密検査した）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

主張は「$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$ と任意の $a,b\in\mathbb{Q}$ について、
$a+b\cdot s=0$ ならば $(a,b)=(0,0)$」。証明の組み立てを一行ずつ突き合わせる。

- 準備: $b\ne0$ の場合の逆元の等式 $b^{-1}\cdot b=1$ と $r:=b^{-1}\cdot(-a)\in\mathbb{Q}$
- 鎖の結合則の段（仮定に依存しない）: $b^{-1}\cdot(b\cdot s)=(b^{-1}\cdot b)\cdot s=s$
- 矛盾の段: $r\in\mathbb{Q}$ なので $r\cdot r\ne2$（`claim_no_rational_square_two`）。
  したがって $s\ne r$ であり、対偶として $a+b\cdot s\ne0$
- $b=0$ の段: $a+0\cdot s=a$ なので $a\ne0$ なら $a+b\cdot s\ne0$

背理法の仮定 $a+b\cdot s=0$（$(a,b)\ne(0,0)$）は偽なので標本では実現できない。
そのため仮定に依存する鎖はその対偶（$s\ne r$ ゆえ $a+b\cdot s\ne0$）で見た。
`QQ`・`QQbar` の等号判定は厳密である。

## 実行方法

```sh
sage check.sage
```
