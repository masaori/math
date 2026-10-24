/-
「二次体の加法閉性」と「二次体の和の表示」の必要十分版。
加法閉性では表示の展開から係数の和までを九等号で導く。
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

theorem add_representation_necSuf
    {A K V : Type} (addA : A → A → A) (addK : K → K → K)
    (value : K → V) (combine : A → A → V) (rep : K → A × A)
    (hUnique : ∀ x : K, ∀ a b : A, value x = combine a b → rep x = (a, b))
    (x y : K)
    (hadd : value (addK x y) =
      combine (addA (rep x).1 (rep y).1) (addA (rep x).2 (rep y).2)) :
    rep (addK x y) =
      (addA (rep x).1 (rep y).1, addA (rep x).2 (rep y).2) := by
  exact hUnique (addK x y)
    (addA (rep x).1 (rep y).1) (addA (rep x).2 (rep y).2) hadd

end Ising2DLambda.NecSuf.FisherZero
