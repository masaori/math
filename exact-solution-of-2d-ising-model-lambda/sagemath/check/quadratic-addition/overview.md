# SageMath Check: 二次体の和の表示

## 対象

**対象ラベル**: `claim_quadratic_addition_mem`、`claim_quadratic_addition_representation`

- 実行日: 2026-08-13
- 結果: 通過（和の両立 49 組、和の鎖と表示 4802 組を厳密検査した）
- 帰属: `QQ` / `QQbar` の厳密計算。浮動小数点は使わない。

## 何を確かめるか

二主張は「$\xi+\eta\in Q_s$」「$\mathrm{rep}_s(\xi+\eta)=(a+a',b+b')$」である。

- **add-compat**: $\mathbb{Q}$ の和と $\overline{\mathbb{Q}}$ の和の一致（準備の段の裏取り）。
- **add-chain**: 標本の全 $((a,b),(a',b'))$（分子 $-2..2$、分母 $1..2$ の 7 値の四つ組、
  $s$ の 2 根）で、本文の鎖
  $(a+b\cdot s)+(a'+b'\cdot s)=\dots=(a+a')+(b+b')\cdot s$ の七段を一段ずつ
  `QQbar` の厳密等号で確かめる。
- **add-rep**: 終点の表示 $(a+a',b+b')$ が $\xi+\eta$ の表示であること。表示の一意性
  （`claim_quadratic_representation_unique`。別の検証で裏取り済み）のもとで、
  そのまま $\mathrm{rep}_s(\xi+\eta)=(a+a',b+b')$ を与える。

## 実行方法

```sh
sage check.sage
```
