/-
節「零代入で消える対称多項式を全変数の積で割る」の具体版。

  人手証明                                                          このファイル
  定義 `def_qbar_all_ones_shift`                                    `allOnesExponent`・`allOnesShift`・`allOnesShift_coeff`
  主張 `claim_qbar_full_elementary_symmetric_is_all_ones_monomial`  `qbarElementarySymmetric_self_eq_monomial_allOnes`
    第一の等号（基本対称式の定義）                                  `qbarElementarySymmetric`
    第二の等号（n 元部分集合は ℕ_{<n} ただ一つ）                    `Finset.powersetCard_self`
    第三・第四の等号（一乗、単項式の定義）                          `qbarMonomial`・`pow_one`
  主張 `claim_symmetric_vanishing_last_variable_shifted_quotient_product`
                                                                    `symmetricVanishing_eq_elementarySymmetric_mul_allOnesShift`
    準備（1 ≤ c でなければ c(k) = 0 の k がある）                   `exists_eq_zero_of_not_allOnes_le`
    第一の等号                                                      `qbarElementarySymmetric_self_eq_monomial_allOnes`
    第二の等号                                                      `qbarMonomial_mul_coeff`
    第三の等号                                                      `allOnesShift_coeff`
    第四の等号（(c - 1) + 1 = c）                                   `tsub_add_cancel_of_le`
    第五の等号                                                      `symmetricVanishing_coeff_eq_zero`

本文の `sd_n(P)` は、係数の族 `P : (Fin n →₀ ℕ) →₀ Qbar` を単射 `d ↦ d + 1_n` で引き戻した族
（`Finsupp.comapDomain`）で作る。本文の定義の「有限個である」は、この引き戻しが有限台を保つことにあたる。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SymmetricVanishingCoefficientSupport

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_qbar_all_ones_shift` の指数 `1_n`（全ての成分が 1）。 -/
noncomputable def allOnesExponent (n : ℕ) : Fin n →₀ ℕ :=
  Finsupp.equivFunOnFinite.symm (fun _ => 1)

theorem allOnesExponent_apply (n : ℕ) (k : Fin n) : allOnesExponent n k = 1 := rfl

/-- `def_qbar_all_ones_shift` の具体版 `sd_n(P)`。係数の族を `d ↦ d + 1_n` で引き戻す。 -/
noncomputable def allOnesShift {n : ℕ} (P : QbarMvPoly n) : QbarMvPoly n :=
  AddMonoidAlgebra.ofCoeff
    (Finsupp.comapDomain (fun d : Fin n →₀ ℕ => d + allOnesExponent n) (AddMonoidAlgebra.coeff P)
      ((add_left_injective (allOnesExponent n)).injOn))

/-- `def_qbar_all_ones_shift` の係数の式 `mco_d(sd_n(P)) = mco_{d+1_n}(P)`。 -/
theorem allOnesShift_coeff {n : ℕ} (P : QbarMvPoly n) (d : Fin n →₀ ℕ) :
    coeff d (allOnesShift P) = coeff (d + allOnesExponent n) P := rfl

/-- `claim_qbar_full_elementary_symmetric_is_all_ones_monomial` の具体版。`es_{n,n} = mon_n(1_n)`。 -/
theorem qbarElementarySymmetric_self_eq_monomial_allOnes (n : ℕ) :
    qbarElementarySymmetric n n = qbarMonomial n (allOnesExponent n) := by
  calc qbarElementarySymmetric n n
      -- 第一の等号: 基本対称式の定義。
      = ∑ S ∈ Finset.powersetCard n (Finset.univ : Finset (Fin n)), ∏ k ∈ S, X k := rfl
      -- 第二の等号: n 元部分集合は ℕ_{<n} ただ一つ。
    _ = ∏ k ∈ (Finset.univ : Finset (Fin n)), (X k : QbarMvPoly n) := by
        have hself := Finset.powersetCard_self (Finset.univ : Finset (Fin n))
        rw [Finset.card_fin] at hself
        rw [hself, Finset.sum_singleton]
      -- 第三の等号: 1_n(k) = 1、一乗はその元。
    _ = ∏ k, (X k : QbarMvPoly n) ^ allOnesExponent n k := by
        simp only [allOnesExponent_apply, pow_one]
      -- 第四の等号: 単項式の定義。
    _ = qbarMonomial n (allOnesExponent n) := rfl

/-- `claim_symmetric_vanishing_last_variable_shifted_quotient_product` の準備。
`1_n ≤ c` でなければ、`c(k) = 0` となる `k` がある。 -/
theorem exists_eq_zero_of_not_allOnes_le {n : ℕ} (c : Fin n →₀ ℕ)
    (h : ¬ allOnesExponent n ≤ c) : ∃ k, c k = 0 := by
  rw [Finsupp.le_def] at h
  simp only [not_forall, not_le] at h
  obtain ⟨k, hk⟩ := h
  rw [allOnesExponent_apply] at hk
  exact ⟨k, by omega⟩

/-- `claim_symmetric_vanishing_last_variable_shifted_quotient_product` の具体版。
対称で `lz_n(P) = 0` の `P` は `es_{n+1,n+1} · sd_{n+1}(P)` に等しい。 -/
theorem symmetricVanishing_eq_elementarySymmetric_mul_allOnesShift {n : ℕ} (P : QbarMvPoly (n + 1))
    (hsym : IsQbarSymmetric P) (hlz : lastVariableZero n P = 0) :
    P = qbarElementarySymmetric (n + 1) (n + 1) * allOnesShift P := by
  classical
  ext c
  symm
  calc coeff c (qbarElementarySymmetric (n + 1) (n + 1) * allOnesShift P)
      -- 第一の等号: es_{n+1,n+1} = mon_{n+1}(1_{n+1})。
      = coeff c (qbarMonomial (n + 1) (allOnesExponent (n + 1)) * allOnesShift P) := by
        rw [qbarElementarySymmetric_self_eq_monomial_allOnes]
      -- 第二の等号: 単項式を掛けた係数。
    _ = if allOnesExponent (n + 1) ≤ c then coeff (c - allOnesExponent (n + 1)) (allOnesShift P)
          else 0 :=
        qbarMonomial_mul_coeff _ c _
      -- 第三の等号: 指数を一つ下げた多項式の係数。
    _ = if allOnesExponent (n + 1) ≤ c
          then coeff (c - allOnesExponent (n + 1) + allOnesExponent (n + 1)) P else 0 := by
        rw [allOnesShift_coeff]
      -- 第四の等号: 1 ≤ c なら (c - 1) + 1 = c。
    _ = if allOnesExponent (n + 1) ≤ c then coeff c P else 0 := by
        split_ifs with h
        · rw [tsub_add_cancel_of_le h]
        · rfl
      -- 第五の等号: 1 ≤ c でなければ c(k) = 0 の k があり、mco_c(P) = 0。
    _ = coeff c P := by
        split_ifs with h
        · rfl
        · obtain ⟨k, hk⟩ := exists_eq_zero_of_not_allOnes_le c h
          exact (symmetricVanishing_coeff_eq_zero P hsym hlz c k hk).symm

end Ising2DLambda.FisherZero
