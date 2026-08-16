/-
人手証明「核は非負である」（`claim_open_square_density_difference_bound_core_nonneg_le_one`）の具体版。

主張: `0 < q ≤ 1` について `0 ≤_{Λ_ℚ} Γ(q)`（核 `Γ(q) := (X + (−Y)) + 2·C`、
`X := 2·ι(ℓ_2) + 4·ι(log(1+q))`、`Y := 4·ι(log q)`、`C := ι(ℓ_2) + 2·ι(log(1+q))`）。

  人手証明の段                                                このファイル
  準備の第一 符号 ι(log q) ≤ 0、0 ≤ ι(ℓ_2)、0 ≤ ι(log(1+q))    rationalLogOrderLE_toRational_logRat_nonpos_of_le_one /
                                                              rationalLogOrderLE_zero_toRational_generator_two /
                                                              rationalLogOrderLE_zero_toRational_logRat_one_add（既出）
  準備の第二 0 = 2·0 ≤ 2·ι(ℓ_2)、0 = 4·0 ≤ 4·ι(log(1+q))
             = 0 + 4·ι(log(1+q)) ≤ 2·ι(ℓ_2) + 4·ι(log(1+q)) = X   rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCoreX
  準備の第三 Y = 4·ι(log q) ≤ 4·0 = 0、0 = −0 ≤ −Y                rationalLogOrderLE_zero_neg_openSquareDensityDifferenceBoundCoreY_of_le_one
  準備の第四 0 ≤ C（既出）、0 = 2·0 ≤ 2·C                          hC2（本体の中）
  本体 0 = 0+0 ≤ X+0 = 0+X ≤ (−Y)+X = X+(−Y) = 0+(X+(−Y))
       ≤ 2·C+(X+(−Y)) = (X+(−Y))+2·C = Γ(q)                     rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCore_of_le_one

使うのは、埋め込んだ対数の符号、非負有理数倍の順序保存（`rationalLogOrderLE_ratSmul_of_nonneg`）、
加法単調性（`rationalLogOrderLE_add_right`）、逆元の順序反転（`rationalLogOrderLE_neg_le_neg`）、
推移律、`Λ_ℚ` の有理数倍 `c • 0 = 0`・逆元 `−0 = 0`・加法の単位元・交換則だけである。
住処は ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityDifferenceBoundCore
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupNegReversesOrder

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第二: `0 ≤_{Λ_ℚ} X := 2·ι(ℓ_2) + 4·ι(log(1+q))`。 -/
theorem rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCoreX {q : ℚ} (hq0 : 0 < q) :
    rationalLogOrderLE 0
      ((2 : ℚ) • toRational (generator ⟨2, Nat.prime_two⟩) + (4 : ℚ) • toRational (logRat (1 + q))) := by
  -- 準備の第一の符号
  have h2 := rationalLogOrderLE_zero_toRational_generator_two
  have h3 := rationalLogOrderLE_zero_toRational_logRat_one_add hq0
  -- 0 = 2·0 ≤ 2·ι(ℓ_2)（非負有理数倍の順序保存を c := 2、λ := 0、μ := ι(ℓ_2) で読む）
  have ha : rationalLogOrderLE 0 ((2 : ℚ) • toRational (generator ⟨2, Nat.prime_two⟩)) := by
    have h := rationalLogOrderLE_ratSmul_of_nonneg (by norm_num : (0 : ℚ) ≤ 2) h2
    rwa [smul_zero] at h
  -- 0 = 4·0 ≤ 4·ι(log(1+q))（c := 4、λ := 0、μ := ι(log(1+q))）
  have hb : rationalLogOrderLE 0 ((4 : ℚ) • toRational (logRat (1 + q))) := by
    have h := rationalLogOrderLE_ratSmul_of_nonneg (by norm_num : (0 : ℚ) ≤ 4) h3
    rwa [smul_zero] at h
  -- 0 + 4·ι(log(1+q)) ≤ 2·ι(ℓ_2) + 4·ι(log(1+q))（加法単調性）、単位元
  have hc := rationalLogOrderLE_add_right ha ((4 : ℚ) • toRational (logRat (1 + q)))
  rw [zero_add] at hc
  exact rationalLogOrderLE_trans hb hc

