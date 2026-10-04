/-
高温展開の必要十分版。同じ辺積の配位和を、一辺の二値評価と部分集合展開で計算する。
有限和・有限積の分配と並べ替えには可換半環を使う。減法は使わず、二項の係数を別々に渡す。
最後の消去には固定した因子による左乗法の単射性だけを使う。整域性は要求しない。
スピン単項式の和の評価は、本文で先に証明された主張に対応する仮定である。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- 二つの評価の一致から、固定した左因子だけを消去する。 -/
theorem common_sum_two_evaluations_necSuf {R : Type*} [Mul R]
    (c z h common : R) (hc : Function.Injective (fun y : R => c * y))
    (hleft : common = c * (c * z)) (hright : common = c * h) :
    c * z = h := by
  have hcommon : c * (c * z) = c * h := hleft.symm.trans hright
  exact hc hcommon

/-- `claim_high_temperature_polynomial_identity` の二つの有限和計算を含む必要十分版。 -/
theorem highTemperaturePolynomial_identity_necSuf
    {R S E : Type*} [CommSemiring R] [Fintype S] [Fintype E] [DecidableEq E]
    (a b k x c : R) (spin : S → E → R) (intact : S → E → Prop)
    [∀ σ, DecidablePred (intact σ)] (even : Finset E → Prop) [DecidablePred even]
    (hedge : ∀ σ e, a + b * spin σ e = if intact σ e then k else k * x)
    (hspin : ∀ A : Finset E, (∑ σ : S, ∏ e ∈ A, spin σ e) =
      if even A then c else 0)
    (hsize : k ^ Fintype.card E = c * c)
    (hc : Function.Injective (fun y : R => c * y)) :
    c * (∑ σ : S, x ^ ((univ : Finset E).filter (fun e => ¬ intact σ e)).card) =
      ∑ A ∈ (univ : Finset (Finset E)).filter even,
        a ^ (Fintype.card E - A.card) * b ^ A.card := by
  classical
  -- 一辺の二値評価、場合別積、一定値の積、冪の法則、辺の総数。
  have hprod (σ : S) : (∏ e : E, (a + b * spin σ e)) =
      k ^ Fintype.card E *
        x ^ ((univ : Finset E).filter (fun e => ¬ intact σ e)).card := by
    simp_rw [hedge]
    rw [Finset.prod_ite]
    simp only [Finset.prod_const]
    rw [mul_pow, ← mul_assoc, ← pow_add]
    rw [Finset.card_filter_add_card_filter_not, Finset.card_univ]
  -- 有限分配則、各部分集合での積の分離、一定値の積、補集合の個数。
  have hexpand (σ : S) : (∏ e : E, (a + b * spin σ e)) =
      ∑ A : Finset E, a ^ (Fintype.card E - A.card) * b ^ A.card *
        ∏ e ∈ A, spin σ e := by
    simp_rw [add_comm a]
    rw [Fintype.prod_add]
    apply Finset.sum_congr rfl
    intro A _
    rw [Finset.prod_mul_distrib]
    simp only [Finset.prod_const, Finset.card_compl]
    ring
  -- 全配位の和を、一辺の二値評価から計算する。
  have hleft : (∑ σ : S, ∏ e : E, (a + b * spin σ e)) =
      c * (c * ∑ σ : S,
        x ^ ((univ : Finset E).filter (fun e => ¬ intact σ e)).card) := by
    simp_rw [hprod]
    rw [← Finset.mul_sum]
    rw [hsize]
    rw [mul_assoc]
  -- 同じ和を展開し、和の交換、因子の取り出し、既証明のスピン和評価を順に使う。
  have hright : (∑ σ : S, ∏ e : E, (a + b * spin σ e)) =
      c * ∑ A ∈ (univ : Finset (Finset E)).filter even,
        a ^ (Fintype.card E - A.card) * b ^ A.card := by
    simp_rw [hexpand]
    rw [Finset.sum_comm]
    simp_rw [← Finset.mul_sum]
    simp_rw [hspin]
    simp only [mul_ite, mul_zero]
    rw [← Finset.sum_filter]
    rw [← Finset.sum_mul]
    rw [mul_comm]
  exact common_sum_two_evaluations_necSuf c _ _ _ hc hleft hright

end Ising2DLambda.NecSuf.FisherZero
