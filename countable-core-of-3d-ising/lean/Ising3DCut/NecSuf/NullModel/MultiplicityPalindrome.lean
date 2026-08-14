/-
「多重度は回文である」の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質                         なぜ削れないか
  `Fintype α`                            二つの水準集合の元の個数を数えるため。
  `f (f a) = a`                          順写像と逆写像を互いに逆にするため。
  `weight (f a) = total - weight a`       一方の水準集合を補数側へ送るため。
  `m ≤ total`                            `total - (total - m) = m` と戻すため。

証明手順は具体版と同じ（水準集合間の二写像を作り、対合性から互いに逆と示し、
全単射で結ばれた有限型の元の個数を等置する）。

住処: 任意の有限型と自然数のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Data.Fintype.EquivFin

namespace Ising3DCut.NecSuf.NullModel

variable {α : Type*} [Fintype α]

/-- 重みが `m` である元の有限集合。 -/
def fiberFinset (weight : α → ℕ) (m : ℕ) : Finset α :=
  Finset.univ.filter fun a => weight a = m

/-- 重みが `m` である元の有限型。 -/
def Fiber (weight : α → ℕ) (m : ℕ) := ↥(fiberFinset weight m)

instance (weight : α → ℕ) (m : ℕ) : Fintype (Fiber weight m) :=
  inferInstanceAs (Fintype ↥(fiberFinset weight m))

/-- 対合が重みを補数へ送るとき、二つの水準集合は全単射で結ばれる。 -/
def fiberComplementEquiv (f : α → α) (weight : α → ℕ) (total m : ℕ)
    (hf : ∀ a, f (f a) = a)
    (hw : ∀ a, weight (f a) = total - weight a)
    (hm : m ≤ total) :
    Fiber weight m ≃ Fiber weight (total - m) where
  toFun a := ⟨f a.1, by
    have ha : weight a.1 = m := (Finset.mem_filter.mp a.2).2
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by rw [hw, ha]⟩
  ⟩
  invFun b := ⟨f b.1, by
    have hb : weight b.1 = total - m := (Finset.mem_filter.mp b.2).2
    apply Finset.mem_filter.mpr
    exact ⟨Finset.mem_univ _, by rw [hw, hb, Nat.sub_sub_self hm]⟩
  ⟩
  left_inv a := Subtype.ext (hf a.1)
  right_inv b := Subtype.ext (hf b.1)

/-- 全単射で結ばれた二つの重み水準の元の個数は等しい。 -/
theorem card_fiber_complement (f : α → α) (weight : α → ℕ) (total m : ℕ)
    (hf : ∀ a, f (f a) = a)
    (hw : ∀ a, weight (f a) = total - weight a)
    (hm : m ≤ total) :
    Fintype.card (Fiber weight m) = Fintype.card (Fiber weight (total - m)) := by
  exact Fintype.card_congr (fiberComplementEquiv f weight total m hf hw hm)

end Ising3DCut.NecSuf.NullModel
