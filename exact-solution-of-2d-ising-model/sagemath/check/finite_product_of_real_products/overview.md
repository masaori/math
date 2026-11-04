# SageMath Check: finite_product_of_real_products

## 対象

**対象ラベル**: `finite_product_of_real_products`

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_finite_product_of_real_products`（m ∈ ℤ_{≥1}、x_j, y_j ∈ ℝ について Π_{j=1}^{m}(x_jy_j) = (Π_j x_j)(Π_j y_j)。有限積は `def_finite_product_of_real_numbers`）
- 範囲: 証明の m = 1 の 2 行と、帰納法の段の 4 行の全て。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| m = 1 の 2 行（`def_finite_product_of_real_numbers`、同じ定義を 2 箇所へ右辺から左辺へ） | `check_induction_chains.sage` | 厳密 |
| 帰納法の段の 4 行（定義、帰納法の仮定、ℝ で (ab)(cd) = (ac)(bd)、定義を 2 箇所へ右辺から左辺へ） | `check_induction_chains.sage` | 厳密。帰納法の仮定の行は前の段の結論を確かめてから使う |

x_j・y_j は QQ 上の多項式環の不定元に置く（主張は可換環の等式で、ℝ の順序や完備性は使わない）。m = 1..8。浮動小数点は使わない。

否定コントロール: 右辺を (Π x_j) + (Π y_j) にしたもの、Π(x_j + y_j) にしたものは左辺と外れる。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_induction_chains.sage` | m = 1 と帰納法の段の全ての行（m = 1..8） | 実行済み | PASS（128 行、否定コントロール 16 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh finite_product_of_real_products
```
