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

原文は準備で `S := (V_1^{(+)})^{1/2}` と `B_1(θ~)` の第 1 列・第 2 列 `β_1, β_2` を置き、(z)・(y) の各列について
次の 12 行の鎖を書き、最後に 2 列を並べる 8 行の鎖を書く。
Lean の `TVPlus_apply_checkZ`・`TVPlus_apply_checkY` の `calc` の 12 段と、`TVPlus_checkZ_checkY` の `calc` の 8 段が、
それぞれ 1 対 1 に対応する。`β_j` は `fun i => B1mat K1 θ i j`、行列の組と数の列の積は `rowMulCol`、
行列の組と `2×2` 行列の積は `rowMul`、`Mat(2,ℂ)` の元と数の列の積は `Matrix.mulVec`（`*ᵥ`）で書く。

| (z)・(y) の鎖の行と根拠 | Lean |
| --- | --- |
| 1 行目 `def_T_V_plus` | `TVPlus_apply` |
| 2 行目 `T_actions_on_check_Z_Y` の左の等号 | `TConj_V1plusHalf_checkZ`・`_checkY`（位相因子を `checkPhase_one_eq_exp`・`checkPhase_neg_one_eq_exp` で `e^{∓iθ~}` に直す） |
| 3 行目 `β_j` の置き方 | `rfl`（`B1mat` の成分） |
| 4 行目 `linearity_of_T_V2` | `linearity_of_T_V2H2Form` |
| 5 行目 `def_pair_of_matrices_times_column_of_numbers` | `rfl`（`rowMulCol`） |
| 6 行目 `calc_of_TxT_check_Z_Y` の第 2 式 | `actsBy_TConj_V2H2Form_check`（`ActsBy` の 2 式は `rowMul` の 2 成分と定義の展開で一致する） |
| 7 行目 `pair_of_matrices_times_matrix_times_column_associative` | `rowMulCol_rowMul_assoc` |
| 8 行目 `def_pair_of_matrices_times_column_of_numbers` | `rfl` |
| 9 行目 `linearity_of_T_on_check_Z_Y` | `linearity_of_T_V1plusHalf` |
| 10 行目 `def_pair_of_matrices_times_column_of_numbers` | `rfl` |
| 11 行目 `calc_of_TxT_check_Z_Y` の第 1 式 | `actsBy_TConj_V1plusHalf` |
| 12 行目 `pair_of_matrices_times_matrix_times_column_associative` | `rowMulCol_rowMul_assoc` |

| 2 列を並べる鎖の行と根拠 | Lean |
| --- | --- |
| 1 行目 (z)・(y) の鎖 | `TVPlus_apply_checkZ`・`TVPlus_apply_checkY` |
| 2 行目 `mat_mult_associative` を 2 成分へ | `Matrix.mulVec_mulVec` |
| 3 行目 準備の `(A, B)w` の約束（`w` の成分を取る） | `rfl` |
| 4 行目 `mat_mult` を 4 成分へ | `rfl`（`Matrix.mulVec` の成分） |
| 5 行目 `(β_j)_{l1} = (B_1(θ~))_{lj}` | `rfl` |
| 6 行目 `mat_mult` を 4 成分へ | `rfl`（`Matrix.mul` の成分） |
| 7 行目 `def_pair_of_matrices_times_two_by_two_matrix` | `rfl`（`rowMul`） |
| 8 行目 `factorization_of_A_theta_general` | `factorization_of_A_thetaTilde` |

必要十分版との対応は次のとおりである。