/-- 準備の第三: `q ≤ 1` なら `0 ≤_{Λ_ℚ} −Y := −(4·ι(log q))`。 -/
theorem rationalLogOrderLE_zero_neg_openSquareDensityDifferenceBoundCoreY_of_le_one
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE 0 (-((4 : ℚ) • toRational (logRat q))) := by
  -- 準備の第一の符号 ι(log q) ≤ 0
  have h1 := rationalLogOrderLE_toRational_logRat_nonpos_of_le_one hq0 hq1
  -- Y = 4·ι(log q) ≤ 4·0 = 0（非負有理数倍の順序保存を c := 4、λ := ι(log q)、μ := 0 で読む）
  have hY : rationalLogOrderLE ((4 : ℚ) • toRational (logRat q)) 0 := by
    have h := rationalLogOrderLE_ratSmul_of_nonneg (by norm_num : (0 : ℚ) ≤ 4) h1
    rwa [smul_zero] at h
  -- 0 = −0 ≤ −Y（逆元の順序反転を λ := Y、μ := 0 で読む）
  have h := rationalLogOrderLE_neg_le_neg hY
  rwa [neg_zero] at h

/-- 主張。 -/
theorem rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCore_of_le_one
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE 0 (openSquareDensityDifferenceBoundCore q) := by
  -- 略記（この証明の中だけ）
  set X : RationalLogOrderGroup :=
    (2 : ℚ) • toRational (generator ⟨2, Nat.prime_two⟩) + (4 : ℚ) • toRational (logRat (1 + q)) with hXdef
  set Y : RationalLogOrderGroup := (4 : ℚ) • toRational (logRat q) with hYdef
  set C : RationalLogOrderGroup :=
    toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)) with hCdef
  -- 準備の第二・第三
  have hX : rationalLogOrderLE 0 X := rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCoreX hq0
  have hnY : rationalLogOrderLE 0 (-Y) :=
    rationalLogOrderLE_zero_neg_openSquareDensityDifferenceBoundCoreY_of_le_one hq0 hq1
  -- 準備の第四: 0 ≤ C（既出）、0 = 2·0 ≤ 2·C
  have hC : rationalLogOrderLE 0 C := rationalLogOrderLE_zero_openSquareUpperBoundConstant hq0
  have hC2 : rationalLogOrderLE 0 ((2 : ℚ) • C) := by
    have h := rationalLogOrderLE_ratSmul_of_nonneg (by norm_num : (0 : ℚ) ≤ 2) hC
    rwa [smul_zero] at h
  -- 本体
  -- 0 = 0 + 0 ≤ X + 0 = 0 + X（加法単調性 ν := 0、単位元・交換則）
  have h1 : rationalLogOrderLE 0 (0 + X) := by
    have h := rationalLogOrderLE_add_right hX 0
    rwa [add_zero (0 : RationalLogOrderGroup), add_comm X 0] at h
  -- 0 + X ≤ (−Y) + X = X + (−Y)（加法単調性 ν := X、交換則）
  have h2 : rationalLogOrderLE (0 + X) (X + -Y) := by
    have h := rationalLogOrderLE_add_right hnY X
    rwa [add_comm (-Y) X] at h
  -- X + (−Y) = 0 + (X + (−Y)) ≤ 2·C + (X + (−Y)) = (X + (−Y)) + 2·C（単位元・加法単調性 ν := X + (−Y)・交換則）
  have h3 : rationalLogOrderLE (X + -Y) ((X + -Y) + (2 : ℚ) • C) := by
    have h := rationalLogOrderLE_add_right hC2 (X + -Y)
    rwa [zero_add, add_comm ((2 : ℚ) • C) (X + -Y)] at h
  -- (X + (−Y)) + 2·C = Γ(q)（核の定義と置き方）
  have hG : openSquareDensityDifferenceBoundCore q = (X + -Y) + (2 : ℚ) • C := rfl
  rw [hG]
  exact rationalLogOrderLE_trans h1 (rationalLogOrderLE_trans h2 h3)

end Ising2DLambda.ThermodynamicLimit
