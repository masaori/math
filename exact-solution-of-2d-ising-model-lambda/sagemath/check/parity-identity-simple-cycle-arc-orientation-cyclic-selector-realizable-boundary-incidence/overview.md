# SageMath Check: 実現可能な境界入射による切断候補の分離

## 対象

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`、`claim_cut_flag_realizable_candidate_selection`

- 帰属: 有限集合と整数の厳密演算。浮動小数点を使わない。
- 一般の辺長についての命題ではない。
- 実行日: 2026-09-18
- 結果: 成功。方向上連結する 1,036 入射から座標上実現不能な 385 入射を除くと、残る
  651 入射の記述は 94 種になり、選択順位が反対になる衝突は無かった。
- 二候補の実現可能性は、候補 0 だけが 174 項、候補 1 だけが 153 項、両方が 162 項だった。
  従って実現可能候補の一意性は成り立たない。一方、保存済み切断位置は全 489 項で実現可能であり、
  実現可能候補集合の最小元と一致した。

## 何を確かめるか

二つの切断候補がともに方向上連結する 489 項について、前段で座標上実現可能と判定した境界入射だけを
各候補の記述へ残す。端点対を使わない実現可能入射記述だけで、実際に選ばれた候補の順位を分類し、
同じ記述が反対の順位を要求しないかを判定する。

実現可能入射記述 94 種には衝突が無かった。従って前段で必要に見えた五つの切断旗と一つの選択辺所属は、
方向上は連結するが座標上は実現不能な入射を混ぜた分類に由来する。実現可能性を先に課せば、これら六つの
端点ビットは候補の分離に必要ない。ただしこれは観測済みの一辺二・三の支持上の有限判定であり、
一般の語長に対する切断選択規則ではない。

この有限判定は、実現可能候補が一意であることを示さない。両候補が実現可能な 162 項がある。
支持係数の再構成には、一般命題 `claim_cut_flag_realizable_candidate_selection` が定める
「実現可能候補集合の最小元」を使う必要がある。保存済み切断位置は全項でこの最小元と一致する。

## 実行方法

```sh
sage sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-realizable-boundary-incidence/check.sage
sage sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-realizable-boundary-incidence/verify-certificate.sage
```
