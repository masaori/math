# SageMath Check: 交差べき等式は極限量に対して必要でない（束ね反例主張の可算側の合成）

## 対象

**対象ラベル**: `claim_shifted_free_family_cross_power_equality_is_not_necessary_for_limit_quantity`

- ファイル: `structured-latex/content/partition-values.ts`
- ブロック: `soundness_bridge_claim_shifted_free_family_cross_power_equality_is_not_necessary_for_limit_quantity`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_tail_shift_termwise_agreement.sage` | 証明の第一段の可算側: ずらした族の第 $L$ 項の値 $Z'_L(2)=Z_{L+1}(2)$ と箱点数 $N'_L=(L+1)^3=N_{L+1}$ が元の列の末尾と項ごとに一致し、有限箱量を特徴づける有限べきの等式が同一の等式になること（$L=1,2,3$） | PASS | `ZZ` 上で一致 |
| `check_receive_breach_conclusion.sage` | 証明の第二段の可算側: 破れの主張の結論 $Z_2(2)^{27}\ne Z_3(2)^{8}$ の独立再計算による受け取り（十分性の主張の仮定が $(q,L)=(2,2)$ で満たされない） | PASS | `ZZ` 上で不一致を確認 |

## 備考

- すべて `ZZ` 上の厳密計算であり、浮動小数点を使わない。
- 極限量の存在と一致そのもの（箱の大きさの極限）は非可算への脱出であり有限検査の対象外。
  ここで確認したのは、その脱出へ渡す直前までの可算側の内容
  （末尾ずらしの項別一致と、交差べき等式の破れの受け取り）である。
- 破れの値の一次的な決定（素因数分解・2 進付値を含む）は
  check `cross-power-equality-fails-at-two/` が担う。本 check はその結論を独立再計算で受け取る。
- 2026-08-20 実行。全チェック通過。

## 実行方法

```bash
for f in sagemath/check/cross-power-equality-not-necessary/check_*.sage; do sage "$f"; done
```
