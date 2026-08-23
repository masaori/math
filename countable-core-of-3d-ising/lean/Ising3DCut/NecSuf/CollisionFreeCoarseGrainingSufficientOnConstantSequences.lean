/-
「定数列の族に限れば、衝突を持たない粗視化は十分である」の Lean 必要十分版。

具体版が使うのは、粗視化写像の単射性、二列がそれぞれ定数列であること、粗視化した
二列が一点で一致すること、値を極限空間へ送った定数列がその値へ収束することだけである。
正の有理数・乗根・順序・代数構造は使わない。定数列の収束を述べるための位相だけを残す。
-/
import Mathlib.Topology.Basic
import Mathlib.Topology.Constructions
import Mathlib.Order.Filter.AtTopBot.Defs

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 単射な粗視化について、二つの定数列の粗視化が一致すれば、値の像の列は共通の値へ収束する。 -/
theorem collision_free_map_is_sufficient_on_constant_sequences
    {V S X : Type*} [TopologicalSpace X]
    (π : V → S) (val : V → X) (Good : V → Prop)
    (hfree : ∀ a b, Good a → Good b → π a = π b → a = b)
    (u w : V) (hu : Good u) (hw : Good w) (A B : ℕ → V)
    (hA : ∀ L, A L = u) (hB : ∀ L, B L = w)
    (hagree : ∀ L, π (A L) = π (B L)) :
    ∃ ℓ : X,
      Tendsto (fun L => val (A L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => val (B L)) atTop (𝓝 ℓ) := by
  have hpi : π u = π w := by
    have := hagree 1
    rwa [hA 1, hB 1] at this
  have huw : u = w := hfree u w hu hw hpi
  refine ⟨val u, ?_, ?_⟩
  · have : (fun L => val (A L)) = fun _ : ℕ => val u := by
      funext L
      rw [hA L]
    rw [this]
    exact tendsto_const_nhds
  · have : (fun L => val (B L)) = fun _ : ℕ => val u := by
      funext L
      rw [hB L, ← huw]
    rw [this]
    exact tendsto_const_nhds

end Ising3DCut.NecSuf