| 具体版の行 | 必要十分版（`NecSuf.actsBy_sandwich`） |
| --- | --- |
| (z)・(y) の 1 行目 `def_T_V_plus` | `TV'` が `T_{g_1}∘T_{g_2}∘T_{g_1}` であること（`actsBy_TV_sandwich` が `actsBy_sandwich` へ渡す形） |
| (z)・(y) の 2〜3 行目 `T_actions_on_check_Z_Y`・`β_j` | 内側の `h₁`（`T_1` が `B_1` で作用すること） |
| (z)・(y) の 4〜7 行目（`linearity_of_T_V2`・`calc_of_TxT_check_Z_Y` の第 2 式・組の積の結合律） | 1 回目の `ActsBy'.comp`（`map_add`・`map_smul` が線型性、`hS` が `B_2`） |
| (z)・(y) の 8〜12 行目（`linearity_of_T_on_check_Z_Y`・`calc_of_TxT_check_Z_Y` の第 1 式・組の積の結合律） | 2 回目の `ActsBy'.comp` |
| 2 列を並べる鎖の 1〜7 行目（列を並べて `(B_1 B_2) B_1`） | `actsBy_sandwich` の `mul_assoc` |
| 2 列を並べる鎖の 8 行目 `factorization_of_A_theta_general` | 導出 `TVPlus_checkZ_checkY_of_necSuf` の `factorization_of_A_thetaTilde` |

## 残る仮定について（008 章と同じ）

`IsingConst` の 5 成分が `K_1, K_2^*` の双曲線関数であることと、双対関係の帰結
`hdual : s_2^* c_2 = c_2^*` だけである。いずれも**数学的に必要**で、
未形式化に由来する仮定は無い。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimTActionsOnCheck
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimFactorizationATheta
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionVPlus
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimPairTimesMatrixTimesColumnAssociative

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **原文 `T_V_plus_check_Z_Y` の証明の (z) の鎖**:
`T_{(V^{(+)})}(check(Z)_μ) = (check(Z)_μ, check(Y)_μ)(B_1(θ~)(B_2 β_1))`（`β_1` は `B_1(θ~)` の第 1 列）。 -/
theorem TVPlus_apply_checkZ (hM : M ≠ 0) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℝ) (μ : ℤ) :
    TVPlus M hs2 K1 K2star (checkZ M μ)
      = rowMulCol (checkZ M μ, checkY M μ)
          (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) *ᵥ
            (B2mat K2star *ᵥ fun i => B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) i 0)) := by
  set θ : ℂ := ((thetaTilde M μ : ℝ) : ℂ)
  set β₁ : Fin 2 → ℂ := fun i => B1mat K1 θ i 0
  set T1 := TConj (V1plusHalfUnits M K1)
  set T2 := TConj (V2H2FormUnits M hs2 K2star)
  have h1z : T1 (checkZ M μ) = (rowMul (checkZ M μ, checkY M μ) (B1mat K1 θ)).1 :=
    (actsBy_TConj_V1plusHalf hM K1 μ).1
  have h1y : T1 (checkY M μ) = (rowMul (checkZ M μ, checkY M μ) (B1mat K1 θ)).2 :=
    (actsBy_TConj_V1plusHalf hM K1 μ).2
  have h2z : T2 (checkZ M μ) = (rowMul (checkZ M μ, checkY M μ) (B2mat K2star)).1 :=
    (actsBy_TConj_V2H2Form_check hs2 K2star μ).1
  have h2y : T2 (checkY M μ) = (rowMul (checkZ M μ, checkY M μ) (B2mat K2star)).2 :=
    (actsBy_TConj_V2H2Form_check hs2 K2star μ).2
  calc TVPlus M hs2 K1 K2star (checkZ M μ)
      = T1 (T2 (T1 (checkZ M μ))) := TVPlus_apply hs2 K1 K2star _
                    -- 1 行目: `def_T_V_plus`
    _ = T1 (T2 (Complex.cosh K1 • checkZ M μ
          + (Complex.I * Complex.exp (-θ * Complex.I) * Complex.sinh K1) • checkY M μ)) := by
        rw [TConj_V1plusHalf_checkZ hM K1 μ, checkPhase_one_eq_exp hM μ]
                    -- 2 行目: `T_actions_on_check_Z_Y` の `T_S(Ž_μ)` の式の左の等号
    _ = T1 (T2 (β₁ 0 • checkZ M μ + β₁ 1 • checkY M μ)) := rfl
                    -- 3 行目: `β_1` の置き方
    _ = T1 (β₁ 0 • T2 (checkZ M μ) + β₁ 1 • T2 (checkY M μ)) := by
        rw [linearity_of_T_V2H2Form hs2 K2star (β₁ 0) (β₁ 1) μ]
                    -- 4 行目: `linearity_of_T_V2`
    _ = T1 (rowMulCol (T2 (checkZ M μ), T2 (checkY M μ)) β₁) := rfl
                    -- 5 行目: `def_pair_of_matrices_times_column_of_numbers`
    _ = T1 (rowMulCol (rowMul (checkZ M μ, checkY M μ) (B2mat K2star)) β₁) := by
        rw [h2z, h2y]
                    -- 6 行目: `calc_of_TxT_check_Z_Y` の第 2 式
    _ = T1 (rowMulCol (checkZ M μ, checkY M μ) (B2mat K2star *ᵥ β₁)) := by
        rw [rowMulCol_rowMul_assoc]
                    -- 7 行目: `pair_of_matrices_times_matrix_times_column_associative`
    _ = T1 ((B2mat K2star *ᵥ β₁) 0 • checkZ M μ + (B2mat K2star *ᵥ β₁) 1 • checkY M μ) := rfl
                    -- 8 行目: `def_pair_of_matrices_times_column_of_numbers`
    _ = (B2mat K2star *ᵥ β₁) 0 • T1 (checkZ M μ) + (B2mat K2star *ᵥ β₁) 1 • T1 (checkY M μ) :=
        linearity_of_T_V1plusHalf K1 _ _ μ
                    -- 9 行目: `linearity_of_T_on_check_Z_Y`
    _ = rowMulCol (T1 (checkZ M μ), T1 (checkY M μ)) (B2mat K2star *ᵥ β₁) := rfl
                    -- 10 行目: `def_pair_of_matrices_times_column_of_numbers`
    _ = rowMulCol (rowMul (checkZ M μ, checkY M μ) (B1mat K1 θ)) (B2mat K2star *ᵥ β₁) := by
        rw [h1z, h1y]
                    -- 11 行目: `calc_of_TxT_check_Z_Y` の第 1 式
    _ = rowMulCol (checkZ M μ, checkY M μ) (B1mat K1 θ *ᵥ (B2mat K2star *ᵥ β₁)) :=
        rowMulCol_rowMul_assoc _ _ _ _
                    -- 12 行目: `pair_of_matrices_times_matrix_times_column_associative`

