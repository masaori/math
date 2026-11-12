/-
「複素根の角表示は分散因子の実現値を余弦で表す」の必要十分版。

具体版と同じ手順（`z = 0` なら `1 = z^n = 0^n = 0` の矛盾、`z + z⁻¹ = (α+βω) + (α−βω) = 2α = 2α + 0·ω`、
`ρ_C(z⁻¹)` の八行、`ρ_R(2α) = re(…)` の九行、分散因子の値の三行と十行）を、次の仮定だけで行う。

- `F`: 可除環（代数的数体にあたる）。乗法の可換性は使わない。`z⁻¹` と `z z⁻¹ = 1` に零でない元の逆元を使う。
- `S`: `F` の部分環（実閉部分体にあたる）と `ω : F`。一意表示・`ω² = −1`・順序は使わない。
- `ρR : S → K` は加法と乗法を保つ（実現写像にあたる）。単位元の保存・順序・単射性は使わない。
- `A`: 環（有理数体にあたる）。`jS : A →+* S` と `j : A →+* K` は環準同型で、`ρR ∘ jS = j`
  （有理数上の一致）。
- `K`: 環（実数体にあたる）。可換性・順序・完備性は使わない。
- `C`: 環（複素数体にあたる）。`ofK : K →+* C` と `I : C` と `re : C → K` は `re(ofK x + I·ofK y) = x` だけを満たす。
  `I² = −1`・可換性・`re` の加法性は使わない（複素実現の乗法の保存は仮定 `ρC_mul` として受けるので、
  そこで `I² = −1` を使い終えている）。
- `ρC : F → C` は `ρC(a + bω) = ofK(ρR a) + I·ofK(ρR b)`（複素実現の定義）、加法・乗法・単位元を保つ。
- `ex : K → C` は加法法則 `ex(s+t) = ex(s)ex(t)` と `ex(0) = 1`、`cs sn : K → K` は
  Euler の公式 `ex(t) = ofK(cs t) + I·ofK(sn t)` と偶奇 `cs(−t) = cs t`・`sn(−t) = −sn t` だけを満たす
  （複素指数関数 `t ↦ exp(it)`・実余弦・実正弦にあたる）。周期性・連続性・`cs² + sn² = 1` は使わない。
- モードは `zⁿ = 1`（`0 < n`）と、共役の主張の結論 `z = α + βω`・`z⁻¹ = α − βω` だけを使う。
-/
import Mathlib.Algebra.Ring.Subring.Basic
import Mathlib.Algebra.GroupWithZero.Basic
import Mathlib.Tactic.NoncommRing

namespace Ising2DLambda.NecSuf.RealEscape

variable {F A K C : Type*} [DivisionRing F] [Ring A] [Ring K] [Ring C]

/-- 準備の段: `z ≠ 0`（三行の矛盾）と `z + z⁻¹ = 2α + 0·ω`（三行）。 -/
theorem mode_add_inv_decomposition_necSuf (S : Subring F) (ω : F) (n : ℕ) (hn : 0 < n)
    (z : F) (hz : z ^ n = 1) (α β : S)
    (hzαβ : z = (α : F) + (β : F) * ω) (hzinv : z⁻¹ = (α : F) - (β : F) * ω) :
    z ≠ 0 ∧ z + z⁻¹ = ((2 * α : S) : F) + ((0 : S) : F) * ω := by
  have hz0 : z ≠ 0 := by
    intro h0
    apply one_ne_zero (α := F)
    calc (1 : F) = z ^ n := hz.symm
      _ = 0 ^ n := by rw [h0]
      _ = 0 := zero_pow hn.ne'
  refine ⟨hz0, ?_⟩
  calc z + z⁻¹
      = ((α : F) + (β : F) * ω) + ((α : F) - (β : F) * ω) := by
        rw [hzinv]; nth_rewrite 1 [hzαβ]; rfl
    _ = 2 * (α : F) := by noncomm_ring
    _ = ((2 * α : S) : F) + ((0 : S) : F) * ω := by
        rw [Subring.coe_mul, Subring.coe_zero, zero_mul, add_zero]; norm_cast

