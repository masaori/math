/-
# `ε, D_0, G` の可換性・`(εG)^2 = I`・配置基底の上での `D_0, G` の対角作用（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`

| 人手 | Lean |
| --- | --- |
| `epsilon_D0_G_pairwise_commute` の各 `m` の `ε(σ^z_mσ^z_{m+1}) = (σ^z_mσ^z_{m+1})ε` | `epsilon_mul_sigmaZ_mul_sigmaZ` |
| 同 `εD_0 = D_0ε` | `epsilon_mul_openChainD0` |
| 同 `εG = Gε` | `epsilon_mul_boundaryG` |
| 同 「`kronecker_product_rule` (1) を各サイトへ適用」した `(σ^z_aσ^z_b)(σ^z_cσ^z_d) = (σ^z_cσ^z_d)(σ^z_aσ^z_b)` | `sigmaZ_mul_sigmaZ_mul_comm` |
| 同 各 `m` の `(σ^z_mσ^z_{m+1})G = G(σ^z_mσ^z_{m+1})` と `D_0G = GD_0` | `openChainD0_mul_boundaryG` |
| `epsilon_G_is_involution` の `(σ^z_k)^2 = I`（`pauli_matrix_products` と `kronecker_product_rule`） | `sigmaZ_mul_self` |
| 同 `G^2 = (σ^z_{M_col})^2(σ^z_1)^2`（相異なるサイトの因子の可換性） | `boundaryG_mul_self` の第 1〜2 段 |
| 同 `(εG)^2 = I` | `epsilon_mul_boundaryG_sq` |
| `D0_G_diagonal_action` の各 `m` の `(σ^z_mσ^z_{m+1})f_{ι(s)} = s(m)s(m+1)f_{ι(s)}` | `sigmaZ_mul_sigmaZ_mulVec_basisVec_spin` |
| 同 `D_0f_{ι(s)} = (∑_{m=1}^{M_col-1}s(m)s(m+1))f_{ι(s)}` | `openChainD0_mulVec_basisVec` |
| 同 `Gf_{ι(s)} = s(M_col)s(1)f_{ι(s)}` | `boundaryG_mulVec_basisVec` |

人手の `ε σ^z_k = -σ^z_k ε`（`epsilon_commutes_with_transfer_matrices` の Step 1）は
`epsilon_anticomm_sigmaZ`、`σ^z_m f_{ι(s)} = s(m) f_{ι(s)}`（`sigma_z_diagonal_action`）は
`sigmaZ_mulVec_basisVec_spin`、`ε^2 = I` は `epsilon_sq` である。
「相異なるサイトの因子は可換」（`kronecker_product_rule` (1)）は `siteProd_mul` でサイトごとの積に直して、
各サイトの因子の積を比べる形で書く。

この証明が使うのは、既存の補題 `epsilon_anticomm_sigmaZ`・`sigmaZ_mulVec_basisVec_spin`・`epsilon_sq`・
`pauliZ_mul_pauliZ`・`siteProd_mul` に加えて、環の公理と有限和・スカラー倍の線型性だけである。
取り払える構造が残らないので、必要十分版は置かない。
-/
import Ising2D.Part018.DefinitionOpenChainAndBoundaryOperators
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimSigmaZDiagonalAction
import Ising2D.Part010.Claim010_EpsilonCommutes

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## `epsilon_D0_G_pairwise_commute` -/

/-- 人手の各 `m` の式変形 `ε(σ^z_aσ^z_b) = ⋯ = (σ^z_aσ^z_b)ε`（二回の反可換移動）。 -/
theorem epsilon_mul_sigmaZ_mul_sigmaZ (a b : Fin M) :
    epsilon M * (sigmaZ a * sigmaZ b) = (sigmaZ a * sigmaZ b) * epsilon M :=
  calc epsilon M * (sigmaZ a * sigmaZ b)
      = (epsilon M * sigmaZ a) * sigmaZ b := by rw [mul_assoc]
    _ = (-(sigmaZ a * epsilon M)) * sigmaZ b := by rw [epsilon_anticomm_sigmaZ a]
    _ = -(sigmaZ a * (epsilon M * sigmaZ b)) := by rw [neg_mul, mul_assoc]
    _ = -(sigmaZ a * (-(sigmaZ b * epsilon M))) := by rw [epsilon_anticomm_sigmaZ b]
    _ = sigmaZ a * (sigmaZ b * epsilon M) := by rw [mul_neg, neg_neg]
    _ = (sigmaZ a * sigmaZ b) * epsilon M := by rw [mul_assoc]

