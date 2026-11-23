/-
節「対称式の基本定理」の本体 `claim_symmetric_polynomial_fundamental_theorem` の具体版。

  人手証明                                                          このファイル
  変数の個数 n = 0（Ex_0 = {0}、se_0(mk_0(c)) = mk_0(c)、wsz_0 = 0）  `symmetricPolynomialFundamental_zero`
  準備: R := P + mk_{n+1}(−1)·se_{n+1}(Q_1) の所属                   `fundamentalRemainder_mem`
  準備: R の対称性（vs_ϱ の六つの等号）                              `fundamentalRemainder_isQbarSymmetric`
  準備: lz_n(R) = 0（八つの等号）                                    `fundamentalRemainder_lastVariableZero`
  準備: tdeg_{n+1}(R) ≤ d（二項の和の全次数の上界）                   `fundamentalRemainder_totalDegree_le`
  準備: P = se_{n+1}(Q_1) + R（六つの等号）                          `eq_elementarySymmetricSubst_add_fundamentalRemainder`
  帰納の段（全次数についての強い帰納法、R = 0 と R ≠ 0 の場合分け）   `symmetricPolynomialFundamental_succ`
  主張（変数の個数についての帰納法）                                 `symmetricPolynomialFundamental`

本文の mk_n(c) は `C c`、−1 は `-1 : Qbar`。

住処: Qbar（次数は ℕ）。R / C は現れない。
-/
import Ising2DLambda.FisherZero.WeightedDegreeSumAndLastVariableProduct
import Ising2DLambda.FisherZero.LastVariableZeroPreservesSymmetry
import Ising2DLambda.FisherZero.LastVariableZeroSubfieldCoefficientDegree
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionLastVariableZero
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionSubfieldCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `claim_symmetric_polynomial_fundamental_theorem` の n = 0 の場合。 -/
theorem symmetricPolynomialFundamental_zero (F : Subfield Qbar) (P : QbarMvPoly 0)
    (hF : P ∈ subfieldCoefficientMvPolys F 0) :
    ∃ Q ∈ subfieldCoefficientMvPolys F 0,
      P = elementarySymmetricSubst 0 Q ∧ qbarWeightedDegree Q ≤ qbarTotalDegree P := by
  -- 係数の比較: Ex_0 の元は零写像だけなので P = mk_0(mco_0(P))。
  have hP : P = C (coeff 0 P) := by
    ext a
    rw [Subsingleton.elim a 0, coeff_C, if_pos rfl]
  refine ⟨P, hF, ?_, ?_⟩
  · calc P = C (coeff 0 P) := hP
      -- ms_y(mk_0(c)) = mk_0(c)（def_qbar_multivariate_substitution）。
      _ = elementarySymmetricSubst 0 (C (coeff 0 P)) := (aeval_C _ _).symm
      _ = elementarySymmetricSubst 0 P := by rw [← hP]
  · -- wsz_0(a) は空集合にわたる和なので 0。
    apply Finset.sup_le
    intro a _
    simp [exponentWeightedTotal]

/-- 帰納の段の準備で置く多項式 `R := P + mk_{n+1}(−1)·se_{n+1}(Q_1)`。 -/
noncomputable def fundamentalRemainder {n : ℕ} (P Q₁ : QbarMvPoly (n + 1)) : QbarMvPoly (n + 1) :=
  P + C (-1) * elementarySymmetricSubst (n + 1) Q₁

