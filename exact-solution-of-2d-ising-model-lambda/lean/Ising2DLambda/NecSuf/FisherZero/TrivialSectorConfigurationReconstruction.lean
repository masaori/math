/-
「自明セクターの偶部分グラフから配位を復元できる」のスピン値域・周期和・横辺差・非境界の縦辺差・個数部分の必要十分版。
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

/-- 横辺を解いた面等式へ同じ横辺を足して消す。必要なのは加法の法則とその横辺の自己和零だけ。 -/
theorem face_pair_necSuf {M : Type*} [AddCommMonoid M]
    (a b c d : M) (hface : d = (a + b) + c) (hdouble : b + b = 0) :
    d + b = c + a := by
  calc
    d + b = ((a + b) + c) + b := congrArg (· + b) hface
    _ = (a + b) + (c + b) := add_assoc _ _ _
    _ = (a + b) + (b + c) := by rw [add_comm c b]
    _ = ((a + b) + b) + c := (add_assoc _ _ _).symm
    _ = (a + (b + b)) + c := by rw [add_assoc a b b]
    _ = (a + 0) + c := by rw [hdouble]
    _ = a + c := by rw [add_zero]
    _ = c + a := add_comm _ _

/-- 隣接二項の望遠鏡和を自然数の帰納法で示す。自己和零は各項にだけ要求し、
環、乗法、逆元、格子を仮定しない。自己和零を外すと中間項が残る。 -/
theorem adjacent_pairs_sum_necSuf {M : Type*} [AddCommMonoid M]
    (f : ℕ → M) (hdouble : ∀ k : ℕ, f k + f k = 0) (m : ℕ) :
    (∑ c ∈ range m, (f (c + 1) + f c)) = f m + f 0 := by
  induction m with
  | zero =>
      calc
        (∑ c ∈ range 0, (f (c + 1) + f c)) = 0 := Finset.sum_range_zero _
        _ = f 0 + f 0 := (hdouble 0).symm
  | succ k ih =>
      calc
        (∑ c ∈ range (k + 1), (f (c + 1) + f c)) =
            (∑ c ∈ range k, (f (c + 1) + f c)) + (f (k + 1) + f k) :=
          Finset.sum_range_succ _ k
        _ = (f k + f 0) + (f (k + 1) + f k) := by rw [ih]
        _ = f k + (f 0 + (f (k + 1) + f k)) := add_assoc _ _ _
        _ = f k + ((f 0 + f (k + 1)) + f k) := by rw [← add_assoc (f 0)]
        _ = f k + (f k + (f 0 + f (k + 1))) := by rw [add_comm (f 0 + f (k + 1)) (f k)]
        _ = (f k + f k) + (f 0 + f (k + 1)) := (add_assoc _ _ _).symm
        _ = 0 + (f 0 + f (k + 1)) := by rw [hdouble k]
        _ = f 0 + f (k + 1) := zero_add _
        _ = f (k + 1) + f 0 := add_comm _ _

/-- 非境界の縦辺差の二十二等号。道和表示、代表の増分、末尾分離、
隣接する横辺二項の表示、端点の評価、重複項の自己和零だけを残す。
周期和零と巻き付き偶奇は使わない。 -/
theorem vertical_path_difference_necSuf {M : Type*} [AddCommMonoid M]
    (pathNext pathCurrent : M) (V v nextRow currentRow f : ℕ → M)
    (n nextN m : ℕ) (initial terminal : M)
    (hpathNext : pathNext = V nextN + ∑ c ∈ range m, nextRow c)
    (hpathCurrent : pathCurrent = V n + ∑ c ∈ range m, currentRow c)
    (hindex : nextN = n + 1) (hsucc : V (n + 1) = V n + v n)
    (hterm : v n = initial) (hdoubleV : V n + V n = 0)
    (hpair : ∀ c : ℕ, nextRow c + currentRow c = f (c + 1) + f c)
    (hdoubleF : ∀ c : ℕ, f c + f c = 0)
    (hterminal : f m = terminal) (hinitial : f 0 = initial) :
    pathNext + pathCurrent = terminal := by
  let Hnext := ∑ c ∈ range m, nextRow c
  let Hcurrent := ∑ c ∈ range m, currentRow c
  have hdoubleInitial : initial + initial = 0 := by rw [← hinitial]; exact hdoubleF 0
  calc
    pathNext + pathCurrent = (V nextN + Hnext) + (V n + Hcurrent) :=
      congrArg₂ (· + ·) hpathNext hpathCurrent
    _ = (V (n + 1) + Hnext) + (V n + Hcurrent) := by rw [hindex]
    _ = ((V n + v n) + Hnext) + (V n + Hcurrent) := by rw [hsucc]
    _ = ((V n + initial) + Hnext) + (V n + Hcurrent) := by rw [hterm]
    _ = (V n + (initial + Hnext)) + (V n + Hcurrent) := by rw [add_assoc (V n) initial]
    _ = V n + ((initial + Hnext) + (V n + Hcurrent)) := add_assoc _ _ _
    _ = V n + (((initial + Hnext) + V n) + Hcurrent) := by rw [← add_assoc (initial + Hnext)]
    _ = V n + ((V n + (initial + Hnext)) + Hcurrent) := by rw [add_comm (initial + Hnext) (V n)]
    _ = V n + (V n + ((initial + Hnext) + Hcurrent)) := by rw [add_assoc (V n) (initial + Hnext)]
    _ = (V n + V n) + ((initial + Hnext) + Hcurrent) := (add_assoc _ _ _).symm
    _ = 0 + ((initial + Hnext) + Hcurrent) := by rw [hdoubleV]
    _ = (initial + Hnext) + Hcurrent := zero_add _
    _ = initial + (Hnext + Hcurrent) := add_assoc _ _ _
    _ = initial + ∑ c ∈ range m, (nextRow c + currentRow c) := by
      dsimp only [Hnext, Hcurrent]
      rw [← Finset.sum_add_distrib]
    _ = initial + ∑ c ∈ range m, (f (c + 1) + f c) :=
      congrArg (initial + ·) (Finset.sum_congr rfl (fun c _ => hpair c))
    _ = initial + (f m + f 0) := congrArg (initial + ·) (adjacent_pairs_sum_necSuf f hdoubleF m)
    _ = initial + (terminal + f 0) := by rw [hterminal]
    _ = initial + (terminal + initial) := by rw [hinitial]
    _ = initial + (initial + terminal) := congrArg (initial + ·) (add_comm _ _)
    _ = (initial + initial) + terminal := (add_assoc _ _ _).symm
    _ = 0 + terminal := by rw [hdoubleInitial]
    _ = terminal := zero_add _

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
