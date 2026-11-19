/-
節「対称式の基本定理」のうち、末尾に変数を足す持ち上げの具体版。

  人手証明                                                          このファイル
  定義 `def_last_variable_extension`                                `lastVariableExtension`
    制限 `a|_{<n}`（`def_exponent_zero_extension`）                 `exponentRestrictLast`
    同値「a(n) = 0 なら a = ez_n(a|_{<n})」                         `eq_exponentZeroExtension_of_last_eq_zero`
    係数の場合分けの式                                              `lastVariableExtension_coeff`
  主張 `claim_last_variable_zero_of_extension`                      `lastVariableZero_lastVariableExtension`
    準備（ez_n(b)|_{<n} = b）                                       `exponentRestrictLast_exponentZeroExtension`
  主張 `claim_last_variable_extension_subfield_coefficient`         `lastVariableExtension_mem_subfieldCoefficientMvPolys`
  主張 `claim_last_variable_extension_weighted_degree_bound`        `qbarWeightedDegree_lastVariableExtension_le`
    式鎖の六つの等号（wsz_{n+1}(a) = wsz_n(a|_{<n})）               `exponentWeightedTotal_of_last_eq_zero`
    式鎖の最後の不等号（最大元の性質）                              `exponentWeightedTotal_le_qbarWeightedDegree`

持ち上げは係数の場合分けの式で定める（`AddMonoidAlgebra.ofCoeff` と `Finsupp.ofSupportFinite`）。mathlib の `MvPolynomial.rename` は使わない。
係数が零でない指数が有限個であることは、定義の段落と同じく `{ez_n(b) | b ∈ spt_n(Q)}` に含まれることで示す。

