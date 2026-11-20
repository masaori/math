/-
必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。
`S := F`、`T := K = F(ω)`、`hquad` は `claim_imaginary_unit_extension_quadratic_root`（e = 1）と
`x + yω ∈ K` から、`hdist` は Qbar の標数が零であることから渡す。
帰納法の仮定の形 `N = 2^{k-1}·m'`（`m'` は奇数）へ合わせる数え上げは、具体版と同じく
`claim_root_index_pair_count` と `claim_pair_count_two_adic_valuation_decrease` で行う。
-/
import Ising2DLambda.FisherZero.SubfieldPolynomialRootInductionStep
import Ising2DLambda.NecSuf.FisherZero.SubfieldPolynomialRootInductionStep

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_subfield_polynomial_root_induction_step` を必要十分版から得る。 -/
theorem subfieldPolynomialRoot_inductionStep_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (omega : Qbar) (homega : omega * omega = -1)
    (k m d : ℕ) (hk : 1 ≤ k) (hm : ∃ j : ℕ, m = j + j + 1) (hd : d = 2 ^ k * m)
    (hIH : ∀ m' : ℕ, (∃ j : ℕ, m' = j + j + 1) → ∀ β : ℕ → Qbar,
      (∏ r ∈ Finset.range (2 ^ (k - 1) * m'), (Polynomial.X - qbarConst (β r))) ∈
        subfieldCoefficientPolynomials F →
      ∃ r : ℕ, r < 2 ^ (k - 1) * m' ∧
        β r ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)))
    (α : ℕ → Qbar)
    (hf : (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i))) ∈
      subfieldCoefficientPolynomials F) :
    ∃ i : ℕ, i < d ∧ α i ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) := by
  set K := Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) with hKdef
  have hFK : ∀ x : Qbar, x ∈ F → x ∈ K := fun x hx => Subfield.subset_closure (Or.inl hx)
  have homegaK : omega ∈ K := Subfield.subset_closure (Or.inr rfl)
  have hd1 : 1 ≤ d := by
    obtain ⟨j, hj⟩ := hm
    have hm1 : 1 ≤ m := by rw [hj]; exact Nat.le_add_left 1 (j + j)
    rw [hd]
    calc 1 = 1 * 1 := (Nat.mul_one 1).symm
      _ ≤ 2 ^ k * m := Nat.mul_le_mul Nat.one_le_two_pow hm1
  set N := Fintype.card (RootIndexPair d) with hNdef
  let π : Fin N ≃ RootIndexPair d := (Fintype.equivFin (RootIndexPair d)).symm
  have hN : N + N = d * (d - 1) := rootIndexPairCount d N hd1 π
  obtain ⟨hNeq, hodd⟩ := pairCountTwoAdicValuationDecrease k m d N hk hm hd hN
  have hquad : ∀ p q : Qbar, p ∈ K → q ∈ K → ∃ r : Qbar, r ∈ K ∧ r * r + p * r + q = 0 := by
    intro p q hp hq
    obtain ⟨r, x, y, hx, hy, hr, hroot⟩ := imaginaryUnitExtension_quadraticRoot F C hC hpositive
      omega 1 p q homega one_ne_zero K.one_mem hp hq
    refine ⟨r, ?_, by rw [← one_mul (r * r)]; exact hroot⟩
    rw [hr]
    exact K.add_mem (hFK x hx) (K.mul_mem (hFK y hy) homegaK)
  have hdist : ∀ c c' : ℕ, c < c' → c' ≤ N → (((c : ℤ) - (c' : ℤ) : ℤ) : Qbar) ≠ 0 := by
    intro c c' hlt _
    exact Int.cast_ne_zero.mpr (by omega)
  have hIH' : ∀ β : ℕ → Qbar,
      (∀ n : ℕ, (∏ r ∈ Finset.range N, (Polynomial.X - Polynomial.C (β r))).coeff n ∈ F) →
      ∃ r : ℕ, r < N ∧ β r ∈ K := by
    intro β hβ
    have hβ' : (∏ r ∈ Finset.range (2 ^ (k - 1) * (m * (d - 1))),
        (Polynomial.X - qbarConst (β r))) ∈ subfieldCoefficientPolynomials F := by
      rw [← hNeq]
      exact hβ
    obtain ⟨r, hr, hmem⟩ := hIH (m * (d - 1)) hodd β hβ'
    exact ⟨r, by rw [hNeq]; exact hr, hmem⟩
  exact Ising2DLambda.NecSuf.FisherZero.subfieldPolynomialRoot_inductionStep_necSuf
    (F : Set Qbar) F.zero_mem F.one_mem (F.neg_mem F.one_mem) (fun _ _ hx hy => F.add_mem hx hy)
    (fun _ _ hx hy => F.mul_mem hx hy) (natCast_mem_subfield F)
    (K : Set Qbar) (fun _ _ ha hb => K.sub_mem ha hb) (fun _ _ ha hb => K.mul_mem ha hb)
    (fun _ _ ha hb => K.div_mem ha hb) (fun z => K.intCast_mem z) hquad π hdist hIH' α hf

end Ising2DLambda.FisherZero
