# SageMath Check: 有限箱の量が定数列なら有理点は 1 である

## 対象

**対象ラベル**: `claim_constant_finite_box_sequence_only_at_one`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_constant_finite_box_sequence_only_at_one`）
- 範囲: 箱 1 の値から $a_2(q)=2$ を導き、$Z_2$ の狭義単調性で $q=1$ を結論する証明全体
- 併せて検証: `def_limit_quantity_from_finite_box_sequence`、`claim_partition_value_at_one`、`claim_partition_coefficients_nonnegative`、`claim_partition_support_endpoints`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_box_one_value.sage` | 箱 1 に辺が無く、正の有理点で $Z_1(q)=2$、$\#V_1=1$ ゆえ $a_1(q)=2$ | PASS | 5 つの正の有理点で成立 |
| `check_constant_forces_partition_value.sage` | $\#V_2=8$ と $a_2(q)=2$ から $Z_2(q)=2^8$、および $Z_2(1)=2^8$ | PASS | 成立 |
| `check_strict_monotonicity.sage` | $Z_2$ の係数の非負性・最高次係数の正値・正の有理数上の狭義単調増加・$Z_2(q)=Z_2(1)$ の正の有理解が 1 のみ | PASS | 辺数 12、正の有理解は $q=1$ のみ |

## 備考

- 箱の一辺を 1 と 2 に固定し、有限集合・`ZZ`・`QQ`・`ZZ[X]` だけで厳密に検証する。
- $a_L(q)=Z_L(q)^{1/\#V_L}$ の正の実数乗根は、箱 1 では $\#V_1=1$ のため現れず、箱 2 では
  8 乗した形 $Z_2(q)=a_2(q)^8$ で扱うため、検証は可算側の厳密計算だけで閉じている。
- 浮動小数点は使わない。箱の大きさの極限も取らない。
- 2026-08-24 に全ファイルを実行し、すべて通過した。

## 実行方法

```sh
for f in sagemath/check/constant-finite-box-sequence-only-at-one/check_*.sage; do sage "$f"; done
```
