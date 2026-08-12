/-
章「Fisher 零点」の「分配多項式は破れた辺の集合の生成多項式の二倍である」の具体版。
人手証明と同じく、破れた辺の集合の各原像が全スピン反転の対であることから有限和をまとめる。
住処: Z。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SameBrokenEdges

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- 配位 `σ` のもとで破れている辺の番号の集合 `B_L(σ)`。 -/
def brokenEdgeSet (L : ℕ) (σ : Config L) : Finset (Edge L) :=
  univ.filter fun e => σ (boundary0 L e) ≠ σ (boundary1 L e)

/-- 実現できる破れた辺の集合の全体 `𝔅_L`。 -/
def attainableBrokenEdgeSets (L : ℕ) [NeZero L] : Finset (Finset (Edge L)) :=
  univ.image (brokenEdgeSet L)

/-- 破れた辺の集合の生成多項式 `D_L`。 -/
noncomputable def lowTemperaturePolynomial (L : ℕ) [NeZero L] : Polynomial ℤ :=
  ∑ B ∈ attainableBrokenEdgeSets L, Polynomial.X ^ B.card

theorem brokenEdgeSet_card (L : ℕ) (σ : Config L) :
    (brokenEdgeSet L σ).card = brokenBondCount L σ := rfl

theorem globalSpinReversal_brokenEdgeSet (L : ℕ) (σ : Config L) :
    brokenEdgeSet L (globalSpinReversal L σ) = brokenEdgeSet L σ := by
  ext e
  simp only [brokenEdgeSet, mem_filter, mem_univ, true_and]
  exact globalSpinReversal_brokenEdge_iff L σ e

theorem spinReversal_ne_self (s : SpinValue) : spinReversal s ≠ s := by
  intro h
  have hvalue := congrArg Subtype.val h
  rcases s with ⟨s, hs | hs⟩ <;> subst s <;> norm_num [spinReversal] at hvalue <;> omega

theorem globalSpinReversal_ne_self (L : ℕ) [NeZero L] (σ : Config L) :
    globalSpinReversal L σ ≠ σ := by
  intro h
  have hbase := congrFun h ((0, 0) : Vertex L)
  exact spinReversal_ne_self (σ (0, 0)) hbase

theorem brokenEdgeSet_fiber_card_two (L : ℕ) [NeZero L]
    (B : Finset (Edge L)) (hB : B ∈ attainableBrokenEdgeSets L) :
    (univ.filter fun σ : Config L => brokenEdgeSet L σ = B).card = 2 := by
  rw [attainableBrokenEdgeSets, mem_image] at hB
  obtain ⟨σ, _, hσ⟩ := hB
  have hfiber :
      univ.filter (fun τ : Config L => brokenEdgeSet L τ = B) =
        {σ, globalSpinReversal L σ} := by
    ext τ
    simp only [mem_filter, mem_univ, true_and, mem_insert, mem_singleton]
    constructor
    · intro hτ
      apply sameBrokenEdges_eq_or_globalSpinReversal L σ τ
      intro e
      have hsets : brokenEdgeSet L τ = brokenEdgeSet L σ := hτ.trans hσ.symm
      have hedge := Finset.ext_iff.mp hsets e
      simpa [brokenEdgeSet] using hedge.symm
    · intro hτ
      rcases hτ with rfl | rfl
      · exact hσ
      · exact (globalSpinReversal_brokenEdgeSet L σ).trans hσ
  rw [hfiber, card_insert_of_notMem]
  · rw [card_singleton]
  · simpa using (globalSpinReversal_ne_self L σ).symm

/-- `Z_L = 2 D_L`。 -/
theorem partitionPolynomial_eq_two_mul_lowTemperaturePolynomial
    (L : ℕ) [NeZero L] :
    partitionPolynomial L = 2 * lowTemperaturePolynomial L := by
  classical
  rw [partitionPolynomial, lowTemperaturePolynomial]
  rw [← sum_fiberwise_of_maps_to
    (s := (univ : Finset (Config L)))
    (t := attainableBrokenEdgeSets L)
    (g := brokenEdgeSet L)
    (fun σ _ => mem_image_of_mem (brokenEdgeSet L) (mem_univ σ))
    (fun σ => Polynomial.X ^ brokenBondCount L σ)]
  calc
    ∑ B ∈ attainableBrokenEdgeSets L,
        ∑ σ ∈ univ with brokenEdgeSet L σ = B,
          Polynomial.X ^ brokenBondCount L σ
      = ∑ B ∈ attainableBrokenEdgeSets L,
          ∑ _σ ∈ univ.filter (fun σ : Config L => brokenEdgeSet L σ = B),
            Polynomial.X ^ B.card := by
          apply sum_congr rfl
          intro B hB
          apply sum_congr rfl
          intro σ hσ
          rw [mem_filter] at hσ
          rw [← brokenEdgeSet_card L σ, hσ.2]
    _ = ∑ B ∈ attainableBrokenEdgeSets L, 2 • Polynomial.X ^ B.card := by
          apply sum_congr rfl
          intro B hB
          rw [sum_const, brokenEdgeSet_fiber_card_two L B hB]
    _ = 2 * ∑ B ∈ attainableBrokenEdgeSets L, Polynomial.X ^ B.card := by
          simp [Finset.mul_sum]

end Ising2DLambda.FisherZero
