/-
# `i H_1^{(+)} = D_0 + ε G`（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_004_claim_H1_plus_in_sigma_z_form`、ラベル **`H1_plus_in_sigma_z_form`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 サイトの積 `σ^yσ^x = -iσ^z`, `σ^xσ^x = I`（`V1_in_Z_Y_epsilon` の Step 0） | `pauliY_mul_pauliX_eq`（`Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimV1InZYEpsilon`）、`pauliX_mul_pauliX`（`Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols`） |
| 1 サイトの積 `σ^xσ^z = -iσ^y`（2 次の成分計算） | `pauliX_mul_pauliZ_eq` |
| 内部辺 `Y_mZ_{m+1} = -iσ^z_mσ^z_{m+1}`（`1 ≤ m ≤ M_col-1`） | `Y_mul_Z_next_of_not_last`（`Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimV1InZYEpsilon`。人手と同じ計算） |
| 両辺に `i` を掛けて `iY_mZ_{m+1} = σ^z_mσ^z_{m+1}` | `I_smul_Y_mul_Z_next_of_not_last` |
| 境界項の左辺 `Y_{M_col}Z_1 = -iσ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}` | `Y_last_mul_Z_first` |
| 境界項の右辺 `εσ^z_{M_col}σ^z_1 = -σ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}` | `epsilon_mul_sigmaZ_last_mul_sigmaZ_first` |
| 突き合わせ `-iY_{M_col}Z_1 = εσ^z_{M_col}σ^z_1` | `neg_I_smul_Y_last_mul_Z_first` |
| `def_H1_plus` の `H_1^{(+)} = ∑_{m=1}^{M_col-1}Y_mZ_{m+1} - Y_{M_col}Z_1` | `H1plus_eq_bulk_sub_boundary` |
| 最後の式変形 `iH_1^{(+)} = ⋯ = D_0 + εG` | `H1_plus_in_sigma_z_form` |

人手の `σ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}` は、サイトごとの因子の族 `boundaryYXYFamily` をクロネッカー積
`siteProd` に入れたものとして書く。「相異なるサイトの因子は可換」（`kronecker_product_rule` (1)）は
Lean では `siteProd_mul`（サイトごとの積）で、各サイトの因子を取り出す段は族の各成分の計算で行う。

具体的な複素行列 `Y_m, Z_m, ε, σ^z_m` の間の等式であり、主張に固有なのは各サイトの Pauli 行列の積だけなので、
必要十分版は置かない（同じ型の主張 `V1_in_Z_Y_epsilon` と同じ判断）。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.DefinitionOpenChainAndBoundaryOperators

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 1 サイトの積 -/

/-- 人手の `σ^xσ^z = -iσ^y`（2 次の成分計算）。 -/
theorem pauliX_mul_pauliZ_eq : pauliX * pauliZ = (-Complex.I) • pauliY := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliX, pauliY, pauliZ, Matrix.mul_apply, Fin.sum_univ_two]

/-! ## 内部辺 -/

/-- 人手の「両辺に `i` を掛けて `iY_mZ_{m+1} = σ^z_mσ^z_{m+1}`（`i·(-i) = 1`）」。 -/
theorem I_smul_Y_mul_Z_next_of_not_last (m : Fin M) (hm : (m : ℕ) + 1 ≠ M) :
    Complex.I • (Y m * Z (nextSite m)) = sigmaZ m * sigmaZ (nextSite m) := by
  rw [Y_mul_Z_next_of_not_last m hm, smul_smul]
  have h : Complex.I * -Complex.I = 1 := by rw [mul_neg, Complex.I_mul_I, neg_neg]
  rw [h, one_smul]

/-! ## 境界項 -/

/-- `σ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}` のサイトごとの因子（サイト `1` と `M_col` に `σ^y`、ほかに `σ^x`）。 -/
noncomputable def boundaryYXYFamily (M : ℕ) (hM : M ≠ 0) : Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => if i = firstSite M hM ∨ i = lastSite M hM then pauliY else pauliX

private theorem firstSite_ne_lastSite (hM : 2 ≤ M) :
    firstSite M (by omega) ≠ lastSite M (by omega) :=
  Fin.ne_of_val_ne (by simp [firstSite, lastSite]; omega)

/-- **人手の境界項の左辺**: `Y_{M_col}Z_1 = -iσ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}`。

