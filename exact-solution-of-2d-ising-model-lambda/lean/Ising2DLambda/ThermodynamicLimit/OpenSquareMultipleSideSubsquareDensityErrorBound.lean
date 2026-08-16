/-
人手証明「倍数辺の部分正方形による密度の挟み込みの誤差評価（q は 1 以下）」
（`claim_open_square_multiple_side_subsquare_density_error_bound`）の具体版。

`a,k ≥ 1`、`ka < L ≤ ka + a`、`0 < q ≤ 1` について
`(2/L)·ι(log q) + ((ka)²/L²)·Ψ^op_{ka}(q) ≤_{Λ_ℚ} Ψ^op_L(q)
 ≤_{Λ_ℚ} (2a/L)·ι(ℓ_2) + (4a/L)·ι(log(1+q)) + ((ka)²/L²)·Ψ^op_{ka}(q)`。

準備の第一: `claim_open_square_subsquare_comparison_density_le_one` を `a := ka` で読む。
準備の第二: ℚ の係数の三つの比較（`(ka+L)/L² ≤ 2/L`、`(L²−(ka)²)/L² ≤ 2a/L`（倍数辺との平方の差）、
`2(L²−(ka)²)/L² ≤ 4a/L`）。
準備の第三: 符号 `ι(log q) ≤ 0`、`0 ≤ ι(ℓ_2)`、`0 ≤ ι(log(1+q))`（`claim_rational_embedded_log_order_iff`
を `q' := 1`、`(1,2)`、`(1,1+q)` で読み、`log 1 = 0`・`ι(0) = 0`・`log 2 = ℓ_2`）。
準備の第四: 係数の大小による有理数倍の比較（非正 1 件・非負 2 件）。
本体: 加法単調性と推移律で左は二段、右は三段。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareSubsquareComparisonDensity
import Ising2DLambda.ThermodynamicLimit.SquareDifferenceFromMultipleSideBound
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupScalarCompareNonneg
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupScalarCompareNonpos
import Ising2DLambda.ThermodynamicLimit.RationalEmbeddedLogOrderIff
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupAddMonotone
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupLinearOrder
import Ising2DLambda.FreeEntropy.Additivity
import Ising2DLambda.FreeEntropy.AtOne

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `ι(0) = 0`（`claim_rational_log_order_group_embedding`。加法を保つ写像は単位元を単位元へ移す）。 -/
theorem toRational_zero : toRational (0 : LogOrderGroup) = 0 := by
  ext p
  rw [toRational_apply, Finsupp.zero_apply, Int.cast_zero, Finsupp.zero_apply]

