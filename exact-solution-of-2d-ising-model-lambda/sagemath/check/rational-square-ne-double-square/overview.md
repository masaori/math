# SageMath Check: 有理数の平方は二倍の平方にならない（混合符号の排除）

## 対象

**対象ラベル**: `claim_rational_square_ne_double_square`

- 実行日: 2026-08-13
- 結果: 通過（分子・分母 1..20 の正負と 0 の有理数の組 640800 組で
  $a\cdot a\ne2\cdot(b\cdot b)$ と証明の鎖の各段を厳密検査した）
- 帰属: `QQ` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

主張は「任意の $a,b\in\mathbb{Q}$ について、$b\ne0$ ならば $a\cdot a\ne2\cdot(b\cdot b)$」。
証明の組み立てを一行ずつ突き合わせる。

- 準備: $b\ne0$ から乗法逆元 $b^{-1}$（$b\cdot b^{-1}=1$）を取り、$r:=a\cdot b^{-1}$ と置く
- 鎖の恒等変形の段: $r\cdot r=(a\cdot b^{-1})\cdot(a\cdot b^{-1})=(a\cdot a)\cdot(b^{-1}\cdot b^{-1})$、
  $(b\cdot b)\cdot(b^{-1}\cdot b^{-1})=(b\cdot b^{-1})\cdot(b\cdot b^{-1})=1\cdot1$、$2\cdot(1\cdot1)=2$
- 背理法の仮定の段の代替: 標本では仮定 $a\cdot a=2\cdot(b\cdot b)$ が成り立たないので、
  代わりに「$a\cdot a=2\cdot(b\cdot b)$ と $r\cdot r=2$ の同値」を検査する
  （鎖はこの同値の $\Rightarrow$ の向きをつないでいる）
- 矛盾の段: $r\cdot r=2$ は `claim_no_rational_square_two`
  （検証 `no-rational-square-two`。3200 個の標本で通過済み）と矛盾する

主張そのものは全称否定なので有限の標本でしか見られないが、鎖の各段は標本の全点で成立する。
`QQ` の等号判定は厳密である。

## 実行方法

```sh
sage check.sage
```