人手の各行: `def_transfer_matrix_symbols` で展開し、相異なるサイトの因子を並べ替えて（`siteProd_mul`）
サイト `1` に `σ^xσ^z` を作り、`σ^xσ^z = -iσ^y` を適用し、スカラーを外へ出す。 -/
theorem Y_last_mul_Z_first (hM : 2 ≤ M) :
    Y (lastSite M (by omega)) * Z (firstSite M (by omega))
      = (-Complex.I) • siteProd M (boundaryYXYFamily M (by omega)) := by
  have hM0 : M ≠ 0 := by omega
  rw [Y, Z, ← siteProd_mul]
  let c : Fin M → ℂ := Function.update 1 (firstSite M hM0) (-Complex.I)
  have hfamily : jwFamily (lastSite M hM0) pauliY * jwFamily (firstSite M hM0) pauliZ
      = fun i => c i • boundaryYXYFamily M hM0 i := by
    funext i
    simp only [Pi.mul_apply]
    by_cases h1 : i = firstSite M hM0
    · subst h1
      rw [jwFamily_of_lt (by simp [firstSite, lastSite]; omega), jwFamily_self,
        pauliX_mul_pauliZ_eq]
      simp [c, boundaryYXYFamily]
    · have h1v : 0 < (i : ℕ) := by
        rcases Nat.eq_zero_or_pos (i : ℕ) with h | h
        · exact absurd (Fin.val_injective (by simp [firstSite, h])) h1
        · exact h
      rw [jwFamily_of_gt (A := pauliZ) (by simp [firstSite]; omega), mul_one]
      by_cases h2 : i = lastSite M hM0
      · subst h2
        rw [jwFamily_self]
        simp [c, boundaryYXYFamily, h1]
      · have h2v : (i : ℕ) < M - 1 := by
          have := i.isLt
          have : (i : ℕ) ≠ M - 1 := fun h => h2 (Fin.val_injective (by simp [lastSite, h]))
          omega
        rw [jwFamily_of_lt (by simp [lastSite]; omega)]
        simp [c, boundaryYXYFamily, h1, h2]
  rw [hfamily, siteProd_smul_family]
  congr 1
  simp [c, Finset.prod_update_of_mem]

/-- **人手の境界項の右辺**: `εσ^z_{M_col}σ^z_1 = -σ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}`。

人手の各行: `def_transfer_matrix_symbols` の `ε = σ^x_1⋯σ^x_{M_col}` で展開し、相異なるサイトの因子を並べ替えて
（`siteProd_mul`）サイト `1` と `M_col` に `σ^xσ^z` を作り、`σ^xσ^z = -iσ^y` を 2 箇所へ同時適用し、
`(-i)^2 = -1`。 -/
theorem epsilon_mul_sigmaZ_last_mul_sigmaZ_first (hM : 2 ≤ M) :
    epsilon M * (sigmaZ (lastSite M (by omega)) * sigmaZ (firstSite M (by omega)))
      = (-1 : ℂ) • siteProd M (boundaryYXYFamily M (by omega)) := by
  have hM0 : M ≠ 0 := by omega
  have hne := firstSite_ne_lastSite hM
  rw [epsilon_eq_siteProd_pauliX_by_induction, sigmaZ, sigmaZ, siteOp_apply, siteOp_apply,
    ← siteProd_mul, ← siteProd_mul]
  let c : Fin M → ℂ :=
    Function.update (Function.update 1 (firstSite M hM0) (-Complex.I)) (lastSite M hM0) (-Complex.I)
  have hfamily : (fun _ : Fin M => pauliX) *
      (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (lastSite M hM0) pauliZ *
        Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (firstSite M hM0) pauliZ)
      = fun i => c i • boundaryYXYFamily M hM0 i := by
    funext i
    simp only [Pi.mul_apply]
    by_cases h1 : i = firstSite M hM0
    · subst h1
      simp [c, boundaryYXYFamily, hne, pauliX_mul_pauliZ_eq]
    · by_cases h2 : i = lastSite M hM0
      · subst h2
        simp [c, boundaryYXYFamily, hne.symm, pauliX_mul_pauliZ_eq]
      · simp [c, boundaryYXYFamily, h1, h2]
  rw [hfamily, siteProd_smul_family]
  congr 1
  rw [Fintype.prod_eq_mul_prod_compl (lastSite M hM0)]
  simp only [c, Function.update_self]
  rw [Finset.prod_eq_single (firstSite M hM0)]
  · rw [Function.update_of_ne hne, Function.update_self]
    rw [neg_mul_neg, Complex.I_mul_I]
  · intro b _ hb
    by_cases h2 : b = lastSite M hM0
    · simp_all
    · rw [Function.update_of_ne h2, Function.update_of_ne hb, Pi.one_apply]
  · intro h
    exact absurd (Finset.mem_compl.2 (by simpa using hne)) h

