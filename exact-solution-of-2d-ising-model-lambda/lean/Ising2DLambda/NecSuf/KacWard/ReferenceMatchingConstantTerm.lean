/-
「基準マッチングの長い標識の項は一である」の必要十分版。
具体版と同じ三段（端点列が昇順の全元列に一致することによる符号、重みの指数の消去、
長い寄与と項の積）を、次の一般の対象で行う。

* 列挙の段: 任意の有限線型順序 J の全元を含む狭義増加列。
  完全マッチングと符号は使わず、その列が昇順の全元列に一致することだけを示す。
* 重みの段: 可換な零付き群 G、z ≠ 0、指数 p q : E → ℤ と二元 e f。
  仮定は q f = q e と p f = p e − 2 だけで、z⁴ = −1 も反転の対合性も使わない。
  z ≠ 0 は整数冪の加法則 `zpow_add₀` に要る。p f = p e − 2 を外すと指数 2 − p e + p f が零にならない。
* 項の段: 可換環 K・R と環準同型 C : K → R、符号 σ ∈ ℤ が一であること、有限型 I から対の型 X への
  単射 a で対の集合 P がその像であること、各 a i で長い寄与の条件が成り立ち重みが一であること。
  a の単射性は P 上の積を I 上の積へ移すのに要る。
-/
import Ising2DLambda.NecSuf.KacWard.PermutationSignOrbitProduct
import Mathlib.Data.List.Sort
import Mathlib.Data.Finset.Sort
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.GroupWithZero.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Ring.Hom.Defs
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 全元を含む狭義増加列は、順序だけで定まる昇順の全元列である。 -/
theorem sorted_complete_word_eq_base {J : Type*} [Fintype J] [LinearOrder J]
    (w : List J) (hs : w.SortedLT) (hc : ∀ x : J, x ∈ w) :
    w = Finset.univ.sort (· ≤ ·) := by
  exact hs.eq_of_mem_iff (Finset.sortedLT_sort univ)
    (fun x => iff_of_true (hc x) (by simp))

/-- 重みの段。z² (z^{-q e} z^{-p e}) (z^{p f} z^{q f}) = z^{2 - p e + p f} = z⁰ = 1。 -/
theorem reference_pair_weight_necSuf {G E : Type*} [CommGroupWithZero G]
    (z : G) (hz : z ≠ 0) (p q : E → ℤ) (e f : E)
    (hq : q f = q e) (hp : p f = p e - 2) :
    z ^ (2 : ℕ) * ((z ^ (-q e) * z ^ (-p e)) * (z ^ p f * z ^ q f)) = 1 := by
  calc
    z ^ (2 : ℕ) * ((z ^ (-q e) * z ^ (-p e)) * (z ^ p f * z ^ q f)) =
        z ^ (2 : ℕ) * ((z ^ (-q e) * z ^ (-p e)) * (z ^ p f * z ^ q e)) := by rw [hq]
    _ = z ^ ((2 : ℤ) - p e + p f) := by
      rw [← zpow_natCast z 2, ← zpow_add₀ hz (-q e), ← zpow_add₀ hz (p f), ← zpow_add₀ hz,
        ← zpow_add₀ hz]
      congr 1
      push_cast
      ring
    _ = z ^ (0 : ℤ) := by
      congr 1
      rw [hp]
      ring
    _ = 1 := zpow_zero z

/-- 項の段。符号 C(σ) と、像の上の長い寄与 C(w) の積は一である。 -/
theorem reference_term_necSuf {K R X I : Type*} [CommRing K] [CommRing R] [Fintype I]
    [DecidableEq X] (C : K →+* R) (σ : ℤ) (hσ : σ = 1)
    (P : Finset X) (a : I → X) (ha : Function.Injective a) (hP : P = univ.image a)
    (cond : X → Prop) [DecidablePred cond] (w : X → K) (g : X → R)
    (hcond : ∀ i, cond (a i)) (hw : ∀ i, w (a i) = 1) :
    C (σ : K) * ((-1 : R) ^ (∅ : Finset X).card *
        (∏ x ∈ P \ ∅, C (if cond x then w x else 0)) * (∏ x ∈ (∅ : Finset X), g x)) = 1 := by
  have hlong : ∀ i, C (if cond (a i) then w (a i) else 0) = 1 := fun i => by
    calc
      C (if cond (a i) then w (a i) else 0) = C (w (a i)) := by rw [if_pos (hcond i)]
      _ = C 1 := by rw [hw i]
      _ = 1 := map_one C
  calc
    C (σ : K) * ((-1 : R) ^ (∅ : Finset X).card *
        (∏ x ∈ P \ ∅, C (if cond x then w x else 0)) * (∏ x ∈ (∅ : Finset X), g x)) =
        C (σ : K) * ∏ i : I, C (if cond (a i) then w (a i) else 0) := by
      rw [card_empty, pow_zero, sdiff_empty, prod_empty, one_mul, mul_one, hP,
        prod_image (fun x _ y _ h => ha h)]
    _ = C ((1 : ℤ) : K) * ∏ _i : I, (1 : R) := by
      rw [hσ]
      congr 1
      exact Finset.prod_congr rfl fun i _ => hlong i
    _ = 1 := by simp

end Ising2DLambda.NecSuf.KacWard
