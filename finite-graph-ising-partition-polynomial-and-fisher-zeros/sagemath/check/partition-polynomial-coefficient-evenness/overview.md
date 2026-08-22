# Ising 分配多項式の全係数の偶数性の検算

**対象ラベル**: `theorem_partition_polynomial_coefficient_evenness`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_partition_polynomial_coefficient_evenness`）
- 範囲: 空でない有限頂点集合をもつ任意の入力グラフで、各破れ辺数の多重度が偶数になること

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_evenness.sage` | 大域スピン反転が不動点を持たない対合であり、破れ辺数の各ファイバーを保存して、その元数と `ZZ[x]` の係数が偶数になる | PASS | 一頂点無辺、一辺、三角形、四頂点サイクル、二本の平行辺で一致 |

## 備考

- 全スピン配位を有限列挙し、`NN` と `ZZ[x]` の厳密演算だけを用いる。
- 実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/partition-polynomial-coefficient-evenness/check_coefficient_evenness.sage
```
