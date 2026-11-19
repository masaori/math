/-
節「根の対の整数倍のずらしの基本対称式」の具体版。

  人手証明                                                         このファイル
  定義 `def_pair_shift_values`                                     `RootIndexPair`・`pairShiftValues`
  主張 `claim_pair_shift_elementary_symmetric_is_symmetric`        `pairShiftElementarySymmetric_isQbarSymmetric`
    第一の準備（pp_ϱ は Pr_d の全単射）                             `pairPermutationFun`・`pairPermutationFun_symm`・`pairPermutation`
    第二の準備（ip_ϱ := ν^{-1} ∘ pp_ϱ ∘ ν ∈ 𝔓_N）                    `pairIndexPermutation`
    第三の準備（vs_ϱ(ps(r)) = ps(ip_ϱ(r))）                          `variablePermutation_pairShiftValues`
    第四の準備（ms_ps(X^{(N)}_{ip(r)}) = ps(ip(r))）                  式鎖の第四の等号の `MvPolynomial.aeval_X`
    式鎖の第二・第五の等号（代入の合成）                           `qbarMvSubst_comp`
    式鎖の第七の等号（基本対称式は対称）                           `elementarySymmetric_isQbarSymmetric`
  主張 `claim_pair_shift_elementary_symmetric_subfield_coefficient` `pairShiftElementarySymmetric_mem_subfieldCoefficientMvPolys`
    第一の準備（y(r) ∈ F[X_{<d}]）                                  `pairShiftValues_mem_subfieldCoefficientMvPolys`
    T_a ∈ F[X_{<d}]                                                 同じ名前の `have`
    式鎖の第一の等号（ms_y の定義の有限和）                         `MvPolynomial.aeval_def`・`MvPolynomial.eval₂_eq'`

