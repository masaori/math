/-
`claim_complex_realization_twisted_modes_are_complex_roots` の必要十分版。

具体版と同じ手順（複素実現が冪を保つことを零乗と冪の定義の帰納法で示し、目標の値 t を
coeff q + scale z₀ の表示から ρ(q) + iρ(z₀) = r + i0 = r と実現し、ρ_C(z)^L = ρ_C(z^L) = ρ_C(t) = r と結ぶ）を、
写像 coeff・scale・decomposition・realization だけで書く。仮定は次のとおりである。
  - α はモノイド: z^L と帰納法の冪の定義に要る。可換性・加法の公理は使わない。
  - α の加法（Add）: t の表示 coeff q + scale z₀ を書くのに要る。結合・交換法則は使わない。
  - mulPres・onePres: 複素実現は乗法と単位元を保つ（具体版では
    `claim_complex_realization_preserves_multiplication`）。冪の保存の帰納法の二段に一つずつ要る。
  - unique: α の元が coeff a + scale b と書けたら decomposition はその (a, b) を返す（一意表示）。
    t の実現を係数の実現値で読むのに要る。表示の存在は t の表示を仮定 ht で受けるので要らない。
  - realQ・realZero: 係数の実現値 ρ(q) = r、ρ(z₀) = 0（具体版では
    `claim_cut_realization_agrees_on_rationals` の q = (-1)^c と q = 0）。
β に演算は要らない。
-/
import Ising2DLambda.NecSuf.RealEscape.ComplexAlgebraicRealization

namespace Ising2DLambda.NecSuf.RealEscape

/-- 複素実現が冪を保つこと（帰納法）。 -/
theorem complexRealization_pow_necSuf {α β : Type*} [Monoid α]
    (decomposition : α → β × β) (realization : β → ℝ)
    (mulPres : ∀ x y : α, complexRealization decomposition realization (x * y) =
      complexRealization decomposition realization x * complexRealization decomposition realization y)
    (onePres : complexRealization decomposition realization 1 = 1) (z : α) :
    ∀ n : ℕ, complexRealization decomposition realization (z ^ n) =
      complexRealization decomposition realization z ^ n
  | 0 => by
    calc
      complexRealization decomposition realization (z ^ 0) =
          complexRealization decomposition realization 1 := by rw [pow_zero]
      _ = 1 := onePres
      _ = complexRealization decomposition realization z ^ 0 := by rw [pow_zero]
  | n + 1 => by
    calc
      complexRealization decomposition realization (z ^ (n + 1)) =
          complexRealization decomposition realization (z ^ n * z) := by rw [pow_succ]
      _ = complexRealization decomposition realization (z ^ n) *
            complexRealization decomposition realization z := mulPres _ _
      _ = complexRealization decomposition realization z ^ n *
            complexRealization decomposition realization z := by
        rw [complexRealization_pow_necSuf decomposition realization mulPres onePres z n]
      _ = complexRealization decomposition realization z ^ (n + 1) := by rw [pow_succ]

/-- 係数表示 coeff q + scale z₀ の元の実現は r + i0 = r。 -/
theorem complexRealization_coeff_necSuf {α β : Type*} [Add α]
    (coeff scale : β → α) (decomposition : α → β × β) (realization : β → ℝ)
    (unique : ∀ (xi : α) (a b : β), xi = coeff a + scale b → decomposition xi = (a, b))
    {t : α} {q z₀ : β} (ht : t = coeff q + scale z₀) {r : ℝ}
    (realQ : realization q = r) (realZero : realization z₀ = 0) :
    complexRealization decomposition realization t = (r : ℂ) := by
  calc
    complexRealization decomposition realization t
        = (realization q : ℂ) + Complex.I * (realization z₀ : ℂ) := by
      simp only [complexRealization, unique _ _ _ ht]
    _ = (r : ℂ) + Complex.I * ((0 : ℝ) : ℂ) := by rw [realQ, realZero]
    _ = (r : ℂ) := by rw [Complex.ofReal_zero, mul_zero, add_zero]

/-- 必要十分版: z^L = t、t = coeff q + scale z₀ なら ρ_C(z)^L = r。 -/
theorem complexRealization_root_necSuf {α β : Type*} [Monoid α] [Add α]
    (coeff scale : β → α) (decomposition : α → β × β) (realization : β → ℝ)
    (mulPres : ∀ x y : α, complexRealization decomposition realization (x * y) =
      complexRealization decomposition realization x * complexRealization decomposition realization y)
    (onePres : complexRealization decomposition realization 1 = 1)
    (unique : ∀ (xi : α) (a b : β), xi = coeff a + scale b → decomposition xi = (a, b))
    {t : α} {q z₀ : β} (ht : t = coeff q + scale z₀) {r : ℝ}
    (realQ : realization q = r) (realZero : realization z₀ = 0)
    (L : ℕ) {z : α} (hz : z ^ L = t) :
    complexRealization decomposition realization z ^ L = (r : ℂ) := by
  calc
    complexRealization decomposition realization z ^ L =
        complexRealization decomposition realization (z ^ L) :=
      (complexRealization_pow_necSuf decomposition realization mulPres onePres z L).symm
    _ = complexRealization decomposition realization t := by rw [hz]
    _ = (r : ℂ) :=
      complexRealization_coeff_necSuf coeff scale decomposition realization unique ht realQ realZero

end Ising2DLambda.NecSuf.RealEscape
