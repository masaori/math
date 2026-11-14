/-
章「Onsager 閉形式への接続」の
「反復横断階段は各歩で横断座標を増やし基点より歩数以上高くなる」
（`claim_iterated_transverse_staircase_lower_bound`）の具体版。

人手証明と同じ整数除法の二場合で隣接差を元の横断階段の一歩へ戻し、
整数横断座標の増加、歩数による下界、頂点の相異性を順に得る。
-/
import Ising2DLambda.KacWard.WindingTransverseStaircase
import Ising2DLambda.NecSuf.KacWard.IteratedTransverseStaircase
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_iterated_transverse_staircase`。横断階段を終点だけ平行移動して反復する。 -/
def iteratedTransverseStaircase (wh wv : ℤ) (base : ℤ × ℤ) (s : ℕ) : ℤ × ℤ :=
  iteratedStaircase (wh.natAbs + wv.natAbs) (windingTransverseStaircase wh wv)
    (wh, -wv) base s

theorem windingTransverseStaircase_zero (wh wv : ℤ) :
    windingTransverseStaircase wh wv 0 = 0 := by
  simp [windingTransverseStaircase, twoPhaseStaircase]

private lemma abs_mul_sign (z : ℤ) : |z| * z.sign = z := by
  rw [mul_comm]
  exact Int.sign_mul_abs z

private lemma windingTransverseStaircase_end (wh wv : ℤ) :
    windingTransverseStaircase wh wv (wh.natAbs + wv.natAbs) = (wh, -wv) := by
  by_cases hV : wv = 0
  · subst wv
    simp [windingTransverseStaircase, twoPhaseStaircase, abs_mul_sign]
  · have hnotle : ¬wh.natAbs + wv.natAbs ≤ wh.natAbs := by
      have : 0 < wv.natAbs := Int.natAbs_pos.mpr hV
      omega
    simp [windingTransverseStaircase, twoPhaseStaircase, hnotle, abs_mul_sign]

private lemma windingTransverseStaircase_length_pos (wh wv : ℤ)
    (hwind : (wh, wv) ≠ (0, 0)) : 0 < wh.natAbs + wv.natAbs := by
  by_contra hnot
  have hsum : wh.natAbs + wv.natAbs = 0 := by omega
  have hparts : wh.natAbs = 0 ∧ wv.natAbs = 0 := Nat.add_eq_zero_iff.mp hsum
  have hwh : wh = 0 := Int.natAbs_eq_zero.mp hparts.1
  have hwv : wv = 0 := Int.natAbs_eq_zero.mp hparts.2
  exact hwind (Prod.ext hwh hwv)

private lemma windingTransverseStaircase_coordinate_step_ge_one (wh wv : ℤ)
    (r : ℕ) (hr : r < wh.natAbs + wv.natAbs) :
    1 ≤ windingTransverseCoordinate wh wv (windingTransverseStaircase wh wv (r + 1)) -
      windingTransverseCoordinate wh wv (windingTransverseStaircase wh wv r) := by
  have h := (windingTransverseStaircase_step_increase wh wv r hr).2
  omega

private lemma iteratedTransverseStaircase_step (wh wv : ℤ) (base : ℤ × ℤ)
    (hwind : (wh, wv) ≠ (0, 0)) (s : ℕ) :
    iteratedTransverseStaircase wh wv base (s + 1) -
        iteratedTransverseStaircase wh wv base s =
      windingTransverseStaircase wh wv (s % (wh.natAbs + wv.natAbs) + 1) -
        windingTransverseStaircase wh wv (s % (wh.natAbs + wv.natAbs)) := by
  let n := wh.natAbs + wv.natAbs
  have hn : 0 < n := windingTransverseStaircase_length_pos wh wv hwind
  have hrlt : s % n < n := Nat.mod_lt s hn
  have hsucc : s + 1 = (s % n + 1) + n * (s / n) := by
    have := Nat.mod_add_div s n
    omega
  have hdivbase : (s + 1) / n = (s % n + 1) / n + s / n := by
    rw [hsucc, Nat.add_mul_div_left _ _ hn]
  have hmodbase : (s + 1) % n = (s % n + 1) % n := by
    rw [hsucc, Nat.add_mul_mod_self_left]
  by_cases hbefore : s % n + 1 < n
  · have hdiv : (s + 1) / n = s / n := by
      rw [hdivbase, Nat.div_eq_of_lt hbefore, zero_add]
    have hmod : (s + 1) % n = s % n + 1 := by
      rw [hmodbase, Nat.mod_eq_of_lt hbefore]
    change iteratedStaircase n (windingTransverseStaircase wh wv) (wh, -wv) base
        (s + 1) - iteratedStaircase n (windingTransverseStaircase wh wv) (wh, -wv)
        base s = _
    rw [iteratedStaircase, iteratedStaircase, hdiv, hmod]
    abel
  · have hrequiv : s % n + 1 = n := by omega
    have hdiv : (s + 1) / n = s / n + 1 := by
      rw [hdivbase, hrequiv, Nat.div_self hn]
      omega
    have hmod : (s + 1) % n = 0 := by
      rw [hmodbase, hrequiv, Nat.mod_self]
    change iteratedStaircase n (windingTransverseStaircase wh wv) (wh, -wv) base
        (s + 1) - iteratedStaircase n (windingTransverseStaircase wh wv) (wh, -wv)
        base s = _
    rw [iteratedStaircase, iteratedStaircase, hdiv, hmod, windingTransverseStaircase_zero, hrequiv,
      windingTransverseStaircase_end]
    simp only [add_nsmul, one_nsmul]
    abel

/-- `claim_iterated_transverse_staircase_lower_bound`。
一歩の差、横断座標の増加と下界、および頂点の相異性。 -/
theorem iteratedTransverseStaircase_lower_bound (wh wv : ℤ) (base : ℤ × ℤ)
    (hwind : (wh, wv) ≠ (0, 0)) :
    (∀ s : ℕ, iteratedTransverseStaircase wh wv base (s + 1) -
        iteratedTransverseStaircase wh wv base s =
      windingTransverseStaircase wh wv (s % (wh.natAbs + wv.natAbs) + 1) -
        windingTransverseStaircase wh wv (s % (wh.natAbs + wv.natAbs))) ∧
    (∀ s : ℕ, windingTransverseCoordinate wh wv (iteratedTransverseStaircase wh wv base s) <
      windingTransverseCoordinate wh wv (iteratedTransverseStaircase wh wv base (s + 1))) ∧
    (∀ s : ℕ, windingTransverseCoordinate wh wv base + (s : ℤ) ≤
      windingTransverseCoordinate wh wv (iteratedTransverseStaircase wh wv base s)) ∧
    Function.Injective (iteratedTransverseStaircase wh wv base) := by
  have hn := windingTransverseStaircase_length_pos wh wv hwind
  have hincrement : ∀ s : ℕ,
      windingTransverseCoordinate wh wv (iteratedTransverseStaircase wh wv base s) + 1 ≤
        windingTransverseCoordinate wh wv
          (iteratedTransverseStaircase wh wv base (s + 1)) := by
    intro s
    have hdiff := congrArg (windingTransverseCoordinate wh wv)
      (iteratedTransverseStaircase_step wh wv base hwind s)
    rw [map_sub, map_sub] at hdiff
    have hbase := windingTransverseStaircase_coordinate_step_ge_one wh wv
      (s % (wh.natAbs + wv.natAbs)) (Nat.mod_lt s hn)
    omega
  constructor
  · intro s
    exact iteratedTransverseStaircase_step wh wv base hwind s
  constructor
  · intro s
    exact lt_of_lt_of_le (lt_add_one _) (hincrement s)
  constructor
  · intro s
    induction s with
    | zero => simp [iteratedTransverseStaircase, iteratedStaircase,
        windingTransverseStaircase_zero]
    | succ s ih =>
        have hs := hincrement s
        norm_num [Nat.cast_add, Nat.cast_one]
        omega
  · intro a b hab
    apply (strictMono_nat_of_lt_succ fun s =>
      lt_of_lt_of_le (lt_add_one _) (hincrement s)).injective
    exact congrArg (windingTransverseCoordinate wh wv) hab

/-- 反復横断階段の各差は四つの単位格子ベクトルの一つである。 -/
theorem iteratedTransverseStaircase_unit_step (wh wv : ℤ) (base : ℤ × ℤ)
    (hwind : (wh, wv) ≠ (0, 0)) (s : ℕ) :
    let difference := iteratedTransverseStaircase wh wv base (s + 1) -
      iteratedTransverseStaircase wh wv base s
    difference = (1, 0) ∨ difference = (-1, 0) ∨
      difference = (0, 1) ∨ difference = (0, -1) := by
  have hn := windingTransverseStaircase_length_pos wh wv hwind
  dsimp
  rw [(iteratedTransverseStaircase_lower_bound wh wv base hwind).1 s]
  exact (windingTransverseStaircase_step_increase wh wv
    (s % (wh.natAbs + wv.natAbs)) (Nat.mod_lt s hn)).1

end Ising2DLambda.KacWard
