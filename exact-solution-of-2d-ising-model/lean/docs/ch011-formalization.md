# 章 011「転送行列の最大固有値と分配関数の挟み撃ち」の Lean 形式化

正本: `structured-latex/content/011_max_eigenvalue.ts`。ただし `def_transfer_matrix_square_root`・`def_symmetrized_transfer_matrix`・
`symmetrized_transfer_matrix_on_sectors` の正本は `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`（2026-10-31 の章立ての組み直しで移した）。
`Z_equals_trace_of_W`・`W_is_real_symmetric_positive_definite`・`def_rayleigh_sup`・`rayleigh_bounds_operator_norm`・`trace_power_upper_bound`・
`moment_log_convexity`・`trace_power_sandwich`・`partition_function_sandwich` の正本は `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`（同じく移した）。
`W_has_positive_entries`・`def_sector_rayleigh_sup`・`c_plus_le_c`・`epsilon_commutes_with_W`・`epsilon_is_real_symmetric` の正本は
`structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`（同じく移した）。011 に残るのは `def_real_bilinear_value`・`def_real_symmetric_matrix`・`real_bilinear_value_of_symmetric_matrix_is_symmetric`・`real_bilinear_value_is_additive_in_right_vector`・`real_bilinear_value_is_additive_in_left_vector`・`real_bilinear_value_with_nonnegative_entries_is_nonnegative`・`real_bilinear_value_of_scalar_multiple_vector`・`real_bilinear_value_is_sum_with_real_matrix_vector_product`・`real_symmetric_matrix_moves_between_factors_of_sum_of_products`・`real_bilinear_value_at_most_value_at_absolute_vector`・`norm_of_vector_of_absolute_values_equals_norm`・`norm_of_normalized_real_vector_is_one`・`real_matrix_fixed_vector_stays_fixed_after_normalization`・`real_bilinear_value_of_normalized_vector`・`psd_cauchy_schwarz` である。

**`(−)` セクターの退避（2026-09-26）**: 人手の本文は `(+)` セクターだけで述べる形になり、
`c(M) = max(c_+(M), c_-(M))`（`sector_decomposition_of_rayleigh_sup`）は参照用ノート
`structured-latex/notes/minus_sector_not_adopted.ts` へ移った。代わりに本文には
`c_+(M)` だけの定義（`def_sector_rayleigh_sup`）、`c_plus_le_c`（`c_+(M) ≤ c(M)`）、
`epsilon_is_real_symmetric`（`ε^⊤ = ε`）が立ち、`epsilon_commutes_with_W` と
`symmetrized_transfer_matrix_on_sectors` は `(+)` だけの主張になった。
`sector_decomposition_of_rayleigh_sup` の Lean（`RoutesNotAdopted/MinusSector/ClaimRayleighSupSectorDecomposition.lean`）は
形式化の記録として残し、ビルドは通し続ける（下の表の「ノート」の行）。本文の主張の Lean はこれに依存しない。

この文書は `lean/README.md` への統合前の記録である（統合は呼び出し元が行う）。

## 0. 土台の選択

章 011 は**実行列 `W ∈ Mat(2^M, ℝ)` と実ベクトル空間 `ℝ^{2^M}`** の上の議論なので、
他章の `TensorPow M = Matrix (Conf M) (Conf M) ℂ`（複素）ではなく
`Matrix n n ℝ`（`n` は有限型。Ising では `n = Conf M` で `Fintype.card n = 2^M`）を土台にした。
ベクトルは `n → ℝ`、ユークリッドノルムは `Ising2D.vecNormSq` / `Ising2D.vecNorm` として
自前で定義してある（`n → ℝ` に mathlib が入れる既定のノルムは sup ノルムなので使えない）。

**スペクトル定理（実対称行列の対角化可能性）は一切使っていない。**
上からの評価は `rayleigh_bounds_operator_norm` から、下からの評価はモーメント列
`m_k = xᵀW^k x` の対数凸性から出しており、人手証明の経路と 1 対 1 に対応する。

## 1. 形式化した定理の一覧

### 1.1 具体版

`c(M) = max(c_+(M), c_-(M))`（参照用ノートへ退避した `sector_decomposition_of_rayleigh_sup`）の形式化の記録は `lean/Ising2D/RoutesNotAdopted/MinusSector/ClaimRayleighSupSectorDecomposition.lean` にある。

