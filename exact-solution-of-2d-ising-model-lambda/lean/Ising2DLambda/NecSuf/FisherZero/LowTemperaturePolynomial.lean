/-
「分配多項式は破れた辺の集合の生成多項式の二倍である」の必要十分版。
必要なのは有限写像の各実現値の原像が二元であり、重みが写像の値だけで決まることだけである。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

theorem sum_eq_two_nsmul_sum_image_necSuf
    {A B M : Type} [DecidableEq B] [AddCommMonoid M]
    (s : Finset A) (g : A → B) (weight : B → M)
    (hfiber : ∀ b ∈ s.image g, (s.filter fun a => g a = b).card = 2) :
    ∑ a ∈ s, weight (g a) = 2 • ∑ b ∈ s.image g, weight b := by
  rw [← sum_fiberwise_of_maps_to'
    (s := s) (t := s.image g) (g := g)
    (fun a ha => mem_image_of_mem g ha) weight]
  calc
    ∑ b ∈ s.image g, ∑ _a ∈ s with g _a = b, weight b
      = ∑ b ∈ s.image g, 2 • weight b := by
          apply sum_congr rfl
          intro b hb
          rw [sum_const, hfiber b hb]
    _ = 2 • ∑ b ∈ s.image g, weight b := by
          exact Finset.sum_nsmul (s.image g) 2 weight

end Ising2DLambda.NecSuf.FisherZero
