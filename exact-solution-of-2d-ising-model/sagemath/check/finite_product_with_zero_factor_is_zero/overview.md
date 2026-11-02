# SageMath Check: finite_product_with_zero_factor_is_zero

## 対象

**対象ラベル**: `finite_product_with_zero_factor_is_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_finite_product_with_zero_factor_is_zero`（0 の因子を持つ複素数の有限積は 0）
- 範囲: 主張と、帰納法の三つの鎖（`m = 1`、`n = m+1`、`n ≤ m`）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 三つの鎖の各行 | `check_induction_lines.sage` | 因子を `QQ` 上の多項式環の不定元に置き、第 `n` 因子だけを `0` にする。有限積は `def_finite_product_of_complex_numbers` の帰納法どおり左から掛け、Sage の `prod` とも比べる。`n ≤ m` の場合は帰納法の仮定（`m` 個の積が `0`）も確かめる。対照として、`0` の因子が無ければ積は `0` でないこと | **PASS** | `m = 1,…,8` のすべての `n`（36 通り） |
| 主張そのもの | `check_statement.sage` | `QQ(i)` の具体の数の列で、`z_n = 0` にしたときの積が `0` で、`0` の因子が無ければ `0` でないこと | **PASS** | `m = 1,…,8` のすべての `n` |

## 計算の帰属と範囲

不定元の多項式の等号は厳密に決まり、任意の複素数を代入しても保たれる（代入は環準同型である）。浮動小数点はない。
`m ≤ 8` を確かめ、一般の `m` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_product_with_zero_factor_is_zero
```

実行ログは `sagemath/check/finite_product_with_zero_factor_is_zero/logs/` に保存する。
