/-
「値の衝突を持たない粗視化は、一般の族に対しても十分である」の Lean 必要十分版。

具体版が使うのは、良い値の上で粗視化写像が単射であること、各添字で粗視化した
二つの値が一致すること、各添字の値を極限空間へ送る写像、収束の書き換え、
極限の一意性だけである。正の有理数・乗根・順序・代数構造は使わない。
-/
import Mathlib.Topology.Basic
import Mathlib.Topology.Constructions
import Mathlib.Order.Filter.AtTopBot.Defs
import Mathlib.Topology.Separation.Hausdorff

namespace Ising3DCut.NecSuf

open Filter Topology

/-- 良い値を区別する粗視化の像が各添字で一致すれば、観測列は写像として等しい。 -/
theorem collision_free_map_gives_equal_observed_sequences
    {V S X : Type*} (π : V → S) (observe : ℕ → V → X) (Good : V → Prop)
    (hfree : ∀ a b, Good a → Good b → π a = π b → a = b)
    (A B : ℕ → V) (hA : ∀ L, Good (A L)) (hB : ∀ L, Good (B L))
    (hagree : ∀ L, π (A L) = π (B L)) :
    (fun L => observe L (A L)) = fun L => observe L (B L) := by
  funext L
  have hpi : π (A L) = π (B L) := hagree L
  have hval : A L = B L := hfree (A L) (B L) (hA L) (hB L) hpi
  rw [hval]

/-- 観測列の写像としての一致により、一方の収束は他方へ移る。 -/
theorem collision_free_map_is_sufficient_on_general_families
    {V S X : Type*} [TopologicalSpace X]
    (π : V → S) (observe : ℕ → V → X) (Good : V → Prop)
    (hfree : ∀ a b, Good a → Good b → π a = π b → a = b)
    (A B : ℕ → V) (hA : ∀ L, Good (A L)) (hB : ∀ L, Good (B L))
    (hagree : ∀ L, π (A L) = π (B L))
    (α : X) (hlimit : Tendsto (fun L => observe L (A L)) atTop (𝓝 α)) :
    Tendsto (fun L => observe L (B L)) atTop (𝓝 α) := by
  have heq := collision_free_map_gives_equal_observed_sequences
    π observe Good hfree A B hA hB hagree
  rwa [heq] at hlimit

/-- 極限が一意な空間では、二つの観測列に与えられた極限値も一致する。 -/
theorem collision_free_map_limits_agree_on_general_families
    {V S X : Type*} [TopologicalSpace X] [T2Space X]
    (π : V → S) (observe : ℕ → V → X) (Good : V → Prop)
    (hfree : ∀ a b, Good a → Good b → π a = π b → a = b)
    (A B : ℕ → V) (hA : ∀ L, Good (A L)) (hB : ∀ L, Good (B L))
    (hagree : ∀ L, π (A L) = π (B L))
    (α β : X)
    (hlimit : Tendsto (fun L => observe L (A L)) atTop (𝓝 α))
    (hlimit' : Tendsto (fun L => observe L (B L)) atTop (𝓝 β)) :
    α = β := by
  have hB' := collision_free_map_is_sufficient_on_general_families
    π observe Good hfree A B hA hB hagree α hlimit
  exact tendsto_nhds_unique hB' hlimit'

end Ising3DCut.NecSuf
