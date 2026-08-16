/-
章「熱力学極限」の「周期境界と開境界の境界評価（正の有理点）」
（`claim_periodic_open_boundary_comparison_rational`）の具体版（人手証明と 1 対 1 に対応させる）。

実数版 `PeriodicOpenComparisonInequality.lean` と同じ手順を、評価点を正の有理数 `q : ℚ` に
置いて辿る。周期境界の値は `Z[x]` の分配多項式への代入 `Polynomial.aeval q (partitionPolynomial L)`
（`FreeEntropy.eval_partitionPolynomial` が定義の右辺 `Σ_σ q^{b(σ)}` を与える）、開境界の値は
`openPartitionValueRat`（`OpenRectanglePartitionValueRational.lean`）。全単射 `r_L`・境界横断辺の
破れ本数 `s^bd`・破れボンド数の分解は実数版と共有する（`PeriodicOpenComparison.lean`。ℕ の計算で
体に依らない）。

  人手証明の段                                     このファイル
  代入を配位の和へ配る・全単射 r_L に沿う和の
    並べ替え・破れボンド数の分解・q^{m+n}=q^m q^n   partitionValueRat_eq_open_double_product
  0<q≤1 での自然数冪の順序 q^{2L} ≤ q^{s^bd} ≤ 1    pow_le_pow_of_le_one_of_exp_le_by_induction_rat /
                                                   pow_le_one_by_induction_rat（接合不等式（正の有理点）と同じ補題）
  「各項は正」                                     pow_pos_by_induction（正の有理数の冪は正）
  項ごとの評価の有限和と有限和の分配則
    （0<q≤1 の二つの不等式）                        partitionValueRat_periodicOpen_bounds_of_le_one
  1≤q での自然数冪の順序 1 ≤ q^{s^bd} ≤ q^{2L}
    （1≤q の二つの不等式）                          partitionValueRat_periodicOpen_bounds_of_one_le

住処: ℕ・ℚ のみ。ℝ / ℂ は現れない。使うのは有理数体の順序体としての性質・自然数冪・
有限和だけである。

人手証明との対応の注意（実数版と同じ）:
- 冪の順序はすべて指数についての帰納法の補題で示し、mathlib の既製の単調性定理へ委ねない。
- 「項ごとに掛けて有限和を取る」は `Finset.sum_le_sum`、「有限和の分配則」は `Finset.mul_sum` で書く。
- 実数版 `claim_periodic_open_boundary_comparison` はこの主張の実数側の像であり、旧経路の撤去まで併存させる。
-/
import Ising2DLambda.ThermodynamicLimit.PeriodicOpenComparison
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequalityRational
import Ising2DLambda.FreeEntropy.ValuePositive

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial NecSuf.ThermodynamicLimit

variable (L : ℕ) [NeZero L]

/-- 人手証明の「代入を配位の和へ配る」「全単射 `r_L` に沿う和の並べ替え」「破れボンド数の分解」
「`q^{m+n} = q^m q^n`」の四段: 周期境界の値の有限和を、開境界配位の和へ書き換える。 -/
lemma partitionValueRat_eq_open_double_product (q : ℚ) :
    Polynomial.aeval q (partitionPolynomial L) =
      ∑ τ : OpenConfig L L,
        q ^ openBrokenBondCount L L τ * q ^ periodicBoundaryBrokenCount L τ := by
  rw [FreeEntropy.eval_partitionPolynomial]
  rw [← Fintype.sum_equiv (periodicOpenConfigEquiv L)
    (fun τ : OpenConfig L L => q ^ brokenBondCount L (openConfigToPeriodic L τ))
    (fun σ => q ^ brokenBondCount L σ) (fun _ => rfl)]
  exact sum_congr rfl fun τ _ => by
    rw [brokenBondCount_openConfigToPeriodic L τ, pow_add]

/-- `claim_periodic_open_boundary_comparison_rational` の `0 < q ≤ 1` の場合:
`q^{2L} Z^op_{L,L}(q) ≤ Z_L(q) ≤ Z^op_{L,L}(q)`。 -/
theorem partitionValueRat_periodicOpen_bounds_of_le_one
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ (2 * L) * openPartitionValueRat L L q ≤
        Polynomial.aeval q (partitionPolynomial L) ∧
      Polynomial.aeval q (partitionPolynomial L) ≤ openPartitionValueRat L L q := by
  constructor
  · rw [openPartitionValueRat_eq_sum, partitionValueRat_eq_open_double_product L q, mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      q ^ (2 * L) * q ^ openBrokenBondCount L L τ
          = q ^ openBrokenBondCount L L τ * q ^ (2 * L) := mul_comm _ _
      _ ≤ q ^ openBrokenBondCount L L τ * q ^ periodicBoundaryBrokenCount L τ :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_le_one_of_exp_le_by_induction_rat hq0 hq1
            (periodicBoundaryBrokenCount_le L τ))
          (pow_pos_by_induction hq0 _).le
  · rw [openPartitionValueRat_eq_sum, partitionValueRat_eq_open_double_product L q]
    refine sum_le_sum fun τ _ => ?_
    calc
      q ^ openBrokenBondCount L L τ * q ^ periodicBoundaryBrokenCount L τ
          ≤ q ^ openBrokenBondCount L L τ * 1 :=
        mul_le_mul_of_nonneg_left (pow_le_one_by_induction_rat hq0.le hq1 _)
          (pow_pos_by_induction hq0 _).le
      _ = q ^ openBrokenBondCount L L τ := mul_one _

/-- `claim_periodic_open_boundary_comparison_rational` の `1 ≤ q` の場合:
`Z^op_{L,L}(q) ≤ Z_L(q) ≤ q^{2L} Z^op_{L,L}(q)`。 -/
theorem partitionValueRat_periodicOpen_bounds_of_one_le
    {q : ℚ} (hq : 1 ≤ q) :
    openPartitionValueRat L L q ≤ Polynomial.aeval q (partitionPolynomial L) ∧
      Polynomial.aeval q (partitionPolynomial L) ≤
        q ^ (2 * L) * openPartitionValueRat L L q := by
  have hq0 : 0 < q := lt_of_lt_of_le zero_lt_one hq
  constructor
  · rw [openPartitionValueRat_eq_sum, partitionValueRat_eq_open_double_product L q]
    refine sum_le_sum fun τ _ => ?_
    calc
      q ^ openBrokenBondCount L L τ
          = q ^ openBrokenBondCount L L τ * 1 := (mul_one _).symm
      _ ≤ q ^ openBrokenBondCount L L τ * q ^ periodicBoundaryBrokenCount L τ :=
        mul_le_mul_of_nonneg_left (one_le_pow_by_induction_rat hq _)
          (pow_pos_by_induction hq0 _).le
  · rw [openPartitionValueRat_eq_sum, partitionValueRat_eq_open_double_product L q, mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      q ^ openBrokenBondCount L L τ * q ^ periodicBoundaryBrokenCount L τ
          ≤ q ^ openBrokenBondCount L L τ * q ^ (2 * L) :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_one_le_of_exp_le_by_induction_rat hq
            (periodicBoundaryBrokenCount_le L τ))
          (pow_pos_by_induction hq0 _).le
      _ = q ^ (2 * L) * q ^ openBrokenBondCount L L τ := mul_comm _ _

end Ising2DLambda.ThermodynamicLimit
