# SageMath Check: クロネッカー積で作る行列の作用

## 対象

**対象ラベル**: `end_acts_on_kronecker_products` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`（ブロック `transfer_matrix_claim_end_acts_on_kronecker_products`）
- 範囲: クロネッカー積で作る行列がクロネッカー積で作る数ベクトルへ作用する等式

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| `check_tensor_action.sage` | 有理数成分について因子数1から4までの作用等式 | PASS | 4件、厳密等号ですべて一致 |

## 備考

- すべて `QQ` 上の厳密等号で検証し、浮動小数点と実数解析への脱出は使わない。

## 実行方法

```bash
sage sagemath/check/end_acts_on_kronecker_products/check_tensor_action.sage
```
