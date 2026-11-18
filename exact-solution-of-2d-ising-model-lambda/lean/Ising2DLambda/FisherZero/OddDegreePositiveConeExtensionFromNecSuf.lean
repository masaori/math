/- 必要十分版を Qbar の部分体・その正錐・`deg_F` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.OddDegreePositiveConeExtension
import Ising2DLambda.FisherZero.OddDegreeWeightedSquareSumAvoidsMinusOneFromNecSuf
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.OddDegreePositiveConeExtension

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_odd_degree_positive_cone_extension` を必要十分版から得る。
係数の集合は `F`、正錐は `isSubfieldPositiveCone_iff_from_necSuf` で読み替え、`deg` は `deg_F`
（証人は `degreeOverSubfield_spec`、最小性は `degreeOverSubfield_hmin`）、根の存在は
`def_algebraic_numbers` の第二条件（`IsAlgClosed.exists_root`）、`E` は `Val_F(α)` の台
（所属は定義のとおり `qbarPolyEval_eq_eval` で読み替え、閉性は部分体の閉性）、列挙は
`algebraicNumbersEnumeration` の全射を渡す。 -/
theorem oddDegree_positiveCone_extension_from_necSuf (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) (α : Qbar) (hodd : Odd (degreeOverSubfield F α)) :
    ∃ Cα : Set Qbar, ExtendsPositiveCone F (subfieldPolynomialValuesSubfield F α) CF Cα := by
  obtain ⟨ξ, hξ⟩ := algebraicNumbersEnumeration
  set E : Subfield Qbar := subfieldPolynomialValuesSubfield F α with hE
  obtain ⟨Cα, h⟩ := Ising2DLambda.NecSuf.FisherZero.oddDegree_positiveCone_extension_necSuf
    (F : Set Qbar) CF (E : Set Qbar) F.zero_mem F.one_mem (fun _ _ ha hb => F.add_mem ha hb)
    (fun _ _ ha hb => F.sub_mem ha hb) (fun _ _ ha hb => F.mul_mem ha hb)
    (fun _ _ ha hb => F.div_mem ha hb) ((isSubfieldPositiveCone_iff_from_necSuf F CF).mp hCF)
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
    α hodd
    (fun y => by
      rw [hE, subfieldPolynomialValuesSubfield_coe]
      constructor
      · rintro ⟨g, hg, hgy⟩
        exact ⟨g, hg, by rw [← qbarPolyEval_eq_eval]; exact hgy⟩
      · rintro ⟨g, hg, hgy⟩
        exact ⟨g, hg, by rw [qbarPolyEval_eq_eval]; exact hgy⟩)
    (fun _ _ hx hy => E.add_mem hx hy) (fun _ _ hx hy => E.mul_mem hx hy)
    (fun _ hx => E.neg_mem hx) (fun _ hz _ => E.inv_mem hz)
    ξ (fun z _ => hξ z)
  exact ⟨Cα, (extendsPositiveCone_iff_from_necSuf F E CF Cα).mpr h⟩

end Ising2DLambda.FisherZero
