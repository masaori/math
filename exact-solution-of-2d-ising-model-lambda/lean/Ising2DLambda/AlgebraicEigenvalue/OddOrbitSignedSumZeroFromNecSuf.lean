/-
有限相殺の必要十分版へ、選んだ奇数軌道の対合と符号付き項を供給する。
対合性・不動点の不在・項の符号反転は、それぞれ既存の導出版から得る。
-/
import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitReversalNontrivialFromNecSuf
import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitSkewProductNegFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OddOrbitSignedSumZero

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)

theorem oddOrbit_signed_sum_zero_from_necSuf
    {J : Type*} [Fintype J] [LinearOrder J]
    (A : Matrix J J (Polynomial Qbar)) (hA : ∀ i j, A j i = -A i j) :
    (∑ σ : {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J},
      Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
        ∏ i : J, A i (σ.val i)) = 0 := by
  classical
  let D := {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J}
  let w : D → Polynomial Qbar := fun σ =>
    Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
      ∏ i : J, A i (σ.val i)
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.involution_neg_sum_zero
    add_neg_cancel selectedOddOrbitInvolution
    selectedOddOrbitInvolution_twice_from_necSuf
    selectedOddOrbitInvolution_no_fixed_from_necSuf w
    (fun σ => selectedOddOrbit_skew_signed_term_neg_from_necSuf A hA σ.val σ.property)

end Ising2DLambda.AlgebraicEigenvalue
