/-
# `!![g, a; -b, g]` 型の 2×2 行列の固有値・固有ベクトル・対角化（**必要十分版**）

対応する人手証明のラベル: `eigenvector_of_A_theta_tilde`, `diagonalization_check_P_D`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_004_claim_eigenvector`, `Athetatilde_005_claim_diagonalization`）

具体版: `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimEigenATildeDiag.lean`。
具体版をこのファイルの特殊化として導く定理は
`Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimEigenATildeDiagFromNecSuf.lean` にある。
（整数運動量の経路の記録 `Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimEigenvectorsAndDiagonalizationOfATheta.lean` の `AMat_mulVec_eigen` 等も同じ形の主張である）。

## 具体版との手順の対応

具体版の略記 `g_1 := γ_1(θ)`、`a := γ_2(θ)`、`b := γ_2(-θ)`、`r := |a|` を、ここでは `g, a, b, s` と書く。

* `eigenvector_of_A_theta_tilde` Step 1:
  準備の因数分解の恒等式 `factor_identity_thetaTilde` ↔ `skew2_factor_identity`、
  `det(A(θ) - λI)` の鎖 `charPoly_factor_thetaTilde` ↔ `skew2_charPoly`（`ab = -r^2` を代入する行の手前まで）と
  `skew2_charPoly_factor`（`ab = -s^2` の代入と準備の恒等式の 2 行）、
  零因子が無いことによる `det_AMat_sub_smul_eq_zero_iff` ↔ `skew2_det_eq_zero_iff`、
  固有値の定義から `λ = g ± s` までの同値の鎖 `eigenvalue_AMat_iff` ↔ `skew2_eigenvalue_iff`
  （鎖のうち「0 でないベクトルを 0 へ送る ⟺ 行列式 0」の段は `NecSuf/TwoByTwoKernelAndDeterminant.lean` の
  `exists_ne_zero_mulVec_eq_zero_iff_det`、2〜5 段は `NecSuf/MatrixVectorIdentityScalarDifference.lean` の
  `sub_eq_zero_iff_vec`・`one_mulVec_eq`・`smul_mulVec_eq'`・`sub_mulVec_eq'`）、末尾の `λ_+ ≠ λ_-` の `lambdaPlusR_ne_lambdaMinusR` ↔ `skew2_eigenvalues_ne`。
* `eigenvector_of_A_theta_tilde` Step 2: 成分ごとの鎖 `AMat_mulVec_eigen_pos`・`AMat_mulVec_eigen_neg` ↔
  `skew2_mulVec_pos`・`skew2_mulVec_neg`、`c` 倍の鎖 `AMat_mulVec_smul_eigen_pos`・`AMat_mulVec_smul_eigen_neg` ↔
  `mulVec_smul_of_mulVec_eq`。
* `diagonalization_check_P_D` Step 2: 列ごとに見た `A P̌ = P̌ Ď` の `AMat_mul_checkPmat` ↔ `skew2_mul_of_cols`。
* `diagonalization_check_P_D` Step 3: `det P̌_μ` の鎖 `det_checkPmat` と `det_checkPmat_ne_zero` ↔ `det_of_cols`・`det_of_cols_ne_zero`
  （具体版は `c = 1/(2√M b)` を代入した成分で計算し、必要十分版は列を `c(∓s, b)` のまま計算する）。
* `diagonalization_check_P_D` Step 4: `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv` ↔ `eq_conj_of_mul_eq`。
* 必要十分版を置かない段: Step 2 の `v_± ≠ 0`（第 2 成分が `b ≠ 0` であることの 1 行）と、
  `diagonalization_check_P_D` Step 1・Step 2 の `√M ≠ 0` と `c b = 1/(2√M)`（`c` を具体的に選んだことの確認）。
  前者は取り払える構造が無く、後者は `c` の具体形に関する計算で、必要十分版の `c` は任意の元である。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

効いているのは

* **行列が `!![g, a; -b, g]` の形（対角成分が等しい）であること**
* **`a b = -s^2` を満たす `s` が係数環に取れること**
* 固有値が `g ± s` に限るという段（`skew2_det_eq_zero_iff`・`skew2_eigenvalue_iff`）と `det P ≠ 0` の段だけは、
  **係数環に零因子が無いこと**（`skew2_eigenvalue_iff` はさらに `0 ≠ 1`）
* 2 つの固有値が異なること（`skew2_eigenvalues_ne`）と `det P ≠ 0` には、**`2 s ≠ 0`**
  （具体版は `r > 0` という実数の順序を使うが、効いているのは `2 s ≠ 0` だけである。
  標数 2 の環、例えば `ZMod 2` で `g = 0`、`a = b = s = 1` とすると `ab = -s^2` なのに `g + s = g - s` となり、
  `P` の 2 列も一致して対角化できない）

だけである。**係数は任意の可換環でよい。** 複素数であることも、`γ_1` が実数であることも、
`γ_2` の具体形も、`θ` が半整数運動量であることも、`|γ_2|` が絶対値であることも効いていない。
人手証明が `√(-γ_2γ_2(-θ))` として導入する量は、ここでは「`a b = -s^2` を満たす元 `s`」
という仮定だけに退化する（分岐の選択は `s` と `-s` の交換にすぎない）。

具体版の Step 2 と比べて分かること:

* 第 1 成分の鎖で具体版は `b = -ā`（`relation_of_gamma_2_theta_tilde` (1)）と `a ā = r^2`（`abs_basic_properties`）の 2 段を経るが、
  効いているのはその合成 `a b = -r^2` だけである（`skew2_mulVec_pos` の第 1 成分は `a b = -s^2` の 1 段）。
  共役も絶対値も効いていない。
* 第 2 成分の鎖は**仮定を何も使わずに環の計算だけで閉じる**（`(-b)(∓s) + g b = (g ± s) b`）。
  `b = -ā` は固有ベクトルであることの第 2 成分に効いていない。人手証明・具体版の第 2 成分も
  同じ 6 行（`b` のまま括り出す）である。

対角化 `A = P D P⁻¹` については、可逆性（`det P` が単元であること）が別途要る。
人手証明 `diagonalization_check_P_D` は Step 3 で `det P̌_μ ≠ 0` を確かめており、
必要十分版ではそれが `IsUnit P.det` の仮定として明示される。
-/
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.FinCases
import Ising2D.NecSuf.TwoByTwoKernelAndDeterminant
import Ising2D.NecSuf.MatrixVectorIdentityScalarDifference

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*} [CommRing R]

/-- **Step 1 の準備**（具体版 `factor_identity_thetaTilde`）: 因数分解の恒等式
`(λ - (g+s))(λ - (g-s)) = λ^2 - 2gλ + (g^2 - s^2)`。**任意の可換環**で成り立つ。 -/
theorem skew2_factor_identity (g s lam : R) :
    (lam - (g + s)) * (lam - (g - s)) = lam ^ 2 - 2 * g * lam + (g ^ 2 - s ^ 2) :=
  calc (lam - (g + s)) * (lam - (g - s))
      = lam ^ 2 - (g - s) * lam - (g + s) * lam + (g + s) * (g - s) := by ring  -- 分配則
    _ = lam ^ 2 - 2 * g * lam + (g + s) * (g - s) := by ring                     -- 同類項の統合
    _ = lam ^ 2 - 2 * g * lam + (g ^ 2 - g * s + s * g - s ^ 2) := by ring      -- 分配則
    _ = lam ^ 2 - 2 * g * lam + (g ^ 2 - s ^ 2) := by ring                       -- 可換則と加法逆元

/-- **Step 1 の `det(A - λI)` の鎖**（具体版 `charPoly_factor_thetaTilde` の、`ab = -r^2` を代入する行の手前まで）。
**任意の可換環**で成り立つ。 -/
theorem skew2_charPoly (g a b lam : R) :
    (!![g, a; -b, g] - lam • (1 : Matrix (Fin 2) (Fin 2) R)).det
      = lam ^ 2 - 2 * g * lam + (g ^ 2 + a * b) :=
  calc (!![g, a; -b, g] - lam • (1 : Matrix (Fin 2) (Fin 2) R)).det
      = (!![(!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 0 - (lam • (1 : Matrix (Fin 2) (Fin 2) R)) 0 0,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 1 - (lam • (1 : Matrix (Fin 2) (Fin 2) R)) 0 1;
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 0 - (lam • (1 : Matrix (Fin 2) (Fin 2) R)) 1 0,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 1 - (lam • (1 : Matrix (Fin 2) (Fin 2) R)) 1 1] :
            Matrix (Fin 2) (Fin 2) R).det := by
        rw [Matrix.eta_fin_two (!![g, a; -b, g] - lam • (1 : Matrix (Fin 2) (Fin 2) R))]
        simp only [Matrix.sub_apply]                                       -- 差の定義
    _ = (!![(!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 0 - lam * (1 : Matrix (Fin 2) (Fin 2) R) 0 0,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 1 - lam * (1 : Matrix (Fin 2) (Fin 2) R) 0 1;
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 0 - lam * (1 : Matrix (Fin 2) (Fin 2) R) 1 0,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 1 - lam * (1 : Matrix (Fin 2) (Fin 2) R) 1 1] :
            Matrix (Fin 2) (Fin 2) R).det := by
        simp only [Matrix.smul_apply, smul_eq_mul]                         -- スカラー倍の定義
    _ = (!![(!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 0 - lam * (if (0 : Fin 2) = 0 then 1 else 0),
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 1 - lam * (if (0 : Fin 2) = 1 then 1 else 0);
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 0 - lam * (if (1 : Fin 2) = 0 then 1 else 0),
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 1 - lam * (if (1 : Fin 2) = 1 then 1 else 0)] :
            Matrix (Fin 2) (Fin 2) R).det := by
        simp only [Matrix.one_apply]                                       -- 単位行列の成分 `δ_{ij}`
    _ = (!![(!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 0 - lam * 1,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 1 - lam * 0;
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 0 - lam * 0,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 1 - lam * 1] : Matrix (Fin 2) (Fin 2) R).det := by
        rw [if_pos rfl, if_pos rfl, if_neg (by decide), if_neg (by decide)]  -- `δ` の値
    _ = (!![(!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 0 - lam,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 1 - lam * 0;
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 0 - lam * 0,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 1 - lam] : Matrix (Fin 2) (Fin 2) R).det := by
        simp only [mul_one]                                                -- `x·1 = x`
    _ = (!![(!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 0 - lam,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 1 - 0;
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 0 - 0,
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 1 - lam] : Matrix (Fin 2) (Fin 2) R).det := by
        simp only [mul_zero]                                               -- `x·0 = 0`
    _ = (!![(!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 0 - lam, (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 0 1;
            (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 0, (!![g, a; -b, g] : Matrix (Fin 2) (Fin 2) R) 1 1 - lam] :
            Matrix (Fin 2) (Fin 2) R).det := by
        simp only [sub_zero]                                               -- `y - 0 = y`
    _ = (!![g - lam, a; -b, g - lam] : Matrix (Fin 2) (Fin 2) R).det := rfl  -- `!![g, a; -b, g]` の成分
    _ = (g - lam) * (g - lam) - a * (-b) := Matrix.det_fin_two_of _ _ _ _  -- 行列式の定義
    _ = (g - lam) * (g - lam) + a * b := by ring                           -- 環の四則
    _ = g ^ 2 - g * lam - lam * g + lam ^ 2 + a * b := by ring              -- 分配則
    _ = g ^ 2 - g * lam - g * lam + lam ^ 2 + a * b := by ring              -- 乗法の可換則
    _ = g ^ 2 - 2 * g * lam + lam ^ 2 + a * b := by ring                     -- 同類項の統合
    _ = lam ^ 2 - 2 * g * lam + (g ^ 2 + a * b) := by ring                   -- 加法の交換則と結合則

/-- **Step 1 の `det(A - λI)` の鎖の残り 2 行**（具体版 `charPoly_factor_thetaTilde` の最後の 2 行）:
`a b = -s^2` なら `λ^2 - 2gλ + (g^2 + ab) = (λ - (g+s))(λ - (g-s))`。 -/
theorem skew2_charPoly_factor (g a b s lam : R) (hab : a * b = -s ^ 2) :
    lam ^ 2 - 2 * g * lam + (g ^ 2 + a * b)
      = (lam - (g + s)) * (lam - (g - s)) :=
  calc lam ^ 2 - 2 * g * lam + (g ^ 2 + a * b)
      = lam ^ 2 - 2 * g * lam + (g ^ 2 - s ^ 2) := by rw [hab, ← sub_eq_add_neg]  -- `ab = -s^2`
    _ = (lam - (g + s)) * (lam - (g - s)) := (skew2_factor_identity g s lam).symm  -- 準備の恒等式

/-- **Step 1 の結論**（具体版 `det_AMat_sub_smul_eq_zero_iff`）: `det(A - λI) = 0` となるのは `λ = g ± s` のときに限る。

`NoZeroDivisors R` は「積が `0` なら因子のどちらかが `0`」の段（`mul_eq_zero`）にだけ使う。
これを外すと「⇒」が通らない（例えば `ℤ/8ℤ` で `g = a = b = s = 0` とすると、`λ = 4` は
`λ^2 = 0` を満たすが `λ = g ± s = 0` ではない）。「⇐」はこの仮定なしで成り立つ。 -/
theorem skew2_det_eq_zero_iff [NoZeroDivisors R] (g a b s lam : R) (hab : a * b = -s ^ 2) :
    (!![g, a; -b, g] - lam • (1 : Matrix (Fin 2) (Fin 2) R)).det = 0
      ↔ lam = g + s ∨ lam = g - s := by
  rw [skew2_charPoly, skew2_charPoly_factor g a b s lam hab, mul_eq_zero, sub_eq_zero, sub_eq_zero]

/-- **Step 1 の主張**（具体版 `eigenvalue_AMat_iff`）: `λ` が `!![g, a; -b, g]` の固有値である
（`A v = λ v` となる `v ≠ 0` がある）のは `λ = g ± s` のときに限る。具体版と同じ同値の鎖を辿る。

`NoZeroDivisors R` は、鎖の `exists_ne_zero_mulVec_eq_zero_iff_det` の「⇒」と `skew2_det_eq_zero_iff` の 2 箇所で効く。
`Nontrivial R`（`0 ≠ 1`）は「⇐」で `v ≠ 0` の `v` を作る段（`exists_ne_zero_mulVec_eq_zero_iff_det`）にだけ使う。
零環では `0 ≠ v` となる `v` が無く、どの `λ` も固有値にならない。 -/
theorem skew2_eigenvalue_iff [NoZeroDivisors R] [Nontrivial R] (g a b s lam : R) (hab : a * b = -s ^ 2) :
    (∃ v : Fin 2 → R, v ≠ 0 ∧ !![g, a; -b, g] *ᵥ v = lam • v) ↔ lam = g + s ∨ lam = g - s :=
  calc (∃ v : Fin 2 → R, v ≠ 0 ∧ !![g, a; -b, g] *ᵥ v = lam • v)
      ↔ ∃ v : Fin 2 → R, v ≠ 0 ∧ !![g, a; -b, g] *ᵥ v - lam • v = 0 := by
        simp only [sub_eq_zero_iff_vec]                                 -- `A - B = O ⟺ A = B`（数ベクトル）
    _ ↔ ∃ v : Fin 2 → R, v ≠ 0 ∧ !![g, a; -b, g] *ᵥ v - lam • ((1 : Matrix (Fin 2) (Fin 2) R) *ᵥ v) = 0 := by
        simp only [one_mulVec_eq]                                       -- `Iv = v`
    _ ↔ ∃ v : Fin 2 → R, v ≠ 0 ∧ !![g, a; -b, g] *ᵥ v - (lam • (1 : Matrix (Fin 2) (Fin 2) R)) *ᵥ v = 0 := by
        simp only [← smul_mulVec_eq']                                   -- `λ(Iv) = (λI)v`
    _ ↔ ∃ v : Fin 2 → R, v ≠ 0 ∧ (!![g, a; -b, g] - lam • (1 : Matrix (Fin 2) (Fin 2) R)) *ᵥ v = 0 := by
        simp only [sub_mulVec_eq']                                      -- `Av - Bv = (A - B)v`
    _ ↔ (!![g, a; -b, g] - lam • (1 : Matrix (Fin 2) (Fin 2) R)).det = 0 :=
        exists_ne_zero_mulVec_eq_zero_iff_det _                         -- 0 でないベクトルを 0 へ送る ⟺ 行列式 0
    _ ↔ lam = g + s ∨ lam = g - s :=
        skew2_det_eq_zero_iff g a b s lam hab                           -- 因数分解と零因子が無いこと

/-- **Step 1 の末尾**（具体版 `lambdaPlusR_ne_lambdaMinusR`）: `2 s ≠ 0` なら `g + s ≠ g - s`。
具体版は `r > 0` と実数の順序を使うが、効いているのは `2 s ≠ 0` だけである（反例は冒頭）。
証明は加法の計算だけで閉じ、乗法の可換性は効いていない（ファイル全体の `CommRing R` を受けているだけである）。 -/
theorem skew2_eigenvalues_ne (g s : R) (hs : 2 * s ≠ 0) : g + s ≠ g - s := by
  intro h
  apply hs
  calc 2 * s = (g + s) - (g - s) := by ring   -- 環の四則
    _ = (g - s) - (g - s) := by rw [h]         -- 仮定 `g + s = g - s`
    _ = 0 := sub_self _                        -- 加法逆元

/-- **Step 2**（具体版 `AMat_mulVec_eigen_pos`）: `a b = -s^2` なら `(-s, b)` は固有値 `g + s` の固有ベクトル。
第 2 成分は仮定を使わない。 -/
theorem skew2_mulVec_pos (g a b s : R) (hab : a * b = -s ^ 2) :
    !![g, a; -b, g] *ᵥ ![-s, b] = (g + s) • ![-s, b] := by
  ext i
  fin_cases i
  · -- 第 1 成分
    calc (!![g, a; -b, g] *ᵥ ![-s, b]) 0
        = g * (-s) + a * b := by
          simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two]       -- 行列とベクトルの積の定義
      _ = -(g * s) + -s ^ 2 := by rw [hab, mul_neg]                  -- `ab = -s^2`
      _ = (g + s) * (-s) := by ring                                   -- 分配則
      _ = ((g + s) • ![-s, b]) 0 := by simp                           -- 第 1 成分は `-s`
  · -- 第 2 成分
    calc (!![g, a; -b, g] *ᵥ ![-s, b]) 1
        = (-b) * (-s) + g * b := by
          simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two]       -- 行列とベクトルの積の定義
      _ = b * s + g * b := by rw [neg_mul_neg]                        -- 環の四則 `(-b)(-s) = b s`（仮定は使わない）
      _ = s * b + g * b := by rw [mul_comm b s]                       -- 乗法の可換則
      _ = (s + g) * b := by rw [add_mul]                              -- 分配則で `b` を括り出す
      _ = (g + s) * b := by rw [add_comm s g]                         -- 加法の交換則
      _ = ((g + s) • ![-s, b]) 1 := by simp                           -- 第 2 成分は `b`

/-- **Step 2**（具体版 `AMat_mulVec_eigen_neg`）: `a b = -s^2` なら `(s, b)` は固有値 `g - s` の固有ベクトル。
第 2 成分は仮定を使わない。 -/
theorem skew2_mulVec_neg (g a b s : R) (hab : a * b = -s ^ 2) :
    !![g, a; -b, g] *ᵥ ![s, b] = (g - s) • ![s, b] := by
  ext i
  fin_cases i
  · -- 第 1 成分
    calc (!![g, a; -b, g] *ᵥ ![s, b]) 0
        = g * s + a * b := by
          simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two]       -- 行列とベクトルの積の定義
      _ = g * s + -s ^ 2 := by rw [hab]                               -- `ab = -s^2`
      _ = (g - s) * s := by ring                                      -- 分配則
      _ = ((g - s) • ![s, b]) 0 := by simp                            -- 第 1 成分は `s`
  · -- 第 2 成分
    calc (!![g, a; -b, g] *ᵥ ![s, b]) 1
        = (-b) * s + g * b := by
          simp [Matrix.mulVec, dotProduct, Fin.sum_univ_two]       -- 行列とベクトルの積の定義
      _ = b * (-s) + g * b := by rw [neg_mul_comm]                    -- 環の四則 `(-b) s = b (-s)`（仮定は使わない）
      _ = (-s) * b + g * b := by rw [mul_comm b (-s)]                 -- 乗法の可換則
      _ = (-s + g) * b := by rw [add_mul]                             -- 分配則で `b` を括り出す
      _ = (g - s) * b := by rw [add_comm, ← sub_eq_add_neg]           -- 加法の交換則（`g + (-s) = g - s`）
      _ = ((g - s) • ![s, b]) 1 := by simp                            -- 第 2 成分は `b`

/-- **Step 2 の `c` 倍**（具体版 `AMat_mulVec_smul_eigen_pos`・`AMat_mulVec_smul_eigen_neg`）:
`A v = l v` なら `A (c v) = l (c v)`。効いているのは係数の乗法の可換性だけで（加法の逆元も要らないので
係数は可換半環 `S` に下げてある）、2×2 であることも行列の形も効かない。 -/
theorem mulVec_smul_of_mulVec_eq {S : Type*} [CommSemiring S] {n : Type*} [Fintype n]
    {A : Matrix n n S} {v : n → S} {l : S}
    (h : A *ᵥ v = l • v) (c : S) : A *ᵥ (c • v) = l • (c • v) :=
  calc A *ᵥ (c • v)
      = c • (A *ᵥ v) := Matrix.mulVec_smul _ _ _   -- スカラー倍は積の外へ出る
    _ = c • (l • v) := by rw [h]                   -- `A v = l v` の代入
    _ = l • (c • v) := smul_comm _ _ _             -- 積の可換性とスカラー倍の結合

/-- **対角化の Step 2**（具体版 `AMat_mul_checkPmat`）: `P` の列が `c(-s, b)` と `c(s, b)` なら
`A P = P diag(g+s, g-s)`。列ごとに見て、Step 2 を 2 列へ同時適用する。 -/
theorem skew2_mul_of_cols (g a b s c : R) (hab : a * b = -s ^ 2) {P : Matrix (Fin 2) (Fin 2) R}
    (hcol0 : (fun k => P k 0) = c • ![-s, b]) (hcol1 : (fun k => P k 1) = c • ![s, b]) :
    !![g, a; -b, g] * P = P * !![g + s, 0; 0, g - s] := by
  -- 列 `j` の `A (c v_±) = (g ± s) (c v_±)`
  have h0 : !![g, a; -b, g] *ᵥ (fun k => P k 0) = (g + s) • (fun k => P k 0) := by
    rw [hcol0, mulVec_smul_of_mulVec_eq (skew2_mulVec_pos g a b s hab)]
  have h1 : !![g, a; -b, g] *ᵥ (fun k => P k 1) = (g - s) • (fun k => P k 1) := by
    rw [hcol1, mulVec_smul_of_mulVec_eq (skew2_mulVec_neg g a b s hab)]
  ext i j
  fin_cases j
  · -- 第 1 列: `diag(g+s, g-s)` の右乗は第 1 列の `g + s` 倍
    have h := congrFun h0 i
    simp only [Matrix.mulVec, dotProduct, Pi.smul_apply, smul_eq_mul] at h
    show (!![g, a; -b, g] * P) i 0 = (P * !![g + s, 0; 0, g - s]) i 0
    rw [Matrix.mul_apply, h]
    simp [Matrix.mul_apply, Fin.sum_univ_two, mul_comm]
  · -- 第 2 列: `diag(g+s, g-s)` の右乗は第 2 列の `g - s` 倍
    have h := congrFun h1 i
    simp only [Matrix.mulVec, dotProduct, Pi.smul_apply, smul_eq_mul] at h
    show (!![g, a; -b, g] * P) i 1 = (P * !![g + s, 0; 0, g - s]) i 1
    rw [Matrix.mul_apply, h]
    simp [Matrix.mul_apply, Fin.sum_univ_two, mul_comm]

/-- **対角化の Step 3**（具体版 `det_checkPmat`）: 列が `c(-s, b)` と `c(s, b)` の行列の行列式は `-2c^2 s b`。 -/
theorem det_of_cols (s b c : R) {P : Matrix (Fin 2) (Fin 2) R}
    (hcol0 : (fun k => P k 0) = c • ![-s, b]) (hcol1 : (fun k => P k 1) = c • ![s, b]) :
    P.det = -(2 * c ^ 2 * s * b) := by
  have h00 : P 0 0 = c * (-s) := by simpa using congrFun hcol0 0
  have h10 : P 1 0 = c * b := by simpa using congrFun hcol0 1
  have h01 : P 0 1 = c * s := by simpa using congrFun hcol1 0
  have h11 : P 1 1 = c * b := by simpa using congrFun hcol1 1
  calc P.det
      = P 0 0 * P 1 1 - P 0 1 * P 1 0 := Matrix.det_fin_two P                 -- 行列式の定義
    _ = (c * (-s)) * (c * b) - (c * s) * (c * b) := by rw [h00, h11, h01, h10] -- 列の成分
    _ = -(c ^ 2 * s * b) - c ^ 2 * s * b := by ring                            -- 環の四則
    _ = -(2 * c ^ 2 * s * b) := by ring                                        -- 同類項の統合

/-- **対角化の Step 3 の結論**（具体版 `det_checkPmat_ne_zero`）: `2 s ≠ 0`、`c ≠ 0`、`b ≠ 0` と零因子が無いことから
`det P ≠ 0`。具体版の `r > 0`・`2M ≠ 0`・`b ≠ 0` に当たる。

`NoZeroDivisors R` は「0 でない元の積は 0 でない」の段（`mul_ne_zero`）に使う。これを外すと通らない
（例えば `ZMod 4` で `s = b = 1`、`c = 2` とすると `2s ≠ 0`、`c ≠ 0`、`b ≠ 0` なのに `det P = -8 = 0`）。 -/
theorem det_of_cols_ne_zero [NoZeroDivisors R] (s b c : R) {P : Matrix (Fin 2) (Fin 2) R}
    (hcol0 : (fun k => P k 0) = c • ![-s, b]) (hcol1 : (fun k => P k 1) = c • ![s, b])
    (hs : 2 * s ≠ 0) (hc : c ≠ 0) (hb : b ≠ 0) : P.det ≠ 0 := by
  rw [det_of_cols s b c hcol0 hcol1]
  have h : 2 * c ^ 2 * s * b = (2 * s) * c ^ 2 * b := by ring
  rw [h, neg_ne_zero]
  exact mul_ne_zero (mul_ne_zero hs (pow_ne_zero 2 hc)) hb

/-- **対角化の Step 4**（具体版 `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`）:
`A P = P D` かつ `det P` が単元なら `A = P D P⁻¹`。
右から `P⁻¹` を掛けて `P P⁻¹ = I` で消す具体版の鎖と同じである。
**この形は 2×2 であることすら使っていない**（任意の有限型の添字でよい）。 -/
theorem eq_conj_of_mul_eq {n : Type*} [DecidableEq n] [Fintype n]
    {A P D : Matrix n n R} (h : A * P = P * D) (hP : IsUnit P.det) :
    A = P * D * P⁻¹ :=
  calc A = A * (P * P⁻¹) := by rw [Matrix.mul_nonsing_inv _ hP, Matrix.mul_one]  -- `P P⁻¹ = I`
    _ = (A * P) * P⁻¹ := (Matrix.mul_assoc _ _ _).symm                            -- 積の結合則
    _ = (P * D) * P⁻¹ := by rw [h]                                                -- Step 2

end Ising2D.NecSuf
