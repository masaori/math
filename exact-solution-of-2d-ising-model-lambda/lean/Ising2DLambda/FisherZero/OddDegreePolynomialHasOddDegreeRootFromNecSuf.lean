/- 必要十分版を Qbar の部分体と `deg_F` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.OddDegreePolynomialHasOddDegreeRoot
import Ising2DLambda.FisherZero.MinimalVanishingPolynomialDividesFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.OddDegreePolynomialHasOddDegreeRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_qbar_poly_product_top_coefficient` を必要十分版から得る。 -/
theorem qbarPolyProductTopCoeff_from_necSuf (f g : QbarPoly) (a b : ℕ)
    (hf : ∀ k, a < k → f.coeff k = 0) (hg : ∀ k, b < k → g.coeff k = 0) :
    (f * g).coeff (a + b) = f.coeff a * g.coeff b :=
  Ising2DLambda.NecSuf.FisherZero.productTopCoeff_necSuf f g a b hf hg

/-- `claim_odd_degree_polynomial_has_odd_degree_root` を必要十分版から得る。
`deg_F` の証人と最小性は `degreeOverSubfield_spec`・`degreeOverSubfield_hmin`、
根の存在は `def_algebraic_numbers` の第二条件（`IsAlgClosed.exists_root`）から渡す。 -/
theorem oddDegreePolynomial_hasOddDegreeRoot_from_necSuf (F : Subfield Qbar) (n : ℕ)
    (f : QbarPoly) (hf : f ∈ subfieldCoefficientPolynomials F) (hodd : Odd n)
    (hfn : f.coeff n ≠ 0) (hfz : ∀ k : ℕ, n < k → f.coeff k = 0) :
    ∃ β : Qbar, qbarPolyEval β f = 0 ∧ Odd (degreeOverSubfield F β) ∧
      degreeOverSubfield F β ≤ n := by
  obtain ⟨β, hβ, hodd', hle⟩ :=
    Ising2DLambda.NecSuf.FisherZero.oddDegreePolynomial_hasOddDegreeRoot_necSuf (F : Set Qbar)
      F.zero_mem (fun _ _ ha hb => F.add_mem ha hb) (fun _ _ ha hb => F.sub_mem ha hb)
      (fun _ _ ha hb => F.mul_mem ha hb) (fun _ _ ha hb => F.div_mem ha hb)
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
      n f hf hodd hfn hfz
  exact ⟨β, by rw [qbarPolyEval_eq_eval]; exact hβ, hodd', hle⟩

end Ising2DLambda.FisherZero
