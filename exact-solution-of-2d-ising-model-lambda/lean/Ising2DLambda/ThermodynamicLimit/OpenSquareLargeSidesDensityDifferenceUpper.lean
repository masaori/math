/-
人手証明「基準辺の平方以上の二つの辺の密度の差の一様な上からの評価（q は 1 以下）」
（`claim_open_square_large_sides_density_difference_upper_le_one`）の具体版。

`a ≥ 1`、`a < L`、`a < M`、`a² ≤ L`、`a² ≤ M`、`0 < q ≤ 1` について
`Ψ^op_L(q) + (−Ψ^op_M(q)) ≤_{Λ_ℚ} U + (−D) + (2/a)·C`、
`U := (2/a)·ι(ℓ_2) + (4/a)·ι(log(1+q))`、`D := (4/a)·ι(log q)`、`C := ι(ℓ_2) + 2·ι(log(1+q))`。

上端: `Ψ^op_L ≤ U + Ψ^op_a`（`rationalLogOrderLE_openSquareLargeSideDensity_upper_vs_baseSide_of_le_one`）。
下端: `(D + Ψ^op_a) + (−(2/a)·C) ≤ Ψ^op_M`（`rationalLogOrderLE_openSquareLargeSideDensity_lower_vs_baseSide_of_le_one`）。
準備: 下端の両辺に `(−D) + (2/a)·C` を足し（加法単調性）、左辺を結合則・交換則・逆元・単位元で `Ψ^op_a` に戻す。
本体: 上端に `−Ψ^op_M` を足す、並べ替え、準備の結論に `(−Ψ^op_M) + U` を足す、並べ替え、逆元、単位元、推移律。
有理数倍の係数には触れない。住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSideDensityLowerVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 主張。 -/
theorem rationalLogOrderLE_openSquareLargeSidesDensityDifference_upper_of_le_one
    (a L M : ℕ) [NeZero a] [NeZero L] [NeZero M]
    (haL : a < L) (haM : a < M) (hsqL : a ^ 2 ≤ L) (hsqM : a ^ 2 ≤ M)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
      (openScaledFreeEntropy L q + -(openScaledFreeEntropy M q))
      ((((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q))) +
        -(((4 : ℚ) / (a : ℚ)) • toRational (logRat q)) +
        ((2 : ℚ) / (a : ℚ)) •
          (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))) := by
  set U : RationalLogOrderGroup :=
    ((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
      ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q)) with hU
  set D : RationalLogOrderGroup := ((4 : ℚ) / (a : ℚ)) • toRational (logRat q) with hD
  set tC : RationalLogOrderGroup :=
    ((2 : ℚ) / (a : ℚ)) •
      (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) with htC
  set Ψ : RationalLogOrderGroup := openScaledFreeEntropy a q with hΨ
  set ΨL : RationalLogOrderGroup := openScaledFreeEntropy L q with hΨL
  set ΨM : RationalLogOrderGroup := openScaledFreeEntropy M q with hΨM
  -- 上端（辺 a, L）
  have hup : rationalLogOrderLE ΨL (U + Ψ) :=
    rationalLogOrderLE_openSquareLargeSideDensity_upper_vs_baseSide_of_le_one a L haL hsqL hq0 hq1
  -- 下端（辺 a, M）
  have hlow : rationalLogOrderLE (D + Ψ + -tC) ΨM :=
    rationalLogOrderLE_openSquareLargeSideDensity_lower_vs_baseSide_of_le_one a M haM hsqM hq0 hq1
  -- 準備: 下端の両辺に (−D) + tC を足す
  have hprep' := rationalLogOrderLE_add_right hlow (-D + tC)
  -- 左辺を Ψ に戻す: 並べ替え → 逆元 → 単位元
  have hre : D + Ψ + -tC + (-D + tC) = Ψ + ((D + -D) + (-tC + tC)) := by
    simp only [add_assoc, add_comm, add_left_comm]
  have hprep : rationalLogOrderLE Ψ (ΨM + (-D + tC)) := by
    rw [hre, add_neg_cancel, neg_add_cancel, add_zero, add_zero] at hprep'
    exact hprep'
  -- 本体
  -- 上端に −ΨM を足す
  have h1 : rationalLogOrderLE (ΨL + -ΨM) (U + Ψ + -ΨM) := rationalLogOrderLE_add_right hup (-ΨM)
  -- 並べ替え
  have h2 : U + Ψ + -ΨM = Ψ + (-ΨM + U) := by
    simp only [add_comm, add_left_comm]
  -- 準備の結論に (−ΨM) + U を足す
  have h3 : rationalLogOrderLE (Ψ + (-ΨM + U)) (ΨM + (-D + tC) + (-ΨM + U)) :=
    rationalLogOrderLE_add_right hprep (-ΨM + U)
  -- 並べ替え・逆元・単位元と結合則
  have h4 : ΨM + (-D + tC) + (-ΨM + U) = (ΨM + -ΨM) + (U + (-D + tC)) := by
    simp only [add_assoc, add_comm, add_left_comm]
  have h5 : (ΨM + -ΨM) + (U + (-D + tC)) = U + -D + tC := by
    rw [add_neg_cancel, zero_add]; exact (add_assoc _ _ _).symm
  rw [h2] at h1
  rw [h4, h5] at h3
  exact rationalLogOrderLE_trans h1 h3

end Ising2DLambda.ThermodynamicLimit
