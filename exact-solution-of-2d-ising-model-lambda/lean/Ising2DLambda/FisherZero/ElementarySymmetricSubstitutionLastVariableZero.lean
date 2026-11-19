/-
節「基本対称式への代入」の具体版（末尾の変数への零代入との入れ替えの部分）。

  人手証明                                                       このファイル
  主張 `claim_elementary_symmetric_substitution_last_variable_zero`  `lastVariableZero_elementarySymmetricSubst`
    準備（ms_{z_n} ∘ ee_{n+1} = ms_{ee_n} ∘ z_n）                 `lastVariableZero_comp_elementarySymmetricValues`
      j < n の第四の等号（lz_n(es_{n+1,j+1}) = es_{n,j+1}）       `lastVariableZero_elementarySymmetric`
      j < n の第六の等号（ms_y(X_k) = y(k)）                       `MvPolynomial.aeval_X`
      j = n の第五の等号（es_{n,n+1} = 0）                         `elementarySymmetric_eq_zero_of_lt`
      j = n の第六の等号（ms_y(0) = 0）                            `map_zero`
    第三・第五の等号（代入の合成）                               `qbarMvSubst_comp`
    定義の展開の等号（ee・lz・se の定義を一行に一つ）              `rfl`

本文の場合分け `j < n`・`j = n` は `Fin.lastCases` の二つの場合（`Fin.castSucc k`・`Fin.last n`）で書く。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ElementarySymmetricLastVariableZero
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionSymmetric

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_qbar_elementary_symmetric_polynomial` の注記: `j > n` なら `es_{n,j} = 0`。 -/
theorem elementarySymmetric_eq_zero_of_lt {n j : ℕ} (h : n < j) :
    qbarElementarySymmetric n j = 0 := by
  unfold qbarElementarySymmetric
  rw [Finset.powersetCard_eq_empty.mpr (by rw [Finset.card_univ, Fintype.card_fin]; exact h)]
  rfl

/-- `claim_elementary_symmetric_substitution_last_variable_zero` の準備。
`ms_{z_n} ∘ ee_{n+1} = ms_{ee_n} ∘ z_n`。 -/
theorem lastVariableZero_comp_elementarySymmetricValues (n : ℕ) :
    (fun j => qbarMvSubst (lastVariableZeroValues n) (elementarySymmetricValues (n + 1) j)) =
      (fun j => qbarMvSubst (elementarySymmetricValues n) (lastVariableZeroValues n j)) := by
  funext j
  refine Fin.lastCases ?_ (fun k => ?_) j
  · -- j = n の場合。
    calc qbarMvSubst (lastVariableZeroValues n) (elementarySymmetricValues (n + 1) (Fin.last n))
        = qbarMvSubst (lastVariableZeroValues n) (qbarElementarySymmetric (n + 1) (n + 1)) := rfl
      _ = lastVariableZero n (qbarElementarySymmetric (n + 1) (n + 1)) := rfl
      _ = qbarElementarySymmetric n (n + 1) := lastVariableZero_elementarySymmetric n (n + 1)
      _ = 0 := elementarySymmetric_eq_zero_of_lt (Nat.lt_succ_self n)
      _ = qbarMvSubst (elementarySymmetricValues n) 0 := (map_zero _).symm
      _ = qbarMvSubst (elementarySymmetricValues n) (lastVariableZeroValues n (Fin.last n)) := by
          rw [lastVariableZeroValues, Fin.lastCases_last]
  · -- j < n の場合（j = castSucc k）。
    calc qbarMvSubst (lastVariableZeroValues n) (elementarySymmetricValues (n + 1) k.castSucc)
        = qbarMvSubst (lastVariableZeroValues n) (qbarElementarySymmetric (n + 1) (k.val + 1)) := rfl
      _ = lastVariableZero n (qbarElementarySymmetric (n + 1) (k.val + 1)) := rfl
      _ = qbarElementarySymmetric n (k.val + 1) := lastVariableZero_elementarySymmetric n (k.val + 1)
      _ = elementarySymmetricValues n k := rfl
      _ = qbarMvSubst (elementarySymmetricValues n) (X k) := (aeval_X _ k).symm
      _ = qbarMvSubst (elementarySymmetricValues n) (lastVariableZeroValues n k.castSucc) := by
          rw [lastVariableZeroValues, Fin.lastCases_castSucc]

/-- `claim_elementary_symmetric_substitution_last_variable_zero` の具体版。
`lz_n(se_{n+1}(Q)) = se_n(lz_n(Q))`。 -/
theorem lastVariableZero_elementarySymmetricSubst {n : ℕ} (Q : QbarMvPoly (n + 1)) :
    lastVariableZero n (elementarySymmetricSubst (n + 1) Q) =
      elementarySymmetricSubst n (lastVariableZero n Q) := by
  calc lastVariableZero n (elementarySymmetricSubst (n + 1) Q)
      = lastVariableZero n (qbarMvSubst (elementarySymmetricValues (n + 1)) Q) := rfl
    _ = qbarMvSubst (lastVariableZeroValues n)
          (qbarMvSubst (elementarySymmetricValues (n + 1)) Q) := rfl
    _ = qbarMvSubst (fun j => qbarMvSubst (lastVariableZeroValues n)
          (elementarySymmetricValues (n + 1) j)) Q := qbarMvSubst_comp _ _ Q
    _ = qbarMvSubst (fun j => qbarMvSubst (elementarySymmetricValues n)
          (lastVariableZeroValues n j)) Q := by
        rw [lastVariableZero_comp_elementarySymmetricValues]
    _ = qbarMvSubst (elementarySymmetricValues n) (qbarMvSubst (lastVariableZeroValues n) Q) :=
        (qbarMvSubst_comp _ _ Q).symm
    _ = qbarMvSubst (elementarySymmetricValues n) (lastVariableZero n Q) := rfl
    _ = elementarySymmetricSubst n (lastVariableZero n Q) := rfl

end Ising2DLambda.FisherZero