`psd_cauchy_schwarz`（数学的道具立て「トレース・共役転置・正定値性」）の `ClaimPsdCauchySchwarz.lean` と補助の `RealMatrixBilinearFormAndNorm.lean` は
`lean/Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/` にある。
章「N→∞ の極限と最大固有値 c(M)」に当たる `c(M)` の定義・`‖Wx‖ ≤ c(M)‖x‖`・`trace_power_upper_bound`・`moment_log_convexity`・`trace_power_sandwich`・具体的な `Z`・`W` の分配関数の挟み撃ちのファイルは
`lean/Ising2D/ThermodynamicLimit/RowLimitAndMaxEigenvalue/` にある（`DefinitionRayleighSup`・`ClaimOperatorBound`・`ClaimTracePowerUpperBound`・`ClaimTracePowerUpperBoundFromNecSuf`・`ClaimMomentLogConvexity`・`ClaimMomentLogConvexityFromNecSuf`・`ClaimTracePowerSandwichUnitVectorBound`・`ClaimTracePowerSandwichUnitVectorBoundFromNecSuf`・`ClaimTracePowerSandwich`・`PhysicalPartitionFunctionSandwich`）。
章「M→∞ の極限と閉形式」に当たる `c_+(M)` の定義・`c_+ ≤ c`・`ε^⊤ = ε`・`ε_ℝ := ϱ(ε)` と `ε_ℝx = x ⟺ ι(x) ∈ 𝓕^{(+)}`・`ε_ℝ` の対称性と `ε_ℝε_ℝ = I`・`ε` の成分と `(ε_ℝu)_{ord(s)} = u_{ord(-s)}`・`u_k ≥ 0 (∀k)` なら `(ε_ℝu)_k ≥ 0 (∀k)`・`u_k ≥ 0 (∀k)` かつ `u ≠ 0` なら `u_k + (ε_ℝu)_k` を成分とするベクトルは 0 でない・`‖u‖ = 1` なら `u_k + (ε_ℝu)_k` を成分とするベクトル `v` について `‖v‖^2 ≤ 4`・`εW = Wε` と `ε_ℝW_ℝ = W_ℝε_ℝ`・`u_k ≥ 0 (∀k)` なら `u_k + (ε_ℝu)_k` を成分とするベクトル `v` について `v^⊤W_ℝv ≥ 2(u^⊤W_ℝu)`・具体的な `W` と `W_ℝ` の成分の正値性のファイルは
`lean/Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/` にある（`DefinitionSectorRayleighSup`・`ClaimCPlusLeC`・`ClaimEpsilonIsRealSymmetric`・`ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors`・`ClaimEpsilonRealIsSymmetricAndSquareIsIdentity`・`ClaimEpsilonRealFixesSumOfVectorAndItsImage`・`ClaimEpsilonRealPermutesEntriesBySpinFlip`・`ClaimEpsilonRealPreservesNonnegativeVectors`・`ClaimSumOfNonnegativeVectorAndItsEpsilonRealImageIsNonzero`・`ClaimNormSquaredOfSumOfUnitVectorAndItsEpsilonRealImageIsAtMostFour`・`ClaimEpsilonCommutesWithW`・`ClaimEpsilonRealCommutesWithWRealAndWRealHasPositiveEntries`・`ClaimWRealBilinearValueAtSumOfNonnegativeVectorAndItsEpsilonRealImageIsAtLeastTwice`・`ClaimPhysicalWHasPositiveEntries`・`ClaimPhysicalWHasPositiveEntriesFromNecSuf`）。

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `minus_sector_not_adopted.ts` へ退避した全スピン反転行列の固有値 −1 の側のものである（退避の記録はノートの各ブロックの冒頭にある）。

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.psd_cauchy_schwarz`（`ClaimPsdCauchySchwarz.lean`） | `(yᵀPx)² ≤ (xᵀPx)(yᵀPy)`（`P` 実対称半正定値） | `psd_cauchy_schwarz` |
| `Ising2D.rayleighSet` / `Ising2D.rayleighSup` | `𝓡 = {xᵀW_ℝx : ‖x‖=1}` と `c(M) := sup 𝓡` | `def_rayleigh_sup` |
| `Ising2D.physicalSymTransferR_eq_realMatrixOfRealEntries`（`PhysicalPartitionFunctionSandwich.lean`） | `W_ℝ := ϱ(W)`（`def_real_matrix_of_real_entry_matrix`、`B → W`）を具体的な `W` について: 実成分で組んだ `physicalSymTransferR` は `ϱ(physicalSymTransferC)` に等しい | `def_W_real` |
| `Ising2D.rayleighSup_physicalSymTransferR_eq`（`PhysicalPartitionFunctionSandwich.lean`） | Lean の `c(M)` は人手の `sup{xᵀW_ℝx \| ‖x‖ = 1}` と同じ値 | `def_rayleigh_sup` |
| `Ising2D.rayleighSet_nonempty` / `rayleighSet_bddAbove` | `𝓡` は空でなく上に有界（上界は `Σ_iΣ_j\|W_ij\|`。`W` に仮定を置かない） | 同上 |
| `Ising2D.abs_component_le_one_of_unit`（`DefinitionRayleighSup.lean`） | `‖x‖ = 1` なら `\|x_i\| ≤ 1`（上に有界であることの段の前半。人手の 4 行と `nonnegative_real_order_from_squares`（具体版は `MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimNonnegativeRealOrderFromSquares.lean`）） | `def_rayleigh_sup` |
| `Ising2D.abs_bilinear_term_le_abs_entry` / `abs_bilinear_row_le_row_abs_sum` / `bilinear_le_abs_entry_sum`（`DefinitionRayleighSup.lean`） | `\|x_k\| ≤ 1` なら `\|x_iW_ijx_j\| ≤ \|W_ij\|`、`\|Σ_j x_iW_ijx_j\| ≤ Σ_j\|W_ij\|`、`xᵀWx ≤ Σ_iΣ_j\|W_ij\|`（上に有界であることの段の後半。人手の項ごとの 6 行・各 `i` の 2 行・外側の 4 行と 1 対 1。人手 `def_real_bilinear_value` の行は `dotProduct_mulVec_eq_real_bilinear_value`） | `def_rayleigh_sup` |
| **`Ising2D.real_bilinear_value_of_symmetric_matrix_is_symmetric`**（`ClaimRealBilinearValueOfSymmetricMatrixIsSymmetric.lean`） | 対称な `P` について `uᵀPv = vᵀPu`（人手の 7 行の鎖と 1 対 1 の `calc`。対称性は `Matrix.IsSymm.apply` で成分の等式にする）。必要十分版 `NecSuf.bilinear_value_of_symmetric_matrix_is_symmetric'`（`NecSuf/BilinearValueOfSymmetricMatrixIsSymmetric.lean`。係数は非単位的な可換半環）からの導出は `real_bilinear_value_of_symmetric_matrix_is_symmetric_of_necSuf`（`ClaimRealBilinearValueOfSymmetricMatrixIsSymmetricFromNecSuf.lean`）。`Ising2D.psd_cauchy_schwarz` は対称性の仮定としてこれを引く | **`real_bilinear_value_of_symmetric_matrix_is_symmetric`** |
| **`Ising2D.real_bilinear_value_is_additive_in_right_vector`** / **`Ising2D.real_bilinear_value_is_additive_in_left_vector`**（`ClaimRealBilinearValueIsAdditive.lean`） | `w_l = y_l + z_l` なら `xᵀPw = xᵀPy + xᵀPz`、`w_k = y_k + z_k` なら `wᵀPx = yᵀPx + zᵀPx`（人手の 6 行・7 行の鎖と 1 対 1 の `calc`）。必要十分版 `NecSuf.bilinear_value_is_additive_in_right_vector'`・`NecSuf.bilinear_value_is_additive_in_left_vector'`（`NecSuf/BilinearValueIsAdditive.lean`。係数は非単位的な半環）からの導出は `real_bilinear_value_is_additive_in_right_vector_of_necSuf`・`real_bilinear_value_is_additive_in_left_vector_of_necSuf`（`ClaimRealBilinearValueIsAdditiveFromNecSuf.lean`） | **`real_bilinear_value_is_additive_in_right_vector`** / **`real_bilinear_value_is_additive_in_left_vector`** |
| **`Ising2D.real_bilinear_value_with_nonnegative_entries_is_nonnegative`** / **`Ising2D.real_bilinear_value_of_scalar_multiple_vector`**（`ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultiple.lean`） | `P_kl, x_k, y_l ≥ 0` なら `xᵀPy ≥ 0`（人手の準備の 2 つの不等式・各 `p` の 2 行・本体の 3 行と 1 対 1）、`w_k = c u_k` なら `wᵀPw = (cc)(uᵀPu)`（人手の 13 行の鎖と 1 対 1 の `calc`）。必要十分版 `NecSuf.bilinear_value_with_nonnegative_entries_is_nonnegative'`・`NecSuf.bilinear_value_of_scalar_multiple_vector'`（`NecSuf/BilinearValueNonnegativeAndScalarMultiple.lean`。係数は非単位的な半環）からの導出は `real_bilinear_value_with_nonnegative_entries_is_nonnegative_of_necSuf`・`real_bilinear_value_of_scalar_multiple_vector_of_necSuf`（`ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultipleFromNecSuf.lean`） | **`real_bilinear_value_with_nonnegative_entries_is_nonnegative`** / **`real_bilinear_value_of_scalar_multiple_vector`** |
| **`Ising2D.real_bilinear_value_is_sum_with_real_matrix_vector_product`** / **`Ising2D.real_symmetric_matrix_moves_between_factors_of_sum_of_products`**（`ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean`） | `Σ_kΣ_l (u_kP_kl)v_l = Σ_k u_k(Pv)_k`（左辺は人手 `def_real_bilinear_value` の和。人手の 2〜4 行目と 1 対 1 の `calc`。mathlib の `uᵀPv`（`u ⬝ᵥ P *ᵥ v`）は定義から右辺と `rfl` で一致するので、`c_between_Lambda_half_and_twice_Lambda_half` の Step 2 を Lean で書くときこの段は `rfl` で済む）、対称な `Q` について `Σ_k (Qu)_k v_k = Σ_k u_k(Qv)_k`（人手の 10 行の鎖と 1 対 1 の `calc`）。必要十分版 `NecSuf.bilinear_value_is_sum_with_matrix_vector_product'`（非単位的な半環）・`NecSuf.symmetric_matrix_moves_between_factors_of_sum_of_products'`（非単位的な可換半環）（`NecSuf/BilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean`）からの導出は `real_bilinear_value_is_sum_with_real_matrix_vector_product_of_necSuf`・`real_symmetric_matrix_moves_between_factors_of_sum_of_products_of_necSuf`（`ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactorsFromNecSuf.lean`） | **`real_bilinear_value_is_sum_with_real_matrix_vector_product`** / **`real_symmetric_matrix_moves_between_factors_of_sum_of_products`** |
| `Ising2D.abs_real_bilinear_row_le_row_abs_sum` / **`Ising2D.real_bilinear_value_at_most_value_at_absolute_vector`**（`ClaimRealBilinearValueAtMostValueAtAbsoluteVector.lean`） | 成分が非負の `P` について `u_k := \|x_k\|` なら `xᵀPx ≤ uᵀPu`（準備の各 `k` の三角不等式と、人手の 9 行の鎖と 1 対 1 の `calc`）。必要十分版 `NecSuf.bilinear_value_at_most_value_at_absolute_vector'`（`NecSuf/BilinearValueAtMostValueAtAbsoluteVector.lean`。係数は順序付きの環）からの導出は `real_bilinear_value_at_most_value_at_absolute_vector_of_necSuf`（`ClaimRealBilinearValueAtMostValueAtAbsoluteVectorFromNecSuf.lean`） | **`real_bilinear_value_at_most_value_at_absolute_vector`** |
| **`Ising2D.norm_of_vector_of_absolute_values_equals_norm`**（`ClaimNormOfVectorOfAbsoluteValuesEqualsNorm.lean`） | `u_k := \|x_k\|` について `‖u‖ = ‖x‖`（人手の 4 行の鎖と 1 対 1 の `calc`）。必要十分版は置かない | **`norm_of_vector_of_absolute_values_equals_norm`** |
| `Ising2D.vecNorm_sq_eq_sum_abs_sq` / `Ising2D.vecNorm_pos_of_ne_zero` / **`Ising2D.norm_of_normalized_real_vector_is_one`**（`ClaimNormOfNormalizedRealVectorIsOne.lean`） | `v ≠ 0`、`v̂_k = v_k/‖v‖` なら `‖v̂‖ = 1`（準備の `‖x‖^2 = Σ\|x_k\|^2` の 2 行と `‖v‖ > 0`、人手の 11 行の鎖と 1 対 1 の `calc`。二乗と積の行き来は `square_of_real_number_is_product`。`vecNorm_sq_eq_sum_abs_sq` は `norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four` も使う）。必要十分版は置かない | **`norm_of_normalized_real_vector_is_one`** |
| **`Ising2D.real_matrix_fixed_vector_stays_fixed_after_normalization`**（`ClaimRealMatrixFixedVectorStaysFixedAfterNormalization.lean`） | `v ≠ 0`、`v̂_k = v_k/‖v‖`、すべての `i` で `(Pv)_i = v_i` なら `(Pv̂)_i = v̂_i`（準備の 2 行と人手の 4 行の鎖と 1 対 1 の `calc`。`c_between_Lambda_half_and_twice_Lambda_half` の Step 2 で `P → ε_ℝ` として引く）。必要十分版は置かない | **`real_matrix_fixed_vector_stays_fixed_after_normalization`** |
| **`Ising2D.real_bilinear_value_of_normalized_vector`**（`ClaimRealBilinearValueOfNormalizedVector.lean`） | `v ≠ 0`、`v̂_k = v_k/‖v‖` なら `v̂ᵀPv̂ = (vᵀPv)/‖v‖^2`（準備の 2 行と人手の 4 行の鎖と 1 対 1 の `calc`。同じ Step 2 で `P → W_ℝ` として引く）。必要十分版は置かない | **`real_bilinear_value_of_normalized_vector`** |
| `Ising2D.le_rayleighSup` | 単位ベクトルで `xᵀWx ≤ c(M)` | 同上 |
| `Ising2D.quad_le_rayleighSup_mul` | 任意の `x` で `xᵀWx ≤ c(M)‖x‖²` | 同上 |
| `Ising2D.rayleighSup_nonneg` | `c(M) ≥ 0`（半正定値性だけを使う） | `def_rayleigh_sup` |
| `Ising2D.ne_zero_of_unit_norm` / `vecNorm_single` / `rayleighSup_pos`（`DefinitionRayleighSup.lean`） | `𝓡 ⊆ ℝ_{>0}` の段の「`‖x‖ = 1` なら `x ≠ 0`」（`‖0‖ = √(Σ\|0\|²) = ⋯ = √0 = 0` の 6 行の鎖と 1 対 1 の `calc`。和の `0 + 0 = 0` は mathlib の `Finset.sum_const_zero`）/ `‖e_1‖ = 1`（`\|(e_1)_i\|^2` の 3 行の鎖 2 本と `‖e_1‖ = √(1 + 0 + ⋯ + 0) = √1 = 1` の 4 行の鎖と 1 対 1 の `calc`。`1 + 0 + ⋯ + 0 = 1` は mathlib の `Finset.sum_ite_eq'`）/ `c(M) = sup 𝓡 ≥ e_1ᵀWe_1 > 0` の 3 行の鎖 | `def_rayleigh_sup`、`moment_log_convexity` の【(W_ℝ)^ax は零でない】の `x ≠ 0` |
| `Ising2D.psd_of_pd`（`ClaimOperatorBound.lean`）/ `Ising2D.W_real_is_positive_semidefinite`（`PhysicalPartitionFunctionSandwich.lean`、本文の `W_ℝ` に当てたもの） | 正定値なら半正定値（`u ≠ 0` は正定値性、`u = 0` は人手の 5 行の鎖） | `W_real_is_positive_semidefinite` |
| `Ising2D.vecNorm_mulVec_sq_eq_bilinear` | `‖Wx‖² = (Wx)ᵀWx`（人手の一つ目の鎖 6 行） | `rayleigh_bounds_operator_norm`（一つ目の鎖） |
| `Ising2D.rayleigh_bounds_operator_norm` | `‖Wx‖ ≤ c(M)‖x‖`（人手の二つ目の鎖・場合分け・割り算と平方の 3 行を同じ順に。正定値性 `hpd` を取る） | 同上 |
| `Ising2D.rayleigh_bounds_operator_norm_pow` | `‖W^k x‖ ≤ c(M)^k‖x‖`（人手の `k = 0` の 3 行と帰納法の 5 行。`Ix = x` は `real_identity_matrix_is_left_unit_of_real_matrix_vector_product`、`(W^kW)x = W^k(Wx)` は `real_matrix_vector_product_is_associative` の具体版を引く） | 同上（帰納法の部分） |
| `Ising2D.rayleigh_bounds_operator_normSq` / `rayleigh_bounds_operator_normSq_pow` | `‖Wx‖² ≤ c(M)²‖x‖²` / `‖W^k x‖² ≤ (c(M)²)^k‖x‖²`（必要十分版の特殊化。具体版の証明には使わない） | 同上 |
| `Ising2D.rayleigh_bounds_operator_norm_of_necSuf` / `rayleigh_bounds_operator_norm_pow_of_necSuf` | 上の 2 つの平方根を取った `‖Wx‖ ≤ c(M)‖x‖` / `‖W^k x‖ ≤ c(M)^k‖x‖`（具体版と同じ主張を必要十分版から得たもの） | 同上 |
| `Ising2D.norm_of_standard_basis_vector` / `power_of_W_real_entry_symm` / `diagonal_entry_via_standard_basis` / `power_of_W_real_mulVec_standard_basis_apply` / `norm_power_of_W_real_mulVec_standard_basis_le` / `norm_sq_power_of_W_real_mulVec_standard_basis_le`（`ClaimTracePowerUpperBound.lean`） | `i ≠ k` の `|(e_k)_i|^2 = 0`（3 行）と `‖e_k‖ = 1`（7 行）/ `((W_ℝ)^p)_kl = ((W_ℝ)^p)_lk`（6 行と単射性）/ `e_k^⊤(W_ℝ)^pe_k = ((W_ℝ)^p)_kk`（5 行）/ `u_l = ((W_ℝ)^a)_lk`（3 行）/ `‖u‖ ≤ c^a`（3 行）/ `‖u‖^2 ≤ c^{2a}`（2 行） | `trace_power_upper_bound` の【e_k のノルム】【冪の対称性】【対角成分の表示】【(W_ℝ)^ae_k の成分とノルム】 |
| `Ising2D.power_of_W_real_even_split` / `diagonal_bound_even` / `power_of_W_odd_split` / `power_of_W_real_odd_split` / `diagonal_bound_odd` | `(W_ℝ)^{2a} = (W_ℝ)^a(W_ℝ)^a`（5 行）/ `n = 2a` について `e_k^⊤(W_ℝ)^{2a}e_k ≤ c^n`（9 行）/ `W^{2a+1} = W^a(WW^a)`（7 行）/ `(W_ℝ)^{2a+1} = (W_ℝ)^a(W_ℝ(W_ℝ)^a)`（5 行）/ `n = 2a+1` について `e_k^⊤(W_ℝ)^{2a+1}e_k ≤ c^n`（12 行） | `trace_power_upper_bound` の偶数・奇数の場合 |
| **`Ising2D.trace_power_upper_bound`** / `trace_power_upper_bound_physical`（`PhysicalPartitionFunctionSandwich.lean`） | 一般の `W : TensorPow M`（実対称、`W_ℝ := ϱ(W)` は対称で正定値）について `n ≥ 1` で `Σ_k ((W_ℝ)^n)_kk ≤ 2^M c(M)^n`（最後のトレースの 5 行。`Σ_k c^n = ι(d)c^n` は `finite_sum_of_constant_real_number_fintype`、`ι(2^M) = 2^M` は `inclusion_zz_to_rr_of_power_of_two`）/ 本文の `W` に当てたもの | **`trace_power_upper_bound`** |
| `Ising2D.real_bilinear_value_of_real_identity_matrix` / `real_identity_matrix_is_positive_semidefinite` / `real_identity_matrix_is_positive_definite` / `real_identity_matrix_entry_symm` / `real_identity_matrix_is_symmetric`（`ClaimMomentLogConvexity.lean`） | `y^⊤I_ℝy = Σ_k y_ky_k`（3 行）/ `≥ 0` / `y ≠ 0` なら `> 0` / `(I_ℝ)_kl = (I_ℝ)_lk`（3 行）/ `I_ℝ` は対称 | `moment_log_convexity` の【I_ℝ と W_ℝ の正値性】（【(W_ℝ)^ax は零でない】の `x ≠ 0` は上の `def_rayleigh_sup` の行） |
| `Ising2D.real_identity_matrix_eq_real_matrix_of_identity` / `power_of_W_split_with_identity` / `power_of_W_split_with_W` / `power_of_W_real_split` / `power_of_W_real_split_with_identity` / `power_of_W_real_split_with_W_real` / `real_bilinear_value_between_two_powers` | `I_ℝ = (W_ℝ)^0 = (W^0)_ℝ = ϱ(I)`（3 行）/ `W^{a+b} = W^b(IW^a)`（3 行）/ `W^{a+b+1} = W^b(WW^a)`（7 行）/ `(W_ℝ)^s = (W_ℝ)^b(C_ℝ(W_ℝ)^a)`（5 行）とその `C = I`・`C = W` / `x^⊤((W_ℝ)^b(C_ℝ(W_ℝ)^a))x = (u^{(b)})^⊤C_ℝu^{(a)}`（10 行） | `moment_log_convexity` の【冪の実数の行列】【冪の分け方】【二つの冪で挟んだ値】 |
| `Ising2D.power_zero_of_W_real_mulVec_apply` / `power_succ_of_W_real` / `power_succ_of_W_real_mulVec_apply` / `real_bilinear_value_eq_zero_of_mulVec_eq_zero` / `power_of_W_real_mulVec_ne_zero` | `u^{(0)}_l = x_l`（4 行）/ `(W_ℝ)^{a+1} = W_ℝ(W_ℝ)^a`（7 行）/ `u^{(a+1)}_l = (W_ℝu^{(a)})_l`（8 行）/ `W_ℝu = 0` なら `u^⊤W_ℝu = 0`（5 行）/ `u^{(a)} ≠ 0`（`a` の帰納法） | `moment_log_convexity` の【(W_ℝ)^ax は零でない】 |
| `Ising2D.moment_even_pos` / `moment_odd_pos` / `moment_sq_le_with_W_real` / `moment_sq_le_with_real_identity` | `m_{2a} > 0`・`m_{2a+1} > 0`（5 行ずつ）/ `(m_{a+b+1})^2 ≤ m_{2a+1}m_{2b+1}`・`(m_{a+b})^2 ≤ m_{2a}m_{2b}`（8 行ずつ） | `moment_log_convexity` の【正値性】と【P = W_ℝ の不等式】【P = I_ℝ の不等式】 |
| **`Ising2D.moment_log_convexity`** / `moment_log_convexity_physical`（`PhysicalPartitionFunctionSandwich.lean`）/ `moment_log_convexity_of_necSuf`（`ClaimMomentLogConvexityFromNecSuf.lean`） | 一般の `W : TensorPow M`（実対称、`W_ℝ := ϱ(W)` は対称で正定値）と単位ベクトル `x` について、`m_k := x^⊤(W_ℝ)^kx`（`momentWReal`）は `m_k > 0`、`k ≥ 1` で `m_k^2 ≤ m_{k-1}m_{k+1}`（偶奇の 4 行ずつ）/ 本文の `W` に当てたもの / 同じ型を必要十分版から得たもの（具体版の証明には使わない） | **`moment_log_convexity`** |
| `Ising2D.trace_pow_le` / `Ising2D.trace_power_upper_bound_of_necSuf`（どちらも `ClaimTracePowerUpperBoundFromNecSuf.lean`） | 実数の行列 `W` の `Σ_k (W^n)_kk ≤ (dim) c(M)^n`（各 `k` の評価は必要十分版 `NecSuf.IsPsdPair.moment_le_pow` の特殊化）/ それを具体版 `trace_power_upper_bound` と同じ型に読んだもの（具体版が必要十分版の特殊化として得られることの記録。具体版の証明と通しの証明には使わない） | `trace_power_upper_bound`（必要十分版からの導出） |
| `Ising2D.power_one_of_W_real` / `norm_sq_pos_of_component_ne_zero` / `norm_pos_of_component_ne_zero` / `norm_of_inverse_norm_multiple_is_one` / `power_of_W_real_is_positive_semidefinite`（`ClaimTracePowerSandwichUnitVectorBound.lean`） | `(W_ℝ)^1 = W_ℝ`（6 行）/ `z_{j_0} ≠ 0` なら `‖z‖^2 > 0`（3 行）・`‖z‖ > 0` / `w_i := ‖z‖^{-1}z_i` で `‖w‖ = 1`（14 行）/ `z^⊤(W_ℝ)^nz ≥ 0`（`z = 0` の 2 行、`z ≠ 0` の 5 行） | `trace_power_sandwich` の【冪の実数の行列】の `(W_ℝ)^1 = W_ℝ` と【(W_ℝ)^n の半正定値性】（成分の対称性は `Ising2D.power_of_W_real_entry_symm` をそのまま引く） |
| `Ising2D.standard_basis_real_bilinear_value` / `power_of_W_real_entry_bound` | `Σ_iΣ_j (e_q)_iP_ij(e_r)_j = P_qr` / `2x_k((W_ℝ)^n)_klx_l ≤ x_l^2((W_ℝ)^n)_kk + x_k^2((W_ℝ)^n)_ll`（8 行と移項） | `trace_power_sandwich` の【(W_ℝ)^n の成分の評価】 |
| `Ising2D.sum_sq_of_unit_vector` / `moment_zero_eq_one` / `moment_one_eq` / `moment_ge_moment_one_mul_prev` / `moment_ge_moment_one_pow` / `moment_le_trace_of_power` / `real_bilinear_value_pow_le_trace_of_power` | `Σ_k x_k^2 = 1`（4 行）/ `m_0 = 1`（7 行）/ `m_1 = x^⊤W_ℝx`（2 行）/ `m_k ≥ m_1m_{k-1}`（帰納法）/ `m_p ≥ m_1^p`（帰納法の 4 行）/ `m_n ≤ T`（8 行）/ `(x^⊤W_ℝx)^n ≤ T`（3 行） | `trace_power_sandwich` の【単位ベクトルでの評価】（人手と 1 対 1） |
| `Ising2D.power_comparison_of_positive_reals`（`ClaimTracePowerSandwich.lean`） | `r, s ∈ ℝ_{>0}`、`r < s`、`p ≥ 1` で (a) `0 < r^p < s^p`、(b) `s^p − r^p ≤ ps^{p−1}(s − r)`（`p` の帰納法。一歩は (a) の 4 行、(b) の 5 行） | `trace_power_sandwich` の【正の実数の冪の比較】 |
| `Ising2D.trace_of_power_pos` / `pow_pred_pos_of_pos` / `rayleighSup_pow_le_trace_of_power` | `T ≥ m_n > 0`（`x = e_1`）/ `c^{n−1} > 0` / `c^n ≤ T`（背理法。`δ < c` の 7 行と `T > T` の 6 行） | `trace_power_sandwich` の【上限への移行】（人手と 1 対 1。極限・連続性・`n` 乗根を使わない） |
| **`Ising2D.trace_power_sandwich`** / `trace_power_sandwich_physical`（`PhysicalPartitionFunctionSandwich.lean`） | 一般の `W : TensorPow M`（実対称、`W_ℝ := ϱ(W)` は対称で正定値）について `n ≥ 1` で `c(M)^n ≤ Σ_k ((W_ℝ)^n)_kk ≤ 2^M c(M)^n`（下は【上限への移行】、上は `trace_power_upper_bound`）/ 本文の `W` に当てたもの | **`trace_power_sandwich`** |
| `Ising2D.symTransfer` | `W := B V₂ B`（`B = V₁^{1/2}`） | `def_symmetrized_transfer_matrix` |
| `Ising2D.open_product_pow` | `X, Y ∈ Mat(n, ℂ)` で `(X(YX)^k)Y = (XY)^{k+1}` | `Z_equals_trace_of_W` の準備 2（`k = 0` の 5 行と帰納段階の 6 行） |
| `Ising2D.symmetrized_pow_succ` | `BB = V₁` のもとで `((BV₂)B)^{k+1} = ((B(V₂V₁)^k)V₂)B` | 同 準備 3（`k = 0` の 6 行と帰納段階の 12 行） |
| **`Ising2D.trace_mul_pow_eq_trace_symmetrized_pow`** | 係数が `ℂ` の行列で、`n ≥ 1` なら `tr((V₁V₂)^n) = tr(((BV₂)B)^n)` | **`Z_equals_trace_of_W`** の本体（6 行） |
| `Ising2D.partition_function_eq_trace_physicalSymTransferC`（`PhysicalPartitionFunctionSandwich.lean`） | 具体的な `(Z(K_1,K_2))_ℂ = tr(W^{N_row})`（`W` は `physicalSymTransferC`、`(·)_ℂ` は Lean の `((· : ℝ) : ℂ)`） | 同「とくに」（2 行） |
| `Ising2D.physicalV1halfR` / `physicalV2R` / `physicalSymTransferR`（`PhysicalSymTransferBridge.lean`） | 章 011 の物理的な `V₁^{1/2}`, `V₂`, `W` を実成分で定義 | `def_transfer_matrix_square_root`, `def_symmetrized_transfer_matrix` |
| `Ising2D.physicalV1halfC` / `physicalSymTransferC` | 同じ物理的行列を複素行列として定義（`V₁^{1/2} = exp(½K₁D)` は `V1PauliForm` の `K₁/2` での値、`V₂` は `def_transfer_matrix` の `Ising2D.V2`） | 同上 |
| **`Ising2D.physicalSymTransferC_eq_map`** | 複素側の物理的転送行列は実行列 `W` の成分ごとの複素化に一致 | **`def_symmetrized_transfer_matrix` の章間接続** |
| **`Ising2D.symmetrized_transfer_matrix_on_sectors`** | 実行列 `W` の複素化について `W P^{(+)} = V^{(+)}P^{(+)}`（`V^{(+)}` は章 010 の `VPlusOfTransfer`。`B P = C P` を `V1_restriction_to_eigenspaces`（結合定数 `K_1/2`）と `epsilon_projector_properties` (2) から作る） | **`symmetrized_transfer_matrix_on_sectors`** |
| `Ising2D.symTransfer_isSymm` | 実行列 `B`, `V₂` が対称なら `W = (BV₂)B` も対称（Step 3 の `W^⊤ = W` の 7 行と同じ段を係数 `ℝ` で） | `W_is_real_symmetric_positive_definite` Step 3 |
| `Ising2D.symTransfer_posDef` | `W` は正定値（合同変換） | 同上 |
| `Ising2D.mulVec_eq_zero_iff_of_isUnit` | 可逆行列の `mulVec` は単射（実行列の一般の形 `symTransfer_posDef` の中で使う補助） | 人手に対応する段は無い（人手の可逆性の段の形式化は、この表の可逆性の行にある） |
| `Ising2D.diagExp` ほか（`diagExp_isSymm`, `diagExp_mul_self`, `diagExp_isUnit`, `diagExp_posDef`）（`DefinitionSymmetrizedTransferMatrix.lean`） | 正の対角行列としての `V₁^{1/2}` と `V₁^{1/2}V₁^{1/2} = V₁` | `def_transfer_matrix_square_root`, `W_has_positive_entries` Step 1 |
| `Ising2D.matExp_isSymm` / `Ising2D.matExp_posDef` | 実対称行列の `exp` は実対称正定値 | `exp_hermitian_is_positive_definite` の実行列版（章 009 への接続点） |
| **`Ising2D.symTransfer_entry_pos`** | `W` の成分はすべて正（`V₁^{1/2}` を一般の正の対角行列 `diagonal d`、`V₂` を成分が正の一般の行列として） | **`W_has_positive_entries`** |
| `Ising2D.adjacentSpinProductSum` / `sum_sigmaZ_sigmaZ_apply_of_ne` / `sum_sigmaZ_sigmaZ_apply_configBasisIso_self` | 準備の `d(μ)`、`D = ∑_m σ^z_mσ^z_{m+1}` の `D_{pq} = 0_ℂ`（`p ≠ q`、人手の 4 行のうち 3 段）・`D_{kk} = d(μ)_ℂ`（人手の 7 行のうち 5 段。`σ^z_{m+1} = σ^z_{m^+}`・`μ(m+1) = μ(m^+)` の 2 行は Lean の `nextSite` の読み方） | `W_has_positive_entries` Step 1 |
| `Ising2D.halfK1SmulD` / `squareRootV1DiagonalEntry` / `squareRootV1DiagonalEntry_pos` | 準備の `X := (½K₁)_ℂD`、`b(μ) := exp(½K₁d(μ))`、`b(μ) > 0`（`real_exp_positive`） | `W_has_positive_entries` 準備 |
| `Ising2D.halfK1SmulD_apply_of_ne` / `halfK1SmulD_eq_diagonal` / `physicalV1halfC_eq_matExp_halfK1SmulD` / `physicalV1halfC_apply_of_ne` / `physicalV1halfC_apply_configBasisIso_self` | `X_{pq} = 0_ℂ`（`p ≠ q`、人手の 3 行を 3 段）、`X` は対角行列（`Matrix.diagonal` への読み替え）、`B = exp(X)`、`B_{pq} = (exp X)_{pq} = 0_ℂ`（2 行を 2 段）、`B_{kk} = b(μ)_ℂ`（7 行を 7 段） | `W_has_positive_entries` Step 1 |
| `Ising2D.sameSiteSpinProductSum` / `secondTransferEntry` / `secondTransferEntry_pos` | 準備の `e(μ,μ') := ∑_m μ(m)μ'(m)`、`v(μ,μ') := exp(K₂e(μ,μ'))`、`v(μ,μ') > 0`（`real_exp_positive`） | `W_has_positive_entries` 準備 |
| `Ising2D.V2_apply_configBasisIso_eq_secondTransferEntry` | `(V₂)_{kl} = v(μ,μ')_ℂ`（人手の 3 行のうち 2 段。1 行目の `config_numbering_equals_kronecker_numbering` は Lean の `V2` が添字 `ι(μ)` で定義されている読み方。2 段目の根拠は `Ising2D.V2_apply_configBasisIso`（章 001）） | `W_has_positive_entries` Step 2 |
| `Ising2D.physicalV1halfC_mul_V2_apply_mul_apply_of_ne` / `physicalV1halfC_apply_mul_V2_apply_of_ne` | Step 3 の補助の鎖 2 本: `t ≠ l` で `(BV₂)_{kt}B_{tl} = 0_ℂ`、`s ≠ k` で `B_{ks}(V₂)_{sl} = 0_ℂ`（各 2 行を 2 段。主の鎖の 3 行目・5 行目が引く） | `W_has_positive_entries` Step 3 |
| `Ising2D.physicalSymTransferC_apply_configBasisIso` / `symTransferEntryProduct_pos` | Step 3 の主の鎖 `W_{kl} = ((b(μ)v(μ,μ'))b(μ'))_ℂ`（複素行列のまま人手の 9 行を 9 段。外側の和を先に潰す）、`w := (b(μ)v(μ,μ'))b(μ') = ∏_{j=1}^{3}r_j > 0`（2 行を 2 段。`finite_product_of_positive_reals_is_positive`） | `W_has_positive_entries` Step 3 |
| **`Ising2D.W_has_positive_entries`** / `W_has_positive_entries_physical` / `physicalSymTransferR_pos` | 複素行列 `W` の `ι(μ), ι(μ')` 成分は `w_ℂ`（`w ∈ ℝ_{>0}`）（人手の主張の形。Step 3 の主の鎖と `w > 0` の鎖で閉じる）、実成分で組んだ `W` の成分はすべて正（`ι` の全射性と `ℝ → ℂ` の単射性で主張の形から導く。`W_has_positive_entries_physical` はそれを `ι(μ), ι(μ')` で引いた形） | **`W_has_positive_entries`**（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean`） |
| `Ising2D.physicalV1halfC_mul_self` / `physicalV1halfR_mul_self_map` | `V₁^{1/2}V₁^{1/2} = V₁`（`½K₁D` は自分自身と可換） | `def_transfer_matrix_square_root` |
| `Ising2D.trace_of_W_power_via_W_real` | `tr(W^q) = (Σ_k ((W_ℝ)^q)_kk)_ℂ`（`W^q` の成分の実性と `(W^q)_ℝ = (W_ℝ)^q` は `real_matrix_of_real_entry_matrix_preserves_power`。4 行の鎖と 1 対 1） | `trace_of_W_power_via_W_real` |
| `Ising2D.partition_function_eq_sum_diag_W_real_pow` | 具体的な `Z(K_1,K_2)` は `Σ_k ((W_ℝ)^{N_row})_kk`（係数 `ℂ` の `partition_function_eq_trace_physicalSymTransferC` と `trace_of_W_power_via_W_real` の 2 行の鎖と、`inclusion_rr_to_cc_is_injective` で実数へ戻す段。人手と 1 対 1） | `partition_function_sandwich` の準備（`Z(K_1,K_2) = T`、`T := Σ_k ((W_ℝ)^{N_row})_kk`） |
| `Ising2D.sigmaZ_transpose` / `sigmaZ_nextSite_mul_comm` / `sigmaZ_mul_sigmaZ_nextSite_transpose` | `(σ^z_k)^⊤ = σ^z_k`（5 行）、`σ^z_{m^+}σ^z_m = σ^z_mσ^z_{m^+}`、`(σ^z_mσ^z_{m+1})^⊤ = σ^z_mσ^z_{m+1}`（5 行。周期端を含む） | `W_is_real_symmetric_positive_definite` Step 1 |
| `Ising2D.K1D_transpose_succ` / `sigmaZ_hasRealEntries` / `K1D_hasRealEntries_succ` | `(K₁D)^⊤ = K₁D`（5 行）、`σ^z_k`・`K₁D` の成分は実（2 段落） | 同 Step 1 |
| `Ising2D.halfK1D_hasRealEntries` / `halfK1D_transpose` / `halfK1D_isRealSymmetric` | `½K₁D` の成分は実、`(½K₁D)^⊤ = ½K₁D`（3 行）、`½K₁D` は実対称 | 同 Step 2 |
| `Ising2D.physicalV1halfC_isRealSymmetric` / `physicalV1halfC_transpose` | 具体的な `V₁^{1/2} = exp(½K₁D)` は実対称（`exp_of_real_symmetric_is_real_symmetric`、`A → ½K₁D`） | 同 Step 2 |
| `Ising2D.K1D_hasRealEntries` / `K1D_transpose` / `K1D_isRealSymmetric` / `K1D_isHermitian` / `halfK1D_isHermitian` | `K₁D` は実対称でエルミート、`½K₁D` はエルミート | 同 Step 1・Step 2 |
| `Ising2D.halfK1D_eq_half_smul_K1D` / `physicalV1halfC_eq_matExp_half` / `physicalV1halfInvC` / `expS2C` / `physicalV1halfC_posDef` / `expS2C_posDef` / `physicalV1halfInvC_mul_physicalV1halfC` / `physicalV1halfC_conjTranspose` | `B = exp(½K₁D)`・`A = exp(S₂)` は正定値、`B' = exp(-½K₁D)` は `B'B = I`、`B^* = B` | 同 Step 2・Step 3 |
| `Ising2D.S2C_isRealSymmetric` / `expS2C_isRealSymmetric` | `S_2` は実対称（Step 1）、`A = exp(S_2)` は実対称（Step 2。`exp_of_real_symmetric_is_real_symmetric`、`A → S_2`） | 同 Step 1・Step 2 |
| `Ising2D.V2_eq_twoS2Pow_smul_expS2C` / `V2_transpose` | 具体的な `V₂ = (2s_2)^{M/2}A`、`V₂^⊤ = V₂`（`transpose_of_matrix_scalar_multiple`、`A^⊤ = A` の 4 行） | 同 Step 3 |
| `Ising2D.physicalSymTransferC_transpose` | 具体的な `W^⊤ = W` の 7 行（`transpose_of_matrix_product` を 2 回、`B^⊤ = B`、`V₂^⊤ = V₂`、`mat_mult_associative`） | 同 Step 3 |
| `Ising2D.V2_hasRealEntries` / `physicalSymTransferC_hasRealEntries` / `physicalSymTransferC_isRealSymmetric` | `V₂`・`W` の成分は実（`real_scalar_multiple_of_real_entry_matrix_has_real_entries`、`product_of_real_entry_matrices_has_real_entries` を 2 回）、`W` は実対称 | 同 Step 3 |
| `Ising2D.twoS2Pow` / `twoS2Pow_pos` / `physicalSymTransferC_eq_smul_congruence` / `physicalSymTransferC_posDef` | 具体的な `W = (2s_2)^{M/2}B^*AB`（Step 3 の 4 行の鎖）と、`congruence_preserves_positive_definite`・`positive_real_multiple_preserves_positive_definite` による `W` の正定値性 | `W_is_real_symmetric_positive_definite` Step 3 |
| `Ising2D.physicalV1halfC_mul_physicalV1halfInvC` / `physicalV1halfC_isUnit` / `physicalV1halfC_mul_V2_isUnit` / `physicalSymTransferC_isUnit` | 可逆性: `BB' = I` の 3 行（`matrix_double_negation`、`exp_of_negative_is_left_inverse`）、`B ∈ R^×`、`BV₂ ∈ R^×`・`W = (BV₂)B ∈ R^×`（`V2_invertible`、`def_invertible_elements_of_R` (ii) の `TensorPow M` での系 `invertible_product_isUnit_tensorPow`） | 同 可逆性の段 |
| `Ising2D.W_real_entry_symm` / `W_real_is_symmetric`（`PhysicalPartitionFunctionSandwich.lean`） | `W_ℝ` は対称: 4 行の鎖 `((W_ℝ)_kl)_ℂ = W_kl = (W^⊤)_kl = W_lk = ((W_ℝ)_lk)_ℂ` と `inclusion_rr_to_cc_is_injective` | `W_real_is_symmetric` |
| `Ising2D.conjugate_bilinear_value_of_real_vector_W` / `W_real_is_positive_definite`（同） | `x ≠ 0` なら `xᵀW_ℝx > 0`: `ξ_k := (x_k)_ℂ` について 10 行の鎖 `ρ_ℂ = ξ^*Wξ = … = (xᵀW_ℝx)_ℂ`（`calc` の 9 段と `rw` 1 回）と単射性 | `W_real_is_positive_definite` |
| `Ising2D.physicalSymTransferR_isSymm` / `physicalSymTransferR_posDef` | 上の 2 つを実成分で組んだ `physicalSymTransferR` で読む（`physicalSymTransferR_eq_realMatrixOfRealEntries`） | `W_real_is_symmetric` / `W_real_is_positive_definite` |
| **`Ising2D.partition_function_sandwich_physical`** | 具体的な `Z(K_1,K_2)` と具体的な `W` について `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/PhysicalPartitionFunctionSandwich.lean`） | **`partition_function_sandwich`** |
| `Ising2D.partition_function_sandwich_and_limit_in_N_row`（`ClaimPartitionFunctionSandwichAndLimitInNRow.lean`） | 章「N→∞ の極限と最大固有値 c(M)」の章末の主張: `M ≥ 2`、`K_1, K_2 > 0`（人手どおり。証明は `K_1 > 0` を `partition_function_sandwich_physical` へ渡すだけで、その先でも使わない）で、具体的な `W` について `c(M) > 0`、`N_row ≥ 1` で `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`、`(1/(M N_row)) log Z → (1/M) log c(M)`（既存の主張を並べたもの） | `partition_function_sandwich_and_limit_in_N_row` |
| `Ising2D.evenSectorSet` / `Ising2D.evenSectorRayleighSup` | `𝓡_+ = {xᵀW_ℝx}` と `c_+(M)`（`ThermodynamicLimit/ColumnLimitAndClosedForm/DefinitionSectorRayleighSup.lean`。`W` は実数の行列で、Ising では `W_ℝ` の具体形 `physicalSymTransferR`） | `def_sector_rayleigh_sup` |
| `Ising2D.evenSectorSet_subset` / `evenSectorSet_bddAbove` / `le_evenSectorRayleighSup` | `𝓡_+ ⊆ 𝓡`（同じ式 `xᵀW_ℝx` の値の包含）と上に有界、単位ベクトルで `xᵀW_ℝx ≤ c_+` | 同上 |
| `Ising2D.aPlus` / `pauliX_mulVec_cvec_aPlus` / `evenUnit` / `evenUnit_apply_succ` / `evenUnit_apply` / `cvec_evenUnit` / `epsilon_mulVec_cvec_evenUnit` / `epsilonR_mulVec_evenUnit` / `epsilonR_zero_mulVec_evenUnit` / `vecNorm_sq_evenUnit_succ` / `vecNorm_evenUnit_succ` / `vecNorm_evenUnit` / `evenSectorSet_epsilonR_nonempty` | 単位ベクトル `x^{(+)}`（成分 `Π_k(a_+)_{i_k}`、各成分の値 `(1/√2)^{M_col}` の 3 行の鎖は `evenUnit_apply_succ`（`finite_product_of_constant_real_is_power` を引く）、`ι(x^{(+)}) = b_+⊠⋯⊠b_+`、`ε_ℝx^{(+)} = x^{(+)}`、`‖x^{(+)}‖² = 1` の 14 行の鎖は `vecNorm_sq_evenUnit_succ`（`product_of_real_powers_is_power_of_product`・`power_of_real_one_is_one` を引く））で `𝓡_+ ≠ ∅` | 同上 |
| **`Ising2D.c_plus_le_c`** | `c_+(M) ≤ c(M)`（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimCPlusLeC.lean`） | **`c_plus_le_c`** |
| `Ising2D.epsilonR` / `epsilon_apply` / `epsilon_eq_ofReal_epsilonR` / `epsilon_transpose` / `epsilonR_isSymm` / `epsilonR_mul_self` | `ε` は実行列 `epsilonR` の成分の埋め込み、`ε^⊤ = ε` とその実行列版（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonIsRealSymmetric.lean`） | `epsilon_is_real_symmetric`（`ε² = I` は `epsilon_square_and_eigenvalues`） |
| `Ising2D.epsilon_hasRealEntries` | `ε` の成分はすべて実数（`MatrixHasRealEntries`。`epsilon_eq_siteProd` と `siteProd_hasRealEntries`・`pauliX_hasRealEntries`） | `epsilon_is_real_symmetric` の証明の成分の実性 |
| **`Ising2D.epsilon_is_real_symmetric`** | `MatrixHasRealEntries ε ∧ ε^⊤ = ε`（`M_col = n + 1`） | **`epsilon_is_real_symmetric`** |
| `Ising2D.epsilonReal` / `ofReal_epsilonReal_apply` / **`epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`** / `epsilonR_eq_epsilonReal` / `epsilonR_mulVec_eq_self_iff_cvec_mem_evenEigenvectors` | `ε_ℝ := ϱ(ε)`、`ε_ℝx = x ⟺ ι(x) ∈ 𝓕^{(+)}`、`epsilonR = ε_ℝ` とその形の同値（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors.lean`） | `def_epsilon_real` / **`epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`** |
| `Ising2D.epsilon_real_entry_symm` / **`epsilon_real_is_symmetric`** / **`epsilon_real_square_is_identity`** | `ε_ℝ` は対称（4 行の鎖と単射性）、`ε_ℝε_ℝ = I_{Mat(d,ℝ)}`（5 行の鎖）。人手と 1 対 1 なのはこちらで、下の `epsilonR_isSymm`・`epsilonR_mul_self` は同じ内容を置換行列の必要十分版から出したもの（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealIsSymmetricAndSquareIsIdentity.lean`） | **`epsilon_real_is_symmetric`** / **`epsilon_real_square_is_identity`** |
| **`Ising2D.epsilon_real_fixes_sum_of_vector_and_its_image`** | すべての `k` で `v_k = u_k + (ε_ℝu)_k` なら `ε_ℝv = v`（各成分の 10 行の鎖。`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealFixesSumOfVectorAndItsImage.lean`） | **`epsilon_real_fixes_sum_of_vector_and_its_image`** |
| `Ising2D.negSpinConf` / `pauliX_configBasisIso_apply_of_eq_neg` / `pauliX_configBasisIso_apply_of_ne_neg` / **`epsilon_entries_in_row_configuration_numbering`** / **`epsilon_real_permutes_entries_by_spin_flip`** | `ε_{ord(s),ord(s')}` は `s' = -s` のとき `1_ℂ`、そうでないとき `0_ℂ`（クロネッカー積表示の成分の積）、`(ε_ℝu)_{ord(s)} = u_{ord(-s)}`（和を ℂ へ包含して一つの項を残し単射性で戻す）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealPermutesEntriesBySpinFlip.lean`。`-s` の `negSpinConf` は `EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusMatrixEntries.lean`） | **`def_negated_row_configuration`** / **`epsilon_entries_in_row_configuration_numbering`** / **`epsilon_real_permutes_entries_by_spin_flip`** |
| **`Ising2D.epsilon_real_preserves_nonnegative_vectors`** | すべての `k` で `u_k ≥ 0` なら、すべての `k` で `(ε_ℝu)_k ≥ 0`（`k = ord(s)` と置き `(ε_ℝu)_{ord(s)} = u_{ord(-s)} ≥ 0`）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealPreservesNonnegativeVectors.lean`） | **`epsilon_real_preserves_nonnegative_vectors`** |
| **`Ising2D.sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`** | すべての `k` で `u_k ≥ 0` かつ `u ≠ 0` のとき、すべての `k` で `v_k = u_k + (ε_ℝu)_k` なら `v ≠ 0`（`u_{k_0} ≠ 0` なる `k_0` で `v_{k_0} ≥ u_{k_0} > 0`）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimSumOfNonnegativeVectorAndItsEpsilonRealImageIsNonzero.lean`） | **`sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`** |
| **`Ising2D.norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`** | `‖u‖ = 1` のとき、すべての `k` で `v_k = u_k + (ε_ℝu)_k` なら `‖v‖^2 ≤ 4`（`‖x‖^2 = Σ|x_k|^2`、成分ごとの `|v_k|^2 ≤ 2|u_k|^2 + 2|(ε_ℝu)_k|^2` を和に移し、`‖ε_ℝu‖ = ‖u‖`）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimNormSquaredOfSumOfUnitVectorAndItsEpsilonRealImageIsAtMostFour.lean`） | **`norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`** |
| **`Ising2D.epsilon_real_preserves_norm`** | `‖ε_ℝu‖ = ‖u‖`（`χ(k) := ord(-ord^{-1}(k))`（`spinFlipIndex`）が全単射で `(ε_ℝu)_k = u_{χ(k)}`、二乗和の添字を `χ` で付け替える）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealPreservesNorm.lean`） | **`epsilon_real_preserves_norm`** |
| `Ising2D.flipConf` / `flipConf_involutive` / `epsilonR_mulVec_apply` | `ε` は符号反転 `π` の置換行列（`(εx)_k = x_{π(k)}`） | `trace_of_epsilon_V_plus` の証明 Step 3 の (b)（`c_between_Lambda_half_and_twice_Lambda_half` Step 2 が引く） |
| `Ising2D.epsilon_commute_physicalSymTransferC` / **`epsilon_commutes_with_W`** / `epsilonR_mulVec_physicalSymTransferR_of_mem` | 物理的な `W` について `εW = Wε`（複素行列の等式から実行列へ）と `W` が `𝓕^{(+)}` を保つこと（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonCommutesWithW.lean`） | **`epsilon_commutes_with_W`** |
| **`Ising2D.W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`** | すべての `k` で `u_k ≥ 0` かつ `v_k = u_k + (ε_ℝu)_k` なら `v^⊤W_ℝv ≥ 2(u^⊤W_ℝu)`（双線型値を左右の加法性で展開し、交差項 2 つは非負性で落とし（`W_ℝ` の対称性は使わない）、`(ε_ℝu)^⊤W_ℝ(ε_ℝu) = u^⊤W_ℝu` は `ε_ℝ` を対称な行列として右の因子へ移して `ε_ℝ(W_ℝ(ε_ℝu)) = W_ℝu` を当てる）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimWRealBilinearValueAtSumOfNonnegativeVectorAndItsEpsilonRealImageIsAtLeastTwice.lean`） | **`W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`** |
| `Ising2D.W_has_positive_entries_as_inclusion` / **`W_real_has_positive_entries`** / **`epsilon_real_commutes_with_W_real`** | `W_has_positive_entries` の言い換えの形（すべての `k, l` について `W_kl = w_ℂ`、`w > 0`。主張の形 `W_has_positive_entries` から `ι` の全射性で導く）、`W_ℝ` の成分は正（2 行の鎖と単射性）、`ε_ℝW_ℝ = W_ℝε_ℝ`（3 行の鎖）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealCommutesWithWRealAndWRealHasPositiveEntries.lean`） | **`W_real_has_positive_entries`** / **`epsilon_real_commutes_with_W_real`** |
| `Ising2D.sectorSet` / `sectorRayleighSup` / `sectorSet_one_eq` / `sectorRayleighSup_one_eq` | 符号つきの `𝓡_±`, `c_±(M)`（`s = 1` で本文の `𝓡_+`, `c_+`） | ノート（`sector_decomposition_of_rayleigh_sup`） |
| `Ising2D.sector_invariant` / `sector_orthogonal` / `projPlus` / `projMinus` / `proj_add_eq_one` / `projPlus_mulVec_eigen` / `projMinus_mulVec_eigen` / `sector_quad_le` / `sectorRayleighSup_le`（`ClaimRayleighSupSectorDecomposition.lean`） | `W` は `F^{(±)}` を保つ、直交性、実行列の `P^{(±)}`、セクター内の評価 | ノート（同上） |
| `Ising2D.sector_decomposition_of_rayleigh_sup` | `c(M) = max(c₊(M), c₋(M))` | ノート `sector_decomposition_of_rayleigh_sup` (3) |
| `Ising2D.matBilin` / `dotProduct_mulVec_comm` / `mulVec_dotProduct_selfadjoint` / `single_dotProduct_mulVec_single` / `vecNormSq` 系 / `mulVecLin_pow` / `isPsdPair_of_matrix` / `isPdPair_of_matrix`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/RealMatrixBilinearFormAndNorm.lean`） | 実行列の双線型形式、実ベクトルの二乗ノルム、必要十分版の半正定値・正定値の対への受け渡し | 補助（対応する人手の項目は無い） |

### 1.2 必要十分版（`lean/Ising2D/NecSuf/`）

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.NecSuf.psd_cauchy_schwarz`（`PsdCauchySchwarz.lean`） | 順序体上の加群の対称半正定値双線型形式に対する Cauchy–Schwarz | `psd_cauchy_schwarz` |
| `Ising2D.NecSuf.bilin_quadratic_expand` | `q(t) = B(y+tx, y+tx)` の展開 | 同上の証明の 1 行目 |
| `Ising2D.NecSuf.IsPsdPair` / `IsPdPair` | 「対称半正定値形式 `ip` と、それについて自己共役かつ（半）正定値な作用素 `W`」の組 | `W_is_real_symmetric_positive_definite` の使われ方の抽象化 |
| `NecSuf.IsPsdPair.cs_ip` / `cs_W` | `P = I` 版・`P = W` 版の Cauchy–Schwarz | `psd_cauchy_schwarz` の 2 通りの使い方 |
| `NecSuf.IsPsdPair.rayleigh_bounds_operator_norm` | `⟪Wx,Wx⟫ ≤ c²⟪x,x⟫` | `rayleigh_bounds_operator_norm` |
| `NecSuf.IsPsdPair.rayleigh_bounds_operator_norm_pow` | `⟪W^k x, W^k x⟫ ≤ (c²)^k⟪x,x⟫` | 同上（帰納法） |
| `NecSuf.IsPsdPair.moment_split` | `⟪W^p x, W^q x⟫ = ⟪x, W^{p+q}x⟫` | Step 2 の書き換え |
| `NecSuf.IsPsdPair.moment_nonneg` / `moment_le_pow` | `0 ≤ m_k`、`m_k ≤ c^k⟪x,x⟫` | Step 1 の偶奇の場合分け |
| `NecSuf.IsPsdPair.moment_log_convex` | `m_{k+1}² ≤ m_k m_{k+2}` | `moment_log_convexity` の不等式（人手は `W_ℝ` の冪の `m_k := x^⊤(W_ℝ)^kx` で述べる。添字は `k → k+1`。人手と 1 対 1 の具体版と、具体版と同じ型での導出は上の表の `ClaimMomentLogConvexity.lean`・`ClaimMomentLogConvexityFromNecSuf.lean` の行） |
| `NecSuf.IsPdPair.moment_pos` / `W_ker` / `pow_ne_zero_of_ne_zero`（`RayleighMoments.lean`） | `m_k > 0`、`W` の核は `{0}`（`m_k > 0` を示すための補助） | `moment_log_convexity` の【(W_ℝ)^ax は零でない】と【正値性】（人手も `W_ℝu = 0` なら `u^⊤W_ℝu = 0` で正定値性に反するという `a` の帰納法で、同じ論法） |
| `NecSuf.IsPdPair.moment_ratio_le` / `moment_pow_le` | `m_1m_k ≤ m_{k+1}` と `(xᵀWx)^n ≤ m_n` | `trace_power_sandwich` の【単位ベクトルでの評価】の `m_k ≥ m_1m_{k-1}`・`m_p ≥ m_1^p`（具体版は `Ising2D.moment_ge_moment_one_mul_prev`・`Ising2D.moment_ge_moment_one_pow`。一歩の論法は、具体版が商を経て、必要十分版は掛けてから約す。具体版と同じ型での導出は `Ising2D.moment_ge_moment_one_pow_of_necSuf`、`ClaimTracePowerSandwichUnitVectorBoundFromNecSuf.lean`） |
| `Ising2D.NecSuf.sandwich_mul_proj_eq` | 任意の半群で `BP=CP` と `C,V` の `P` との可換性から `BVB P=CVC P` | `symmetrized_transfer_matrix_on_sectors` |

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `minus_sector_not_adopted.ts` へ退避した全スピン反転行列の固有値 −1 の側のものである（退避の記録はノートの各ブロックの冒頭にある）。

