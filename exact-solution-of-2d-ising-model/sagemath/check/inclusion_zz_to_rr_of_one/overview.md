# SageMath Check: inclusion_zz_to_rr_of_one

## 対象

**対象ラベル**: `inclusion_zz_to_rr_of_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_of_one`（`ι_{ℤ→ℝ}(1_ℤ) = 1_ℝ`。`ι_{ℤ→ℝ}` は `inclusion_zz_to_rr`）
- 範囲: 証明の 4 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `ι(1) = ι(0+1) = ι(0)+1_ℝ = 0_ℝ+1_ℝ = 1_ℝ` | `check_proof_lines.sage` | `ι` を定義の再帰（共通の準備 `sagemath/_shared/inclusion_zz_to_rr_by_definition.sage`）で作り、4 個の等号を QQ で。Sage の組み込みの埋め込み `QQ(1)` との一致 | **PASS** |

否定コントロール: 定義の `ι(0) := 0` を `ι'(0) := 1` に取り違えた写像 `ι'` を再帰で作ると `ι'(1) = 2 ≠ 1`。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い（`ι` の値は整数の像なので有理数で表せる）。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の 2〜4 行は再帰の定義をなぞるので構成上一致する。中身は組み込みの埋め込みとの比較にある。
