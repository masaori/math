# 代数的評価点における Fisher 零点差の逆数和の検算

**対象ラベル**: `def_fisher_zero_algebraic_shifted_reciprocal_sum`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_definition_fisher_zero_algebraic_shifted_reciprocal_sum`）
- 範囲: 零点差の非零性、重複度込み逆数和の並べ方への不変性、次数零の空和
- 依存する本文ラベル: `theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_nonzero_differences.sage` | 非零な代数的評価値から全ての零点差が非零となり、逆数和が `QQbar` に属すること | PASS | 全例・全対象評価点で成立 |
| `check_order_independence.sage` | 重複度込み零点列を逆順にしても逆数和が不変であること | PASS | 全例・全対象評価点で一致 |
| `check_degree_zero_empty_sum.sage` | 次数零の空和 | PASS | 空和が `QQbar(0)` に一致 |

## 備考

- 無辺グラフ、一辺グラフ、四辺道、五サイクル、四頂点完全グラフを用いる。
- 代数的評価点は `t^2-2`、`t^2+1`、`t^3-2` の全ての `QQbar` 根とし、厳密演算だけを用いる。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum/check_*.sage; do
  sage "$file"
done
```