| 人手証明のラベル | 具体版 | 必要十分版 | 具体版は必要十分版の系か |
| --- | --- | --- | --- |
| `psd_cauchy_schwarz` | `Ising2D.psd_cauchy_schwarz` | `Ising2D.NecSuf.psd_cauchy_schwarz` | **はい**（`matBilin P` を代入） |
| `rayleigh_bounds_operator_norm` | `Ising2D.rayleigh_bounds_operator_norm(_pow)`（人手の鎖と 1 対 1） | `NecSuf.IsPsdPair.rayleigh_bounds_operator_norm(_pow)` | **はい**（`Ising2D.rayleigh_bounds_operator_norm(_pow)_of_necSuf`。`isPsdPair_of_matrix` 経由） |
| `trace_power_upper_bound` | `Ising2D.trace_power_upper_bound`（人手の鎖と 1 対 1） | `NecSuf.IsPsdPair.moment_le_pow`（各 `k` の評価。同じ偶奇の手順で、人手の【冪の対称性】と成分の鎖に当たる段は自己共役性から出る `moment_split`） | 各 `k` の評価は**はい**（`trace_power_upper_bound_of_necSuf`）。対角成分の和の段は有限の添字と ℝ の順序に固有なので具体版のみ（`Σ_k c^n = ι(d)c^n`・`ι(2^{M_col}) = 2^{M_col}` の段が引く主張の必要十分版は `NecSuf/NaturalNumberCastIntoSemiring.lean`） |
| `trace_power_sandwich` | `Ising2D.trace_power_sandwich`（人手の鎖と 1 対 1） | 【単位ベクトルでの評価】の `NecSuf.IsPdPair.moment_ratio_le` / `moment_pow_le`（上からの評価は `trace_power_upper_bound` の行） | 【単位ベクトルでの評価】は**はい**（`moment_ge_moment_one_pow_of_necSuf`）。【正の実数の冪の比較】・【上限への移行】・跡の段は ℝ の順序と `sup` に固有なので具体版のみ |
| `symmetrized_transfer_matrix_on_sectors` | `Ising2D.symmetrized_transfer_matrix_on_sectors` | `Ising2D.NecSuf.sandwich_mul_proj_eq` | **はい**（`B,C,V,P` を物理的転送行列の各因子へ特殊化） |
| `Z_equals_trace_of_W` | `Ising2D.trace_mul_pow_eq_trace_symmetrized_pow` | `Ising2D.NecSuf.trace_mul_pow_eq_trace_sandwich_pow`（`NecSuf/OpenProductPowAndCyclicTrace.lean`。モノイドと巡回的な写像） | **はい**（`trace_mul_pow_eq_trace_symmetrized_pow_of_necSuf`、`ClaimZEqualsTraceOfWFromNecSuf.lean`） |
| `W_is_real_symmetric_positive_definite` | `Ising2D.physicalSymTransferC_isRealSymmetric` / `physicalSymTransferC_posDef` / `physicalSymTransferC_isUnit`（具体的な `W`）。`Ising2D.symTransfer_isSymm` / `symTransfer_posDef` は実行列の一般の形 | なし（下記） | — |
| `W_has_positive_entries` | `Ising2D.W_has_positive_entries`（人手の主張の形。人手の Step 1〜3 の鎖と 1 対 1） / `W_has_positive_entries_physical` / `physicalSymTransferR_pos`（実成分で組んだ具体的な `W`。主張の形から導く）。`Ising2D.symTransfer_entry_pos` は一般の対角行列で挟んだ形で、人手の Step 3 の式変形は通らない | `Ising2D.NecSuf.sandwich_outer_term_of_ne` / `sandwich_inner_term_of_ne` / `sandwich_apply_eq_map` / `sandwich_weight_pos` / `sandwich_apply_pos`（`NecSuf/SandwichByDiagonal.lean`。Step 3 の補助の鎖 2 本・主の鎖・`w > 0` の鎖・主張の形を同じ並びで。添字は有限、係数 `R` は加法の可換モノイドと乗法で、`x·0 = 0`・`0·x = 0` を明示の仮定に置く。`B` は `l` 列・`k` 行の非対角成分が `0`、値は積を保つ写像 `φ : S → R` の像。正値性には `S` の「正の元どうしの積は正」だけ） | **はい**（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean`。`R := ℂ`・`S := ℝ`・`φ := ℝ → ℂ の埋め込み`、`B := V₁^{1/2}`・`V := V₂`） |
| `partition_function_sandwich` | `Ising2D.partition_function_sandwich_physical`（具体的な `Z`・`W`） | なし（`Z_equals_trace_of_W`・`trace_of_W_power_via_W_real` と `trace_power_sandwich` をつなぐだけ） | — |
| `def_sector_rayleigh_sup` / `c_plus_le_c` | `Ising2D.evenSectorRayleighSup` / `Ising2D.c_plus_le_c` | なし（`sSup` とその単調性は ℝ の完備性そのもの） | — |
| `epsilon_is_real_symmetric` | `Ising2D.epsilon_is_real_symmetric` | なし（`ε` の具体的な成分の計算。置換行列の一般的な性質は `NecSuf/PermMatrix.lean`） | — |
| `epsilon_commutes_with_W` | `Ising2D.epsilon_commutes_with_W` | なし（結合律だけの鎖。置き換えた構造は章 010 の具体的な反交換関係） | — |
| ノート `sector_decomposition_of_rayleigh_sup` | `Ising2D.sector_decomposition_of_rayleigh_sup` | なし（下記） | — |

### 必要十分版で判明した本質

- **`psd_cauchy_schwarz` に効いているのは 3 つだけ**である:
  係数が**順序体**であること（`t = -(yᵀPx)/(xᵀPx)` を代入する割り算）、形式が**双線型**であること、
  形式が**対称かつ半正定値**であること。
  行列であること・実数であること・有限次元であること・完備性・連続性・平方根は効いていない。

- **`rayleigh_bounds_operator_norm` の `‖Wx‖ ≤ c‖x‖` に平方根は効いていない。**
  必要十分版は `⟪Wx,Wx⟫ ≤ c²⟪x,x⟫` という平方根を取る前の形で、順序体の上で成り立つ。
  平方根は「ノルム」という言い方をするためだけのもので、証明の内容ではない。
  効いているのは Cauchy–Schwarz（上記 3 条件）と、`W` が形式について自己共役かつ半正定値であることだけ。
  有限次元性・行列であること・実数であること・**スペクトル定理**はいずれも効いていない。

- **`trace_power_sandwich` の不等式の中核（【単位ベクトルでの評価】の `m_k ≥ m_1m_{k-1}`・`m_p ≥ m_1^p` と、`moment_log_convexity`）も順序体で閉じている。**
  モーメントの対数凸性 `m_k² ≤ m_{k-1}m_{k+1}` も、比の単調性から出る `(xᵀWx)^n ≤ m_n` も、
  実数性を全く使わない。【(W_ℝ)^n の成分の評価】の `m_n ≤ T` も、半正定値性を `v = x_le_k − x_ke_l` に当てる鎖で、平方根を使わない。
  ℝ が本質的に効くのは `c(M) = sup 𝓡` が存在すること（ℝ の完備性そのもの）だけである。
  【上限への移行】は、その上限が最小の上界であることだけを使い、極限・連続性・`n` 乗根を使わない（【正の実数の冪の比較】と背理法）。
  つまり**この章で「実数への脱出」が必要なのはこの 1 点だけ**であり、行列の対角化可能性も固有値の存在も要らない。

- **`symmetrized_transfer_matrix_on_sectors` の射影子移動は任意の半群で閉じている。**
  `BP=CP` と `C,V` が `P` と可換であることだけを使い、`P` の冪等性も、行列・複素数・
  転送行列であることも使わない。具体版はこの一般定理へ物理的な四因子を特殊化して得られる。

- **`tr((V₁V₂)^n) = tr(W^n)` に効いているのは、積の結合律・単位元・冪の定め方（モノイド）と、跡の巡回性 `τ(ab) = τ(ba)` だけである。**
  必要十分版 `NecSuf/OpenProductPowAndCyclicTrace.lean` は具体版と同じ段の calc を、任意のモノイドと巡回的な写像 `τ` で述べる。
  加法・係数・`τ` の線型性、`B` が平方根・可逆・正定値であることは効かない（`BB = V₁` だけを仮定する）。
  係数が `ℂ` の具体版（人手の主張）と、使う側の係数が `ℝ` の読みは、どちらもこの特殊化として得られる。

- **`W` の対称性・正定値性は、抽象化しても失われる構造がない。**
  正定値性は「合同変換 `B*AB` が正定値性を保つ」ことに尽き、
  Lean 側は `B` が対称かつ**可逆**であることしか使っていない（`B` が `exp` であることは不要）。
  既に最小の仮定で述べてあるため、別ファイルの必要十分版は置いていない。

- **`W_has_positive_entries` の Step 3（`NecSuf/SandwichByDiagonal.lean`）に効いているのは、添字が有限であること、
  係数の `0` が乗法で吸収されること（`x·0 = 0`・`0·x = 0`）、挟む行列 `B` の `l` 列と `k` 行の非対角成分が `0` であること、`B_{kk}`・`B_{ll}`・`V_{kl}` が
  積を保つ写像 `φ` の値であることだけである。**
  乗法の結合律・可換律・単位元、分配律、`B` のほかの非対角成分、添字の等号の判定可能性、`φ` が `0`・和・順序を保つこと、実数であること、指数関数は効いていない。
  正値性の段では、上に加えて `φ` の元の側の「正の元どうしの積が正」（具体版は ℝ の `mul_pos`）だけが効く。
  実数・指数関数の正値性は、`b(μ) > 0`・`v(μ,μ') > 0`（準備）にだけ効く。

- （ノートへ退避したセクター分解について）**セクター分解に効いているのは「対称な対合 `ε`（`ε² = 1`）で `W` と可換なもの」だけ**である。
  `ε` が `σ^x` の積であることも、`W` が転送行列であることも効いていない。
  Lean 側の `Ising2D.sector_decomposition_of_rayleigh_sup` はすでにその一般性で述べてあるので、
  別途の必要十分版は置いていない。

## 3. 他章に仮定として置いた事実

章 009 / 010 などの結果は、一般の実行列について述べた次の定理では **import せず仮定として受け取っている**。
（`PartitionFunction/ProjectionAndJordanWigner/DefinitionSymmetrizedTransferMatrix.lean` の冒頭コメントにも明記した。）
具体的な `Z`・`W` についての通しの証明（`partition_function_sandwich_physical` ほか）は、これらを仮定に取らず証明して使う。
`(Z(K_1,K_2))_ℂ = tr((V₁V₂)^{N_row})`（章 001 の `partition_function_via_transfer_matrix`）を仮定に取る定理はもう無い。`partition_function_sandwich_physical` が人手の準備 `Z(K_1,K_2) = Σ_k ((W_ℝ)^{N_row})_kk`（`partition_function_eq_sum_diag_W_real_pow`）を証明して使う。

| 仮定 | 対応する人手証明 | Lean での受け取り方 |
| --- | --- | --- |
| `V₁^{1/2}` が正の対角行列 | `sigma_z_diagonal_action` + `exp_of_diagonal_matrix`（章 009） | `Ising2D.diagExp d`（`d : n → ℝ`）として与える。`d μ = (1/2)K₁∑_m μ(m)μ(m+1)` に対応 |
| `V₂` の成分がすべて正 | `def_transfer_matrix`（章 001。成分は `Ising2D.physicalV2C_eq_map` で実行列と一致） | `symTransfer_entry_pos` の引数 `hV2`。具体的な `V₂` については `secondTransferEntry_pos` と `V2_apply_configBasisIso_eq_secondTransferEntry`（`(V₂)_{kl} = v(μ,μ')_ℂ`、`v(μ,μ') > 0`）で証明済み |
| `V₂` が実対称正定値 | `iH_is_real_symmetric` + `exp_hermitian_is_positive_definite`（章 009） | `symTransfer_posDef` の引数。具体的な `W` については `partition_function_sandwich_physical` が、人手どおり `W_ℝ` の正定値性 `W_real_is_positive_definite` から `trace_power_sandwich` を引く |
| `ε` が実対称・`ε² = 1`・`εW = Wε`（一般の `W` について） | `epsilon_is_real_symmetric`・`epsilon_square_and_eigenvalues`・`epsilon_commutes_with_W` | 物理的な `W`（`physicalSymTransferR`）と `ε`（`epsilonR`）については `epsilon_commutes_with_W` / `epsilonR_isSymm` / `epsilonR_mul_self` で証明済み。一般の `W` について述べる定理（章 018 の `EvenSectorBridge` など）は `εW = Wε` を引数で受け取る |

## 4. 形式化できなかった主張とその理由

| 人手証明 | 状況 | 理由 |
| --- | --- | --- |
| `maxeig_000_remark_overview` | 形式化対象外 | 章の目的を述べた注記であり数学的主張ではない |

（数学的主張を持つブロックはすべて形式化済み。`sorry` / `admit` はゼロ。）

## 5. 人手証明に見つけた問題

`structured-latex/` は編集していない。見つけた点は次に記録した。

1. `docs/tasks/2026-07_lean-ch009-013/001_ch011-moment-log-convexity-index-error.md`
   — `trace_power_sandwich` Step 2 で、モーメント対数凸性を導くための `(a, b)` の指定が誤っている
   （結論は正しい）。正しい添字を表で示した。
2. `docs/tasks/2026-07_lean-ch009-013/002_ch011-sector-sup-nonempty-gap.md`
   — `sector_decomposition_of_rayleigh_sup` (3) で `c_±(M)` の `sup` が定義できること
   （`F^{(±)}` に単位ベクトルが存在すること）の根拠が本文に無い。
   （現在の本文の `def_sector_rayleigh_sup` は `x^{(+)}` を構成して `𝓡_+ ≠ ∅` を示している。）

## 5.1 人手証明と 1 対 1 にならない箇所（2026-09-26 に追加した主張）

- `def_sector_rayleigh_sup`: `ε x^{(+)} = x^{(+)}` の示し方（人手はクロネッカー積の積の規則、Lean は置換行列の成分表示と
  成分が定数であること）。`x^{(+)}` は人手が確かめた「各成分が `2^{-M/2}`」の形で直接定義した。
- `epsilon_commutes_with_W`: 人手は複素行列として `εW = Wε` を示す。Lean は複素行列の等式を示したあと、
  成分の埋め込みの単射性で実行列の等式へ移す一段を足している。

## 6. 検証結果

```
cd exact-solution-of-2d-ising-model/lean
lake build                 # exit 0
./scripts/check-no-sorry.sh # exit 0（新規定理 91 本を targets に追加済み）
```
