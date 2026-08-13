# SageMath Check: 二次体の積の表示

## 対象

**対象ラベル**: `claim_quadratic_multiplication_mem`、`claim_quadratic_multiplication_representation`

- 実行日: 2026-08-13
- 結果: 通過（積・和の両立 49 組、補助等式と鎖と表示 4802 組を厳密検査した）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

二主張は「$\xi\cdot\eta\in Q_s$」「$\mathrm{rep}_s(\xi\cdot\eta)=(a\cdot a'+2\cdot(b\cdot b'),\ a\cdot b'+b\cdot a')$」である。

- **mul-compat**: $\mathbb{Q}$ の和・積と $\overline{\mathbb{Q}}$ の和・積の一致（準備の段の裏取り）。
- **mul-aux**: 標本の全 $((a,b),(a',b'))$（分子 $-2..2$、分母 $1..2$ の 7 値の四つ組、
  $s$ の 2 根）で、本文の三つの補助等式
  $a\cdot(b'\cdot s)=(a\cdot b')\cdot s$（1 段）、
  $(b\cdot s)\cdot a'=(b\cdot a')\cdot s$（3 段）、
  $(b\cdot s)\cdot(b'\cdot s)=2\cdot(b\cdot b')$（7 段。$s\cdot s=2$ を使う）を一段ずつ
  `QQbar` の厳密等号で確かめる。
- **mul-chain**: 同じ標本で、本文の鎖
  $(a+b\cdot s)\cdot(a'+b'\cdot s)=\dots=(a\cdot a'+2\cdot(b\cdot b'))+(a\cdot b'+b\cdot a')\cdot s$
  の十四段を一段ずつ `QQbar` の厳密等号で確かめる。
- **mul-rep**: 終点の表示 $(a\cdot a'+2\cdot(b\cdot b'),\ a\cdot b'+b\cdot a')$ が
  $\xi\cdot\eta$ の表示であること。表示の一意性
  （`claim_quadratic_representation_unique`。別の検証で裏取り済み）のもとで、
  そのまま $\mathrm{rep}_s(\xi\cdot\eta)$ を与える。

## 実行方法

```sh
sage check.sage
```
