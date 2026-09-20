/-
「反復横断階段は各歩で横断座標を増やし基点より歩数以上高くなる」の必要十分版。

具体的な整数格子から切り離すと、正の長さを持つ有限階段、その終点を周期とする反復、
および各歩の座標増分が 1 以上であることだけが必要である。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 長さ `n` の有限階段を、その終点 `period` だけ平行移動しながら反復する。 -/
def iteratedStaircase {G : Type*} [AddCommGroup G]
    (n : ℕ) (path : ℕ → G) (period base : G) (s : ℕ) : G :=
  base + (s / n) • period + path (s % n)

/-- 整数除法の二場合から、反復階段の一歩は元の有限階段の一歩に等しい。 -/
theorem iteratedStaircase_step_necSuf {G : Type*} [AddCommGroup G]
    (n : ℕ) (path : ℕ → G) (period base : G)
    (hn : 0 < n) (hzero : path 0 = 0) (hend : path n = period) (s : ℕ) :
    iteratedStaircase n path period base (s + 1) -
        iteratedStaircase n path period base s =
      path (s % n + 1) - path (s % n) := by
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
    rw [iteratedStaircase, iteratedStaircase, hdiv, hmod]
    abel
  · have hrequiv : s % n + 1 = n := by omega
    have hdiv : (s + 1) / n = s / n + 1 := by
      rw [hdivbase, hrequiv, Nat.div_self hn]
      omega
    have hmod : (s + 1) % n = 0 := by
      rw [hmodbase, hrequiv, Nat.mod_self]
    rw [iteratedStaircase, iteratedStaircase, hdiv, hmod, hzero, hrequiv, hend]
    simp only [add_nsmul, one_nsmul]
    abel

/-- 各歩の整数座標増分が 1 以上なら、反復階段は各歩で増加し、歩数分の下界を持つ。 -/
theorem iteratedStaircase_coordinate_necSuf
    {G : Type*} [AddCommGroup G]
    (n : ℕ) (path : ℕ → G) (period base : G) (coordinate : G →+ ℤ)
    (hn : 0 < n) (hzero : path 0 = 0) (hend : path n = period)
    (hstep : ∀ r < n, 1 ≤ coordinate (path (r + 1)) - coordinate (path r)) :
    (∀ s : ℕ, coordinate (iteratedStaircase n path period base s) <
      coordinate (iteratedStaircase n path period base (s + 1))) ∧
    (∀ s : ℕ, coordinate base + (s : ℤ) ≤
      coordinate (iteratedStaircase n path period base s)) ∧
    Function.Injective (iteratedStaircase n path period base) := by
  have hincrement : ∀ s, coordinate (iteratedStaircase n path period base s) + 1 ≤
      coordinate (iteratedStaircase n path period base (s + 1)) := by
    intro s
    have hrlt : s % n < n := Nat.mod_lt s hn
    have hdiff := congrArg coordinate
      (iteratedStaircase_step_necSuf n path period base hn hzero hend s)
    rw [map_sub, map_sub] at hdiff
    have hbase := hstep (s % n) hrlt
    omega
  constructor
  · intro s
    exact lt_of_lt_of_le (lt_add_one _) (hincrement s)
  constructor
  · intro s
    induction s with
    | zero => simp [iteratedStaircase, hzero]
    | succ s ih =>
        have hs := hincrement s
        norm_num [Nat.cast_add, Nat.cast_one]
        omega
  · intro a b hab
    apply (strictMono_nat_of_lt_succ fun s =>
      lt_of_lt_of_le (lt_add_one _) (hincrement s)).injective
    exact congrArg coordinate hab

end Ising2DLambda.NecSuf.KacWard
