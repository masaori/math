# SageMath Check: 自己双対方程式の二根は相異なる

## 対象

**対象ラベル**: `claim_self_dual_quadratic_roots_distinct`

- 実行日: 2026-08-13
- 結果: 通過（$s\cdot s=2$ を満たす 2 通りの $s$ の両方で厳密検査した）
- 帰属: `QQbar`（代数的数）の厳密計算。浮動小数点は使わない。

## 何を確かめるか

主張は「$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$ について $-1+s\ne-1-s$」。
証明は背理法（等しいと仮定すると $s=-s$、$2\cdot s=0$、零因子の不在から $s=0$、
すると $2=s\cdot s=0$ で $2\ne0$ と矛盾）である。検査は次を突き合わせる。

- 準備: $2\ne0$
- 主張そのもの: 各 $s$ で $-1+s\ne-1-s$
- 鎖の各段（対偶側）: $s\ne0$、$2\cdot s=(1+1)\cdot s=1\cdot s+1\cdot s=s+s$、$2\cdot s\ne0$
- 背理法の最終段: $0\cdot 0=0$ と $2\ne 0\cdot 0$

$s\cdot s=2$ の解は 2 つあり、主張は任意の $s$ についてなので、両方の $s$ で検査する。
`QQbar` の等号判定は厳密（根分離）であり、数値近似を経由しない。

## 実行方法

```sh
sage check.sage
```
