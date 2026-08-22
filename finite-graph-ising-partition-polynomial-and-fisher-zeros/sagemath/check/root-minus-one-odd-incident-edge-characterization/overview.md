# 零点 -1 による奇接続辺数頂点の特徴付けの検算

**対象ラベル**: `theorem_root_minus_one_characterizes_odd_incident_edge_count`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_root_minus_one_characterizes_odd_incident_edge_count`）
- 範囲: `Z_G(-1)=0` と奇数本の辺が接続する頂点の存在との同値性

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_equivalence.sage` | 奇接続辺数頂点がある場合の零評価と、全接続辺数が偶数である場合の評価 `2^{|V|}` を照合する | PASS | 一頂点無辺、一辺、二本・三本の平行辺、三頂点道、三角形、四頂点サイクル、奇接続辺数頂点をもつ四頂点五辺グラフで同値性が成立 |

## 備考

- `NN`、`ZZ`、`ZZ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/root-minus-one-odd-incident-edge-characterization/check_equivalence.sage
```
