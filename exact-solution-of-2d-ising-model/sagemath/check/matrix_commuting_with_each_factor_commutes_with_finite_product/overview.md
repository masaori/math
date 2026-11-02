# SageMath Check: matrix_commuting_with_each_factor_commutes_with_finite_product

## 対象

**対象ラベル**: `matrix_commuting_with_each_factor_commutes_with_finite_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_commuting_with_each_factor_commutes_with_finite_product`（各因子と可換な行列は有限積とも可換）
- 範囲: 主張と、帰納法の二つの鎖。有限積は `def_finite_product_of_matrices` どおり左から掛ける

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の三行と、`r → r+1` の七行 | `check_induction_lines.sage` | 前提を満たす族（`X` は不定元の行列、`A_j` は `X` の 2 次以下の多項式で係数も不定元）で、各行の項が隣どうし一致することを確かめる。独立な経路として Sage の積でも比べる。対照として、因子を `X` と可換でない行列に替えると主張が外れること | **PASS** | `n = 1, 2, 3` × `r = 1, 2, 3` で 51 行 |

## 計算の帰属と範囲

`QQ` 上の多項式環で厳密に確かめた。浮動小数点はない。一般の `n`・`r` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_commuting_with_each_factor_commutes_with_finite_product
```

実行ログは `sagemath/check/matrix_commuting_with_each_factor_commutes_with_finite_product/logs/` に保存する（2026-11-02）。
