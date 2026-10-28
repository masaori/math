import Mathlib.Logic.Equiv.Basic

namespace Ising2DLambda.NecSuf.KacWard

/- 同じ単射・全射の論法に必要なのは、添字集合とモード・方向の直積の全単射だけである。 -/
def fiberDirectionEquiv {J M D : Type*} (κ : J ≃ M × D) (m : M) :
    {j : J // (κ j).1 = m} ≃ D where
  toFun j := (κ j.1).2
  invFun d := ⟨κ.symm (m, d), by simp⟩
  left_inv j := by
    apply Subtype.ext
    apply κ.injective
    simp only [Equiv.apply_symm_apply]
    rcases j with ⟨j, hj⟩
    exact Prod.ext hj.symm rfl
  right_inv d := by simp

end Ising2DLambda.NecSuf.KacWard
