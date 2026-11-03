# SageMath Check: distinct_site_pauli_matrices_commute

## 対象

**対象ラベル**: `distinct_site_pauli_matrices_commute`

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_claim_distinct_site_pauli_matrices_commute`（相異なるサイトに置いた Pauli 行列は可換）
- 範囲: 準備の表示、`y_ix_i = x_iy_i` の 3 つの場合の鎖、主張の 3 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の `σ_j^a = x_1⊠⋯⊠x_{M_col}`・`σ_k^b = y_1⊠⋯⊠y_{M_col}`、3 つの場合の鎖（4 行・4 行・2 行）、主張の 3 行の鎖 | `check_chain.sage` | `M_col = 2, 3, 4`、`j ≠ k`、`a, b ∈ {x, y, z}` の全 180 組、2520 段。積は `mat_mult` の成分の式、クロネッカー積は `def_kronecker` の成分の式と Sage の `tensor_product` の一致を見てから使う。対照 15 件: `j = k` で `σ^a, σ^b` が反可換なら、場合の鎖の両端も主張の両辺も一致しない | **PASS** | 成り立つ |

共通の準備は `sagemath/_shared/pauli_sites_exact.sage`（σ_k^a は `def_site_pauli_matrices` どおり第 k 因子だけ σ^a）。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ(i)` で、浮動小数点と ℝ/ℂ への脱出はない。
- 範囲外: `M_col ≥ 5`。主張の証明は `M_col` についての帰納法を含まず、各段は `M_col` に依らない形の鎖である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh distinct_site_pauli_matrices_commute
```

実行ログは `logs/` に保存する。
