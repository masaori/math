/-
不変部分集合上の反転による符号保存の必要十分版。
場合分けには判定可能な述語、その両側逆の構成には元の自己全単射と述語保存を使う。
符号の値側には積と単位元、積の結合則と左単位元、写像の乗法性と値の平方の法則を使う。
添字集合の有限性・順序も、値側の可換性・逆元・加法も要求しない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversal
import Mathlib.GroupTheory.Perm.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 部分置換や合成等式を仮定せず、具体版と同じ計算鎖で内部に構成する。 -/
theorem invariantPredicateReversal_sign
    {J S : Type*} [Mul S] [One S]
    (P : J → Prop) [DecidablePred P]
    (ε : Equiv.Perm J → S)
    (hMul : ∀ π τ, ε (π * τ) = ε π * ε τ)
    (hSquare : ∀ π, ε π * ε π = 1)
    (hAssoc : ∀ a b c : S, (a * b) * c = a * (b * c))
    (hOneMul : ∀ a : S, 1 * a = a)
    (σ : Equiv.Perm J) (hP : ∀ i : J, P (σ i) ↔ P i) :
    ε (invariantPredicateReversal P σ hP) = ε σ := by
  -- 逆像の所属を移す二つの同値。
  have hInv (i : J) : P (σ.symm i) ↔ P i := by
    calc
      P (σ.symm i) ↔ P (σ (σ.symm i)) := (hP (σ.symm i)).symm
      _ ↔ P i := by rw [σ.apply_symm_apply i]
  let p : J → J := fun i => if P i then σ i else i
  let q₀ : J → J := fun i => if P i then σ.symm i else i
  -- 内側三等号、外側二等号で一方の逆を示す。
  have hpq (i : J) : p (q₀ i) = i := by
    by_cases hi : P i
    · have hsi : P (σ.symm i) := (hInv i).mpr hi
      calc
        p (q₀ i) = p (σ.symm i) := congrArg p (if_pos hi)
        _ = σ (σ.symm i) := if_pos hsi
        _ = i := σ.apply_symm_apply i
    · calc
        p (q₀ i) = p i := congrArg p (if_neg hi)
        _ = i := if_neg hi
  -- 内側三等号、外側二等号でもう一方の逆を示す。
  have hqp (i : J) : q₀ (p i) = i := by
    by_cases hi : P i
    · have hsi : P (σ i) := (hP i).mpr hi
      calc
        q₀ (p i) = q₀ (σ i) := congrArg q₀ (if_pos hi)
        _ = σ.symm (σ i) := if_pos hsi
        _ = i := σ.symm_apply_apply i
    · calc
        q₀ (p i) = q₀ i := congrArg q₀ (if_neg hi)
        _ = i := if_neg hi
  let q : Equiv.Perm J :=
    { toFun := q₀, invFun := p, left_inv := hpq, right_inv := hqp }
  -- 二重合成は、内側五等号、外側四等号で反転と一致する。
  have hComposition : q * (q * σ) = invariantPredicateReversal P σ hP := by
    apply Equiv.ext
    intro i
    by_cases hi : P i
    · have hsi : P (σ i) := (hP i).mpr hi
      calc
        (q * (q * σ)) i = q (q (σ i)) := rfl
        _ = q (σ.symm (σ i)) := congrArg q (if_pos hsi)
        _ = q i := congrArg q (σ.symm_apply_apply i)
        _ = σ.symm i := if_pos hi
        _ = invariantPredicateReversal P σ hP i := (if_pos hi).symm
    · have hsi : ¬ P (σ i) := fun hmem => hi ((hP i).mp hmem)
      calc
        (q * (q * σ)) i = q (q (σ i)) := rfl
        _ = q (σ i) := congrArg q (if_neg hsi)
        _ = σ i := if_neg hsi
        _ = invariantPredicateReversal P σ hP i := (if_neg hi).symm
  -- 乗法性を二回、結合則・平方の法則・左単位元を一回ずつ使う六等号。
  calc
    ε (invariantPredicateReversal P σ hP) = ε (q * (q * σ)) :=
      congrArg ε hComposition.symm
    _ = ε q * ε (q * σ) := hMul q (q * σ)
    _ = ε q * (ε q * ε σ) := congrArg (ε q * ·) (hMul q σ)
    _ = (ε q * ε q) * ε σ := (hAssoc _ _ _).symm
    _ = 1 * ε σ := congrArg (· * ε σ) (hSquare q)
    _ = ε σ := hOneMul _

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
