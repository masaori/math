import Ising3DCut.CoarseGrainingValuesAgreeStepTwo
import Ising3DCut.NecSuf.CoarseGrainingValuesAgree

/-!
「粗視化の値の一致から $Z_L$ の等式へ」の必要十分版を具体箱型 `Config L`・`ℤ`・`ℚ` へ
特殊化し、具体版の主張を導く。
-/

namespace Ising3DCut.NullModel

theorem allEdgesToRational_multivariatePartitionPolynomial_eq_eval_fromNecSuf (L : ℕ) (q : ℚ) :
    allEdgesToRational q
        (multivariatePartitionPolynomial (fun σ : Config L => brokenSet σ)) =
      evalAtRational q (partitionPolynomial L) :=
  NecSuf.apply_eq_of_eq_comp (allEdgesToRational q) (evalAtRational q)
    allEdgesToOneIndeterminate
    (by
      rw [allEdgesToRational_eq_evalAtRational_comp_allEdgesToOneIndeterminate]
      rfl)
    _ _ (allEdgesToOneIndeterminate_multivariatePartitionPolynomial_eq_partitionPolynomial L)

theorem partitionPolynomial_eval_eq_of_allEdgesToRational_eq_fromNecSuf (L : ℕ) (q q' : ℚ)
    (h : allEdgesToRational q
          (multivariatePartitionPolynomial (fun σ : Config L => brokenSet σ)) =
        allEdgesToRational q'
          (multivariatePartitionPolynomial (fun σ : Config L => brokenSet σ))) :
    evalAtRational q (partitionPolynomial L) = evalAtRational q' (partitionPolynomial L) :=
  NecSuf.values_eq_of_comp_values_eq (allEdgesToRational q) (allEdgesToRational q')
    (evalAtRational q) (evalAtRational q') allEdgesToOneIndeterminate
    (by rw [allEdgesToRational_eq_evalAtRational_comp_allEdgesToOneIndeterminate]; rfl)
    (by rw [allEdgesToRational_eq_evalAtRational_comp_allEdgesToOneIndeterminate]; rfl)
    _ _ (allEdgesToOneIndeterminate_multivariatePartitionPolynomial_eq_partitionPolynomial L) h

end Ising3DCut.NullModel