/-- 準備の第三の第一: `q ≤ 1` なら `ι(log q) ≤_{Λ_ℚ} 0`。 -/
theorem rationalLogOrderLE_toRational_logRat_nonpos_of_le_one {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE (toRational (logRat q)) 0 := by
  -- ι(log q) ≤ ι(log 1)（claim_rational_embedded_log_order_iff を q' := 1 で）
  have h := (rationalLogOrderLE_toRational_logRat_iff hq0 one_pos).mp hq1
  -- log 1 = 0、ι(0) = 0
  rwa [logRat_one, toRational_zero] at h

/-- 準備の第三の第二: `0 ≤_{Λ_ℚ} ι(ℓ_2)`。 -/
theorem rationalLogOrderLE_zero_toRational_generator_two :
    rationalLogOrderLE 0 (toRational (generator ⟨2, Nat.prime_two⟩)) := by
  -- ι(log 1) ≤ ι(log 2)（(q,q') := (1,2)、1 ≤ 2）
  have h := (rationalLogOrderLE_toRational_logRat_iff one_pos two_pos).mp (by norm_num : (1 : ℚ) ≤ 2)
  -- log 1 = 0、ι(0) = 0、log 2 = ℓ_2
  rwa [logRat_one, toRational_zero, logRat_two] at h

/-- 準備の第三の第三: `0 < q` なら `0 ≤_{Λ_ℚ} ι(log(1+q))`。 -/
theorem rationalLogOrderLE_zero_toRational_logRat_one_add {q : ℚ} (hq0 : 0 < q) :
    rationalLogOrderLE 0 (toRational (logRat (1 + q))) := by
  -- ι(log 1) ≤ ι(log(1+q))（(q,q') := (1,1+q)、1 ≤ 1+q）
  have h := (rationalLogOrderLE_toRational_logRat_iff one_pos (by linarith)).mp
    (by linarith : (1 : ℚ) ≤ 1 + q)
  rwa [logRat_one, toRational_zero] at h

/-- 主張。 -/
theorem rationalLogOrderLE_openSquareMultipleSideSubsquareDensity_error_bounds_of_le_one
    (a k L : ℕ) [NeZero a] [NeZero k] [NeZero L] (h1 : k * a < L) (h2 : L ≤ k * a + a)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        (((2 : ℚ) / (L : ℚ)) • toRational (logRat q) +
          ((((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy (k * a) q)
        (openScaledFreeEntropy L q) ∧
      rationalLogOrderLE (openScaledFreeEntropy L q)
        (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 * (a : ℚ)) / (L : ℚ)) • toRational (logRat (1 + q)) +
          ((((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy (k * a) q) := by
  have hL : (0 : ℚ) < (L : ℚ) := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne L)
  have hL2 : (0 : ℚ) < (L : ℚ) ^ 2 := by positivity
  -- 準備の第一: 部分正方形比較を a := ka で読む（ka ≥ 1 は NeZero (k*a)、ka < L は h1）
  obtain ⟨hlow, hup⟩ :=
    rationalLogOrderLE_openSquareSubsquareDensity_bounds_of_le_one (k * a) L h1 hq0 hq1
  -- 準備の第二: ℚ の係数の三つの比較
  have hc1 : (((k * a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2)) ≤ (2 : ℚ) / (L : ℚ) := by
    -- ka + L ≤ L + L（ℕ の加法単調性）、L² > 0 で割る、2L/L² = 2/L
    have hn : ((k * a + L : ℕ) : ℚ) ≤ ((L + L : ℕ) : ℚ) := by
      exact_mod_cast Nat.add_le_add_right h1.le L
    calc (((k * a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2))
        ≤ ((L + L : ℕ) : ℚ) / ((L : ℚ) ^ 2) := div_le_div_of_nonneg_right hn hL2.le
      _ = (2 : ℚ) / (L : ℚ) := by
        push_cast; field_simp; norm_num
  have hc2 : (((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2)) ≤ (2 * (a : ℚ)) / (L : ℚ) := by
    -- claim_square_difference_from_multiple_side_bound、L² > 0 で割る、2aL/L² = 2a/L
    have hn : ((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) ≤ ((2 * a * L : ℕ) : ℚ) := by
      exact_mod_cast sq_sub_multiple_sq_le_two_mul_nat a k L h1.le h2
    calc (((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2))
        ≤ ((2 * a * L : ℕ) : ℚ) / ((L : ℚ) ^ 2) := div_le_div_of_nonneg_right hn hL2.le
      _ = (2 * (a : ℚ)) / (L : ℚ) := by
        push_cast; field_simp
  have hc3 : (((2 * (L ^ 2 - (k * a) ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) ≤ (4 * (a : ℚ)) / (L : ℚ) := by
    -- 2·((L²−(ka)²)/L²) ≤ 2·(2a/L) = 4a/L
    calc (((2 * (L ^ 2 - (k * a) ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2))
        = 2 * ((((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2))) := by
          push_cast; ring
      _ ≤ 2 * ((2 * (a : ℚ)) / (L : ℚ)) := by
          exact mul_le_mul_of_nonneg_left hc2 (by norm_num)
      _ = (4 * (a : ℚ)) / (L : ℚ) := by ring
  -- 準備の第三: 符号
  have hs1 := rationalLogOrderLE_toRational_logRat_nonpos_of_le_one hq0 hq1
  have hs2 := rationalLogOrderLE_zero_toRational_generator_two
  have hs3 := rationalLogOrderLE_zero_toRational_logRat_one_add hq0
  -- 準備の第四: 係数の大小による有理数倍の比較
  have hm1 := rationalLogOrderLE_ratSmul_le_ratSmul_of_le_of_nonpos hc1 hs1   -- (2/L)·ι(log q) ≤ ((ka+L)/L²)·ι(log q)
  have hm2 := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hc2 hs2             -- ((L²−(ka)²)/L²)·ι(ℓ_2) ≤ (2a/L)·ι(ℓ_2)
  have hm3 := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hc3 hs3             -- (2(L²−(ka)²)/L²)·ι(log(1+q)) ≤ (4a/L)·ι(log(1+q))
  refine ⟨?_, ?_⟩
  · -- 左: 加法単調性で第一項を取り替え、第一の左へ推移律
    exact rationalLogOrderLE_trans (rationalLogOrderLE_add_right hm1 _) hlow
  · -- 右: 第一の右、加法単調性（第一項。二回右から足す）、加法単調性（第二項）
    -- 第一項だけを取り替えた中間の元
    have hmid1 : rationalLogOrderLE
        ((((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          (((2 * (L ^ 2 - (k * a) ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q)) +
          ((((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy (k * a) q)
        (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          (((2 * (L ^ 2 - (k * a) ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q)) +
          ((((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy (k * a) q) :=
      rationalLogOrderLE_add_right (rationalLogOrderLE_add_right hm2 _) _
    -- 第二項へ当てるため、加法の交換則で当てる項を先頭へ寄せてから読む
    have hmid2 : rationalLogOrderLE
        (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          (((2 * (L ^ 2 - (k * a) ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q)) +
          ((((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy (k * a) q)
        (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 * (a : ℚ)) / (L : ℚ)) • toRational (logRat (1 + q)) +
          ((((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy (k * a) q) := by
      rw [add_comm (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩))
            ((((2 * (L ^ 2 - (k * a) ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q))),
          add_comm (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩))
            (((4 * (a : ℚ)) / (L : ℚ)) • toRational (logRat (1 + q)))]
      exact rationalLogOrderLE_add_right (rationalLogOrderLE_add_right hm3 _) _
    exact rationalLogOrderLE_trans hup (rationalLogOrderLE_trans hmid1 hmid2)

end Ising2DLambda.ThermodynamicLimit
