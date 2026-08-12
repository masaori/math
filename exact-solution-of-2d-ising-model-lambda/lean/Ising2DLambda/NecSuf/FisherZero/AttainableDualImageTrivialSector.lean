/-
像として得られる対象の全体と適格な対象の全体が一致するための必要十分な組み立て。
具体版の両包含と同じく、順方向の適格性と逆方向の原像の存在だけを使う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

theorem image_eq_admissible_filter_necSuf {α β : Type*} [Fintype β] [DecidableEq β]
    (source : Finset α) (map : α → β) (admissible : β → Prop) [DecidablePred admissible]
    (hforward : ∀ x ∈ source, admissible (map x))
    (hbackward : ∀ y, admissible y → ∃ x ∈ source, map x = y) :
    source.image map = univ.filter admissible := by
  classical
  ext y
  simp only [mem_image, mem_filter, mem_univ, true_and]
  constructor
  · rintro ⟨x, hx, rfl⟩
    exact hforward x hx
  · intro hy
    obtain ⟨x, hx, hxy⟩ := hbackward y hy
    exact ⟨x, hx, hxy⟩

end Ising2DLambda.NecSuf.FisherZero
