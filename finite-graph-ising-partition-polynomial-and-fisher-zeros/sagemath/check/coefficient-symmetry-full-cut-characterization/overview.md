# 係数対称性による全辺二分割の特徴付けの検算

**対象ラベル**: `theorem_coefficient_symmetry_characterizes_full_cut`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_coefficient_symmetry_characterizes_full_cut`）
- 範囲: 係数対称性から最高次数の正多重度を得て、全辺を破る配位から全辺二分割を復元する逆向きと、既存定理を含む同値性

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_zero_multiplicity_is_positive.sage` | 全頂点下向き配位が破れ辺数零のファイバーに属し、`Omega_G(0) >= 1` となること | PASS | 全有限例で成立 |
| `check_symmetry_recovers_full_cut.sage` | 係数対称性から最高次数の配位を得て、その上向き頂点集合が全辺二分割になること | PASS | 全有限例で証人を復元 |
| `check_equivalence.sage` | 全辺二分割の存在と `ZZ[x]` の全係数対称性の同値性 | PASS | 全有限例で真理値が一致 |

## 備考

- 一頂点無辺、一辺、三頂点道、三角形、四頂点サイクル、完全四頂点グラフ、二本の平行辺を全列挙する。
- 有限集合、`NN`、`ZZ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/coefficient-symmetry-full-cut-characterization/check_*.sage; do
  sage "$file"
done
```
