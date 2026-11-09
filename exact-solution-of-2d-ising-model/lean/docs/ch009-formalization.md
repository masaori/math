# 章 009「転送行列 `V` の固有値」の形式化

対象の人手証明: `structured-latex/content/009_eigenvalues_of_V.ts`（19 ブロック。章立ての組み直しで、`iH_is_real_symmetric`・`sign_flip_conjugation` は `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts` へ移った）

- 具体版: `Ising2D/RoutesNotAdopted/IntegerMomentum/`（この章は整数運動量の経路として参照用ノートへ退避済みで、Lean は形式化の記録。`def_trace`・`trace_basic_properties`・`trace_of_idempotent` の `DefinitionTrace.lean` と、`def_hermitian_positive_definite`・`star_preserves_norm_and_limits`・`exp_hermitian_is_positive_definite`・`iH_is_real_symmetric` の `ClaimPositiveDefinite.lean` は、数学的道具立て「トレース・共役転置・正定値性」の項が多いので `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/` にある）
- 必要十分版: `Ising2D/NecSuf/NumberOperator.lean`, `Ising2D/NecSuf/JointEigenspace.lean`, `Ising2D/NecSuf/ConjugationOfExpSeries.lean`（`constant_c_value_even_sector` Step 2 の共役と指数関数の交換。導出は `EigenvalueProblem/EigenvaluesOfVPlus/ClaimSignFlipConjugationFromNecSuf.lean`）

`lake build` 成功・`scripts/check-no-sorry.sh` exit 0（`sorry` / `admit` ゼロ）。

---

## 1. 形式化した定理の一覧

### 必要十分版（`Ising2D.NecSuf`）

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した整数運動量の経路のものである（退避の記録はノートの各ブロックの冒頭にある）。

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `NecSuf.num` | `n_i := c_i a_i` | `def_number_operator` |
| `NecSuf.sq_eq_zero_of_acomm_self` | `x + x = 0 → x = 0` の下で `x x = 0` | `number_operator_idempotent` (1) |
| `NecSuf.ann_mul_cre` | `a_i c_i = 1 - n_i` | 同 (2) |
| `NecSuf.num_mul_num` | `n_i^2 = n_i` | 同 (3) |
| `NecSuf.commute_mul_of_anticommute` | 反可換 2 元の積との可換性 | `number_operators_commute` Step 2 |
| `NecSuf.commute_cre_num` / `commute_ann_num`（`NumberOperator.lean`） | `c_i`, `a_i` は `n_j` (`i≠j`) と可換 | `number_operators_commute` (1) |
| `NecSuf.commute_num_num` | `n_i n_j = n_j n_i` | 同 (2) |
| `NecSuf.commute_num_of_commute` | `c_i, a_i` が `P` と可換なら `n_i` も | 補助（原文は暗黙） |
| `NecSuf.tau_num_mul_add_self` | `τ(n_i P) + τ(n_i P) = τ(P)` | `trace_of_number_operator_product` の帰納段階 |
| `NecSuf.projFactor` / `projOn`（`JointEigenspace.lean`） | `R_μ^{(ε_μ)}` と `Q_ε = ∏ R` | `joint_eigenspace_decomposition` |
| `NecSuf.projOn_mul_self` | `Q_ε^2 = Q_ε` | 同 (1) 後半 |
| `NecSuf.projOn_mul_projOn_of_ne` | `ε≠ε' ⇒ Q_ε Q_{ε'} = 0` | 同 (1) 前半 |
| `NecSuf.sum_projOn` | `∑_ε Q_ε = 1` | 同 (2) |
| `NecSuf.num_mul_projOn` | `n_ν Q_ε = ε_ν Q_ε` | 同 (3) |
| `NecSuf.two_pow_smul_tau_projOn` | `2^{|s|} τ(Q_ε) = τ(1)` | 同 (4)、`trace_of_number_operator_product` |
| `NecSuf.pow_mul_eq_of_mul_eq_smul` | `X Q = gQ ⇒ X^k Q = g^k Q` | `eigenvalues_of_Vprime` Step 2 |
| `NecSuf.exp_mul_eq_of_mul_eq_smul` | `X Q = gQ ⇒ exp(X) Q = e^g Q` | 同 Step 3 |
| `NecSuf.isInternal_range_proj` | 直交する射影の族の像は**内部直和分解**を与える（`DirectSum.IsInternal`） | `joint_eigenspace_decomposition` (5) |
| `NecSuf.iSupIndep_range_proj` / `iSup_range_proj_eq_top` | 同 (5) の後半（独立性）・前半（全体を張ること） | 同 (5) |
| `NecSuf.idem_of_ortho_of_sum_eq_one` | **冪等性 (1) 後半は仮定に要らず、(1) 前半と (2) から従う** | 同 (1) |
| `NecSuf.eigen_of_mem_range_proj` / `collectedBasis_eigen` | `f Q_ε = c_ε Q_ε` なら `im Q_ε` の元は固有値 `c_ε` の固有ベクトル。各成分の基底を集めたものは固有ベクトルからなる基底 | `eigenvalues_of_Vprime` Step 4 |
| `NecSuf.toMatrix_collectedBasis_eq_diagonal` | その基底に関する表現行列は対角行列 | 同 Step 4 |
| `NecSuf.conj_pow_of_inv` / `conj_partialSum_of_inv` / `conj_series_limit_of_inv` | `uv = vu = 1` の下で `us^kv = (usv)^k`、部分和の共役、`x ↦ uxv` の連続性と極限の一意性から `u e v = e'` | `constant_c_value_even_sector` Step 2 |
| `NecSuf.isInternal_range_matrix_proj` / `exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj` | 上記の行列版（**対角化可能性**: `P P' = P' P = 1` かつ `P' A P = diagonal Λ`） | 同 Step 4 の結論 |

