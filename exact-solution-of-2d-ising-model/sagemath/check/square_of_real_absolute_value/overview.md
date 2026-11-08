# SageMath Check: square_of_real_absolute_value

## 対象

**対象ラベル**: `square_of_real_absolute_value` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_square_of_real_absolute_value`（`|q|^2 = q^2`）
- 範囲: 2 つの場合（`q ≥ 0` の 1 行、`q < 0` の 4 行）の鎖と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 範囲に書いた各行と主張 | `check_proof_lines.sage` | QQ と AA の 11 点の全て（2 つの場合がそれぞれ 1 点以上あることも確かめる）で、二乗を `def_power_of_real_number` どおり組み、各行の等号を厳密に | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQ と AA（実代数的数）だけで計算した。浮動小数点は使わない。
- 範囲外: 選んだ以外の点。点での検算は証明ではなく、式変形の書き間違い・符号の誤りの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh square_of_real_absolute_value
```

実行ログは `logs/` に保存する（2026-11-08）。
