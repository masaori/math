/-
「忠実な作用が不動点のない対合と可換すれば、二元対を保つ置換群へ埋め込まれる」
の必要十分版。多項式・根・分解体・体構造を落とし、群作用、忠実性、対合との可換性だけを残す。
-/
import Mathlib.GroupTheory.GroupAction.Basic

namespace Ising3DCut.NecSuf.NullModel

variable {H A : Type*} [Group H]

/-- 必要十分版の主定理。

忠実性は結論の単射性に必要であり、可換性は像が二元対を保つために必要である。
対合性と不動点不存在は二元対そのものを与える性質であり、埋め込みの構成では使わない。 -/
theorem embeds_in_pairPermutations
    (action : H →* Equiv.Perm A) (reciprocal : A → A)
    (_hinvolution : ∀ a, reciprocal (reciprocal a) = a)
    (_hfixedPointFree : ∀ a, reciprocal a ≠ a)
    (hfaithful : ∀ g h : H, (∀ a, action g a = action h a) → g = h)
    (hcommutes : ∀ g a, action g (reciprocal a) = reciprocal (action g a)) :
    ∃ φ : H →* Equiv.Perm A,
      Function.Injective φ ∧ ∀ g a, φ g (reciprocal a) = reciprocal (φ g a) := by
  refine ⟨action, ?_, hcommutes⟩
  intro g h hgh
  apply hfaithful g h
  intro a
  exact DFunLike.congr_fun hgh a

end Ising3DCut.NecSuf.NullModel
