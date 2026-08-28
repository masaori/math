# SageMath Check: 剰余類ごとの値の食い違いと極限量の非存在

## 対象

**対象ラベル**: `claim_residue_class_values_differ_no_limit_quantity`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_residue_class_values_differ_no_limit_quantity`）
- 範囲: 二つの剰余類部分列が相異なる定数列になること、および相異なる二定数の有理数近傍が両立しないこと
- 併せて検証: `claim_eventually_periodic_residue_class_constant`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_distinct_residue_subsequences.sage` | 二つの剰余類部分列がそれぞれ相異なる代表値で一定になること | PASS | `ZZ` と `QQ` 上で全検査通過 |
| `check_disjoint_rational_neighborhoods.sage` | 距離の 3 分の 1を幅に取ると二定数の近傍が両立しないこと | PASS | `QQ` 上で全検査通過 |

## 備考

- 収束列の部分列が同じ極限へ収束すること自体は箱の大きさの極限に属するため、SageMath ではなく本文と Lean の検証対象である。ここでは矛盾の有限算術部分だけを検査する。
- `ZZ` と `QQ` の厳密計算だけを使い、浮動小数点および新たな非可算への脱出は使わない。

## 実行方法

```bash
for f in sagemath/check/residue-class-values-differ-no-limit-quantity/check_*.sage; do sage "$f"; done
```
