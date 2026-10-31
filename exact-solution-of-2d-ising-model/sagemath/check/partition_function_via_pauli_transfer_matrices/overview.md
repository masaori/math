# SageMath Check: partition_function_via_pauli_transfer_matrices

## 対象

**対象ラベル**: `partition_function_via_pauli_transfer_matrices` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
  （ブロック `transfer_matrix_representation_claim_partition_function_via_pauli_transfer_matrices`）
- 主張: `K_1, K_2 > 0` のとき
  `Z(K_1,K_2) = tr((exp(K_1 Σ_{m=1}^{M_col} σ^z_m σ^z_{m+1}) (2 sinh 2K_2)^{M_col/2} exp(K_2^* Σ_{m=1}^{M_col} σ^x_m))^{N_row})`
- 範囲: statement と proof の式変形 3 行（`partition_function_via_transfer_matrix`、
  `first_transfer_matrix_pauli_form`、`second_transfer_matrix_pauli_form` の代入）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_substitution_chain_exact.sage | `Z`（全配位の和）、`tr((V_1V_2)^{N_row})`（成分の `V_1, V_2`）、`V_1` を `exp(K_1Σσ^zσ^z)` に置き換えたトレース、さらに `V_2` を `(2 sinh 2K_2)^{M_col/2} exp(K_2^*Σσ^x)` に置き換えたトレースの 4 値が一致すること、否定コントロール（`K_2^*` の代わりに `K_2`）が一致しないこと（`M_col = 1..4`、`N_row = 1..3`、`(exp K_1, exp K_2) ∈ {(2, 3/2), (5/4, 2), (3, 7/3)}`） | PASS | 36 組すべて一致（`AA`） |

## 備考

- `K_i = log x_i`（`x_i ∈ QQ`, `x_i > 1`）と選ぶ。このとき `Z` と成分の `V_1, V_2` は `QQ`、
  `exp(K_2^* λ) = (√tanh K_2)^{-λ}` と前係数 `(√(2 sinh 2K_2))^{M_col}` は `AA`（実代数的数。等号は決定可能）に住む。
  ℝ 脱出は `K_i` の選び方の一点だけ（見かけだけの ℝ 脱出）。
- 行列の指数関数は、整数固有値をもつ対称な整数行列（`Σσ^z_mσ^z_{m+1}`、`Σσ^x_m`）のスペクトル射影で計算した
  （`_shared/row_configurations.sage` の `exp_by_spectral_projectors`）。
- 各行の代入の中身（成分の `V_1, V_2` とパウリ行列表示の一致）は `first_transfer_matrix_pauli_form/`・
  `second_transfer_matrix_pauli_form/`・`252_partition_function_via_transfer_matrix/` が確かめている。
  ここでは三つを代入した結果の一致を確かめる。

## 実行方法

```bash
cd sagemath/check/partition_function_via_pauli_transfer_matrices
sage check_substitution_chain_exact.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
