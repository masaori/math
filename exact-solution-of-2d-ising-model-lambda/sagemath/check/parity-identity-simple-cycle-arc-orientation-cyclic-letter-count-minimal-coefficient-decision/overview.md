# SageMath Check: 文字出現回数の最小成分

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

- 実行日: 2026-09-18
- 結果: PASS
- 帰属: 有限集合と $\mathbb F_2$ 上の係数。浮動小数点を使わない。

## 何を確かめるか

一辺二・三から得た 9,739 弧型について、前段で選んだ相対端点 10 成分を固定する。
内部語に現れる 216 種の文字それぞれの出現回数を候補とし、二つの正準巡回支持の
係数対が異なる 38,352 弧型対を全て分ける最小の文字集合を二値整数計画で求める。

36,603 種の相違成分集合を全て横切る最小集合は 98 文字である。この 98 個の
出現回数と相対端点 10 成分との組により、9,739 弧型は 8,969 記述へ分かれ、
端点だけの支持・語位置と端点の支持のどちらでも係数衝突は零になる。

これは有限データ上の最小性であり、一般の辺長・全語長に対する閉じた係数式ではない。
選ばれた 98 文字の全体は `certificate.json` に保存する。

## 実行方法

```sh
sage sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-letter-count-minimal-coefficient-decision/check.sage
```