### 具体版（`Ising2D`, `Ising2D.FermiSetup`）

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した整数運動量の経路のものである（退避の記録はノートの各ブロックの冒頭にある）。

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `trace_eq_sum_diag` | `tr(A) = ∑_k A_{kk}`（mathlib `Matrix.trace` と一致） | `def_trace` |
| `trace_linear` / `trace_cyclic` / `trace_one_eq_card` / `trace_conj`（`DefinitionTrace.lean`） | 線型性・巡回性・`tr(I)=n`・共役不変 | `trace_basic_properties` (1)(2)(3)(4) |
| `trace_identity_eq_sum_one`（`DefinitionTrace.lean`。人手の 3 行と 1 対 1） | `tr(I_n) = Σ_{k=1}^{n} 1_ℂ` | `trace_basic_properties` (3) |
| `trace_add_matrix` / `trace_binaryWordMatrixSum` / `trace_of_scalar_multiple`（`ClaimTraceOfSumOverBinaryWords.lean`） | `tr(A+B) = tr(A)+tr(B)`、`tr(Σ_{ε∈{0,1}^r}B_ε) = Σ_ε tr(B_ε)`、`tr(αA) = αtr(A)` | `trace_of_sum_over_binary_words`（準備の鎖と帰納法）・`trace_of_scalar_multiple` |
| `trace_of_idempotent` | `Q^2=Q ⇒ tr(Q) = dim im Q` | `trace_of_idempotent` |
| `isCompl_range_ker_of_idempotent` | `ℂ^n = im Q ⊕ ker Q` | 同 Step 1 |
| `trace_one_tensorPow` | `tr(I) = 2^M` | `trace_of_number_operator_product` の `k=0` |
| `tensorPow_two_torsion_free` | `x+x=0 → x=0`（`Mat(2^M,ℂ)`。定義は本文の `EigenvalueProblem/EigenvaluesOfVPlus/DefinitionCheckNumberOperator.lean` にあり、ここから使う） | `number_operator_idempotent` (1) の「`2≠0`」 |
| `FermiSetup`（`DefinitionNumberOperator.lean`） | 原文 `def_number_operator` の設定（`𝓘`, 分枝 `t`） | `def_number_operator` |
| `FermiSetup.nOp` | `n_μ = ψ_μ^† ψ_{-μ}` | `def_number_operator` |
| `FermiSetup.acomm_cre_cre` / `acomm_ann_ann` / `acomm_cre_ann` | `𝓘` 上の CAR（`δ^M` が Kronecker `δ_{μν}` になる） | `anticommutator_of_psi` の制限 |
| `FermiSetup.cre_sq` / `ann_sq` | `(ψ^†)^2 = 0`, `(ψ)^2 = 0` | `number_operator_idempotent` (1) |
| `FermiSetup.ann_mul_cre` | `ψ_{-μ}ψ_μ^† = I - n_μ` | 同 (2) |
| `FermiSetup.nOp_mul_self` | `n_μ^2 = n_μ` | 同 (3) |
| `FermiSetup.commute_cre_nOp` / `commute_ann_nOp` | `ψ_μ^†, ψ_{-μ}` は `n_ν` と可換 | `number_operators_commute` (1) |
| `FermiSetup.commute_nOp_nOp` | `n_μ n_ν = n_ν n_μ` | 同 (2) |
| `FermiSetup.Qproj` / `Qproj'`（`ClaimJointEigenspaceDecomposition.lean`） | `Q_ε`（`Finset` 版 / `ε : 𝓘 → Bool` 版） | `joint_eigenspace_decomposition` |
| `FermiSetup.Qproj_mul_self` / `Qproj_mul_Qproj_of_ne` | (1) | 同 (1) |
| `FermiSetup.sum_Qproj` | `∑_ε Q_ε = I` | 同 (2) |
| `FermiSetup.nOp_mul_Qproj` | `n_ν Q_ε = ε_ν Q_ε` | 同 (3) |
| `FermiSetup.two_pow_mul_trace_Qproj` / `trace_Qproj` | `2^m tr(Q_ε) = 2^M`, `tr(Q_ε) = 2^{M-m}` | 同 (4) |
| `FermiSetup.finrank_range_Qproj` | `dim im Q_ε = 2^{M-m}` | 同 (4) 後半 |
| `FermiSetup.card_I_le` | `m ≤ M` | 同（`2^{M-m}` が書けることの根拠） |
| `FermiSetup.sum_Qproj_mulVec` / `eq_zero_of_sum_eq_zero` | 直和分解（張ること・直和性） | 同 (5) Step 5 |
| `FermiSetup.Xop` / `Vprime` / `gval`（`ClaimEigenvaluesAndTraceOfVprime.lean`） | `X`, `V' = exp(X)`, `g(ε)` | `def_number_operator`, `def_Vprime` |
| `FermiSetup.Xop_mul_Qproj` | `X Q_ε = g(ε) Q_ε` | `eigenvalues_of_Vprime` Step 1 |
| `FermiSetup.Vprime_mul_Qproj` | `V' Q_ε = e^{g(ε)} Q_ε` | 同 Step 3 |
| `FermiSetup.Vprime_mulVec_of_mem_range` | `im Q_ε` の元は固有ベクトル | 同 Step 4 |
| `FermiSetup.Vprime_mul_Vprime_neg` / `Vprime_neg_mul_Vprime` | `V'^{-1} = exp(-X)` | `trace_of_Vprime` Step 1 |
| `FermiSetup.sum_exp_gval` | `∑_ε e^{g(ε)} = ∏_μ 2cosh(γ_μ/2)` | 同 Step 3 |
| `FermiSetup.trace_Vprime` | `tr(V') = 2^{M-m}∏ 2cosh(γ_μ/2)` | 同 Step 2〜3 |
| `FermiSetup.trace_Vprime_inv` | `tr(V'^{-1}) = tr(V')` | 同 Step 4 |
| `FermiSetup.trace_Vprime_pos` | `tr(V') > 0` | 同 Step 5 |
| `pauliX/Y/Z_transpose`・`identity_matrix_two_transpose`（`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`） | Pauli 行列と 2 次の単位行列の転置 | `transpose_of_pauli_x`・`transpose_of_pauli_z`・`transpose_of_pauli_y`・`transpose_of_identity_matrix_of_order_two` |
| `identity_matrix_two_hasRealEntries`・`pauliX_hasRealEntries`・`pauliZ_hasRealEntries`（`PartitionFunction/ProjectionAndJordanWigner/ClaimPauliMatricesHaveRealEntries.lean`。人手の鎖と 1 対 1） | 2 次の単位行列・`σ^x`・`σ^z` の成分はすべて実数 | `identity_matrix_of_order_two_has_real_entries`・`pauli_x_has_real_entries`・`pauli_z_has_real_entries` |
| `pauliYReal`・`pauliY_eq_I_smul_pauliYReal`・`pauliYReal_hasRealEntries`（`PartitionFunction/ProjectionAndJordanWigner/ClaimPauliMatricesHaveRealEntries.lean`。人手の鎖と 1 対 1） | `σ^y` の実の因子 `R^y`、`σ^y = iR^y`、`R^y` の成分はすべて実数 | `def_real_factor_of_pauli_y`・`pauli_y_is_i_times_real_factor`・`real_factor_of_pauli_y_has_real_entries` |
| `pauliX/Y/Z_conjTranspose` | Pauli 行列の共役転置 | `iH_is_real_symmetric` Step 3 |
| `siteProd_transpose_apply` / `siteProd_transpose`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerTranspose.lean`。人手の成分の鎖の 4 行と 1 対 1） / `siteProd_conjTranspose`（`ClaimPositiveDefinite.lean`） | クロネッカー積の転置は因子ごとの転置、共役転置も因子ごと | `kronecker_transpose`（共役転置は原文には無い中間段階） |
| `real_inclusion_mul` / `finite_product_of_real_inclusions_is_real` / `MatrixHasRealEntries` / `siteProd_hasRealEntries`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/` の `ClaimRealInclusionPreservesProduct.lean`・`ClaimFiniteProductOfRealInclusionsIsReal.lean`・`DefinitionMatrixWithRealEntries.lean`・`ClaimKroneckerOfRealEntryMatricesHasRealEntries.lean`。人手の鎖と 1 対 1） | 実数の積の包含、実数の包含の有限積は実数の包含、成分がすべて実数の行列、そのクロネッカー積も成分がすべて実数 | `real_inclusion_preserves_product`・`finite_product_of_real_inclusions_is_real`・`def_matrix_with_real_entries`・`kronecker_of_real_entry_matrices_has_real_entries`（`iH_is_real_symmetric` Step 3 の成分の実性で引く） |
| `real_inclusion_of_power`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealInclusionPreservesPower.lean`。人手の `m = 0` の 3 行と帰納法の段の 4 行と 1 対 1。必要十分版 `NecSuf.map_pow_of_map_one_of_map_mul'`（`NecSuf/MultiplicativeMapPreservesPower.lean`。仮定は `f(1) = 1` と `f(ab) = f(a)f(b)` だけ）からの導出は `real_inclusion_of_power_of_necSuf`（同じフォルダの `ClaimRealInclusionPreservesPowerFromNecSuf.lean`）） | 実数の冪の包含は包含の冪 `(r^m)_ℂ = (r_ℂ)^m` | `real_inclusion_preserves_power`（`trace_of_check_number_operator_product` の基底段階と、`exponential_series_of_even_odd_power_terms` の中間目標「各項」で引く） |
| `real_inclusion_two_ne_zero` / `real_inclusion_half_eq_inv_two`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/` の `ClaimRealInclusionOfOneHalfIsInverseOfTwo.lean`。人手の鎖と 1 対 1） | `2_ℂ ≠ 0_ℂ` と `(1/2)_ℂ = 2_ℂ^{-1}` | `real_inclusion_of_one_half_is_inverse_of_two`（`V_plus_is_positive_definite` の `(V_1^{(+)})^{1/2}` の鎖と `symmetrized_transfer_matrix_on_sectors` の第一の鎖で、`def_V1_plus_square_root` の `i/2 = i·2_ℂ^{-1}` と `i(1/2)_ℂ` の間を移る行で引く） |
| `real_inclusion_add`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealInclusionPreservesSum.lean`。人手の 4 行の鎖と 1 対 1）/ `binaryWordRealSum`・`binaryWordComplexSum_ofReal`（`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/` の `DefinitionSumOverBinaryWords.lean`・`ClaimRealInclusionPreservesSumOverBinaryWords.lean`。帰納法の `r = 1` の 3 行・`r → r+1` の 4 行と 1 対 1 の `calc`。必要十分版 `NecSuf.binWordSum_map` からの導出と `NecSuf.binWordSum` の系 `binWordSum_ofReal` は同じフォルダの `DefinitionSumOverBinaryWordsFromNecSuf.lean`・`ClaimRealInclusionPreservesSumOverBinaryWordsFromNecSuf.lean`） | 実数の和の包含は包含の和、`{0,1}^r` の上の実数の和、その包含は包含の和 | `real_inclusion_preserves_sum`・`def_sum_over_binary_words_of_real_numbers`・`real_inclusion_preserves_sum_over_binary_words`（`trace_of_check_Vprime` Step 2 の 1 行目で引く） |
| `real_smul_hasRealEntries`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealScalarMultipleOfRealEntryMatrixHasRealEntries.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/ScalarMultipleOfClosedEntries.lean`） | 成分がすべて実数の行列の実数倍も成分がすべて実数 | `real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`iH_is_real_symmetric` Step 3 の `G` の成分の実性で引く） |
| `matrix_add_hasRealEntries`・`matrix_sub_hasRealEntries`・`sub_hasRealEntries_tensorPow`・`finite_sum_hasRealEntries`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimSumsOfRealEntryMatricesHaveRealEntries.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/SumsOfClosedEntries.lean`、導出は `ClaimSumsOfRealEntryMatricesFromNecSuf.lean`） | 成分がすべて実数の行列の和・差・有限和も成分がすべて実数 | `sum_of_real_entry_matrices_has_real_entries`・`difference_of_real_entry_matrices_has_real_entries`・`finite_sum_of_real_entry_matrices_has_real_entries`（`iH_is_real_symmetric` Step 3 の S_2・S_1^{(+)} の成分の実性で引く） |
| `matrix_mul_hasRealEntries`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimProductOfRealEntryMatricesHasRealEntries.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/ProductOfClosedEntries.lean`、導出は `ClaimProductOfRealEntryMatricesFromNecSuf.lean`） | 成分がすべて実数の行列の積も成分がすべて実数 | `product_of_real_entry_matrices_has_real_entries`（`power_of_real_symmetric_complex_matrix_is_real_symmetric`・`trace_power_upper_bound`・`moment_log_convexity` が引く。`W_is_real_symmetric_positive_definite` Step 1 の `σ^z_mσ^z_{m^+}` の成分の実性でも引く予定で、書き換えは状態台帳の (r2c1b2)） |
| `matrix_transpose_add`・`matrix_transpose_smul`・`matrix_transpose_sub`・`finite_sum_transpose_of_matrices`（`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixSumsAndScalarMultiples.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/TransposeOfMatrixSums.lean`、導出と `TensorPow M` の系は `ClaimTransposeOfMatrixSumsAndScalarMultiplesFromNecSuf.lean`） | 行列の和・スカラー倍・差・有限和の転置は、転置の和・スカラー倍・差・有限和 | `transpose_of_matrix_sum`・`transpose_of_matrix_scalar_multiple`・`transpose_of_matrix_difference`・`transpose_of_finite_sum_of_matrices`（`iH_is_real_symmetric` Step 3 の S_2・S_1^{(+)} の転置の鎖で引く） |
| `matrix_transpose_mul_apply`・`matrix_transpose_mul`（`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixProduct.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/TransposeOfMatrixProduct.lean`、導出と `TensorPow M` の系は `ClaimTransposeOfMatrixProductFromNecSuf.lean`） | 行列の積の転置は転置を逆の順に掛けた積 | `transpose_of_matrix_product`（`W_is_real_symmetric_positive_definite` の実対称性の鎖の「転置の積の法則」に当たる。引く形への書き換えは状態台帳の次の単位） |
| `Z_transpose` / `Z_conjTranspose` / `Y_transpose` / `Y_conjTranspose`（`ClaimPositiveDefinite.lean`） | `Z^⊤=Z`, `Y^⊤=-Y`, `Z^*=Z`, `Y^*=Y` | 同（原文には無い中間段階） |
| `S1plus_isHermitian` / `S1plus_transpose` / `S2_isHermitian` / `S2_transpose`（`EigenvalueProblem/EigenvaluesOfVPlus/ClaimIHPauliForm.lean`。`M_col ≥ 2` では Step 3 の鎖 `*_isHermitian_of_real_symmetric`・`*_transpose_by_pauli_form` そのもの。人手の主張は `G` の定義と Step 3 の `S_1^{(+)}` の成分の実性の段落により `M_col ≥ 2` を前提にする。鎖で埋まらない `S_1^{(+)}` の `M_col ≤ 1`・`S_2` の `M_col = 0` は下の補助で埋める） | `S_1^{(+)}, S_2` はエルミートで転置で不変（人手の本文は `(+)` だけ） | `iH_is_real_symmetric` |
| `S1plus_isRealSymmetric` / `S2_isRealSymmetric`（同じファイル。係数は `K_1, K_2^* ∈ ℝ`。`M_col ≥ 2`（`S_2` は `M_col ≥ 1`）では Step 3 の成分の実性 `S1plus_hasRealEntries`・`S2_hasRealEntries` と転置の鎖 `*_transpose_by_pauli_form` の組。範囲外は上のエルミート性と転置から `hermitian_and_transpose_invariant_matrix_is_real_symmetric`） | `S_1^{(+)}, S_2` は実対称（`MatrixIsRealSymmetric`） | `iH_is_real_symmetric` の結論 |
| `S1_isHermitian` / `S1_transpose` / `S2_isHermitian_by_anticommutation` / `H2_transpose`（`ClaimPositiveDefinite.lean`） | 反可換性による別の論法の補助（`S1_*` は境界項の係数を `η` にした一般形）。整数運動量の経路の `Vmat` が使い、`S1_*` は上の `S1plus_*` の `M_col ≤ 1`、`S2_isHermitian_by_anticommutation`・`H2_transpose` は上の `S2_*` の `M_col = 0` の場合に使う | 人手の論法ではない |
| `MatrixIsRealSymmetric`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/DefinitionRealSymmetricComplexMatrix.lean`） / `real_symmetric_isHermitian`・`complex_conjugate_of_real_inclusion`（`ClaimRealSymmetricMatrixIsHermitian.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/HermitianOfStarFixedSymmetricEntries.lean`、導出は `ClaimRealSymmetricMatrixIsHermitianFromNecSuf.lean`） | 成分がすべて実数で転置で不変な複素行列（実対称）はエルミート、`\overline{r_ℂ} = r_ℂ` | `def_real_symmetric_complex_matrix`・`real_symmetric_matrix_is_hermitian`・`complex_conjugate_of_real_inclusion` |
| `hermitian_and_transpose_invariant_matrix_is_real_symmetric`・`exists_real_of_star_eq`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimHermitianAndTransposeInvariantMatrixIsRealSymmetric.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/StarFixedEntriesOfHermitianSymmetric.lean` の `star_fixed_entries_of_hermitian_symmetric`、導出は `ClaimHermitianAndTransposeInvariantMatrixIsRealSymmetricFromNecSuf.lean`） | `A^* = A` かつ `A^⊤ = A` なら `A` は実対称 | `hermitian_and_transpose_invariant_matrix_is_real_symmetric` |
| `matrix_conjTranspose_mul` / `matrix_conjTranspose_add_smul` / `matrix_conjTranspose_norm` / `matrix_conjTranspose_tendsto`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimStarPreservesNormAndLimits.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/StarPreservesNormAndLimits.lean` の `conjTranspose_mul_matrix'`・`conjTranspose_add_smul_matrix'`・`conjTranspose_norm'`・`conjTranspose_tendsto'`、導出と `TensorPow M` の系 `conjTranspose_mul_tensorPow`・`conjTranspose_tendsto_tensorPow` は `ClaimStarPreservesNormAndLimitsFromNecSuf.lean`） | `(AB)^* = B^*A^*`、`(αA + βB)^* = \overline{α}A^* + \overline{β}B^*`、`‖A^*‖ = ‖A‖`、`A_N → A` なら `A_N^* → A^*` | `star_preserves_norm_and_limits` |
| `matrix_transpose_norm` / `matrix_transpose_tendsto`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTransposePreservesMatrixNormAndLimits.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/TransposePreservesMatrixNormAndLimits.lean` の `transpose_norm'`・`transpose_tendsto'`、導出は `ClaimTransposePreservesMatrixNormAndLimitsFromNecSuf.lean`） | `‖A^⊤‖ = ‖A‖` と、`A_N → A` なら `A_N^⊤ → A^⊤` | `transpose_preserves_matrix_norm` / `transpose_preserves_matrix_limits` |
| `matExp_transpose_of_transpose_eq`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfSymmetricIsSymmetric.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/SeriesOfSymmetricIsSymmetric.lean` の `limit_transpose_of_transpose_eq'` ほか、導出は `ClaimExpOfSymmetricIsSymmetricFromNecSuf.lean`） | `S^⊤ = S` なら `exp(S)^⊤ = exp(S)` | `exp_of_symmetric_is_symmetric` |
| `matExp_conjTranspose_of_conjTranspose_eq`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfHermitianIsHermitian.lean`。人手の鎖と 1 対 1。冒頭の `I^* = I` は `identity_matrix_is_positive_definite` のエルミート性の 5 行を `identity_conjTranspose_tensorPow` に置いた。必要十分版は `NecSuf/SeriesOfHermitianIsHermitian.lean` の `limit_conjTranspose_of_conjTranspose_eq'` ほか、導出は `ClaimExpOfHermitianIsHermitianFromNecSuf.lean`。使う側の `posDef_exp_of_isHermitian`（`T^* = T`）と `exp_of_real_symmetric_is_real_symmetric` はこれを引く。`Vmat_posDef`・`VPlus_posDef`・`VPlusInv_posDef` の `B^* = B` は、人手どおり `posDef_exp_of_isHermitian` の正定値性から読む（mathlib の `Matrix.IsHermitian.exp` は使っていない）） | `S^* = S` なら `exp(S)^* = exp(S)` | `exp_of_hermitian_is_hermitian` |
| `exp_of_real_symmetric_is_real_symmetric`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfRealSymmetricIsRealSymmetric.lean`。`TensorPow M` で述べる。人手の 4 行は `real_symmetric_isHermitian`・`MatrixIsRealSymmetric` の第 2 成分・`matExp_conjTranspose_of_conjTranspose_eq`・`matExp_transpose_of_transpose_eq`、結論は `hermitian_and_transpose_invariant_matrix_is_real_symmetric` と 1 対 1。既存の主張を並べるだけなので必要十分版は置かない。使う側は `PhysicalPartitionFunctionSandwich.lean` の `physicalV1halfC_isRealSymmetric`・`expS2C_isRealSymmetric` と `ClaimVPlusRealEntries.lean` の `V1plusHalf_isRealSymmetric`・`V2H2Form_hasRealEntries`） | 実対称な複素行列の `exp` は実対称 | `exp_of_real_symmetric_is_real_symmetric` |
| `power_of_real_symmetric_complex_matrix_is_real_symmetric`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPowerOfRealSymmetricComplexMatrixIsRealSymmetric.lean`。`TensorPow M` で述べる。準備の 4 行は `matrix_pow_one_eq_self_tensorPow`、`p = 0` は `identity_matrix_entry_cases_tensorPow`・`identity_matrix_hasRealEntries_tensorPow`・`identity_matrix_isRealSymmetric_tensorPow`、`p + 1` の転置の 11 行は `matrix_pow_succ_transpose_apply_tensorPow` と 1 対 1。必要十分版は `NecSuf/PowerOfSymmetricMatrixWithClosedEntries.lean` の `pow_entries_mem_and_transpose_eq'`、導出は `ClaimPowerOfRealSymmetricComplexMatrixIsRealSymmetricFromNecSuf.lean`。使う側は `trace_power_upper_bound` の【冪の対称性】（具体版はまだ無い）） | 実対称な複素行列の冪は実対称 | `power_of_real_symmetric_complex_matrix_is_real_symmetric` |
| `S2_isHermitian_of_real_symmetric`・`S1plus_isHermitian_of_real_symmetric`（`EigenvalueProblem/EigenvaluesOfVPlus/ClaimIHPauliForm.lean`） | `S_2`・`S_1^{(+)}` は実対称なのでエルミート | `iH_is_real_symmetric` Step 3 の最後の文 |
| `conjugate_bilinear_value_of_positive_real_multiple` / `positive_real_multiple_preserves_positive_definite`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPositiveRealMultiplePreservesPositiveDefinite.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/PositiveMultiplePreservesPositiveDefinite.lean`、導出と `TensorPow M` の系 `positive_real_multiple_preserves_positive_definite_tensorPow` は `ClaimPositiveRealMultiplePreservesPositiveDefiniteFromNecSuf.lean`） | 正値性の 13 行の鎖 `x^*(α_ℂA)x = (αr)_ℂ`、正定値の正実数倍は正定値 | `positive_real_multiple_preserves_positive_definite` |
| `posDef_exp_of_isHermitian`（`TensorPow M`。`T^* = T` は `matExp_conjTranspose_of_conjTranspose_eq` を引くが、正定値性は mathlib の `Matrix.PosDef.conjTranspose_mul_self` で示しており、人手の合同変換の段とは一対一でない） | エルミートの `exp` は正定値 | `exp_hermitian_is_positive_definite` |
| `conjugateBilinearValue` / `posDef_conjugateBilinearValue_pos` / `standardBasisVec_ne_zero` / `star_kroneckerDelta` / `kroneckerDelta_comm` / `conjugate_bilinear_value_basis_eq_diag` / `trace_of_positive_definite_is_positive`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTraceOfPositiveDefiniteIsPositive.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/TraceOfPositiveDefinite.lean`） | `x^*Ay` の式、正定値の読み替え、`b^{(k)*}Ab^{(k)} = A_{kk}`、正定値行列のトレースは正 | `def_conjugate_bilinear_value`、`trace_of_positive_definite_is_positive` |
| `conjugate_bilinear_value_of_congruence` / `conjTranspose_conjTranspose_apply`・`conjTranspose_conjTranspose_eq` / `mulVec_zero_apply`・`mulVec_zero_eq` / `congruence_isHermitian` / `mulVec_ne_zero_of_left_inverse` / `congruence_preserves_positive_definite` / `posDef_of_conjugateBilinearValue_pos`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimCongruencePreservesPositiveDefinite.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/CongruencePreservesPositiveDefinite.lean`、導出と `TensorPow M` の系 `congruence_preserves_positive_definite_tensorPow` は `ClaimCongruencePreservesPositiveDefiniteFromNecSuf.lean`） | `x^*(B^*(AB))y = (Bx)^*A(By)`、準備の `(B^*)^* = B`・`B'0 = 0`、エルミート性の鎖、`B'B = I` なら `Bx ≠ 0`、`B^*(AB)` は正定値、人手の正値の条件から `Matrix.PosDef` を得る読み替え | `conjugate_bilinear_value_of_congruence`、`congruence_preserves_positive_definite` |
| `real_multiple_isHermitian`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealMultipleOfHermitianIsHermitian.lean`。人手の鎖と 1 対 1。必要十分版は `NecSuf/StarFixedScalarMultipleOfHermitian.lean`、導出 `real_multiple_isHermitian_of_necSuf` は `ClaimRealMultipleOfHermitianIsHermitianFromNecSuf.lean`） | `α ∈ ℝ`、`A^* = A` なら `(α_ℂA)^* = α_ℂA` | `real_multiple_of_hermitian_is_hermitian` |
| `Vmat` / `Vmat_posDef` / `trace_Vmat_pos` | `V` の定義・正定値性・`tr(V) > 0` | `V_is_positive_definite` |
| `eFlipFam` / `Eflip` / `Fflip` / `Uflip` / `UflipInv` / `eFlipFam_mul_self` / `Fflip_mul_self` / `Eflip_mul_self` / `Uflip_mul_inv` / `UflipInv_mul` | `E_m`・`E = E_1⊠⋯⊠E_M`・`F = σ^z⊠⋯⊠σ^z`・`U = EF`・`U^{-1} = FE`、`E_mE_m = I`・`FF = I`・`EE = I`（人手の鎖と 1 対 1）、`U` の可逆性（`def_invertible_elements_of_R` (ii) の証明の鎖を `g_1 = E`・`g_2 = F` で） | `sign_flip_conjugation` の定義と Step 0 |
| `siteProd_conj_siteOp` / `siteProd_update_conj_eq_siteOp` / `siteProd_update_eFlipFam_conj_of_odd` / `Fflip_conj_siteOp` / `Eflip_conj_siteOp_of_even` / `Eflip_conj_siteOp_of_odd` / `Fflip_conj_sigmaX` / `Fflip_conj_sigmaY` / `Fflip_conj_sigmaZ` / `Eflip_conj_sigmaX_of_even` / `Eflip_conj_sigmaY_of_even` / `Eflip_conj_sigmaZ_of_even` | `(Wσ_k^a)W = I⊠⋯⊠((W_kσ^a)W_k)⊠⋯⊠I`、`I⊠⋯⊠((σ^pσ^a)σ^p)⊠⋯⊠I = (σ_k^pσ_k^a)σ_k^p`、`k` 偶数の `E` の鎖、`F`・`E` による共役の鎖の全体（人手の鎖と 1 対 1。Lean の添字 `(k : ℕ)` 偶数が人手の `k` 奇数） | 同 Step 1 の `W` の鎖と `F`・`E` による共役の鎖の 1 行目 |
| `Eflip_conj_sigmaX_of_odd` / `Eflip_conj_sigmaY_of_odd` / `Eflip_conj_sigmaZ_of_odd` | `E` による共役の第 1 式（人手の `k` 偶数）を `a = x, y, z` で | 同 Step 1 の `E` による共役の鎖 |
| `Uflip_conj_eq_Eflip_conj_Fflip_conj` / `Uflip_conj_sigmaX_eq_neg` / `Uflip_conj_sigmaY_of_even` / `Uflip_conj_sigmaY_of_odd` / `Uflip_conj_sigmaZ_of_even` / `Uflip_conj_sigmaZ_of_odd` | `UXU^{-1} = E(FXF^{-1})E^{-1}`、`Uσ_k^xU^{-1} = -σ_k^x`、`Uσ_k^yU^{-1}`・`Uσ_k^zU^{-1}` の偶奇ごとの値（人手の鎖と 1 対 1。Lean の `(k : ℕ)` 偶数が人手の `k` 奇数） | 同 Step 1 の合成の鎖とその後の 3 本の鎖 |
| `siteOp_mul_of_anticomm` / `sigmaZ_mul_sigmaX_site` / `sigmaY_mul_sigmaZ_site` / `sigmaY_mul_sigmaX_site` / `sigmaZ_sigmaX_sigmaZ_site` / `sigmaZ_sigmaY_sigmaZ_site` / `sigmaZ_sigmaZ_sigmaZ_site` / `sigmaX_sigmaX_sigmaX_site` / `sigmaX_sigmaY_sigmaX_site` / `sigmaX_sigmaZ_sigmaX_site` | `AB = -(BA)` なら `siteOp k A * siteOp k B = -(siteOp k B * siteOp k A)`（人手の 10 行の鎖。特殊化が `(p, q) = (z, x), (y, z), (y, x)`）、`(σ_k^zσ_k^a)σ_k^z`（`a = x, y, z`）と `(σ_k^xσ_k^a)σ_k^x`（`a = x, y, z`）の値（人手の鎖の行と 1 対 1） | 同 Step 1 の `σ_k^pσ_k^q` の鎖と、`F`・`E` による共役の鎖の、`W` の鎖と `(σ_k^pσ_k^a)σ_k^p` の鎖より後の行 |
| `UflipUnit` / `Uflip_conj_mul` / `Uflip_conj_smul` | `U` を可逆元とする単元、共役は積を保つ（`Conjugation.conj_mul_tensorPow` の特殊化）、`(U(cA))U^{-1} = c((UA)U^{-1})` | 同 Step 2・Step 3 の `conjugation_is_ring_homomorphism` の 3 行、Step 4 の `scalar_multiple_factors_out_of_right_factor`・`..._left_factor` の 2 行 |
| `Uflip_conj_xString_zero` / `Uflip_conj_xString_succ` / `Uflip_conj_xString_parity` / `Uflip_conj_xString_of_even` / `Uflip_conj_xString_of_odd` | `P_r`（Lean の `xString M r`）について、`UP_0U^{-1} = P_0`（`T_B` の定義・単位性）、`UP_{r+1}U^{-1} = -((UP_rU^{-1})σ_{r+1}^x)`（場合分けの前の 6 行）、`UP_rU^{-1}` は `r` 偶数で `P_r`・奇数で `-P_r`（人手の帰納法と 1 対 1） | `sign_flip_conjugation` Step 2 の `UP_rU^{-1}` の帰納法 |
| `Uflip_conj_Z` / `Uflip_conj_Y` | `U Z_m U^{-1} = -Z_m`, `U Y_m U^{-1} = Y_m`（人手の `Z_m`・`Y_m` の鎖と 1 対 1。場合分けの行は `(m : ℕ)` の偶奇ごとの `calc` に分ける。Lean の `(m : ℕ)` 偶数が人手の `m` 奇数） | 同 Step 2 の Z_m と Y_m の鎖 |
| `Uflip_conj_YZ` / `Uflip_conj_ZY` / `Uflip_conj_H1plus` / `Uflip_conj_H2` / `Uflip_conj_S1plus` / `Uflip_conj_S2` | `U(Y_jZ_k)U^{-1} = -(Y_jZ_k)`・`U(Z_jY_j)U^{-1} = -(Z_jY_j)`（Step 3 の項の鎖）、`U H U^{-1} = -H`, `U S U^{-1} = -S`（`H = H_1^{(+)}, H_2`。`Uflip_conj_H1plus` は `M = r + 2` で人手の `H_1^{(+)}` の鎖の 9 行と 1 対 1（両端は `H1plus_eq_sub`）、`Uflip_conj_H2` は人手の `H_2` の鎖の 7 行と 1 対 1。`Uflip_conj_H1` / `Uflip_conj_S1` は補助の一般形） | `sign_flip_conjugation` |
| `Uflip_conj_pow` / `Uflip_conj_expPartialSum` | `US^kU^{-1} = (USU^{-1})^k`、部分和の共役 `U s_n(S) U^{-1} = s_n(USU^{-1})` | `constant_c_value` Step 2 |
| `Uflip_conj_matExp` | `U exp(S) U^{-1} = exp(USU^{-1})`（部分和の共役・ノルム評価による極限との交換・極限の一意性） | `constant_c_value` Step 2 |
| `VmatInv` / `Vmat_mul_VmatInv` / `VmatInv_mul_Vmat`（`ClaimConstantCAndEigenvaluesOfV.lean`） | `V^{-1}` の明示形 | `V_is_positive_definite` Step 4 |
| `tauTrace` / `trace_Vmat` / `trace_VmatInv` | `τ`, `tr(V) = (2s_2)^{M/2}τ`, `tr(V^{-1}) = (2s_2)^{-M/2}τ` | `constant_c_value` Step 1 |
| `trace_exp_neg_eq_tau` | `tr(exp(-S_1)exp(-S_2)) = τ` | 同 Step 2 |
| `constant_c_value` | **`c = (2 sinh 2K_2)^{M/2}`** | `constant_c_value` |
| `bigLambda` / `Vmat_mul_Qproj` | `Λ_ε` と **`V Q_ε = Λ_ε Q_ε`** | `eigenvalues_of_V` (1) |
| `bigLambda_pos` | `Λ_ε > 0` | 同 (2) |
| `bigLambda_le_max` / `bigLambda_min_le` | `Λ_max` は全 `ε_μ=1`、`Λ_min` は全 `ε_μ=0` | 同 (2) |
| `bigLambda_max_mul_min` | `Λ_max Λ_min = (2 sinh 2K_2)^M` | 同 |
| `FermiSetup.isInternal_range_Qproj` | **`ℂ^{2^M} = ⊕_ε im Q_ε`（内部直和）** | `joint_eigenspace_decomposition` (5) |
| `FermiSetup.iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj` | 同 (5) を `Submodule` の言葉で分けて述べた版 | 同 (5) |
| `FermiSetup.exists_eigenBasis_Vprime` | **`V'` の固有ベクトルからなる基底が取れ、表現行列は対角行列** | `eigenvalues_of_Vprime`（対角化可能） |
| `FermiSetup.exists_conj_diagonal_Vprime` | **`P' V' P = diagonal Λ`（`P` は可逆）** | 同 |
| `FermiSetup.exists_conj_diagonal_Vmat` | **`V = cV'` を仮定した `V` の対角化** | `eigenvalues_of_V`（対角化可能） |

