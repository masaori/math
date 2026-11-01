/-
# 具体版: `T_{(V^{(+)})}` の `check(Z), check(Y)` への作用（**章 014 の結論**）

対応する人手証明のラベル: **`T_V_plus_check_Z_Y`**
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensectorT_010_claim_T_V_plus_action`）

**必要十分版**は `Ising2D/NecSuf/TVActionSandwich.lean` の
`Ising2D.NecSuf.actsBy_TV_sandwich`（3 つの共役の合成が `B_1 B_2 B_1` で作用すること。
ℂ 上の任意の加群と ℂ 線型写像で成り立つ）。本ファイルの主張がその特殊化として得られることは
`EigenvalueProblem/ReductionToATheta/ClaimTVPlusActionFromNecSuf.lean` に書いた。

## 原文の主張

  `(T_{(V^{(+)})}(check(Z)_μ), T_{(V^{(+)})}(check(Y)_μ))
     = (check(Z)_μ, check(Y)_μ) A(θ~_μ)`,  `θ~_μ = 2π(μ - 1/2)/M`

## 証明の骨格（原文との対応）

原文は (z)・(y) の各列について次の 6 行の鎖を書き、2 列を並べて `factorization_of_A_theta_general` を当てる。
Lean の `TVPlus_apply_checkZ`・`TVPlus_apply_checkY` の `calc` の各行がこの 6 行に 1 対 1 に対応する。

| 人手の行の根拠 | Lean |
| --- | --- |
| `def_T_V_plus` | `TVPlus_apply` |
| `T_actions_on_check_Z_Y` | `TConj_V1plusHalf_checkZ`・`_checkY`（位相因子を `checkPhase_one_eq_exp`・`checkPhase_neg_one_eq_exp` で `e^{∓iθ~}` に直す） |
| `linearity_of_T_V2` | `linearity_of_T_V2H2Form` |
| `calc_of_TxT_check_Z_Y`（`B_2`） | `actsBy_TConj_V2H2Form_check` |
| `linearity_of_T_on_check_Z_Y` | `linearity_of_T_V1plusHalf` |
| `calc_of_TxT_check_Z_Y`（`B_1(θ~)`） | `actsBy_TConj_V1plusHalf` |

必要十分版との対応は次のとおりである。

| 具体版の行（`TVPlus_apply_checkZ`・`_checkY`・`TVPlus_checkZ_checkY`） | 必要十分版（`NecSuf.actsBy_sandwich`） |
| --- | --- |
| 1 行目 `def_T_V_plus` | `TV` が `T_{g_1}∘T_{g_2}∘T_{g_1}` であること（`actsBy_TV_sandwich` が `actsBy_sandwich` へ渡す形） |
| 2 行目 `T_actions_on_check_Z_Y` | 内側の `h₁`（`T_1` が `B_1` で作用すること） |
| 3〜4 行目 `linearity_of_T_V2`・`calc_of_TxT_check_Z_Y`（`B_2`） | 1 回目の `ActsBy.comp`（`map_add`・`map_smul` が線型性、`hS` が `B_2`） |
| 5〜6 行目 `linearity_of_T_on_check_Z_Y`・`calc_of_TxT_check_Z_Y`（`B_1(θ~)`） | 2 回目の `ActsBy.comp` |
| 最後の鎖の 1 行目（列を並べて `B_1 B_2 B_1`） | `actsBy_sandwich` の `mul_assoc` |
| 最後の鎖の 2 行目 `factorization_of_A_theta_general` | 導出 `TVPlus_checkZ_checkY_of_necSuf` の `factorization_of_A_thetaTilde` |

行ベクトルと列ベクトルの積 `(check(Z)_μ, check(Y)_μ) v` は `v 0 • check(Z)_μ + v 1 • check(Y)_μ`、
行列と列ベクトルの積は `Matrix.mulVec` で書く。
最後の 2 行（`TVPlus_checkZ_checkY`）は、(z)・(y) の列ベクトルが `def_B1_theta_B2` の `B_1(θ~)` の第 1 列・第 2 列であること
（`B1mat_col_zero`・`B1mat_col_one`）で `B_1(θ~) B_2 B_1(θ~)` にまとめ、`factorization_of_A_theta_general`
（`factorization_of_A_thetaTilde`）で `A(θ~_μ)` へ移す。

## 残る仮定について（008 章と同じ）

`IsingConst` の 5 成分が `K_1, K_2^*` の双曲線関数であることと、双対関係の帰結
`hdual : s_2^* c_2 = c_2^*` だけである。いずれも**数学的に必要**で、
未形式化に由来する仮定は無い。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimTActionsOnCheck
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimFactorizationATheta
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionVPlus

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- `def_B1_theta_B2` の `B_1(θ)` の第 1 列 `(cosh K_1, i e^{-iθ} sinh K_1)`。 -/
theorem B1mat_col_zero (K1 θ : ℂ) :
    ![Complex.cosh K1, Complex.I * Complex.exp (-θ * Complex.I) * Complex.sinh K1]
      = fun i => B1mat K1 θ i 0 := by
  ext i; fin_cases i <;> rfl

/-- `def_B1_theta_B2` の `B_1(θ)` の第 2 列 `(-i e^{iθ} sinh K_1, cosh K_1)`。 -/
theorem B1mat_col_one (K1 θ : ℂ) :
    ![-Complex.I * Complex.exp (θ * Complex.I) * Complex.sinh K1, Complex.cosh K1]
      = fun i => B1mat K1 θ i 1 := by
  ext i; fin_cases i <;> rfl

/-- **原文 `T_V_plus_check_Z_Y` の証明の (z) の鎖**:
`T_{(V^{(+)})}(check(Z)_μ) = (check(Z)_μ, check(Y)_μ) B_1(θ~) B_2 (cosh K_1, i e^{-iθ~} sinh K_1)^T`。 -/
theorem TVPlus_apply_checkZ (hM : M ≠ 0) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) (μ : ℤ) :
    TVPlus M hs2 K1 K2star (checkZ M μ)
      = (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) *ᵥ (B2mat K2star *ᵥ
            ![Complex.cosh K1,
              Complex.I * Complex.exp (-((thetaTilde M μ : ℝ) : ℂ) * Complex.I) * Complex.sinh K1])) 0
          • checkZ M μ
        + (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) *ᵥ (B2mat K2star *ᵥ
            ![Complex.cosh K1,
              Complex.I * Complex.exp (-((thetaTilde M μ : ℝ) : ℂ) * Complex.I) * Complex.sinh K1])) 1
          • checkY M μ := by
  set θ : ℂ := ((thetaTilde M μ : ℝ) : ℂ)
  set v : Fin 2 → ℂ := ![Complex.cosh K1, Complex.I * Complex.exp (-θ * Complex.I) * Complex.sinh K1]
  set T1 := TConj (V1plusHalfUnits M K1)
  set T2 := TConj (V2H2FormUnits M hs2 K2star)
  have h1z : T1 (checkZ M μ) = B1mat K1 θ 0 0 • checkZ M μ + B1mat K1 θ 1 0 • checkY M μ :=
    (actsBy_TConj_V1plusHalf hM K1 μ).1
  have h1y : T1 (checkY M μ) = B1mat K1 θ 0 1 • checkZ M μ + B1mat K1 θ 1 1 • checkY M μ :=
    (actsBy_TConj_V1plusHalf hM K1 μ).2
  have h2z : T2 (checkZ M μ) = B2mat K2star 0 0 • checkZ M μ + B2mat K2star 1 0 • checkY M μ :=
    (actsBy_TConj_V2H2Form_check hs2 K2star μ).1
  have h2y : T2 (checkY M μ) = B2mat K2star 0 1 • checkZ M μ + B2mat K2star 1 1 • checkY M μ :=
    (actsBy_TConj_V2H2Form_check hs2 K2star μ).2
  calc TVPlus M hs2 K1 K2star (checkZ M μ)
      -- `def_T_V_plus`
      = T1 (T2 (T1 (checkZ M μ))) := TVPlus_apply hs2 K1 K2star _
      -- `T_actions_on_check_Z_Y`
    _ = T1 (T2 (v 0 • checkZ M μ + v 1 • checkY M μ)) := by
        rw [TConj_V1plusHalf_checkZ hM K1 μ, checkPhase_one_eq_exp hM μ]; rfl
      -- `linearity_of_T_V2`
    _ = T1 (v 0 • T2 (checkZ M μ) + v 1 • T2 (checkY M μ)) := by
        rw [linearity_of_T_V2H2Form hs2 K2star (v 0) (v 1) μ]
      -- `calc_of_TxT_check_Z_Y`（`B_2`）
    _ = T1 ((B2mat K2star *ᵥ v) 0 • checkZ M μ + (B2mat K2star *ᵥ v) 1 • checkY M μ) := by
        rw [h2z, h2y]
        congr 1
        simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_two]
        module
      -- `linearity_of_T_on_check_Z_Y`
    _ = (B2mat K2star *ᵥ v) 0 • T1 (checkZ M μ) + (B2mat K2star *ᵥ v) 1 • T1 (checkY M μ) :=
        linearity_of_T_V1plusHalf K1 _ _ μ
      -- `calc_of_TxT_check_Z_Y`（`B_1(θ~)`）
    _ = (B1mat K1 θ *ᵥ (B2mat K2star *ᵥ v)) 0 • checkZ M μ
          + (B1mat K1 θ *ᵥ (B2mat K2star *ᵥ v)) 1 • checkY M μ := by
        rw [h1z, h1y]
        simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_two]
        module

/-- **原文 `T_V_plus_check_Z_Y` の証明の (y) の鎖**:
`T_{(V^{(+)})}(check(Y)_μ) = (check(Z)_μ, check(Y)_μ) B_1(θ~) B_2 (-i e^{iθ~} sinh K_1, cosh K_1)^T`。 -/
theorem TVPlus_apply_checkY (hM : M ≠ 0) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) (μ : ℤ) :
    TVPlus M hs2 K1 K2star (checkY M μ)
      = (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) *ᵥ (B2mat K2star *ᵥ
            ![-Complex.I * Complex.exp (((thetaTilde M μ : ℝ) : ℂ) * Complex.I) * Complex.sinh K1,
              Complex.cosh K1])) 0
          • checkZ M μ
        + (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) *ᵥ (B2mat K2star *ᵥ
            ![-Complex.I * Complex.exp (((thetaTilde M μ : ℝ) : ℂ) * Complex.I) * Complex.sinh K1,
              Complex.cosh K1])) 1
          • checkY M μ := by
  set θ : ℂ := ((thetaTilde M μ : ℝ) : ℂ)
  set v : Fin 2 → ℂ := ![-Complex.I * Complex.exp (θ * Complex.I) * Complex.sinh K1, Complex.cosh K1]
  set T1 := TConj (V1plusHalfUnits M K1)
  set T2 := TConj (V2H2FormUnits M hs2 K2star)
  have h1z : T1 (checkZ M μ) = B1mat K1 θ 0 0 • checkZ M μ + B1mat K1 θ 1 0 • checkY M μ :=
    (actsBy_TConj_V1plusHalf hM K1 μ).1
  have h1y : T1 (checkY M μ) = B1mat K1 θ 0 1 • checkZ M μ + B1mat K1 θ 1 1 • checkY M μ :=
    (actsBy_TConj_V1plusHalf hM K1 μ).2
  have h2z : T2 (checkZ M μ) = B2mat K2star 0 0 • checkZ M μ + B2mat K2star 1 0 • checkY M μ :=
    (actsBy_TConj_V2H2Form_check hs2 K2star μ).1
  have h2y : T2 (checkY M μ) = B2mat K2star 0 1 • checkZ M μ + B2mat K2star 1 1 • checkY M μ :=
    (actsBy_TConj_V2H2Form_check hs2 K2star μ).2
  calc TVPlus M hs2 K1 K2star (checkY M μ)
      -- `def_T_V_plus`
      = T1 (T2 (T1 (checkY M μ))) := TVPlus_apply hs2 K1 K2star _
      -- `T_actions_on_check_Z_Y`
    _ = T1 (T2 (v 0 • checkZ M μ + v 1 • checkY M μ)) := by
        rw [TConj_V1plusHalf_checkY hM K1 μ, checkPhase_neg_one_eq_exp hM μ]; rfl
      -- `linearity_of_T_V2`
    _ = T1 (v 0 • T2 (checkZ M μ) + v 1 • T2 (checkY M μ)) := by
        rw [linearity_of_T_V2H2Form hs2 K2star (v 0) (v 1) μ]
      -- `calc_of_TxT_check_Z_Y`（`B_2`）
    _ = T1 ((B2mat K2star *ᵥ v) 0 • checkZ M μ + (B2mat K2star *ᵥ v) 1 • checkY M μ) := by
        rw [h2z, h2y]
        congr 1
        simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_two]
        module
      -- `linearity_of_T_on_check_Z_Y`
    _ = (B2mat K2star *ᵥ v) 0 • T1 (checkZ M μ) + (B2mat K2star *ᵥ v) 1 • T1 (checkY M μ) :=
        linearity_of_T_V1plusHalf K1 _ _ μ
      -- `calc_of_TxT_check_Z_Y`（`B_1(θ~)`）
    _ = (B1mat K1 θ *ᵥ (B2mat K2star *ᵥ v)) 0 • checkZ M μ
          + (B1mat K1 θ *ᵥ (B2mat K2star *ᵥ v)) 1 • checkY M μ := by
        rw [h1z, h1y]
        simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_two]
        module

/-- `B_1 (B_2 (B_1 の第 j 列)) = (B_1 B_2 B_1) の第 j 列`（行列の積の定義）。 -/
theorem mulVec_mulVec_col (B1 B2 : Matrix (Fin 2) (Fin 2) ℂ) (j : Fin 2) :
    (B1 *ᵥ (B2 *ᵥ fun i => B1 i j)) = fun i => (B1 * B2 * B1) i j := by
  ext i
  simp only [Matrix.mulVec, dotProduct, Matrix.mul_apply, Fin.sum_univ_two]
  ring

/-- **章 014 の結論（原文 `T_V_plus_check_Z_Y`）**:

  `(T_{(V^{(+)})}(check(Z)_μ), T_{(V^{(+)})}(check(Y)_μ))
     = (check(Z)_μ, check(Y)_μ) A(θ~_μ)`

行ベクトル記法は `Ising2D.ActsBy`（`B` の**列**が像の係数）。 -/
theorem TVPlus_checkZ_checkY (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ)
    {s2 : ℝ} (hs2 : 0 < s2)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    ActsBy (TVPlus M hs2 K1 K2star).toLinearMap (checkZ M μ) (checkY M μ)
      (AMat K (thetaTilde M μ)) := by
  set θ : ℂ := ((thetaTilde M μ : ℝ) : ℂ)
  -- (z), (y) の鎖と `def_B1_theta_B2`（列ベクトルは `B_1(θ~)` の第 1 列・第 2 列）
  have hB : ActsBy (TVPlus M hs2 K1 K2star).toLinearMap (checkZ M μ) (checkY M μ)
      (B1mat K1 θ * B2mat K2star * B1mat K1 θ) := by
    constructor
    · change TVPlus M hs2 K1 K2star (checkZ M μ) = _
      rw [TVPlus_apply_checkZ hM hs2 K1 K2star μ, B1mat_col_zero, mulVec_mulVec_col]
    · change TVPlus M hs2 K1 K2star (checkY M μ) = _
      rw [TVPlus_apply_checkY hM hs2 K1 K2star μ, B1mat_col_one, mulVec_mulVec_col]
  -- `factorization_of_A_theta_general`
  rwa [factorization_of_A_thetaTilde (M := M) K K1 K2star μ hc1 hs1 hc2star hs2star hdual] at hB

/-- 上を成分の形（原文の 2 本の等式）で書いた版。 -/
theorem TVPlus_checkZ_checkY_components (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ)
    {s2 : ℝ} (hs2 : 0 < s2)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    TVPlus M hs2 K1 K2star (checkZ M μ)
        = AMat K (thetaTilde M μ) 0 0 • checkZ M μ
          + AMat K (thetaTilde M μ) 1 0 • checkY M μ
      ∧ TVPlus M hs2 K1 K2star (checkY M μ)
        = AMat K (thetaTilde M μ) 0 1 • checkZ M μ
          + AMat K (thetaTilde M μ) 1 1 • checkY M μ :=
  TVPlus_checkZ_checkY hM K μ K1 K2star hs2 hc1 hs1 hc2star hs2star hdual

end Ising2D