/-- 八行: `ρC(z) = ex(θ)` かつ `z ≠ 0` なら `ρC(z⁻¹) = ex(−θ)`。 -/
theorem realization_inv_eq_ex_neg_necSuf (ρC : F → C)
    (ρC_mul : ∀ x y, ρC (x * y) = ρC x * ρC y) (ρC_one : ρC 1 = 1)
    (ex : K → C) (ex_add : ∀ s t, ex (s + t) = ex s * ex t) (ex_zero : ex 0 = 1)
    (z : F) (hz0 : z ≠ 0) (θ : K) (hexp : ρC z = ex θ) :
    ρC z⁻¹ = ex (-θ) := by
  calc ρC z⁻¹ = 1 * ρC z⁻¹ := (one_mul _).symm
    _ = ex 0 * ρC z⁻¹ := by rw [ex_zero]
    _ = ex (-θ + θ) * ρC z⁻¹ := by rw [neg_add_cancel]
    _ = ex (-θ) * ex θ * ρC z⁻¹ := by rw [ex_add]
    _ = ex (-θ) * (ρC z * ρC z⁻¹) := by rw [hexp, mul_assoc]
    _ = ex (-θ) * ρC (z * z⁻¹) := by rw [ρC_mul]
    _ = ex (-θ) * ρC 1 := by rw [mul_inv_cancel₀ hz0]
    _ = ex (-θ) := by rw [ρC_one, mul_one]

/-- 九行: `ρR(2α) = 2·cs(θ)`。 -/
theorem realization_two_mul_eq_two_cs_necSuf (S : Subring F) (ω : F) (ρR : S → K)
    (ofK : K →+* C) (I : C) (re : C → K) (re_spec : ∀ x y, re (ofK x + I * ofK y) = x)
    (ρC : F → C) (ρC_eq : ∀ a b : S, ρC ((a : F) + (b : F) * ω) = ofK (ρR a) + I * ofK (ρR b))
    (ρC_add : ∀ x y, ρC (x + y) = ρC x + ρC y)
    (ex : K → C) (cs sn : K → K) (euler : ∀ t, ex t = ofK (cs t) + I * ofK (sn t))
    (cs_neg : ∀ t, cs (-t) = cs t) (sn_neg : ∀ t, sn (-t) = -sn t)
    (z : F) (α : S) (hsum : z + z⁻¹ = ((2 * α : S) : F) + ((0 : S) : F) * ω)
    (θ : K) (hexp : ρC z = ex θ) (hexpInv : ρC z⁻¹ = ex (-θ)) :
    ρR (2 * α) = 2 * cs θ := by
  calc ρR (2 * α)
      = re (ofK (ρR (2 * α)) + I * ofK (ρR 0)) := (re_spec _ _).symm
    _ = re (ρC (((2 * α : S) : F) + ((0 : S) : F) * ω)) := by rw [ρC_eq]
    _ = re (ρC (z + z⁻¹)) := by rw [hsum]
    _ = re (ρC z + ρC z⁻¹) := by rw [ρC_add]
    _ = re (ex θ + ex (-θ)) := by rw [hexp, hexpInv]
    _ = re ((ofK (cs θ) + I * ofK (sn θ)) + (ofK (cs (-θ)) + I * ofK (sn (-θ)))) := by
        rw [euler, euler]
    _ = re ((ofK (cs θ) + I * ofK (sn θ)) + (ofK (cs θ) - I * ofK (sn θ))) := by
        rw [cs_neg, sn_neg, map_neg, mul_neg, ← sub_eq_add_neg]
    _ = re (ofK (2 * cs θ) + I * ofK 0) := by
        congr 1
        rw [map_mul, map_ofNat, map_zero, mul_zero, add_zero]
        noncomm_ring
    _ = 2 * cs θ := re_spec _ _

