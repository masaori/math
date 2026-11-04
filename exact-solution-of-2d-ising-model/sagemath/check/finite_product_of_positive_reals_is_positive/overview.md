# SageMath Check: finite_product_of_positive_reals_is_positive

## 対象

**対象ラベル**: `finite_product_of_positive_reals_is_positive` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_finite_product_of_positive_reals_is_positive`（正の実数の有限積は正）
- 範囲: 主張 `すべての r_j > 0 なら Π_{j=1}^{m} r_j > 0` と、証明の帰納法の各行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の 2 行 | `check_induction_chain.sage` | `def_finite_product_of_real_numbers` どおり左から掛けた積が `r_1` に等しく、`r_1 > 0` | **PASS** | 厳密 |
| `m → m+1` の前置き（帰納法の仮定、`r_{m+1} > 0`）と 2 行 | 同上 | `m = 1,…,8` で前置きの 2 つの不等号、1 行目の等号、2 行目の `> 0` を確かめる | **PASS** | 厳密（4 通りの列で等号 36 個、不等号 36 個） |
| 主張そのもの | 同上 | Sage の `prod`（独立な経路）と比べる。否定コントロールとして、仮定を 1 つ外した（最後の因子を負にした）列では積が正にならないことを確かめる | **PASS** | 否定コントロール 8 件 |

## 計算の帰属と範囲

`r_j` は `QQ` の正の元の具体的な列を 4 通り取った（1 より小さい数、整数、二つの値の交互、`y + 1/y`（`y ∈ QQ_{>0}`）。
最後のものは `γ/2 = log y` のときの `2cosh(γ/2)` で、`trace_of_check_Vprime` の Step 4 が当てる因子の形）。
等号も不等号も `QQ` で厳密に判定し、浮動小数点と `RR` / `CC` への脱出はない。一般の実数と一般の `m` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_product_of_positive_reals_is_positive
```

実行ログは `sagemath/check/finite_product_of_positive_reals_is_positive/logs/` に保存する（2026-11-04）。
