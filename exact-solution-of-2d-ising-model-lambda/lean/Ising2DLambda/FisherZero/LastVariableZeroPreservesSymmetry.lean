/-
節「対称式の基本定理」のうち、末尾の変数への零代入が対称性を保つことの具体版。

  人手証明                                                         このファイル
  定義 `def_last_fixed_permutation_extension`                      `lastFixedExtensionFun`
                                                                   `lastFixedExtensionFun_castSucc`
                                                                   `lastFixedExtensionFun_last`
  主張 `claim_last_fixed_permutation_extension_is_bijection`       `lastFixedExtensionFun_inverse`
                                                                   `lastFixedExtension`
    k < n の場合の式鎖                                             `lastFixedExtensionFun_inverse` の castSucc の場合
    末尾 n の場合の式鎖                                            `lastFixedExtensionFun_inverse` の last の場合
  主張 `claim_last_variable_zero_commutes_with_variable_permutation`
                                                                   `variablePermutation_lastVariableZero`
    準備（ms_{xv_{n,ϱ}} ∘ z_n = ms_{z_n} ∘ xv_{n+1,pe_n(ϱ)}）     `variablePermutationValues_comp_lastVariableZeroValues`
    式鎖の第三・第五の等号（代入の合成）                           `qbarMvSubst_comp`
  主張 `claim_last_variable_zero_preserves_symmetry`               `lastVariableZero_isQbarSymmetric`

本文の場合分け `k < n`・`k = n` は `Fin.lastCases` の二つの場合（`Fin.castSucc k`・`Fin.last n`）で書く。

