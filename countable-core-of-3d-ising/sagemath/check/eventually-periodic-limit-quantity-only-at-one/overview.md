# SageMath Check: 末尾周期的で極限量を持つ正の有理点の分類

## 対象

**対象ラベル**: `claim_eventually_periodic_limit_quantity_only_at_one`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_eventually_periodic_limit_quantity_only_at_one`）
- 範囲: 剰余類ごとの有限個の値の排他的な場合分け、および全一致の場合の末尾定数性への接続
- 併せて検証: `claim_residue_class_values_differ_no_limit_quantity`、`claim_residue_class_values_agree_gives_eventually_constant`、`claim_eventually_constant_only_at_one`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_residue_value_dichotomy.sage` | 有限個の剰余類値は、全一致または相異なる二値の存在の一方だけを満たすこと | PASS | `QQ` 上で全検査通過 |
| `check_agreeing_case_reduces_to_one.sage` | 全一致の場合に列が末尾定数となり、既存分類の候補 `q = 1` へ接続すること | PASS | `ZZ` と `QQ` 上で全検査通過 |

## 備考

- 相異なる二値の場合に極限量が存在しないこと、および末尾定数となる正の有理点が 1 に限られることは、参照先の主張で既に四層検証済みである。ここでは新しい定理が追加した有限の場合分けと接続だけを検査する。
- `ZZ` と `QQ` の厳密計算だけを使い、浮動小数点および新たな非可算への脱出は使わない。

## 実行方法

```bash
for f in sagemath/check/eventually-periodic-limit-quantity-only-at-one/check_*.sage; do sage "$f"; done
```
