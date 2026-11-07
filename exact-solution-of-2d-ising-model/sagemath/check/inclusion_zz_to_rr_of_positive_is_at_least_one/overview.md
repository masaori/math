# SageMath Check: inclusion_zz_to_rr_of_positive_is_at_least_one

## 対象

**対象ラベル**: `inclusion_zz_to_rr_of_positive_is_at_least_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_inclusion_zz_to_rr_of_positive_is_at_least_one`（`n ∈ ℤ_{≥1}` なら `ι_{ℤ→ℝ}(n) ≥ 1_ℝ`。`ι_{ℤ→ℝ}` は `inclusion_zz_to_rr`）
- 範囲: `n = 1` の 2 行と、帰納法の段の 4 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| `n = 1`: `ι(1) = 1 ≥ 1` | `check_proof_lines.sage` | `ι` を定義の再帰（共通の準備 `sagemath/_shared/inclusion_zz_to_rr_by_definition.sage`）で作り、QQ で | **PASS** |
| 帰納法の段: `ι(n+1) = ι(n) + 1 ≥ 1 + 1 ≥ 1 + 0 = 1` | `check_proof_lines.sage` | `n = 1..199` で各行を QQ の厳密な比較で。組み込みの埋め込み `QQ(n)` との一致 | **PASS** |

比較は 1196 個。否定コントロール: 範囲を `ℤ_{≥0}` に広げると `n = 0` で `ι(0) = 0 < 1` になり、主張は成り立たない。

## 計算の帰属と範囲

- **厳密**: 値はすべて QQ。ℝ への脱出は無い（`ι` の値は整数の像なので有理数で表せる）。
- 確かめられない行: 帰納法そのものは `n ≤ 200` までの証人を示すだけである。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 帰納法の段の 1 行目は再帰の定義をなぞるので構成上一致する。2〜4 行目の不等号と主張、組み込みの埋め込みとの一致に中身がある。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh inclusion_zz_to_rr_of_positive_is_at_least_one
```

実行ログは `logs/` に保存する。
