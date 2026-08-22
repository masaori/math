# 全ての辺を横切る頂点二分割による係数対称性の検算

**対象ラベル**: `theorem_full_cut_coefficient_symmetry`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_full_cut_coefficient_symmetry`）
- 範囲: 全ての辺を横切る頂点部分集合上でのスピン反転が破れ辺数を補数へ移し、Ising 分配多項式の係数を辺数を中心に対称にすること

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_symmetry.sage` | 頂点部分集合上の反転の対合性、破れ辺数の補数関係、`ZZ[x]` 係数の対称性 | PASS | 一辺、三頂点道、四頂点サイクル、二本の平行辺で一致。三角形では仮定が成立せず係数対称性も成立しない |

## 備考

- 全スピン配位を有限列挙し、`NN` と `ZZ[x]` の厳密演算だけを用いる。
- 実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-coefficient-symmetry/check_coefficient_symmetry.sage
```