/-- **原文 `T_V_plus_check_Z_Y` の証明の (y) の鎖**:
`T_{(V^{(+)})}(check(Y)_μ) = (check(Z)_μ, check(Y)_μ)(B_1(θ~)(B_2 β_2))`（`β_2` は `B_1(θ~)` の第 2 列）。 -/
theorem TVPlus_apply_checkY (hM : M ≠ 0) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℝ) (μ : ℤ) :
    TVPlus M hs2 K1 K2star (checkY M μ)
      = rowMulCol (checkZ M μ, checkY M μ)
          (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) *ᵥ
            (B2mat K2star *ᵥ fun i => B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) i 1)) := by
  set θ : ℂ := ((thetaTilde M μ : ℝ) : ℂ)
  set β₂ : Fin 2 → ℂ := fun i => B1mat K1 θ i 1
  set T1 := TConj (V1plusHalfUnits M K1)
  set T2 := TConj (V2H2FormUnits M hs2 K2star)
  have h1z : T1 (checkZ M μ) = (rowMul (checkZ M μ, checkY M μ) (B1mat K1 θ)).1 :=
    (actsBy_TConj_V1plusHalf hM K1 μ).1
  have h1y : T1 (checkY M μ) = (rowMul (checkZ M μ, checkY M μ) (B1mat K1 θ)).2 :=
    (actsBy_TConj_V1plusHalf hM K1 μ).2
  have h2z : T2 (checkZ M μ) = (rowMul (checkZ M μ, checkY M μ) (B2mat K2star)).1 :=
    (actsBy_TConj_V2H2Form_check hs2 K2star μ).1
  have h2y : T2 (checkY M μ) = (rowMul (checkZ M μ, checkY M μ) (B2mat K2star)).2 :=
    (actsBy_TConj_V2H2Form_check hs2 K2star μ).2
  calc TVPlus M hs2 K1 K2star (checkY M μ)
      = T1 (T2 (T1 (checkY M μ))) := TVPlus_apply hs2 K1 K2star _
                    -- 1 行目: `def_T_V_plus`
    _ = T1 (T2 ((-Complex.I * Complex.exp (θ * Complex.I) * Complex.sinh K1) • checkZ M μ
          + Complex.cosh K1 • checkY M μ)) := by
        rw [TConj_V1plusHalf_checkY hM K1 μ, checkPhase_neg_one_eq_exp hM μ]
                    -- 2 行目: `T_actions_on_check_Z_Y` の `T_S(Y̌_μ)` の式の左の等号
    _ = T1 (T2 (β₂ 0 • checkZ M μ + β₂ 1 • checkY M μ)) := rfl
                    -- 3 行目: `β_2` の置き方
    _ = T1 (β₂ 0 • T2 (checkZ M μ) + β₂ 1 • T2 (checkY M μ)) := by
        rw [linearity_of_T_V2H2Form hs2 K2star (β₂ 0) (β₂ 1) μ]
                    -- 4 行目: `linearity_of_T_V2`
    _ = T1 (rowMulCol (T2 (checkZ M μ), T2 (checkY M μ)) β₂) := rfl
                    -- 5 行目: `def_pair_of_matrices_times_column_of_numbers`
    _ = T1 (rowMulCol (rowMul (checkZ M μ, checkY M μ) (B2mat K2star)) β₂) := by
        rw [h2z, h2y]
                    -- 6 行目: `calc_of_TxT_check_Z_Y` の第 2 式
    _ = T1 (rowMulCol (checkZ M μ, checkY M μ) (B2mat K2star *ᵥ β₂)) := by
        rw [rowMulCol_rowMul_assoc]
                    -- 7 行目: `pair_of_matrices_times_matrix_times_column_associative`
    _ = T1 ((B2mat K2star *ᵥ β₂) 0 • checkZ M μ + (B2mat K2star *ᵥ β₂) 1 • checkY M μ) := rfl
                    -- 8 行目: `def_pair_of_matrices_times_column_of_numbers`
    _ = (B2mat K2star *ᵥ β₂) 0 • T1 (checkZ M μ) + (B2mat K2star *ᵥ β₂) 1 • T1 (checkY M μ) :=
        linearity_of_T_V1plusHalf K1 _ _ μ
                    -- 9 行目: `linearity_of_T_on_check_Z_Y`
    _ = rowMulCol (T1 (checkZ M μ), T1 (checkY M μ)) (B2mat K2star *ᵥ β₂) := rfl
                    -- 10 行目: `def_pair_of_matrices_times_column_of_numbers`
    _ = rowMulCol (rowMul (checkZ M μ, checkY M μ) (B1mat K1 θ)) (B2mat K2star *ᵥ β₂) := by
        rw [h1z, h1y]
                    -- 11 行目: `calc_of_TxT_check_Z_Y` の第 1 式
    _ = rowMulCol (checkZ M μ, checkY M μ) (B1mat K1 θ *ᵥ (B2mat K2star *ᵥ β₂)) :=
        rowMulCol_rowMul_assoc _ _ _ _
                    -- 12 行目: `pair_of_matrices_times_matrix_times_column_associative`