本文の根の番号の対の集合 `Pr_d = {(i,j) | i < j < d}` は部分型 `RootIndexPair d`、
全単射 `ν : ℕ_{<N} → Pr_d` は `π : Fin N ≃ RootIndexPair d`、`ps_{c,ν}` は `pairShiftValues c π`、
`pp_ϱ` は `pairPermutation ϱ`、`ip_ϱ` は `pairIndexPermutation π ϱ` で書く。
本文の `min`・`max` は `Fin d` の `min`・`max`。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionSubfieldCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_pair_shift_values` の根の番号の対の集合 `P_d = {(i,j) ∈ ℕ_{<d} × ℕ_{<d} | i < j}`。 -/
abbrev RootIndexPair (d : ℕ) : Type := {p : Fin d × Fin d // p.1 < p.2}

/-- `def_pair_shift_values` の具体版。`π(r) = (i,j)` について
`y_{c,π}(r) = X^{(d)}_i + X^{(d)}_j + mk_d(c) · X^{(d)}_i · X^{(d)}_j`。 -/
noncomputable def pairShiftValues {d N : ℕ} (c : Qbar) (π : Fin N ≃ RootIndexPair d) :
    Fin N → QbarMvPoly d :=
  fun r => X (π r).1.1 + X (π r).1.2 + C c * X (π r).1.1 * X (π r).1.2

/-- `claim_pair_shift_elementary_symmetric_is_symmetric` の第一の準備の写像
`σ_ϱ(i,j) = (min(ϱ(i),ϱ(j)), max(ϱ(i),ϱ(j)))`。`ϱ` は単射なので `ϱ(i) ≠ ϱ(j)`、よって `min < max`。 -/
def pairPermutationFun {d : ℕ} (ϱ : Equiv.Perm (Fin d)) (p : RootIndexPair d) : RootIndexPair d :=
  ⟨(min (ϱ p.1.1) (ϱ p.1.2), max (ϱ p.1.1) (ϱ p.1.2)),
    min_lt_max.mpr (fun h => (ne_of_lt p.2) (ϱ.injective h))⟩

/-- 第一の準備: `σ_{ϱ^{-1}}(σ_ϱ(i,j)) = (i,j)`。
`ϱ(i) < ϱ(j)` なら `σ_ϱ(i,j) = (ϱ(i),ϱ(j))`、そうでなければ `(ϱ(j),ϱ(i))` で、
どちらも `ϱ^{-1}` で `{i,j}` に戻り、`i < j` なので `(min, max) = (i,j)`。 -/
theorem pairPermutationFun_symm {d : ℕ} (ϱ : Equiv.Perm (Fin d)) (p : RootIndexPair d) :
    pairPermutationFun ϱ.symm (pairPermutationFun ϱ p) = p := by
  obtain ⟨⟨i, j⟩, hij⟩ := p
  apply Subtype.ext
  simp only [pairPermutationFun]
  rcases lt_or_ge (ϱ i) (ϱ j) with h | h
  · -- ϱ(i) < ϱ(j) のとき。
    rw [min_eq_left h.le, max_eq_right h.le]
    simp only [Equiv.symm_apply_apply]
    rw [min_eq_left hij.le, max_eq_right hij.le]
  · -- ϱ(j) ≤ ϱ(i) のとき。
    rw [min_eq_right h, max_eq_left h]
    simp only [Equiv.symm_apply_apply]
    rw [min_eq_right hij.le, max_eq_left hij.le]

/-- 第一の準備: `σ_ϱ` は `P_d` の全単射で、逆写像は `σ_{ϱ^{-1}}`。 -/
def pairPermutation {d : ℕ} (ϱ : Equiv.Perm (Fin d)) : RootIndexPair d ≃ RootIndexPair d where
  toFun := pairPermutationFun ϱ
  invFun := pairPermutationFun ϱ.symm
  left_inv := pairPermutationFun_symm ϱ
  right_inv := by
    intro p
    have h := pairPermutationFun_symm ϱ.symm p
    rwa [Equiv.symm_symm] at h

/-- 第二の準備: `τ_ϱ := π^{-1} ∘ σ_ϱ ∘ π ∈ 𝔓_N`。 -/
def pairIndexPermutation {d N : ℕ} (π : Fin N ≃ RootIndexPair d) (ϱ : Equiv.Perm (Fin d)) :
    Equiv.Perm (Fin N) :=
  π.trans ((pairPermutation ϱ).trans π.symm)

/-- 第三の準備: `vs_ϱ(y_{c,π}(r)) = y_{c,π}(τ_ϱ(r))`。 -/
theorem variablePermutation_pairShiftValues {d N : ℕ} (c : Qbar) (π : Fin N ≃ RootIndexPair d)
    (ϱ : Equiv.Perm (Fin d)) (r : Fin N) :
    variablePermutation d ϱ (pairShiftValues c π r) =
      pairShiftValues c π (pairIndexPermutation π ϱ r) := by
  -- π(τ_ϱ(r)) = σ_ϱ(π(r))。
  have hπ : π (pairIndexPermutation π ϱ r) = pairPermutationFun ϱ (π r) := by
    simp [pairIndexPermutation, pairPermutation]
  -- vs_ϱ は和・積・定数を保ち、vs_ϱ(X_k) = X_{ϱ(k)}。
  have hlhs : variablePermutation d ϱ (pairShiftValues c π r) =
      X (ϱ (π r).1.1) + X (ϱ (π r).1.2) + C c * X (ϱ (π r).1.1) * X (ϱ (π r).1.2) := by
    have hC : variablePermutation d ϱ (C c) = C c := by
      rw [← algebraMap_eq]
      exact AlgHom.commutes _ _
    simp only [pairShiftValues, map_add, map_mul, hC, variablePermutation_X]
  rw [hlhs, pairShiftValues, hπ]
  simp only [pairPermutationFun]
  rcases le_total (ϱ (π r).1.1) (ϱ (π r).1.2) with h | h
  · -- ϱ(i) ≤ ϱ(j) のとき: (min, max) = (ϱ(i), ϱ(j))。
    rw [min_eq_left h, max_eq_right h]
  · -- ϱ(j) ≤ ϱ(i) のとき: (min, max) = (ϱ(j), ϱ(i))。和と積の可換律。
    rw [min_eq_right h, max_eq_left h]
    ring

/-- `claim_pair_shift_elementary_symmetric_is_symmetric` の具体版。
`ms_{y_{c,π}}(es_{N,k})` は対称。 -/
theorem pairShiftElementarySymmetric_isQbarSymmetric {d N : ℕ} (c : Qbar)
    (π : Fin N ≃ RootIndexPair d) (k : ℕ) :
    IsQbarSymmetric (qbarMvSubst (pairShiftValues c π) (qbarElementarySymmetric N k)) := by
  intro ϱ
  calc variablePermutation d ϱ (qbarMvSubst (pairShiftValues c π) (qbarElementarySymmetric N k))
      = qbarMvSubst (variablePermutationValues d ϱ)
          (qbarMvSubst (pairShiftValues c π) (qbarElementarySymmetric N k)) := rfl
    -- 第二の等号: 代入の合成。
    _ = qbarMvSubst (fun r => qbarMvSubst (variablePermutationValues d ϱ) (pairShiftValues c π r))
          (qbarElementarySymmetric N k) := qbarMvSubst_comp _ _ _
    -- 第三の等号: 第三の準備。
    _ = qbarMvSubst (fun r => pairShiftValues c π (pairIndexPermutation π ϱ r))
          (qbarElementarySymmetric N k) := by
        exact congrArg (fun y => qbarMvSubst y (qbarElementarySymmetric N k))
          (funext fun r => variablePermutation_pairShiftValues c π ϱ r)
    -- 第四の等号: ms_y(X^{(N)}_{τ(r)}) = y(τ(r))。
    _ = qbarMvSubst (fun r => qbarMvSubst (pairShiftValues c π)
          (variablePermutationValues N (pairIndexPermutation π ϱ) r))
          (qbarElementarySymmetric N k) := by
        refine congrArg (fun y => qbarMvSubst y (qbarElementarySymmetric N k)) (funext fun r => ?_)
        simp [qbarMvSubst, variablePermutationValues]
    -- 第五の等号: 代入の合成を逆に。
    _ = qbarMvSubst (pairShiftValues c π)
          (qbarMvSubst (variablePermutationValues N (pairIndexPermutation π ϱ))
            (qbarElementarySymmetric N k)) := (qbarMvSubst_comp _ _ _).symm
    -- 第六の等号: vs_τ の定義。
    _ = qbarMvSubst (pairShiftValues c π)
          (variablePermutation N (pairIndexPermutation π ϱ) (qbarElementarySymmetric N k)) := rfl
    -- 第七の等号: 基本対称式は対称。
    _ = qbarMvSubst (pairShiftValues c π) (qbarElementarySymmetric N k) := by
        rw [elementarySymmetric_isQbarSymmetric N k (pairIndexPermutation π ϱ)]

/-- `claim_pair_shift_elementary_symmetric_subfield_coefficient` の第一の準備。
`c ∈ F` なら `y_{c,π}(r) ∈ F[X_{<d}]`。 -/
theorem pairShiftValues_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {d N : ℕ} {c : Qbar}
    (hc : c ∈ F) (π : Fin N ≃ RootIndexPair d) (r : Fin N) :
    pairShiftValues c π r ∈ subfieldCoefficientMvPolys F d := by
  have hi := X_mem_subfieldCoefficientMvPolys F (n := d) (π r).1.1
  have hj := X_mem_subfieldCoefficientMvPolys F (n := d) (π r).1.2
  -- mk_d(c) · X_i · X_j ∈ F[X_{<d}]（積の閉性を二回）。
  have hprod : C c * X (π r).1.1 * X (π r).1.2 ∈ subfieldCoefficientMvPolys F d :=
    mul_mem_subfieldCoefficientMvPolys F
      (mul_mem_subfieldCoefficientMvPolys F (C_mem_subfieldCoefficientMvPolys F hc) hi) hj
  -- 三項の和（二元の和の閉性を二回）。
  have hadd : ∀ A B : QbarMvPoly d, A ∈ subfieldCoefficientMvPolys F d →
      B ∈ subfieldCoefficientMvPolys F d → A + B ∈ subfieldCoefficientMvPolys F d := by
    intro A B hA hB
    have h := sum_mem_subfieldCoefficientMvPolys F (Finset.univ : Finset (Fin 2)) ![A, B]
      (fun i _ => by fin_cases i <;> simpa)
    rwa [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one,
      Matrix.cons_val_fin_one] at h
  exact hadd _ _ (hadd _ _ hi hj) hprod

/-- `claim_pair_shift_elementary_symmetric_subfield_coefficient` の具体版。
`c ∈ F` なら `ms_{y_{c,π}}(es_{N,k}) ∈ F[X_{<d}]`。 -/
theorem pairShiftElementarySymmetric_mem_subfieldCoefficientMvPolys (F : Subfield Qbar)
    {d N : ℕ} {c : Qbar} (hc : c ∈ F) (π : Fin N ≃ RootIndexPair d) (k : ℕ) :
    qbarMvSubst (pairShiftValues c π) (qbarElementarySymmetric N k) ∈
      subfieldCoefficientMvPolys F d := by
  -- 基本対称式の係数は F に入る。
  have hes := elementarySymmetric_mem_subfieldCoefficientMvPolys F N k
  -- T_a ∈ F[X_{<d}]。
  have hT : ∀ a ∈ (qbarElementarySymmetric N k).support,
      C (coeff a (qbarElementarySymmetric N k)) * ∏ r, pairShiftValues c π r ^ a r ∈
        subfieldCoefficientMvPolys F d := fun a _ =>
    mul_mem_subfieldCoefficientMvPolys F (C_mem_subfieldCoefficientMvPolys F (hes a))
      (prod_mem_subfieldCoefficientMvPolys F Finset.univ _ (fun r _ =>
        pow_mem_subfieldCoefficientMvPolys F
          (pairShiftValues_mem_subfieldCoefficientMvPolys F hc π r) (a r)))
  -- ms_y(es_{N,k}) = Σ_{a ∈ A} T_a ∈ F[X_{<d}]。
  have hexp : qbarMvSubst (pairShiftValues c π) (qbarElementarySymmetric N k) =
      ∑ a ∈ (qbarElementarySymmetric N k).support,
        C (coeff a (qbarElementarySymmetric N k)) * ∏ r, pairShiftValues c π r ^ a r := by
    rw [qbarMvSubst, aeval_def, eval₂_eq', algebraMap_eq]
  rw [hexp]
  exact sum_mem_subfieldCoefficientMvPolys F _ _ hT

end Ising2DLambda.FisherZero
