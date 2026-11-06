# 章 011「転送行列の最大固有値と分配関数の挟み撃ち」の Lean 形式化

正本: `structured-latex/content/011_max_eigenvalue.ts`。ただし `def_transfer_matrix_square_root`・`def_symmetrized_transfer_matrix`・
`symmetrized_transfer_matrix_on_sectors` の正本は `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`（2026-10-31 の章立ての組み直しで移した）。
`Z_equals_trace_of_W`・`W_is_real_symmetric_positive_definite`・`def_rayleigh_sup`・`rayleigh_bounds_operator_norm`・`trace_power_upper_bound`・
`moment_log_convexity`・`trace_power_sandwich`・`partition_function_sandwich` の正本は `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`（同じく移した）。
`W_has_positive_entries`・`def_sector_rayleigh_sup`・`c_plus_le_c`・`epsilon_commutes_with_W`・`epsilon_is_real_symmetric` の正本は
`structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`（同じく移した）。011 に残るのは `psd_cauchy_schwarz` だけである。

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
章「N→∞ の極限と最大固有値 c(M)」に当たる `c(M)` の定義・`‖Wx‖ ≤ c(M)‖x‖`・`xᵀAx ≤ ‖x‖² tr A`・`trace_power_sandwich`・分配関数の挟み撃ち（一般の行列の版と具体的な `Z`・`W` の版）のファイルは
`lean/Ising2D/ThermodynamicLimit/RowLimitAndMaxEigenvalue/` にある（`DefinitionRayleighSup`・`ClaimOperatorBound`・`TraceBound`・`ClaimTracePowerSandwich`・`ClaimPartitionFunctionSandwich`・`PhysicalPartitionFunctionSandwich`）。
章「M→∞ の極限と閉形式」に当たる `c_+(M)` の定義・`c_+ ≤ c`・`ε^⊤ = ε`・`εW = Wε`・具体的な `W` の成分の正値性のファイルは
`lean/Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/` にある（`DefinitionSectorRayleighSup`・`ClaimCPlusLeC`・`ClaimEpsilonIsRealSymmetric`・`ClaimEpsilonCommutesWithW`・`ClaimPhysicalWHasPositiveEntries`・`ClaimPhysicalWHasPositiveEntriesFromNecSuf`）。

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `minus_sector_not_adopted.ts` へ退避した全スピン反転行列の固有値 −1 の側のものである（退避の記録はノートの各ブロックの冒頭にある）。

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.psd_cauchy_schwarz`（`ClaimPsdCauchySchwarz.lean`） | `(yᵀPx)² ≤ (xᵀPx)(yᵀPy)`（`P` 実対称半正定値） | `psd_cauchy_schwarz` |
| `Ising2D.rayleighSet` / `Ising2D.rayleighSup` | `𝓡 = {xᵀWx : ‖x‖=1}` と `c(M) := sup 𝓡` | `def_rayleigh_sup` |
| `Ising2D.physicalSymTransferR_eq_realMatrixOfRealEntries`（`PhysicalPartitionFunctionSandwich.lean`） | `W_ℝ := ϱ(W)`（`def_real_matrix_of_real_entry_matrix`、`B → W`）を具体的な `W` について: 実成分で組んだ `physicalSymTransferR` は `ϱ(physicalSymTransferC)` に等しい | `def_W_real` |
| `Ising2D.rayleighSup_physicalSymTransferR_eq`（`PhysicalPartitionFunctionSandwich.lean`） | Lean の `c(M)` は人手の `sup{xᵀW_ℝx \| ‖x‖ = 1}` と同じ値 | `def_rayleigh_sup` |
| `Ising2D.rayleighSet_nonempty` / `rayleighSet_bddAbove` | `𝓡` は空でなく上に有界（上界は `Σ_iΣ_j\|W_ij\|`。`W` に仮定を置かない） | 同上 |
| `Ising2D.abs_component_le_one_of_unit`（`DefinitionRayleighSup.lean`） | `‖x‖ = 1` なら `\|x_i\| ≤ 1`（上に有界であることの段の前半。人手の 4 行と `nonnegative_real_order_from_squares`（具体版は `MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimNonnegativeRealOrderFromSquares.lean`）） | `def_rayleigh_sup` |
| `Ising2D.abs_bilinear_term_le_abs_entry` / `abs_bilinear_row_le_row_abs_sum` / `bilinear_le_abs_entry_sum`（`DefinitionRayleighSup.lean`） | `\|x_k\| ≤ 1` なら `\|x_iW_ijx_j\| ≤ \|W_ij\|`、`\|Σ_j x_iW_ijx_j\| ≤ Σ_j\|W_ij\|`、`xᵀWx ≤ Σ_iΣ_j\|W_ij\|`（上に有界であることの段の後半。人手の項ごとの 6 行・各 `i` の 2 行・外側の 4 行と 1 対 1。人手 `def_real_bilinear_value` の行は `dotProduct_mulVec_eq_real_bilinear_value`） | `def_rayleigh_sup` |
| `Ising2D.le_rayleighSup` | 単位ベクトルで `xᵀWx ≤ c(M)` | 同上 |
| `Ising2D.quad_le_rayleighSup_mul` | 任意の `x` で `xᵀWx ≤ c(M)‖x‖²` | 同上 |
| `Ising2D.rayleighSup_nonneg` | `c(M) ≥ 0`（半正定値性だけを使う） | `def_rayleigh_sup` |
| `Ising2D.ne_zero_of_vecNormSq_eq_one` / `rayleighSup_pos`（`DefinitionRayleighSup.lean`） | `𝓡 ⊆ ℝ_{>0}` の段の「`‖x‖ = 1` なら `x ≠ 0`」（`‖0‖² = Σ0² = Σ0 = 0` の鎖。Lean の `𝓡` は `‖x‖² = 1` で述べるので、人手の `√·`・`\|0\|` の行は現れない）/ `c(M) = sup 𝓡 ≥ e_1ᵀWe_1 > 0` の 3 行の鎖（`‖e_1‖² = 1` は既存の `vecNormSq_single` で受け、人手の `|(e_1)_i|^2` の鎖 2 本と `‖e_1‖ = 1` の 4 行の鎖とは 1 対 1 でない。和の `0 + 0 = 0` は mathlib の `Finset.sum_const_zero`） | `def_rayleigh_sup` |
| `Ising2D.psd_of_pd`（`ClaimOperatorBound.lean`）/ `Ising2D.W_real_is_positive_semidefinite`（`PhysicalPartitionFunctionSandwich.lean`、本文の `W_ℝ` に当てたもの） | 正定値なら半正定値（`u ≠ 0` は正定値性、`u = 0` は人手の 5 行の鎖） | `W_real_is_positive_semidefinite` |
| `Ising2D.vecNorm_mulVec_sq_eq_bilinear` | `‖Wx‖² = (Wx)ᵀWx`（人手の一つ目の鎖 6 行） | `rayleigh_bounds_operator_norm`（一つ目の鎖） |
| `Ising2D.rayleigh_bounds_operator_norm` | `‖Wx‖ ≤ c(M)‖x‖`（人手の二つ目の鎖・場合分け・割り算と平方の 3 行を同じ順に。正定値性 `hpd` を取る） | 同上 |
| `Ising2D.rayleigh_bounds_operator_norm_pow` | `‖W^k x‖ ≤ c(M)^k‖x‖`（人手の `k = 0` の 3 行と帰納法の 5 行） | 同上（帰納法の部分） |
| `Ising2D.rayleigh_bounds_operator_normSq` / `rayleigh_bounds_operator_normSq_pow` | `‖Wx‖² ≤ c(M)²‖x‖²` / `‖W^k x‖² ≤ (c(M)²)^k‖x‖²`（必要十分版の特殊化。具体版の証明には使わない） | 同上 |
| `Ising2D.rayleigh_bounds_operator_norm_of_necSuf` / `rayleigh_bounds_operator_norm_pow_of_necSuf` | 上の 2 つの平方根を取った `‖Wx‖ ≤ c(M)‖x‖` / `‖W^k x‖ ≤ c(M)^k‖x‖`（具体版と同じ主張を必要十分版から得たもの） | 同上 |
| `Ising2D.psd_quad_le_normSq_mul_trace`（`TraceBound.lean`） | `xᵀAx ≤ ‖x‖² tr A`（`A` 半正定値） | `trace_power_sandwich` Step 3 の補題 |
| `Ising2D.psd_abs_entry_le` | `\|A_ij\| ≤ √(A_ii)√(A_jj)` | 同上 |
| `Ising2D.trace_pow_le`（`ClaimTracePowerSandwich.lean`） | 実数の行列 `W` の `Σ_k (W^n)_kk ≤ (dim) c(M)^n`（人手の `Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col} c^n` は `W := W_ℝ`・`card = 2^{M_col}`・`N ≥ 1` と置いた特殊化。証明は必要十分版 `NecSuf.IsPsdPair.moment_le_pow` の特殊化で、人手の偶数・奇数の場合分けの鎖と 1 対 1 でない） | `trace_power_upper_bound` |
| `Ising2D.quad_pow_le_trace_pow` | 単位 `x` で `(xᵀWx)^n ≤ tr(W^n)` | `trace_power_sandwich` の【単位ベクトルでの評価】（証明は必要十分版の特殊化で、人手の成分の評価を足し合わせる鎖と 1 対 1 でない） |
| `Ising2D.rayleighSup_pow_le_trace_pow` | `c(M)^n ≤ tr(W^n)` | `trace_power_sandwich` の【上限への移行】（人手は冪の比較と背理法、Lean は `n` 乗根で、1 対 1 でない） |
| **`Ising2D.trace_power_sandwich`** | 実数の行列 `W` の `c(M)^n ≤ Σ_k (W^n)_kk ≤ (dim) c(M)^n`（人手の `c^n ≤ Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col}c^n` は `W := W_ℝ`・`card = 2^{M_col}` の特殊化） | **`trace_power_sandwich`** |
| `Ising2D.symTransfer` | `W := B V₂ B`（`B = V₁^{1/2}`） | `def_symmetrized_transfer_matrix` |
| `Ising2D.open_product_pow` | `X, Y ∈ Mat(n, ℂ)` で `(X(YX)^k)Y = (XY)^{k+1}` | `Z_equals_trace_of_W` の準備 2（`k = 0` の 5 行と帰納段階の 6 行） |
| `Ising2D.symmetrized_pow_succ` | `BB = V₁` のもとで `((BV₂)B)^{k+1} = ((B(V₂V₁)^k)V₂)B` | 同 準備 3（`k = 0` の 6 行と帰納段階の 12 行） |
| **`Ising2D.trace_mul_pow_eq_trace_symmetrized_pow`** | 係数が `ℂ` の行列で、`n ≥ 1` なら `tr((V₁V₂)^n) = tr(((BV₂)B)^n)` | **`Z_equals_trace_of_W`** の本体（6 行） |
| `Ising2D.partition_function_eq_trace_physicalSymTransferC`（`PhysicalPartitionFunctionSandwich.lean`） | 具体的な `(Z(K_1,K_2))_ℂ = tr(W^{N_row})`（`W` は `physicalSymTransferC`、`(·)_ℂ` は Lean の `((· : ℝ) : ℂ)`） | 同「とくに」（2 行） |
| `Ising2D.trace_mul_pow_eq_trace_symTransfer_pow` / `partition_function_eq_trace_symTransfer_pow`（`ClaimZEqualsTraceOfWFromNecSuf.lean`） | 係数が `ℝ` の行列での同じ等式（必要十分版の特殊化）と、`Z = tr((V₁V₂)^N)` を仮定に取る「とくに」 | `partition_function_sandwich` が使う読み |
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
| `Ising2D.physicalV1halfC_apply_configBasisIso` / `physicalV1halfR_apply_configBasisIso` / `physicalV1halfR_offDiag` / `physicalV1halfR_apply_configBasisIso_self_pos` | 具体的な `V₁^{1/2} = exp(½K₁D)` の成分は `μ = μ'` で `exp(½K₁∑_m μ(m)μ(m+1)) > 0`、それ以外で `0` | `W_has_positive_entries` Step 1 |
| `Ising2D.V2_apply_configBasisIso`（章 001） / `physicalV2R_apply_configBasisIso` / `physicalV2R_apply_configBasisIso_pos` | 具体的な `V₂` の成分は `exp(K₂∑_m μ(m)μ'(m)) > 0` | `W_has_positive_entries` Step 2 |
| `Ising2D.physicalSymTransferR_apply_configBasisIso` | 具体的な `W` の成分は `(V₁^{1/2})_{ι(μ),ι(μ)}(V₂)_{ι(μ),ι(μ')}(V₁^{1/2})_{ι(μ'),ι(μ')}`（人手の式変形の各行） | `W_has_positive_entries` Step 3 |
| **`Ising2D.W_has_positive_entries_physical`** / `physicalSymTransferR_pos` | 具体的な `W` の成分はすべて正（後者は `ι` の全射性で任意の行・列番号へ広げた形） | **`W_has_positive_entries`**（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean`） |
| **`Ising2D.partition_function_sandwich`**（`ClaimPartitionFunctionSandwich.lean`） | `c(M)^{N_row} ≤ Z ≤ (dim) c(M)^{N_row}` | **`partition_function_sandwich`** |
| `Ising2D.physicalV1halfC_mul_self` / `physicalV1halfR_mul_self_map` | `V₁^{1/2}V₁^{1/2} = V₁`（`½K₁D` は自分自身と可換） | `def_transfer_matrix_square_root` |
| `Ising2D.trace_of_W_power_via_W_real` | `tr(W^q) = (Σ_k ((W_ℝ)^q)_kk)_ℂ`（`W^q` の成分の実性と `(W^q)_ℝ = (W_ℝ)^q` は `real_matrix_of_real_entry_matrix_preserves_power`。4 行の鎖と 1 対 1） | `trace_of_W_power_via_W_real` |
| `Ising2D.partitionFunction_eq_trace_physicalSymTransferR_pow` | 具体的な `Z(K_1,K_2)` は実行列 `(W_ℝ)^{N_row}` のトレース（係数 `ℂ` の `partition_function_eq_trace_physicalSymTransferC` と `trace_of_W_power_via_W_real` をつなぎ、`inclusion_rr_to_cc_is_injective` で実数へ戻す） | `partition_function_sandwich` の準備（`Z(K_1,K_2) = T`、`T := Σ_k ((W_ℝ)^{N_row})_kk`） |
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
| `Ising2D.partition_function_sandwich_and_limit_in_N_row`（`ClaimPartitionFunctionSandwichAndLimitInNRow.lean`） | 章「N→∞ の極限と最大固有値 c(M)」の章末の主張: `M ≥ 2`、`K_2 > 0`（`K_1` は任意の実数）で、具体的な `W` について `c(M) > 0`、`N_row ≥ 1` で `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`、`(1/(M N_row)) log Z → (1/M) log c(M)`（既存の主張を並べたもの） | `partition_function_sandwich_and_limit_in_N_row` |
| `Ising2D.evenSectorSet` / `Ising2D.evenSectorRayleighSup` | `𝓡_+` と `c_+(M)`（`ThermodynamicLimit/ColumnLimitAndClosedForm/DefinitionSectorRayleighSup.lean`） | `def_sector_rayleigh_sup` |
| `Ising2D.evenSectorSet_subset` / `evenSectorSet_bddAbove` / `le_evenSectorRayleighSup` | `𝓡_+ ⊆ 𝓡` と上に有界、単位ベクトルで `xᵀWx ≤ c_+` | 同上 |
| `Ising2D.evenUnit` / `epsilonR_mulVec_evenUnit` / `vecNormSq_evenUnit` / `evenSectorSet_epsilonR_nonempty` | 単位ベクトル `x^{(+)}`（各成分 `2^{-M/2}`）で `𝓡_+ ≠ ∅` | 同上 |
| **`Ising2D.c_plus_le_c`** | `c_+(M) ≤ c(M)`（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimCPlusLeC.lean`） | **`c_plus_le_c`** |
| `Ising2D.epsilonR` / `epsilon_apply` / `epsilon_eq_ofReal_epsilonR` / `epsilon_transpose` / `epsilonR_isSymm` / `epsilonR_mul_self` | `ε` は実行列 `epsilonR` の成分の埋め込み、`ε^⊤ = ε` とその実行列版（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonIsRealSymmetric.lean`） | `epsilon_is_real_symmetric`（`ε² = I` は `epsilon_square_and_eigenvalues`） |
| `Ising2D.epsilon_hasRealEntries` | `ε` の成分はすべて実数（`MatrixHasRealEntries`。`epsilon_eq_siteProd` と `siteProd_hasRealEntries`・`pauliX_hasRealEntries`） | `epsilon_is_real_symmetric` の証明の成分の実性 |
| **`Ising2D.epsilon_is_real_symmetric`** | `MatrixHasRealEntries ε ∧ ε^⊤ = ε`（`M_col = n + 1`） | **`epsilon_is_real_symmetric`** |
| `Ising2D.flipConf` / `flipConf_involutive` / `epsilonR_mulVec_apply` | `ε` は符号反転 `π` の置換行列（`(εx)_k = x_{π(k)}`） | `trace_of_epsilon_V_plus` の証明 Step 3 の (b)（`c_between_Lambda_half_and_twice_Lambda_half` Step 2 が引く） |
| `Ising2D.epsilon_commute_physicalSymTransferC` / **`epsilon_commutes_with_W`** / `epsilonR_mulVec_physicalSymTransferR_of_mem` | 物理的な `W` について `εW = Wε`（複素行列の等式から実行列へ）と `W` が `𝓕^{(+)}` を保つこと（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonCommutesWithW.lean`） | **`epsilon_commutes_with_W`** |
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
| `NecSuf.IsPsdPair.moment_log_convex` | `m_{k+1}² ≤ m_k m_{k+2}` | `moment_log_convexity` の不等式（人手は `W_ℝ` の冪の `m_k := x^⊤(W_ℝ)^kx` で述べる。添字は `k → k+1`。人手と 1 対 1 の具体版は無い） |
| `NecSuf.IsPdPair.moment_pos` / `W_ker` / `pow_ne_zero_of_ne_zero`（`RayleighMoments.lean`） | `m_k > 0`、`W` の核は `{0}`（`m_k > 0` を示すための補助） | `moment_log_convexity` の【(W_ℝ)^ax は零でない】と【正値性】（人手も `W_ℝu = 0` なら `u^⊤W_ℝu = 0` で正定値性に反するという `a` の帰納法で、同じ論法） |
| `NecSuf.IsPdPair.moment_ratio_le` / `moment_pow_le` | 比の単調性と `(xᵀWx)^n ≤ m_n` | Step 3 前半 |
| `Ising2D.NecSuf.sandwich_mul_proj_eq` | 任意の半群で `BP=CP` と `C,V` の `P` との可換性から `BVB P=CVC P` | `symmetrized_transfer_matrix_on_sectors` |

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `minus_sector_not_adopted.ts` へ退避した全スピン反転行列の固有値 −1 の側のものである（退避の記録はノートの各ブロックの冒頭にある）。