住処: Qbar（添字は有限集合）。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionLastVariableZero
import Ising2DLambda.FisherZero.VariablePermutationCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_last_fixed_permutation_extension` の具体版。`k < n` なら `pe_n(ϱ)(k) = ϱ(k)`、`pe_n(ϱ)(n) = n`。 -/
def lastFixedExtensionFun (n : ℕ) (f : Fin n → Fin n) : Fin (n + 1) → Fin (n + 1) :=
  Fin.lastCases (Fin.last n) (fun k => (f k).castSucc)

/-- `def_last_fixed_permutation_extension` の第一の値: `k < n` なら `pe_n(ϱ)(k) = ϱ(k)`。 -/
theorem lastFixedExtensionFun_castSucc (n : ℕ) (f : Fin n → Fin n) (k : Fin n) :
    lastFixedExtensionFun n f k.castSucc = (f k).castSucc := by
  rw [lastFixedExtensionFun, Fin.lastCases_castSucc]

/-- `def_last_fixed_permutation_extension` の第二の値: `pe_n(ϱ)(n) = n`。 -/
theorem lastFixedExtensionFun_last (n : ℕ) (f : Fin n → Fin n) :
    lastFixedExtensionFun n f (Fin.last n) = Fin.last n := by
  rw [lastFixedExtensionFun, Fin.lastCases_last]

/-- `claim_last_fixed_permutation_extension_is_bijection` の具体版の本体。
`ϱ' ∘ ϱ = id` なら `pe_n(ϱ') ∘ pe_n(ϱ) = id`。 -/
theorem lastFixedExtensionFun_inverse (n : ℕ) (f g : Fin n → Fin n) (hgf : ∀ k, g (f k) = k)
    (j : Fin (n + 1)) : lastFixedExtensionFun n g (lastFixedExtensionFun n f j) = j := by
  refine Fin.lastCases ?_ (fun k => ?_) j
  · -- 末尾 n の場合。
    calc lastFixedExtensionFun n g (lastFixedExtensionFun n f (Fin.last n))
        = lastFixedExtensionFun n g (Fin.last n) := by rw [lastFixedExtensionFun_last]
      _ = Fin.last n := lastFixedExtensionFun_last n g
  · -- k < n の場合。
    calc lastFixedExtensionFun n g (lastFixedExtensionFun n f k.castSucc)
        = lastFixedExtensionFun n g (f k).castSucc := by rw [lastFixedExtensionFun_castSucc]
      _ = (g (f k)).castSucc := lastFixedExtensionFun_castSucc n g (f k)
      _ = k.castSucc := by rw [hgf k]

/-- `claim_last_fixed_permutation_extension_is_bijection` の具体版。
`pe_n(ϱ) ∈ 𝔓_{n+1}` で、逆写像は `pe_n(ϱ^{-1})`。 -/
def lastFixedExtension (n : ℕ) (ϱ : Equiv.Perm (Fin n)) : Equiv.Perm (Fin (n + 1)) where
  toFun := lastFixedExtensionFun n ϱ
  invFun := lastFixedExtensionFun n ϱ.symm
  left_inv := lastFixedExtensionFun_inverse n ϱ ϱ.symm (fun k => ϱ.symm_apply_apply k)
  right_inv := lastFixedExtensionFun_inverse n ϱ.symm ϱ (fun k => ϱ.apply_symm_apply k)

/-- `claim_last_variable_zero_commutes_with_variable_permutation` の準備。
`ms_{xv_{n,ϱ}} ∘ z_n = ms_{z_n} ∘ xv_{n+1,pe_n(ϱ)}`（値ごと）。 -/
theorem variablePermutationValues_comp_lastVariableZeroValues (n : ℕ) (ϱ : Equiv.Perm (Fin n))
    (j : Fin (n + 1)) :
    qbarMvSubst (variablePermutationValues n ϱ) (lastVariableZeroValues n j) =
      qbarMvSubst (lastVariableZeroValues n)
        (variablePermutationValues (n + 1) (lastFixedExtension n ϱ) j) := by
  refine Fin.lastCases ?_ (fun k => ?_) j
  · -- j = n の場合。
    calc qbarMvSubst (variablePermutationValues n ϱ) (lastVariableZeroValues n (Fin.last n))
        = qbarMvSubst (variablePermutationValues n ϱ) 0 := by
          rw [lastVariableZeroValues, Fin.lastCases_last]
      _ = 0 := map_zero _
      _ = lastVariableZeroValues n (Fin.last n) := by
          rw [lastVariableZeroValues, Fin.lastCases_last]
      _ = qbarMvSubst (lastVariableZeroValues n) (X (Fin.last n)) := (aeval_X _ _).symm
      _ = qbarMvSubst (lastVariableZeroValues n) (X (lastFixedExtension n ϱ (Fin.last n))) := by
          rw [show lastFixedExtension n ϱ (Fin.last n) = Fin.last n from
            lastFixedExtensionFun_last n ϱ]
      _ = qbarMvSubst (lastVariableZeroValues n)
            (variablePermutationValues (n + 1) (lastFixedExtension n ϱ) (Fin.last n)) := rfl
  · -- j < n の場合（j = castSucc k）。
    calc qbarMvSubst (variablePermutationValues n ϱ) (lastVariableZeroValues n k.castSucc)
        = qbarMvSubst (variablePermutationValues n ϱ) (X k) := by
          rw [lastVariableZeroValues, Fin.lastCases_castSucc]
      _ = variablePermutationValues n ϱ k := aeval_X _ k
      _ = X (ϱ k) := rfl
      _ = lastVariableZeroValues n (ϱ k).castSucc := by
          rw [lastVariableZeroValues, Fin.lastCases_castSucc]
      _ = qbarMvSubst (lastVariableZeroValues n) (X (ϱ k).castSucc) := (aeval_X _ _).symm
      _ = qbarMvSubst (lastVariableZeroValues n) (X (lastFixedExtension n ϱ k.castSucc)) := by
          rw [show lastFixedExtension n ϱ k.castSucc = (ϱ k).castSucc from
            lastFixedExtensionFun_castSucc n ϱ k]
      _ = qbarMvSubst (lastVariableZeroValues n)
            (variablePermutationValues (n + 1) (lastFixedExtension n ϱ) k.castSucc) := rfl

/-- `claim_last_variable_zero_commutes_with_variable_permutation` の具体版。
`vs_ϱ(lz_n(P)) = lz_n(vs_{pe_n(ϱ)}(P))`。 -/
theorem variablePermutation_lastVariableZero {n : ℕ} (ϱ : Equiv.Perm (Fin n))
    (P : QbarMvPoly (n + 1)) :
    variablePermutation n ϱ (lastVariableZero n P) =
      lastVariableZero n (variablePermutation (n + 1) (lastFixedExtension n ϱ) P) := by
  calc variablePermutation n ϱ (lastVariableZero n P)
      = qbarMvSubst (variablePermutationValues n ϱ) (lastVariableZero n P) := rfl
    _ = qbarMvSubst (variablePermutationValues n ϱ)
          (qbarMvSubst (lastVariableZeroValues n) P) := rfl
    _ = qbarMvSubst (fun j => qbarMvSubst (variablePermutationValues n ϱ)
          (lastVariableZeroValues n j)) P := qbarMvSubst_comp _ _ P
    _ = qbarMvSubst (fun j => qbarMvSubst (lastVariableZeroValues n)
          (variablePermutationValues (n + 1) (lastFixedExtension n ϱ) j)) P := by
        rw [show (fun j => qbarMvSubst (variablePermutationValues n ϱ)
            (lastVariableZeroValues n j)) = (fun j => qbarMvSubst (lastVariableZeroValues n)
            (variablePermutationValues (n + 1) (lastFixedExtension n ϱ) j)) from
          funext (variablePermutationValues_comp_lastVariableZeroValues n ϱ)]
    _ = qbarMvSubst (lastVariableZeroValues n)
          (qbarMvSubst (variablePermutationValues (n + 1) (lastFixedExtension n ϱ)) P) :=
        (qbarMvSubst_comp _ _ P).symm
    _ = qbarMvSubst (lastVariableZeroValues n)
          (variablePermutation (n + 1) (lastFixedExtension n ϱ) P) := rfl
    _ = lastVariableZero n (variablePermutation (n + 1) (lastFixedExtension n ϱ) P) := rfl

/-- `claim_last_variable_zero_preserves_symmetry` の具体版。対称な `P` の `lz_n(P)` は対称。 -/
theorem lastVariableZero_isQbarSymmetric {n : ℕ} (P : QbarMvPoly (n + 1))
    (hP : IsQbarSymmetric P) : IsQbarSymmetric (lastVariableZero n P) := by
  intro ϱ
  calc variablePermutation n ϱ (lastVariableZero n P)
      = lastVariableZero n (variablePermutation (n + 1) (lastFixedExtension n ϱ) P) :=
        variablePermutation_lastVariableZero ϱ P
    _ = lastVariableZero n P := by rw [hP (lastFixedExtension n ϱ)]

end Ising2DLambda.FisherZero
