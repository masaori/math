/-
相異な標本点のデータが対象を一意に決める議論の必要十分版。
多項式・有理数・素因数分解を落とし、次の三性質だけを残す。

* データ写像の単射性から評価値の等式を戻せる。
* 評価値が等しい標本点は差の根である。
* 対象が異なるなら、相異な根は `d` 個以下である。
-/
import Mathlib.Data.Fintype.Card

namespace Ising3DCut.NecSuf.NullModel

theorem eq_of_injective_data_at_too_many_points
    {P Q V D : Type*} [DecidableEq Q]
    (eval : P → Q → V) (data : V → D) (hdata_injective : Function.Injective data)
    (RootOfDifference : P → P → Q → Prop)
    (d : ℕ) (q : Fin (d + 1) → Q) (hq_injective : Function.Injective q)
    (A B : P)
    (hroot_of_eval_eq : ∀ x, eval A x = eval B x → RootOfDifference A B x)
    (hroot_card_bound : A ≠ B → ∀ s : Finset Q,
      (∀ x ∈ s, RootOfDifference A B x) → s.card ≤ d)
    (hdata : ∀ i, data (eval A (q i)) = data (eval B (q i))) :
    A = B := by
  have heval : ∀ i, eval A (q i) = eval B (q i) := by
    intro i
    exact hdata_injective (hdata i)
  by_contra hAB
  have hroots : ∀ x ∈ Finset.univ.image q, RootOfDifference A B x := by
    intro x hx
    obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hx
    exact hroot_of_eval_eq (q i) (heval i)
  have hcard := hroot_card_bound hAB (Finset.univ.image q) hroots
  have hpoints : (Finset.univ.image q).card = d + 1 := by
    rw [Finset.card_image_of_injective _ hq_injective, Finset.card_univ, Fintype.card_fin]
  omega

end Ising3DCut.NecSuf.NullModel
