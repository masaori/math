/-
有理係数多項式の具体版が必要十分版の特殊化として得られることの明示。
人手証明と同じく、データの単射性、差多項式の根、根の個数と次数の比較をこの順に渡す。
-/
import Ising3DCut.NullModel.RationalValuesDeterminePartitionPolynomial
import Ising3DCut.NecSuf.NullModel.RationalValuesDeterminePartitionPolynomial

namespace Ising3DCut.NullModel

noncomputable section

/-- `claim_rational_values_determine_partition_polynomial` の具体版を必要十分版から導いたもの。 -/
theorem rationalPolynomial_eq_of_primeExponentData_eq_from_necSuf {D : Type*}
    (primeExponentData : ℚ → D) (hdata_injective : Function.Injective primeExponentData)
    (d : ℕ) (q : Fin (d + 1) → ℚ) (hq_injective : Function.Injective q)
    (A B : Polynomial ℚ) (hA_degree : A.natDegree ≤ d) (hB_degree : B.natDegree ≤ d)
    (hdata : ∀ i, primeExponentData (A.eval (q i)) = primeExponentData (B.eval (q i))) :
    A = B := by
  apply NecSuf.NullModel.eq_of_injective_data_at_too_many_points
    (fun P x ↦ P.eval x) primeExponentData hdata_injective
    (fun A B x ↦ (A - B).IsRoot x) d q hq_injective A B
  · intro x heval
    change (A - B).eval x = 0
    rw [Polynomial.eval_sub]
    exact sub_eq_zero.mpr heval
  · intro hAB s hroots
    apply (Polynomial.card_le_degree_of_subset_roots ?_).trans
      ((Polynomial.natDegree_sub_le A B).trans (max_le hA_degree hB_degree))
    intro x hx
    rw [Polynomial.mem_roots (sub_ne_zero.mpr hAB)]
    exact hroots x hx
  · exact hdata

end

end Ising3DCut.NullModel
