# SageMath Check: symmetrized_transfer_matrix_on_sector_exponential_form

## 対象

**対象ラベル**: `symmetrized_transfer_matrix_on_sector_exponential_form` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
  （ブロック `projection_and_jordan_wigner_claim_symmetrized_transfer_matrix_on_sector_exponential_form`）
- 主張: `M_col ≥ 2`、`K_1, K_2 > 0` のとき
  `W P^{(+)} = exp((i/2)K_1H_1^{(+)}) (2 sinh 2K_2)^{M_col/2} exp(iK_2^*H_2) exp((i/2)K_1H_1^{(+)}) P^{(+)}`
- 範囲: proof の式変形 5 行（`symmetrized_transfer_matrix_on_sectors`、`def_V_plus`、`def_V1_plus_square_root`、
  `V2_exponential_representation`、`def_indexed_hyperbolic_abbreviations` の代入）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_substitution_chain.sage | 0 行目 `W P^{(+)}` から 5 行目の右辺までの 6 つの値を各行の式どおりに独立に作り、隣どうしの相対残差（作用素ノルム）が `1e-9` 以下であること。否定コントロール（5 行目で `K_2^*` の代わりに `K_2`）は 0 行目と一致しないこと（`M_col ∈ {2,3,4}`、`044_claim_max_eigenvalue` の `MAXEIG_CASES` の 7 組） | PASS | 最大相対残差 7.7e-16、否定コントロールの残差 ≥ 0.40 |

## 備考

- **ℝ 脱出（指数評価）**: `exp((i/2)K_1H_1^{(+)})` と `exp(iK_2^*H_2)` は、実数の `K_1, K_2^*` と固有値が一般に無理数の
  `H_1^{(+)}, H_2` から作るので成分が超越数になり、厳密計算できない。倍精度複素数 `CDF` で計算した。
- 1 行目の `V^{(+)}`・2 行目の `(V_1^{(+)})^{1/2}`・`V_2`・`W`・`P^{(+)}` は
  `044_claim_max_eigenvalue/_prelude.sage`（と、それが読む `043_claim_transfer_matrix_bridge/_prelude.sage`）の定義を使う。
  `V_2` はパウリ行列表示（`second_transfer_matrix_pauli_form` の右辺）で作るので、3 行目から 4 行目の残差は、
  `iH_2 = Σ_m σ^x_m` が倍精度でも成分ごとに一致するため 0 になる。
- 0 行目から 1 行目の等号（`symmetrized_transfer_matrix_on_sectors`）は、`044_claim_max_eigenvalue/` の
  一行ずつの検査（`check_W_P_equals_B_V2_B_P.sage` ほか）が確かめている。ここでは代入を重ねた結果の一致を確かめる。

## 実行方法

```bash
cd sagemath/check/symmetrized_transfer_matrix_on_sector_exponential_form
sage check_substitution_chain.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
