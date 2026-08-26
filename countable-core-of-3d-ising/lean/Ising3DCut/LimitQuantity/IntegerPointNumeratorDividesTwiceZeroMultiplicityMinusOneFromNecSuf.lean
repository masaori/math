import Ising3DCut.NecSuf.DivisibilityTransfersAlongAdditiveDecomposition
import Ising3DCut.LimitQuantity.IntegerPointNumeratorDividesTwiceZeroMultiplicityMinusOne

/-!
必要十分版 `NecSuf.dvd_of_additive_decomposition` から、人手証明の主張
（ラベル `claim_integer_point_numerator_divides_twice_zero_multiplicity_minus_one`）を導く。

具体側で足すのは次だけである。
`m = 0` の項の分離が加法的な分解を与えること、
多重度ゼロの値と分配多項式の値がいずれも 1 以上なので自然数の減法が整数の減法と一致すること。
-/

namespace Ising3DCut.LimitQuantity

open Ising3DCut.NecSuf

theorem integer_point_numerator_divides_twice_zero_multiplicity_minus_one_viaNecSuf
    {a E Z : ℕ} {Omega : ℕ → ℕ} (hOmega : 1 ≤ Omega 0)
    (hZ : Z = ∑ m ∈ Finset.range (E + 1), Omega m * a ^ m)
    (hdvd : a ∣ 2 * (Z - 1)) :
    a ∣ 2 * (Omega 0 - 1) := by
  set S := shiftedMultiplicitySum Omega a E with hS
  have hsplit : Z = Omega 0 + a * S := by
    rw [hZ, hS]; exact partition_sum_split_zero_term Omega a E
  have hZone : 1 ≤ Z := by omega
  -- 自然数の整除を整数の整除へ移す
  have hdvdInt : (a : ℤ) ∣ 2 * ((Z : ℤ) - 1) := by
    have := Int.natCast_dvd_natCast.mpr hdvd
    push_cast [Nat.cast_sub hZone] at this
    exact this
  have hdecomposition : (Z : ℤ) = (Omega 0 : ℤ) + (a : ℤ) * (S : ℤ) := by
    exact_mod_cast congrArg (Nat.cast : ℕ → ℤ) hsplit
  have hgoalInt : (a : ℤ) ∣ 2 * ((Omega 0 : ℤ) - 1) :=
    dvd_of_additive_decomposition hdecomposition hdvdInt
  have : ((2 * (Omega 0 - 1) : ℕ) : ℤ) = 2 * ((Omega 0 : ℤ) - 1) := by
    push_cast [Nat.cast_sub hOmega]; ring
  exact Int.natCast_dvd_natCast.mp (by rw [this]; exact hgoalInt)

end Ising3DCut.LimitQuantity
