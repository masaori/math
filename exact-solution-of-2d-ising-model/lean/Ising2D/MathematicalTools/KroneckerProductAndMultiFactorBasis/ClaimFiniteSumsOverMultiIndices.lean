/-
# 本文の有限和の主張を、多重添字の集合 `𝓘_M`（Lean の `Conf M`）の上の和へ当てたもの（具体版）

本文は行列 `Mat(2^M, ℂ)`・数ベクトル `ℂ^{2^M}` の成分の番号の上の和に、添字の集合 `{1,…,m}` の上の和の主張
（`finite_sum_of_real_scalar_multiples`・`real_inclusion_preserves_finite_sum` など）を `m → 2^M` として当てる。
Lean の成分の番号は `Conf M` なので、本文の `𝓘_M` の上の和の定義（`def_finite_sum_of_complex_numbers_over_multi_indices`・
`def_finite_sum_of_real_numbers_over_multi_indices`）で両辺を `ν^{-1}`（Lean の `σ`）による `{1,…,2^M}` の上の和へ開き、
`Fin n` の上の具体版を当てて閉じる。どれも本文の主張の当てはめで、本文に対応するブロックは無い（Lean だけの段）。

添字の型を任意の有限型に取る `*_fintype`（`Fintype.equivFin` で番号を付ける）の代わりに使う。`*_fintype` の番号付けは本文の `ν` と関係が無い。
必要十分版は置かない（当てはめだけで、取り払える構造が無い）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionFiniteSumOverMultiIndices
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimInclusionOfIntegersIntoRealNumbers

namespace Ising2D

variable {M : ℕ}

/-- 人手 `finite_sum_of_real_scalar_multiples` を、多重添字の集合 `𝓘_M`（Lean の `Conf M`。行列 `Mat(2^M, ℝ)`・数ベクトル `ℝ^{2^M}` の成分の番号）の上の和
（`def_finite_sum_of_real_numbers_over_multi_indices`）へ当てたもの: `Σ_{I∈𝓘_M} c a(I) = c Σ_{I∈𝓘_M} a(I)`。
定義の一致の補題 `finset_sum_conf_real_eq_finite_sum_over_multi_indices` で両辺の `𝓘_M` の上の和を
`ν^{-1}`（Lean の `σ`）による `{1,…,2^M}` の上の和へ開き、具体版 `finite_sum_of_real_scalar_multiples` を当て、同じ補題で閉じる。 -/
theorem finite_sum_over_multi_indices_of_real_scalar_multiples (c : ℝ) (a : Conf M → ℝ) :
    ∑ I : Conf M, c * a I = c * ∑ I : Conf M, a I := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M     -- `def_inverse_of_kronecker_numbering`
  have hsum := finset_sum_conf_real_eq_finite_sum_over_multi_indices M
  calc ∑ I : Conf M, c * a I
      = ∑ k : Fin n, c * a (σ k) := hsum n hord σ hσ (fun I => c * a I)     -- `def_finite_sum_of_real_numbers_over_multi_indices`
    _ = c * ∑ k : Fin n, a (σ k) := finite_sum_of_real_scalar_multiples n c _  -- `finite_sum_of_real_scalar_multiples`
    _ = c * ∑ I : Conf M, a I := by rw [hsum n hord σ hσ a]                 -- `def_finite_sum_of_real_numbers_over_multi_indices`

