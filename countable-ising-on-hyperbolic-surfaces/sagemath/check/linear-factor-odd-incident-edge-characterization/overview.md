# 一次因子 x+1 による奇接続辺数頂点の特徴付けの検算

**対象ラベル**: `theorem_linear_factor_characterizes_odd_incident_edge_count`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_linear_factor_characterizes_odd_incident_edge_count`）
- 範囲: `x+1` による整数係数多項式の除法の余り、`-1` 評価、奇接続辺数頂点の存在の三条件の同値性

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_equivalence.sage` | 除法等式、余りと `-1` 評価の一致、一次因子による整除と奇接続辺数頂点の存在との同値性 | PASS | 一頂点無辺、一辺、二本・三本の平行辺、三頂点道、三角形、四頂点サイクル、奇接続辺数頂点をもつ四頂点五辺グラフで成立 |

## 備考

- `NN`、`ZZ`、`ZZ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/linear-factor-odd-incident-edge-characterization/check_equivalence.sage
```