/-- 準備: `R ∈ F[X_{<n+1}]`。 -/
theorem fundamentalRemainder_mem (F : Subfield Qbar) {n : ℕ} {P Q₁ : QbarMvPoly (n + 1)}
    (hP : P ∈ subfieldCoefficientMvPolys F (n + 1)) (hQ₁ : Q₁ ∈ subfieldCoefficientMvPolys F (n + 1)) :
    fundamentalRemainder P Q₁ ∈ subfieldCoefficientMvPolys F (n + 1) := by
  -- −1 ∈ F なので mk_{n+1}(−1) ∈ F[X_{<n+1}]（claim_subfield_coefficient_multivariate_constant）。
  have hC : (C (-1) : QbarMvPoly (n + 1)) ∈ subfieldCoefficientMvPolys F (n + 1) :=
    C_mem_subfieldCoefficientMvPolys F (F.neg_mem F.one_mem)
  -- se_{n+1}(Q_1) ∈ F[X_{<n+1}]（claim_elementary_symmetric_substitution_subfield_coefficient）。
  have hse := elementarySymmetricSubst_mem_subfieldCoefficientMvPolys F Q₁ hQ₁
  -- 積（claim_subfield_coefficient_multivariate_finite_product の二元の場合）。
  have hmul : (C (-1) : QbarMvPoly (n + 1)) * elementarySymmetricSubst (n + 1) Q₁ ∈
      subfieldCoefficientMvPolys F (n + 1) := by
    have h := prod_mem_subfieldCoefficientMvPolys F (Finset.univ : Finset (Fin 2))
      ![C (-1), elementarySymmetricSubst (n + 1) Q₁] (fun i _ => by fin_cases i; exacts [hC, hse])
    simpa only [Fin.prod_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one] using h
  -- 和（claim_subfield_coefficient_multivariate_finite_sum の二元の場合）。
  have h := sum_mem_subfieldCoefficientMvPolys F (Finset.univ : Finset (Fin 2))
    ![P, C (-1) * elementarySymmetricSubst (n + 1) Q₁] (fun i _ => by fin_cases i; exacts [hP, hmul])
  simpa only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, fundamentalRemainder] using h

/-- 準備: `R` は対称である。 -/
theorem fundamentalRemainder_isQbarSymmetric {n : ℕ} {P : QbarMvPoly (n + 1)} (hsym : IsQbarSymmetric P)
    (Q₁ : QbarMvPoly (n + 1)) : IsQbarSymmetric (fundamentalRemainder P Q₁) := by
  intro ϱ
  calc variablePermutation (n + 1) ϱ (fundamentalRemainder P Q₁)
      = variablePermutation (n + 1) ϱ (P + C (-1) * elementarySymmetricSubst (n + 1) Q₁) := rfl
      -- vs_ϱ は代入なので和と積を保つ（def_qbar_multivariate_substitution）。
    _ = variablePermutation (n + 1) ϱ P +
          variablePermutation (n + 1) ϱ (C (-1)) *
            variablePermutation (n + 1) ϱ (elementarySymmetricSubst (n + 1) Q₁) := by
        rw [map_add, map_mul]
      -- P は対称（def_qbar_symmetric_polynomial）。
    _ = P + variablePermutation (n + 1) ϱ (C (-1)) *
            variablePermutation (n + 1) ϱ (elementarySymmetricSubst (n + 1) Q₁) := by
        rw [hsym ϱ]
      -- ms_y(mk(c)) = mk(c)（def_qbar_multivariate_substitution）。
    _ = P + C (-1) * variablePermutation (n + 1) ϱ (elementarySymmetricSubst (n + 1) Q₁) := by
        rw [show variablePermutation (n + 1) ϱ (C (-1)) = C (-1) from aeval_C _ _]
      -- claim_elementary_symmetric_substitution_symmetric。
    _ = P + C (-1) * elementarySymmetricSubst (n + 1) Q₁ := by
        rw [elementarySymmetricSubst_isQbarSymmetric Q₁ ϱ]
    _ = fundamentalRemainder P Q₁ := rfl

