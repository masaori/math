/-
「二次体の加法閉性」と「二次体の和の表示」の必要十分版。
両方とも表示の展開から係数の和までを九等号で導く。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 表示仕様・結合則・中央の二項の可換性・右乗法の加法保存・包含の加法保存だけを使う。
係数の加法の法則、乗法、単位元、逆元、平方根の条件は不要である。 -/
theorem add_mem_necSuf
    {A K : Type} [Add A] [Add K] (j : A → K) (scale : K → K)
    (hAssoc : ∀ u v w : K, (u + v) + w = u + (v + w))
    (hComm : ∀ b a : A, scale (j b) + j a = j a + scale (j b))
    (hScale : ∀ b d : A, scale (j b + j d) = scale (j b) + scale (j d))
    (hMap : ∀ a c : A, j (a + c) = j a + j c)
    (x y : K) (a b a' b' : A)
    (hx : x = j a + scale (j b)) (hy : y = j a' + scale (j b')) :
    ∃ c d : A, x + y = j c + scale (j d) := by
  -- 本文の四所属に対応する証人は、係数の型 A の和である。
  refine ⟨a + a', b + b', ?_⟩
  -- 本文の表示の代入から包含の加法保存まで、同じ九等号。
  calc
    x + y = (j a + scale (j b)) + (j a' + scale (j b')) := by rw [hx, hy]
    _ = j a + (scale (j b) + (j a' + scale (j b'))) := hAssoc _ _ _
    _ = j a + ((scale (j b) + j a') + scale (j b')) := by rw [hAssoc]
    _ = j a + ((j a' + scale (j b)) + scale (j b')) := by rw [hComm]
    _ = j a + (j a' + (scale (j b) + scale (j b'))) := by rw [hAssoc]
    _ = (j a + j a') + (scale (j b) + scale (j b')) := (hAssoc _ _ _).symm
    _ = (j a + j a') + scale (j b + j b') := by rw [hScale]
    _ = j (a + a') + scale (j b + j b') := by rw [hMap a a']
    _ = j (a + a') + scale (j (b + b')) := by rw [hMap b b']

/-- 和の値への展開、表示仕様、係数整理の演算則、一意性だけを使う。
係数の加法則・体構造・平方根条件は不要で、一意性は最後の表示確定にだけ使う。 -/
theorem add_representation_necSuf
    {A K V : Type} [Add A] [Add V]
    (addK : K → K → K) (value : K → V) (rep : K → A × A)
    (j : A → V) (scale : V → V)
    (hAssoc : ∀ u v w : V, (u + v) + w = u + (v + w))
    (hComm : ∀ b a : A, scale (j b) + j a = j a + scale (j b))
    (hScale : ∀ b d : A, scale (j b + j d) = scale (j b) + scale (j d))
    (hMap : ∀ a c : A, j (a + c) = j a + j c)
    (hValue : ∀ x y : K, value (addK x y) = value x + value y)
    (hSpec : ∀ x : K, value x = j (rep x).1 + scale (j (rep x).2))
    (hUnique : ∀ x : K, ∀ a b : A,
      value x = j a + scale (j b) → rep x = (a, b))
    (x y : K) :
    rep (addK x y) = ((rep x).1 + (rep y).1, (rep x).2 + (rep y).2) := by
  let a := (rep x).1
  let b := (rep x).2
  let a' := (rep y).1
  let b' := (rep y).2
  apply hUnique
  rw [hValue]
  -- 本文と同じ九等号で表示を作り、最後に一意性へ渡す。
  calc
    value x + value y = (j a + scale (j b)) + (j a' + scale (j b')) := by
      rw [hSpec x, hSpec y]
    _ = j a + (scale (j b) + (j a' + scale (j b'))) := hAssoc _ _ _
    _ = j a + ((scale (j b) + j a') + scale (j b')) := by rw [hAssoc]
    _ = j a + ((j a' + scale (j b)) + scale (j b')) := by rw [hComm]
    _ = j a + (j a' + (scale (j b) + scale (j b'))) := by rw [hAssoc]
    _ = (j a + j a') + (scale (j b) + scale (j b')) := (hAssoc _ _ _).symm
    _ = (j a + j a') + scale (j b + j b') := by rw [hScale]
    _ = j (a + a') + scale (j b + j b') := by rw [hMap a a']
    _ = j (a + a') + scale (j (b + b')) := by rw [hMap b b']

end Ising2DLambda.NecSuf.FisherZero
