# SageMath Check: ずらした自由族は評価点 2 の箱 L=2 で交差べき等式が破れる

## 対象

**対象ラベル**: `claim_shifted_free_family_cross_power_equality_fails_at_two`

- ファイル: `structured-latex/content/partition-values.ts`
- ブロック: `soundness_bridge_claim_shifted_free_family_cross_power_equality_fails_at_two`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_partition_values_at_two.sage` | $Z_2(2)=36450$、$Z_3(2)=942223653336523266$ の厳密評価（層転送と $L=2$ の全列挙の突き合わせ） | PASS | `ZZ` 上で一致 |
| `check_two_adic_exponent_inequality.sage` | $Z_2(2)=2\cdot3^6\cdot5^2$、$Z_3(2)=2\cdot(\text{奇数})$、素因数 $2$ の指数 $27\ne8$、$Z_2(2)^{27}\ne Z_3(2)^{8}$ | PASS | `ZZ` 上で不一致を確認 |
| `check_point_one_not_usable.sage` | 評価点 $1$ では $Z_2(1)^{27}=2^{216}=Z_3(1)^{8}$ で破れが出ないこと | PASS | `ZZ` 上で一致を確認 |

## 備考

- すべて `ZZ` 上の厳密計算であり、浮動小数点を使わない。
- 素因数 $2$ の指数は 2 進付値 `valuation(2)` で確認し、本文の結論はべきの自然数としての直接比較でも重ねて確認した。
- 2026-08-20 実行。全チェック通過。

## 実行方法

```bash
for f in sagemath/check/cross-power-equality-fails-at-two/check_*.sage; do sage "$f"; done
```
