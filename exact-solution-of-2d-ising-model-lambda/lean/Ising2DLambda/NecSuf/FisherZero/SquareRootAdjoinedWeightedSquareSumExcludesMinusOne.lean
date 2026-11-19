import Ising2DLambda.NecSuf.FisherZero.SubfieldWeightedSquareSumExcludesMinusOne
import Ising2DLambda.NecSuf.FisherZero.QuadraticConjugateSquareSumIdentity
import Ising2DLambda.NecSuf.FisherZero.SquareRootAdjoinedQuadraticRepresentationUnique

namespace Ising2DLambda.NecSuf.FisherZero

/-- 表示の一意性に部分体の除法、共役和からの二の消去に `2 ≠ 0` を用いる。 -/
theorem squareRootAdjoinedWeightedSquareSum_ne_neg_one
    {K : Type} [Field K] [NeZero (2 : K)] (F : Subfield K) (C E : Set K)
    (hCsubset : C ⊆ (F : Set K))
    (hCmul : ∀ x y : K, x ∈ C → y ∈ C → x * y ∈ C)
    (hbase : (-1 : K) ∉ weightedSquareSums (F : Set K) C)
    (a b : K) (ha : a ∈ C) (hb : b * b = a) (hbF : b ∉ F)
    (hrep : ∀ y ∈ E, ∃ u v : K, u ∈ F ∧ v ∈ F ∧ y = u + v * b) :
    (-1 : K) ∉ weightedSquareSums E C := by
  classical
  intro hneg
  obtain ⟨ι, _, c, y, hc, hy, hsum⟩ := hneg
  have haF : a ∈ F := hCsubset ha
  have hlin (i : ι) : ∃ u v : K, u ∈ F ∧ v ∈ F ∧ y i = u + v * b :=
    hrep (y i) (hy i)
  let u : ι → K := fun i => (hlin i).choose
  let v : ι → K := fun i => (hlin i).choose_spec.choose
  have hu (i : ι) : u i ∈ F := (hlin i).choose_spec.choose_spec.1
  have hv (i : ι) : v i ∈ F := (hlin i).choose_spec.choose_spec.2.1
  have hyuv (i : ι) : y i = u i + v i * b :=
    (hlin i).choose_spec.choose_spec.2.2
  let A : K := ∑ i, c i * (u i * u i + a * (v i * v i))
  let B : K := ∑ i, (2 * c i * u i * v i)
  have hAF : A ∈ F := by
    dsimp [A]
    apply Subfield.sum_mem
    intro i _
    exact F.mul_mem (hCsubset (hc i))
      (F.add_mem (F.mul_mem (hu i) (hu i))
        (F.mul_mem haF (F.mul_mem (hv i) (hv i))))
  have hBF : B ∈ F := by
    dsimp [B]
    apply Subfield.sum_mem
    intro i _
    have htwo : (2 : K) ∈ F := by
      simpa only [one_add_one_eq_two] using F.add_mem F.one_mem F.one_mem
    exact F.mul_mem (F.mul_mem (F.mul_mem htwo (hCsubset (hc i)))
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
  have hcoeff := quadraticRepresentation_unique_necSuf F b A B (-1) 0 hbF hAF hBF
    (F.neg_mem F.one_mem) F.zero_mem
    (by simpa using hfirst_neg)
  have hconj : (∑ i, c i * ((u i - v i * b) * (u i - v i * b))) = -1 := by
    rw [hsecond, hcoeff.2, hcoeff.1]
    ring
  have hidentity := quadraticConjugateSquareSumIdentity a b hb ι c u v
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
      A = (2 * A) / 2 := by field_simp
      _ = (-2) / 2 := by rw [htwo]
      _ = -1 := by
        have htwo_nonzero : (2 : K) ≠ 0 := NeZero.ne _
        field_simp
  have hAweighted : A ∈ weightedSquareSums (F : Set K) C := by
    refine ⟨ι ⊕ ι, inferInstance, Sum.elim c (fun i => c i * a),
      Sum.elim u v, ?_, ?_, ?_⟩
    · rintro (i | i)
      · exact hc i
      · exact hCmul _ _ (hc i) ha
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
  exact hbase (hAneg ▸ hAweighted)

end Ising2DLambda.NecSuf.FisherZero
