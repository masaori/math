# SageMath Check: real_identity_matrix_is_left_unit_of_real_matrix_vector_product

## 対象

**対象ラベル**: `real_identity_matrix_is_left_unit_of_real_matrix_vector_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_identity_matrix_is_left_unit_of_real_matrix_vector_product`（実数の単位行列を実数のベクトルに掛けても変わらない）
- 範囲: 証明の三つの鎖（`j ≠ i` の 4 行 `(r_j)_ℂ = … = 0_ℂ`、`j = i` の 3 行 `r_i = … = x_i`、5 行 `((Ix)_i)_ℂ = … = (x_i)_ℂ`）、単射性による `(Ix)_i = x_i`、主張 `Ix = x`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 三つの鎖と単射性の段、主張 | `check_proof_lines.sage` | `n ∈ {1,…,6}`（`n = 1` を含む）、成分が有理数と `±√2, √3` の 30 組で、各行の値を AA（ℝ）と QQbar（ℂ）で比べる。主張を Sage の組み込みの単位行列と積とも比べる。否定コントロール 1 件（対角成分を 2 にした行列では `Px ≠ x`） | **PASS** | 91 個の成分で成り立つ |

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- `r_j := I_ijx_j` の置き換えの行と、`(Ix)_i` を定義の式で作る 1 行目は構成上一致する。中身は、主張と Sage の組み込みの単位行列の積 `identity_matrix(AA, n) * x` との比較と、`Σ_j (r_j)_ℂ = (r_i)_ℂ`（一つの項のほかが `0_ℂ` の和）の比較にある。

## 計算の帰属と範囲

- **厳密**: ℝ の元は AA、ℂ の元は QQbar で持つ（`r ↦ r_ℂ` は AA → QQbar）。浮動小数点は使わない。
- 範囲外: 選んだ以外の大きさ・成分。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_identity_matrix_is_left_unit_of_real_matrix_vector_product
```

実行ログは `logs/` に保存する。
