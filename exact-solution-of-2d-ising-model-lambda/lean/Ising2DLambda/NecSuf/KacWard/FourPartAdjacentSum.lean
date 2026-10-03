/-
四部分の循環隣接和の分割の必要十分版。
値の有限和に可換加法モノイドを使う。歩の型には構造を要求せず、
重みにも対角零・反対称性・双線形性を要求しない。
各列の非空性は先頭と末尾、および接合項を指定するために必要である。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

def joinDirectionSequence {α : Type*} (u v : ℕ → α) (a j : ℕ) : α :=
  if j < a then u j else v (j - a)

def internalAdjacentSum {α M : Type*} [AddCommMonoid M]
    (weight : α → α → M) (n : ℕ) (u : ℕ → α) : M :=
  ∑ j ∈ Finset.range (n - 1), weight (u j) (u (j + 1))

/-- 二列の内部和を、前半の内部・接合・後半の内部へ分割する。 -/
theorem internalAdjacentSum_join_necSuf {α M : Type*} [AddCommMonoid M]
    (weight : α → α → M) (u v : ℕ → α) (a b : ℕ)
    (ha : 0 < a) (hb : 0 < b) :
    internalAdjacentSum weight (a + b) (joinDirectionSequence u v a) =
      internalAdjacentSum weight a u + weight (u (a - 1)) (v 0) +
        internalAdjacentSum weight b v := by
  let z := joinDirectionSequence u v a
  have hsplit (f : ℕ → M) :
      (∑ j ∈ Finset.range (a + b - 1), f j) =
        ((∑ j ∈ Finset.range (a - 1), f j) + f (a - 1)) +
          ∑ j ∈ Finset.range (b - 1), f (a + j) := by
    rw [show a + b - 1 = a + (b - 1) by omega, Finset.sum_range_add]
    have hfirst : (∑ j ∈ Finset.range a, f j) =
        (∑ j ∈ Finset.range (a - 1), f j) + f (a - 1) := by
      have hlength : a - 1 + 1 = a := by omega
      simpa only [hlength] using Finset.sum_range_succ f (a - 1)
    rw [hfirst]
  have hprefix : (∑ j ∈ Finset.range (a - 1), weight (z j) (z (j + 1))) =
      internalAdjacentSum weight a u := by
    apply Finset.sum_congr rfl
    intro j hj
    have hj' := Finset.mem_range.mp hj
    simp only [z, joinDirectionSequence, if_pos (show j < a by omega),
      if_pos (show j + 1 < a by omega)]
  have hboundary : weight (z (a - 1)) (z (a - 1 + 1)) =
      weight (u (a - 1)) (v 0) := by
    simp [z, joinDirectionSequence, show a - 1 < a by omega,
      show a - 1 + 1 = a by omega]
  have htail : (∑ j ∈ Finset.range (b - 1), weight (z (a + j)) (z (a + j + 1))) =
      internalAdjacentSum weight b v := by
    apply Finset.sum_congr rfl
    intro j _
    simp [z, joinDirectionSequence, show ¬a + j < a by omega,
      show ¬a + j + 1 < a by omega, show a + j + 1 - a = j + 1 by omega]
  calc
    internalAdjacentSum weight (a + b) z =
        ((∑ j ∈ Finset.range (a - 1), weight (z j) (z (j + 1))) +
          weight (z (a - 1)) (z (a - 1 + 1))) +
          ∑ j ∈ Finset.range (b - 1), weight (z (a + j)) (z (a + j + 1)) :=
      hsplit (fun j => weight (z j) (z (j + 1)))
    _ = internalAdjacentSum weight a u + weight (u (a - 1)) (v 0) +
        internalAdjacentSum weight b v := by rw [hprefix, hboundary, htail]

/-- 二列の分割を三回適用し、最後に閉じる接合を加える。 -/
theorem fourPart_cyclicAdjacentSum_necSuf {α M : Type*} [AddCommMonoid M]
    (weight : α → α → M) (u v w x : ℕ → α) (a b c d : ℕ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (hd : 0 < d) :
    let uv := joinDirectionSequence u v a
    let uvw := joinDirectionSequence uv w (a + b)
    let z := joinDirectionSequence uvw x (a + b + c)
    internalAdjacentSum weight (a + b + c + d) z +
        weight (z (a + b + c + d - 1)) (z 0) =
      internalAdjacentSum weight a u + weight (u (a - 1)) (v 0) +
      internalAdjacentSum weight b v + weight (v (b - 1)) (w 0) +
      internalAdjacentSum weight c w + weight (w (c - 1)) (x 0) +
      internalAdjacentSum weight d x + weight (x (d - 1)) (u 0) := by
  dsimp only
  have huv : joinDirectionSequence u v a (a + b - 1) = v (b - 1) := by
    simp [joinDirectionSequence, show ¬a + b - 1 < a by omega,
      show a + b - 1 - a = b - 1 by omega]
  have huvw : joinDirectionSequence (joinDirectionSequence u v a) w (a + b)
      (a + b + c - 1) = w (c - 1) := by
    simp [joinDirectionSequence, show ¬a + b + c - 1 < a + b by omega,
      show a + b + c - 1 - (a + b) = c - 1 by omega]
  have hlast : joinDirectionSequence
      (joinDirectionSequence (joinDirectionSequence u v a) w (a + b)) x
      (a + b + c) (a + b + c + d - 1) = x (d - 1) := by
    simp [joinDirectionSequence, show ¬a + b + c + d - 1 < a + b + c by omega,
      show a + b + c + d - 1 - (a + b + c) = d - 1 by omega]
  rw [internalAdjacentSum_join_necSuf weight _ x _ d (by omega) hd]
  rw [internalAdjacentSum_join_necSuf weight _ w _ c (by omega) hc]
  rw [internalAdjacentSum_join_necSuf weight u v a b ha hb]
  rw [huv, huvw, hlast]
  simp [joinDirectionSequence, ha, show 0 < a + b by omega,
    add_assoc]

end Ising2DLambda.NecSuf.KacWard
