# SageMath Check: epsilon_D0_G_pairwise_commute

## 対象

**対象ラベル**: `epsilon_D0_G_pairwise_commute`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_claim_epsilon_D0_G_pairwise_commute`（εD_0 = D_0ε、εG = Gε、D_0G = GD_0。D_0 は def_D0_open_chain_operator、G は def_G_boundary_operator、ε は def_global_spin_flip_matrix）
- 範囲: 証明の準備「ε と σ^z の対の可換」（各 j, k の 9 行）、準備「σ^z どうしの可換」（各 j, k）、準備「σ^z の対と G の可換」（各 m の 15 行）、εD_0 の鎖（6 行）、εG の鎖（4 行）、D_0G の鎖（6 行）の全ての行と、行の根拠に引いた主張の個々の場合と、主張。行の鎖は M_col = 2..5、全ての j, k ∈ {1,…,M_col}、全ての m ∈ {1,…,M_col−1}。主張は M_col = 2..7。

## 組み方

- σ_k^z は def_site_pauli_matrices の第 k 因子だけ σ^z のクロネッカー積を、def_kronecker (2) の成分の式で組む（`_shared/pauli_sites_exact.sage` の `site`。Sage の `tensor_product` との一致も確かめる）。
- ε は def_global_spin_flip_matrix の σ_1^x⋯σ_{M_col}^x を左から mat_mult の成分の式で掛けたもの（`epsilon`。Sage の経路との一致も確かめる）。
- 積は mat_mult の成分の式（`body_product`）、符号反転は def_matrix_negation の成分の式（`body_negation`）、行列の有限和は def_finite_sum_of_matrices の左からの和（`body_finite_sum`）で組む。
- 各行は、その行に書かれた式の括弧のとおりに組んだ値で、隣の行と比べる（例: 準備「ε と σ^z の対の可換」 の 3 行目は (−(σ_jε))σ_k、4 行目は −((σ_jε)σ_k) をそれぞれ符号反転と積の成分の式で組む）。
- 主張は Sage の `tensor_product`・`*`・`sum` だけで組んだ ε・D_0・G でも独立に確かめる。

## 証明の行との対応

表の「◯行目」は、その鎖の◯番目の等号（◯行目の式から◯+1 行目の式への変形）を指す。

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| 準備「ε と σ^z の対の可換」 の 1・4・8 行目（mat_mult_associative） | `check_chain.sage` | 厳密（QQ(i)）。全ての j, k |
| 準備「ε と σ^z の対の可換」 の 2・5 行目（epsilon_anticommutes_with_site_sigma_z） | `check_chain.sage` | 厳密。根拠の εσ_k^z = −(σ_k^zε) も全ての k で別に確かめる |
| 準備「ε と σ^z の対の可換」 の 3 行目（negation_factors_out_of_left_factor） | `check_chain.sage` | 厳密 |
| 準備「ε と σ^z の対の可換」 の 6 行目（negation_factors_out_of_right_factor） | `check_chain.sage` | 厳密 |
| 準備「ε と σ^z の対の可換」 の 7 行目（matrix_double_negation） | `check_chain.sage` | 厳密 |
| 準備「σ^z どうしの可換」（distinct_site_pauli_matrices_commute、j = k は同じ行列） | `check_chain.sage` | 厳密。j = k を含む全ての j, k |
| 準備「σ^z の対と G の可換」 の 1・14 行目（def_G_boundary_operator） | `check_chain.sage` | 厳密 |
| 準備「σ^z の対と G の可換」 の 2・3・5・7・9・10・12・13 行目（mat_mult_associative） | `check_chain.sage` | 厳密。全ての m（m = 1 と m + 1 = M_col の、サイトが重なる場合を含む） |
| 準備「σ^z の対と G の可換」 の 4・6・8・11 行目（準備「σ^z どうしの可換」） | `check_chain.sage` | 厳密 |
| εD_0 の 1・5 行目（def_D0_open_chain_operator） | `check_chain.sage` | 厳密 |
| εD_0 の 2 行目（finite_sum_of_matrices_distributes_in_right_factor） | `check_chain.sage` | 厳密 |
| εD_0 の 3 行目（準備「ε と σ^z の対の可換」） | `check_chain.sage` | 厳密 |
| εD_0 の 4 行目（finite_sum_of_matrices_distributes_in_left_factor） | `check_chain.sage` | 厳密 |
| εG の 1・3 行目（def_G_boundary_operator）、2 行目（準備「ε と σ^z の対の可換」、j = M_col, k = 1） | `check_chain.sage` | 厳密 |
| D_0G の 1・5 行目（def_D0_open_chain_operator）、2 行目（finite_sum_of_matrices_distributes_in_left_factor）、3 行目（準備「σ^z の対と G の可換」）、4 行目（finite_sum_of_matrices_distributes_in_right_factor） | `check_chain.sage` | 厳密 |
| 主張 | `check_chain.sage` | 厳密。Sage の経路だけで組んだ ε・D_0・G で M_col = 2..7 |

否定コントロール（M_col = 2..5 のそれぞれで外れることを見る）: ε を σ_1^x に替えると D_0 と可換でない、準備「ε と σ^z の対の可換」 の右辺の符号を変える（ε(σ_1^zσ_2^z) = −((σ_1^zσ_2^z)ε) にする）と外れる、G を σ_{M_col}^yσ_1^z に替えると D_0 と可換でない、G を σ_{M_col}^xσ_1^z に替えると ε と可換でない。

浮動小数点は使わない（全ての成分が QQ(i) にある）。証明は M_col ∈ ℤ_{≥2} の全てについてのものだが、行の鎖は 2^{M_col} 次の行列を成分の式で組むので M_col = 2..5 に、Sage の経路の主張は M_col = 2..7 に限る。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | 三つの準備 と三つの鎖の全ての行、根拠の個々の場合、主張、否定コントロール | 実行済み | PASS（等号・主張 710 件、否定コントロール 16 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh epsilon_D0_G_pairwise_commute
```
