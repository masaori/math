# SageMath Check: inclusion_zz_to_rr_of_nonpositive_is_nonpositive

## 対象

**対象ラベル**: `inclusion_zz_to_rr_of_nonpositive_is_nonpositive` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_of_nonpositive_is_nonpositive`（`n ∈ ℤ_{≤0}` なら `ι_{ℤ→ℝ}(n) ≤ 0_ℝ`。`ι_{ℤ→ℝ}` は `inclusion_zz_to_rr`）
- 範囲: `n = 0` の 2 行と、`n = -m`（`m ∈ ℤ_{≥1}`）の 4 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `n = 0`: `ι(0) = 0 ≤ 0` | `check_proof_lines.sage` | `ι` を定義の再帰（共通の準備 `sagemath/_shared/inclusion_zz_to_rr_by_definition.sage`）で作り、QQ で | **PASS** |
| `n = -m`: `ι(-m) = -ι(m) ≤ -1 ≤ -0 = 0` | `check_proof_lines.sage` | `m = 1..199` で各行を QQ の厳密な比較で（`ι(m) ≥ 1` は `inclusion_zz_to_rr_of_positive_is_at_least_one`）。組み込みの埋め込み `QQ(-m)` との一致 | **PASS** |

比較は 1196 個。否定コントロール: 定義の負の元の節 `ι(-n) := -ι(n)` を `ι'(-n) := ι(n)` に取り違えた写像では、`ι'(-1) = 1 > 0` になる。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い。
- 確かめられない行: `m ≤ 199` までの証人を示すだけである。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- `ι(-m) = -ι(m)` は再帰の定義をなぞるので構成上一致する。不等号の 2 行と主張、組み込みの埋め込みとの一致に中身がある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_zz_to_rr_of_nonpositive_is_nonpositive
```

実行ログは `logs/` に保存する。