/-- **人手の突き合わせ**: `-iY_{M_col}Z_1 = εσ^z_{M_col}σ^z_1`。 -/
theorem neg_I_smul_Y_last_mul_Z_first (hM : 2 ≤ M) :
    (-Complex.I) • (Y (lastSite M (by omega)) * Z (firstSite M (by omega)))
      = epsilon M * (sigmaZ (lastSite M (by omega)) * sigmaZ (firstSite M (by omega))) := by
  calc (-Complex.I) • (Y (lastSite M (by omega)) * Z (firstSite M (by omega)))
      = (-Complex.I) • ((-Complex.I) • siteProd M (boundaryYXYFamily M (by omega))) := by
        rw [Y_last_mul_Z_first hM]
    _ = (-1 : ℂ) • siteProd M (boundaryYXYFamily M (by omega)) := by
        rw [smul_smul, neg_mul_neg, Complex.I_mul_I]
    _ = epsilon M * (sigmaZ (lastSite M (by omega)) * sigmaZ (firstSite M (by omega))) := by
        rw [epsilon_mul_sigmaZ_last_mul_sigmaZ_first hM]

/-! ## `H_1^{(+)}` の書き換え -/

private theorem filter_last_eq_singleton (hM : M ≠ 0) :
    Finset.univ.filter (fun m : Fin M => ¬ ((m : ℕ) + 1 ≠ M)) = {lastSite M hM} := by
  ext m
  simp only [Finset.mem_filter, Finset.mem_univ, true_and, not_not, Finset.mem_singleton]
  constructor
  · intro h
    exact Fin.val_injective (by simp [lastSite]; omega)
  · rintro rfl
    simp [lastSite]
    omega

/-- **人手 `def_H1_plus` の形** `H_1^{(+)} = ∑_{m=1}^{M_col-1}Y_mZ_{m+1} - Y_{M_col}Z_1`。

Lean の `H1plus` は全サイトの和に境界項の係数 `lastSign (-1)` を掛けた形なので、和を
`(m : ℕ) + 1 ≠ M` の範囲と、残る 1 項（人手のサイト `M_col`）とに分ける。 -/
theorem H1plus_eq_bulk_sub_boundary (hM : M ≠ 0) :
    H1plus M
      = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M), Y m * Z (nextSite m)
        - Y (lastSite M hM) * Z (firstSite M hM) := by
  rw [H1plus, ← Finset.sum_filter_add_sum_filter_not Finset.univ (fun m : Fin M => (m : ℕ) + 1 ≠ M),
    filter_last_eq_singleton hM, Finset.sum_singleton, sub_eq_add_neg]
  congr 1
  · exact Finset.sum_congr rfl fun m hm => by
      rw [lastSign_of_not_last (Finset.mem_filter.1 hm).2, one_smul]
  · rw [lastSign_of_last (by simp [lastSite]; omega), nextSite_lastSite hM, neg_one_smul]

/-- **人手 `H1_plus_in_sigma_z_form`**: `iH_1^{(+)} = D_0 + εG`（`M_col ≥ 2`）。

人手の最後の式変形を 1 行ずつ辿る。 -/
theorem H1_plus_in_sigma_z_form (hM : 2 ≤ M) :
    Complex.I • H1plus M = openChainD0 M + epsilon M * boundaryG M (by omega) := by
  have hM0 : M ≠ 0 := by omega
  calc Complex.I • H1plus M
      = Complex.I • (∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
            Y m * Z (nextSite m) - Y (lastSite M hM0) * Z (firstSite M hM0)) := by
        -- def_H1_plus
        rw [H1plus_eq_bulk_sub_boundary hM0]
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
            Complex.I • (Y m * Z (nextSite m))
          + (-Complex.I) • (Y (lastSite M hM0) * Z (firstSite M hM0)) := by
        -- スカラー倍の分配法則
        rw [smul_sub, Finset.smul_sum, sub_eq_add_neg, neg_smul]
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
            sigmaZ m * sigmaZ (nextSite m)
          + (-Complex.I) • (Y (lastSite M hM0) * Z (firstSite M hM0)) := by
        -- 内部辺の等式を有限和へ適用
        congr 1
        exact Finset.sum_congr rfl fun m hm =>
          I_smul_Y_mul_Z_next_of_not_last m (Finset.mem_filter.1 hm).2
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
            sigmaZ m * sigmaZ (nextSite m)
          + epsilon M * (sigmaZ (lastSite M hM0) * sigmaZ (firstSite M hM0)) := by
        -- 境界項の等式
        rw [neg_I_smul_Y_last_mul_Z_first hM]
    _ = openChainD0 M + epsilon M * (sigmaZ (lastSite M hM0) * sigmaZ (firstSite M hM0)) := by
        -- def_D0_open_chain_operator
        rfl
    _ = openChainD0 M + epsilon M * boundaryG M hM0 := by
        -- def_G_boundary_operator
        rfl

end Ising2D
