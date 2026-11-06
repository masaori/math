# SageMath Check: real_matrix_of_real_entry_matrix_preserves_product

## 対象

**対象ラベル**: `real_matrix_of_real_entry_matrix_preserves_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_real_matrix_of_real_entry_matrix_preserves_product`（`ϱ_{ℂ→ℝ}` は積を保つ）
- 範囲: 証明の 6 行の鎖 `(((AB)_ℝ)_ik)_ℂ = (AB)_ik = Σ_j A_ijB_jk = Σ_j ((A_ℝ)_ij)_ℂ((B_ℝ)_jk)_ℂ = Σ_j ((A_ℝ)_ij(B_ℝ)_jk)_ℂ = (Σ_j (A_ℝ)_ij(B_ℝ)_jk)_ℂ = ((A_ℝB_ℝ)_ik)_ℂ` と、単射性による `(AB)_ℝ = A_ℝB_ℝ`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 6 行の鎖と主張 | `check_proof_lines.sage` | 大きさ `m, n, p ∈ {1,…,4}`、成分が有理数と `±√2, √3` の実の行列 30 組で、全ての成分の各行を比べ、`(AB)_ℝ = A_ℝB_ℝ` を確かめる。否定コントロール 1 件（積の順を入れ替えると一致しない） | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: ℂ の元は QQbar、ℝ の元は AA で持つ。浮動小数点は使わない。
- 範囲外: 選んだ以外の大きさ・成分。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_matrix_of_real_entry_matrix_preserves_product
```

実行ログは `logs/` に保存する。
