/-
必要十分版: 2 が可逆な可換環上で、定数項 1 の係数列に対する平方根係数列の再帰は、
定数項 1 の形式的平方根を与える。

人手証明と同じ手順を使う。
  係数の再帰 s_0 = 1, s_{n+1} = ⅟2 (d_{n+1} − Σ_{j=1}^{n} s_j s_{n+1−j})
  Cauchy 積の n+1 次係数を j = 0 と j = n+1 の項の分離で 2 s_{n+1} + 中間和 に直し、
  再帰で d_{n+1} に戻す

使う構造は可換環と 2 の可逆性だけである。体・零積性・標数零・代数閉性は使わない
（一意性と違い、存在は零因子があっても通る）。
-/
import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.Algebra.BigOperators.NatAntidiagonal

namespace Ising2DLambda.NecSuf.KacWard

open PowerSeries Finset

variable {R : Type} [CommRing R] [Invertible (2 : R)]

/-- 平方根係数列の再帰（本文 `def_sqrt_coefficient_recursion` と 1 対 1）。
中間和は j = i + 1（i ∈ range n）で走らせる（j が 1 から n まで）。 -/
noncomputable def sqrtCoeff (d : ℕ → R) : ℕ → R
  | 0 => 1
  | n + 1 =>
    ⅟(2 : R) *
      (d (n + 1) - ∑ i ∈ (range n).attach, sqrtCoeff d (i.1 + 1) * sqrtCoeff d (n - i.1))
decreasing_by
  · have := mem_range.mp i.2; omega
  · have := mem_range.mp i.2; omega

/-- 再帰の始点（本文の s_0 := 1）。 -/
theorem sqrtCoeff_zero (d : ℕ → R) : sqrtCoeff d 0 = 1 := by
  rw [sqrtCoeff]

/-- 再帰の一段（attach を外した形。本文の s_{n+1} の定義式）。 -/
theorem sqrtCoeff_succ (d : ℕ → R) (n : ℕ) :
    sqrtCoeff d (n + 1) =
      ⅟(2 : R) * (d (n + 1) - ∑ i ∈ range n, sqrtCoeff d (i + 1) * sqrtCoeff d (n - i)) := by
  rw [sqrtCoeff, sum_attach (range n) (fun j => sqrtCoeff d (j + 1) * sqrtCoeff d (n - j))]

/-- 定数項は 1 である（本文の ac_0(S) = s_0 = 1）。 -/
theorem constantCoeff_mk_sqrtCoeff (d : ℕ → R) :
    constantCoeff (mk (sqrtCoeff d)) = 1 := by
  rw [constantCoeff_mk, sqrtCoeff_zero]

/-- 定数項 1 の形式的平方根は存在する（本文 `claim_formal_square_root_exists` と 1 対 1）。
    人手証明と同じく Cauchy 積の n 次係数を d n と比較する。 -/
theorem mk_sqrtCoeff_mul_self (d : ℕ → R) (hd0 : d 0 = 1) :
    mk (sqrtCoeff d) * mk (sqrtCoeff d) = mk d := by
  ext n
  -- 人手証明: 形式的冪級数の等号は全係数の一致（def_qbar_formal_power_series）
  rw [coeff_mk, coeff_mul]
  -- 人手証明: Cauchy 積の n 次係数は Σ_{j=0}^{n} s_j s_{n-j}
  rw [Finset.Nat.sum_antidiagonal_eq_sum_range_succ
    (fun a b => coeff a (mk (sqrtCoeff d)) * coeff b (mk (sqrtCoeff d))) n]
  simp only [coeff_mk]
  cases n with
  | zero =>
    -- 人手証明の n = 0 の鎖: s_0 s_0 = 1·1 = 1 = d_0
    simp [sqrtCoeff_zero, hd0]
  | succ m =>
    -- 人手証明の n ≥ 1 の鎖: j = 0 と j = n の項を分ける
    rw [Finset.sum_range_succ, Finset.sum_range_succ']
    -- s_0 = 1 と乗法単位元、および Nat の添字の整理
    simp only [sqrtCoeff_zero, one_mul, mul_one, Nat.succ_sub_succ, Nat.sub_zero, Nat.sub_self]
    -- 再帰の定義から 2 s_{m+1} = d_{m+1} − 中間和
    have h2 : (2 : R) * sqrtCoeff d (m + 1) =
        d (m + 1) - ∑ i ∈ range m, sqrtCoeff d (i + 1) * sqrtCoeff d (m - i) := by
      rw [sqrtCoeff_succ, ← mul_assoc, mul_invOf_self, one_mul]
    -- 人手証明: 2 s_{m+1} + 中間和 = d_{m+1}
    rw [add_assoc, ← two_mul, h2]
    ring

end Ising2DLambda.NecSuf.KacWard
