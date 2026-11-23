/-
章「道具: 可算な代数の足場」の「定数項一の形式的平方根は存在する」
（`claim_formal_square_root_exists`。本文から参照用ノートへ退避した主張）の具体版。

人手証明と同じ係数再帰と Cauchy 積の係数比較を使う。住処は Qbar[[X]] であり、
ℝ / ℂ は現れない。2 の逆元は Qbar が標数零の体であることから来る。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.Algebra.BigOperators.NatAntidiagonal

namespace Ising2DLambda.KacWard

open PowerSeries Finset Ising2DLambda.AlgebraicEigenvalue

/-- Qbar 上の平方根係数列（本文 `def_sqrt_coefficient_recursion` と 1 対 1）。
中間和は j = i + 1（i ∈ range n）で走らせる（j が 1 から n まで）。 -/
noncomputable def sqrtCoeff (d : ℕ → Qbar) : ℕ → Qbar
  | 0 => 1
  | n + 1 =>
    (2 : Qbar)⁻¹ *
      (d (n + 1) - ∑ i ∈ (range n).attach, sqrtCoeff d (i.1 + 1) * sqrtCoeff d (n - i.1))
decreasing_by
  · have := mem_range.mp i.2; omega
  · have := mem_range.mp i.2; omega

/-- 再帰の始点（本文の s_0 := 1）。 -/
theorem sqrtCoeff_zero (d : ℕ → Qbar) : sqrtCoeff d 0 = 1 := by
  rw [sqrtCoeff]

/-- 再帰の一段（本文の s_{n+1} の定義式）。 -/
theorem sqrtCoeff_succ (d : ℕ → Qbar) (n : ℕ) :
    sqrtCoeff d (n + 1) =
      (2 : Qbar)⁻¹ *
        (d (n + 1) - ∑ i ∈ range n, sqrtCoeff d (i + 1) * sqrtCoeff d (n - i)) := by
  rw [sqrtCoeff, sum_attach (range n) (fun j => sqrtCoeff d (j + 1) * sqrtCoeff d (n - j))]

/-- Qbar[[X]] で、定数項 1 の係数列の平方根係数列は定数項 1 の形式的平方根を与える。 -/
theorem formalSquareRoot_exists (d : ℕ → Qbar) (hd0 : d 0 = 1) :
    constantCoeff (mk (sqrtCoeff d)) = 1 ∧ mk (sqrtCoeff d) * mk (sqrtCoeff d) = mk d := by
  refine ⟨?_, ?_⟩
  · -- 人手証明: ac_0(S) = s_0 = 1
    rw [constantCoeff_mk, sqrtCoeff_zero]
  · ext n
    -- 人手証明: 形式的冪級数の等号は全係数の一致
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
      simp only [sqrtCoeff_zero, one_mul, mul_one, Nat.succ_sub_succ, Nat.sub_zero, Nat.sub_self]
      -- 再帰の定義から 2 s_{m+1} = d_{m+1} − 中間和
      have h2 : (2 : Qbar) * sqrtCoeff d (m + 1) =
          d (m + 1) - ∑ i ∈ range m, sqrtCoeff d (i + 1) * sqrtCoeff d (m - i) := by
        rw [sqrtCoeff_succ, ← mul_assoc, mul_inv_cancel₀ (by norm_num : (2 : Qbar) ≠ 0),
          one_mul]
      -- 人手証明: 2 s_{m+1} + 中間和 = d_{m+1}
      rw [add_assoc, ← two_mul, h2]
      ring

end Ising2DLambda.KacWard
