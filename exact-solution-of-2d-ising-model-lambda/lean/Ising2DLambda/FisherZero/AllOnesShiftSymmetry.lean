/-
節「指数を一つ下げた多項式の対称性」の具体版。

  人手証明                                                  このファイル
  主張 `claim_qbar_all_ones_shift_preserves_symmetry`       `allOnesShift_isQbarSymmetric`
    準備（(d + 1_n) ∘ ϱ = d ∘ ϱ + 1_n。六つの等号）         `exponentComp_add_allOnes`
    第一の等号（変数を置換した多項式の係数）                `variablePermutation_coeff`
    第二の等号（指数を一つ下げた多項式の係数）              `allOnesShift_coeff`
    第三の等号（準備）                                      `exponentComp_add_allOnes`
    第四の等号（変数を置換した多項式の係数）                `variablePermutation_coeff`
    第五の等号（P は対称）                                  `IsQbarSymmetric`
    第六の等号（指数を一つ下げた多項式の係数）              `allOnesShift_coeff`

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SymmetricVanishingShiftedQuotient

namespace Ising2DLambda.FisherZero

open MvPolynomial

/-- `claim_qbar_all_ones_shift_preserves_symmetry` の準備。`(d + 1_n) ∘ ϱ = d ∘ ϱ + 1_n`。 -/
theorem exponentComp_add_allOnes {n : ℕ} (d : Fin n →₀ ℕ) (ϱ : Equiv.Perm (Fin n)) :
    exponentComp (d + allOnesExponent n) ϱ = exponentComp d ϱ + allOnesExponent n := by
  ext k
  calc exponentComp (d + allOnesExponent n) ϱ k
      -- 第一の等号: 指数の合成。
      = (d + allOnesExponent n) (ϱ k) := exponentComp_apply _ ϱ k
      -- 第二の等号: 指数の和。
    _ = d (ϱ k) + allOnesExponent n (ϱ k) := Finsupp.add_apply _ _ _
      -- 第三の等号: 1_n(ϱ(k)) = 1。
    _ = d (ϱ k) + 1 := by rw [allOnesExponent_apply]
      -- 第四の等号: 指数の合成。
    _ = exponentComp d ϱ k + 1 := by rw [exponentComp_apply]
      -- 第五の等号: 1_n(k) = 1。
    _ = exponentComp d ϱ k + allOnesExponent n k := by rw [allOnesExponent_apply]
      -- 第六の等号: 指数の和。
    _ = (exponentComp d ϱ + allOnesExponent n) k := (Finsupp.add_apply _ _ _).symm

/-- `claim_qbar_all_ones_shift_preserves_symmetry` の具体版。対称な `P` の `sd_n(P)` は対称。 -/
theorem allOnesShift_isQbarSymmetric {n : ℕ} (P : QbarMvPoly n) (hsym : IsQbarSymmetric P) :
    IsQbarSymmetric (allOnesShift P) := by
  intro ϱ
  ext d
  calc coeff d (variablePermutation n ϱ (allOnesShift P))
      -- 第一の等号: 変数を置換した多項式の係数。
      = coeff (exponentComp d ϱ) (allOnesShift P) := variablePermutation_coeff ϱ _ d
      -- 第二の等号: 指数を一つ下げた多項式の係数。
    _ = coeff (exponentComp d ϱ + allOnesExponent n) P := allOnesShift_coeff _ _
      -- 第三の等号: 準備。
    _ = coeff (exponentComp (d + allOnesExponent n) ϱ) P := by rw [exponentComp_add_allOnes]
      -- 第四の等号: 変数を置換した多項式の係数。
    _ = coeff (d + allOnesExponent n) (variablePermutation n ϱ P) :=
        (variablePermutation_coeff ϱ P _).symm
      -- 第五の等号: P は対称。
    _ = coeff (d + allOnesExponent n) P := by rw [hsym ϱ]
      -- 第六の等号: 指数を一つ下げた多項式の係数。
    _ = coeff d (allOnesShift P) := (allOnesShift_coeff P d).symm

end Ising2DLambda.FisherZero
