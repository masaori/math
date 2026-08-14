/-
人手証明の主張「同じ分配多項式は異なる二点データを区別しない」
（ラベル `claim_same_partition_different_pair_data`）の具体版。

自由境界の一辺 2 の箱を、八つの Bool 値と十二本の内部辺として直接定義する。
人手証明とこのファイルの対応:

  標識は破れ数を変えない                         `same_partitionPolynomial`
  隣接点対では破れ数 4 の一致数・不一致数が 20・10  `adjacent_counts_at_four`
  対角点対では破れ数 4 の一致数・不一致数が 12・18  `diagonal_counts_at_four`
  四次係数が 10 と -6 なので多項式が異なる          `same_partition_different_pairData`

住処: `Fin 2`、`Bool`、`Nat`、`Int`、整数係数多項式、有限型のみ。ℝ / ℂ は現れない。
-/
import Mathlib

namespace Ising3DCut.NullModel

abbrev CubeTwoConfig := Fin 2 → Fin 2 → Fin 2 → Bool

def cubeTwoBrokenCount (σ : CubeTwoConfig) : ℕ :=
  (if σ 0 0 0 != σ 1 0 0 then 1 else 0) +
  (if σ 0 1 0 != σ 1 1 0 then 1 else 0) +
  (if σ 0 0 1 != σ 1 0 1 then 1 else 0) +
  (if σ 0 1 1 != σ 1 1 1 then 1 else 0) +
  (if σ 0 0 0 != σ 0 1 0 then 1 else 0) +
  (if σ 1 0 0 != σ 1 1 0 then 1 else 0) +
  (if σ 0 0 1 != σ 0 1 1 then 1 else 0) +
  (if σ 1 0 1 != σ 1 1 1 then 1 else 0) +
  (if σ 0 0 0 != σ 0 0 1 then 1 else 0) +
  (if σ 1 0 0 != σ 1 0 1 then 1 else 0) +
  (if σ 0 1 0 != σ 0 1 1 then 1 else 0) +
  (if σ 1 1 0 != σ 1 1 1 then 1 else 0)

def cubeTwoMultiplicity (m : ℕ) : ℕ :=
  (Finset.univ.filter fun σ : CubeTwoConfig => cubeTwoBrokenCount σ = m).card

def adjacentAgree (σ : CubeTwoConfig) : Bool := σ 0 0 0 == σ 1 0 0

def diagonalAgree (σ : CubeTwoConfig) : Bool := σ 0 0 0 == σ 1 1 1

def pairAgreeCount (agree : CubeTwoConfig → Bool) (m : ℕ) : ℕ :=
  (Finset.univ.filter fun σ : CubeTwoConfig =>
    cubeTwoBrokenCount σ = m && agree σ).card

def pairDisagreeCount (agree : CubeTwoConfig → Bool) (m : ℕ) : ℕ :=
  (Finset.univ.filter fun σ : CubeTwoConfig =>
    cubeTwoBrokenCount σ = m && !agree σ).card

noncomputable def cubeTwoPartitionPolynomial : Polynomial ℤ :=
  ∑ m ∈ Finset.range 13, Polynomial.monomial m (cubeTwoMultiplicity m)

noncomputable def cubeTwoPairPolynomial (agree : CubeTwoConfig → Bool) : Polynomial ℤ :=
  ∑ m ∈ Finset.range 13,
    Polynomial.monomial m ((pairAgreeCount agree m : ℤ) - pairDisagreeCount agree m)

lemma cubeTwoPairPolynomial_coeff (agree : CubeTwoConfig → Bool) (m : ℕ) (hm : m < 13) :
    (cubeTwoPairPolynomial agree).coeff m =
      (pairAgreeCount agree m : ℤ) - pairDisagreeCount agree m := by
  rw [cubeTwoPairPolynomial, Polynomial.finsetSum_coeff]
  simp [Polynomial.coeff_monomial, Finset.sum_ite_eq', Finset.mem_range, hm]

/-- 標識点対を変えても、標識を含まない分配多項式の定義は変わらない。 -/
lemma same_partitionPolynomial :
    cubeTwoPartitionPolynomial = cubeTwoPartitionPolynomial := rfl

/-- 隣接点対では、破れ数 4 の一致配位が 20、不一致配位が 10。 -/
lemma adjacent_counts_at_four :
    pairAgreeCount adjacentAgree 4 = 20 ∧ pairDisagreeCount adjacentAgree 4 = 10 := by
  decide

/-- 対角点対では、破れ数 4 の一致配位が 12、不一致配位が 18。 -/
lemma diagonal_counts_at_four :
    pairAgreeCount diagonalAgree 4 = 12 ∧ pairDisagreeCount diagonalAgree 4 = 18 := by
  decide

/-- `claim_same_partition_different_pair_data` の具体版。
分配多項式は共通だが、二つの符号付き二点多項式の四次係数は異なる。 -/
theorem same_partition_different_pairData :
    cubeTwoPartitionPolynomial = cubeTwoPartitionPolynomial ∧
    (cubeTwoPairPolynomial adjacentAgree).coeff 4 = 10 ∧
    (cubeTwoPairPolynomial diagonalAgree).coeff 4 = -6 ∧
    cubeTwoPairPolynomial adjacentAgree ≠ cubeTwoPairPolynomial diagonalAgree := by
  have hadj := adjacent_counts_at_four
  have hdiag := diagonal_counts_at_four
  refine ⟨same_partitionPolynomial, ?_, ?_, ?_⟩
  · rw [cubeTwoPairPolynomial_coeff adjacentAgree 4 (by omega), hadj.1, hadj.2]
    norm_num
  · rw [cubeTwoPairPolynomial_coeff diagonalAgree 4 (by omega), hdiag.1, hdiag.2]
    norm_num
  · intro h
    have hcoeff := congrArg (fun p : Polynomial ℤ => p.coeff 4) h
    rw [cubeTwoPairPolynomial_coeff adjacentAgree 4 (by omega),
      cubeTwoPairPolynomial_coeff diagonalAgree 4 (by omega),
      hadj.1, hadj.2, hdiag.1, hdiag.2] at hcoeff
    norm_num at hcoeff

end Ising3DCut.NullModel