/-- 準備: `lz_n(R) = 0`（`Q_1 = ex_n(Q_0)`、`lz_n(P) = se_n(Q_0)`）。 -/
theorem fundamentalRemainder_lastVariableZero {n : ℕ} (P : QbarMvPoly (n + 1)) (Q₀ : QbarMvPoly n)
    (hQ₀ : lastVariableZero n P = elementarySymmetricSubst n Q₀) :
    lastVariableZero n (fundamentalRemainder P (lastVariableExtension Q₀)) = 0 := by
  calc lastVariableZero n (fundamentalRemainder P (lastVariableExtension Q₀))
      = lastVariableZero n (P + C (-1) * elementarySymmetricSubst (n + 1) (lastVariableExtension Q₀)) :=
        rfl
      -- lz_n は代入なので和と積を保つ（def_qbar_multivariate_substitution）。
    _ = lastVariableZero n P + lastVariableZero n (C (-1)) *
          lastVariableZero n (elementarySymmetricSubst (n + 1) (lastVariableExtension Q₀)) := by
        rw [map_add, map_mul]
      -- ms_y(mk(c)) = mk(c)。
    _ = lastVariableZero n P + C (-1) *
          lastVariableZero n (elementarySymmetricSubst (n + 1) (lastVariableExtension Q₀)) := by
        rw [show lastVariableZero n (C (-1)) = C (-1) from aeval_C _ _]
      -- claim_elementary_symmetric_substitution_last_variable_zero。
    _ = lastVariableZero n P + C (-1) *
          elementarySymmetricSubst n (lastVariableZero n (lastVariableExtension Q₀)) := by
        rw [lastVariableZero_elementarySymmetricSubst]
      -- claim_last_variable_zero_of_extension。
    _ = lastVariableZero n P + C (-1) * elementarySymmetricSubst n Q₀ := by
        rw [lastVariableZero_lastVariableExtension]
      -- Q_0 の取り方。
    _ = lastVariableZero n P + C (-1) * lastVariableZero n P := by rw [hQ₀]
      -- mk_n(1) は単位元。
    _ = C 1 * lastVariableZero n P + C (-1) * lastVariableZero n P := by rw [C_1, one_mul]
      -- 分配法則。
    _ = (C 1 + C (-1)) * lastVariableZero n P := (add_mul _ _ _).symm
      -- 和の係数の式: mk_n(1) + mk_n(−1) = mk_n(0)。
    _ = C 0 * lastVariableZero n P := by rw [← C_add, add_neg_cancel]
      -- mk_n(0) は零元で、零元との積は零元。
    _ = 0 := by rw [C_0, zero_mul]

/-- 準備: `tdeg_{n+1}(R) ≤ d`（`tdeg_{n+1}(P) = d`、`wdeg_{n+1}(Q_1) ≤ d`）。 -/
theorem fundamentalRemainder_totalDegree_le {n d : ℕ} {P Q₁ : QbarMvPoly (n + 1)}
    (hP : qbarTotalDegree P = d) (hQ₁ : qbarWeightedDegree Q₁ ≤ d) :
    qbarTotalDegree (fundamentalRemainder P Q₁) ≤ d := by
  have hterm : qbarTotalDegree (C (-1) * elementarySymmetricSubst (n + 1) Q₁) ≤ d :=
    calc qbarTotalDegree (C (-1) * elementarySymmetricSubst (n + 1) Q₁)
        -- claim_qbar_total_degree_product_bound。
        ≤ qbarTotalDegree (C (-1) : QbarMvPoly (n + 1)) +
            qbarTotalDegree (elementarySymmetricSubst (n + 1) Q₁) := qbarTotalDegree_mul_le _ _
        -- claim_qbar_total_degree_constant。
      _ = 0 + qbarTotalDegree (elementarySymmetricSubst (n + 1) Q₁) := by rw [qbarTotalDegree_C]
        -- claim_elementary_symmetric_substitution_degree_bound。
      _ ≤ 0 + qbarWeightedDegree Q₁ :=
          Nat.add_le_add_left (qbarTotalDegree_elementarySymmetricSubst_le Q₁) _
      _ ≤ d := by rw [Nat.zero_add]; exact hQ₁
  -- claim_qbar_total_degree_finite_sum_bound（二元の添字集合、m = d）。
  have h := qbarTotalDegree_sum_le (Finset.univ : Finset (Fin 2))
    ![P, C (-1) * elementarySymmetricSubst (n + 1) Q₁] d
    (fun i _ => by fin_cases i; exacts [hP.le, hterm])
  simpa only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, fundamentalRemainder] using h

