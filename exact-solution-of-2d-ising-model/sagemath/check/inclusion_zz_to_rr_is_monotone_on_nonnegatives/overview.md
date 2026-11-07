# SageMath Check: inclusion_zz_to_rr_is_monotone_on_nonnegatives

## 対象

**対象ラベル**: `inclusion_zz_to_rr_is_monotone_on_nonnegatives` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_is_monotone_on_nonnegatives`（`a, b ∈ ℤ_{≥0}`、`a ≤ b` なら `ι_{ℤ→ℝ}(a) ≤ ι_{ℤ→ℝ}(b)`。`ι_{ℤ→ℝ}` は `inclusion_zz_to_rr`）
- 範囲: 準備（`k := b − a ∈ ℤ_{≥0}`、`b = a + k`）、`ι(k) ≥ 0` の二つの場合（各 2 行）、`ι(b) ≥ ι(a)` の 4 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| 準備: `k ∈ ℤ_{≥0}`、`b = a + k` | `check_proof_lines.sage` | `0 ≤ a ≤ b < 40` の全ての組で | **PASS** |
| `k = 0`: `ι(0) = 0 ≥ 0`、`k ≥ 1`: `ι(k) ≥ 1 ≥ 0` | `check_proof_lines.sage` | `ι` を定義の再帰（`sagemath/_shared/inclusion_zz_to_rr_by_definition.sage`）で作り、QQ で | **PASS** |
| `ι(b) = ι(a+k) = ι(a) + ι(k) ≥ ι(a) + 0 = ι(a)` | `check_proof_lines.sage` | 各行を QQ の厳密な比較で | **PASS** |

比較は 7380 個。否定コントロール: 仮定 `a ≤ b` を外すと `a = 1, b = 0` で `ι(1) = 1 > 0 = ι(0)` になる。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い。
- 確かめられない行: `a, b < 40` の組の証人を示すだけである。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- `ι(a+k) = ι(a) + ι(k)` は再帰で作った `ι` の性質で、`inclusion_zz_to_rr_preserves_sum_of_nonnegatives` の検算と同じ内容である。
  不等号の行と主張に中身がある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_zz_to_rr_is_monotone_on_nonnegatives
```

実行ログは `logs/` に保存する。
