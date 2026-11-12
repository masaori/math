/-
「短い対と基準の長い対の対角変換因子の比」の必要十分版。
具体版と同じ手順（各辺の比の平方、巡回再添字付け、共通因子の約分、逆元の代入、定数の積）を、
可換な零付き群 G と任意の添字型 E の上で行う。
仮定に残したもの（いずれも具体版の証明が使う性質）:
* `hz : z ≠ 0` — 整数冪の加法則 `zpow_add₀`・減法則 `zpow_sub₀` と、u_e が零でないことに要る。
* `hc : c ≠ 0` — 共通因子 c（具体版では z²）の約分に要る。外すと比の段が書けない。
* `hq` — ねじれの指数が反転 ρ で変わらないこと。比 u_e / u_{ρ(e)} から q を消すのに要る。
* `hp`・`h4`・`hm4` — 方向の指数の差の二倍が ±4 であることと、z^4 = z^{-4} = μ。
  具体版では μ = -1 で、z^{-4} = μ は z^4 = -1 と (-1)⁻¹ = -1 から従う。
ρ が対合であること、閉路が非後退であること、μ² = 1 は使わない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

/-- 指数の対 (p, q) から作る対角成分 u_e = z^{p_e} z^{q_e}。 -/
def powerPairGauge {G E : Type*} [CommGroupWithZero G] (z : G) (p q : E → ℤ) (e : E) : G :=
  z ^ p e * z ^ q e

/-- 逆の対角成分 v_e = z^{-q_e} z^{-p_e}。 -/
def powerPairGaugeInverse {G E : Type*} [CommGroupWithZero G] (z : G) (p q : E → ℤ) (e : E) : G :=
  z ^ (-q e) * z ^ (-p e)

/-- 重み w_{e,f} = c (v_e u_f)。 -/
def powerPairGaugeWeight {G E : Type*} [CommGroupWithZero G] (z c : G) (p q : E → ℤ)
    (e f : E) : G :=
  c * (powerPairGaugeInverse z p q e * powerPairGauge z p q f)

