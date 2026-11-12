/-
`claim_complex_realization_injective`（複素実現は単射である）の必要十分版。

具体版と同じ手順（一意表示を取り、ρ(a) + iρ(b) = ρ(c) + iρ(d) を作り、実部と虚部を取り出し、
係数の実現値の単射性で a = c, b = d とし、表示へ戻す）を、
α・β と写像 coeff（係数の包含 a ↦ a）・scale（b ↦ bω）・decomposition・realization だけで書く。
仮定は次のとおりである。
  - α の加法（Add）: 表示 coeff a + scale b を書くのに要る。結合・交換法則は使わない。
  - represent: α の任意の元は coeff a + scale b と書ける（一意表示の存在）。
    これを外すと、表示を持たない元の像は decomposition の任意の値で決まり、単射性は従わない。
  - unique: α の元が coeff a + scale b と書けたら decomposition はその (a, b) を返す（一意表示の一意性）。
  - realInj: 係数の実現値は単射（具体版では `claim_cut_realization_preserves_strict_order` の単射性）。
β に演算は要らない。ℂ からは実部・虚部の取り出しだけを使う。
-/
import Ising2DLambda.NecSuf.RealEscape.ComplexAlgebraicRealization

namespace Ising2DLambda.NecSuf.RealEscape

theorem complexRealization_injective_necSuf {α β : Type*} [Add α]
    (coeff scale : β → α) (decomposition : α → β × β) (realization : β → ℝ)
    (represent : ∀ xi : α, ∃ a b : β, xi = coeff a + scale b)
    (unique : ∀ (xi : α) (a b : β), xi = coeff a + scale b → decomposition xi = (a, b))
    (realInj : Function.Injective realization) :
    Function.Injective (complexRealization decomposition realization) := by
  intro xi eta h
  obtain ⟨a, b, hxi⟩ := represent xi
  obtain ⟨c, d, heta⟩ := represent eta
  have hC : (realization a : ℂ) + Complex.I * (realization b : ℂ) =
      (realization c : ℂ) + Complex.I * (realization d : ℂ) := by
    calc
      (realization a : ℂ) + Complex.I * (realization b : ℂ)
          = complexRealization decomposition realization xi := by
        simp only [complexRealization, unique _ _ _ hxi]
      _ = complexRealization decomposition realization eta := h
      _ = (realization c : ℂ) + Complex.I * (realization d : ℂ) := by
        simp only [complexRealization, unique _ _ _ heta]
  have hre : realization a = realization c := by
    calc
      realization a = ((realization a : ℂ) + Complex.I * (realization b : ℂ)).re := by simp
      _ = ((realization c : ℂ) + Complex.I * (realization d : ℂ)).re := by rw [hC]
      _ = realization c := by simp
  have him : realization b = realization d := by
    calc
      realization b = ((realization a : ℂ) + Complex.I * (realization b : ℂ)).im := by simp
      _ = ((realization c : ℂ) + Complex.I * (realization d : ℂ)).im := by rw [hC]
      _ = realization d := by simp
  have hac : a = c := realInj hre
  have hbd : b = d := realInj him
  calc
    xi = coeff a + scale b := hxi
    _ = coeff c + scale d := by rw [hac, hbd]
    _ = eta := heta.symm

end Ising2DLambda.NecSuf.RealEscape
