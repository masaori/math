# SageMath Check: 正の乗根の一致は交差べき等式を決める

## 対象

**対象ラベル**: `claim_root_equality_implies_cross_power_equality`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_root_equality_implies_cross_power_equality`）
- 範囲: 証明の等式列 `A^M=(x^N)^M=x^{NM}=x^{MN}=(x^M)^N=B^N`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_substitute_a.sage` | `x^N=A` を `A^M` へ代入する段 | PASS | 正有理数三例で成立 |
| `check_power_of_power_from_a.sage` | `(x^N)^M=x^{NM}` | PASS | 正有理数三例で成立 |
| `check_exponent_commutativity.sage` | `x^{NM}=x^{MN}` | PASS | 正有理数三例で成立 |
| `check_power_of_power_to_b.sage` | `x^{MN}=(x^M)^N` | PASS | 正有理数三例で成立 |
| `check_substitute_b.sage` | `x^M=B` を `B^N` へ代入する段 | PASS | 正有理数三例で成立 |

## 備考

- `QQ` と `ZZ` の厳密計算だけを使い、浮動小数点、実対数、指数関数、極限、積分、微分は使わない。
- 正の実数乗根の存在は本文の実数側の前提であり、検査対象はそこから得た等式を有限積へ移す五段である。

## 実行方法

```bash
for f in sagemath/check/root-equality-implies-cross-power-equality/check_*.sage; do sage "$f"; done
```
