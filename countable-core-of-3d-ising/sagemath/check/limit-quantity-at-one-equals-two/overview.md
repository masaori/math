# SageMath Check: 有理点 1 での極限量

## 対象

**対象ラベル**: `claim_limit_quantity_at_one_equals_two`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `constant_coarse_graining_witness_claim_limit_at_one`）
- 範囲: 有限箱の値と正の乗根が箱サイズによらず 2 になるまで
- 併せて検証: `claim_partition_value_at_one`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_partition_value_at_one.sage` | 小さい自由境界箱を全数列挙し、$Z_L(1)=2^{\#V_L}$ を検査 | PASS | $L=1,2$ で一致 |
| `check_positive_root.sage` | $2$ が $2^{\#V_L}$ の正の $\#V_L$ 乗根であることを代数的数の厳密等号で検査 | PASS | $L=1,2,3,4$ で一致 |
| `check_constant_finite_box_values.sage` | 有限箱量が箱サイズによらず $2$ であることを検査 | PASS | $L=1,2,3,4$ で全項が $2$ |

## 備考

- `ZZ`・`ZZ[X]`・`QQbar` の厳密計算だけを使い、浮動小数点は使わない。
- 定数列が自身の値へ収束する最終段は箱サイズ極限による許可済みの非可算への脱出であり、有限個の SageMath 計算では検証しない。本文では定数列の極限定理として明示している。
- 2026-08-24 に全ファイルを実行し、すべて通過した。

## 実行方法

```bash
for f in sagemath/check/limit-quantity-at-one-equals-two/check_*.sage; do sage "$f"; done
```
