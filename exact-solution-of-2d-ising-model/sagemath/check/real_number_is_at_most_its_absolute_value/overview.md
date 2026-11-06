# SageMath Check: real_number_is_at_most_its_absolute_value

## 対象

**対象ラベル**: `real_number_is_at_most_its_absolute_value` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_real_number_is_at_most_its_absolute_value`（q ≤ |q|）
- 範囲: q ≥ 0 の 1 行（q = |q|）と q < 0 の 3 行（q < 0 < -q = |q|）と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 範囲に書いた各行と主張 | `check_proof_lines.sage` | QQ と AA の 11 点。|·| は def_real_absolute_value の場合分けで計算し、Sage の abs と一致することも見るで、各行の等号・不等号を厳密に | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQ と AA（実代数的数）だけで計算した。浮動小数点は使わない。
- 範囲外: 選んだ以外の点。点での検算は証明ではなく、式変形の書き間違い・符号の誤りの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_number_is_at_most_its_absolute_value
```

実行ログは `logs/` に保存する。