---

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した整数運動量の経路のものである（退避の記録はノートの各ブロックの冒頭にある）。

| 人手証明のラベル | 具体版 | 必要十分版 |
| --- | --- | --- |
| `def_number_operator` | `Ising2D.FermiSetup.nOp`（`Mat(2^M,ℂ)`） | `Ising2D.NecSuf.num`（任意の環、任意の添字型） |
| `number_operator_idempotent` | `FermiSetup.cre_sq` / `ann_sq` / `ann_mul_cre` / `nOp_mul_self` | `NecSuf.sq_eq_zero_of_acomm_self` / `ann_mul_cre` / `num_mul_num` |
| `number_operators_commute` | `FermiSetup.commute_cre_nOp` / `commute_ann_nOp` / `commute_nOp_nOp` | `NecSuf.commute_cre_num` / `commute_ann_num` / `commute_num_num` |
| `trace_of_number_operator_product` | `FermiSetup.two_pow_mul_trace_Qproj`（`Matrix.trace`） | `NecSuf.tau_num_mul_add_self` / `two_pow_smul_tau_projOn`（加法的かつ巡回的な汎関数） |
| `joint_eigenspace_decomposition` (1)(2)(3)(4) | `FermiSetup.Qproj_*` / `sum_Qproj` / `nOp_mul_Qproj` / `trace_Qproj` | `NecSuf.projOn_*` / `sum_projOn` / `num_mul_projOn` / `two_pow_smul_tau_projOn` |
| `eigenvalues_of_Vprime` Step 2/3 | `FermiSetup.Vprime_mul_Qproj` | `NecSuf.pow_mul_eq_of_mul_eq_smul` / `exp_mul_eq_of_mul_eq_smul` |
| `joint_eigenspace_decomposition` (5) | `FermiSetup.isInternal_range_Qproj` / `iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj`（既存の `sum_Qproj_mulVec` / `eq_zero_of_sum_eq_zero` が人手証明の書き方に 1 対 1 で対応する版） | `NecSuf.isInternal_range_proj` / `isInternal_range_matrix_proj`（任意の環上の加群、有限個の直交射影だけ） |
| `eigenvalues_of_Vprime` / `eigenvalues_of_V`（対角化可能） | `FermiSetup.exists_eigenBasis_Vprime` / `exists_conj_diagonal_Vprime` / `exists_conj_diagonal_Vmat` | `NecSuf.exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj`（任意の体上の有限次元、固有関係 `f Q_ε = c_ε Q_ε` だけ） |

