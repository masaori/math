# SageMath Check: inclusion_zz_to_rr_preserves_sum_of_nonnegatives

## 対象

**対象ラベル**: `inclusion_zz_to_rr_preserves_sum_of_nonnegatives` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_preserves_sum_of_nonnegatives`（`a, b ∈ ℤ_{≥0}` なら `ι(a+b) = ι(a)+ι(b)`）
- 範囲: `b = 0` の 3 行、帰納法の段の 5 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `b = 0`: `ι(a+0) = ι(a) = ι(a)+0_ℝ = ι(a)+ι(0)` | `check_proof_lines.sage` | `a = 0..29` で 3 個の等号（QQ） | **PASS** |
| 帰納法の段: `ι(a+(b+1)) = ι((a+b)+1) = ι(a+b)+1_ℝ = (ι(a)+ι(b))+1_ℝ = ι(a)+(ι(b)+1_ℝ) = ι(a)+ι(b+1)` | `check_proof_lines.sage` | `a, b = 0..29` で 5 個の等号（QQ） | **PASS** |
| 主張 | `check_proof_lines.sage` | `a, b = 0..29` で主張と、組み込みの埋め込み `QQ(a+b)` との一致 | **PASS** |

等号は 6390 個。否定コントロール: 定義を `ι'(0) := 1`、`ι'(n+1) := ι'(n)+2` と取り違えた写像 `ι'` を再帰で作ると、範囲 `a, b ≥ 0` の中で `ι'(1+1) = 5 ≠ 6 = ι'(1)+ι'(1)`。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い。範囲は `a, b ≤ 29`。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は再帰の定義と QQ の結合則をなぞるので構成上一致する。中身は組み込みの埋め込みとの比較にある。
