# SageMath Check: real_plus_or_minus_one_times_itself_is_one

## 対象

**対象ラベル**: `real_plus_or_minus_one_times_itself_is_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_real_plus_or_minus_one_times_itself_is_one`（`σ ∈ {-1,1} ⊂ ℝ` なら `σ·σ = 1`）
- 範囲: 主張と、証明の `σ = 1` の 1 行・`σ = -1` の 2 行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `σ = 1` の 1 行（`1·1 = 1`。ℝ の乗法の単位元 `p·1 = p`（`p → 1`）） | `check_proof_lines.sage` | `QQ` で `1·1 = 1` を確かめる | **PASS** | 厳密（等号 1 個） |
| `σ = -1` の 2 行（`(-1)(-1) = 1·1`（`real_negation_times_negation_is_product`（`a → 1`、`b → 1`））・`1·1 = 1`（`p·1 = p`（`p → 1`））） | 同上 | `-1` を `QQ[n]` の不定元 `n` に置き（計算する環で既に成り立つ `(-1)(-1) = 1` を前提にしないため）、1 行目の両辺の差が主張 `real_negation_times_negation_is_product`（`a → 1`、`b → 1`）の等式 `n·n = 1·1` の両辺の差とちょうど一致すること（主張をそのまま当てた段であること）と、その等式が `n = -1` で成り立つことを確かめ、2 行目の等号と、`n = -1` に置くと全ての行が `1` になることを確かめる | **PASS** | 厳密（等号 4 個） |
| 主張（`σ ∈ {-1,1}` の 2 つの値） | 同上 | `σ = 1`・`σ = -1` で `σ·σ = 1` | **PASS** | 厳密（等号 2 個。合わせて等号 7 個） |
| 否定コントロール | 同上 | 1 行目は置き換えなしでは成り立たない。`{-1,1}` の外の `0, 2, -2, 1/2` では `σ·σ ≠ 1` | **PASS** | 5 件 |

## 計算の帰属と範囲

- **厳密**: `QQ` と多項式環 `QQ[n]` だけで計算した。浮動小数点は使わない。
- 範囲外: 多項式環での一致は `ℚ` 係数の多項式としての一致であり、ℝ の公理からの証明ではない。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_plus_or_minus_one_times_itself_is_one
```

実行ログは `logs/` に保存する（2026-11-20）。
