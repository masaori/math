/-
「自明セクターの偶部分グラフから配位を復元できる」の周期和と個数部分の必要十分版。
周期和では、出発点からの歩みが全点を覆い、一歩で値が変わらないことだけを残す。
自然数の帰納法という人手証明の手順を保ち、格子・有限和・剰余類・標数を仮定しない。
格子・辺・スピンを外し、値を保ち不動点を持たない対を与える写像と、同じ値を持つ元が
その対だけであることだけから、実現された値の原像が二元であることを示す
（写像が対合であることは使わないので仮定しない）。
-/
import Mathlib.Data.Finset.Card

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- 出発点での値と一歩の不変性を、全点を覆う歩みに沿って帰納的に運ぶ。 -/
theorem constant_on_walk_necSuf {X Y : Type*}
    (walk : ℕ → X) (step : X → X) (base : X) (index : X → ℕ)
    (hstart : walk 0 = base)
    (hstep : ∀ n : ℕ, walk (n + 1) = step (walk n))
    (hcover : ∀ x : X, walk (index x) = x)
    (f : X → Y) (value : Y)
    (hbase : f base = value) (hinvariant : ∀ x : X, f (step x) = f x) :
    ∀ x : X, f x = value := by
  have haux : ∀ n : ℕ, f (walk n) = value := by
    intro n
    induction n with
    | zero =>
      calc
        f (walk 0) = f base := congrArg f hstart
        _ = value := hbase
    | succ n ih =>
      calc
        f (walk (n + 1)) = f (step (walk n)) := congrArg f (hstep n)
        _ = f (walk n) := hinvariant (walk n)
        _ = value := ih
  intro x
  calc
    f x = f (walk (index x)) := congrArg f (hcover x).symm
    _ = value := haux (index x)

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
