# SageMath Check: epsilon_G_is_involution

## 対象

**対象ラベル**: `epsilon_G_is_involution`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_claim_epsilon_G_is_involution`（(εG)^2 = I_{Mat(2^{M_col},ℂ)}、X^2 := XX。G は def_G_boundary_operator、ε は def_global_spin_flip_matrix）
- 範囲: 証明の準備の鎖（各 k の 6 行）と主張の鎖（16 行）の全ての行と、行の根拠に引いた主張の個々の場合と、主張。行の鎖は M_col = 2..5、全ての k ∈ {1,…,M_col}。主張は M_col = 2..7。

## 組み方

- σ_k^z は def_site_pauli_matrices の第 k 因子だけ σ^z のクロネッカー積を、def_kronecker (2) の成分の式で組む（`kron_def`・`site`）。
- ε は def_global_spin_flip_matrix の σ_1^x⋯σ_{M_col}^x を左から mat_mult の成分の式で掛けたもの（`epsilon`）、G = σ_{M_col}^zσ_1^z。
- 積は mat_mult の成分の式（`body_product`）、単位行列は def_identity_matrix の δ_{ij}（`body_identity`）、X^2 は XX。
- 準備の 3 行目（kronecker_product_rule (1) の右辺）は 2 次の各因子の積 A_kB_k を成分の式で組んでから、それらのクロネッカー積を def_kronecker (2) で組む。5 行目は I⊠⋯⊠I を def_kronecker (2) で組み、6 行目の 2^{M_col} 次の単位行列と比べる（kronecker_product_rule (2)）。
- 主張は Sage の `tensor_product`・`*`・`^`・`identity_matrix` だけで組んだ ε・G でも独立に確かめる。

## 証明の行との対応

表の「◯行目」は、その鎖の◯番目の等号（◯行目の式から◯+1 行目の式への変形）を指す。

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| 準備 1 行目（def_site_pauli_matrices） | `check_chain.sage` | 厳密（QQ(i)）。全ての k |
| 準備 2 行目（kronecker_product_rule (1)） | `check_chain.sage` | 厳密 |
| 準備 3 行目（identity_matrix_is_left_unit_of_mat_mult を k 以外のサイトで） | `check_chain.sage` | 厳密。根拠の II = I（2 次）も別に確かめる |
| 準備 4 行目（pauli_matrix_products の σ^zσ^z = I） | `check_chain.sage` | 厳密。根拠も別に確かめる |
| 準備 5 行目（kronecker_product_rule (2)） | `check_chain.sage` | 厳密 |
| 主張の鎖 1 行目（X^2 := XX） | `check_chain.sage` | 厳密。左辺は Sage の `^` で組み、右辺の積の成分の式と比べる |
| 主張の鎖 2・3・5・9・10・12・13 行目（mat_mult_associative） | `check_chain.sage` | 厳密 |
| 主張の鎖 4 行目（epsilon_D0_G_pairwise_commute の εG = Gε） | `check_chain.sage` | 厳密。根拠も別に確かめる |
| 主張の鎖 6 行目（epsilon_square_and_eigenvalues の εε = I） | `check_chain.sage` | 厳密。根拠も別に確かめる |
| 主張の鎖 7・15 行目（identity_matrix_is_left_unit_of_mat_mult） | `check_chain.sage` | 厳密 |
| 主張の鎖 8 行目（def_G_boundary_operator） | `check_chain.sage` | 厳密 |
| 主張の鎖 11 行目（distinct_site_pauli_matrices_commute、1 ≠ M_col） | `check_chain.sage` | 厳密。根拠も別に確かめる |
| 主張の鎖 14 行目（準備を k = M_col と k = 1 で） | `check_chain.sage` | 厳密 |
| 主張 | `check_chain.sage` | 厳密。Sage の経路だけで M_col = 2..7 |

否定コントロール（M_col = 2..5 のそれぞれで外れることを見る）: G を σ_{M_col}^xσ_1^z に替えると (εG)^2 ≠ I（ε と反可換になるため −I になる）、右辺を −I にすると外れる、εG 自身は I でない。

浮動小数点は使わない（全ての成分が QQ(i) にある）。証明は M_col ∈ ℤ_{≥2} の全てについてのものだが、行の鎖は M_col = 2..5、Sage の経路の主張は M_col = 2..7 に限る。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | 準備と主張の鎖の全ての行、根拠の個々の場合、主張、否定コントロール | 実行済み | PASS（等号・主張 163 件、否定コントロール 12 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh epsilon_G_is_involution
```
