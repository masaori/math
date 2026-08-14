/-
「実対数の自然数冪」の必要十分版。

実数・順序・対数・冪を外し、本文の帰納法が実際に使う二つの再帰等式、
乗法を加法へ移す等式、係数写像の零・一・加法保存、尺度作用の零・一・加法保存だけを残す。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 二つの再帰列と加法化・尺度作用の両立だけから、自然数回の積の像を求める。 -/
theorem naturalPower_map_necSuf
    {K C A : Type}
    (oneK : K) (mulK : K → K → K) (u : K) (power : ℕ → K)
    (zeroC oneC : C) (addC : C → C → C) (natEmbed : ℕ → C)
    (zeroA : A) (addA : A → A → A) (scale : C → A → A)
    (ell : K → A)
    (powerZero : power 0 = oneK)
    (powerSucc : ∀ k : ℕ, power (k + 1) = mulK (power k) u)
    (ellOne : ell oneK = zeroA)
    (ellMul : ∀ x : K, ell (mulK x u) = addA (ell x) (ell u))
    (scaleZero : ∀ y : A, scale zeroC y = zeroA)
    (scaleOne : ∀ y : A, scale oneC y = y)
    (scaleAdd : ∀ c d : C, ∀ y : A,
      addA (scale c y) (scale d y) = scale (addC c d) y)
    (embedZero : natEmbed 0 = zeroC)
    (embedOne : natEmbed 1 = oneC)
    (embedAddOne : ∀ k : ℕ, natEmbed (k + 1) = addC (natEmbed k) (natEmbed 1)) :
    ∀ n : ℕ, ell (power n) = scale (natEmbed n) (ell u)
  | 0 => by
      calc
        ell (power 0) = ell oneK := by rw [powerZero]
        _ = zeroA := ellOne
        _ = scale zeroC (ell u) := (scaleZero _).symm
        _ = scale (natEmbed 0) (ell u) := by rw [embedZero]
  | k + 1 => by
      calc
        ell (power (k + 1)) = ell (mulK (power k) u) := by rw [powerSucc]
        _ = addA (ell (power k)) (ell u) := ellMul (power k)
        _ = addA (scale (natEmbed k) (ell u)) (ell u) :=
          congrArg (fun z => addA z (ell u))
            (naturalPower_map_necSuf oneK mulK u power zeroC oneC addC natEmbed
              zeroA addA scale ell powerZero powerSucc ellOne ellMul scaleZero scaleOne
              scaleAdd embedZero embedOne embedAddOne k)
        _ = addA (scale (natEmbed k) (ell u)) (scale oneC (ell u)) := by
          rw [scaleOne]
        _ = scale (addC (natEmbed k) oneC) (ell u) := scaleAdd _ _ _
        _ = scale (addC (natEmbed k) (natEmbed 1)) (ell u) := by rw [embedOne]
        _ = scale (natEmbed (k + 1)) (ell u) :=
          congrArg (fun c => scale c (ell u)) (embedAddOne k).symm

end Ising2DLambda.NecSuf.ThermodynamicLimit
