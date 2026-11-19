/-
節「対称式の基本定理」のうち、重み付き次数の和の上界と末尾の変数倍の上界の具体版。

  人手証明                                                          このファイル
  主張 `claim_qbar_weighted_degree_sum_bound`                       `qbarWeightedDegree_add_le`
    和の係数は係数の和、零でない項が一つはある                       `MvPolynomial.coeff_add`
  主張 `claim_qbar_weighted_degree_last_variable_product_bound`     `qbarWeightedDegree_X_last_mul_le`
    準備（mon_{n+1}(δ_n) = X^{(n+1)}_n の四つの等号）               `qbarMonomial_single_last`
    台の元の取り出し（claim_qbar_monomial_multiplication_coefficient）`qbarMonomial_mul_coeff`
    式鎖の五つの等号（wsz_{n+1}(a) = (n+1) + wsz_{n+1}(a − δ_n)）     `exponentWeightedTotal_of_single_last_le`
    式鎖の最後の不等号（最大元の性質）                              `exponentWeightedTotal_le_qbarWeightedDegree`

本文の δ_n ∈ Ex_{n+1} は `Finsupp.single (Fin.last n) 1`、`a − δ_n` は `Finsupp` の各点の差。

住処: Qbar（次数は ℕ）。R / C は現れない。
-/
import Ising2DLambda.FisherZero.LastVariableExtension

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `claim_qbar_weighted_degree_sum_bound` の具体版。`wdeg_n(A + B) ≤ max(wdeg_n(A), wdeg_n(B))`。 -/
theorem qbarWeightedDegree_add_le {n : ℕ} (A B : QbarMvPoly n) :
    qbarWeightedDegree (A + B) ≤ max (qbarWeightedDegree A) (qbarWeightedDegree B) := by
  -- 最大元は、全ての元が上界以下なら上界以下（def_qbar_multivariate_weighted_degree）。
  apply Finset.sup_le
  intro a ha
  -- mco_a(A + B) = mco_a(A) + mco_a(B) ≠ 0。
  have hne : coeff a A + coeff a B ≠ 0 := by
    rw [← coeff_add]
    exact mem_support_iff.mp ha
  by_cases hA : coeff a A = 0
  · -- mco_a(A) = 0 のとき: mco_a(B) ≠ 0 なので a ∈ spt_n(B)。
    have hB : coeff a B ≠ 0 := by
      intro hB
      rw [hA, hB, add_zero] at hne
      exact hne rfl
    calc exponentWeightedTotal a ≤ qbarWeightedDegree B :=
          exponentWeightedTotal_le_qbarWeightedDegree B a hB
      _ ≤ max (qbarWeightedDegree A) (qbarWeightedDegree B) := le_max_right _ _
  · -- mco_a(A) ≠ 0 のとき: a ∈ spt_n(A)。
    calc exponentWeightedTotal a ≤ qbarWeightedDegree A :=
          exponentWeightedTotal_le_qbarWeightedDegree A a hA
      _ ≤ max (qbarWeightedDegree A) (qbarWeightedDegree B) := le_max_left _ _

/-- `claim_qbar_weighted_degree_last_variable_product_bound` の準備。`mon_{n+1}(δ_n) = X^{(n+1)}_n`。 -/
theorem qbarMonomial_single_last (n : ℕ) :
    qbarMonomial (n + 1) (Finsupp.single (Fin.last n) 1) = X (Fin.last n) := by
  calc qbarMonomial (n + 1) (Finsupp.single (Fin.last n) 1)
      -- 第一の等号: def_qbar_multivariate_monomial。
      = ∏ k : Fin (n + 1), (X k : QbarMvPoly (n + 1)) ^ (Finsupp.single (Fin.last n) 1 k) := rfl
      -- 第二の等号: ℕ_{<n+1} = ℕ_{<n} ∪ {n} による有限積の分離。
    _ = (∏ k : Fin n, (X k.castSucc : QbarMvPoly (n + 1)) ^
            (Finsupp.single (Fin.last n) 1 k.castSucc)) *
          (X (Fin.last n)) ^ (Finsupp.single (Fin.last n) 1 (Fin.last n)) :=
        Fin.prod_univ_castSucc _
      -- 第三の等号: δ_n(k) = 0（k < n）、δ_n(n) = 1。
    _ = (∏ k : Fin n, (X k.castSucc : QbarMvPoly (n + 1)) ^ 0) * (X (Fin.last n)) ^ 1 := by
        congr 1
        · exact Finset.prod_congr rfl fun k _ => by
            rw [Finsupp.single_apply, if_neg (Fin.castSucc_ne_last k).symm]
        · rw [Finsupp.single_eq_same]
      -- 第四の等号: 零乗は単位元、単位元の有限積は単位元、一乗はそれ自身。
    _ = X (Fin.last n) := by simp

