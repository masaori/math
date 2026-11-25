# SageMath Check: finite_sum_of_real_zeros

## 対象

**対象ラベル**: `finite_sum_of_real_zeros` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_finite_sum_of_real_zeros`（`m ∈ ℤ_{≥0}` なら `Σ_{j=1}^{m} 0 = 0`）
- 範囲: `m = 0` の 1 行、`m = 1` の 1 行、帰納法の段の 3 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `m = 0`: `Σ_{j=1}^{0} 0 = 0` | `check_proof_lines.sage` | 空の和 `Σ^{0} := 0` | **PASS** |
| `m = 1`: `Σ_{j=1}^{1} 0 = 0` | `check_proof_lines.sage` | `Σ^{1} r_j := r_1` | **PASS** |
| 帰納法の段: `Σ_{j=1}^{m+1} 0 = (Σ_{j=1}^{m} 0) + 0 = 0 + 0 = 0` | `check_proof_lines.sage` | `m = 1..39` で 3 個の等号 | **PASS** |
| 主張 | `check_proof_lines.sage` | `m = 0..40` で主張と、Sage の `sum` との一致 | **PASS** |

否定コントロール: 項の一つを 1 にした和は 0 にならない。

## 計算の帰属と範囲

- **厳密**: QQ の厳密な比較。浮動小数点は使わない。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 鎖の各行は定数どうしの比較なので構成上一致する。確かめるのは各行の写し間違いと、和の組み方が定義どおりであることである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_real_zeros
```

実行ログは `sagemath/check/finite_sum_of_real_zeros/logs/` に保存する（2026-11-25）。
