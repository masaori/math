/-
具体版の有限添字集合 J と二元性・一意な被覆を必要十分版へ渡す導出版。
二つの定義の述語は展開すると一致する。相手は同じ存在一意条件を満たす元なので、
Lean の証明の無関係性により選択の実装も一致する。
具体版の全単射定理を使わず、必要十分版の両逆から具体版の各主張を得る。
-/
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatching
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- 二元性と各点の一意な被覆が必要十分版の入力を満たす。 -/
theorem perfectMatching_partner_existsUnique_from_necSuf (D : PerfectMatching J) (i : J) :
    ∃! j : J, j ≠ i ∧ ({i, j} : Set J) ∈ D.val := by
  have hD : NecSuf.AlgebraicEigenvalue.IsPerfectMatching D.val :=
    ⟨D.property.1, D.property.2⟩
  exact NecSuf.AlgebraicEigenvalue.perfectMatching_partner_existsUnique ⟨D.val, hD⟩ i

/-- 存在一意条件の二つの定義を展開したときの一致。 -/
theorem perfectMatchingMate_eq_necSuf (D : PerfectMatching J) (i : J) :
    perfectMatchingMate D i =
      NecSuf.AlgebraicEigenvalue.perfectMatchingMate D i := by
  rfl

theorem perfectMatchingMate_ne_from_necSuf (D : PerfectMatching J) (i : J) :
    perfectMatchingMate D i ≠ i := by
  rw [perfectMatchingMate_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.perfectMatchingMate_ne D i

theorem perfectMatchingMate_involutive_from_necSuf (D : PerfectMatching J) :
    Function.Involutive (perfectMatchingMate D) := by
  intro i
  change NecSuf.AlgebraicEigenvalue.perfectMatchingMate D
    (NecSuf.AlgebraicEigenvalue.perfectMatchingMate D i) = i
  exact NecSuf.AlgebraicEigenvalue.perfectMatchingMate_involutive D i

theorem involutionPairs_isPerfectMatching_from_necSuf (τ : FixedPointFreeInvolution J) :
    IsPerfectMatching (involutionPairs τ) := by
  have hτ : (∀ i : J, τ.val i ≠ i) ∧ Function.Involutive τ.val :=
    ⟨τ.property.1, τ.property.2⟩
  exact NecSuf.AlgebraicEigenvalue.involutionPairs_isPerfectMatching ⟨τ.val, hτ⟩

theorem matching_involution_left_inverse_from_necSuf (D : PerfectMatching J) :
    involutionToPerfectMatching (perfectMatchingToInvolution D) = D := by
  change NecSuf.AlgebraicEigenvalue.involutionToPerfectMatching
    (NecSuf.AlgebraicEigenvalue.perfectMatchingToInvolution D) = D
  exact NecSuf.AlgebraicEigenvalue.matching_involution_left_inverse D

theorem matching_involution_right_inverse_from_necSuf (τ : FixedPointFreeInvolution J) :
    perfectMatchingToInvolution (involutionToPerfectMatching τ) = τ := by
  change NecSuf.AlgebraicEigenvalue.perfectMatchingToInvolution
    (NecSuf.AlgebraicEigenvalue.involutionToPerfectMatching τ) = τ
  exact NecSuf.AlgebraicEigenvalue.matching_involution_right_inverse τ

theorem perfectMatchingToInvolution_bijective_from_necSuf :
    Function.Bijective (perfectMatchingToInvolution (J := J)) := by
  change Function.Bijective (NecSuf.AlgebraicEigenvalue.perfectMatchingToInvolution (J := J))
  exact NecSuf.AlgebraicEigenvalue.perfectMatchingToInvolution_bijective

end Ising2DLambda.AlgebraicEigenvalue
