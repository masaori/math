# SageMath Check: real_matrix_of_real_entry_matrix_preserves_power

## 対象

**対象ラベル**: `real_matrix_of_real_entry_matrix_preserves_power` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_matrix_of_real_entry_matrix_preserves_power`（`ϱ_{ℂ→ℝ}` は冪を保つ）
- 範囲: `q = 0` の 4 行の鎖 `I_st = δ_st = {1_ℂ, 0_ℂ} = {(1)_ℂ, (0)_ℂ} = ((I_{Mat(n,ℝ)})_st)_ℂ` と
  `(((A^0)_ℝ)_st)_ℂ = (A^0)_st = I_st = ((I_{Mat(n,ℝ)})_st)_ℂ = (((A_ℝ)^0)_st)_ℂ`、
  `q + 1` の 4 行の鎖 `(A^{q+1})_ℝ = (A^qA)_ℝ = (A^q)_ℝA_ℝ = (A_ℝ)^qA_ℝ = (A_ℝ)^{q+1}`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `q = 0` の 2 本の鎖と `q + 1` の鎖 | `check_proof_lines.sage` | 冪を `def_exp` (1) の漸化式で組み、大きさ `n ∈ {1,…,4}` の実の行列 12 個の全ての成分で `q = 0` の鎖を、`q = 0,…,5` で `q + 1` の鎖の各行を比べる（計 72 組）。否定コントロール 1 件（漸化式を和に替えると外れる） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: ℂ の元は QQbar、ℝ の元は AA で持つ。浮動小数点は使わない。
- 範囲外: 選んだ以外の大きさ・成分・冪。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_matrix_of_real_entry_matrix_preserves_power
```

実行ログは `logs/` に保存する。
