/-
必要十分版: 相異なる列の二項が同じ台を持つとき、その二項が反転対に限られるなら、
反転対を含まない列の台は相異なる。

人手証明からトーラス、置換、非後退性を除き、台写像、反転写像、列の相異性、
同じ台を持つ二項の二分法だけを残す。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 相異なる項からなり反転対を含まない有限区間の列では、台も相異なる。 -/
theorem reversalFreeProjectedSequence_distinct_necSuf
    {A B : Type*} (u : ℕ → A) (base : A → B) (reverse : A → A) (r : ℕ)
    (hdistinct : ∀ i j, i < r → j < r → i ≠ j → u i ≠ u j)
    (hcollision : ∀ a b, base a = base b → a = b ∨ reverse a = b)
    (hfree : ∀ i j, i < r → j < r → reverse (u i) ≠ u j) :
    ∀ i j, i < r → j < r → base (u i) = base (u j) → i = j := by
  intro i j hir hjr hbase
  by_contra hij
  rcases hcollision (u i) (u j) hbase with hs | hr
  · exact hdistinct i j hir hjr hij hs
  · exact hfree i j hir hjr hr

end Ising2DLambda.NecSuf.KacWard