/-- 人手 `real_inclusion_preserves_finite_sum` を、多重添字の集合 `𝓘_M`（Lean の `Conf M`。行列 `Mat(2^M, ℂ)` の成分の番号）の上の和
（`def_finite_sum_of_complex_numbers_over_multi_indices`・`def_finite_sum_of_real_numbers_over_multi_indices`）へ当てたもの:
`Σ_{I∈𝓘_M} (r(I))_ℂ = (Σ_{I∈𝓘_M} r(I))_ℂ`。
二つの定義の一致の補題で両辺の `𝓘_M` の上の和を同じ `ν^{-1}`（Lean の `σ`）による `{1,…,2^M}` の上の和へ開き、
具体版 `real_inclusion_of_finite_sum` を当てる。 -/
theorem real_inclusion_of_finite_sum_over_multi_indices (r : Conf M → ℝ) :
    ∑ I : Conf M, ((r I : ℝ) : ℂ) = ((∑ I : Conf M, r I : ℝ) : ℂ) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M     -- `def_inverse_of_kronecker_numbering`
  have hsumR := finset_sum_conf_real_eq_finite_sum_over_multi_indices M
  have hsumC := finset_sum_conf_complex_eq_finite_sum_over_multi_indices M n hord σ hσ
  calc ∑ I : Conf M, ((r I : ℝ) : ℂ)
      = ∑ k : Fin n, ((r (σ k) : ℝ) : ℂ) := hsumC (fun I => ((r I : ℝ) : ℂ))  -- `def_finite_sum_of_complex_numbers_over_multi_indices`
    _ = ((∑ k : Fin n, r (σ k) : ℝ) : ℂ) := real_inclusion_of_finite_sum n _   -- `real_inclusion_preserves_finite_sum`
    _ = ((∑ I : Conf M, r I : ℝ) : ℂ) := by rw [hsumR n hord σ hσ r]         -- `def_finite_sum_of_real_numbers_over_multi_indices`

/-- 人手 `finite_sum_of_real_sums` を `𝓘_M`（Lean の `Conf M`）の上の和へ当てたもの: `Σ_{I∈𝓘_M} (a(I) + b(I)) = Σ_{I∈𝓘_M} a(I) + Σ_{I∈𝓘_M} b(I)`。
定義の一致の補題で三つの和を `ν^{-1}`（Lean の `σ`）による `{1,…,2^M}` の上の和へ開き、具体版 `finite_sum_of_real_sums` を当てて閉じる。 -/
theorem finite_sum_over_multi_indices_of_real_sums (a b : Conf M → ℝ) :
    ∑ I : Conf M, (a I + b I) = (∑ I : Conf M, a I) + ∑ I : Conf M, b I := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M     -- `def_inverse_of_kronecker_numbering`
  have hsum := finset_sum_conf_real_eq_finite_sum_over_multi_indices M n hord σ hσ
  calc ∑ I : Conf M, (a I + b I)
      = ∑ k : Fin n, (a (σ k) + b (σ k)) := hsum (fun I => a I + b I)        -- `def_finite_sum_of_real_numbers_over_multi_indices`
    _ = (∑ k : Fin n, a (σ k)) + ∑ k : Fin n, b (σ k) := finite_sum_of_real_sums n _ _  -- `finite_sum_of_real_sums`
    _ = (∑ I : Conf M, a I) + ∑ I : Conf M, b I := by rw [hsum a, hsum b]   -- `def_finite_sum_of_real_numbers_over_multi_indices` を 2 か所

/-- 人手 `finite_sum_of_real_numbers_is_monotone` を `𝓘_M`（Lean の `Conf M`）の上の和へ当てたもの:
すべての `I ∈ 𝓘_M` で `a(I) ≤ b(I)` なら `Σ_{I∈𝓘_M} a(I) ≤ Σ_{I∈𝓘_M} b(I)`。
両辺を `ν^{-1}`（Lean の `σ`）による `{1,…,2^M}` の上の和へ開き、具体版 `finite_sum_of_real_numbers_is_monotone`（`a_k → a(ν^{-1}(k))`）を当てる。 -/
theorem finite_sum_over_multi_indices_of_real_numbers_is_monotone (a b : Conf M → ℝ)
    (hab : ∀ I, a I ≤ b I) : ∑ I : Conf M, a I ≤ ∑ I : Conf M, b I := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M     -- `def_inverse_of_kronecker_numbering`
  have hsum := finset_sum_conf_real_eq_finite_sum_over_multi_indices M n hord σ hσ
  calc ∑ I : Conf M, a I
      = ∑ k : Fin n, a (σ k) := hsum a                                      -- `def_finite_sum_of_real_numbers_over_multi_indices`
    _ ≤ ∑ k : Fin n, b (σ k) :=
        finite_sum_of_real_numbers_is_monotone n _ _ fun k => hab (σ k)     -- `finite_sum_of_real_numbers_is_monotone`
    _ = ∑ I : Conf M, b I := (hsum b).symm                                  -- `def_finite_sum_of_real_numbers_over_multi_indices`

