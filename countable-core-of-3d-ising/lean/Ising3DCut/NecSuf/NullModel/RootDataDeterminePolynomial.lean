/-
「零点と係数データによる多項式の決定」の必要十分版。

反例では対象を区別する観測と、同じ零点データだけを残す。一意性では、
対象が最高次データと重複度込み零点データから同じ有限積へ復元されることだけを残す。
代数的閉体と多項式は、この復元表示を具体化するためにだけ必要である。
-/
import Mathlib

namespace Ising3DCut.NecSuf.NullModel

/-- 同じ零点データを持ちながら別の観測で区別される二組は、零点データだけでは
最高次データも重複度も決められないという二つの反例になる。 -/
theorem rootData_does_not_determine_object_twice
    {Object Observation RootData : Type*}
    (A B C D : Object) (observe : Object → Observation) (rootData : Object → RootData)
    (hobserveAB : observe A ≠ observe B) (hrootsAB : rootData A = rootData B)
    (hobserveCD : observe C ≠ observe D) (hrootsCD : rootData C = rootData D) :
    (A ≠ B ∧ rootData A = rootData B) ∧ (C ≠ D ∧ rootData C = rootData D) := by
  constructor
  · exact ⟨fun h ↦ hobserveAB (congrArg observe h), hrootsAB⟩
  · exact ⟨fun h ↦ hobserveCD (congrArg observe h), hrootsCD⟩

/-- 最高次データと重複度込み零点データから同じ対象へ復元される二対象は等しい。 -/
theorem eq_of_rootData_and_leadingData_eq
    {Object RootData LeadingData : Type*}
    (reconstruct : LeadingData → RootData → Object)
    (F G : Object) (rootsF rootsG : RootData) (leadF leadG : LeadingData)
    (hF : F = reconstruct leadF rootsF) (hG : G = reconstruct leadG rootsG)
    (hroots : rootsF = rootsG) (hlead : leadF = leadG) : F = G := by
  calc
    F = reconstruct leadF rootsF := hF
    _ = reconstruct leadG rootsG := by rw [hlead, hroots]
    _ = G := hG.symm

end Ising3DCut.NecSuf.NullModel
