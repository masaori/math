# SageMath Check: real_matrix_vector_product_commutes_with_real_scalar_multiple

## 対象

**対象ラベル**: `real_matrix_vector_product_commutes_with_real_scalar_multiple` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_matrix_vector_product_commutes_with_real_scalar_multiple`（実数のベクトルを実数倍してから実数の行列を掛けると、積の各成分が同じ実数倍になる）
- 主張は `(Pw)_i = c (Pu)_i`（`w_k = c u_k`）。`(Px)_i` は定義 `def_real_matrix_vector_product`（`Σ_j P_ij x_j`、左から順に足す）どおりに成分から組む。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 7 行の鎖 | `check_proof_lines.sage` | `P`・`u`・`c` を不定元に置き、`w` を仮定の成分の等式で組み、`m, n = 1,…,4` の各 `i` で隣り合う行が `QQ` 上の多項式として等しい | **PASS** | 厳密等号（280 段） |
| 主張そのもの | 同上 | 鎖の両端を Sage の `matrix * vector`（独立な経路）と比べる。否定コントロールとして、仮定の成分の等式を 1 か所崩した `w` では主張が成り立たないこと、`n ≥ 2` で `u` の添字を 1 つずらした誤った 6 行目が 5 行目と一致しないこと（検算が添字の書き間違いを拾えること）を確かめる | **PASS** | 同上 |

## 計算の帰属と範囲

成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、任意の実数を代入しても成り立つ（代入は環準同型である）。
浮動小数点と `RR` / `CC` への脱出はない。一般の `m, n` は人手証明の鎖が担う。

鎖の項は多項式環の元なので、積の括弧の付け方と因子の順序の違いは Sage の正規形で吸収される。
この検査が確かめるのは、各行に書かれた式（添字の位置、`c` を外へ出す和の位置）が前の行と同じ値を持つことである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_matrix_vector_product_commutes_with_real_scalar_multiple
```

実行ログは `sagemath/check/real_matrix_vector_product_commutes_with_real_scalar_multiple/logs/` に保存する（2026-11-07）。
