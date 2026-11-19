/-
節「対称式の基本定理」のうち、末尾の変数への零代入が部分体係数を保ち全次数を増やさないことの必要十分版。

具体版（`Ising2DLambda.FisherZero.lastVariableZero_mem_subfieldCoefficientMvPolys`・
`qbarTotalDegree_lastVariableZero_le`）と同じ段（零代入の係数の式 → 係数の所属、台の元の写り先 → 最大元の性質）で示し、
各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい（零代入の係数の式 `lastVariableZero_coeff_necSuf` が可換半環で成り立つ）。
- 部分体係数の主張では、部分体の代わりに `K` の任意の部分集合 `S` でよい。零元を含むことも、和・積・逆元で
  閉じることも使わない。係数の式により、`lz_n(P)` の係数は全て `P` の係数のどれかだからである。
- 全次数の主張では、全次数の代わりに、`n` 変数の指数の重み `w` と `n+1` 変数の指数の重み `w'` についての次数でよい。
  使うのは、任意の指数 `b` で `w b ≤ w' (ez_n(b))` であることだけである（具体版では指数の総和で、等号が成り立つ）。
-/
import Ising2DLambda.NecSuf.FisherZero.MonomialAndLastVariableZeroCoefficient
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionSubfieldCoefficient
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionDegreeBound

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

/-- `claim_last_variable_zero_subfield_coefficient` の必要十分版（`S` は任意の部分集合）。 -/
theorem lastVariableZero_mem_coeffIn_necSuf {S : Set K} {n : ℕ} (P : MvPolynomial (Fin (n + 1)) K)
    (hP : P ∈ coeffIn S (Fin (n + 1))) : lastVariableZeroNecSuf n P ∈ coeffIn S (Fin n) := by
  intro b
  rw [lastVariableZero_coeff_necSuf]
  exact hP (exponentZeroExtension b)

/-- `claim_last_variable_zero_total_degree_bound` の必要十分版（`w b ≤ w' (ez_n(b))` だけを使う）。 -/
theorem wDeg_lastVariableZero_le_necSuf {n : ℕ} (w : (Fin n →₀ ℕ) → ℕ) (w' : (Fin (n + 1) →₀ ℕ) → ℕ)
    (hw : ∀ b, w b ≤ w' (exponentZeroExtension b)) (P : MvPolynomial (Fin (n + 1)) K) :
    wDeg w (lastVariableZeroNecSuf n P) ≤ wDeg w' P := by
  apply wDeg_le_of_forall
  intro b hb
  have hsupp : coeff (exponentZeroExtension b) P ≠ 0 := by
    rw [← lastVariableZero_coeff_necSuf]
    exact hb
  calc w b ≤ w' (exponentZeroExtension b) := hw b
    _ ≤ wDeg w' P := le_wDeg w' P _ hsupp

end Ising2DLambda.NecSuf.FisherZero