theorem cycle_gauge_ratio_necSuf {G E : Type*} [CommGroupWithZero G]
    (z c μ : G) (hz : z ≠ 0) (hc : c ≠ 0) (p q : E → ℤ) (ρ : E → E)
    (hq : ∀ e, q (ρ e) = q e)
    (hp : ∀ e, 2 * (p e - p (ρ e)) = 4 ∨ 2 * (p e - p (ρ e)) = -4)
    (h4 : z ^ (4 : ℤ) = μ) (hm4 : z ^ (-4 : ℤ) = μ)
    {m : ℕ} (γ : Fin (m + 1) → E) :
    ∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (ρ (γ (r - 1))) (γ r) =
      μ ^ (m + 1) * ∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (γ r) (ρ (γ r)) := by
  let u := powerPairGauge z p q
  let v := powerPairGaugeInverse z p q
  have hu : ∀ e, u e ≠ 0 := fun e => mul_ne_zero (zpow_ne_zero _ hz) (zpow_ne_zero _ hz)
  have hv : ∀ e, v e = (u e)⁻¹ := fun e => by
    refine eq_inv_of_mul_eq_one_right ?_
    show (z ^ p e * z ^ q e) * (z ^ (-q e) * z ^ (-p e)) = 1
    rw [← zpow_add₀ hz, ← zpow_add₀ hz, ← zpow_add₀ hz]
    rw [show p e + q e + (-q e + -p e) = 0 by ring, zpow_zero]
  -- 各辺の比の平方（具体版の準備の三等号）
  have hsq : ∀ e, (u e / u (ρ e)) ^ (2 : ℕ) = μ := fun e => by
    calc
      (u e / u (ρ e)) ^ (2 : ℕ) = ((z ^ p e * z ^ q e) / (z ^ p (ρ e) * z ^ q e)) ^ (2 : ℕ) := by
        show ((z ^ p e * z ^ q e) / (z ^ p (ρ e) * z ^ q (ρ e))) ^ (2 : ℕ) = _
        rw [hq]
      _ = (z ^ (p e + q e) / z ^ (p (ρ e) + q e)) ^ (2 : ℕ) := by
        rw [zpow_add₀ hz, zpow_add₀ hz]
      _ = (z ^ ((p e + q e) - (p (ρ e) + q e))) ^ (2 : ℕ) := by rw [zpow_sub₀ hz]
      _ = z ^ (((p e + q e) - (p (ρ e) + q e)) * 2) := by
        rw [zpow_mul]
        exact (zpow_natCast _ 2).symm
      _ = z ^ (2 * (p e - p (ρ e))) := by congr 1; ring
      _ = μ := by
        rcases hp e with h | h
        · rw [h, h4]
        · rw [h, hm4]
  have hlong : ∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (γ r) (ρ (γ r)) ≠ 0 :=
    Finset.prod_ne_zero_iff.mpr fun r _ =>
      mul_ne_zero hc (mul_ne_zero (show v (γ r) ≠ 0 from (hv (γ r)).symm ▸ inv_ne_zero (hu (γ r))) (hu _))
  have hshift : ∀ f : E → G, ∏ r : Fin (m + 1), f (γ (r - 1)) = ∏ r : Fin (m + 1), f (γ r) :=
    fun f => Fintype.prod_equiv (Equiv.subRight (1 : Fin (m + 1))) _ _ (fun _ => rfl)
  have hratio :
      (∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (ρ (γ (r - 1))) (γ r)) /
          (∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (γ r) (ρ (γ r))) = μ ^ (m + 1) := by
    calc
      (∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (ρ (γ (r - 1))) (γ r)) /
          (∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (γ r) (ρ (γ r))) =
          (∏ r : Fin (m + 1), c * (v (ρ (γ (r - 1))) * u (γ r))) /
            (∏ r : Fin (m + 1), c * (v (γ r) * u (ρ (γ r)))) := rfl
      _ = (∏ r : Fin (m + 1), c * (v (ρ (γ r)) * u (γ r))) /
            (∏ r : Fin (m + 1), c * (v (γ r) * u (ρ (γ r)))) := by
        congr 1
        rw [Finset.prod_mul_distrib, Finset.prod_mul_distrib,
          hshift (fun e => v (ρ e)), ← Finset.prod_mul_distrib, ← Finset.prod_mul_distrib]
      _ = ∏ r : Fin (m + 1), (c * (v (ρ (γ r)) * u (γ r))) / (c * (v (γ r) * u (ρ (γ r)))) :=
        (Finset.prod_div_distrib _ _).symm
      _ = ∏ r : Fin (m + 1), (v (ρ (γ r)) * u (γ r)) / (v (γ r) * u (ρ (γ r))) :=
        Finset.prod_congr rfl fun r _ => mul_div_mul_left _ _ hc
      _ = ∏ r : Fin (m + 1), (u (γ r) / u (ρ (γ r))) ^ (2 : ℕ) := by
        refine Finset.prod_congr rfl fun r _ => ?_
        have h1 := hu (γ r)
        have h2 := hu (ρ (γ r))
        rw [hv, hv]
        field_simp
      _ = ∏ _r : Fin (m + 1), μ := Finset.prod_congr rfl fun r _ => hsq (γ r)
      _ = μ ^ (m + 1) := by rw [Finset.prod_const, Finset.card_univ, Fintype.card_fin]
  calc
    ∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (ρ (γ (r - 1))) (γ r) =
        ((∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (ρ (γ (r - 1))) (γ r)) /
            (∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (γ r) (ρ (γ r)))) *
          ∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (γ r) (ρ (γ r)) :=
      (div_mul_cancel₀ _ hlong).symm
    _ = μ ^ (m + 1) * ∏ r : Fin (m + 1), powerPairGaugeWeight z c p q (γ r) (ρ (γ r)) := by
      rw [hratio]

end Ising2DLambda.NecSuf.KacWard
