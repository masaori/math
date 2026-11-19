/-
節「対称式の基本定理」のうち、重み付き次数の和の上界と末尾の変数倍の上界の必要十分版。

具体版（`Ising2DLambda.FisherZero.qbarWeightedDegree_add_le`・`qbarWeightedDegree_X_last_mul_le`）と同じ段
（和の係数は係数の和で、零でない方の台に入る → 最大元の性質、変数を単項式として書く → 単項式を掛けた係数の式で
台の元を取り出す → 指数を変数の指数と差に分けて重みを評価する → 最大元の性質）で示し、各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい（多変数多項式環を作るのに Lean が要求する構造）。和の上界では、零元が加法の単位元で
  あることしか使わない。体であること・零因子が無いこと・符号反転はどちらの主張でも使わない。
- 和の上界では、重み付き次数の代わりに指数の任意の重み `w` についての次数でよい。`w` に何も要求しない。
- 変数倍の上界では、変数の添字は任意の有限集合 `σ` でよく、末尾の変数である必要はない（`Fin (n+1)` の順序は使わない）。
  有限であることは、変数を単項式 `∏ k, X k ^ δ_i(k)` として書き、単項式を掛けた係数の式を使うために要る。
  重み `w` について使うのは、変数 `i` の指数 `δ_i` を足すと重みが高々 `d` しか増えないこと（`hw`）だけである。
  具体版の重み付きの指数の総和では `d = n + 1` で、等号 `wsz(δ_n + c) = (n+1) + wsz(c)` が成り立つ。
-/
import Ising2DLambda.NecSuf.FisherZero.MonomialAndLastVariableZeroCoefficient
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionDegreeBound

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

/-- `claim_qbar_weighted_degree_sum_bound` の必要十分版（重み `w` に何も要求しない）。 -/
theorem wDeg_add_le_necSuf {σ : Type} (w : (σ →₀ ℕ) → ℕ) (A B : MvPolynomial σ K) :
    wDeg w (A + B) ≤ max (wDeg w A) (wDeg w B) := by
  apply wDeg_le_of_forall
  intro a ha
  have hne : coeff a A + coeff a B ≠ 0 := by
    rw [← coeff_add]
    exact ha
  by_cases hA : coeff a A = 0
  · have hB : coeff a B ≠ 0 := by
      intro hB
      rw [hA, hB, add_zero] at hne
      exact hne rfl
    calc w a ≤ wDeg w B := le_wDeg w B a hB
      _ ≤ max (wDeg w A) (wDeg w B) := le_max_right _ _
  · calc w a ≤ wDeg w A := le_wDeg w A a hA
      _ ≤ max (wDeg w A) (wDeg w B) := le_max_left _ _

variable {σ : Type} [Fintype σ] [DecidableEq σ]

/-- 準備（具体版 `qbarMonomial_single_last` と同じ段）。`mon(δ_i) = X_i`。 -/
theorem monomialProd_single (i : σ) :
    (monomialProd (Finsupp.single i 1) : MvPolynomial σ K) = X i := by
  unfold monomialProd
  rw [Finset.prod_eq_single i]
  · rw [Finsupp.single_eq_same, pow_one]
  · intro k _ hk
    rw [Finsupp.single_apply, if_neg (Ne.symm hk), pow_zero]
  · intro h
    exact absurd (Finset.mem_univ i) h

/-- `claim_qbar_weighted_degree_last_variable_product_bound` の必要十分版
（`δ_i` を足すと重みが高々 `d` しか増えないことだけを使う）。 -/
theorem wDeg_X_mul_le_necSuf (w : (σ →₀ ℕ) → ℕ) (i : σ) (d : ℕ)
    (hw : ∀ c : σ →₀ ℕ, w (Finsupp.single i 1 + c) ≤ d + w c) (S : MvPolynomial σ K) :
    wDeg w (X i * S) ≤ d + wDeg w S := by
  apply wDeg_le_of_forall
  intro a hne
  rw [← monomialProd_single (K := K) i, monomialProd_mul_coeff_necSuf] at hne
  have hle : Finsupp.single i 1 ≤ a := by
    by_contra h
    rw [if_neg h] at hne
    exact hne rfl
  have hsupp : coeff (a - Finsupp.single i 1) S ≠ 0 := by
    rw [if_pos hle] at hne
    exact hne
  calc w a = w (Finsupp.single i 1 + (a - Finsupp.single i 1)) := by
        rw [add_tsub_cancel_of_le hle]
    _ ≤ d + w (a - Finsupp.single i 1) := hw _
    _ ≤ d + wDeg w S := Nat.add_le_add_left (le_wDeg w S _ hsupp) _

end Ising2DLambda.NecSuf.FisherZero
