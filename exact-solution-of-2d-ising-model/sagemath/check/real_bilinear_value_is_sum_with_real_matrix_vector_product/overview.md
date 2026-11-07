# SageMath Check: real_bilinear_value_is_sum_with_real_matrix_vector_product

## 対象

**対象ラベル**: `real_bilinear_value_is_sum_with_real_matrix_vector_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/011_max_eigenvalue.ts`
- ブロック: `maxeig_claim_real_bilinear_value_is_sum_with_real_matrix_vector_product`（実数の双線型値 `u^T P v` は、`u` の成分と `Pv` の成分の積の和である）
- 主張は `u^T P v = Σ_k u_k (Pv)_k`。`x^T P y` は定義 `def_real_bilinear_value`（`Σ_k Σ_l (x_k P_kl) y_l`）、`Px` は定義 `def_real_matrix_vector_product`（`(Px)_i = Σ_j P_ij x_j`）どおりに、左から順に足して組む。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 4 行の鎖 | `check_sum_with_matrix_vector_product_chain.sage` | `P`・`u`・`v` を不定元に置き、`n = 1,…,5` で隣り合う行が `QQ` 上の多項式として等しい | **PASS** | 厳密等号（20 段） |
| 主張そのもの | 同上 | 鎖の両端を Sage の `vector * matrix * vector` と `u·(P v)`（独立な経路）と比べる。否定コントロールとして、`(Pv)_k` を `(P^T v)_k` に取り違えると `n ≥ 2` で主張が成り立たないことを確かめる | **PASS** | 同上 |

## 計算の帰属と範囲

成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `n` は人手証明の鎖が担う。

鎖の項は多項式環の元なので、積の括弧の付け方は Sage の正規形で吸収される。
この検査が確かめるのは、各行に書かれた式（添字の位置、`u_k` を外へ出す和の位置）が前の行と同じ値を持つことである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_bilinear_value_is_sum_with_real_matrix_vector_product
```

実行ログは `sagemath/check/real_bilinear_value_is_sum_with_real_matrix_vector_product/logs/` に保存する（2026-11-07）。
