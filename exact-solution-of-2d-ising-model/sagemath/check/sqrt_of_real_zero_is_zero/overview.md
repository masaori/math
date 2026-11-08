# SageMath Check: sqrt_of_real_zero_is_zero

## 対象

**対象ラベル**: `sqrt_of_real_zero_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_sqrt_of_real_zero_is_zero`（0 の平方根は 0）
- 範囲: 主張 `√0 = 0` と、証明の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `0^2 = 0·0`（`square_of_real_number_is_product`（`r → 0`）） | `check_proof_lines.sage` | 冪を `def_power_of_real_number` どおり `a^0 := 1`、`a^{m+1} := a^m a` で組み、`0^2 = 0·0` | **PASS** | 厳密（等号 2 個） |
| `0·0 = 0`（ℝ で `0·x = 0` の `x → 0`） | 同上 | `0·0 = 0` | **PASS** | 厳密（等号 2 個） |
| `y → 0` が `y ≥ 0 ∧ y^2 = 0` を満たし、そのような `y` はただ一つ（`definition_of_sqrt_r_positive`（`x → 0`）） | 同上 | `0 ≥ 0` と `0^2 = 0`、`y^2` の `AA` の根のうち非負のものが `0` だけであること、Sage の `sqrt` で `√0 = 0` | **PASS** | 厳密（等号 4 個。表の等号は合わせて 8 個） |
| 否定コントロール | 同上 | `1`・`2`・`1/2`・`√2` は `y^2 = 0` を満たさない。2 行目の `0·x` を `x·x` に取り違える（`x → 1`）と `0` にならない | **PASS** | 5 件 |

## 計算の帰属と範囲

`0 ∈ QQ` と `0 ∈ AA` で厳密に判定する。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sqrt_of_real_zero_is_zero
```

実行ログは `sagemath/check/sqrt_of_real_zero_is_zero/logs/` に保存する（2026-11-08、SageMath 10.9）。
