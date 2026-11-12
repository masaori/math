/-
`claim_complex_realization_preserves_addition`（複素実現は加法を保つ）の必要十分版。

具体版と同じ手順（一意表示を取り、ξ + η = (a + c) + (b + d)ω を作り、一意性で ξ + η の表示と読み、
係数の実現値の加法保存と ℂ の分配・結合・交換法則でまとめ直す）を、
α・β と写像 coeff（係数の包含 a ↦ a）・scale（b ↦ bω）・decomposition・realization だけで書く。
仮定は次のとおりである。
  - α の加法の結合法則と交換法則（AddCommSemigroup）: ξ + η を (a + c) + (bω + dω) へ並べ替える段に要る。
  - coeffAdd: 係数の包含は加法を保つ（具体版では部分体の加法が Q̄ の加法の制限であること）。
  - scaleAdd: bω + dω = (b + d)ω（具体版では Q̄ の分配法則と部分体の加法）。
  - unique: α の元が coeff a + scale b と書けたら decomposition はその (a, b) を返す（一意表示）。
  - realAdd: 係数の実現値は加法を保つ（具体版では `claim_cut_realization_preserves_addition`）。
α・β に零・逆元・乗法は要らない。表示の存在も、ξ, η の表示を仮定 hxi, heta で受けるので要らない。
-/
import Ising2DLambda.NecSuf.RealEscape.ComplexAlgebraicRealization

namespace Ising2DLambda.NecSuf.RealEscape

theorem complexRealization_preserves_addition_necSuf {α β : Type*} [AddCommSemigroup α] [Add β]
    (coeff scale : β → α) (decomposition : α → β × β) (realization : β → ℝ)
    (coeffAdd : ∀ a c : β, coeff (a + c) = coeff a + coeff c)
    (scaleAdd : ∀ b d : β, scale (b + d) = scale b + scale d)
    (unique : ∀ (xi : α) (a b : β), xi = coeff a + scale b → decomposition xi = (a, b))
    (realAdd : ∀ a c : β, realization (a + c) = realization a + realization c)
    {xi eta : α} {a b c d : β}
    (hxi : xi = coeff a + scale b) (heta : eta = coeff c + scale d) :
    complexRealization decomposition realization (xi + eta) =
      complexRealization decomposition realization xi +
        complexRealization decomposition realization eta := by
  have hsum : xi + eta = coeff (a + c) + scale (b + d) := by
    calc
      xi + eta = (coeff a + scale b) + (coeff c + scale d) := by rw [hxi, heta]
      _ = (coeff a + coeff c) + (scale b + scale d) := by ac_rfl
      _ = coeff (a + c) + scale (b + d) := by rw [coeffAdd, scaleAdd]
  calc
    complexRealization decomposition realization (xi + eta)
        = (realization (a + c) : ℂ) + Complex.I * (realization (b + d) : ℂ) := by
      simp only [complexRealization, unique _ _ _ hsum]
    _ = ((realization a + realization c : ℝ) : ℂ) +
          Complex.I * ((realization b + realization d : ℝ) : ℂ) := by
      rw [realAdd, realAdd]
    _ = ((realization a : ℂ) + (realization c : ℂ)) +
          (Complex.I * (realization b : ℂ) + Complex.I * (realization d : ℂ)) := by
      rw [Complex.ofReal_add, Complex.ofReal_add, mul_add]
    _ = ((realization a : ℂ) + Complex.I * (realization b : ℂ)) +
          ((realization c : ℂ) + Complex.I * (realization d : ℂ)) := by
      ac_rfl
    _ = complexRealization decomposition realization xi +
          complexRealization decomposition realization eta := by
      simp only [complexRealization, unique _ _ _ hxi, unique _ _ _ heta]

end Ising2DLambda.NecSuf.RealEscape
