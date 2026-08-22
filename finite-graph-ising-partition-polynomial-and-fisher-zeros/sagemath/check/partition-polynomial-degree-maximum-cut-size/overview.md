# Ising 分配多項式の次数と最大カット辺数の検算

**対象ラベル**: `theorem_partition_polynomial_degree_maximum_cut_size`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_partition_polynomial_degree_maximum_cut_size`）
- 範囲: Ising 分配多項式の次数が、頂点部分集合とその補集合を横切る辺数の最大値に等しいこと

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_maximum_cut_size.sage` | スピン配位の破れ辺数集合と頂点部分集合のカット辺数集合が一致し、その最大値が `ZZ[x]` 上の分配多項式の次数に等しい | PASS | 三角形、四頂点サイクル、完全四頂点グラフ、二本の平行辺で一致 |

## 備考

- 全スピン配位と全頂点部分集合を有限列挙し、`NN` と `ZZ[x]` の厳密演算だけを用いる。
- 実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/partition-polynomial-degree-maximum-cut-size/check_maximum_cut_size.sage
```
