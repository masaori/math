# 因子 2(x+1) による奇接続辺数頂点の特徴付けの検算

**対象ラベル**: `theorem_even_linear_factor_characterizes_odd_incident_edge_count`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_even_linear_factor_characterizes_odd_incident_edge_count`）
- 範囲: 全係数の偶数性による半分の多項式、`-1` 評価、モニック一次除法、因子 `2(x+1)` と奇接続辺数頂点の存在の同値性

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_even_coefficient_factorization.sage` | 各係数の偶数性と `Z_G(x)=2P_G(x)` | PASS | 全八例で整数係数の半分と多項式の復元が一致 |
| `check_half_polynomial_root.sage` | `Z_G(-1)=0` から `P_G(-1)=0` への移行 | PASS | 奇接続辺数頂点をもつ全例で整数評価の消去が成立 |
| `check_half_polynomial_division.sage` | `P_G(-1)=0` と `x+1` による除法、`2(x+1)` 因子の復元 | PASS | 全八例で除法等式、余り、因子の復元が成立 |
| `check_equivalence.sage` | `2(x+1)` による整除と奇接続辺数頂点の存在との同値性 | PASS | 一頂点無辺、一辺、二本・三本の平行辺、三頂点道、三角形、四頂点サイクル、奇接続辺数頂点をもつ四頂点五辺グラフで成立 |

## 備考

- `NN`、`ZZ`、`ZZ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for check_file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/even-linear-factor-odd-incident-edge-characterization/check_*.sage; do
  sage "$check_file"
done
```