住処: Qbar（次数は ℕ）。R / C は現れない。
-/
import Ising2DLambda.FisherZero.MonomialAndLastVariableZeroCoefficient
import Ising2DLambda.FisherZero.SymmetricVanishingDivisibleByProduct
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionDegreeBound

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_exponent_zero_extension` の制限 `a|_{<n}(k) = a(k)`（`k < n`）。 -/
noncomputable def exponentRestrictLast {n : ℕ} (a : Fin (n + 1) →₀ ℕ) : Fin n →₀ ℕ :=
  Finsupp.comapDomain Fin.castSucc a (Fin.castSucc_injective n).injOn

theorem exponentRestrictLast_apply {n : ℕ} (a : Fin (n + 1) →₀ ℕ) (k : Fin n) :
    exponentRestrictLast a k = a k.castSucc :=
  Finsupp.comapDomain_apply _ _ _ _

/-- `def_exponent_zero_extension` の同値の一方向。`a(n) = 0` なら `a = ez_n(a|_{<n})`。 -/
theorem eq_exponentZeroExtension_of_last_eq_zero {n : ℕ} (a : Fin (n + 1) →₀ ℕ)
    (ha : a (Fin.last n) = 0) : a = exponentZeroExtension (exponentRestrictLast a) := by
  ext j
  refine Fin.lastCases ?_ (fun k => ?_) j
  · rw [exponentZeroExtension_last, ha]
  · rw [exponentZeroExtension_castSucc, exponentRestrictLast_apply]

/-- `claim_last_variable_zero_of_extension` の準備。`ez_n(b)|_{<n} = b`。 -/
theorem exponentRestrictLast_exponentZeroExtension {n : ℕ} (b : Fin n →₀ ℕ) :
    exponentRestrictLast (exponentZeroExtension b) = b := by
  ext k
  rw [exponentRestrictLast_apply, exponentZeroExtension_castSucc]

/-- `def_last_variable_extension` の係数の場合分けの式（定める前の関数）。 -/
noncomputable def lastVariableExtensionCoeff {n : ℕ} (Q : QbarMvPoly n) (a : Fin (n + 1) →₀ ℕ) :
    Qbar :=
  if a (Fin.last n) = 0 then coeff (exponentRestrictLast a) Q else 0

/-- `def_last_variable_extension` の段落: 係数が零でない指数は `{ez_n(b) | b ∈ spt_n(Q)}` に属し、有限個である。 -/
theorem lastVariableExtensionCoeff_support_finite {n : ℕ} (Q : QbarMvPoly n) :
    (Function.support (lastVariableExtensionCoeff Q)).Finite := by
  apply ((Q.support : Set (Fin n →₀ ℕ)).toFinite.image exponentZeroExtension).subset
  intro a ha
  rw [Function.mem_support, lastVariableExtensionCoeff] at ha
  split_ifs at ha with hlast
  · exact ⟨exponentRestrictLast a, mem_support_iff.mpr ha,
      (eq_exponentZeroExtension_of_last_eq_zero a hlast).symm⟩
  · exact absurd rfl ha

/-- `def_last_variable_extension` の具体版。`ex_n(Q) ∈ Qbar[X_{<n+1}]`。 -/
noncomputable def lastVariableExtension {n : ℕ} (Q : QbarMvPoly n) : QbarMvPoly (n + 1) :=
  AddMonoidAlgebra.ofCoeff
    (Finsupp.ofSupportFinite (lastVariableExtensionCoeff Q) (lastVariableExtensionCoeff_support_finite Q))

/-- `def_last_variable_extension` の係数の式。 -/
theorem lastVariableExtension_coeff {n : ℕ} (Q : QbarMvPoly n) (a : Fin (n + 1) →₀ ℕ) :
    coeff a (lastVariableExtension Q) =
      if a (Fin.last n) = 0 then coeff (exponentRestrictLast a) Q else 0 :=
  rfl

/-- `claim_last_variable_zero_of_extension` の具体版。`lz_n(ex_n(Q)) = Q`。 -/
theorem lastVariableZero_lastVariableExtension {n : ℕ} (Q : QbarMvPoly n) :
    lastVariableZero n (lastVariableExtension Q) = Q := by
  ext b
  calc coeff b (lastVariableZero n (lastVariableExtension Q))
      -- 第一の等号: claim_last_variable_zero_coefficient。
      = coeff (exponentZeroExtension b) (lastVariableExtension Q) := lastVariableZero_coeff _ b
      -- 第二の等号: ez_n(b)(n) = 0 と def_last_variable_extension。
    _ = coeff (exponentRestrictLast (exponentZeroExtension b)) Q := by
        rw [lastVariableExtension_coeff, if_pos (exponentZeroExtension_last b)]
      -- 第三の等号: ez_n(b)|_{<n} = b。
    _ = coeff b Q := by rw [exponentRestrictLast_exponentZeroExtension]

/-- `claim_last_variable_extension_subfield_coefficient` の具体版。`Q ∈ F[X_{<n}]` なら `ex_n(Q) ∈ F[X_{<n+1}]`。 -/
theorem lastVariableExtension_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ}
    (Q : QbarMvPoly n) (hQ : Q ∈ subfieldCoefficientMvPolys F n) :
    lastVariableExtension Q ∈ subfieldCoefficientMvPolys F (n + 1) := by
  intro a
  by_cases hlast : a (Fin.last n) = 0
  · -- a(n) = 0 のとき: mco_a(ex_n(Q)) = mco_{a|<n}(Q) ∈ F。
    rw [lastVariableExtension_coeff, if_pos hlast]
    exact hQ (exponentRestrictLast a)
  · -- a(n) ≠ 0 のとき: mco_a(ex_n(Q)) = 0 ∈ F（部分体は零元を含む）。
    rw [lastVariableExtension_coeff, if_neg hlast]
    exact F.zero_mem

/-- `claim_last_variable_extension_weighted_degree_bound` の式鎖の等号の部分。
`a(n) = 0` なら `wsz_{n+1}(a) = wsz_n(a|_{<n})`。 -/
theorem exponentWeightedTotal_of_last_eq_zero {n : ℕ} (a : Fin (n + 1) →₀ ℕ)
    (ha : a (Fin.last n) = 0) :
    exponentWeightedTotal a = exponentWeightedTotal (exponentRestrictLast a) := by
  calc exponentWeightedTotal a
      -- 第一の等号: wsz_{n+1} の定義。
      = ∑ k : Fin (n + 1), (k.val + 1) * a k := rfl
      -- 第二の等号: 有限和の末項の分離。
    _ = ∑ k : Fin n, ((k.castSucc : Fin (n + 1)).val + 1) * a k.castSucc
          + ((Fin.last n).val + 1) * a (Fin.last n) := Fin.sum_univ_castSucc _
      -- 第三の等号: a(n) = 0。
    _ = ∑ k : Fin n, ((k.castSucc : Fin (n + 1)).val + 1) * a k.castSucc
          + ((Fin.last n).val + 1) * 0 := by rw [ha]
      -- 第四の等号: ℕ で零との積は零、零は加法の単位元。
    _ = ∑ k : Fin n, ((k.castSucc : Fin (n + 1)).val + 1) * a k.castSucc := by
        rw [mul_zero, add_zero]
      -- 第五の等号: 制限 a|_{<n}(k) = a(k)（castSucc は値を変えない）。
    _ = ∑ k : Fin n, (k.val + 1) * exponentRestrictLast a k :=
        Finset.sum_congr rfl fun k _ => by rw [exponentRestrictLast_apply, Fin.val_castSucc]
      -- 第六の等号: wsz_n の定義。
    _ = exponentWeightedTotal (exponentRestrictLast a) := rfl

/-- `claim_last_variable_extension_weighted_degree_bound` の具体版。`wdeg_{n+1}(ex_n(Q)) ≤ wdeg_n(Q)`。 -/
theorem qbarWeightedDegree_lastVariableExtension_le {n : ℕ} (Q : QbarMvPoly n) :
    qbarWeightedDegree (lastVariableExtension Q) ≤ qbarWeightedDegree Q := by
  -- 最大元は、全ての元が wdeg_n(Q) 以下なら wdeg_n(Q) 以下（def_qbar_multivariate_weighted_degree）。
  apply Finset.sup_le
  intro a ha
  have hne : coeff a (lastVariableExtension Q) ≠ 0 := mem_support_iff.mp ha
  -- a(n) ≠ 0 なら係数は 0 で台に反する。
  have hlast : a (Fin.last n) = 0 := by
    by_contra h
    rw [lastVariableExtension_coeff, if_neg h] at hne
    exact hne rfl
  -- 準備: mco_{a|<n}(Q) = mco_a(ex_n(Q)) ≠ 0。
  have hsupp : coeff (exponentRestrictLast a) Q ≠ 0 := by
    rw [lastVariableExtension_coeff, if_pos hlast] at hne
    exact hne
  calc exponentWeightedTotal a
      = exponentWeightedTotal (exponentRestrictLast a) :=
        exponentWeightedTotal_of_last_eq_zero a hlast
    _ ≤ qbarWeightedDegree Q := exponentWeightedTotal_le_qbarWeightedDegree Q _ hsupp

end Ising2DLambda.FisherZero