/-- **人手 `epsilon_D0_G_pairwise_commute` の `εD_0 = D_0ε`。** -/
theorem epsilon_mul_openChainD0 (M : ℕ) :
    epsilon M * openChainD0 M = openChainD0 M * epsilon M :=
  calc epsilon M * openChainD0 M
      = epsilon M * ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          sigmaZ m * sigmaZ (nextSite m) := by rw [openChainD0]
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          epsilon M * (sigmaZ m * sigmaZ (nextSite m)) := by rw [Finset.mul_sum]
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          (sigmaZ m * sigmaZ (nextSite m)) * epsilon M :=
        Finset.sum_congr rfl fun m _ => epsilon_mul_sigmaZ_mul_sigmaZ m (nextSite m)
    _ = (∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          sigmaZ m * sigmaZ (nextSite m)) * epsilon M := by rw [Finset.sum_mul]
    _ = openChainD0 M * epsilon M := by rw [openChainD0]

/-- **人手 `epsilon_D0_G_pairwise_commute` の `εG = Gε`。** -/
theorem epsilon_mul_boundaryG (hM : M ≠ 0) :
    epsilon M * boundaryG M hM = boundaryG M hM * epsilon M := by
  rw [boundaryG]
  exact epsilon_mul_sigmaZ_mul_sigmaZ (lastSite M hM) (firstSite M hM)

/-- 人手の「`kronecker_product_rule` (1) より、相異なるサイトの因子は可換し、同じサイトに現れる因子は
いずれも `σ^z` なので、各サイトの因子を並べ替える」:
`(σ^z_aσ^z_b)(σ^z_cσ^z_d) = (σ^z_cσ^z_d)(σ^z_aσ^z_b)`。

`siteProd_mul` で両辺をサイトごとの積に直すと、各サイトの因子は `1` か `σ^z` の積で、
`1` と `σ^z` は互いに可換なので並べ替えられる。 -/
theorem sigmaZ_mul_sigmaZ_mul_comm (a b c d : Fin M) :
    (sigmaZ a * sigmaZ b) * (sigmaZ c * sigmaZ d)
      = (sigmaZ c * sigmaZ d) * (sigmaZ a * sigmaZ b) := by
  simp only [sigmaZ, siteOp_apply, ← siteProd_mul]
  congr 1
  funext i
  simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
  split_ifs <;> simp

/-- **人手 `epsilon_D0_G_pairwise_commute` の `D_0G = GD_0`。** -/
theorem openChainD0_mul_boundaryG (hM : M ≠ 0) :
    openChainD0 M * boundaryG M hM = boundaryG M hM * openChainD0 M :=
  calc openChainD0 M * boundaryG M hM
      = (∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          sigmaZ m * sigmaZ (nextSite m)) * boundaryG M hM := by rw [openChainD0]
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          (sigmaZ m * sigmaZ (nextSite m)) * boundaryG M hM := by rw [Finset.sum_mul]
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          boundaryG M hM * (sigmaZ m * sigmaZ (nextSite m)) :=
        Finset.sum_congr rfl fun m _ => by
          rw [boundaryG]
          exact sigmaZ_mul_sigmaZ_mul_comm _ _ _ _
    _ = boundaryG M hM * ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          sigmaZ m * sigmaZ (nextSite m) := by rw [Finset.mul_sum]
    _ = boundaryG M hM * openChainD0 M := by rw [openChainD0]

/-! ## `epsilon_G_is_involution` -/

/-- 人手の `(σ^z_k)^2 = I`（`pauli_matrix_products` の `(σ^z)^2 = I` を `kronecker_product_rule` でサイト `k` に置く）。 -/
theorem sigmaZ_mul_self (k : Fin M) : sigmaZ k * sigmaZ k = 1 := by
  rw [sigmaZ, siteOp_apply, ← siteProd_mul, ← siteProd_one]
  congr 1
  funext i
  by_cases h : i = k
  · subst h
    simp [pauliZ_mul_pauliZ]
  · simp [Function.update_of_ne h]

/-- 人手の `G^2 = (σ^z_{M_col})^2(σ^z_1)^2 = I·I`。 -/
theorem boundaryG_mul_self (hM : M ≠ 0) : boundaryG M hM * boundaryG M hM = 1 :=
  calc boundaryG M hM * boundaryG M hM
      = (sigmaZ (lastSite M hM) * sigmaZ (firstSite M hM))
          * (sigmaZ (lastSite M hM) * sigmaZ (firstSite M hM)) := by rw [boundaryG]
    _ = (sigmaZ (lastSite M hM) * sigmaZ (lastSite M hM))
          * (sigmaZ (firstSite M hM) * sigmaZ (firstSite M hM)) := by
        simp only [sigmaZ, siteOp_apply, ← siteProd_mul]
        congr 1
        funext i
        simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
        split_ifs <;> simp
    _ = 1 * 1 := by rw [sigmaZ_mul_self, sigmaZ_mul_self]
    _ = 1 := one_mul 1

