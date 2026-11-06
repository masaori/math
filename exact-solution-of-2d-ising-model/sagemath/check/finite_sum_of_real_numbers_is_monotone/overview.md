# SageMath Check: finite_sum_of_real_numbers_is_monotone

## 対象

**対象ラベル**: `finite_sum_of_real_numbers_is_monotone` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_finite_sum_of_real_numbers_is_monotone`（すべての j で a_j ≤ b_j なら Σ a_j ≤ Σ b_j）
- 範囲: m = 1 の 3 行と、m → m+1 の 4 行と主張。対照として項ごとの大小が無いと成り立たないこと

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 範囲に書いた各行と主張 | `check_proof_lines.sage` | QQ の長さ 1〜9 の列の組 200 個（乱数の種 20261106）で、各行の等号・不等号を厳密に | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQ と AA（実代数的数）だけで計算した。浮動小数点は使わない。
- 範囲外: 選んだ以外の点。点での検算は証明ではなく、式変形の書き間違い・符号の誤りの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_real_numbers_is_monotone
```

実行ログは `logs/` に保存する。
