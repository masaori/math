/-
「二次体の台集合の乗法による閉性」と「二次体の積の表示」の必要十分版。
閉性の計算は必要な演算則と写像保存を明示する。表示写像の結論は表示の一意性を使う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem mul_mem_necSuf
    {A K : Type} (mulK : K → K → K) (combine : A → A → K)
    (a b a' b' c d : A)
    (hmul : mulK (combine a b) (combine a' b') = combine c d) :
    ∃ u v : A, mulK (combine a b) (combine a' b') = combine u v := by
  exact ⟨c, d, hmul⟩

/-- 閉性に使う計算の必要十分版。
源の側は二つの演算と係数 q、像の側は結合・可換・左右分配則、写像は和と積の保存だけを使う。
逆元、零元、単位元、順序、単射性、平方根の一意性は計算に使わない。
-/
theorem quadratic_mul_value_necSuf
    {C K : Type} [Add C] [Mul C] [Add K] [Mul K]
    (j : C → K)
    (hmapAdd : ∀ c d : C, j (c + d) = j c + j d)
    (hmapMul : ∀ c d : C, j (c * d) = j c * j d)
    (haddAssoc : ∀ x y z : K, (x + y) + z = x + (y + z))
    (haddComm : ∀ x y : K, x + y = y + x)
    (hmulAssoc : ∀ x y z : K, (x * y) * z = x * (y * z))
    (hmulComm : ∀ x y : K, x * y = y * x)
    (haddMul : ∀ x y z : K, (x + y) * z = x * z + y * z)
    (hmulAdd : ∀ x y z : K, x * (y + z) = x * y + x * z)
    (q a b a' b' : C) (s xi eta : K)
    (hs : s * s = j q)
    (hxi : xi = j a + j b * s) (heta : eta = j a' + j b' * s) :
    xi * eta = j (a * a' + q * (b * b')) + j (a * b' + b * a') * s := by
  let A : K := j a
  let B : K := j b
  let A' : K := j a'
  let B' : K := j b'
  have h₁ : A * (B' * s) = (A * B') * s := by rw [hmulAssoc]
  have h₂ : (B * s) * A' = (B * A') * s := by
    calc
      (B * s) * A' = B * (s * A') := by rw [hmulAssoc]
      _ = B * (A' * s) := by rw [hmulComm s A']
      _ = (B * A') * s := by rw [hmulAssoc]
  have h₃ : (B * s) * (B' * s) = j q * (B * B') := by
    calc
      (B * s) * (B' * s) = ((B * s) * B') * s := by rw [← hmulAssoc]
      _ = (B * (s * B')) * s := by rw [hmulAssoc B s B']
      _ = (B * (B' * s)) * s := by rw [hmulComm s B']
      _ = ((B * B') * s) * s := by rw [← hmulAssoc B B' s]
      _ = (B * B') * (s * s) := by rw [hmulAssoc]
      _ = (B * B') * j q := by rw [hs]
      _ = j q * (B * B') := by rw [hmulComm]
  calc
    xi * eta = (A + B * s) * (A' + B' * s) := by
      exact congrArg₂ (· * ·) hxi
        heta
    _ =
        A * (A' + B' * s) + (B * s) * (A' + B' * s) := by rw [haddMul]
    _ = (A * A' + A * (B' * s)) + (B * s) * (A' + B' * s) := by rw [hmulAdd]
    _ = (A * A' + A * (B' * s)) + ((B * s) * A' + (B * s) * (B' * s)) := by rw [hmulAdd]
    _ = (A * A' + (A * B') * s) + ((B * s) * A' + (B * s) * (B' * s)) := by rw [h₁]
    _ = (A * A' + (A * B') * s) + ((B * A') * s + (B * s) * (B' * s)) := by rw [h₂]
    _ = (A * A' + (A * B') * s) + ((B * A') * s + j q * (B * B')) := by rw [h₃]
    _ = (A * A' + (A * B') * s) + (j q * (B * B') + (B * A') * s) := by rw [haddComm ((B * A') * s)]
    _ = A * A' + ((A * B') * s + (j q * (B * B') + (B * A') * s)) := by rw [haddAssoc]
    _ = A * A' + (((A * B') * s + j q * (B * B')) + (B * A') * s) := by rw [haddAssoc]
    _ = A * A' + ((j q * (B * B') + (A * B') * s) + (B * A') * s) := by rw [haddComm ((A * B') * s)]
    _ = A * A' + (j q * (B * B') + ((A * B') * s + (B * A') * s)) := by rw [haddAssoc]
    _ = (A * A' + j q * (B * B')) + ((A * B') * s + (B * A') * s) := by rw [haddAssoc]
    _ = (A * A' + j q * (B * B')) + (A * B' + B * A') * s := by rw [haddMul]
    _ = (j (a * a') + j q * j (b * b')) +
        (j (a * b') + j (b * a')) * s := by
      simp only [hmapMul]
      rfl
    _ = (j (a * a') + j (q * (b * b'))) +
        (j (a * b') + j (b * a')) * s := by
      rw [hmapMul q (b * b')]
    _ = j (a * a' + q * (b * b')) +
        (j (a * b') + j (b * a')) * s := by
      rw [hmapAdd (a * a') (q * (b * b'))]
    _ = j (a * a' + q * (b * b')) +
        j (a * b' + b * a') * s := by
      rw [hmapAdd (a * b') (b * a')]

theorem mul_representation_necSuf
    {A K V : Type} (mulK : K → K → K)
    (value : K → V) (combine : A → A → V) (rep : K → A × A)
    (hUnique : ∀ x : K, ∀ a b : A, value x = combine a b → rep x = (a, b))
    (x y : K) (c d : A)
    (hmul : value (mulK x y) = combine c d) :
    rep (mulK x y) = (c, d) := by
  exact hUnique (mulK x y) c d hmul

end Ising2DLambda.NecSuf.FisherZero
