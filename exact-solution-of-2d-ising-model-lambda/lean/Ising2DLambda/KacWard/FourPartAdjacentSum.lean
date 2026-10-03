/-
「四部分の循環隣接和を内部和と接合へ分割する」の具体版。
整数格子の歩と整数表 ϑ(u,v) = u₂v₁ - u₁v₂ に固定する。
本文の二区間・一接合の有限和分割を三回行い、閉じる接合を加える。
-/
import Ising2DLambda.KacWard.ReversedParallelStaircaseTurning
import Ising2DLambda.NecSuf.KacWard.FourPartAdjacentSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 有限列の範囲外を零で補い、連結の自然数添字へ合わせる。 -/
def extendLatticeWord {n : ℕ} (u : Fin n → ℤ × ℤ) (j : ℕ) : ℤ × ℤ :=
  if h : j < n then u ⟨j, h⟩ else 0

/-- 二列の内部和を、前半の内部・接合・後半の内部へ分割する。 -/
theorem latticeInternalTurning_join (u v : ℕ → ℤ × ℤ) (a b : ℕ)
    (ha : 0 < a) (hb : 0 < b) :
    internalAdjacentSum latticeStepTurning (a + b) (joinDirectionSequence u v a) =
      internalAdjacentSum latticeStepTurning a u + latticeStepTurning (u (a - 1)) (v 0) +
        internalAdjacentSum latticeStepTurning b v := by
  let z := joinDirectionSequence u v a
  have hsplit (f : ℕ → ℤ) :
      (∑ j ∈ Finset.range (a + b - 1), f j) =
        ((∑ j ∈ Finset.range (a - 1), f j) + f (a - 1)) +
          ∑ j ∈ Finset.range (b - 1), f (a + j) := by
    rw [show a + b - 1 = a + (b - 1) by omega, Finset.sum_range_add]
    have hfirst : (∑ j ∈ Finset.range a, f j) =
        (∑ j ∈ Finset.range (a - 1), f j) + f (a - 1) := by
      have hlength : a - 1 + 1 = a := by omega
      simpa only [hlength] using Finset.sum_range_succ f (a - 1)
    rw [hfirst]
  have hprefix : (∑ j ∈ Finset.range (a - 1), latticeStepTurning (z j) (z (j + 1))) =
      internalAdjacentSum latticeStepTurning a u := by
    apply Finset.sum_congr rfl
    intro j hj
    have hj' := Finset.mem_range.mp hj
    simp only [z, joinDirectionSequence, if_pos (show j < a by omega),
      if_pos (show j + 1 < a by omega)]
  have hboundary : latticeStepTurning (z (a - 1)) (z (a - 1 + 1)) =
      latticeStepTurning (u (a - 1)) (v 0) := by
    simp [z, joinDirectionSequence, show a - 1 < a by omega,
      show a - 1 + 1 = a by omega]
  have htail : (∑ j ∈ Finset.range (b - 1), latticeStepTurning (z (a + j)) (z (a + j + 1))) =
      internalAdjacentSum latticeStepTurning b v := by
    apply Finset.sum_congr rfl
    intro j _
    simp [z, joinDirectionSequence, show ¬a + j < a by omega,
      show ¬a + j + 1 < a by omega, show a + j + 1 - a = j + 1 by omega]
  calc
    internalAdjacentSum latticeStepTurning (a + b) z =
        ((∑ j ∈ Finset.range (a - 1), latticeStepTurning (z j) (z (j + 1))) +
          latticeStepTurning (z (a - 1)) (z (a - 1 + 1))) +
          ∑ j ∈ Finset.range (b - 1), latticeStepTurning (z (a + j)) (z (a + j + 1)) :=
      hsplit (fun j => latticeStepTurning (z j) (z (j + 1)))
    _ = internalAdjacentSum latticeStepTurning a u + latticeStepTurning (u (a - 1)) (v 0) +
        internalAdjacentSum latticeStepTurning b v := by rw [hprefix, hboundary, htail]

/-- 二列の分割を三回適用し、最後に閉じる接合を加える。 -/
theorem fourPart_latticeCyclicTurning (a b c d : ℕ)
    (u : Fin a → ℤ × ℤ) (v : Fin b → ℤ × ℤ)
    (w : Fin c → ℤ × ℤ) (x : Fin d → ℤ × ℤ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (hd : 0 < d) :
    let uv := joinDirectionSequence (extendLatticeWord u) (extendLatticeWord v) a
    let uvw := joinDirectionSequence uv (extendLatticeWord w) (a + b)
    let z := joinDirectionSequence uvw (extendLatticeWord x) (a + b + c)
    internalAdjacentSum latticeStepTurning (a + b + c + d) z +
        latticeStepTurning (z (a + b + c + d - 1)) (z 0) =
      internalAdjacentSum latticeStepTurning a (extendLatticeWord u) +
        latticeStepTurning ((extendLatticeWord u) (a - 1)) ((extendLatticeWord v) 0) +
      internalAdjacentSum latticeStepTurning b (extendLatticeWord v) +
        latticeStepTurning ((extendLatticeWord v) (b - 1)) ((extendLatticeWord w) 0) +
      internalAdjacentSum latticeStepTurning c (extendLatticeWord w) +
        latticeStepTurning ((extendLatticeWord w) (c - 1)) ((extendLatticeWord x) 0) +
      internalAdjacentSum latticeStepTurning d (extendLatticeWord x) +
        latticeStepTurning ((extendLatticeWord x) (d - 1)) ((extendLatticeWord u) 0) := by
  dsimp only
  have huv : joinDirectionSequence (extendLatticeWord u) (extendLatticeWord v) a (a + b - 1) = (extendLatticeWord v) (b - 1) := by
    simp [joinDirectionSequence, show ¬a + b - 1 < a by omega,
      show a + b - 1 - a = b - 1 by omega]
  have huvw : joinDirectionSequence (joinDirectionSequence (extendLatticeWord u) (extendLatticeWord v) a) (extendLatticeWord w) (a + b)
      (a + b + c - 1) = (extendLatticeWord w) (c - 1) := by
    simp [joinDirectionSequence, show ¬a + b + c - 1 < a + b by omega,
      show a + b + c - 1 - (a + b) = c - 1 by omega]
  have hlast : joinDirectionSequence
      (joinDirectionSequence (joinDirectionSequence (extendLatticeWord u) (extendLatticeWord v) a) (extendLatticeWord w) (a + b)) (extendLatticeWord x)
      (a + b + c) (a + b + c + d - 1) = (extendLatticeWord x) (d - 1) := by
    simp [joinDirectionSequence, show ¬a + b + c + d - 1 < a + b + c by omega,
      show a + b + c + d - 1 - (a + b + c) = d - 1 by omega]
  rw [latticeInternalTurning_join _ (extendLatticeWord x) _ d (by omega) hd]
  rw [latticeInternalTurning_join _ (extendLatticeWord w) _ c (by omega) hc]
  rw [latticeInternalTurning_join (extendLatticeWord u) (extendLatticeWord v) a b ha hb]
  rw [huv, huvw, hlast]
  simp [joinDirectionSequence, ha, show 0 < a + b by omega,
    add_assoc]

end Ising2DLambda.KacWard
