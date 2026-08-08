/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版の `orbit` / `orbitSet` に ι := RowConfig L、f := rowShift L を代入すると、
具体版の `rowShiftOrbit` / `rowShiftOrbitSet` と同じものが出る。代入する仮定は次だけである。

  R_L が有限で相等が判定できること
  各点について K(τ) が空でないこと   ← S^[L](τ) = τ（`rowShiftIterate_period`）と L ≥ 1

**単射性も全射性も渡していない。** 前の主張（軌道の元の個数）は S の単射性を渡していたが、
分割の側はそれすら要らない。人手証明が「逆向きに辿る代わりに e·m 回の反復で前向きに
辿り着く」形で書かれているためである。

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・スピンの値が ±1 であること・シフトが巡回であること・
S が全単射であること・S の位数が L であること・最小周期の最小性。

住処: ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbitPartition
import Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbitFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowShiftOrbitPartition

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 主張「軌道の元の軌道はもとの軌道に等しい」を、必要十分版から導いたもの。 -/
theorem rowShiftOrbit_eq_of_mem_from_necSuf (τ : RowConfig L) {τ' : RowConfig L}
    (hτ' : τ' ∈ rowShiftOrbit L τ) : rowShiftOrbit L τ' = rowShiftOrbit L τ := by
  rw [rowShiftOrbit_eq_necSuf, rowShiftOrbit_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.orbit_eq_of_mem (rowShift L) τ (iterLeft_period_exists τ)
    ((rowShiftOrbit_eq_necSuf τ) ▸ hτ')

/-- 主張「2 つの軌道は一致するか互いに素である」を、必要十分版から導いたもの。 -/
theorem rowShiftOrbit_eq_of_inter_nonempty_from_necSuf (τ₁ τ₂ : RowConfig L)
    (hne : (rowShiftOrbit L τ₁ ∩ rowShiftOrbit L τ₂).Nonempty) :
    rowShiftOrbit L τ₁ = rowShiftOrbit L τ₂ := by
  rw [rowShiftOrbit_eq_necSuf, rowShiftOrbit_eq_necSuf]
  refine NecSuf.AlgebraicEigenvalue.orbit_eq_of_inter_nonempty (rowShift L) τ₁ τ₂
    (iterLeft_period_exists τ₁) (iterLeft_period_exists τ₂) ?_
  obtain ⟨τ₃, hτ₃⟩ := hne
  exact ⟨τ₃, by rwa [← rowShiftOrbit_eq_necSuf, ← rowShiftOrbit_eq_necSuf]⟩

/-- 具体版の軌道の全体が、必要十分版の軌道の全体の特殊化であること。 -/
theorem rowShiftOrbitSet_eq_necSuf :
    rowShiftOrbitSet L = NecSuf.AlgebraicEigenvalue.orbitSet (RowConfig L) (rowShift L) := by
  classical
  ext O
  rw [mem_rowShiftOrbitSet, NecSuf.AlgebraicEigenvalue.mem_orbitSet]
  constructor
  · rintro ⟨τ, hτ⟩
    exact ⟨τ, by rw [← rowShiftOrbit_eq_necSuf, hτ]⟩
  · rintro ⟨τ, hτ⟩
    exact ⟨τ, by rw [rowShiftOrbit_eq_necSuf, hτ]⟩

/-- 主張「軌道の全体は行配位の全体の分割である」を、必要十分版から導いたもの。 -/
theorem rowShiftOrbitSet_partition_from_necSuf :
    (∀ O ∈ rowShiftOrbitSet L, O.Nonempty)
      ∧ (∀ O₁ ∈ rowShiftOrbitSet L, ∀ O₂ ∈ rowShiftOrbitSet L, O₁ ≠ O₂ → Disjoint O₁ O₂)
      ∧ (rowShiftOrbitSet L).biUnion id = (univ : Finset (RowConfig L)) := by
  rw [rowShiftOrbitSet_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.orbitSet_partition (rowShift L) iterLeft_period_exists

end Ising2DLambda.AlgebraicEigenvalue
