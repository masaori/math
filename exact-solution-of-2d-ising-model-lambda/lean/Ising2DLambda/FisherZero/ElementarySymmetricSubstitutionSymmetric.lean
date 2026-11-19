/-
節「基本対称式への代入」の具体版（対称性の部分）。

  人手証明                                                       このファイル
  主張 `claim_qbar_multivariate_substitution_composition`        `qbarMvSubst_comp`
    第一の等号（代入の定義）                                     `MvPolynomial.aeval_eq_eval₂Hom`・`MvPolynomial.eval₂_eq'`
    第二の等号（ms_y は有限和・有限積・冪を保つ）                `map_sum`・`map_mul`・`map_prod`・`map_pow`
    第三の等号（ms_y(mk_m(c)) = mk_p(c)）                        `AlgHom.commutes`
    第四の等号（合成の定義）                                     定義どおり
    第五の等号（代入の定義）                                     `MvPolynomial.aeval_eq_eval₂Hom`・`MvPolynomial.eval₂_eq'`
  主張 `claim_qbar_elementary_symmetric_is_symmetric`            `elementarySymmetric_isQbarSymmetric`
    第一の準備（∏_{k∈S} X_{ϱ(k)} = ∏_{i∈ϱ(S)} X_i）               `elementarySymmetric_term_perm`
    第二の準備（S ↦ ϱ(S) は j 元部分集合の全単射）                `Finset.sum_nbij'` の五つの段
    第二の等号（代入は有限和・有限積を保つ）                     `map_sum`・`map_prod`
    第三の等号（vs_ϱ(X_k) = X_{ϱ(k)}）                            `variablePermutation_X`
  定義 `def_elementary_symmetric_substitution`                   `elementarySymmetricValues`・`elementarySymmetricSubst`
  主張 `claim_elementary_symmetric_substitution_symmetric`       `elementarySymmetricSubst_isQbarSymmetric`
    準備（vs_ϱ ∘ ee_n = ee_n）                                    `variablePermutation_comp_elementarySymmetricValues`
    第二の等号（代入の合成）                                     `qbarMvSubst_comp`

