# SageMath Check: real_matrix_vector_product_is_associative

## 対象

**対象ラベル**: `real_matrix_vector_product_is_associative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_matrix_vector_product_is_associative`（実数の行列の積と実数のベクトルへの積の結合則）
- 範囲: 証明の 10 行の鎖 `((PQ)x)_i = Σ_k (PQ)_ik x_k = … = Σ_j P_ij(Qx)_j = (P(Qx))_i` と、主張 `(PQ)x = P(Qx)`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 10 行の鎖（`def_real_matrix_vector_product`、`def_real_matrix_product`、乗法の交換則、`finite_sum_of_real_scalar_multiples`、乗法の交換則・結合則、和の順序の入れ替え、`finite_sum_of_real_scalar_multiples`、`def_real_matrix_vector_product` の 2 行）と主張 | `check_proof_lines.sage` | 大きさ `m, n, p ∈ {1,…,4}`、成分が有理数と `±√2, √3` の 30 組で、鎖の 11 個の式を成分ごとに比べる（和は定義どおり左から足す）。主張を Sage の組み込みの積とも比べる。否定コントロール 1 件（`(QP)x ≠ (PQ)x`） | **PASS** | 71 個の成分で成り立つ |

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 1→2 行と 9→10 行・10→11 行は、`matvec`・`matprod` を定義の式そのもので作るので構成上一致する。中身は、主張と Sage の組み込みの積 `(P*Q)*x`・`P*(Q*x)` との比較にある。
- 3→4・5→6・6→7 行は AA の乗法の交換則・結合則だけで一致する。7→8 行（和の順序の入れ替え）と 4→5・8→9 行（共通の因子を和の外へ出す）は、和の順と因子の位置を変えた別の式を比べている。

## 計算の帰属と範囲

- **厳密**: ℝ の元は AA で持つ。浮動小数点は使わない。
- 範囲外: 選んだ以外の大きさ・成分。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_matrix_vector_product_is_associative
```

実行ログは `logs/` に保存する。
