/-
章「熱力学極限」の「開境界正方形の自由エントロピー密度」（`def_open_square_free_entropy_density`）の具体版
（人手証明と 1 対 1 に対応させる）。

  人手証明の段                                                このファイル
  Ψ^op_L(q) := (1/L²)·ι(log Z^op_{L,L}(q)) ∈ Λ_ℚ               openScaledFreeEntropy
  各素数での値の三段の鎖（有理数倍の定義・ι の定義・ℚ の積）     openScaledFreeEntropy_apply

住処: ℕ・ℚ・Λ・Λ_ℚ のみ。ℝ / ℂ は現れない。周期境界の `scaledFreeEntropy`
（`RationalLogOrderGroup.lean`）と同じ形で、`freeEntropy L q` の代わりに開境界正方形の値
`openPartitionValueRat L L q` の対数 `logRat` を置いたものである。実数値の
`openSquareFreeEnergyDensity` はこの実数側の像であり、旧経路の撤去まで併存させる。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroup
import Ising2DLambda.ThermodynamicLimit.OpenRectanglePartitionValueRational

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `def_open_square_free_entropy_density`。開境界正方形の自由エントロピー密度
`Ψ^op_L(q) := (1/L^2)·ι(log Z^op_{L,L}(q)) ∈ Λ_ℚ`。 -/
noncomputable def openScaledFreeEntropy (L : ℕ) [NeZero L] (q : ℚ) : RationalLogOrderGroup :=
  ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (openPartitionValueRat L L q))

/-- `def_open_square_free_entropy_density` の各素数での値:
`Ψ^op_L(q)(p) = (log Z^op_{L,L}(q))(p) / L^2`。
人手証明の三段の鎖（有理数倍の定義・`ι` の定義・`ℚ` の積）と 1 対 1 に対応する。 -/
theorem openScaledFreeEntropy_apply (L : ℕ) [NeZero L] (q : ℚ) (p : Nat.Primes) :
    openScaledFreeEntropy L q p =
      ((logRat (openPartitionValueRat L L q) p : ℤ) : ℚ) / ((L : ℚ) ^ 2) := by
  calc
    openScaledFreeEntropy L q p
        = ((1 : ℚ) / ((L : ℚ) ^ 2)) * toRational (logRat (openPartitionValueRat L L q)) p :=
          Finsupp.smul_apply _ _ _                     -- 有理数倍の定義
    _ = ((1 : ℚ) / ((L : ℚ) ^ 2)) * ((logRat (openPartitionValueRat L L q) p : ℤ) : ℚ) := by
          rw [toRational_apply]                        -- ι の定義
    _ = ((logRat (openPartitionValueRat L L q) p : ℤ) : ℚ) / ((L : ℚ) ^ 2) := by
          rw [one_div, mul_comm, div_eq_mul_inv]       -- ℚ の積

end Ising2DLambda.ThermodynamicLimit