本文の `ϱ(S) = {ϱ(k) | k ∈ S}` は `S.map ϱ.toEmbedding` で書く。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.VariablePermutationCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `claim_qbar_multivariate_substitution_composition` の具体版。
`ms_y(ms_e(Q)) = ms_{ms_y ∘ e}(Q)`。 -/
theorem qbarMvSubst_comp {n m p : ℕ} (e : Fin n → QbarMvPoly m) (y : Fin m → QbarMvPoly p)
    (Q : QbarMvPoly n) :
    qbarMvSubst y (qbarMvSubst e Q) = qbarMvSubst (fun k => qbarMvSubst y (e k)) Q := by
  -- 第一の等号: 内側の代入の定義。
  have hinner : qbarMvSubst e Q =
      ∑ d ∈ Q.support, algebraMap Qbar (QbarMvPoly m) (coeff d Q) * ∏ i, e i ^ d i := by
    rw [qbarMvSubst, aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']
  rw [hinner]
  -- 第二の等号: ms_y は有限和・積・有限積・冪を保つ。
  rw [map_sum]
  simp_rw [map_mul, map_prod, map_pow]
  -- 第三の等号: ms_y(mk_m(c)) = mk_p(c)。
  simp_rw [AlgHom.commutes]
  -- 第四・第五の等号: 合成の定義と外側の代入の定義。
  conv_rhs => rw [qbarMvSubst, aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']

/-- `def_qbar_variable_permutation` の値: `vs_ϱ(X^{(n)}_k) = X^{(n)}_{ϱ(k)}`。 -/
theorem variablePermutation_X {n : ℕ} (ϱ : Equiv.Perm (Fin n)) (k : Fin n) :
    variablePermutation n ϱ (X k) = X (ϱ k) := by
  simp [variablePermutation, qbarMvSubst, variablePermutationValues]

/-- `claim_qbar_elementary_symmetric_is_symmetric` の第一の準備。
`∏_{k ∈ S} X_{ϱ(k)} = ∏_{i ∈ ϱ(S)} X_i`。 -/
theorem elementarySymmetric_term_perm {n : ℕ} (ϱ : Equiv.Perm (Fin n)) (S : Finset (Fin n)) :
    ∏ k ∈ S, (X (ϱ k) : QbarMvPoly n) = ∏ i ∈ S.map ϱ.toEmbedding, X i := by
  rw [Finset.prod_map]
  rfl

/-- `claim_qbar_elementary_symmetric_is_symmetric` の具体版。`es_{n,j}` は対称。 -/
theorem elementarySymmetric_isQbarSymmetric (n j : ℕ) :
    IsQbarSymmetric (qbarElementarySymmetric n j) := by
  classical
  intro ϱ
  -- 第一の等号: 基本対称式の定義。
  unfold qbarElementarySymmetric
  -- 第二の等号: 代入は有限和と有限積を保つ。
  rw [map_sum]
  simp_rw [map_prod]
  -- 第三の等号: vs_ϱ(X_k) = X_{ϱ(k)}。
  simp_rw [variablePermutation_X]
  -- 第四の等号: 第一の準備。
  simp_rw [elementarySymmetric_term_perm]
  -- 第五の等号: 第二の準備（S ↦ ϱ(S) は j 元部分集合の全単射、逆は T ↦ ϱ^{-1}(T)）。
  refine Finset.sum_nbij' (fun S => S.map ϱ.toEmbedding) (fun T => T.map ϱ.symm.toEmbedding)
    ?_ ?_ ?_ ?_ ?_
  · -- ϱ(S) は j 元部分集合（ϱ は単射なので |ϱ(S)| = |S|）。
    intro S hS
    simp only [Finset.mem_powersetCard, Finset.subset_univ, true_and] at hS ⊢
    rw [Finset.card_map, hS]
  · -- ϱ^{-1}(T) は j 元部分集合。
    intro T hT
    simp only [Finset.mem_powersetCard, Finset.subset_univ, true_and] at hT ⊢
    rw [Finset.card_map, hT]
  · -- ϱ^{-1}(ϱ(S)) = S。
    intro S _
    ext k
    simp
  · -- ϱ(ϱ^{-1}(T)) = T。
    intro T _
    ext i
    simp
  · -- 各項は同じ。
    intro S _
    rfl

/-- `def_elementary_symmetric_substitution` の代入する値。`ee_n(j) = es_{n,j+1}`。 -/
noncomputable def elementarySymmetricValues (n : ℕ) : Fin n → QbarMvPoly n :=
  fun j => qbarElementarySymmetric n (j.val + 1)

/-- `def_elementary_symmetric_substitution` の具体版 `se_n = ms_{ee_n}`。 -/
noncomputable def elementarySymmetricSubst (n : ℕ) : QbarMvPoly n →ₐ[Qbar] QbarMvPoly n :=
  qbarMvSubst (elementarySymmetricValues n)

/-- `claim_elementary_symmetric_substitution_symmetric` の準備。`vs_ϱ ∘ ee_n = ee_n`。 -/
theorem variablePermutation_comp_elementarySymmetricValues {n : ℕ} (ϱ : Equiv.Perm (Fin n)) :
    (fun j => variablePermutation n ϱ (elementarySymmetricValues n j)) =
      elementarySymmetricValues n := by
  funext j
  calc variablePermutation n ϱ (elementarySymmetricValues n j)
      = variablePermutation n ϱ (qbarElementarySymmetric n (j.val + 1)) := rfl
    _ = qbarElementarySymmetric n (j.val + 1) := elementarySymmetric_isQbarSymmetric n (j.val + 1) ϱ
    _ = elementarySymmetricValues n j := rfl

/-- `claim_elementary_symmetric_substitution_symmetric` の具体版。`se_n(Q)` は対称。 -/
theorem elementarySymmetricSubst_isQbarSymmetric {n : ℕ} (Q : QbarMvPoly n) :
    IsQbarSymmetric (elementarySymmetricSubst n Q) := by
  intro ϱ
  calc variablePermutation n ϱ (elementarySymmetricSubst n Q)
      = qbarMvSubst (variablePermutationValues n ϱ) (qbarMvSubst (elementarySymmetricValues n) Q) := rfl
    _ = qbarMvSubst (fun j => qbarMvSubst (variablePermutationValues n ϱ)
          (elementarySymmetricValues n j)) Q := qbarMvSubst_comp _ _ Q
    _ = qbarMvSubst (elementarySymmetricValues n) Q := by
        rw [show (fun j => qbarMvSubst (variablePermutationValues n ϱ)
          (elementarySymmetricValues n j)) = elementarySymmetricValues n from
          variablePermutation_comp_elementarySymmetricValues ϱ]
    _ = elementarySymmetricSubst n Q := rfl

end Ising2DLambda.FisherZero