具体版はいずれも**必要十分版を特殊化して導出している**（`DefinitionNumberOperator.lean` /
`ClaimJointEigenspaceDecomposition.lean` / `ClaimEigenvaluesAndTraceOfVprime.lean` を参照）。
そのうえで、人手証明と 1 対 1 に対応する形の主張を具体版として別に立ててある。

### 必要十分版で判明した本質

- **直和分解 (5) に効いているのは「有限個の直交射影の和が恒等」だけ**である。行列であること・
  有限次元性・複素数であること・個数演算子であること・CAR はどれも効いていない。
  さらに **`Q_ε^2 = Q_ε`（原文 (1) 後半）は独立な仮定ではなく、(1) 前半と (2) から従う**
  （`NecSuf.idem_of_ortho_of_sum_eq_one`）。原文が 2 つに分けて述べている性質の一方は冗長である。
- **対角化可能性に追加で効いているのは、係数が体であること（各成分に基底が取れる）と
  固有関係 `f Q_ε = c_ε Q_ε` だけ**である。`V'` が指数関数であることも、固有値が正の実数であることも
  効いていない。

- **個数演算子の冪等性・可換性に効いているのは、台が環であることと CAR、
  そして加法群に 2-捩れが無いこと（`x + x = 0 → x = 0`）の 3 つだけ**である。
  `ψ` の具体形（`hat(Z)^{(-)}, hat(Y)` の線型結合）も、行列であることも、
  複素数であることも、テンソル冪であることも、`M` も `γ_2` も効いていない。
  添字型は等号の決定可能性すら要らない（`δ_{ij}` は各定理へ反交換子の値として渡すだけ）。
  2-捩れの仮定は**省略できない**: 標数 2 では `(ψ^†)^2 = 0` が CAR から出ない。