/-- **章 014 の結論（原文 `T_V_plus_check_Z_Y`）**:

  `(T_{(V^{(+)})}(check(Z)_μ), T_{(V^{(+)})}(check(Y)_μ))
     = (check(Z)_μ, check(Y)_μ) A(θ~_μ)`

行ベクトル記法は `Ising2D.ActsBy`（`B` の**列**が像の係数。`actsBy_iff_rowApply_eq_rowMul` で `rowMul` の等式と同値）。 -/
theorem TVPlus_checkZ_checkY (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℝ)
    {s2 : ℝ} (hs2 : 0 < s2)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    ActsBy (TVPlus M hs2 K1 K2star).toLinearMap (checkZ M μ) (checkY M μ)
      (AMat K (thetaTilde M μ)) := by
  set θ : ℂ := ((thetaTilde M μ : ℝ) : ℂ)
  set B1 := B1mat K1 θ
  set B2 := B2mat K2star
  set β₁ : Fin 2 → ℂ := fun i => B1 i 0
  set β₂ : Fin 2 → ℂ := fun i => B1 i 1
  have hpair : rowApply (TVPlus M hs2 K1 K2star).toLinearMap (checkZ M μ, checkY M μ)
      = rowMul (checkZ M μ, checkY M μ) (AMat K (thetaTilde M μ)) :=
    calc rowApply (TVPlus M hs2 K1 K2star).toLinearMap (checkZ M μ, checkY M μ)
        = (rowMulCol (checkZ M μ, checkY M μ) (B1 *ᵥ (B2 *ᵥ β₁)),
            rowMulCol (checkZ M μ, checkY M μ) (B1 *ᵥ (B2 *ᵥ β₂))) := by
          show (TVPlus M hs2 K1 K2star (checkZ M μ), TVPlus M hs2 K1 K2star (checkY M μ)) = _
          rw [TVPlus_apply_checkZ hM hs2 K1 K2star μ, TVPlus_apply_checkY hM hs2 K1 K2star μ]
                    -- 1 行目: (z)・(y) の鎖
      _ = (rowMulCol (checkZ M μ, checkY M μ) ((B1 * B2) *ᵥ β₁),
            rowMulCol (checkZ M μ, checkY M μ) ((B1 * B2) *ᵥ β₂)) := by
          rw [Matrix.mulVec_mulVec, Matrix.mulVec_mulVec]
                    -- 2 行目: `mat_mult_associative` を 2 成分へ同時適用
      _ = (rowMulCol (checkZ M μ, checkY M μ) (fun i => ((B1 * B2) *ᵥ β₁) i),
            rowMulCol (checkZ M μ, checkY M μ) (fun i => ((B1 * B2) *ᵥ β₂) i)) := rfl
                    -- 3 行目: 準備の `(A, B)w` の約束（`w` の成分を取る）を 2 成分へ同時適用
      _ = (rowMulCol (checkZ M μ, checkY M μ) (fun i => ∑ l, (B1 * B2) i l * β₁ l),
            rowMulCol (checkZ M μ, checkY M μ) (fun i => ∑ l, (B1 * B2) i l * β₂ l)) := rfl
                    -- 4 行目: `mat_mult` を 4 成分へ同時適用
      _ = (rowMulCol (checkZ M μ, checkY M μ) (fun i => ∑ l, (B1 * B2) i l * B1 l 0),
            rowMulCol (checkZ M μ, checkY M μ) (fun i => ∑ l, (B1 * B2) i l * B1 l 1)) := rfl
                    -- 5 行目: `(β_j)_{l1} = (B_1(θ~))_{lj}`
      _ = (rowMulCol (checkZ M μ, checkY M μ) (fun i => (B1 * B2 * B1) i 0),
            rowMulCol (checkZ M μ, checkY M μ) (fun i => (B1 * B2 * B1) i 1)) := rfl
                    -- 6 行目: `mat_mult` を 4 成分へ同時適用
      _ = rowMul (checkZ M μ, checkY M μ) (B1 * B2 * B1) := rfl
                    -- 7 行目: `def_pair_of_matrices_times_two_by_two_matrix`
      _ = rowMul (checkZ M μ, checkY M μ) (AMat K (thetaTilde M μ)) := by
          rw [factorization_of_A_thetaTilde (M := M) K K1 K2star μ hc1 hs1 hc2star hs2star hdual]
                    -- 8 行目: `factorization_of_A_theta_general`（`θ → θ~_μ`）
  exact actsBy_iff_rowApply_eq_rowMul.2 hpair

/-- 上を成分の形（原文の 2 本の等式）で書いた版。 -/
theorem TVPlus_checkZ_checkY_components (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℝ)
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
