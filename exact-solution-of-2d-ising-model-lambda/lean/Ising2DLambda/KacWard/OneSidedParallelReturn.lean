/- `claim_one_sided_parallel_return_repetition` の具体版。
第三部分の点を整数格子上で定義し、本文と同じ整数除法の二場合を証明する。 -/
import Ising2DLambda.KacWard.NegatedParallelStaircaseTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

private theorem twoPhase_end (p q : ℕ) (a b : ℤ × ℤ) :
    twoPhaseStaircase p a b (p + q) = p • a + q • b := by
  by_cases hq : q = 0
  · subst q; simp [twoPhaseStaircase]
  · simp [twoPhaseStaircase, show ¬p + q ≤ p by omega]

theorem windingParallelStaircase_zero (L : ℕ) (wh wv : ℤ) :
    windingParallelStaircase L wh wv 0 = 0 := by
  simp [windingParallelStaircase, orderedTwoPhaseStaircase, twoPhaseStaircase]

theorem windingParallelStaircase_end (L : ℕ) (wh wv : ℤ) :
    windingParallelStaircase L wh wv (L * wh.natAbs + L * wv.natAbs) =
      ((L : ℤ) * wv, (L : ℤ) * wh) := by
  have habs (z : ℤ) : |z| * z.sign = z := by
    rw [mul_comm]; exact Int.sign_mul_abs z
  unfold windingParallelStaircase orderedTwoPhaseStaircase
  by_cases horder : 0 < wh * wv
  · rw [if_pos horder, twoPhase_end]
    simp [Prod.smul_mk, mul_assoc, habs]
  · rw [if_neg horder, Nat.add_comm (L * wh.natAbs), twoPhase_end]
    simp [Prod.smul_mk, mul_assoc, habs]

def oneSidedParallelReturn (L : ℕ) (wh wv : ℤ) (base : ℤ × ℤ) (c s : ℕ) : ℤ × ℤ :=
  base + ((c : ℤ) - (s / (L * wh.natAbs + L * wv.natAbs) : ℕ)) •
    ((L : ℤ) * wv, (L : ℤ) * wh) -
    windingParallelStaircase L wh wv (s % (L * wh.natAbs + L * wv.natAbs))

theorem oneSidedParallelReturn_step (L : ℕ) (wh wv : ℤ) (base : ℤ × ℤ) (c : ℕ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) (s : ℕ) :
    oneSidedParallelReturn L wh wv base c (s + 1) -
        oneSidedParallelReturn L wh wv base c s =
      negatedParallelStaircaseStep L wh wv (s % (L * wh.natAbs + L * wv.natAbs)) := by
  rw [negatedParallelStaircaseStep_difference]
  let n := L * wh.natAbs + L * wv.natAbs
  let path := windingParallelStaircase L wh wv
  let period : ℤ × ℤ := ((L : ℤ) * wv, (L : ℤ) * wh)
  have hzero : path 0 = 0 := windingParallelStaircase_zero L wh wv
  have hend : path n = period := windingParallelStaircase_end L wh wv
  change (base + ((c : ℤ) - ((s + 1) / n : ℕ)) • period - path ((s + 1) % n)) -
      (base + ((c : ℤ) - (s / n : ℕ)) • period - path (s % n)) =
    -(path (s % n + 1) - path (s % n))
  have hrlt : s % n < n := Nat.mod_lt s hn
  have hsrepr := Nat.mod_add_div s n
  have hsucc : s + 1 = (s % n + 1) + n * (s / n) := by omega
  have hdivbase : (s + 1) / n = (s % n + 1) / n + s / n := by
    rw [hsucc, Nat.add_mul_div_left _ _ hn]
  have hmodbase : (s + 1) % n = (s % n + 1) % n := by
    rw [hsucc, Nat.add_mul_mod_self_left]
  by_cases hbefore : s % n + 1 < n
  · have hdiv : (s + 1) / n = s / n := by
      rw [hdivbase, Nat.div_eq_of_lt hbefore, zero_add]
    have hmod : (s + 1) % n = s % n + 1 := by
      rw [hmodbase, Nat.mod_eq_of_lt hbefore]
    rw [hdiv, hmod]
    abel
  · have hrequiv : s % n + 1 = n := by omega
    have hdiv : (s + 1) / n = s / n + 1 := by
      rw [hdivbase, hrequiv, Nat.div_self hn]
      omega
    have hmod : (s + 1) % n = 0 := by
      rw [hmodbase, hrequiv, Nat.mod_self]
    rw [hdiv, hmod, hzero, hrequiv, hend]
    simp only [Nat.cast_add, Nat.cast_one, sub_smul, add_smul, one_smul]
    abel

/-- 反転平行階段の平行座標は各歩で真に減るため、全ての頂点が相異なる。 -/
theorem oneSidedParallelReturn_injective (L : ℕ) (wh wv : ℤ)
    (base : ℤ × ℤ) (c : ℕ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    Function.Injective (oneSidedParallelReturn L wh wv base c) := by
  let r := oneSidedParallelReturn L wh wv base c
  let G := windingParallelStaircase L wh wv
  let κ := windingParallelCoordinate wv wh
  let n := L * wh.natAbs + L * wv.natAbs
  have hdecrease (s : ℕ) : κ (r (s + 1)) < κ (r s) := by
    have hs : s % n < n := Nat.mod_lt s hn
    have hG := (windingParallelStaircase_step_increase L wh wv (s % n) hs).2
    change κ (G (s % n)) < κ (G (s % n + 1)) at hG
    have hr := oneSidedParallelReturn_step L wh wv base c hn s
    have hdifference : κ (r (s + 1)) - κ (r s) =
        -(κ (G (s % n + 1)) - κ (G (s % n))) := by
      rw [← map_sub, hr, negatedParallelStaircaseStep_difference,
        map_neg, map_sub]
    omega
  have hmono : StrictMono (fun s : ℕ => -(κ (r s))) :=
    strictMono_nat_of_lt_succ (fun s => by have h := hdecrease s; omega)
  intro i j hij
  apply hmono.injective
  exact congrArg (fun p : ℤ × ℤ => -(κ p)) hij

end Ising2DLambda.KacWard
