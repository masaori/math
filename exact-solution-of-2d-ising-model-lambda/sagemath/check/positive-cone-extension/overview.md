# SageMath Check: 部分体の正錐の延長

## 対象

**対象ラベル**: `def_positive_cone_extension`

- 実行日: 2026-11-17
- 結果: $\mathbb Q\subseteq Q_s$ の二つの正錐がともに $\mathbb Q_{>0}$ を延長することが有限標本で通過
- 帰属: `QQ` の厳密計算。浮動小数点を使わない。

## 何を確かめるか

$F=\mathbb Q\subseteq E=Q_s$（$s\cdot s=2$）、$C_F=\mathbb Q_{>0}$ について、
延長の条件 $C_E\cap F=C_F$ を有限標本で確かめる。$E$ の元 $a+b\cdot s$ は組 $(a,b)$、
$F$ の元 $a$ は組 $(a,0)$ で表す。普遍量化された条件そのものの証明ではない。

- $C_E=P_s$（`def_quadratic_positive_cone`）と、共役の正錐 $C_E'=\{(a,b)\mid(a,-b)\in P_s\}$ の
  どちらも、標本 64 点で $E$ の正錐の三条件を満たす。
- どちらも $F$ の標本 8 点で $C_E\cap F=C_F$ を満たす。
- $s=(0,1)$ は $P_s$ に入り $C_E'$ に入らないので、延長は一つとは限らない。

## 実行方法

```sh
sage check.sage
```
