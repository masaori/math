# SageMath Check: epsilon_real_fixes_sum_of_vector_and_its_image

## 対象

**対象ラベル**: `epsilon_real_fixes_sum_of_vector_and_its_image` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
- ブロック: `maxeig_claim_epsilon_real_fixes_sum_of_vector_and_its_image`（成分が `u_k + (ε_ℝu)_k` のベクトルは `ε_ℝ` を掛けても変わらない）
- 主張は、`v_k := u_k + (ε_ℝu)_k` について `ε_ℝv = v`。`Px` は定義 `def_real_matrix_vector_product`、`PQ` は定義 `def_real_matrix_product` どおりに、左から順に足して組む。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 10 行の鎖 | `check_proof_lines.sage` | `u` の成分を不定元に置き、`M_col = 1, 2, 3`（`d = 2, 4, 8`）の各成分 `k` で、隣り合う行が `QQ` 上の多項式として等しい | **PASS** | 厳密等号（140 段） |
| 引く主張 `epsilon_real_square_is_identity` | 同上 | 同じ `ε_ℝ` で `ε_ℝε_ℝ = I` | **PASS** | 同上 |
| 主張そのもの | 同上 | Sage の行列とベクトルの積（独立な経路）で `ε_ℝv = v`。否定コントロールとして、`ε_ℝ` の 1 行目を 2 倍した行列（2 乗が単位行列でない）では主張が崩れることを確かめる | **PASS** | 同上 |

## 計算の帰属と範囲

`ε` は `epsilon_square_and_eigenvalues` の証明の表示 `σ^x ⊠ ⋯ ⊠ σ^x` の成分（0 と 1）で作った。成分は整数なので、
`ε_ℝ = ϱ(ε)` の成分も同じ整数として `QQ` 上に置いた。`u` の成分は `QQ` 上の多項式環の不定元で、不定元で成り立つ多項式の等号は、
任意の実数を代入しても成り立つ（代入は環準同型である）。浮動小数点と `RR` / `CC` への脱出はない。一般の `M_col` は人手証明の鎖が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_real_fixes_sum_of_vector_and_its_image
```

実行ログは `sagemath/check/epsilon_real_fixes_sum_of_vector_and_its_image/logs/` に保存する（2026-11-07）。