/-- 準備: `P = se_{n+1}(Q_1) + R`。 -/
theorem eq_elementarySymmetricSubst_add_fundamentalRemainder {n : ℕ} (P Q₁ : QbarMvPoly (n + 1)) :
    P = elementarySymmetricSubst (n + 1) Q₁ + fundamentalRemainder P Q₁ := by
  calc P = P + 0 := (add_zero P).symm
      -- mk_{n+1}(0) は零元で、零元との積は零元。
    _ = P + C 0 * elementarySymmetricSubst (n + 1) Q₁ := by rw [C_0, zero_mul]
      -- 和の係数の式: mk(0) = mk(1) + mk(−1)。
    _ = P + (C 1 + C (-1)) * elementarySymmetricSubst (n + 1) Q₁ := by
        rw [← C_add, add_neg_cancel]
      -- 分配法則。
    _ = P + (C 1 * elementarySymmetricSubst (n + 1) Q₁ +
          C (-1) * elementarySymmetricSubst (n + 1) Q₁) := by rw [add_mul]
      -- mk(1) は単位元。
    _ = P + (elementarySymmetricSubst (n + 1) Q₁ + C (-1) * elementarySymmetricSubst (n + 1) Q₁) := by
        rw [C_1, one_mul]
      -- 加法の交換法則・結合法則と R の置き方。
    _ = elementarySymmetricSubst (n + 1) Q₁ + fundamentalRemainder P Q₁ := by
        unfold fundamentalRemainder
        rw [← add_assoc, add_comm P, add_assoc]