/-- `claim_qbar_weighted_degree_last_variable_product_bound` の式鎖の等号の部分。
`δ_n ≤ a` なら `wsz_{n+1}(a) = (n+1) + wsz_{n+1}(a − δ_n)`。 -/
theorem exponentWeightedTotal_of_single_last_le {n : ℕ} (a : Fin (n + 1) →₀ ℕ)
    (ha : Finsupp.single (Fin.last n) 1 ≤ a) :
    exponentWeightedTotal a =
      (n + 1) + exponentWeightedTotal (a - Finsupp.single (Fin.last n) 1) := by
  calc exponentWeightedTotal a
      -- 第一の等号: wsz_{n+1} の定義。
      = ∑ k : Fin (n + 1), (k.val + 1) * a k := rfl
      -- 第二の等号: δ_n ≤ a と指数の差の定義から a(k) = δ_n(k) + (a − δ_n)(k)。
    _ = ∑ k : Fin (n + 1), (k.val + 1) *
          (Finsupp.single (Fin.last n) 1 k + (a - Finsupp.single (Fin.last n) 1 : Fin (n + 1) →₀ ℕ) k) :=
        Finset.sum_congr rfl fun k _ => by
          rw [Finsupp.tsub_apply, Nat.add_sub_cancel' (ha k)]
      -- 第三の等号: ℕ の分配法則と有限和の加法の結合・交換。
    _ = ∑ k : Fin (n + 1), (k.val + 1) * Finsupp.single (Fin.last n) 1 k +
          ∑ k : Fin (n + 1), (k.val + 1) * (a - Finsupp.single (Fin.last n) 1 : Fin (n + 1) →₀ ℕ) k := by
        rw [← Finset.sum_add_distrib]
        exact Finset.sum_congr rfl fun k _ => Nat.mul_add _ _ _
      -- 第四の等号: δ_n は n で 1、他で 0 なので、第一の和は (n+1)·1 = n+1。
    _ = (n + 1) + ∑ k : Fin (n + 1), (k.val + 1) * (a - Finsupp.single (Fin.last n) 1 : Fin (n + 1) →₀ ℕ) k := by
        congr 1
        rw [Finset.sum_eq_single (Fin.last n)]
        · rw [Finsupp.single_eq_same, Fin.val_last, mul_one]
        · intro k _ hk
          rw [Finsupp.single_apply, if_neg (Ne.symm hk), mul_zero]
        · intro h
          exact absurd (Finset.mem_univ _) h
      -- 第五の等号: wsz_{n+1} の定義。
    _ = (n + 1) + exponentWeightedTotal (a - Finsupp.single (Fin.last n) 1) := rfl

/-- `claim_qbar_weighted_degree_last_variable_product_bound` の具体版。
`wdeg_{n+1}(X^{(n+1)}_n · S) ≤ (n+1) + wdeg_{n+1}(S)`。 -/
theorem qbarWeightedDegree_X_last_mul_le {n : ℕ} (S : QbarMvPoly (n + 1)) :
    qbarWeightedDegree (X (Fin.last n) * S) ≤ (n + 1) + qbarWeightedDegree S := by
  apply Finset.sup_le
  intro a ha
  have hne : coeff a (X (Fin.last n) * S) ≠ 0 := mem_support_iff.mp ha
  -- 準備と claim_qbar_monomial_multiplication_coefficient: mco_a(X_n · S) は δ_n ≤ a で mco_{a−δ_n}(S)、他で 0。
  rw [← qbarMonomial_single_last, qbarMonomial_mul_coeff] at hne
  have hle : Finsupp.single (Fin.last n) 1 ≤ a := by
    by_contra h
    rw [if_neg h] at hne
    exact hne rfl
  have hsupp : coeff (a - Finsupp.single (Fin.last n) 1) S ≠ 0 := by
    rw [if_pos hle] at hne
    exact hne
  calc exponentWeightedTotal a
      = (n + 1) + exponentWeightedTotal (a - Finsupp.single (Fin.last n) 1) :=
        exponentWeightedTotal_of_single_last_le a hle
    _ ≤ (n + 1) + qbarWeightedDegree S :=
        Nat.add_le_add_left (exponentWeightedTotal_le_qbarWeightedDegree S _ hsupp) _

end Ising2DLambda.FisherZero
