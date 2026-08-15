/-
「開境界自由エネルギー密度の値集合の下限の存在（t が 1 以下の場合）」の必要十分版。

格子・自由エネルギー密度・実数を外し、添字付き値集合の証人、一様下界、順序を反転する対合、
および空でない上に有界な集合へ上限を与える性質だけを残す。人手証明どおり、値集合を反転して
上限を取り、反転して戻す。順序の反射律・推移律・反対称律は使わない。
-/
import Mathlib.Order.Bounds.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 添字付きの値集合が下限を持つために、人手証明が実際に使う仮定だけを並べた形。 -/
theorem indexedValueSet_has_infimum_necSuf
    {I A : Type} [LE A]
    (value : I → A) (witness : I) (lower : A)
    (neg : A → A)
    (negAntitone : ∀ {a b : A}, a ≤ b → neg b ≤ neg a)
    (negNeg : ∀ a : A, neg (neg a) = a)
    (pointwiseLower : ∀ i : I, lower ≤ value i)
    (hasSupremum : ∀ S : Set A, S.Nonempty → BddAbove S → ∃ s : A, IsLUB S s) :
    ∃ v : A, IsGLB (Set.range value) v := by
  -- 反転した集合 `-Ψ`
  let negated : Set A := neg '' Set.range value
  have hnonempty : negated.Nonempty := ⟨neg (value witness), ⟨value witness, ⟨witness, rfl⟩, rfl⟩⟩
  have hbounded : BddAbove negated := by
    refine ⟨neg lower, ?_⟩
    rintro z ⟨y, ⟨i, rfl⟩, rfl⟩
    exact negAntitone (pointwiseLower i)
  obtain ⟨u, hu⟩ := hasSupremum negated hnonempty hbounded
  refine ⟨neg u, ?_, ?_⟩
  · -- `-u` は下界である
    rintro y ⟨i, rfl⟩
    have hmem : neg (value i) ∈ negated := ⟨value i, ⟨i, rfl⟩, rfl⟩
    have h := negAntitone (hu.1 hmem)
    rw [negNeg] at h
    exact h
  · -- 任意の下界 `m` は `-u` 以下である
    intro m hm
    have hupper : neg m ∈ upperBounds negated := by
      rintro z ⟨y, hy, rfl⟩
      exact negAntitone (hm hy)
    have h := negAntitone (hu.2 hupper)
    rw [negNeg] at h
    exact h

end Ising2DLambda.NecSuf.ThermodynamicLimit
