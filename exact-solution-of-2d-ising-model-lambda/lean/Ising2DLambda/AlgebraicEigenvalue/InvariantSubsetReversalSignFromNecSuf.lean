/-
述語版へ実際の有限集合の所属、自前の整数値の符号、既証の符号法則を供給する。
この節の具体版は呼ばず、反転置換の定義の一致から同じ主張を導く。
-/
import Ising2DLambda.AlgebraicEigenvalue.SelectedOddOrbitReversalFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversalSign
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign sign_comp sign_mul_self)
open Ising2DLambda.NecSuf.KacWard (trichotomous_of_linearOrder)

variable {J : Type*} [Fintype J] [LinearOrder J]

theorem invariantSubsetReversal_sign_from_necSuf (C : Finset J) (σ : Equiv.Perm J)
    (hC : ∀ i : J, σ i ∈ C ↔ i ∈ C) :
    sign (fun i j : J => i < j) (invariantSubsetReversal C σ hC) =
      sign (fun i j : J => i < j) σ := by
  calc
    sign (fun i j : J => i < j) (invariantSubsetReversal C σ hC) =
        sign (fun i j : J => i < j)
          (NecSuf.AlgebraicEigenvalue.invariantPredicateReversal
            (fun i : J => i ∈ C) σ hC) := rfl
    _ = sign (fun i j : J => i < j) σ :=
      NecSuf.AlgebraicEigenvalue.invariantPredicateReversal_sign
        (fun i : J => i ∈ C) (sign (fun i j : J => i < j))
        (sign_comp _ trichotomous_of_linearOrder) (sign_mul_self _)
        mul_assoc one_mul σ hC

theorem selectedOddOrbitReversal_sign_from_necSuf (σ : Equiv.Perm J)
    (hσ : σ ∈ oddOrbitDerangements J) :
    sign (fun i j : J => i < j) (selectedOddOrbitReversal σ hσ.2) =
      sign (fun i j : J => i < j) σ := by
  calc
    sign (fun i j : J => i < j) (selectedOddOrbitReversal σ hσ.2) =
        sign (fun i j : J => i < j)
          (invariantSubsetReversal (selectedOddOrbitFinset σ hσ.2) σ
            (selectedOddOrbitFinset_invariant_from_necSuf σ hσ.2)) := rfl
    _ = sign (fun i j : J => i < j) σ :=
      invariantSubsetReversal_sign_from_necSuf (selectedOddOrbitFinset σ hσ.2) σ
        (selectedOddOrbitFinset_invariant_from_necSuf σ hσ.2)

end Ising2DLambda.AlgebraicEigenvalue
