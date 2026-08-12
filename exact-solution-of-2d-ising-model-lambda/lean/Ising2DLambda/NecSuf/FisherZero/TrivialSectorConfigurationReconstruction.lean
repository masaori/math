/-
「自明セクターの偶部分グラフから配位を復元できる」の個数部分の必要十分版。
格子・辺・スピンを外し、値を保ち不動点を持たない対を与える写像と、同じ値を持つ元が
その対だけであることだけから、実現された値の原像が二元であることを示す
（写像が対合であることは使わないので仮定しない）。
-/
import Mathlib.Data.Finset.Card

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

theorem paired_fiber_card_two_necSuf {α β : Type*}
    [Fintype α] [DecidableEq α] [DecidableEq β]
    (g : α → β) (ν : α → α) (x : α)
    (hne : ν x ≠ x)
    (hpreserve : g (ν x) = g x)
    (hunique : ∀ y : α, g y = g x → y = x ∨ y = ν x) :
    (univ.filter fun y : α => g y = g x).card = 2 := by
  have hfiber :
      univ.filter (fun y : α => g y = g x) = {x, ν x} := by
    ext y
    simp only [mem_filter, mem_univ, true_and, mem_insert, mem_singleton]
    constructor
    · exact hunique y
    · intro hy
      rcases hy with rfl | rfl
      · rfl
      · exact hpreserve
  rw [hfiber, card_insert_of_notMem]
  · rw [card_singleton]
  · simpa using hne.symm

end Ising2DLambda.NecSuf.FisherZero
