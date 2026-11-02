# SageMath Check: product_of_two_finite_products_of_matrices

## 対象

**対象ラベル**: `product_of_two_finite_products_of_matrices` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_product_of_two_finite_products_of_matrices`（二つの有限積の積は、因子ごとの積の有限積）
- 範囲: 主張と、帰納法の二つの鎖。有限積は `def_finite_product_of_matrices` どおり左から掛ける

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の二行と、`r → r+1` の八行 | `check_induction_lines.sage` | 前提（`j < i` で `A_iB_j = B_jA_i`）を満たす族で、各行の項が隣どうし一致することを確かめる。`A_1` と `B_r` は前提に現れないので、ほかと可換でない独立な不定元の行列にした（`A_1`・`B_r` を含む組の可換性を使わないことの確認。ほかの因子はどれも `G` の多項式で互いに可換なので、それ以外の組の可換性を使わないことはこの検算では確かめていない）。独立な経路として Sage の積でも比べる。対照として、`j < i` の組が可換でなければ主張が外れること | **PASS** | `n = 1, 2, 3` × `r = 1, 2, 3` で 54 行 |

## 計算の帰属と範囲

`QQ` 上の多項式環で厳密に確かめた。浮動小数点はない。一般の `n`・`r` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh product_of_two_finite_products_of_matrices
```

実行ログは `sagemath/check/product_of_two_finite_products_of_matrices/logs/` に保存する（2026-11-02）。
