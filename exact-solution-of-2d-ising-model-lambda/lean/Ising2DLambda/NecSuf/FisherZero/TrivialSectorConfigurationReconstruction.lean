/-
「自明セクターの偶部分グラフから配位を復元できる」のスピン値域・周期和・横辺差・個数部分の必要十分版。
周期和では、出発点からの歩みが全点を覆い、一歩で値が変わらないことだけを残す。
自然数の帰納法という人手証明の手順を保ち、格子・有限和・剰余類・標数を仮定しない。
格子・辺・スピンを外し、値を保ち不動点を持たない対を与える写像と、同じ値を持つ元が
その対だけであることだけから、実現された値の原像が二元であることを示す
（写像が対合であることは使わないので仮定しない）。
-/
import Mathlib.Data.Finset.Card
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- 周期境界では末尾の和へ一項を足すと周期和となる。使うのは加法モノイドの法則と、
二点の道和表示、次の代表が零であること、末尾分離、周期和零、基点と末尾項の自己和零だけ。
自己和零はそれぞれ二重の基点と末尾項を消すため、周期和零は末尾の和を一項へ戻すために要る。
交換則、逆元、環、格子は使わない。 -/
theorem periodic_path_prefix_difference_necSuf {X M : Type*} [AddMonoid M]
    (path : X → M) (index : X → ℕ) (partialSum f : ℕ → M) (base : M)
    (x y : X) (length : ℕ)
    (hpathX : path x = base + partialSum (index x))
    (hpathY : path y = base + partialSum (index y))
    (hindex : index y = 0) (hlast : index x + 1 = length)
    (hzero : partialSum 0 = 0)
    (hsucc : partialSum (index x + 1) = partialSum (index x) + f (index x))
    (hperiod : partialSum length = 0)
    (hbase : base + base = 0) (hterm : f (index x) + f (index x) = 0) :
    path y + path x = f (index x) := by
  have hprefix : partialSum (index x) = f (index x) := by
    calc
      partialSum (index x) = partialSum (index x) + 0 := (add_zero _).symm
      _ = partialSum (index x) + (f (index x) + f (index x)) :=
        congrArg (partialSum (index x) + ·) hterm.symm
      _ = (partialSum (index x) + f (index x)) + f (index x) :=
        (add_assoc _ _ _).symm
      _ = partialSum (index x + 1) + f (index x) :=
        congrArg (· + f (index x)) hsucc.symm
      _ = partialSum length + f (index x) := by rw [hlast]
      _ = 0 + f (index x) := congrArg (· + f (index x)) hperiod
      _ = f (index x) := zero_add _
  calc
    path y + path x = (base + partialSum (index y)) + (base + partialSum (index x)) :=
      congrArg₂ (· + ·) hpathY hpathX
    _ = (base + partialSum 0) + (base + partialSum (index x)) := by rw [hindex]
    _ = (base + 0) + (base + partialSum (index x)) := by rw [hzero]
    _ = base + (base + partialSum (index x)) := by rw [add_zero]
    _ = (base + base) + partialSum (index x) := (add_assoc _ _ _).symm
    _ = 0 + partialSum (index x) := congrArg (· + partialSum (index x)) hbase
    _ = partialSum (index x) := zero_add _
    _ = f (index x) := hprefix

/-- 非境界の道和差は、添字が一つ増すことと、加法の結合・交換・零元、
重複する道和の自己和が零であることだけを使う。格子、環、乗法、逆元は不要である。
自己和の仮定を外すと、例えば自然数の加法で重複する道和が残る。 -/
theorem path_prefix_difference_necSuf {X M : Type*} [AddCommMonoid M]
    (path : X → M) (index : X → ℕ) (f : ℕ → M) (base : M) (x y : X)
    (hpathX : path x = base + ∑ c ∈ range (index x), f c)
    (hpathY : path y = base + ∑ c ∈ range (index y), f c)
    (hindex : index y = index x + 1)
    (hdouble : (base + ∑ c ∈ range (index x), f c) +
      (base + ∑ c ∈ range (index x), f c) = 0) :
    path y + path x = f (index x) := by
  let H : ℕ → M := fun m => ∑ c ∈ range m, f c
  calc
    path y + path x = (base + H (index y)) + (base + H (index x)) :=
      congrArg₂ (· + ·) hpathY hpathX
    _ = (base + H (index x + 1)) + (base + H (index x)) := by rw [hindex]
    _ = (base + (H (index x) + f (index x))) + (base + H (index x)) := by
      rw [show H (index x + 1) = H (index x) + f (index x) from
        Finset.sum_range_succ f (index x)]
    _ = ((base + H (index x)) + f (index x)) + (base + H (index x)) := by
      rw [← add_assoc base (H (index x)) (f (index x))]
    _ = (base + H (index x)) + (f (index x) + (base + H (index x))) :=
      add_assoc _ _ _
    _ = (base + H (index x)) + ((base + H (index x)) + f (index x)) :=
      congrArg ((base + H (index x)) + ·) (add_comm (f (index x)) (base + H (index x)))
    _ = ((base + H (index x)) + (base + H (index x))) + f (index x) :=
      (add_assoc _ _ _).symm
    _ = 0 + f (index x) := congrArg (· + f (index x)) hdouble
    _ = f (index x) := zero_add _

/-- 指数の二場合を、それぞれの値へ代入する本文と同じ計算。
必要なのは代表が零か一であることと、評価写像のその二点での値だけである。
格子・剰余環・整数・乗法の構造は使わない。二場合の仮定を外すと他の指数の値を制限できない。 -/
theorem two_exponent_values_necSuf {M : Type*}
    (evaluate : ℕ → M) (zeroValue oneValue : M) (n : ℕ)
    (hcases : n = 0 ∨ n = 1)
    (hzero : evaluate 0 = zeroValue) (hone : evaluate 1 = oneValue) :
    evaluate n = zeroValue ∨ evaluate n = oneValue := by
  rcases hcases with hqzero | hqone
  · left
    calc
      evaluate n = evaluate 0 := congrArg evaluate hqzero
      _ = zeroValue := hzero
  · right
    calc
      evaluate n = evaluate 1 := congrArg evaluate hqone
      _ = oneValue := hone

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
