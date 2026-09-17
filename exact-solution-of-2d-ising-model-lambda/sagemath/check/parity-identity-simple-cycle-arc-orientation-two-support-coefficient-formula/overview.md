# SageMath Check: 二つの正準巡回支持の係数式

## 対象

**対象ラベル**: `claim_two_support_coefficient_formula`

- 帰属: 有限集合と $\mathbb F_2$ の厳密演算。浮動小数点を使わない。
- 一般の辺長・全語長についての検算ではない。
- 実行日: 2026-09-18

## 何を確かめるか

端点特徴代表の 462 軌道と語位置・端点積代表の 616 軌道を
$\mathbb F_2$ 上で加える。共有する 227 軌道では切断位置も一致し、係数が
$1+1=0$ で相殺する。残る 624 軌道について、「二つの軌道係数の和を選択した
切断だけに戻す」係数式が、二つの保存済み支持の対称差と一致することを検査する。

## 実行方法

```sh
sage sagemath/check/parity-identity-simple-cycle-arc-orientation-two-support-coefficient-formula/check.sage
```