/-- **人手 `epsilon_G_is_involution`**: `(εG)^2 = I`。 -/
theorem epsilon_mul_boundaryG_sq (hM : M ≠ 0) :
    (epsilon M * boundaryG M hM) ^ 2 = 1 :=
  calc (epsilon M * boundaryG M hM) ^ 2
      = epsilon M * boundaryG M hM * (epsilon M * boundaryG M hM) := sq _
    _ = (epsilon M * epsilon M) * (boundaryG M hM * boundaryG M hM) := by
        rw [mul_assoc, ← mul_assoc (boundaryG M hM), ← epsilon_mul_boundaryG hM]
        simp only [mul_assoc]
    _ = 1 * (boundaryG M hM * boundaryG M hM) := by rw [epsilon_sq]
    _ = 1 * 1 := by rw [boundaryG_mul_self]
    _ = 1 := one_mul 1

/-! ## `D0_G_diagonal_action` -/

/-- 人手の各 `m` の式変形 `(σ^z_aσ^z_b)f_{ι(s)} = ⋯ = s(a)s(b)f_{ι(s)}`。 -/
theorem sigmaZ_mul_sigmaZ_mulVec_basisVec_spin (a b : Fin M) (s : SpinConf M) :
    (sigmaZ a * sigmaZ b) *ᵥ basisVec (configBasisIso M s)
      = (((s a : ℝ) * (s b : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) :=
  calc (sigmaZ a * sigmaZ b) *ᵥ basisVec (configBasisIso M s)
      = sigmaZ a *ᵥ (sigmaZ b *ᵥ basisVec (configBasisIso M s)) := by
        rw [Matrix.mulVec_mulVec]
    _ = sigmaZ a *ᵥ ((((s b : ℝ)) : ℂ) • basisVec (configBasisIso M s)) := by
        rw [sigmaZ_mulVec_basisVec_spin b s]
    _ = (((s b : ℝ)) : ℂ) • (sigmaZ a *ᵥ basisVec (configBasisIso M s)) := by
        rw [Matrix.mulVec_smul]
    _ = (((s b : ℝ)) : ℂ) • ((((s a : ℝ)) : ℂ) • basisVec (configBasisIso M s)) := by
        rw [sigmaZ_mulVec_basisVec_spin a s]
    _ = ((((s b : ℝ)) : ℂ) * (((s a : ℝ)) : ℂ)) • basisVec (configBasisIso M s) := by
        rw [smul_smul]
    _ = (((s a : ℝ) * (s b : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) := by
        rw [← Complex.ofReal_mul, mul_comm (s b : ℝ)]

/-- **人手 `D0_G_diagonal_action` の `D_0f_{ι(s)} = (∑_{m=1}^{M_col-1}s(m)s(m+1))f_{ι(s)}`。** -/
theorem openChainD0_mulVec_basisVec (s : SpinConf M) :
    openChainD0 M *ᵥ basisVec (configBasisIso M s)
      = ((∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
            (s m : ℝ) * (s (nextSite m) : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) :=
  calc openChainD0 M *ᵥ basisVec (configBasisIso M s)
      = (∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          sigmaZ m * sigmaZ (nextSite m)) *ᵥ basisVec (configBasisIso M s) := by rw [openChainD0]
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          (sigmaZ m * sigmaZ (nextSite m)) *ᵥ basisVec (configBasisIso M s) := by
        rw [Matrix.sum_mulVec]
    _ = ∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
          (((s m : ℝ) * (s (nextSite m) : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) :=
        Finset.sum_congr rfl fun m _ => sigmaZ_mul_sigmaZ_mulVec_basisVec_spin m (nextSite m) s
    _ = ((∑ m ∈ Finset.univ.filter (fun m : Fin M => (m : ℕ) + 1 ≠ M),
            (s m : ℝ) * (s (nextSite m) : ℝ) : ℝ) : ℂ) • basisVec (configBasisIso M s) := by
        rw [Complex.ofReal_sum, Finset.sum_smul]

/-- **人手 `D0_G_diagonal_action` の `Gf_{ι(s)} = s(M_col)s(1)f_{ι(s)}`。** -/
theorem boundaryG_mulVec_basisVec (hM : M ≠ 0) (s : SpinConf M) :
    boundaryG M hM *ᵥ basisVec (configBasisIso M s)
      = (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
          • basisVec (configBasisIso M s) := by
  rw [boundaryG]
  exact sigmaZ_mul_sigmaZ_mulVec_basisVec_spin (lastSite M hM) (firstSite M hM) s

end Ising2D
