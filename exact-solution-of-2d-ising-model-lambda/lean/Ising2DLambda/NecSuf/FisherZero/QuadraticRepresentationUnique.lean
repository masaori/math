/-
「二次体の表示の一意性」の論理的な手順だけを残した必要十分版。
係数側と値側に零元・加法・負号だけを置き、計算鎖で使う法則を個別に要求する。
値側の右乗法は、固定した根に掛ける一つの写像として表す。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 係数側の四法則は差が零であることから係数を復元する二本の鎖に使う。
値側の四法則と二つの写像の保存則は、差の表示を零へ運ぶ鎖に使う。
係数側の可換性・値側の右零元・係数写像の零元保存・乗法構造は要求しない。
一次独立性は零表示の係数を消去する箇所でだけ適用する。 -/
theorem quadratic_representation_unique_necSuf
    {A K : Type*} [Zero A] [Add A] [Neg A] [Zero K] [Add K] [Neg K]
    (hAAddZero : ∀ x : A, x + 0 = x)
    (hANegAdd : ∀ x : A, -x + x = 0)
    (hAAddAssoc : ∀ x y z : A, (x + y) + z = x + (y + z))
    (hAZeroAdd : ∀ x : A, 0 + x = x)
    (hKAddAssoc : ∀ x y z : K, (x + y) + z = x + (y + z))
    (hKAddComm : ∀ x y : K, x + y = y + x)
    (hKAddNeg : ∀ x : K, x + -x = 0)
    (hKZeroAdd : ∀ x : K, 0 + x = x)
    (embed : A → K)
    (hEmbedAdd : ∀ x y : A, embed (x + y) = embed x + embed y)
    (hEmbedNeg : ∀ x : A, embed (-x) = -embed x)
    (rightMul : K → K)
    (hRightMulAdd : ∀ x y : K, rightMul (x + y) = rightMul x + rightMul y)
    (hRightMulZero : rightMul 0 = 0)
    (hIndependent : ∀ α β : A, embed α + rightMul (embed β) = 0 → α = 0 ∧ β = 0)
    (a b a' b' : A)
    (hab : embed a + rightMul (embed b) = embed a' + rightMul (embed b')) :
    a = a' ∧ b = b' := by
  let α : A := a + (-a')
  let β : A := b + (-b')
  have hzero : embed α + rightMul (embed β) = 0 := by
    calc
      embed α + rightMul (embed β) =
          embed (a + (-a')) + rightMul (embed (b + (-b'))) := by rfl
      _ = (embed a + embed (-a')) + rightMul (embed b + embed (-b')) := by
            rw [hEmbedAdd, hEmbedAdd]
      _ =
          (embed a + (-embed a')) + rightMul (embed b + (-embed b')) := by
            rw [hEmbedNeg, hEmbedNeg]
      _ = (embed a + (-embed a')) + (rightMul (embed b) + rightMul (-embed b')) := by
            rw [hRightMulAdd]
      _ = embed a + ((-embed a') + (rightMul (embed b) + rightMul (-embed b'))) := by
            rw [hKAddAssoc]
      _ = embed a + ((rightMul (embed b) + rightMul (-embed b')) + (-embed a')) := by
            rw [hKAddComm (-embed a')]
      _ = embed a + (rightMul (embed b) + (rightMul (-embed b') + (-embed a'))) := by
            rw [hKAddAssoc]
      _ = (embed a + rightMul (embed b)) + (rightMul (-embed b') + (-embed a')) := by
            rw [hKAddAssoc]
      _ = (embed a' + rightMul (embed b')) + (rightMul (-embed b') + (-embed a')) := by
            rw [hab]
      _ = embed a' + (rightMul (embed b') + (rightMul (-embed b') + (-embed a'))) := by
            rw [hKAddAssoc]
      _ = embed a' + ((rightMul (embed b') + rightMul (-embed b')) + (-embed a')) := by
            rw [hKAddAssoc]
      _ = embed a' + (rightMul (embed b' + (-embed b')) + (-embed a')) := by
            rw [hRightMulAdd]
      _ = embed a' + (rightMul 0 + (-embed a')) := by rw [hKAddNeg]
      _ = embed a' + (0 + (-embed a')) := by rw [hRightMulZero]
      _ = embed a' + (-embed a') := by rw [hKZeroAdd]
      _ = 0 := by rw [hKAddNeg]
  have hcoeff : α = 0 ∧ β = 0 := hIndependent α β hzero
  constructor
  · calc
      a = a + 0 := by rw [hAAddZero]
      _ = a + ((-a') + a') := by rw [hANegAdd]
      _ = (a + (-a')) + a' := by rw [hAAddAssoc]
      _ = α + a' := by rfl
      _ = 0 + a' := by rw [hcoeff.1]
      _ = a' := by rw [hAZeroAdd]
  · calc
      b = b + 0 := by rw [hAAddZero]
      _ = b + ((-b') + b') := by rw [hANegAdd]
      _ = (b + (-b')) + b' := by rw [hAAddAssoc]
      _ = β + b' := by rfl
      _ = 0 + b' := by rw [hcoeff.2]
      _ = b' := by rw [hAZeroAdd]

end Ising2DLambda.NecSuf.FisherZero
