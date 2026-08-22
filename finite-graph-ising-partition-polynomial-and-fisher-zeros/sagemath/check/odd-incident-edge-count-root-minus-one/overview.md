# 奇数本の辺が接続する頂点と零点 -1 の検算

**対象ラベル**: `theorem_odd_incident_edge_count_root_minus_one`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_odd_incident_edge_count_root_minus_one`）
- 範囲: 一頂点反転による破れ辺数の変化、符号反転、二元軌道内の相殺

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_broken_edge_count_change.sage` | 接続辺上だけ破れ状態が反転し、破れ辺数が `b + |I_w| - 2r` になる | PASS | 四例の全配位で集合の対称差と整数等式が一致 |
| `check_sign_reversal.sage` | 接続辺数が奇数なら一頂点反転前後の `-1` の冪が逆符号になる | PASS | 四例の全配位で整数符号が反転 |
| `check_pair_cancellation.sage` | 不動点を持たない対合の全二元軌道が相殺し、`ZZ[x]` の `-1` 評価が零になる | PASS | 四例で有限和と多項式評価がともに零 |

## 備考

- 一辺グラフ、三頂点道、三本の平行辺、奇数次数頂点をもつ四頂点五辺グラフの全配位を有限列挙する。
- `NN`、`ZZ`、`ZZ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/odd-incident-edge-count-root-minus-one/check_*.sage; do sage "$f"; done
```