/-- 人手 `finite_sum_of_nonnegative_reals_is_at_least_each_term` を `𝓘_M`（Lean の `Conf M`）の上の和へ当てたもの:
すべての項が非負なら、各 `J ∈ 𝓘_M` で `Σ_{I∈𝓘_M} a(I) ≥ a(J)`。
`J` の番号 `ν(J)` を `{1,…,2^M}` の元 `k` の像として取り（`ν^{-1}` の条件）、`ν` の単射（`kronecker_numbering_injective`）から
`ν^{-1}(k) = J` を得て、`{1,…,2^M}` の上の具体版 `finite_sum_of_nonnegative_reals_ge_term`（`k → ν(J)`）を当てる。 -/
theorem finite_sum_over_multi_indices_of_nonnegative_reals_ge_term (a : Conf M → ℝ)
    (ha : ∀ I, 0 ≤ a I) (J : Conf M) : ∑ I : Conf M, a I ≥ a J := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M     -- `def_inverse_of_kronecker_numbering`
  have hsum := finset_sum_conf_real_eq_finite_sum_over_multi_indices M n hord σ hσ
  obtain ⟨k, hk⟩ := hord J                                                -- `ν(J) ∈ {1,…,2^M}`
  have hσk : σ k = J := kronecker_numbering_injective _ _ (by rw [hσ, hk])  -- `ν(ν^{-1}(k)) = k = ν(J)` と `ν` の単射
  calc ∑ I : Conf M, a I
      = ∑ k : Fin n, a (σ k) := hsum a                                      -- `def_finite_sum_of_real_numbers_over_multi_indices`
    _ ≥ a (σ k) :=
        finite_sum_of_nonnegative_reals_ge_term n _ (fun k => ha (σ k)) k  -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`k → ν(J)`）
    _ = a J := by rw [hσk]                                                  -- `ν^{-1}(ν(J)) = J`

/-- 人手 `finite_sum_of_constant_real_number` を `𝓘_M`（Lean の `Conf M`）の上の和へ当てたもの: `Σ_{I∈𝓘_M} r = ι_{ℤ→ℝ}(n) r`。
`n` は `ν^{-1}` の定義域 `{1,…,n}` の大きさ（`def_inverse_of_kronecker_numbering`。`n = 2^M` だが、主張の型に冪の記号を出さないため
`exists_inverse_of_kronecker_numbering` と同じ条件で受け取る）。和を `{1,…,n}` の上の和へ開き、具体版 `finite_sum_of_constant_real_number`（`m → n`）を当てる。
仮定 `1 ≤ n` は、使う側の本文が `m → d ∈ ℤ_{≥1}`（`d := 2_ℤ^{M_col}` と `power_of_two_in_integers_is_at_least_one`）で引くのに合わせて置いたもので、
証明は使わない（本文の `finite_sum_of_constant_real_number` は `m ∈ ℤ_{≥0}` で成り立つ）。 -/
theorem finite_sum_over_multi_indices_of_constant_real_number (n : ℕ)
    (hord : ∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k)
    (σ : Fin n → Conf M) (hσ : ∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) (_hn1 : 1 ≤ n) (r : ℝ) :
    ∑ _I : Conf M, r = (((n : ℤ)) : ℝ) * r := by
  calc ∑ _I : Conf M, r
      = ∑ _k : Fin n, r :=
        finset_sum_conf_real_eq_finite_sum_over_multi_indices M n hord σ hσ (fun _ => r)
                                                                            -- `def_finite_sum_of_real_numbers_over_multi_indices`
    _ = (((n : ℤ)) : ℝ) * r := finite_sum_of_constant_real_number n r       -- `finite_sum_of_constant_real_number`（`m → n`）

end Ising2D
