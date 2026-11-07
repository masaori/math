# SageMath Check: inclusion_zz_to_rr_of_power_of_two

## 対象

**対象ラベル**: `inclusion_zz_to_rr_of_power_of_two` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_inclusion_zz_to_rr_of_power_of_two`（`M ∈ ℤ_{≥0}` なら `ι(2_ℤ^M) = 2_ℝ^M`）
- 範囲: `M = 0` の 3 行、帰納法の段の 10 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `M = 0`: `ι(2_ℤ^0) = ι(1) = 1_ℝ = 2_ℝ^0` | `check_proof_lines.sage` | ℤ の冪を `def_power_of_integer` の再帰で `2_ℤ := 1_ℤ+1_ℤ` について、`ℝ` の冪を `def_power_of_real_number` の再帰で `2_ℝ := 1_ℝ+1_ℝ` について作り、3 個の等号 | **PASS** |
| 帰納法の段: `ι(2_ℤ^{M+1}) = ι(2_ℤ^M·2_ℤ) = ι(2_ℤ^M(1+1)) = ι(2_ℤ^M·1+2_ℤ^M·1) = ι(2_ℤ^M+2_ℤ^M) = ι(2_ℤ^M)+ι(2_ℤ^M) = 2_ℝ^M+2_ℝ^M = 2_ℝ^M·1+2_ℝ^M·1 = 2_ℝ^M(1+1) = 2_ℝ^M·2_ℝ = 2_ℝ^{M+1}` | `check_proof_lines.sage` | `M = 0..12` で `2_ℤ^M ≥ 0` と 10 個の等号 | **PASS** |
| 主張 | `check_proof_lines.sage` | `M = 0..12` で主張と、組み込みの冪 `QQ(2)^M`・`ZZ(2)^M` との一致 | **PASS** |

等号は 185 個。否定コントロール: ℝ の側の底を `3` に取り違えると `M = 1` で合わない。

## 計算の帰属と範囲

- **厳密**: 値はすべて ZZ・QQ。ℝ への脱出は無い。範囲は `M ≤ 12`。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は再帰の定義と QQ の分配則をなぞるので構成上一致する。中身は組み込みの冪との比較にある。
