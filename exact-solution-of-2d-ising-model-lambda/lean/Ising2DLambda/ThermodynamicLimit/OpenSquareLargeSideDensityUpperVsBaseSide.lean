/-
人手証明「基準辺の平方以上の辺の密度の基準辺の密度による一様な上からの評価（q は 1 以下）」
（`claim_open_square_large_side_density_upper_vs_base_side_le_one`）の具体版。

`a ≥ 1`、`a < L`、`a² ≤ L`、`0 < q ≤ 1` について
`Ψ^op_L(q) ≤_{Λ_ℚ} (2/a)·ι(ℓ_2) + (4/a)·ι(log(1+q)) + Ψ^op_a(q)`。

準備の第一: 自然数の除法で `L − 1 = k a + r`、`0 ≤ r < a` を取り、`k ≥ 1`、`ka < L ≤ ka + a`。
準備の第二: ℚ の係数の比較 `2a/L ≤ 2a/a² = 2/a`、`4a/L ≤ 4a/a² = 4/a`（`a² ≤ L`）。
準備の第三: 符号 `0 ≤ ι(ℓ_2)`、`0 ≤ ι(log(1+q))`（埋め込んだ対数の順序）。
準備の第四: 非負の元の有理数倍を係数の大小で比較（`(2a/L)·ι(ℓ_2) ≤ (2/a)·ι(ℓ_2)`、
`(4a/L)·ι(log(1+q)) ≤ (4/a)·ι(log(1+q))`）。
本体: 倍数でない辺の上からの評価を第一の `k` で読み、右辺の最初の二つの項を第四で置き換える
（加法単調性。二番目の項へは交換則で先頭へ寄せてから当てる）、推移律。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareNonMultipleSideDensityUpperVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第一: `a ≥ 1`、`a < L` なら `k ≥ 1`、`ka < L ≤ ka + a` を満たす `k` がある
（`k := (L − 1) / a`、自然数の除法）。 -/
theorem exists_multiple_side_below_of_lt (a L : ℕ) (ha : 1 ≤ a) (haL : a < L) :
    ∃ k : ℕ, 1 ≤ k ∧ k * a < L ∧ L ≤ k * a + a := by
  have hL1 : 1 ≤ L := le_trans ha haL.le
  -- 除法の等式 L − 1 = k a + r、0 ≤ r < a
  have hdiv : (L - 1) = a * ((L - 1) / a) + (L - 1) % a := (Nat.div_add_mod (L - 1) a).symm
  have hr : (L - 1) % a < a := Nat.mod_lt _ (Nat.pos_of_ne_zero (by omega))
  refine ⟨(L - 1) / a, ?_, ?_, ?_⟩
  · -- a ≤ L − 1 = ka + r < ka + a = (k+1)a なので 1 < k + 1（ℕ の乗法の順序）
    have h1 : a ≤ L - 1 := by omega
    exact Nat.div_pos h1 (by omega)
  · -- ka ≤ ka + r = L − 1 < L
    have : ((L - 1) / a) * a ≤ L - 1 := Nat.div_mul_le_self (L - 1) a
    omega
  · -- L = ka + r + 1 ≤ ka + (a − 1) + 1 = ka + a
    have : L - 1 < ((L - 1) / a) * a + a := by
      rw [Nat.mul_comm]; omega
    omega

/-- 主張。 -/
theorem rationalLogOrderLE_openSquareLargeSideDensity_upper_vs_baseSide_of_le_one
    (a L : ℕ) [NeZero a] [NeZero L] (haL : a < L) (hsq : a ^ 2 ≤ L)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE (openScaledFreeEntropy L q)
      (((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
        ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q)) +
        openScaledFreeEntropy a q) := by
  have ha1 : 1 ≤ a := Nat.pos_of_ne_zero (NeZero.ne a)
  -- 準備の第一
  obtain ⟨k, hk1, hkL, hLk⟩ := exists_multiple_side_below_of_lt a L ha1 haL
  haveI : NeZero k := ⟨by omega⟩
  -- 準備の第二: ℚ の係数の比較
  have haq : (0 : ℚ) < (a : ℚ) := by exact_mod_cast ha1
  have hsqq : ((a : ℚ) ^ 2) ≤ (L : ℚ) := by exact_mod_cast hsq
  have hc2 : (2 * (a : ℚ)) / (L : ℚ) ≤ (2 : ℚ) / (a : ℚ) := by
    calc (2 * (a : ℚ)) / (L : ℚ) ≤ (2 * (a : ℚ)) / ((a : ℚ) ^ 2) :=
          div_le_div_of_nonneg_left (by positivity) (by positivity) hsqq
      _ = (2 : ℚ) / (a : ℚ) := by field_simp
  have hc4 : (4 * (a : ℚ)) / (L : ℚ) ≤ (4 : ℚ) / (a : ℚ) := by
    calc (4 * (a : ℚ)) / (L : ℚ) ≤ (4 * (a : ℚ)) / ((a : ℚ) ^ 2) :=
          div_le_div_of_nonneg_left (by positivity) (by positivity) hsqq
      _ = (4 : ℚ) / (a : ℚ) := by field_simp
  -- 準備の第三: 符号
  have hs2 := rationalLogOrderLE_zero_toRational_generator_two
  have hs3 := rationalLogOrderLE_zero_toRational_logRat_one_add hq0
  -- 準備の第四: 非負の元の係数の大小による比較
  have hA := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hc2 hs2
  have hB := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hc4 hs3
  -- 本体
  have hup := rationalLogOrderLE_openSquareNonMultipleSideDensity_upper_vs_baseSide_of_le_one
    a k L hkL hLk hq0 hq1
  -- 第四の前者に ν := (4a/L)·ι(log(1+q)) を足し、さらに ν := Ψ_a を足す
  have h1 := rationalLogOrderLE_add_right
    (rationalLogOrderLE_add_right hA (((4 * (a : ℚ)) / (L : ℚ)) • toRational (logRat (1 + q))))
    (openScaledFreeEntropy a q)
  -- 第四の後者に ν := (2/a)·ι(ℓ_2) を足し（交換則で先頭へ寄せる）、さらに ν := Ψ_a を足す
  have h2' := rationalLogOrderLE_add_right hB
    (((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩))
  rw [add_comm _ (((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩)),
    add_comm (((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q)))
      (((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩))] at h2'
  have h2 := rationalLogOrderLE_add_right h2' (openScaledFreeEntropy a q)
  exact rationalLogOrderLE_trans hup (rationalLogOrderLE_trans h1 h2)

end Ising2DLambda.ThermodynamicLimit
