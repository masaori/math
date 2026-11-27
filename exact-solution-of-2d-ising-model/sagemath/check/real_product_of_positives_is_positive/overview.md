# SageMath Check: real_product_of_positives_is_positive

## 対象

**対象ラベル**: `real_product_of_positives_is_positive` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_product_of_positives_is_positive`（`ℝ` で `0 < a`、`0 < b` なら `0 < a·b`）
- 範囲: 主張と、証明の準備の 2 本の鎖、順序と乗法の両立の行、`a·b ≠ 0` の 2 行、結びの行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `0 < a ⇒ 0 ≤ a ∧ 0 ≠ a ⇒ 0 ≤ a ∧ a ≠ 0`（`b` も同じ） | `check_proof_lines.sage` | `QQ` と `AA` の標本で `<` の定義の前半・後半と対称律の対偶の形 | **PASS** | 50 件 |
| `0 ≤ a ∧ 0 ≤ b ⇒ 0 ≤ a·b`（順序と乗法の両立） | 同上 | 標本で公理の形 | **PASS** | 36 件 |
| `a ≠ 0 ∧ b ≠ 0 ⇒ a·b ≠ 0 ⇒ 0 ≠ a·b`（`real_product_of_nonzero_is_nonzero`） | 同上 | 標本で主張の形 | **PASS** | 64 件 |
| `0 ≤ a·b ∧ 0 ≠ a·b ⇒ 0 < a·b`（`def_real_strict_order` を右辺から左辺へ）と主張 | 同上 | 標本で `<` の定義の両向きと主張 | **PASS** | 本体 25 件・結びと主張 50 件 |
| 否定コントロール | 同上 | 仮定のどちらかを外すと主張は偽。`≤` の両立だけでは `0 ≠ a·b` が出ない（`a = 0`） | **PASS** | 3 件 |

## 計算の帰属と範囲

- **厳密**: `QQ`・`AA` だけで計算した。浮動小数点は使わない。
- 範囲外: 不等号の段は標本で公理と主張の形を確かめるだけで、ℝ の順序体の公理からの証明ではない。
  検算は証明の行の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_product_of_positives_is_positive
```

実行ログは `logs/` に保存する（2026-11-27、SageMath）。