| 人手証明のラベル | 具体版 | 必要十分版 | 具体版は必要十分版の系か |
| --- | --- | --- | --- |
| `psd_cauchy_schwarz` | `Ising2D.psd_cauchy_schwarz` | `Ising2D.NecSuf.psd_cauchy_schwarz` | **はい**（`matBilin P` を代入） |
| `rayleigh_bounds_operator_norm` | `Ising2D.rayleigh_bounds_operator_norm(_pow)`（人手の鎖と 1 対 1） | `NecSuf.IsPsdPair.rayleigh_bounds_operator_norm(_pow)` | **はい**（`Ising2D.rayleigh_bounds_operator_norm(_pow)_of_necSuf`。`isPsdPair_of_matrix` 経由） |
| `trace_power_sandwich` | `Ising2D.trace_power_sandwich` | `NecSuf.IsPsdPair.moment_le_pow` / `moment_log_convex` / `NecSuf.IsPdPair.moment_pow_le` | 不等式の中核部分は**はい**。跡と `sup` の部分は ℝ 固有なので具体版のみ |
| `symmetrized_transfer_matrix_on_sectors` | `Ising2D.symmetrized_transfer_matrix_on_sectors` | `Ising2D.NecSuf.sandwich_mul_proj_eq` | **はい**（`B,C,V,P` を物理的転送行列の各因子へ特殊化） |
| `Z_equals_trace_of_W` | `Ising2D.trace_mul_pow_eq_trace_symmetrized_pow` | `Ising2D.NecSuf.trace_mul_pow_eq_trace_sandwich_pow`（`NecSuf/OpenProductPowAndCyclicTrace.lean`。モノイドと巡回的な写像） | **はい**（`trace_mul_pow_eq_trace_symmetrized_pow_of_necSuf`。使う側の実行列の読み `trace_mul_pow_eq_trace_symTransfer_pow` も同じ特殊化） |
| `W_is_real_symmetric_positive_definite` | `Ising2D.physicalSymTransferC_isRealSymmetric` / `physicalSymTransferC_posDef` / `physicalSymTransferC_isUnit`（具体的な `W`）。`Ising2D.symTransfer_isSymm` / `symTransfer_posDef` は実行列の一般の形 | なし（下記） | — |
| `W_has_positive_entries` | `Ising2D.W_has_positive_entries_physical` / `physicalSymTransferR_apply_configBasisIso`（具体的な `W`）。`Ising2D.symTransfer_entry_pos` は一般の対角行列で挟んだ形で、人手の Step 3 の式変形は通らない | `Ising2D.NecSuf.sandwich_apply_pos` / `NecSuf.sandwich_apply_of_offDiag_zero`（`NecSuf/SandwichByDiagonal.lean`。添字は有限、係数は結合律・可換律を仮定しない半環。正値性には前順序と `PosMulStrictMono` だけ） | **はい**（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean`） |
| `partition_function_sandwich` | `Ising2D.partition_function_sandwich` | なし（`trace_power_sandwich` の言い換え） | — |
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

- **`trace_power_sandwich` の不等式の中核（Step 1〜Step 3 前半）も順序体で閉じている。**
  モーメントの対数凸性 `m_k² ≤ m_{k-1}m_{k+1}` も、比の単調性から出る `(xᵀWx)^n ≤ m_n` も、
  実数性を全く使わない。ℝ が本質的に効くのは次の 2 箇所だけである。
  1. `c(M) = sup 𝓡` が存在すること（ℝ の完備性そのもの）。
  2. `m_n ≤ tr(W^n)` の証明（`|A_kl| ≤ √(A_kk A_ll)` で平方根を使う）。
  つまり**この章で「実数への脱出」が必要なのはこの 2 点だけ**であり、
  行列の対角化可能性も固有値の存在も要らない。

- **`symmetrized_transfer_matrix_on_sectors` の射影子移動は任意の半群で閉じている。**
  `BP=CP` と `C,V` が `P` と可換であることだけを使い、`P` の冪等性も、行列・複素数・
  転送行列であることも使わない。具体版はこの一般定理へ物理的な四因子を特殊化して得られる。

- **`Z = tr(W^n)` に効いているのは、積の結合律・単位元・冪の定め方（モノイド）と、跡の巡回性 `τ(ab) = τ(ba)` だけである。**
  必要十分版 `NecSuf/OpenProductPowAndCyclicTrace.lean` は具体版と同じ段の calc を、任意のモノイドと巡回的な写像 `τ` で述べる。
  加法・係数・`τ` の線型性、`B` が平方根・可逆・正定値であることは効かない（`BB = V₁` だけを仮定する）。
  係数が `ℂ` の具体版（人手の主張）と、使う側の係数が `ℝ` の読みは、どちらもこの特殊化として得られる。

- **`W` の対称性・正定値性は、抽象化しても失われる構造がない。**
  正定値性は「合同変換 `B*AB` が正定値性を保つ」ことに尽き、
  Lean 側は `B` が対称かつ**可逆**であることしか使っていない（`B` が `exp` であることは不要）。
  既に最小の仮定で述べてあるため、別ファイルの必要十分版は置いていない。

- **`W_has_positive_entries` の Step 3（`NecSuf/SandwichByDiagonal.lean`）に効いているのは、添字が有限であること、
  係数の `0` が乗法で吸収されること、挟む行列 `B` の非対角成分が `0` であることだけである。**
  乗法の結合律・可換律・単位元、分配律、添字の等号の判定可能性、実数であること、指数関数は効いていない。
  正値性の段では、上に加えて `mul_pos` の順序の条件（正の元どうしの積が正）だけが効く。
  実数・指数関数の正値性は、`B` の対角成分と `V₂` の成分が正であることを示す Step 1・Step 2 にだけ効く。

- （ノートへ退避したセクター分解について）**セクター分解に効いているのは「対称な対合 `ε`（`ε² = 1`）で `W` と可換なもの」だけ**である。
  `ε` が `σ^x` の積であることも、`W` が転送行列であることも効いていない。
  Lean 側の `Ising2D.sector_decomposition_of_rayleigh_sup` はすでにその一般性で述べてあるので、
  別途の必要十分版は置いていない。

## 3. 他章に仮定として置いた事実

章 009 / 010 などの結果は、次を **import せず仮定として受け取っている**（本章の定理は一般の実行列について述べてある）。
（`PartitionFunction/ProjectionAndJordanWigner/DefinitionSymmetrizedTransferMatrix.lean` と
`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimPartitionFunctionSandwich.lean` の冒頭コメントにも明記した。）

| 仮定 | 対応する人手証明 | Lean での受け取り方 |
| --- | --- | --- |
| `Z(K_1,K_2) = tr((V₁V₂)^{N_row})`（実成分の行列で読んだ形） | `partition_function_via_transfer_matrix`（章 001。人手は `(Z(K_1,K_2))_ℂ = tr(…)`。Lean では `Ising2D.partition_function_via_transfer_matrix`） | `partition_function_sandwich` の引数 `hZ`（`Z : ℝ` と実成分の行列で、人手の ℂ 版の主張を実数で読んだもの）。具体的な `Z` と `W` については `partition_function_sandwich_physical` が人手の準備 `Z(K_1,K_2) = Σ_k ((W_ℝ)^{N_row})_kk`（`partitionFunction_eq_trace_physicalSymTransferR_pow`）を証明して使う |
| `V₁^{1/2}` が正の対角行列 | `sigma_z_diagonal_action` + `exp_of_diagonal_matrix`（章 009） | `Ising2D.diagExp d`（`d : n → ℝ`）として与える。`d μ = (1/2)K₁∑_m μ(m)μ(m+1)` に対応 |
| `V₂` の成分がすべて正 | `def_transfer_matrix`（章 001。成分は `Ising2D.physicalV2C_eq_map` で実行列と一致） | `symTransfer_entry_pos` の引数 `hV2`。具体的な `V₂` については `physicalV2R_apply_configBasisIso_pos` で証明済み |
| `V₂` が実対称正定値 | `iH_is_real_symmetric` + `exp_hermitian_is_positive_definite`（章 009） | `symTransfer_posDef` / `partition_function_sandwich` の引数。具体的な `W` については `partition_function_sandwich_physical` が一般の `partition_function_sandwich` を経ず、人手どおり `W` の正定値性 `physicalSymTransferR_posDef`（`congruence_preserves_positive_definite` を `A = exp(S₂)` に使う）から `trace_power_sandwich` を引く |
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
