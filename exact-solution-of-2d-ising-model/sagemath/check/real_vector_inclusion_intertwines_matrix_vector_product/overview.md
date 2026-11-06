# SageMath Check: real_vector_inclusion_intertwines_matrix_vector_product

## 対象

**対象ラベル**: `real_vector_inclusion_intertwines_matrix_vector_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_vector_inclusion_intertwines_matrix_vector_product`（`ι^m_{ℝ→ℂ}(B_ℝx) = B ι^n_{ℝ→ℂ}(x)`）
- 範囲: 証明の 7 行の鎖 `(ι^m(B_ℝx))_i = ((B_ℝx)_i)_ℂ = … = (Bι^n(x))_i` と、主張 `ι^m(B_ℝx) = Bι^n(x)`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 7 行の鎖（`def_real_vector_inclusion`、`def_real_matrix_vector_product`、`real_inclusion_preserves_finite_sum`、`real_inclusion_preserves_product`、`def_real_matrix_of_real_entry_matrix` の `((B_ℝ)_pq)_ℂ = B_pq`、`def_real_vector_inclusion`、`mat_mult`）と主張 | `check_proof_lines.sage` | 大きさ `m, n ∈ {1,…,4}`、成分が有理数と `±√2, √3` の実数の包含である複素行列と実数のベクトルの 30 組で、鎖の 8 個の式を成分ごとに比べる（和は定義どおり左から足す）。`((B_ℝ)_pq)_ℂ = B_pq` を全成分で確かめ、主張を Sage の組み込みの積とも比べる。否定コントロール 1 件（転置した行列を掛けると一致しない） | **PASS** | 62 個の成分で成り立つ |

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 1→2 行・6→7 行・7→8 行は、`iota`・`cmatvec` を定義の式そのもので作るので構成上一致する。中身は、包含を和の内へ入れる 3→4 行、積へ割る 4→5 行、`((B_ℝ)_pq)_ℂ = B_pq` を当てる 5→6 行と、主張を Sage の組み込みの積と比べるところにある。

## 計算の帰属と範囲

- **厳密**: ℝ の元は AA、ℂ の元は QQbar で持つ。浮動小数点は使わない。
- 範囲外: 選んだ以外の大きさ・成分。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_vector_inclusion_intertwines_matrix_vector_product
```

実行ログは `logs/` に保存する。
