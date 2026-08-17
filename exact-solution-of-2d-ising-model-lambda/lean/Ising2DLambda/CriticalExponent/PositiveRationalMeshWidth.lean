/-
人手証明 `claim_positive_rational_mesh_width` の具体版。

  人手証明                                           このファイル
  ε := min(δ, 1) > 0 を置く                          `epsilon` と `hEpsilon`
  Q の Archimedes 性から 1/(n+1) < ε を満たす n を取る  `exists_nat_one_div_lt`
  h := 1/(n+1) は正で h < 1                          `hPositive` と `hLtOne`
  h² < h < ε ≤ δ                                     `mul_lt_of_lt_one_right` と推移律

住処: Q。実数体・複素数体は現れない。
-/
import Mathlib.Algebra.Order.Archimedean.Basic

namespace Ising2DLambda.CriticalExponent

/-- 正の有理数 δ に対し、平方が δ より小さい正の有理網幅 1/N が取れる。 -/
theorem positiveRational_exists_meshWidth_square_lt (delta : ℚ) (hDelta : 0 < delta) :
    ∃ N : ℕ, 1 ≤ N ∧
      0 < (1 / (N : ℚ)) ∧
      (1 / (N : ℚ)) * (1 / (N : ℚ)) < delta := by
  let epsilon : ℚ := min delta 1
  have hEpsilon : 0 < epsilon := by
    simpa [epsilon] using lt_min hDelta (by norm_num : (0 : ℚ) < 1)
  obtain ⟨n, hn⟩ := exists_nat_one_div_lt hEpsilon
  let h : ℚ := 1 / ((n + 1 : ℕ) : ℚ)
  have hPositive : 0 < h := by
    exact one_div_pos.mpr (by
      simpa [Nat.cast_add] using (n.cast_add_one_pos : (0 : ℚ) < (n : ℚ) + 1))
  have hLtEpsilon : h < epsilon := by
    simpa [h] using hn
  have hLtOne : h < 1 := hLtEpsilon.trans_le (by simp [epsilon])
  have hSquareLtH : h * h < h := mul_lt_of_lt_one_right hPositive hLtOne
  refine ⟨n + 1, Nat.succ_le_succ (Nat.zero_le n), ?_, ?_⟩
  · simpa [h] using hPositive
  · have hEpsilonLeDelta : epsilon ≤ delta := by simp [epsilon]
    simpa [h] using (hSquareLtH.trans hLtEpsilon).trans_le hEpsilonLeDelta

end Ising2DLambda.CriticalExponent