/-- 必要十分版の本体。`ρR(D) = (1 + j(q)²)² − 2j(q)(1 − j(q)²)(cs θ₁ + cs θ₂)`。 -/
theorem dispersion_angle_realization_necSuf (S : Subring F) (ω : F) (ρR : S → K)
    (ρR_add : ∀ x y, ρR (x + y) = ρR x + ρR y) (ρR_mul : ∀ x y, ρR (x * y) = ρR x * ρR y)
    (jS : A →+* S) (j : A →+* K) (ρR_rat : ∀ u, ρR (jS u) = j u)
    (ofK : K →+* C) (I : C) (re : C → K) (re_spec : ∀ x y, re (ofK x + I * ofK y) = x)
    (ρC : F → C) (ρC_eq : ∀ a b : S, ρC ((a : F) + (b : F) * ω) = ofK (ρR a) + I * ofK (ρR b))
    (ρC_add : ∀ x y, ρC (x + y) = ρC x + ρC y) (ρC_mul : ∀ x y, ρC (x * y) = ρC x * ρC y)
    (ρC_one : ρC 1 = 1)
    (ex : K → C) (ex_add : ∀ s t, ex (s + t) = ex s * ex t) (ex_zero : ex 0 = 1)
    (cs sn : K → K) (euler : ∀ t, ex t = ofK (cs t) + I * ofK (sn t))
    (cs_neg : ∀ t, cs (-t) = cs t) (sn_neg : ∀ t, sn (-t) = -sn t)
    (n : ℕ) (hn : 0 < n) (z w : F) (hz : z ^ n = 1) (hw : w ^ n = 1)
    (α β γ δ : S)
    (hzαβ : z = (α : F) + (β : F) * ω) (hzinv : z⁻¹ = (α : F) - (β : F) * ω)
    (hwγδ : w = (γ : F) + (δ : F) * ω) (hwinv : w⁻¹ = (γ : F) - (δ : F) * ω)
    (θ₁ θ₂ : K) (hzexp : ρC z = ex θ₁) (hwexp : ρC w = ex θ₂)
    (q : A) (D : S)
    (hD : (D : F) = (1 + ((jS q : S) : F) ^ 2) ^ 2 -
      ((jS q : S) : F) * (1 - ((jS q : S) : F) ^ 2) * (z + z⁻¹ + w + w⁻¹)) :
    ρR D = (1 + j q ^ 2) ^ 2 - 2 * j q * (1 - j q ^ 2) * (cs θ₁ + cs θ₂) := by
  obtain ⟨hz0, hzsum⟩ := mode_add_inv_decomposition_necSuf S ω n hn z hz α β hzαβ hzinv
  obtain ⟨hw0, hwsum⟩ := mode_add_inv_decomposition_necSuf S ω n hn w hw γ δ hwγδ hwinv
  have hcs₁ : ρR (2 * α) = 2 * cs θ₁ :=
    realization_two_mul_eq_two_cs_necSuf S ω ρR ofK I re re_spec ρC ρC_eq ρC_add ex cs sn euler
      cs_neg sn_neg z α hzsum θ₁ hzexp
      (realization_inv_eq_ex_neg_necSuf ρC ρC_mul ρC_one ex ex_add ex_zero z hz0 θ₁ hzexp)
  have hcs₂ : ρR (2 * γ) = 2 * cs θ₂ :=
    realization_two_mul_eq_two_cs_necSuf S ω ρR ofK I re re_spec ρC ρC_eq ρC_add ex cs sn euler
      cs_neg sn_neg w γ hwsum θ₂ hwexp
      (realization_inv_eq_ex_neg_necSuf ρC ρC_mul ρC_one ex ex_add ex_zero w hw0 θ₂ hwexp)
  set m : S := jS ((1 + q ^ 2) ^ 2) with hm
  set k : S := jS (q * (1 - q ^ 2)) with hk
  set v : S := k * (2 * α + 2 * γ) with hv
  have hDR : D = m - v := by
    apply Subtype.ext
    calc (D : F)
        = (1 + ((jS q : S) : F) ^ 2) ^ 2 -
            ((jS q : S) : F) * (1 - ((jS q : S) : F) ^ 2) * (z + z⁻¹ + w + w⁻¹) := hD
      _ = (m : F) - (k : F) * ((z + z⁻¹) + (w + w⁻¹)) := by
          rw [hm, hk]
          simp only [map_pow, map_add, map_one, map_mul, map_sub]
          push_cast
          noncomm_ring
      _ = ((m - v : S) : F) := by
          rw [hzsum, hwsum, hv]
          push_cast
          noncomm_ring
  calc ρR D = ρR (m - v) := by rw [hDR]
    _ = ρR (m - v) + ρR v - ρR v := by rw [add_sub_cancel_right]
    _ = ρR ((m - v) + v) - ρR v := by rw [ρR_add]
    _ = ρR m - ρR v := by rw [sub_add_cancel]
    _ = ρR m - ρR k * ρR (2 * α + 2 * γ) := by rw [hv, ρR_mul]
    _ = ρR m - ρR k * (ρR (2 * α) + ρR (2 * γ)) := by rw [ρR_add]
    _ = j ((1 + q ^ 2) ^ 2) - j (q * (1 - q ^ 2)) * (ρR (2 * α) + ρR (2 * γ)) := by
        rw [hm, hk, ρR_rat, ρR_rat]
    _ = j ((1 + q ^ 2) ^ 2) - j (q * (1 - q ^ 2)) * (2 * cs θ₁ + 2 * cs θ₂) := by
        rw [hcs₁, hcs₂]
    _ = (1 + j q ^ 2) ^ 2 - j q * (1 - j q ^ 2) * (2 * cs θ₁ + 2 * cs θ₂) := by
        simp only [map_pow, map_add, map_one, map_mul, map_sub]
    _ = (1 + j q ^ 2) ^ 2 - 2 * j q * (1 - j q ^ 2) * (cs θ₁ + cs θ₂) := by
        -- 2x = x + x で数 2 を消してから展開する（K の可換性は使わない）
        simp only [two_mul]
        noncomm_ring

end Ising2DLambda.NecSuf.RealEscape
