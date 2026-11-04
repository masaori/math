# SageMath Check: D0_G_diagonal_action

## 対象

**対象ラベル**: `D0_G_diagonal_action`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_claim_D0_G_diagonal_action`（D_0f_{ι(s)} = (Σ_{m=1}^{M_col−1} s(m)s(m+1))_ℂ f_{ι(s)}、Gf_{ι(s)} = (s(M_col)s(1))_ℂ f_{ι(s)}。D_0 は def_D0_open_chain_operator、G は def_G_boundary_operator、f_{ι(s)} は def_config_basis_iso）
- 範囲: 証明の準備の鎖（各 m の 8 行）、開鎖項の鎖（6 行）、周期境界項の鎖（9 行）の全ての行と、行の根拠に引いた主張の個々の場合と、主張。M_col = 2..6、全ての s ∈ 𝔐 = Map({1,…,M_col}, {−1,1})。

## 組み方

- σ_m^z は def_site_pauli_matrices の第 m 因子だけ σ^z のクロネッカー積を、def_kronecker (2) の成分の式で組む（`_shared/pauli_sites_exact.sage` の `site`。Sage の `tensor_product` との一致も確かめる）。
- f_{ι(s)} は def_config_basis_iso の ι（s(m) = +1 なら i_m = 1、−1 なら 2）と def_end_iso の f_I = e_{i_1}⊠⋯⊠e_{i_M} を、成分の式 (f_I)_{ν(J)} = Π_k (e_{i_k})_{j_k} で組む（Sage の `tensor_product` との一致も確かめる）。
- 積は mat_mult の成分の式（数ベクトルは 2^{M_col} 行 1 列）、スカラー倍は def_matrix_scalar_multiple、行列の有限和は def_finite_sum_of_matrices の左からの和、複素数の有限和は def_finite_sum_of_complex_numbers の左からの和、ℂ の積は definition_of_cc の積を QQ の対で計算したもの、ℝ→ℂ の包含は inclusion_rr_to_cc の r ↦ (r, 0) で組む。s(m) は QQ ⊂ ℝ の元として持つ。
- 各行は、その行に書かれた式のとおりに組んだ値で、隣の行と比べる（例: 準備の 2 行目は σ_m^z(σ_{m+1}^z f)、3 行目は σ_m^z(s(m+1)_ℂ f) をそれぞれ積とスカラー倍の成分の式で組む）。
- 主張は Sage の `tensor_product`・`*`・スカラー倍・`sum` だけで組んだ D_0・G と f_{ι(s)} でも独立に確かめる。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| 準備 1 行目（mat_mult_associative） | `check_chain.sage` | 厳密（QQ(i)）。(σ_m^zσ_{m+1}^z)f と σ_m^z(σ_{m+1}^z f) を比べる |
| 準備 2 行目（sigma_z_diagonal_action、m → m+1） | `check_chain.sage` | 厳密。根拠の σ_k^z f = s(k)_ℂ f も全ての k で別に確かめる |
| 準備 3 行目（scalar_multiple_factors_out_of_right_factor） | `check_chain.sage` | 厳密 |
| 準備 4 行目（sigma_z_diagonal_action、m → m） | `check_chain.sage` | 厳密 |
| 準備 5 行目（scalar_multiple_is_associative） | `check_chain.sage` | 厳密。積 s(m+1)_ℂ s(m)_ℂ は definition_of_cc の積で組む |
| 準備 6 行目（real_inclusion_preserves_product） | `check_chain.sage` | 厳密。根拠の a_ℂb_ℂ = (ab)_ℂ も各 m で別に確かめる |
| 準備 7 行目（ℝ の積の交換律） | `check_chain.sage` | 厳密 |
| 開鎖項 1 行目（def_D0_open_chain_operator） | `check_chain.sage` | 厳密。D_0 を本文の経路と Sage の経路の両方で組んで一致も見る |
| 開鎖項 2 行目（finite_sum_of_matrices_distributes_in_left_factor） | `check_chain.sage` | 厳密 |
| 開鎖項 3 行目（準備の等式を各 m へ） | `check_chain.sage` | 厳密 |
| 開鎖項 4 行目（finite_sum_of_scalar_multiples_of_one_matrix） | `check_chain.sage` | 厳密。係数の和は def_finite_sum_of_complex_numbers の左からの和 |
| 開鎖項 5 行目（real_inclusion_preserves_finite_sum） | `check_chain.sage` | 厳密。根拠の Σ(r_j)_ℂ = (Σr_j)_ℂ も別に確かめる |
| 周期境界項 1〜8 行目 | `check_chain.sage` | 厳密。準備と同じ根拠の行を m → M_col, m+1 → 1 で確かめる |
| 主張 | `check_chain.sage` | 厳密。Sage の経路だけで組んだ D_0f・Gf と係数倍を比べる |

否定コントロール（M_col ごとに、どれかの s で外れることを見る）: 係数を s(m)+s(m+1) の和にしたもの、係数を周期境界で閉じた和 Σ_{m=1}^{M_col} s(m)s(m+1)（s(M_col+1) := s(1)）にしたもの、σ^x で組んだ開鎖項、G の係数の符号を変えたもの。

浮動小数点は使わない（全ての量が QQ(i) にある）。証明は M_col ∈ ℤ_{≥2} の全てについてのものだが、検算は M_col = 2..6 に限る（2^{M_col} 次の行列を成分の式で組むため）。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | 準備・開鎖項・周期境界項の鎖の全ての行、根拠の個々の場合、主張、否定コントロール | 実行済み | PASS（等号・主張 6757 件、否定コントロール 20 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh D0_G_diagonal_action
```
