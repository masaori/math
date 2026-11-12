/-
`claim_complex_realization_preserves_multiplication`（複素実現は乗法と単位元を保つ）の必要十分版。

具体版と同じ手順（一意表示を取り、分配法則・乗法の結合交換法則・ω² = −1・加法の結合交換法則・分配法則で
ξη = (ac − bd) + (ad + bc)ω を作り、一意性で ξη の表示と読み、係数の実現値の加法・符号反転・乗法の保存と
ℂ の分配・交換・結合法則、i² = −1 でまとめ直す。単位元は 1 = 1 + 0ω の表示から）を、
写像 coeff（係数の包含）・decomposition・realization だけで書く。仮定は次のとおりである。
  - α は可換環: (bω)c = (bc)ω の並べ替えに乗法の交換法則が、ω² = −1 に単位元と符号反転が、
    分配法則による展開と括り出しに環の公理が要る。
  - β は環、coeff は環準同型: ac − bd と ad + bc を β の中で作り、その包含が α の演算に一致することに要る
    （具体版では部分体の演算が Q̄ の演算の制限であること）。β の乗法の交換法則は使わない。
  - omegaSq: ω·ω = −1（`def_real_closed_subfield` の条件）。
  - unique: α の元が coeff a + coeff b·ω と書けたら decomposition はその (a, b) を返す（一意表示）。
  - realAdd・realMul: 係数の実現値は加法と乗法を保つ（具体版では
    `claim_cut_realization_preserves_addition`・`claim_cut_realization_preserves_multiplication`）。
  - realZero・realOne: ρ(0) = 0、ρ(1) = 1（具体版では `claim_cut_realization_agrees_on_rationals`）。
    realZero は ρ(−x) = −ρ(x) を加法保存から出すのにも使う。
表示の存在は、ξ, η の表示を仮定 hxi, heta で受けるので要らない。
-/
import Ising2DLambda.NecSuf.RealEscape.ComplexAlgebraicRealization
import Mathlib.Algebra.Ring.Hom.Defs
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.RealEscape

/-- 加法保存と ρ(0) = 0 から ρ(−x) = −ρ(x)。 -/
theorem realization_neg_necSuf {β : Type*} [Ring β] (realization : β → ℝ)
    (realAdd : ∀ a c : β, realization (a + c) = realization a + realization c)
    (realZero : realization 0 = 0) (x : β) :
    realization (-x) = -realization x := by
  have h : realization x + realization (-x) = 0 := by
    rw [← realAdd, add_neg_cancel, realZero]
  exact (neg_eq_of_add_eq_zero_right h).symm

/-- 一つ目の式変形: (coeff a + coeff b·ω)(coeff c + coeff d·ω) = coeff (ac − bd) + coeff (ad + bc)·ω。 -/
theorem complexRealization_product_decomposition_necSuf {α β : Type*} [CommRing α] [Ring β]
    (coeff : β →+* α) (omega : α) (omegaSq : omega * omega = -1)
    {xi eta : α} {a b c d : β}
    (hxi : xi = coeff a + coeff b * omega) (heta : eta = coeff c + coeff d * omega) :
    xi * eta = coeff (a * c - b * d) + coeff (a * d + b * c) * omega := by
  calc
    xi * eta = (coeff a + coeff b * omega) * (coeff c + coeff d * omega) := by rw [hxi, heta]
    _ = coeff a * coeff c + coeff a * (coeff d * omega) + (coeff b * omega) * coeff c +
          (coeff b * omega) * (coeff d * omega) := by
      rw [add_mul, mul_add, mul_add, ← add_assoc]
    _ = coeff a * coeff c + (coeff a * coeff d) * omega + (coeff b * coeff c) * omega +
          (coeff b * coeff d) * (omega * omega) := by
      ring
    _ = coeff a * coeff c + (coeff a * coeff d) * omega + (coeff b * coeff c) * omega -
          coeff b * coeff d := by
      rw [omegaSq, mul_neg_one, ← sub_eq_add_neg]
    _ = (coeff a * coeff c - coeff b * coeff d) +
          ((coeff a * coeff d) * omega + (coeff b * coeff c) * omega) := by
      abel
    _ = (coeff a * coeff c - coeff b * coeff d) + (coeff a * coeff d + coeff b * coeff c) * omega := by
      rw [add_mul]
    _ = coeff (a * c - b * d) + coeff (a * d + b * c) * omega := by
      rw [map_sub, map_add, map_mul, map_mul, map_mul, map_mul]

