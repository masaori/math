/-
「接触対数の整礎帰納は台の辺が相異なる閉歩道を頂点単純な閉路族へ分ける」の具体版。
人手証明と同じく、接触対数が正なら接触点で二分し、台の辺の目録と二つの
切断線偶奇を保存する一歩を、接触対数についての累積帰納で繰り返す。
-/
import Ising2DLambda.NecSuf.KacWard.ContactEliminationBySplitting

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem contact_elimination_by_splitting {W E : Type}
    (contactCount : W → ℕ) (baseEdges : W → Multiset E)
    (horizontalParity verticalParity : W → ℕ)
    (split : ∀ γ : W, 0 < contactCount γ → ∃ γA γB : W,
      contactCount γA + contactCount γB < contactCount γ ∧
      baseEdges γA + baseEdges γB = baseEdges γ ∧
      (horizontalParity γA + horizontalParity γB) % 2 = horizontalParity γ % 2 ∧
      (verticalParity γA + verticalParity γB) % 2 = verticalParity γ % 2) :
    ∀ γ : W, ∃ family : List W,
      family ≠ [] ∧
      (∀ δ ∈ family, contactCount δ = 0) ∧
      (family.map baseEdges).sum = baseEdges γ ∧
      (family.map horizontalParity).sum % 2 = horizontalParity γ % 2 ∧
      (family.map verticalParity).sum % 2 = verticalParity γ % 2 :=
  contact_elimination_by_splitting_necSuf
    contactCount baseEdges horizontalParity verticalParity split

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem contact_elimination_by_splitting_from_necSuf {W E : Type}
    (contactCount : W → ℕ) (baseEdges : W → Multiset E)
    (horizontalParity verticalParity : W → ℕ)
    (split : ∀ γ : W, 0 < contactCount γ → ∃ γA γB : W,
      contactCount γA + contactCount γB < contactCount γ ∧
      baseEdges γA + baseEdges γB = baseEdges γ ∧
      (horizontalParity γA + horizontalParity γB) % 2 = horizontalParity γ % 2 ∧
      (verticalParity γA + verticalParity γB) % 2 = verticalParity γ % 2) :
    ∀ γ : W, ∃ family : List W,
      family ≠ [] ∧
      (∀ δ ∈ family, contactCount δ = 0) ∧
      (family.map baseEdges).sum = baseEdges γ ∧
      (family.map horizontalParity).sum % 2 = horizontalParity γ % 2 ∧
      (family.map verticalParity).sum % 2 = verticalParity γ % 2 :=
  contact_elimination_by_splitting
    contactCount baseEdges horizontalParity verticalParity split

end Ising2DLambda.KacWard
