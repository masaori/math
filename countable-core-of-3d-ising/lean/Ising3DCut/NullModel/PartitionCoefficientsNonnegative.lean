/-
人手証明の主張「分配多項式の各係数は非負である」
（ラベル `claim_partition_coefficients_nonnegative`）の具体版。

人手証明の式変形とこのファイルの対応:

  [X^m] Z_L(X)
    = [X^m] Σ_r Ω_L(r) X^r       `partitionPolynomial_coeff_eq_delta_sum`
    = Σ_r Ω_L(r) δ_{r,m}       同じ補題で係数写像の有限和への加法性と
                                      単項式の係数を一項ずつ適用
    = Ω_L(m)                       `partitionPolynomial_coeff_eq_multiplicity`
    ∈ ℕ                            `partitionPolynomial_coeff_nonnegative`

分配多項式は `Polynomial ℤ` の元、その係数は `ℤ` の元、多重度は `ℕ` の元として
区別する。住処は `Fin`、`Nat`、`Int`、整数係数多項式、有限型のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Polynomial.Coeff
import Ising3DCut.NullModel.PartitionValueAtOne

namespace Ising3DCut.NullModel

noncomputable section

/-- 人手証明の最初の二行。係数写像を有限和の各単項式へ適用する。 -/
lemma partitionPolynomial_coeff_eq_delta_sum (L m : ℕ) :
    (partitionPolynomial L).coeff m =
      ∑ r ∈ Finset.range (Fintype.card (Edge L) + 1),
        if r = m then (multiplicity L r : ℤ) else 0 := by
  rw [partitionPolynomial]
  rw [Polynomial.finsetSum_coeff]
  simp only [Polynomial.coeff_monomial]

/-- 人手証明の三行目。範囲内の次数ではクロネッカーのデルタの有限和が
その次数の多重度だけを残す。 -/
lemma partitionPolynomial_coeff_eq_multiplicity (L m : ℕ)
    (hm : m ≤ Fintype.card (Edge L)) :
    (partitionPolynomial L).coeff m = (multiplicity L m : ℤ) := by
  rw [partitionPolynomial_coeff_eq_delta_sum]
  simp [Finset.sum_ite_eq', Finset.mem_range, hm]

/-- `claim_partition_coefficients_nonnegative` の具体版。
各係数は自然数値の多重度を整数へ写したものであり、非負である。 -/
theorem partitionPolynomial_coeff_nonnegative (L m : ℕ)
    (hm : m ≤ Fintype.card (Edge L)) :
    0 ≤ (partitionPolynomial L).coeff m := by
  rw [partitionPolynomial_coeff_eq_multiplicity L m hm]
  exact Int.natCast_nonneg (multiplicity L m)

end

end Ising3DCut.NullModel
