/-
「一と s の一次独立性」の五計算鎖を保つ必要十分版。
係数側は零元・単位元・積・負号・逆元の演算と、非零係数の左逆元だけを使う。
値側は加法の結合則・左右の零元・左の加法逆元、および積の結合則・左単位元・
左零元だけを使う。体・分配則・可換性・値側の除法・係数側の加法は要求しない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- `target` は本文の二に当たるが、証明が使うのは平方として表せないことだけである。
左逆元と積・単位元の保存は逆元の移送、加法の四法則は移項、積の結合則と
負号の保存は根の表示に必要である。単射性は平方の矛盾と最後の係数消去に使い、
零元の保存と左零元は最後の計算鎖に使う。途中の等式は仮定せず各鎖で導く。 -/
theorem one_s_linearly_independent_necSuf
    {A K : Type*} [Zero A] [One A] [Mul A] [Neg A] [Inv A]
    [Zero K] [One K] [Add K] [Mul K] [Neg K]
    (embed : A → K) (hEmbedInjective : Function.Injective embed)
    (hEmbedMul : ∀ x y : A, embed (x * y) = embed x * embed y)
    (hEmbedNeg : ∀ x : A, embed (-x) = -embed x)
    (hEmbedOne : embed 1 = 1) (hEmbedZero : embed 0 = 0)
    (hLeftInverse : ∀ b : A, b ≠ 0 → b⁻¹ * b = 1)
    (hZeroAdd : ∀ x : K, 0 + x = x)
    (hAddZero : ∀ x : K, x + 0 = x)
    (hNegAdd : ∀ x : K, -x + x = 0)
    (hAddAssoc : ∀ x y z : K, (x + y) + z = x + (y + z))
    (hOneMul : ∀ x : K, 1 * x = x)
    (hMulAssoc : ∀ x y z : K, (x * y) * z = x * (y * z))
    (hZeroMul : ∀ x : K, 0 * x = 0)
    (target : A) (hNoSquare : ∀ q : A, q * q ≠ target)
    (s : K) (hs : s * s = embed target)
    (a b : A) (hab : embed a + embed b * s = 0) :
    a = 0 ∧ b = 0 := by
  have hb : b = 0 := by
    by_contra hbne
    let r : A := b⁻¹ * (-a)
    have hInverse : embed (b⁻¹) * embed b = 1 := by
      calc
        embed (b⁻¹) * embed b = embed (b⁻¹ * b) := by rw [hEmbedMul]
        _ = embed 1 := by rw [hLeftInverse b hbne]
        _ = 1 := hEmbedOne
    have hbs : embed b * s = -(embed a) := by
      calc
        embed b * s = 0 + embed b * s := by rw [hZeroAdd]
        _ = (-embed a + embed a) + embed b * s := by rw [hNegAdd]
        _ = -embed a + (embed a + embed b * s) := by rw [hAddAssoc]
        _ = -embed a + 0 := by rw [hab]
        _ = -embed a := by rw [hAddZero]
    have hsr : s = embed r := by
      calc
        s = 1 * s := by rw [hOneMul]
        _ = (embed (b⁻¹) * embed b) * s := by rw [hInverse]
        _ = embed (b⁻¹) * (embed b * s) := by rw [hMulAssoc]
        _ = embed (b⁻¹) * (-embed a) := by rw [hbs]
        _ = embed (b⁻¹) * embed (-a) := by rw [hEmbedNeg]
        _ = embed (b⁻¹ * (-a)) := by rw [hEmbedMul]
        _ = embed r := rfl
    have hrSquare : r * r = target := by
      apply hEmbedInjective
      calc
        embed (r * r) = embed r * embed r := by rw [hEmbedMul]
        _ = s * s := by rw [hsr]
        _ = embed target := hs
    exact hNoSquare r hrSquare
  constructor
  · apply hEmbedInjective
    calc
      embed a = embed a + 0 := by rw [hAddZero]
      _ = embed a + 0 * s := by rw [hZeroMul]
      _ = embed a + embed 0 * s := by rw [hEmbedZero]
      _ = embed a + embed b * s := by rw [hb]
      _ = 0 := hab
      _ = embed 0 := by rw [hEmbedZero]
  · exact hb

end Ising2DLambda.NecSuf.FisherZero
