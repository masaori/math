# 全頂点の接続辺数が偶数の場合の -1 評価の検算

**対象ラベル**: `theorem_even_incident_edge_counts_evaluation_minus_one`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_even_incident_edge_counts_evaluation_minus_one`）
- 範囲: 上向きスピン頂点集合に接続する辺端の二重計数、破れ辺数の偶数性、`ZZ[x]` での `-1` 評価

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_incident_edge_count_identity.sage` | 上向きスピン頂点集合の接続辺数和が、内部辺数の二倍と破れ辺数の和に一致する | PASS | 四例の全配位で整数等式と破れ辺数の偶数性が一致 |
| `check_polynomial_evaluation.sage` | 全配位の `-1` 評価項が `1` となり、分配多項式の評価値が配位数に一致する | PASS | 四例で `Z_G(-1)=2^{|V|}` |

## 備考

- 一頂点無辺、三角形、四頂点サイクル、二本の平行辺の全配位を有限列挙する。
- `NN`、`ZZ`、`ZZ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/even-incident-edge-counts-evaluation-minus-one/check_*.sage; do sage "$f"; done
```
