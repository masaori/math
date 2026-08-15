# SageMath Check: 開境界密度の上界と上限の存在

## 対象

**対象ラベル**: `claim_open_free_energy_density_upper_bound`, `def_open_free_energy_density_value_set`, `claim_open_free_energy_density_supremum_exists`

- 実行日: 2026-08-15
- 状態: PASS（20 件）
- 帰属: 配位数・辺数・分配多項式の値は `ZZ` / `QQ` で厳密に検査する。実対数を含む密度の比較だけ `RealBallField(256)` を使う。

## 検査内容

- 一辺 1, 2, 3 の開境界正方形について、辺数 `2L(L-1) ≤ 2L²`、配位数 `2^(L²)`、分配多項式の値の上界を厳密検査する。
- 正の有理点 5 点で、開境界密度の一様上界を ball の端点で検査する。
- 有限値集合をモデルとして、非空性・共通上界・有限集合の上限性を検査する。

## 範囲

実数の完備性そのものは有限標本では検査できない。Lean 具体版は、空でないことと上に有界であることを示した後、本文で宣言済みの完備性を一度だけ適用する。必要十分版は既存の `indexedValueSet_has_supremum_necSuf` を特殊化する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-free-energy-density-supremum/check.sage
```
