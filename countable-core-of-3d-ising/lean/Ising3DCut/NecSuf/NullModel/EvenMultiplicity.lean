/-
「不動点のない対合で保たれる有限集合の個数は偶数」の必要十分版。
格子・辺・スピン・破れ数を落とし、有限型上の不動点のない対合だけを仮定する。
証明は二元軌道を作り、互いに素な軌道の合併を有限和で数える。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Fintype.Card

namespace Ising3DCut.NecSuf.NullModel

variable {α : Type*} [Fintype α]

noncomputable section

local instance : DecidableEq α := Classical.decEq _

noncomputable def pairOrbit (f : α → α) (a : α) : Finset α := {a, f a}

noncomputable def pairOrbits (f : α → α) : Finset (Finset α) :=
  Finset.univ.image (pairOrbit f)

lemma pairOrbit_eq_of_mem (f : α → α) (hinv : ∀ a, f (f a) = a) {a b : α}
    (hb : b ∈ pairOrbit f a) : pairOrbit f b = pairOrbit f a := by
  classical
  simp only [pairOrbit, Finset.mem_insert, Finset.mem_singleton] at hb
  rcases hb with rfl | rfl
  · rfl
  · simp only [pairOrbit, hinv]
    exact Finset.pair_comm _ _

lemma pairOrbits_disjoint (f : α → α) (hinv : ∀ a, f (f a) = a) :
    ∀ O ∈ pairOrbits f, ∀ O' ∈ pairOrbits f, O ≠ O' → Disjoint O O' := by
  classical
  intro O hO O' hO' hne
  simp only [pairOrbits, Finset.mem_image] at hO hO'
  obtain ⟨a, _, rfl⟩ := hO
  obtain ⟨b, _, rfl⟩ := hO'
  rw [Finset.disjoint_left]
  intro c hc hc'
  apply hne
  exact (pairOrbit_eq_of_mem f hinv hc).symm.trans (pairOrbit_eq_of_mem f hinv hc')

lemma pairOrbits_biUnion (f : α → α) :
    (pairOrbits f).biUnion (fun O => O) = Finset.univ := by
  classical
  apply Finset.eq_univ_of_forall
  intro a
  rw [Finset.mem_biUnion]
  exact ⟨pairOrbit f a, Finset.mem_image.mpr ⟨a, Finset.mem_univ _, rfl⟩,
    Finset.mem_insert_self _ _⟩

lemma pairOrbit_card (f : α → α) (hne : ∀ a, f a ≠ a) (a : α) :
    (pairOrbit f a).card = 2 := by
  classical
  rw [pairOrbit, Finset.card_pair]
  exact (hne a).symm

/-- 必要十分版の主定理。 -/
theorem card_eq_two_mul_of_fixedPointFree_involution (f : α → α)
    (hinv : ∀ a, f (f a) = a) (hne : ∀ a, f a ≠ a) :
    ∃ k : ℕ, Fintype.card α = 2 * k := by
  classical
  refine ⟨(pairOrbits f).card, ?_⟩
  rw [← Finset.card_univ, ← pairOrbits_biUnion f,
    Finset.card_biUnion (pairOrbits_disjoint f hinv)]
  rw [show ∑ O ∈ pairOrbits f, O.card = ∑ _O ∈ pairOrbits f, 2 by
    apply Finset.sum_congr rfl
    intro O hO
    simp only [pairOrbits, Finset.mem_image] at hO
    obtain ⟨a, _, rfl⟩ := hO
    exact pairOrbit_card f hne a]
  rw [Finset.sum_const]
  simp [Nat.mul_comm]

end

end Ising3DCut.NecSuf.NullModel
