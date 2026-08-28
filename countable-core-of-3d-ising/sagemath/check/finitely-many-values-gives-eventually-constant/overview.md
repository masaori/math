# SageMath Check: 有限個の値しかとらない列と末尾定数性

## 対象

**対象ラベル**: `claim_finitely_many_values_gives_eventually_constant`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_finitely_many_values_gives_eventually_constant`）
- 範囲: 極限と異なる定数部分列が極限の一意性に反する有限算術部分、および有限個の有限例外集合から末尾閾値を作る部分
- 併せて検証: `def_limit_quantity_from_finite_box_sequence`、`def_eventually_constant_finite_box_sequence`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_constant_subsequence_conflicts_with_distinct_limit.sage` | 相異なる定数値と極限候補を分離する有理数近傍 | PASS | `QQ` 上で全検査通過 |
| `check_finite_exception_union_threshold.sage` | 有限例外添字の合併の最大元から末尾閾値を作ること | PASS | `ZZ` と `QQ` 上で全検査通過 |

## 備考

- 無限集合から狭義単調増加な添字列を取ること、部分列の収束、Hausdorff 空間での極限の一意性は SageMath の有限検査対象外であり、本文と Lean の検証対象である。
- `ZZ` と `QQ` の厳密計算だけを使い、浮動小数点および新たな非可算への脱出は使わない。

## 実行方法

```bash
for f in sagemath/check/finitely-many-values-gives-eventually-constant/check_*.sage; do sage "$f"; done
```
