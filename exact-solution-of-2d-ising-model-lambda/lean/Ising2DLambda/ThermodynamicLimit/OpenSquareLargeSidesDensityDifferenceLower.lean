/-
人手証明「基準辺の平方以上の二つの辺の密度の差の一様な下からの評価（q は 1 以下）」
（`claim_open_square_large_sides_density_difference_lower_le_one`）の具体版。

`a ≥ 1`、`a < L`、`a < M`、`a² ≤ L`、`a² ≤ M`、`0 < q ≤ 1` について
`−R ≤_{Λ_ℚ} Ψ^op_L(q) + (−Ψ^op_M(q))`、`R := U + (−D) + (2/a)·C`
（`U := (2/a)·ι(ℓ_2) + (4/a)·ι(log(1+q))`、`D := (4/a)·ι(log q)`、`C := ι(ℓ_2) + 2·ι(log(1+q))`。
差の上からの評価の右辺と同じ元）。

入れ替えた上端: 差の上からの評価を第一の辺 `M`・第二の辺 `L` で読む
（`rationalLogOrderLE_openSquareLargeSidesDensityDifference_upper_of_le_one a M L`）: `Ψ^op_M + (−Ψ^op_L) ≤ R`。
準備: `−(Ψ^op_M + (−Ψ^op_L)) = Ψ^op_L + (−Ψ^op_M)` を素数ごとに六段で示す
（`neg_add_neg_eq_add_neg_swap`。逆元の定義・加法の定義・逆元の定義・ℚ の四則・逆元の定義・加法の定義）。
本体: 逆元による順序の反転（`rationalLogOrderLE_neg_le_neg`）で `−R ≤ −(Ψ^op_M + (−Ψ^op_L))`、準備の結論で読み替える。
有理数倍の係数には触れない。住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSidesDensityDifferenceUpper
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupNegReversesOrder

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備: `−(μ + (−λ)) = λ + (−μ)` を素数ごとに六段で示す（人手証明の準備の鎖と 1 対 1）。 -/
theorem neg_add_neg_eq_add_neg_swap (l m : RationalLogOrderGroup) :
    -(m + -l) = l + -m := by
  ext p
  calc (-(m + -l)) p
      = -((m + -l) p) := Finsupp.neg_apply _ _          -- 逆元の定義
    _ = -(m p + (-l) p) := by rw [Finsupp.add_apply]    -- 加法の定義
    _ = -(m p + -(l p)) := by rw [Finsupp.neg_apply]    -- 逆元の定義
    _ = l p + -(m p) := by ring                          -- ℚ の四則 −(u+(−v)) = v+(−u)
    _ = l p + (-m) p := by rw [Finsupp.neg_apply]        -- 逆元の定義
    _ = (l + -m) p := by rw [Finsupp.add_apply]          -- 加法の定義

/-- 主張。 -/
theorem rationalLogOrderLE_openSquareLargeSidesDensityDifference_lower_of_le_one
    (a L M : ℕ) [NeZero a] [NeZero L] [NeZero M]
    (haL : a < L) (haM : a < M) (hsqL : a ^ 2 ≤ L) (hsqM : a ^ 2 ≤ M)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
      (-((((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q))) +
        -(((4 : ℚ) / (a : ℚ)) • toRational (logRat q)) +
        ((2 : ℚ) / (a : ℚ)) •
          (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))))
      (openScaledFreeEntropy L q + -(openScaledFreeEntropy M q)) := by
  -- 入れ替えた上端（第一の辺 M、第二の辺 L）
  have hswap :=
    rationalLogOrderLE_openSquareLargeSidesDensityDifference_upper_of_le_one a M L haM haL hsqM hsqL hq0 hq1
  -- 本体: 逆元による順序の反転
  have h1 := rationalLogOrderLE_neg_le_neg hswap
  -- 準備の結論で右辺を読み替える
  rwa [neg_add_neg_eq_add_neg_swap] at h1

end Ising2DLambda.ThermodynamicLimit
