# SageMath Check: sqrt_of_positive_real_is_positive

## 対象

**対象ラベル**: `sqrt_of_positive_real_is_positive` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_sqrt_of_positive_real_is_positive`（正の実数の平方根は正）
- 範囲: 主張 `x > 0 ⟹ √x > 0` と、証明の前置き・背理法の鎖の各行・結論

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 前置き: `x > 0` なので `x ≥ 0`、`y := √x` は `y ≥ 0 ∧ y^2 = x`（`definition_of_sqrt_r_positive`） | `check_proof_lines.sage` | `x ∈ QQ_{>0}` の 7 通りで、`Y^2 - x` の `AA` の非負の根がただ一つで、それが `y ≥ 0 ∧ y^2 = x`（冪は `def_power_of_real_number` どおり）を満たし、Sage の `sqrt` と一致 | **PASS** | 厳密（等号 21 個） |
| `x = y^2 = 0^2`（`definition_of_sqrt_r_positive`、仮定 `y = 0`） | 同上 | `0^2` が `x` と一致しない（矛盾が起きる） | **PASS** | 厳密（7 通り） |
| `0^2 = 0·0`（`square_of_real_number_is_product`（`r → 0`）） | 同上 | `0^2 = 0·0` | **PASS** | 厳密（等号 7 個） |
| `0·0 = 0`（ℝ で `0·x = 0` の `x → 0`） | 同上 | `0·0 = 0` | **PASS** | 厳密（等号 7 個。表の等号は合わせて 35 個） |
| 結論: `y ≠ 0` と `y ≥ 0` から `y > 0` | 同上 | `y ≠ 0` かつ `y > 0` | **PASS** | 厳密（7 通り） |
| 否定コントロール | 同上 | `x = 0` では非負の平方根が `0`、`y ≥ 0` を外すと `-√2`・`-√(1/2)` が `y^2 = x` を満たして正でない、4 行目の `0·x` を `x·x`（`x → 1`）に取り違えると `0` にならない | **PASS** | 4 件 |

## 計算の帰属と範囲

`x ∈ QQ_{>0}` と、その非負の平方根 `y ∈ AA` で厳密に判定する。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sqrt_of_positive_real_is_positive
```

実行ログは `sagemath/check/sqrt_of_positive_real_is_positive/logs/` に保存する（2026-11-11、SageMath 10.9）。
