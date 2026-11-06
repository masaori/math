# SageMath Check: inclusion_rr_to_cc_is_injective

## 対象

**対象ラベル**: `inclusion_rr_to_cc_is_injective` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_rr_to_cc_is_injective`（ι_{ℝ→ℂ} は単射）
- 範囲: 証明の 3 行の鎖 `(a, 0) = a_ℂ = b_ℂ = (b, 0)` と、第 1 成分の比較と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 範囲に書いた各行と主張 | `check_proof_lines.sage` | ℂ を ℝ² の組として持ち、QQ と AA の 10 点の全ての組（100 組）で、`a_ℂ = b_ℂ` の組では鎖の各行と `a = b` を、それ以外の組では `a ≠ b` を厳密に | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQ と AA（実代数的数）だけで計算した。浮動小数点は使わない。
- 範囲外: 選んだ以外の点。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_rr_to_cc_is_injective
```

実行ログは `logs/` に保存する。
