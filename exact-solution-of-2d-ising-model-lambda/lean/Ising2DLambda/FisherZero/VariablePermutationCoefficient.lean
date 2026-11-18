/-
節「変数の置換と対称多項式」の具体版。

  人手証明                                                  このファイル
  定義 `def_qbar_variable_permutation`                      `variablePermutationValues`・`variablePermutation`・`exponentComp`
  定義 `def_qbar_symmetric_polynomial`                      `IsQbarSymmetric`
  主張 `claim_qbar_variable_permutation_coefficient`        `variablePermutation_coeff`
    準備の一つ目（項の積を ϱ で添字を付け替えて単項式に書く） `variablePermutation_term`
    準備の二つ目（定数と単項式の積の係数）                   `qbarConst_mul_monomial_coeff`
    第一の等号（代入の定義）                                `MvPolynomial.aeval_eq_eval₂Hom`・`MvPolynomial.eval₂_eq'`
    第二の等号（準備の一つ目）                              `variablePermutation_term`
    第三の等号（和の係数）                                  `MvPolynomial.coeff_sum`
    第四・第五の等号（係数が残る指数は a ∘ ϱ だけ）          `qbarConst_mul_monomial_coeff`・`Finset.sum_eq_single`

本文の全単射の全体 `𝔓_n` は `Equiv.Perm (Fin n)`。本文の指数の合成 `a ∘ ϱ`（`(a ∘ ϱ)(k) = a(ϱ(k))`）は
`Finsupp.equivMapDomain ϱ.symm a` で書く（`exponentComp_apply` が各点の値を確かめる）。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.MonomialAndLastVariableZeroCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_qbar_variable_permutation` の代入する値。`xv_{n,ϱ}(k) = X^{(n)}_{ϱ(k)}`。 -/
noncomputable def variablePermutationValues (n : ℕ) (ϱ : Equiv.Perm (Fin n)) :
    Fin n → QbarMvPoly n :=
  fun k => X (ϱ k)

/-- `def_qbar_variable_permutation` の具体版 `vs_ϱ = ms_{xv_{n,ϱ}}`。 -/
noncomputable def variablePermutation (n : ℕ) (ϱ : Equiv.Perm (Fin n)) :
    QbarMvPoly n →ₐ[Qbar] QbarMvPoly n :=
  qbarMvSubst (variablePermutationValues n ϱ)

/-- `def_qbar_variable_permutation` の指数の合成 `a ∘ ϱ`。 -/
noncomputable def exponentComp {n : ℕ} (a : Fin n →₀ ℕ) (ϱ : Equiv.Perm (Fin n)) : Fin n →₀ ℕ :=
  Finsupp.equivMapDomain ϱ.symm a

theorem exponentComp_apply {n : ℕ} (a : Fin n →₀ ℕ) (ϱ : Equiv.Perm (Fin n)) (k : Fin n) :
    exponentComp a ϱ k = a (ϱ k) := by
  simp [exponentComp, Finsupp.equivMapDomain_apply]

/-- `def_qbar_symmetric_polynomial` の具体版。任意の `ϱ ∈ 𝔓_n` について `vs_ϱ(P) = P`。 -/
def IsQbarSymmetric {n : ℕ} (P : QbarMvPoly n) : Prop :=
  ∀ ϱ : Equiv.Perm (Fin n), variablePermutation n ϱ P = P

/-- `claim_qbar_variable_permutation_coefficient` の準備の一つ目。
`∏_k (X^{(n)}_{ϱ(k)})^{b(k)} = ∏_j (X^{(n)}_j)^{b(ϱ^{-1}(j))} = mon_n(b ∘ ϱ^{-1})`。
有限積の添字を全単射 `ϱ` で付け替える。 -/
theorem variablePermutation_term {n : ℕ} (ϱ : Equiv.Perm (Fin n)) (b : Fin n →₀ ℕ) :
    ∏ k, variablePermutationValues n ϱ k ^ b k = qbarMonomial n (exponentComp b ϱ.symm) := by
  unfold qbarMonomial variablePermutationValues
  rw [← Equiv.prod_comp ϱ (fun j => X j ^ (exponentComp b ϱ.symm) j)]
  refine Finset.prod_congr rfl (fun k _ => ?_)
  rw [exponentComp_apply, Equiv.symm_apply_apply]

/-- `claim_qbar_variable_permutation_coefficient` の準備の二つ目。
`mco_a(mk_n(d) · mon_n(e))` は `e = a` なら `d`、そうでなければ `0`。 -/
theorem qbarConst_mul_monomial_coeff {n : ℕ} (d : Qbar) (e a : Fin n →₀ ℕ) :
    coeff a (C d * qbarMonomial n e) = if e = a then d else 0 := by
  classical
  -- 積の可換性。
  rw [mul_comm]
  -- 単項式を掛けた係数（claim_qbar_monomial_multiplication_coefficient）。
  rw [qbarMonomial_mul_coeff]
  -- 定数の係数は零写像で d、他で 0。e ≤ a のもとで a - e = 0 ↔ e = a。
  split_ifs with hle heq heq
  · rw [coeff_C, if_pos]
    rw [heq, tsub_self]
  · rw [coeff_C, if_neg]
    intro h0
    exact heq (le_antisymm hle (tsub_eq_zero_iff_le.mp h0.symm))
  · exact absurd (heq ▸ le_refl a) hle
  · rfl

/-- `claim_qbar_variable_permutation_coefficient` の具体版。`mco_a(vs_ϱ(P)) = mco_{a ∘ ϱ}(P)`。 -/
theorem variablePermutation_coeff {n : ℕ} (ϱ : Equiv.Perm (Fin n)) (P : QbarMvPoly n)
    (a : Fin n →₀ ℕ) :
    coeff a (variablePermutation n ϱ P) = coeff (exponentComp a ϱ) P := by
  classical
  -- 第一の等号: 代入の定義。
  rw [variablePermutation, qbarMvSubst, aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']
  -- 第二の等号: 各項の積を単項式 mon_n(b ∘ ϱ^{-1}) に書く。
  simp_rw [variablePermutation_term]
  -- 第三の等号: 和の係数は係数の和。
  rw [coeff_sum]
  -- 第四の等号: 各項の係数は、b ∘ ϱ^{-1} = a のときだけ mco_b(P)。
  simp_rw [MvPolynomial.algebraMap_eq, qbarConst_mul_monomial_coeff]
  -- 第五の等号: b ∘ ϱ^{-1} = a と b = a ∘ ϱ は同値。
  have hiff : ∀ b : Fin n →₀ ℕ, exponentComp b ϱ.symm = a ↔ b = exponentComp a ϱ := by
    intro b
    constructor
    · intro h
      ext k
      rw [exponentComp_apply, ← h, exponentComp_apply, Equiv.symm_apply_apply]
    · intro h
      ext j
      rw [exponentComp_apply, h, exponentComp_apply, Equiv.apply_symm_apply]
  rw [Finset.sum_eq_single (exponentComp a ϱ)]
  · rw [if_pos ((hiff _).mpr rfl)]
  · intro b _ hne
    rw [if_neg]
    intro h
    exact hne ((hiff b).mp h)
  · intro hnot
    rw [if_pos ((hiff _).mpr rfl)]
    by_contra hcoeff
    exact hnot (mem_support_iff.mpr hcoeff)

end Ising2DLambda.FisherZero
