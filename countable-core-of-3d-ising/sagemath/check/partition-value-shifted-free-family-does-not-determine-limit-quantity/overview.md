# SageMath Check: ずらした自由族の分配多項式値は極限量を決めない

## 対象

**対象ラベル**: `claim_shifted_free_family_partition_value_does_not_determine_limit_quantity`

- ファイル: `structured-latex/content/partition-values.ts`
- ブロック: `soundness_bridge_claim_shifted_free_family_partition_value_does_not_determine_limit_quantity`
- 併せて検証: `claim_shifted_free_family_partition_values_differ_but_finite_box_quantities_agree`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_partition_values_differ.sage` | $Z_2(1)=2^8\ne2^{27}=Z'_2(1)$ | PASS | `ZZ` 上で不一致を確認 |
| `check_finite_box_quantities_agree_at_one.sage` | $a_L(1)=2=a'_L(1)$ の根拠となる有限べき等式 | PASS | $L=1,\ldots,6$ とその末尾ずらしで確認 |

## 備考

- すべて `ZZ` 上の厳密計算であり、浮動小数点を使わない。
- 正の整数乗根の一意性は本文で使う実数の初等定理である。SageMath では、その適用前提となる有限べき等式を整数上で検証する。
- 極限量の一致は、既に四層で検証済みの末尾ずらし定理を本文が参照するため、この有限計算では再検証しない。
- 2026-08-18 実行。全チェック通過。

## 実行方法

```bash
for f in sagemath/check/partition-value-shifted-free-family-does-not-determine-limit-quantity/check_*.sage; do sage "$f"; done
```
