# SageMath Check: 二次体の零元の特徴づけと加法逆元の表示

## 対象

**対象ラベル**: `claim_quadratic_zero_representation`

（同じ検証で `claim_quadratic_negation_representation` の内容も見る。）

- 実行日: 2026-08-13
- 結果: 通過（加法逆元の両立 19 組、零元の特徴づけ 722 組、
  加法逆元の表示の鎖 722 組を厳密検査した）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

主張は「$s\cdot s=2$ を満たす $s\in\overline{\mathbb{Q}}$ について、
$0\in Q_s$ であり $\xi=0\iff\mathrm{rep}_s(\xi)=(0,0)$」（零元の特徴づけ）と、
「$\xi\in Q_s$、$(a,b):=\mathrm{rep}_s(\xi)$ について、$-\xi\in Q_s$ であり
$\mathrm{rep}_s(-\xi)=(-a,-b)$」（加法逆元の表示）。

- **zero-chain**: 準備の鎖 $0=0+0=0+0\cdot s$ の各段が `QQbar` の厳密等号で成り立つ。
- **zero-iff**: 標本の全組（分子 $-4..4$、分母 $1..3$ の有理数の組、$s$ の 2 根）で
  「$a+b\cdot s=0\iff(a,b)=(0,0)$」が成り立つ。第一の方向は表示の一意性の適用、
  第二の方向は本文の第二の方向の鎖の裏取りである。
- **neg-compat**: $\mathbb{Q}$ の加法逆元と $\overline{\mathbb{Q}}$ の加法逆元の一致
  （準備の段の裏取り）。
- **neg-chain / neg-rep**: 本文の鎖 $-(a+b\cdot s)=(-a)+(-(b\cdot s))=(-a)+(-b)\cdot s$ を
  一段ずつ `QQbar` の厳密等号で確かめる。表示の一意性
  （`claim_quadratic_representation_unique`。別の検証で裏取り済み）のもとで、
  終点の表示 $(-a,-b)$ がそのまま $\mathrm{rep}_s(-\xi)=(-a,-b)$ を与える。

## 実行方法

```sh
sage check.sage
```
