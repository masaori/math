/-
「周期境界の密度の下組は開境界正方形の密度の下組に含まれる」の必要十分版。

具体版が使うのは、関係 `le` が推移的であることと、二つの列が `L ≥ 1` で項ごとに `le` で
比較できること（`l L ≤ l' L`）だけである。加法は `Add X` で足り（結合則・交換則・単位元・逆元・
加法単調性は使わない）、`Zero X` は `0 ≤ ε` を述べる名前としてだけ要る。
順序の線形性・有理数倍・`Λ_ℚ`・密度の中身は使わない。
下組は「列が定める下組は下に閉じている」の必要十分版の `lowerSetOfSequence` を共有する。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupSequenceLowerSet

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [Add X] [Zero X]

/-- 列 `l` が `L ≥ 1` で項ごとに列 `l'` 以下なら、`l` の下組は `l'` の下組に含まれる。
証人 `ε, N` を引き継ぎ、推移律だけで示す。 -/
theorem lowerSetOfSequence_subset_of_pointwise_le_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (l l' : ℕ → X) (hle : ∀ L : ℕ, 1 ≤ L → le (l L) (l' L)) :
    lowerSetOfSequence le l ⊆ lowerSetOfSequence le l' := by
  intro μ hμ
  obtain ⟨ε, hε0, hεne, N, hN1, hN⟩ := hμ
  refine ⟨ε, hε0, hεne, N, hN1, ?_⟩
  intro L hL
  exact htrans (hN L hL) (hle L (Nat.le_trans hN1 hL))

end Ising2DLambda.NecSuf.ThermodynamicLimit