- **同時固有空間分解 (1)(2)(3) に効いているのは、台が環であることと
  「`n_i` が互いに可換な冪等元であること」の 2 つだけ**である。CAR すら要らない
  （CAR は `n_i` が可換な冪等元であることを導くために使うだけ）。

- **トレースの計算に効いているのは「加法的かつ巡回的な汎関数 `τ` が 1 つあること」だけ**である。
  `τ` の値域は任意の可換群でよく（(4) では可換**群**、`trace_of_number_operator_product` の
  帰納段階だけなら可換モノイドで足りる）、割り算も、複素数であることも、
  行列のトレースであることも効いていない。`τ(1) = 2^M` という具体値も結論に
  そのまま現れるだけである。

- **人手証明 (4) の二項展開と二項定理は不要**である。効いているのは
  「どちらの因子（`n_j` でも `1 - n_j` でも）についても `2 τ(R_j X) = τ(X)`」という
  1 段の帰納法だけで、`1 - n_j` の場合はその差として自動的に出る。

- **`exp(X) Q = e^{g} Q` に効いているのは ℂ 上の完備ノルム環であることだけ**である。
  行列であることも、有限次元であることも、`Q` が射影であることも効いていない。

- 積の順序について: 人手証明の「因子は互いに可換なので積の順序は問わない」は、
  Lean では `Finset.noncommProd`（可換性の証明を引数に取る積）としてそのまま書ける。
  非可換環に `Finset.prod` が無いことへの回避であり、数学的な内容は増えていない。

