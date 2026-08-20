# Ising 分配多項式の次数と最大破れ辺数の検算

**対象ラベル**: `theorem_partition_polynomial_degree_maximum_broken_edge_count`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_partition_polynomial_degree_maximum_broken_edge_count`）
- 範囲: Ising 分配多項式の次数が、有限スピン配位全体で実現する最大破れ辺数に等しいこと

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_degree_from_coefficients.sage` | `ZZ[x]` 上の次数が非零多重度をもつ最大次数に等しい | PASS | 三角形、四頂点サイクル、二本の平行辺で一致 |
| `check_multiplicity_support_is_broken_count_image.sage` | 非零多重度の台が破れ辺数写像の有限像に一致する | PASS | 三つの有限グラフの全スピン配位で集合として一致 |

## 備考

- 全スピン配位を有限列挙し、`NN` と `ZZ[x]` の厳密演算だけを用いる。
- 実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/partition-polynomial-degree-maximum-broken-edge-count/check_*.sage; do sage "$f"; done
```