theorem complexRealization_preserves_multiplication_necSuf {α β : Type*} [CommRing α] [Ring β]
    (coeff : β →+* α) (omega : α) (omegaSq : omega * omega = -1)
    (decomposition : α → β × β) (realization : β → ℝ)
    (unique : ∀ (xi : α) (a b : β), xi = coeff a + coeff b * omega → decomposition xi = (a, b))
    (realAdd : ∀ a c : β, realization (a + c) = realization a + realization c)
    (realMul : ∀ a c : β, realization (a * c) = realization a * realization c)
    (realZero : realization 0 = 0)
    {xi eta : α} {a b c d : β}
    (hxi : xi = coeff a + coeff b * omega) (heta : eta = coeff c + coeff d * omega) :
    complexRealization decomposition realization (xi * eta) =
      complexRealization decomposition realization xi *
        complexRealization decomposition realization eta := by
  have hprod := complexRealization_product_decomposition_necSuf coeff omega omegaSq hxi heta
  calc
    complexRealization decomposition realization (xi * eta)
        = (realization (a * c - b * d) : ℂ) + Complex.I * (realization (a * d + b * c) : ℂ) := by
      simp only [complexRealization, unique _ _ _ hprod]
    _ = ((realization (a * c) + realization (-(b * d)) : ℝ) : ℂ) +
          Complex.I * ((realization (a * d) + realization (b * c) : ℝ) : ℂ) := by
      rw [sub_eq_add_neg, realAdd (a * c), realAdd (a * d)]
    _ = ((realization (a * c) - realization (b * d) : ℝ) : ℂ) +
          Complex.I * ((realization (a * d) + realization (b * c) : ℝ) : ℂ) := by
      rw [realization_neg_necSuf realization realAdd realZero, ← sub_eq_add_neg]
    _ = ((realization a : ℂ) * realization c - (realization b : ℂ) * realization d) +
          Complex.I * ((realization a : ℂ) * realization d + (realization b : ℂ) * realization c) := by
      rw [realMul a c, realMul b d, realMul a d, realMul b c]
      push_cast
      rfl
    _ = ((realization a : ℂ) * realization c - (realization b : ℂ) * realization d) +
          (Complex.I * ((realization a : ℂ) * realization d) +
            Complex.I * ((realization b : ℂ) * realization c)) := by
      rw [mul_add]
    _ = (realization a : ℂ) * realization c + Complex.I * ((realization a : ℂ) * realization d) +
          Complex.I * ((realization b : ℂ) * realization c) -
          (realization b : ℂ) * realization d := by
      abel
    _ = (realization a : ℂ) * realization c + Complex.I * ((realization a : ℂ) * realization d) +
          Complex.I * ((realization b : ℂ) * realization c) +
          Complex.I ^ 2 * ((realization b : ℂ) * realization d) := by
      rw [Complex.I_sq, neg_one_mul, ← sub_eq_add_neg]
    _ = (realization a : ℂ) * realization c + (realization a : ℂ) * (Complex.I * realization d) +
          (Complex.I * realization b) * realization c +
          (Complex.I * realization b) * (Complex.I * realization d) := by
      ring
    _ = ((realization a : ℂ) + Complex.I * realization b) *
          ((realization c : ℂ) + Complex.I * realization d) := by
      rw [add_mul, mul_add, mul_add, ← add_assoc]
    _ = complexRealization decomposition realization xi *
          complexRealization decomposition realization eta := by
      simp only [complexRealization, unique _ _ _ hxi, unique _ _ _ heta]

theorem complexRealization_one_necSuf {α β : Type*} [CommRing α] [Ring β]
    (coeff : β →+* α) (omega : α)
    (decomposition : α → β × β) (realization : β → ℝ)
    (unique : ∀ (xi : α) (a b : β), xi = coeff a + coeff b * omega → decomposition xi = (a, b))
    (realZero : realization 0 = 0) (realOne : realization 1 = 1) :
    complexRealization decomposition realization 1 = 1 := by
  have h1 : (1 : α) = coeff 1 + coeff 0 * omega := by
    rw [map_one, map_zero, zero_mul, add_zero]
  calc
    complexRealization decomposition realization 1
        = (realization 1 : ℂ) + Complex.I * (realization 0 : ℂ) := by
      simp only [complexRealization, unique _ _ _ h1]
    _ = 1 + Complex.I * 0 := by
      rw [realOne, realZero, Complex.ofReal_one, Complex.ofReal_zero]
    _ = 1 := by
      rw [mul_zero, add_zero]

end Ising2DLambda.NecSuf.RealEscape
