/- 必要十分版を Qbar の部分体・その正錐・`deg_F` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.OddDegreeWeightedSquareSumAvoidsMinusOne
import Ising2DLambda.FisherZero.OddDegreePolynomialHasOddDegreeRootFromNecSuf
import Ising2DLambda.FisherZero.OnePlusWeightedSquareSumEvenDegreeFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.OddDegreeWeightedSquareSumAvoidsMinusOne

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_odd_degree_weighted_square_sum_avoids_minus_one` を必要十分版から得る。
係数の集合は `F`、`deg` は `deg_F`（証人は `degreeOverSubfield_spec`、最小性は `degreeOverSubfield_hmin`）、
根の存在は `def_algebraic_numbers` の第二条件（`IsAlgClosed.exists_root`）、正錐の単位元・零でない元の平方は
具体版の前段（`mul_self_mem_of_isSubfieldPositiveCone`）、零元を含まないことは三分法の排他性から渡す。
`Val_F(α)` の所属は定義のとおり読み替える（`qbarPolyEval_eq_eval`）。 -/
theorem oddDegree_weightedSquareSum_ne_neg_one_from_necSuf (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) (n : ℕ) (α : Qbar) (hαn : degreeOverSubfield F α = n)
    (hodd : Odd n) :
    (-1 : Qbar) ∉ positiveWeightedSquareSums (subfieldPolynomialValuesSubfield F α) CF := by
  have h1C : (1 : Qbar) ∈ CF := by
    have h := mul_self_mem_of_isSubfieldPositiveCone_from_necSuf F CF hCF 1 F.one_mem one_ne_zero
    rw [mul_one] at h
    exact h
  have h0C : (0 : Qbar) ∉ CF := fun h0 =>
    (hCF.trichotomy 0 (hCF.subset 0 h0)).2.1 ⟨rfl, h0⟩
  have hnec := Ising2DLambda.NecSuf.FisherZero.oddDegree_weightedSquareSum_ne_neg_one_necSuf
    (F : Set Qbar) CF F.zero_mem F.one_mem (fun _ _ ha hb => F.add_mem ha hb)
    (fun _ _ ha hb => F.sub_mem ha hb) (fun _ _ ha hb => F.mul_mem ha hb)
    (fun _ _ ha hb => F.div_mem ha hb) hCF.add_mem hCF.mul_mem h1C h0C hCF.subset
    (fun a ha ha0 => mul_self_mem_of_isSubfieldPositiveCone_from_necSuf F CF hCF a ha ha0)
    (degreeOverSubfield F)
    (fun β => by
      obtain ⟨p, hp, hp0, htop, hpβ⟩ := degreeOverSubfield_spec F β
      exact ⟨p, hp, hp0, htop, by rw [← qbarPolyEval_eq_eval]; exact hpβ⟩)
    (fun β => degreeOverSubfield_hmin F β)
    (fun g m _ hm hgm => by
      have hdeg : g.degree ≠ 0 := by
        intro h0
        have hlow : ((m : ℕ) : WithBot ℕ) ≤ g.degree := Polynomial.le_degree_of_ne_zero hgm
        rw [h0] at hlow
        exact (by omega : ¬ m ≤ 0) (by exact_mod_cast hlow)
      exact IsAlgClosed.exists_root g hdeg)
    n α hαn hodd
  rintro ⟨ι, hι, c, y, hc, hy, hsum⟩
  apply hnec
  refine ⟨ι, hι, c, y, hc, fun i => ?_, hsum⟩
  obtain ⟨g, hg, hgy⟩ := hy i
  exact ⟨g, hg, by rw [← qbarPolyEval_eq_eval]; exact hgy⟩

end Ising2DLambda.FisherZero
