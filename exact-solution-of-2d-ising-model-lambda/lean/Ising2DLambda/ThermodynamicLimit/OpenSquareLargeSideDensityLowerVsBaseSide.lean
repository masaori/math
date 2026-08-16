/-
人手証明「基準辺の平方以上の辺の密度の基準辺の密度による一様な下からの評価（q は 1 以下）」
（`claim_open_square_large_side_density_lower_vs_base_side_le_one`）の具体版。

`a ≥ 1`、`a < L`、`a² ≤ L`、`0 < q ≤ 1` について
`(4/a)·ι(log q) + Ψ^op_a(q) + (−((2/a)·C)) ≤_{Λ_ℚ} Ψ^op_L(q)`、`C := ι(ℓ_2) + 2·ι(log(1+q))`。

準備の第一: 自然数の除法で `k ≥ 1`、`ka < L ≤ ka + a` を取る（上端と同じ `exists_multiple_side_below_of_lt`）。
準備の第二: ℚ の係数の比較 `2/L ≤ 2/a`（`a ≤ L`）、`2a/L ≤ 2a/a² = 2/a`（`a² ≤ L`）、
それを逆元へ移した `−(2/a) ≤ −(2a/L)`。
準備の第三: 符号 `ι(log q) ≤ 0`（`q ≤ 1`）、`0 ≤ C`。
準備の第四: 非正の元の係数比較 `(2/a)·ι(log q) ≤ (2/L)·ι(log q)`、
非負の元の係数比較 `(−(2/a))·C ≤ (−(2a/L))·C` と `(−r)·C = −(r·C)`（素数ごとの ℚ の四則）。
本体: `(4/a)·ι(log q) = (2/a)·ι(log q) + (2/a)·ι(log q)`（分配則）、第一の項を第四で置き換え、
末尾の項を第四で置き換え（加法単調性。交換則で先頭へ寄せてから当てる）、
倍数でない辺の下からの評価を第一の `k` で読み、推移律。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareNonMultipleSideDensityLowerVsBaseSide
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSideDensityUpperVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 主張。 -/
theorem rationalLogOrderLE_openSquareLargeSideDensity_lower_vs_baseSide_of_le_one
    (a L : ℕ) [NeZero a] [NeZero L] (haL : a < L) (hsq : a ^ 2 ≤ L)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
      (((4 : ℚ) / (a : ℚ)) • toRational (logRat q) +
        openScaledFreeEntropy a q +
        -(((2 : ℚ) / (a : ℚ)) •
          (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))))
      (openScaledFreeEntropy L q) := by
  have ha1 : 1 ≤ a := Nat.pos_of_ne_zero (NeZero.ne a)
  -- 準備の第一
  obtain ⟨k, hk1, hkL, hLk⟩ := exists_multiple_side_below_of_lt a L ha1 haL
  haveI : NeZero k := ⟨by omega⟩
  set C : RationalLogOrderGroup :=
    toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)) with hC
  set Ψ : RationalLogOrderGroup := openScaledFreeEntropy a q with hΨ
  set v : RationalLogOrderGroup := toRational (logRat q) with hv
  -- 準備の第二: ℚ の係数の比較
  have haq : (0 : ℚ) < (a : ℚ) := by exact_mod_cast ha1
  have haLq : (a : ℚ) ≤ (L : ℚ) := by exact_mod_cast haL.le
  have hsqq : ((a : ℚ) ^ 2) ≤ (L : ℚ) := by exact_mod_cast hsq
  -- 2/L ≤ 2/a（a ≤ L。正の分子の分数は分母が大きいほど小さい）
  have hcL : (2 : ℚ) / (L : ℚ) ≤ (2 : ℚ) / (a : ℚ) :=
    div_le_div_of_nonneg_left (by norm_num) haq haLq
  -- 2a/L ≤ 2a/a² = 2/a
  have hc2 : (2 * (a : ℚ)) / (L : ℚ) ≤ (2 : ℚ) / (a : ℚ) := by
    calc (2 * (a : ℚ)) / (L : ℚ) ≤ (2 * (a : ℚ)) / ((a : ℚ) ^ 2) :=
          div_le_div_of_nonneg_left (by positivity) (by positivity) hsqq
      _ = (2 : ℚ) / (a : ℚ) := by field_simp
  -- 逆元へ移す: −(2/a) ≤ −(2a/L)（ℚ の順序）
  have hneg : -((2 : ℚ) / (a : ℚ)) ≤ -((2 * (a : ℚ)) / (L : ℚ)) := neg_le_neg hc2
  -- 準備の第三: 符号
  have hv0 : rationalLogOrderLE v 0 := rationalLogOrderLE_toRational_logRat_nonpos_of_le_one hq0 hq1
  have hC0 : rationalLogOrderLE 0 C := rationalLogOrderLE_zero_openSquareUpperBoundConstant hq0
  -- 準備の第四: 非正の元の係数比較 (2/a)·v ≤ (2/L)·v
  have hA : rationalLogOrderLE (((2 : ℚ) / (a : ℚ)) • v) (((2 : ℚ) / (L : ℚ)) • v) :=
    rationalLogOrderLE_ratSmul_le_ratSmul_of_le_of_nonpos hcL hv0
  -- 非負の元の係数比較 (−(2/a))·C ≤ (−(2a/L))·C、(−r)·C = −(r·C)
  have hB' : rationalLogOrderLE ((-((2 : ℚ) / (a : ℚ))) • C) ((-((2 * (a : ℚ)) / (L : ℚ))) • C) :=
    rationalLogOrderLE_ratSmul_le_ratSmul_of_le hneg hC0
  have hB : rationalLogOrderLE (-(((2 : ℚ) / (a : ℚ)) • C)) (-(((2 * (a : ℚ)) / (L : ℚ)) • C)) := by
    rwa [neg_smul, neg_smul] at hB'
  -- 本体
  have hlow := rationalLogOrderLE_openSquareNonMultipleSideDensity_lower_vs_baseSide_of_le_one
    a k L hkL hLk hq0 hq1
  -- (4/a)·v = (2/a)·v + (2/a)·v（ℚ の四則・分配則）
  have hsplit : ((4 : ℚ) / (a : ℚ)) • v = ((2 : ℚ) / (a : ℚ)) • v + ((2 : ℚ) / (a : ℚ)) • v := by
    rw [← add_smul]; congr 1; ring
  -- 第四の前者に ν := (2/a)·v を足し、さらに Ψ を足し、さらに −((2/a)·C) を足す
  have h1 := rationalLogOrderLE_add_right
    (rationalLogOrderLE_add_right
      (rationalLogOrderLE_add_right hA (((2 : ℚ) / (a : ℚ)) • v)) Ψ)
    (-(((2 : ℚ) / (a : ℚ)) • C))
  -- 第四の後者に ν := ((2/L)·v + (2/a)·v) + Ψ を足す（交換則で先頭へ寄せる）
  have h2' := rationalLogOrderLE_add_right hB
    ((((2 : ℚ) / (L : ℚ)) • v + ((2 : ℚ) / (a : ℚ)) • v) + Ψ)
  rw [add_comm (-(((2 : ℚ) / (a : ℚ)) • C)), add_comm (-(((2 * (a : ℚ)) / (L : ℚ)) • C))] at h2'
  rw [hsplit]
  exact rationalLogOrderLE_trans h1 (rationalLogOrderLE_trans h2' hlow)

end Ising2DLambda.ThermodynamicLimit
