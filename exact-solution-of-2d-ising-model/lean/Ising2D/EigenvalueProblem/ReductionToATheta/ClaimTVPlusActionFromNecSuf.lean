/-
# 具体版 `T_V_plus_check_Z_Y` を必要十分版 `NecSuf.actsBy_TV_sandwich` の特殊化として得る

対応する人手証明のラベル: **`T_V_plus_check_Z_Y`**
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`）。

人手証明と 1 対 1 に対応する具体版は `EigenvalueProblem/ReductionToATheta/ClaimTVPlusAction.lean` の
`TVPlus_checkZ_checkY` である（(z)・(y) の各列を 6 行の鎖で示し、2 列を並べる）。本ファイルは同じ主張を
必要十分版 `Ising2D/NecSuf/TVActionSandwich.lean` の `actsBy_TV_sandwich` の特殊化として導出し、
README 4 節の要件 4 を満たす。

渡すのは `T_1 = T_{(V_1^{(+)})^{1/2}}`（作用行列 `B_1(θ~_μ)`、`actsBy_TConj_V1plusHalf`）と
`T_2 = T_{V_2}`（作用行列 `B_2`、`actsBy_TConj_V2H2Form_check`）である。具体版の (z)・(y) の鎖の 6 行は、
必要十分版では合成則 `ActsBy.comp` の 2 回の適用（線型性はその中に埋め込まれている）にまとまる。
-/
import Ising2D.NecSuf.TVActionSandwich
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimTVPlusAction

namespace Ising2D

variable {M : ℕ}

/-- `TVPlus_checkZ_checkY` を必要十分版 `NecSuf.actsBy_TV_sandwich` の特殊化として得たもの。 -/
theorem TVPlus_checkZ_checkY_of_necSuf (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ)
    {s2 : ℝ} (hs2 : 0 < s2)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    ActsBy (TVPlus M hs2 K1 K2star).toLinearMap (checkZ M μ) (checkY M μ)
      (AMat K (thetaTilde M μ)) := by
  have h := NecSuf.actsBy_TV_sandwich (actsBy_TConj_V1plusHalf hM K1 μ)
    (actsBy_TConj_V2H2Form_check hM hs2 K2star μ)
  rwa [factorization_of_A_thetaTilde (M := M) K K1 K2star μ hc1 hs1 hc2star hs2star hdual] at h

end Ising2D
