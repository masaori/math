# SageMath Check: 有理点 2 では有限箱の量の列は定数列でない

## 対象

**対象ラベル**: `claim_finite_box_sequence_at_two_is_not_constant`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_finite_box_sequence_at_two_is_not_constant`）
- 範囲: $a_1(2)=2$ と $a_2(2)>2$ を与える有限箱側の等式・不等式まで
- 併せて検証: `claim_partition_value_at_one`, `claim_partition_coefficients_nonnegative`, `claim_partition_support_endpoints`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_finite_box_values_at_two.sage` | $L=1$ の箱に辺が無く $Z_1$ が定数 $2$ であること、$L=2$ の箱で係数が非負・最高次係数が $2$ 以上・$Z_2(2)>Z_2(1)=2^8$ であること、二つの正の乗根が相異なることを検査 | PASS | $\#E_1=0$、$Z_1=2$、$a_1(2)=2$、$\#E_2=12$、$Z_2(1)=256$、$Z_2(2)=36450$、$a_2(2)>2$ |

## 備考

- `ZZ`・`ZZ[X]`・`QQbar` の厳密計算だけを使い、浮動小数点は使わない。
- 箱の大きさの極限は取らない。本主張は二つの項の比較だけで閉じる有限側の言明である。
- 2026-08-24 に実行し、全て通過した。

## 実行方法

```bash
sage sagemath/check/finite-box-sequence-at-two-is-not-constant/check_finite_box_values_at_two.sage
```
