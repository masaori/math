/-
章「熱力学極限」の「周期境界と開境界の境界評価」の実数評価の上下評価の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_periodic_open_boundary_comparison` の証明の後半である。

  人手証明の段                                     このファイル
  全単射 r_L に沿う和の並べ替え・破れボンド数の
    分解・t^{m+n} = t^m t^n の三段                  partitionValue_eq_open_double_product
  0<t≤1 での自然数冪の順序 t^{2L} ≤ t^{s^bd} ≤ 1    pow_le_pow_of_le_one_of_exp_le_by_induction /
                                                   pow_le_one_by_induction（接合不等式と同じ補題）
  項ごとの評価の有限和と有限和の分配則
    （0<t≤1 の二つの不等式）                        partitionValue_periodicOpen_bounds_of_le_one
  1≤t での自然数冪の順序 1 ≤ t^{s^bd} ≤ t^{2L}
    （1≤t の二つの不等式）                          partitionValue_periodicOpen_bounds_of_one_le

住処: この章で宣言済みの ℝ 脱出の中にある。使うのは順序体の性質・自然数冪・
有限和だけであり、実対数・完備性・極限は使わない（人手証明の realEscape どおり）。

人手証明との対応の注意:
- 周期境界の値 Z_L(t) は多項式への代入 `Polynomial.aeval t (partitionPolynomial L)` で書く
  （`eval_partitionPolynomial_real` が定義の右辺 `Σ_σ t^{b(σ)}` を与える）。
- 冪の順序はすべて指数についての帰納法の補題で示し、mathlib の既製の単調性定理へ委ねない
  （接合不等式の具体版と同じ補題を使う）。
- 「項ごとに掛けて有限和を取る」は `Finset.sum_le_sum`、「有限和の分配則」は
  `Finset.mul_sum` で書く。
-/
import Ising2DLambda.ThermodynamicLimit.PeriodicOpenComparison
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequality

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 人手証明の「全単射 `r_L` に沿う和の並べ替え」「破れボンド数の分解」
「`t^{m+n} = t^m t^n`」の三段: 周期境界の値の有限和を、開境界配位の和へ書き換える。 -/
lemma partitionValue_eq_open_double_product (t : ℝ) :
    Polynomial.aeval t (partitionPolynomial L) =
      ∑ τ : OpenConfig L L,
        t ^ openBrokenBondCount L L τ * t ^ periodicBoundaryBrokenCount L τ := by
  rw [eval_partitionPolynomial_real]
  rw [← Fintype.sum_equiv (periodicOpenConfigEquiv L)
    (fun τ : OpenConfig L L => t ^ brokenBondCount L (openConfigToPeriodic L τ))
    (fun σ => t ^ brokenBondCount L σ) (fun _ => rfl)]
  exact sum_congr rfl fun τ _ => by
    rw [brokenBondCount_openConfigToPeriodic L τ, pow_add]

/-- `claim_periodic_open_boundary_comparison` の `0 < t ≤ 1` の場合:
`t^{2L} Z^op_{L,L}(t) ≤ Z_L(t) ≤ Z^op_{L,L}(t)`。 -/
theorem partitionValue_periodicOpen_bounds_of_le_one
    {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ (2 * L) * openPartitionValue L L t ≤
        Polynomial.aeval t (partitionPolynomial L) ∧
      Polynomial.aeval t (partitionPolynomial L) ≤ openPartitionValue L L t := by
  constructor
  · rw [openPartitionValue_eq_sum, partitionValue_eq_open_double_product L t, mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      t ^ (2 * L) * t ^ openBrokenBondCount L L τ
          = t ^ openBrokenBondCount L L τ * t ^ (2 * L) := mul_comm _ _
      _ ≤ t ^ openBrokenBondCount L L τ * t ^ periodicBoundaryBrokenCount L τ :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_le_one_of_exp_le_by_induction ht0 ht1
            (periodicBoundaryBrokenCount_le L τ))
          (pow_pos_by_induction ht0 _).le
  · rw [openPartitionValue_eq_sum, partitionValue_eq_open_double_product L t]
    refine sum_le_sum fun τ _ => ?_
    calc
      t ^ openBrokenBondCount L L τ * t ^ periodicBoundaryBrokenCount L τ
          ≤ t ^ openBrokenBondCount L L τ * 1 :=
        mul_le_mul_of_nonneg_left (pow_le_one_by_induction ht0.le ht1 _)
          (pow_pos_by_induction ht0 _).le
      _ = t ^ openBrokenBondCount L L τ := mul_one _

/-- `claim_periodic_open_boundary_comparison` の `1 ≤ t` の場合:
`Z^op_{L,L}(t) ≤ Z_L(t) ≤ t^{2L} Z^op_{L,L}(t)`。 -/
theorem partitionValue_periodicOpen_bounds_of_one_le
    {t : ℝ} (ht : 1 ≤ t) :
    openPartitionValue L L t ≤ Polynomial.aeval t (partitionPolynomial L) ∧
      Polynomial.aeval t (partitionPolynomial L) ≤
        t ^ (2 * L) * openPartitionValue L L t := by
  have ht0 : 0 < t := lt_of_lt_of_le zero_lt_one ht
  constructor
  · rw [openPartitionValue_eq_sum, partitionValue_eq_open_double_product L t]
    refine sum_le_sum fun τ _ => ?_
    calc
      t ^ openBrokenBondCount L L τ
          = t ^ openBrokenBondCount L L τ * 1 := (mul_one _).symm
      _ ≤ t ^ openBrokenBondCount L L τ * t ^ periodicBoundaryBrokenCount L τ :=
        mul_le_mul_of_nonneg_left (one_le_pow_by_induction ht _)
          (pow_pos_by_induction ht0 _).le
  · rw [openPartitionValue_eq_sum, partitionValue_eq_open_double_product L t, mul_sum]
    refine sum_le_sum fun τ _ => ?_
    calc
      t ^ openBrokenBondCount L L τ * t ^ periodicBoundaryBrokenCount L τ
          ≤ t ^ openBrokenBondCount L L τ * t ^ (2 * L) :=
        mul_le_mul_of_nonneg_left
          (pow_le_pow_of_one_le_of_exp_le_by_induction ht
            (periodicBoundaryBrokenCount_le L τ))
          (pow_pos_by_induction ht0 _).le
      _ = t ^ (2 * L) * t ^ openBrokenBondCount L L τ := mul_comm _ _

end Ising2DLambda.ThermodynamicLimit
