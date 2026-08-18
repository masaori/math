/-
先頭距離の詰め寄りから詰め寄りの述語の不等式を合成する論法の必要十分版。

必要なのは体の四則、`1 + 1` の平方表示、二平方和の平方表示と零性だけである。
体の仮定は零因子の不在（証人の非零性）に要る。`sumEqZero` は `1 + 1 ≠ 0`
（標数 2 の排除）も担う——標数 2 では `1·1 + 1·1 = 0` が `1 = 0` を強いるからである。
-/
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

namespace Ising2DLambda.NecSuf.CriticalExponent

/--
`η − dsq_c`、`η − (xc−q)²`、和の平方の評価の差をすべて平方証人で受けると、
`(1+1)·(1+1)·η − dsq(ξ,q)` の零元でない平方証人を構成できる。
人手証明の式変形の鎖（八段）と 1 対 1 に対応する。
-/
theorem pinch_bound_necSuf {K : Type*} [Field K]
    (sumIsSquare : ∀ a b : K, ∃ v : K, a * a + b * b = v * v)
    (sumEqZero : ∀ a b : K, a * a + b * b = 0 → a = 0 ∧ b = 0)
    (t : K) (ht : t * t = 1 + 1)
    (alpha beta xc q eta : K)
    (hCrit : ∃ c1 : K,
      c1 ≠ 0 ∧ eta - ((alpha - xc) * (alpha - xc) + beta * beta) = c1 * c1)
    (hApprox : ∃ c2 : K, c2 ≠ 0 ∧ eta - (xc - q) * (xc - q) = c2 * c2)
    (hSquare : ∃ g : K,
      ((1 + 1) * ((alpha - xc) * (alpha - xc)) + (1 + 1) * ((xc - q) * (xc - q)))
        - ((alpha - xc) + (xc - q)) * ((alpha - xc) + (xc - q)) = g * g) :
    ∃ z : K, z ≠ 0 ∧
      ((1 + 1) * (1 + 1)) * eta - ((alpha - q) * (alpha - q) + beta * beta)
        = z * z := by
  obtain ⟨c1, hc10, hc1⟩ := hCrit
  obtain ⟨c2, hc20, hc2⟩ := hApprox
  obtain ⟨g, hg⟩ := hSquare
  -- t ≠ 0（t = 0 なら 1 + 1 = 0 となり、sumEqZero が 1 = 0 を強いる）。
  have ht0 : t ≠ 0 := by
    intro h0
    have hsum : (1 : K) * 1 + 1 * 1 = 0 := by
      have h2 : (1 : K) + 1 = 0 := by rw [← ht, h0]; ring
      linear_combination h2
    exact one_ne_zero (sumEqZero 1 1 hsum).1
  -- 本文: t·c₁ と t·c₂ は零元でない（体は零因子を持たない）。
  have htc1 : t * c1 ≠ 0 := mul_ne_zero ht0 hc10
  have htc2 : t * c2 ≠ 0 := mul_ne_zero ht0 hc20
  -- 本文: 二平方和の平方表示を三度当て、各証人の非零性を零性から出す。
  obtain ⟨z1, hz1⟩ := sumIsSquare (t * c1) (t * c2)
  have hz10 : z1 ≠ 0 := by
    intro h0
    have hsum : (t * c1) * (t * c1) + (t * c2) * (t * c2) = 0 := by
      rw [hz1, h0]; ring
    exact htc1 (sumEqZero _ _ hsum).1
  obtain ⟨z2, hz2⟩ := sumIsSquare z1 g
  have hz20 : z2 ≠ 0 := by
    intro h0
    have hsum : z1 * z1 + g * g = 0 := by rw [hz2, h0]; ring
    exact hz10 (sumEqZero _ _ hsum).1
  obtain ⟨z3, hz3⟩ := sumIsSquare z2 beta
  have hz30 : z3 ≠ 0 := by
    intro h0
    have hsum : z2 * z2 + beta * beta = 0 := by rw [hz3, h0]; ring
    exact hz20 (sumEqZero _ _ hsum).1
  refine ⟨z3, hz30, ?_⟩
  -- 本文の式変形の鎖と 1 対 1。
  calc ((1 + 1) * (1 + 1)) * eta - ((alpha - q) * (alpha - q) + beta * beta)
      -- 本文: u+v = (α−xc)+(xc−q) = α−q（K の四則）。
      = ((1 + 1) * (1 + 1)) * eta
          - ((((alpha - xc) + (xc - q)) * ((alpha - xc) + (xc - q))) + beta * beta) := by
            ring
    -- 本文: 分配則と同じ項の整理。直前の書き換えと一度の `ring` に畳まない。
    _ = (1 + 1) * (eta - ((alpha - xc) * (alpha - xc) + beta * beta))
          + (1 + 1) * (eta - (xc - q) * (xc - q))
          + (((1 + 1) * ((alpha - xc) * (alpha - xc))
              + (1 + 1) * ((xc - q) * (xc - q)))
            - ((alpha - xc) + (xc - q)) * ((alpha - xc) + (xc - q)))
          + beta * beta := by ring
    _ = (1 + 1) * (c1 * c1) + (1 + 1) * (c2 * c2) + g * g + beta * beta := by
          rw [hc1, hc2, hg]
    _ = (t * c1) * (t * c1) + (t * c2) * (t * c2) + g * g + beta * beta := by
          linear_combination (-(c1 * c1) - c2 * c2) * ht
    _ = z1 * z1 + g * g + beta * beta := by rw [hz1]
    _ = z2 * z2 + beta * beta := by rw [hz2]
    _ = z3 * z3 := hz3

end Ising2DLambda.NecSuf.CriticalExponent
