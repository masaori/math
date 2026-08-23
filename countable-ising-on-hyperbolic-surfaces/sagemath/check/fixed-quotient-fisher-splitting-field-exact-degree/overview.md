# 固定剰余類格子の Fisher 分解体の厳密次数

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_exact_degree`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_exact_degree`）
- 範囲: 有限 Galois 拡大の次数公式、全対称群同定、四十四元集合上の全対称群の位数を結ぶ等式
- 併せて検証: `theorem_fixed_quotient_fisher_splitting_field_finite_degree`、`theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_symmetric_group_order.sage` | 四十四元集合上の全対称群の位数が `44!` であり、その整数値が表示値と一致すること | PASS | `SymmetricGroup(44).order() = 44! = 2658271574788448768043625811014615890319638528000000000` |

## 備考

- 有限 Galois 拡大の次数が Galois 群の位数に等しいことは証明本文の群論的入力である。SageMath は、直前の定理で同定済みの全対称群の位数と最終次数を有限置換群と整数上で厳密検算する。
- `ZZ`、`NN`、有限置換群だけを用い、浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-exact-degree/check_symmetric_group_order.sage
```
