import Ising2DLambda.KacWard.OneSidedParallelReturnFromWalk
import Ising2DLambda.KacWard.IteratedTransverseStaircase
import Ising2DLambda.KacWard.ParallelStaircaseTransverseWidth
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 一側閉包の反転平行階段は、上り・下りの横断階段と接合点以外で交わらない。 -/
theorem oneSidedParallelReturnFromWalk_avoids_staircases {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ) (t c : ℕ) :
    let wh := horizontalDirectedWindingNumber γ
    let wv := verticalDirectedWindingNumber γ
    let S := periodicPlaneLiftFromWalk γ k₀
    let b := t * (wh.natAbs + wv.natAbs)
    let n := L * wh.natAbs + L * wv.natAbs
    (∀ i < b, ∀ j < c * n,
      iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) i ≠
        oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c j) ∧
    (∀ i < c * n, ∀ j, 0 < j → j ≤ b →
      oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c i ≠
        iteratedTransverseStaircase wh wv S j) := by
  dsimp only
  let wh := horizontalDirectedWindingNumber γ
  let wv := verticalDirectedWindingNumber γ
  let S := periodicPlaneLiftFromWalk γ k₀
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let κ := windingTransverseCoordinate wh wv
  have hn : 0 < n := by
    by_cases hh : wh = 0
    · have hv : wv ≠ 0 := by
        intro he
        exact hwind (by simp [wh, wv, hh, he])
      have hp : 0 < L * wv.natAbs := Nat.mul_pos (NeZero.pos L)
        (Nat.pos_of_ne_zero (by simpa using hv))
      omega
    · have hp : 0 < L * wh.natAbs := Nat.mul_pos (NeZero.pos L)
        (Nat.pos_of_ne_zero (by simpa using hh))
      omega
  have htop (i : ℕ) (hi : i < c * n) :
      κ S + (t : ℤ) * (wh ^ 2 + wv ^ 2) ≤
        κ (oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c i) := by
    have hrem : i % n ≤ n := by have := Nat.mod_lt i hn; omega
    have hwidth := (windingParallelStaircase_transverse_width_bound
      L wh wv (0, 0) (i % n) hrem).2
    have hG : κ (windingParallelStaircase L wh wv (i % n)) ≤ 0 := by
      simpa [κ] using hwidth
    have hr : κ (oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c i) =
        κ S + (t : ℤ) * (wh ^ 2 + wv ^ 2) -
          κ (windingParallelStaircase L wh wv (i % n)) := by
      simp [κ, n, oneSidedParallelReturn, windingTransverseCoordinate,
        Prod.smul_mk]
      ring
    rw [hr]
    omega
  have hbase : κ (S + c • windingShift L wv wh) = κ S := by
    simp [κ, windingTransverseCoordinate, Prod.smul_mk, windingShift]
    ring
  have hend : κ (iteratedTransverseStaircase wh wv S b) =
      κ S + (t : ℤ) * (wh ^ 2 + wv ^ 2) := by
    have hlen : 0 < wh.natAbs + wv.natAbs := by
      by_contra h
      have hwh : wh = 0 := Int.natAbs_eq_zero.mp (by omega)
      have hwv : wv = 0 := Int.natAbs_eq_zero.mp (by omega)
      exact hwind (by simp [wh, wv, hwh, hwv])
    have hdiv : b / (wh.natAbs + wv.natAbs) = t := by
      simpa [b, Nat.mul_comm] using Nat.mul_div_cancel_left t hlen
    have hmod : b % (wh.natAbs + wv.natAbs) = 0 := by
      simpa [b, Nat.mul_comm] using Nat.mul_mod_right (wh.natAbs + wv.natAbs) t
    change κ (S + (b / (wh.natAbs + wv.natAbs)) • (wh, -wv) +
      windingTransverseStaircase wh wv (b % (wh.natAbs + wv.natAbs))) = _
    rw [hdiv, hmod]
    rw [windingTransverseStaircase_zero]
    simp [κ, windingTransverseCoordinate, Prod.smul_mk]
    ring
  have htranslate (i : ℕ) :
      κ (iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) i) =
        κ (iteratedTransverseStaircase wh wv S i) := by
    change κ ((S + c • windingShift L wv wh) +
      (i / (wh.natAbs + wv.natAbs)) • (wh, -wv) +
      windingTransverseStaircase wh wv (i % (wh.natAbs + wv.natAbs))) =
      κ (S + (i / (wh.natAbs + wv.natAbs)) • (wh, -wv) +
        windingTransverseStaircase wh wv (i % (wh.natAbs + wv.natAbs)))
    simp only [map_add]
    rw [map_add] at hbase
    omega
  have hmono := (iteratedTransverseStaircase_lower_bound wh wv S hwind).2.1
  have hstrict : StrictMono (fun i : ℕ => κ (iteratedTransverseStaircase wh wv S i)) :=
    strictMono_nat_of_lt_succ hmono
  constructor
  · intro i hi j hj heq
    change i < b at hi
    change j < c * n at hj
    change iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) i =
      oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c j at heq
    have hlt := hstrict hi
    dsimp only at hlt
    rw [← htranslate i, heq, hend] at hlt
    exact (not_lt_of_ge (htop j hj)) hlt
  · intro i hi j hj hjb heq
    change i < c * n at hi
    change j ≤ b at hjb
    change oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c i =
      iteratedTransverseStaircase wh wv S j at heq
    by_cases hlast : j = b
    · subst j
      have hreturnEnd : oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c (c * n) =
          iteratedTransverseStaircase wh wv S b := by
        have hlen : 0 < wh.natAbs + wv.natAbs := by
          by_contra h
          have hwh : wh = 0 := Int.natAbs_eq_zero.mp (by omega)
          have hwv : wv = 0 := Int.natAbs_eq_zero.mp (by omega)
          exact hwind (by simp [wh, wv, hwh, hwv])
        have hdivn : c * n / n = c := by
          simpa [Nat.mul_comm] using Nat.mul_div_cancel_left c hn
        have hmodn : c * n % n = 0 := by
          simpa [Nat.mul_comm] using Nat.mul_mod_right n c
        have hdivb : b / (wh.natAbs + wv.natAbs) = t := by
          simpa [b, Nat.mul_comm] using Nat.mul_div_cancel_left t hlen
        have hmodb : b % (wh.natAbs + wv.natAbs) = 0 := by
          simpa [b, Nat.mul_comm] using Nat.mul_mod_right (wh.natAbs + wv.natAbs) t
        change S + t • (wh, -wv) + ((c : ℤ) - ((c * n / n : ℕ) : ℤ)) •
            ((L : ℤ) * wv, (L : ℤ) * wh) -
            windingParallelStaircase L wh wv (c * n % n) =
          S + (b / (wh.natAbs + wv.natAbs)) • (wh, -wv) +
            windingTransverseStaircase wh wv (b % (wh.natAbs + wv.natAbs))
        rw [hdivn, hmodn, hdivb, hmodb,
          windingParallelStaircase_zero]
        simp [windingTransverseStaircase_zero]
      have hinj := oneSidedParallelReturnFromWalk_injective γ hwind k₀ t c
      have hindex : i = c * n := hinj (heq.trans hreturnEnd.symm)
      omega
    · have hlt : j < b := by omega
      have hcoord := hstrict hlt
      dsimp only at hcoord
      rw [hend, ← heq] at hcoord
      exact (not_lt_of_ge (htop i hi)) hcoord

end Ising2DLambda.KacWard
