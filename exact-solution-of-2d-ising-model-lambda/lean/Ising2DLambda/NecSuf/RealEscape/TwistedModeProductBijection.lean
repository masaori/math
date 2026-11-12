/-
`claim_twisted_mode_product_bijection` の必要十分版。

具体版と同じ手順（各成分の値域から組の値域、組の像の等号から射影の三行で成分の像の等号を出し
各成分の単射性で組の等号、各成分の全射性で逆像を取り組の像を三行で計算）を、集合と写像だけで書く。
仮定は二つの成分の写像 f・g がそれぞれ U → E・W → F の全単射であることだけである
（具体版では `claim_twisted_modes_complex_roots_bijection`）。値域・単射性・全射性の
三つとも使う: 値域を外すと組が E × F に入らず、単射性を外すと組の単射性が、
全射性を外すと組の全射性が従わない。α・β・γ・δ に演算は要らない
（複素実現の代数的性質は成分の全単射の中にしか現れない）。
-/
import Mathlib.Data.Set.Function
import Mathlib.Data.Set.Prod

namespace Ising2DLambda.NecSuf.RealEscape

/-- 成分ごとの写像の組 (p.1, p.2) ↦ (f p.1, g p.2)。 -/
def pairMap {α β γ δ : Type*} (f : α → γ) (g : β → δ) : α × β → γ × δ :=
  fun p => (f p.1, g p.2)

/-- 必要十分版: 成分が全単射なら組の写像も U × W → E × F の全単射。 -/
theorem pairMap_bijOn_necSuf {α β γ δ : Type*} (f : α → γ) (g : β → δ)
    (U : Set α) (W : Set β) (E : Set γ) (F : Set δ)
    (hf : Set.BijOn f U E) (hg : Set.BijOn g W F) :
    Set.BijOn (pairMap f g) (U ×ˢ W) (E ×ˢ F) := by
  refine ⟨?_, ?_, ?_⟩
  · -- 値域
    rintro ⟨u, v⟩ ⟨hu, hv⟩
    exact ⟨hf.mapsTo hu, hg.mapsTo hv⟩
  · -- 単射
    rintro ⟨u, v⟩ ⟨hu, hv⟩ ⟨u', v'⟩ ⟨hu', hv'⟩ hP
    have h1 : f u = f u' :=
      calc
        f u = (pairMap f g (u, v)).1 := rfl
        _ = (pairMap f g (u', v')).1 := by rw [hP]
        _ = f u' := rfl
    have h2 : g v = g v' :=
      calc
        g v = (pairMap f g (u, v)).2 := rfl
        _ = (pairMap f g (u', v')).2 := by rw [hP]
        _ = g v' := rfl
    have hueq : u = u' := hf.injOn hu hu' h1
    have hveq : v = v' := hg.injOn hv hv' h2
    calc
      ((u, v) : α × β) = (u', v) := by rw [hueq]
      _ = (u', v') := by rw [hveq]
  · -- 全射
    rintro ⟨z, w⟩ ⟨hz, hw⟩
    obtain ⟨u, hu, huz⟩ := hf.surjOn hz
    obtain ⟨v, hv, hvw⟩ := hg.surjOn hw
    refine ⟨(u, v), ⟨hu, hv⟩, ?_⟩
    calc
      pairMap f g (u, v) = (f u, g v) := rfl
      _ = (z, g v) := by rw [huz]
      _ = (z, w) := by rw [hvw]

end Ising2DLambda.NecSuf.RealEscape
