# SageMath Check: 分配多項式の台の両端

## 対象

**対象ラベル**: `claim_partition_support_endpoints`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `partition_support_endpoints_claim`）
- 範囲: 定数配位から両端の多重度を得て、係数と多重度の一致から台の両端を定める証明全体
- 併せて検証: `def_broken_count`、`claim_odd_flip_involution`、`claim_broken_complement`、`def_multiplicity`、`claim_partition_coefficients_nonnegative`、`def_partition_polynomial`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_constant_configurations.sage` | 定数配位二つが相異なり、破れ辺集合が空で破れ数が 0 | PASS | `L=1,2` で成立 |
| `check_odd_flip_full_breaking.sage` | 奇数側反転後の破れ数が辺数から元の破れ数を引いた値で、二つの像が相異なる | PASS | `L=1,2` で成立 |
| `check_endpoint_multiplicities.sage` | 両端の水準集合の元の個数が 2 以上 | PASS | `L=1,2` で成立 |
| `check_polynomial_support_endpoints.sage` | 両端係数と多重度の一致、非零性、有限和の外側の係数が 0 | PASS | `L=1,2` で成立 |

## 備考

- 箱の一辺を 1 と 2 に固定し、有限集合・`ZZ`・`ZZ[X]` だけで厳密に検証する。
- 浮動小数点および非可算への脱出は使わない。
- 2026-08-15 に全ファイルを実行し、すべて通過した。

## 実行方法

```sh
for f in sagemath/check/partition-support-endpoints/check_*.sage; do sage "$f"; done
```
