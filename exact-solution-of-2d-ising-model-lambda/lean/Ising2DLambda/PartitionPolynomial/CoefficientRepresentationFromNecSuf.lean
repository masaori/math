/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.PartitionPolynomial.sum_comp_eq_sum_nsmul` に
  α := 配位の集合 Config L
  f := 破れボンド数 brokenBondCount L
  N := 2L²
  M := Polynomial ℤ
  g := m ↦ x^m
を代入すると、具体版 `PartitionPolynomial.partitionPolynomial_eq_sum_multiplicity` が出る。
残るのは `k • x^m` を `C(k) * x^m` と書き直すことだけであり、これは記法の変換である。

このことは、具体版の証明が「多項式であること」「係数が ℤ であること」「不定元の冪であること」
「格子の形」「スピンの値が `{+1,-1}` であること」を使っていないという主張の裏取りになっている。

住処: ℤ[x] のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.PartitionPolynomial.CoefficientRepresentation
import Ising2DLambda.NecSuf.PartitionPolynomial.CoefficientRepresentation

namespace Ising2DLambda.PartitionPolynomial

open Finset

variable (L : ℕ) [NeZero L]

/-- 具体版の定理を、必要十分版から導いたもの。 -/
theorem partitionPolynomial_eq_sum_multiplicity_from_necSuf :
    partitionPolynomial L
      = ∑ m ∈ range (2 * L ^ 2 + 1),
          Polynomial.C (multiplicity L m : ℤ) * Polynomial.X ^ m := by
  have h := NecSuf.PartitionPolynomial.sum_comp_eq_sum_nsmul
    (α := Config L) (brokenBondCount L) (2 * L ^ 2)
    (fun m => (Polynomial.X : Polynomial ℤ) ^ m) (brokenBondCount_le L)
  rw [partitionPolynomial, h]
  -- 必要十分版の類は具体版の類そのもの（`brokenFiber_eq_necSuf_fiber`）であり、
  -- その元の個数が多重度である（人手証明の第 5 の等号）。
  -- あとは `k • x^m = C(k) * x^m` の書き直しだけである。
  refine sum_congr rfl fun m _ => ?_
  rw [show NecSuf.PartitionPolynomial.fiber (brokenBondCount L) m = brokenFiber L m from rfl,
    ← multiplicity_eq_card_brokenFiber, nsmul_eq_mul]
  simp

end Ising2DLambda.PartitionPolynomial
