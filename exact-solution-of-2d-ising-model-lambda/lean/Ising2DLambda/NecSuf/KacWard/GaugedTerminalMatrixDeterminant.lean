/- スカラーの冪にはモノイドと準同型、相似変換には値域の可換モノイドと
乗法・スカラー倍の保存だけが必要である。加法、行列、対角性、逆元一般は仮定しない。 -/
import Mathlib.Algebra.Group.Hom.Defs
import Mathlib.Algebra.Group.Hom.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem mapped_eighthRoot_square_power_necSuf
    {R S : Type*} [Monoid R] [Monoid S] (C : R →* S)
    (z : R) (hz8 : z ^ 8 = 1) (m : ℕ) :
    C (z ^ 2) ^ (4 * m) = 1 := by
  calc
    C (z ^ 2) ^ (4 * m) = C ((z ^ 2) ^ (4 * m)) := (map_pow C _ _).symm
    _ = C (z ^ (2 * (4 * m))) := congrArg C (pow_mul z 2 _).symm
    _ = C (z ^ (8 * m)) := by rw [show 2 * (4 * m) = 8 * m by rw [← Nat.mul_assoc]]
    _ = C ((z ^ 8) ^ m) := congrArg C (pow_mul z 8 _)
    _ = C ((1 : R) ^ m) := by rw [hz8]
    _ = C (1 : R) := congrArg C (one_pow _)
    _ = 1 := map_one C

theorem scaledConjugate_determinant_necSuf
    {M S : Type*} [Mul M] [One M] [CommMonoid S]
    (det : M → S) (scale : S → M → M) (n : ℕ)
    (hmul : ∀ A B, det (A * B) = det A * det B)
    (hscale : ∀ c A, det (scale c A) = c ^ n * det A)
    (hone : det 1 = 1) (V T U : M) (c : S)
    (hinverse : V * U = 1) (hc : c ^ n = 1) :
    det (scale c ((V * T) * U)) = det T := by
  have hcancel : det V * det U = 1 := by
    calc
      det V * det U = det (V * U) := (hmul V U).symm
      _ = det 1 := congrArg det hinverse
      _ = 1 := hone
  calc
    det (scale c ((V * T) * U)) = c ^ n * det ((V * T) * U) := hscale c _
    _ = 1 * det ((V * T) * U) := by rw [hc]
    _ = det ((V * T) * U) := one_mul _
    _ = det (V * T) * det U := hmul _ _
    _ = (det V * det T) * det U := by rw [hmul V T]
    _ = det V * (det T * det U) := mul_assoc _ _ _
    _ = det V * (det U * det T) := congrArg (det V * ·) (mul_comm _ _)
    _ = (det V * det U) * det T := (mul_assoc _ _ _).symm
    _ = 1 * det T := by rw [hcancel]
    _ = det T := one_mul _

end Ising2DLambda.NecSuf.KacWard
