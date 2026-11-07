# SageMath Check: finite_sum_of_constant_real_number

## 対象

**対象ラベル**: `finite_sum_of_constant_real_number` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_finite_sum_of_constant_real_number`（`m ∈ ℤ_{≥1}`、`r ∈ ℝ` なら `Σ_{j=1}^{m} r = ι(m) r`）
- 範囲: `m = 1` の 3 行、帰納法の段の 5 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `m = 1`: `Σ_{j=1}^{1} r = r = 1_ℝ r = ι(1) r` | `check_proof_lines.sage` | 有限和を `def_finite_sum_of_real_numbers` の再帰で作り、3 個の等号 | **PASS** |
| 帰納法の段: `Σ_{j=1}^{m+1} r = (Σ_{j=1}^{m} r) + r = ι(m)r + r = ι(m)r + 1_ℝ r = (ι(m)+1_ℝ) r = ι(m+1) r` | `check_proof_lines.sage` | `m = 1..39` で 5 個の等号 | **PASS** |
| 主張 | `check_proof_lines.sage` | `m = 1..39` で主張と、組み込みの整数倍 `m*r` との一致 | **PASS** |

`r ∈ {0, 1, −3/7, 5, √2, √3−1}`（QQ と AA）。等号は 1656 個。否定コントロール: `Σ_{j=1}^{3} 5 ≠ ι(4)·5`（項の数の取り違え）。

## 計算の帰属と範囲

- **厳密**: QQ と AA（実代数的数）の厳密な比較。浮動小数点は使わない。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は和の再帰と QQ・AA の分配則をなぞるので構成上一致する。中身は組み込みの整数倍との比較にある。