### 必要十分版を置かなかった主張とその理由

- `def_trace` / `trace_basic_properties`: mathlib の `Matrix.trace_add` / `trace_smul` /
  `trace_mul_comm` / `trace_one` が既に任意の可換半環について述べており、
  これ以上取り払える構造が無い。巡回性という**性質だけ**を仮定にした必要十分版は
  上記の `τ` として存在する。
- `iH_is_real_symmetric` / `V_is_positive_definite` / `sign_flip_conjugation` /
  `constant_c_value` / `eigenvalues_of_V`: いずれも**この模型の具体的な対象**
  （`Z_m, Y_m, H_1^{(±)}, H_2, V_1, V_2, U`）についての主張であり、
  取り払える一般構造が無い。使っている一般論（トレースの線型性・巡回性、
  共役が環準同型であること、`exp` の性質）はすべて既存の必要十分版で押さえてある。

---

## 3. 形式化できなかった主張とその理由

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した整数運動量の経路のものである（退避の記録はノートの各ブロックの冒頭にある）。

| 原文の主張 | 状況 | 理由 |
| --- | --- | --- |
| `joint_eigenspace_decomposition` (5) の `DirectSum.IsInternal` 形 | **形式化した（2026-07-30）** | `Ising2D.FermiSetup.isInternal_range_Qproj`（`RoutesNotAdopted/IntegerMomentum/ClaimDirectSumAndDiagonalizationOfV.lean`）。必要十分版 `Ising2D.NecSuf.isInternal_range_matrix_proj`（`NecSuf/JointEigenspaceDecomposition.lean`）の特殊化。人手証明 Step 5 の 2 つの事実（`x = ∑_ε Q_ε x` / 直和性）は従来どおり `sum_Qproj_mulVec` / `eq_zero_of_sum_eq_zero` にあり、`Submodule` の言葉での対応物が `iSup_range_Qproj_eq_top` / `iSupIndep_range_Qproj` である |
| `eigenvalues_of_Vprime` / `eigenvalues_of_V` の「`V'`（`V`）は対角化可能」 | **形式化した（2026-07-30）** | `Ising2D.FermiSetup.exists_eigenBasis_Vprime`（固有ベクトルからなる基底 `b` と `LinearMap.toMatrix b b V' = diagonal Λ`）、`exists_conj_diagonal_Vprime`（`P' V' P = diagonal Λ`, `P P' = P' P = 1`）、`exists_conj_diagonal_Vmat`（`V = cV'` を仮定した `V` 版）。いずれも必要十分版 `Ising2D.NecSuf.exists_eigenBasis_of_matrix_proj` / `exists_conj_diagonal_of_matrix_proj` の特殊化 |
| `γ(θ_μ) = arccosh(γ_1(θ_μ))` であること | **仮定として受け取った** | mathlib に `Real.arccosh` が無い（`lean/README.md`「mathlib に無いことが分かっているもの」に既出）。本章が `γ` について使うのは `γ(θ_μ) ≥ 0` だけなので、非負実数の族 `g : 𝓘 → ℝ` として受け取っている |
| `V_eq_Vprime`（008 章、「ある `c ∈ ℂ^×` が存在して `V = cV'`」） | **仮定として受け取った** | 008 章の内容で本リポジトリでは未形式化。`constant_c_value` の仮定 `hVeq : Vmat = c • Vprime` として明示 |
| `gamma_2_theta_is_0` による `𝓘` の同定（`𝓘 = {1,…,M}` または `{1,…,M-1}`） | **仮定として受け取った** | 008 章の内容（`Ising2D.gamma2_eq_zero_iff` として形式化済み）。009 章では「`{1,…,M}` に含まれ、そこで `γ_2(θ_μ) ≠ 0` となる有限集合 `I`」として `FermiSetup` の仮定に置いた |
| `ψ` の平方根の分枝の一意性 | **仮定として受け取った** | 008 章で既に指摘済みの**原文の穴**。`FermiSetup.hbr` として明示（`docs/tasks/2026-07_lean-ch009-013/001_...md` (2) 参照） |

---

## 4. 人手証明に見つかった問題

`exact-solution-of-2d-ising-model/docs/tasks/2026-07_lean-ch009-013/003_ch009_未定義記号と暗黙の仮定.md`
に一次情報つきで記録した。要約:

1. `number_operator_idempotent` の証明中で、009 章では定義されていない記号 `\mathcal{M}` を使っている。
2. 平方根の分枝の整合（008 章で指摘済みの穴）が 009 章にも波及するが、本章はそれに触れていない。
3. `constant_c_value` Step 3 の `V^{-1} = c^{-1}V'^{-1}` に逆元の一意性への言及がない
   （可逆性は他のブロックにあるので埋まる）。

いずれも**結論を覆すものではない**。加えて、`sign_flip_conjugation` の `M` の偶奇による場合分けと
`joint_eigenspace_decomposition` (4) の二項定理は、証明として正しいが**不要**であることが分かった
（同じ文書の「誤りではないが冗長と分かった箇所」参照）。
