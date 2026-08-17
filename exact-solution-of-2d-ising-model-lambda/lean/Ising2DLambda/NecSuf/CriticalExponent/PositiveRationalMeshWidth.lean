/-
`claim_positive_rational_mesh_width` の必要十分版。

具体版が使う本質は、Archimedes 的な線型順序体であることだけである。
有理数としての分子・分母表示、代数的数、平方根、完備性は使わない。
-/
import Mathlib.Algebra.Order.Archimedean.Basic

namespace Ising2DLambda.NecSuf.CriticalExponent

/-- Archimedes 的な線型順序体では、正の元より平方が小さい正の逆自然数が取れる。 -/
theorem exists_meshWidth_square_lt_necSuf {K : Type*}
    [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Archimedean K]
    (delta : K) (hDelta : 0 < delta) :
    ∃ N : ℕ, 1 ≤ N ∧
      0 < (1 / (N : K)) ∧
      (1 / (N : K)) * (1 / (N : K)) < delta := by
  let epsilon : K := min delta 1
  have hEpsilon : 0 < epsilon := by
    simpa [epsilon] using lt_min hDelta (zero_lt_one : (0 : K) < 1)
  obtain ⟨n, hn⟩ := exists_nat_one_div_lt hEpsilon
  let h : K := 1 / ((n + 1 : ℕ) : K)
  have hPositive : 0 < h := by
    exact one_div_pos.mpr (by
      simpa [Nat.cast_add] using (n.cast_add_one_pos : (0 : K) < (n : K) + 1))
  have hLtEpsilon : h < epsilon := by
    simpa [h] using hn
  have hLtOne : h < 1 := hLtEpsilon.trans_le (by simp [epsilon])
  have hSquareLtH : h * h < h := mul_lt_of_lt_one_right hPositive hLtOne
  refine ⟨n + 1, Nat.succ_le_succ (Nat.zero_le n), ?_, ?_⟩
  · simpa [h] using hPositive
  · have hEpsilonLeDelta : epsilon ≤ delta := by simp [epsilon]
    simpa [h] using (hSquareLtH.trans hLtEpsilon).trans_le hEpsilonLeDelta

end Ising2DLambda.NecSuf.CriticalExponent
