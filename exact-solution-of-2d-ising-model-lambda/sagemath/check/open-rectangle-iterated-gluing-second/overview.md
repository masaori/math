# SageMath Check: 開境界長方形の第二座標方向の反復接合不等式

## 対象

**対象ラベル**: `claim_open_rectangle_iterated_gluing_second`

- 実行日: 2026-08-15
- 結果: すべて通過（40 組）
- 帰属: 配位・辺・破れボンド数・反復回数は有限集合と $\mathbb{N}$、評価点と
  分配多項式の値は $\mathbb{Q}_{>0}$ で厳密に計算した。浮動小数点・`RR`・`CC` は使わない。

## 何を確かめるか

$(a,b,k)\in\{(1,1,1),(1,1,2),(1,1,3),(2,1,1),(2,1,2),(2,1,3),(1,2,1),(1,2,2)\}$ と
$t\in\{1/3,1/2,1,2,3\}$ の全組について、本文の二場合の上下評価を検査する。

## 検査できないこと（黙って広げない）

有限標本検査は任意の正の実数 $t$、任意の長方形、任意の反復回数についての証明ではない。
本文は、一回の第二座標方向の接合不等式を反復回数について帰納的に適用して一般の場合を証明する。
Lean は具体版 `openPartitionValue_iteratedGlueSecond_bounds_of_le_one` / `_of_one_le`
（`lean/Ising2DLambda/ThermodynamicLimit/OpenRectangleIteratedGluingSecond.lean`）、
必要十分版 `iterated_glue_pow_bounds_necSuf`（接ぐ向きに依らないので第一座標方向と同じ定理を使う）、
導出版 `..._from_necSuf` が揃い、`lake build` と sorry 非依存検査を通っている（2026-08-15）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-rectangle-iterated-gluing-second/check.sage
```