/-- 帰納の段: `n` で主張が成り立つなら `n + 1` で、全次数が `d` の対称な `P` について成り立つ
（`d` についての強い帰納法）。 -/
theorem symmetricPolynomialFundamental_succ (F : Subfield Qbar) (n : ℕ)
    (ih : ∀ P : QbarMvPoly n, P ∈ subfieldCoefficientMvPolys F n → IsQbarSymmetric P →
      ∃ Q ∈ subfieldCoefficientMvPolys F n,
        P = elementarySymmetricSubst n Q ∧ qbarWeightedDegree Q ≤ qbarTotalDegree P) (d : ℕ) :
    ∀ P : QbarMvPoly (n + 1), qbarTotalDegree P = d → P ∈ subfieldCoefficientMvPolys F (n + 1) →
      IsQbarSymmetric P → ∃ Q ∈ subfieldCoefficientMvPolys F (n + 1),
        P = elementarySymmetricSubst (n + 1) Q ∧ qbarWeightedDegree Q ≤ d := by
  induction d using Nat.strong_induction_on with
  | _ d ihd =>
  intro P hdeg hF hsym
  -- 準備: P_0 := lz_n(P) の所属・対称性・全次数（三つの主張）と、外側の帰納法の仮定による Q_0。
  have hP₀F := lastVariableZero_mem_subfieldCoefficientMvPolys F P hF
  have hP₀sym := lastVariableZero_isQbarSymmetric P hsym
  have hP₀deg : qbarTotalDegree (lastVariableZero n P) ≤ d :=
    hdeg ▸ qbarTotalDegree_lastVariableZero_le P
  obtain ⟨Q₀, hQ₀F, hQ₀eq, hQ₀deg⟩ := ih (lastVariableZero n P) hP₀F hP₀sym
  -- 準備: Q_1 := ex_n(Q_0) の所属と重み付き次数。
  have hQ₁F := lastVariableExtension_mem_subfieldCoefficientMvPolys F Q₀ hQ₀F
  have hQ₁deg : qbarWeightedDegree (lastVariableExtension Q₀) ≤ d :=
    calc qbarWeightedDegree (lastVariableExtension Q₀)
        -- claim_last_variable_extension_weighted_degree_bound。
        ≤ qbarWeightedDegree Q₀ := qbarWeightedDegree_lastVariableExtension_le Q₀
        -- Q_0 の取り方。
      _ ≤ qbarTotalDegree (lastVariableZero n P) := hQ₀deg
        -- claim_last_variable_zero_total_degree_bound。
      _ ≤ d := hP₀deg
  -- 準備: R の所属・対称性・零代入・全次数と、P = se(Q_1) + R。
  set Q₁ := lastVariableExtension Q₀ with hQ₁def
  set R := fundamentalRemainder P Q₁ with hRdef
  have hRF : R ∈ subfieldCoefficientMvPolys F (n + 1) := fundamentalRemainder_mem F hF hQ₁F
  have hRsym : IsQbarSymmetric R := fundamentalRemainder_isQbarSymmetric hsym Q₁
  have hRlz : lastVariableZero n R = 0 := fundamentalRemainder_lastVariableZero P Q₀ hQ₀eq
  have hRdeg : qbarTotalDegree R ≤ d := fundamentalRemainder_totalDegree_le hdeg hQ₁deg
  have hPR : P = elementarySymmetricSubst (n + 1) Q₁ + R :=
    eq_elementarySymmetricSubst_add_fundamentalRemainder P Q₁
  -- 準備: claim_symmetric_vanishing_last_variable_divisible_by_product を R に当てる。
  obtain ⟨S, hSF, hSsym, hRS, hSdeg⟩ :=
    symmetricVanishing_divisible_by_elementarySymmetric F R hRF hRsym hRlz
  by_cases hR0 : R = 0
  · -- R = 0 のとき: Q := Q_1。
    refine ⟨Q₁, hQ₁F, ?_, hQ₁deg⟩
    calc P = elementarySymmetricSubst (n + 1) Q₁ + R := hPR
      _ = elementarySymmetricSubst (n + 1) Q₁ + 0 := by rw [hR0]
      _ = elementarySymmetricSubst (n + 1) Q₁ := add_zero _
  · -- R ≠ 0 のとき: tdeg(S) < d なので内側の帰納法の仮定から Q_2。
    have hSdeg' := hSdeg hR0
    have hSlt : qbarTotalDegree S < d :=
      calc qbarTotalDegree S < qbarTotalDegree S + (n + 1) := Nat.lt_add_of_pos_right (Nat.succ_pos n)
        _ = qbarTotalDegree R := hSdeg'
        _ ≤ d := hRdeg
    obtain ⟨Q₂, hQ₂F, hQ₂eq, hQ₂deg⟩ := ihd (qbarTotalDegree S) hSlt S rfl hSF hSsym
    -- Q := Q_1 + X^{(n+1)}_n · Q_2 の所属（変数・二元の積・二元の和）。
    have hXQ₂F : X (Fin.last n) * Q₂ ∈ subfieldCoefficientMvPolys F (n + 1) := by
      have h := prod_mem_subfieldCoefficientMvPolys F (Finset.univ : Finset (Fin 2))
        ![X (Fin.last n), Q₂]
        (fun i _ => by
          fin_cases i
          exacts [X_mem_subfieldCoefficientMvPolys F (Fin.last n), hQ₂F])
      simpa only [Fin.prod_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one] using h
    have hQF : Q₁ + X (Fin.last n) * Q₂ ∈ subfieldCoefficientMvPolys F (n + 1) := by
      have h := sum_mem_subfieldCoefficientMvPolys F (Finset.univ : Finset (Fin 2))
        ![Q₁, X (Fin.last n) * Q₂] (fun i _ => by fin_cases i; exacts [hQ₁F, hXQ₂F])
      simpa only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, fundamentalRemainder] using h
    refine ⟨Q₁ + X (Fin.last n) * Q₂, hQF, ?_, ?_⟩
    · calc P = elementarySymmetricSubst (n + 1) Q₁ + R := hPR
        -- claim_symmetric_vanishing_last_variable_divisible_by_product。
        _ = elementarySymmetricSubst (n + 1) Q₁ + qbarElementarySymmetric (n + 1) (n + 1) * S := by
            rw [← hRS]
        -- Q_2 の取り方。
        _ = elementarySymmetricSubst (n + 1) Q₁ +
              qbarElementarySymmetric (n + 1) (n + 1) * elementarySymmetricSubst (n + 1) Q₂ := by
            rw [← hQ₂eq]
        -- def_elementary_symmetric_substitution: ee_{n+1}(n) = es_{n+1,n+1}。
        _ = elementarySymmetricSubst (n + 1) Q₁ +
              elementarySymmetricValues (n + 1) (Fin.last n) * elementarySymmetricSubst (n + 1) Q₂ := rfl
        -- ms_y(X_k) = y(k)（def_qbar_multivariate_substitution）と se の定義。
        _ = elementarySymmetricSubst (n + 1) Q₁ +
              elementarySymmetricSubst (n + 1) (X (Fin.last n)) * elementarySymmetricSubst (n + 1) Q₂ := by
            rw [show elementarySymmetricSubst (n + 1) (X (Fin.last n)) =
              elementarySymmetricValues (n + 1) (Fin.last n) from aeval_X _ _]
        -- se は和と積を保つ（def_qbar_multivariate_substitution）。
        _ = elementarySymmetricSubst (n + 1) (Q₁ + X (Fin.last n) * Q₂) := by
            rw [map_add, map_mul]
    · calc qbarWeightedDegree (Q₁ + X (Fin.last n) * Q₂)
          -- claim_qbar_weighted_degree_sum_bound。
          ≤ max (qbarWeightedDegree Q₁) (qbarWeightedDegree (X (Fin.last n) * Q₂)) :=
            qbarWeightedDegree_add_le _ _
          -- Q_1 の重み付き次数の評価。
        _ ≤ max d (qbarWeightedDegree (X (Fin.last n) * Q₂)) := max_le_max hQ₁deg le_rfl
          -- claim_qbar_weighted_degree_last_variable_product_bound。
        _ ≤ max d ((n + 1) + qbarWeightedDegree Q₂) :=
            max_le_max le_rfl (qbarWeightedDegree_X_last_mul_le Q₂)
          -- Q_2 の取り方。
        _ ≤ max d ((n + 1) + qbarTotalDegree S) :=
            max_le_max le_rfl (Nat.add_le_add_left hQ₂deg _)
          -- 割り切れの主張の全次数の等号（R ≠ 0）。
        _ = max d (qbarTotalDegree R) := by rw [Nat.add_comm, hSdeg']
          -- R の全次数の評価。
        _ = d := max_eq_left hRdeg

/-- `claim_symmetric_polynomial_fundamental_theorem` の具体版（変数の個数についての帰納法）。 -/
theorem symmetricPolynomialFundamental (F : Subfield Qbar) :
    ∀ (n : ℕ) (P : QbarMvPoly n), P ∈ subfieldCoefficientMvPolys F n → IsQbarSymmetric P →
      ∃ Q ∈ subfieldCoefficientMvPolys F n,
        P = elementarySymmetricSubst n Q ∧ qbarWeightedDegree Q ≤ qbarTotalDegree P
  | 0, P, hF, _ => symmetricPolynomialFundamental_zero F P hF
  | n + 1, P, hF, hsym =>
      symmetricPolynomialFundamental_succ F n (symmetricPolynomialFundamental F n)
        (qbarTotalDegree P) P rfl hF hsym

end Ising2DLambda.FisherZero
