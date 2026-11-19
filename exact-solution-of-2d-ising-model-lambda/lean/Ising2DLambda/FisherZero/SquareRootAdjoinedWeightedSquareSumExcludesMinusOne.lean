import Ising2DLambda.FisherZero.SubfieldWeightedSquareSumExcludesMinusOne
import Ising2DLambda.FisherZero.QuadraticConjugateSquareSumIdentity

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 正の元の平方根を添加しても、正錐重み付き平方和は負の単位元を含まない。 -/
theorem squareRootAdjoinedWeightedSquareSum_ne_neg_one
    (F : Subfield Qbar) (CF : Set Qbar) (hCF : IsSubfieldPositiveCone F CF)
    (a b : Qbar) (ha : a ∈ CF) (hb : b * b = a) (hbF : b ∉ F) :
    (-1 : Qbar) ∉ positiveWeightedSquareSums
      (Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar))) CF := by
  classical
  intro hneg
  obtain ⟨ι, _, c, y, hc, hy, hsum⟩ := hneg
  have haF : a ∈ F := hCF.subset a ha
  have hlin (i : ι) : ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧ y i = u + v * b := by
    have h : y i ∈ quadraticLinearValues F b := by
      rw [quadraticLinearValues_eq_adjoin F a b haF hb hbF]
      exact hy i
    exact h
  let u : ι → Qbar := fun i => (hlin i).choose
  let v : ι → Qbar := fun i => (hlin i).choose_spec.choose
  have hu (i : ι) : u i ∈ F := (hlin i).choose_spec.choose_spec.1
  have hv (i : ι) : v i ∈ F := (hlin i).choose_spec.choose_spec.2.1
  have hyuv (i : ι) : y i = u i + v i * b :=
    (hlin i).choose_spec.choose_spec.2.2
  let A : Qbar := ∑ i, c i * (u i * u i + a * (v i * v i))
  let B : Qbar := ∑ i, (2 * c i * u i * v i)
  have hAF : A ∈ F := by
    dsimp [A]
    apply Subfield.sum_mem
    intro i _
    exact F.mul_mem (hCF.subset _ (hc i))
      (F.add_mem (F.mul_mem (hu i) (hu i))
        (F.mul_mem haF (F.mul_mem (hv i) (hv i))))
  have hBF : B ∈ F := by
    dsimp [B]
    apply Subfield.sum_mem
    intro i _
    have htwo : (2 : Qbar) ∈ F := by
      simpa only [one_add_one_eq_two] using F.add_mem F.one_mem F.one_mem
    exact F.mul_mem (F.mul_mem (F.mul_mem htwo (hCF.subset _ (hc i)))
      (hu i)) (hv i)
  have hfirst : (∑ i, c i * ((u i + v i * b) * (u i + v i * b))) = A + B * b := by
    dsimp [A, B]
    rw [Finset.sum_mul, ← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro i _
    ring_nf
    rw [← hb]
    ring
  have hsecond : (∑ i, c i * ((u i - v i * b) * (u i - v i * b))) = A - B * b := by
    dsimp [A, B]
    rw [Finset.sum_mul, ← Finset.sum_sub_distrib]
    apply Finset.sum_congr rfl
    intro i _
    ring_nf
    rw [← hb]
    ring
  have hfirst_neg : A + B * b = -1 := by
    calc
      A + B * b = ∑ i, c i * ((u i + v i * b) * (u i + v i * b)) := hfirst.symm
      _ = ∑ i, c i * (y i * y i) := by
        apply Finset.sum_congr rfl
        intro i _
        rw [hyuv]
      _ = -1 := hsum.symm
  have hcoeff := quadraticRepresentation_unique F b A B (-1) 0 hbF hAF hBF
    (F.neg_mem F.one_mem) F.zero_mem
    (by simpa using hfirst_neg)
  have hconj : (∑ i, c i * ((u i - v i * b) * (u i - v i * b))) = -1 := by
    rw [hsecond, hcoeff.2, hcoeff.1]
    ring
  have hidentity := quadraticConjugateSquareSumIdentity F a b haF hb ι c u v
    (fun i => hCF.subset _ (hc i)) hu hv
  have hAneg : A = -1 := by
    have htwo : 2 * A = -2 := by
      calc
        2 * A = (∑ i, c i * ((u i + v i * b) * (u i + v i * b))) +
            (∑ i, c i * ((u i - v i * b) * (u i - v i * b))) := by
              dsimp [A]
              exact hidentity.symm
        _ = -1 + -1 := by rw [hfirst, hfirst_neg, hconj]
        _ = -2 := by ring
    calc
      A = (2 * A) / 2 := by ring
      _ = (-2) / 2 := by rw [htwo]
      _ = -1 := by norm_num
  have hAweighted : A ∈ positiveWeightedSquareSums F CF := by
    refine ⟨ι ⊕ ι, inferInstance, Sum.elim c (fun i => c i * a),
      Sum.elim u v, ?_, ?_, ?_⟩
    · rintro (i | i)
      · exact hc i
      · exact hCF.mul_mem _ _ (hc i) ha
    · rintro (i | i)
      · exact hu i
      · exact hv i
    · dsimp [A]
      rw [Fintype.sum_sum_type]
      rw [← Finset.sum_add_distrib]
      apply Finset.sum_congr rfl
      intro i _
      simp only [Sum.elim_inl, Sum.elim_inr]
      ring
  exact (subfieldWeightedSquareSum_ne_neg_one F CF hCF) (hAneg ▸ hAweighted)

end Ising2DLambda.FisherZero
