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
* `diagonalization_check_P_D` Step 2: 前置きの `Ď` が対角行列であること `checkDmat_offdiag` ↔ `skew2_diag_offdiag`、
  6 行の鎖 `AMat_mul_checkPmat` ↔ `skew2_mul_of_cols`（同じ 6 段。`P̌ = [v_+ v_-]` の `checkPmat_eq_cols` は列の仮定 `hcol0`・`hcol1` から
  同じ形で作り、列ごとの作用は `NecSuf/MatColumnwise.lean`、対角行列の右乗は `NecSuf/ColumnMatrixTimesDiagonalMatrix.lean`）。
* `diagonalization_check_P_D` Step 3: `det P̌_μ` の 29 行の鎖 `det_checkPmat_eq_mul_inv`（1〜28 行目）・`det_checkPmat` と
  `det_checkPmat_ne_zero` ↔ `det_of_quotient_entries_eq_mul_inv`・`det_of_quotient_entries`・`det_of_quotient_entries_ne_zero`
  （同じ 29 行。具体版の略記 `ρ, u, d, q` を体の任意の元とし、前置き (d) `d u = 2 q` を仮定で受ける）。
* `diagonalization_check_P_D` Step 4: `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv` ↔ `eq_conj_of_mul_eq`。
* 必要十分版を置かない段: Step 2 の `v_± ≠ 0`（第 2 成分が `b ≠ 0` であることの 1 行）と、
  `diagonalization_check_P_D` Step 1・Step 2 の `√M ≠ 0` と `c b = 1/(2√M)`（`c` を具体的に選んだことの確認）。
  前者は取り払える構造が無く、後者は `c` の具体形に関する計算で、必要十分版の `c` は任意の元である。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

効いているのは

* **行列が `!![g, a; -b, g]` の形（対角成分が等しい）であること**
* **`a b = -s^2` を満たす `s` が係数環に取れること**
* 固有値が `g ± s` に限るという段（`skew2_det_eq_zero_iff`・`skew2_eigenvalue_iff`）だけは、
  **係数環に零因子が無いこと**（`skew2_eigenvalue_iff` はさらに `0 ≠ 1`）
* 2 つの固有値が異なること（`skew2_eigenvalues_ne`）には、**`2 s ≠ 0`**
  （具体版は `r > 0` という実数の順序を使うが、効いているのは `2 s ≠ 0` だけである。
  標数 2 の環、例えば `ZMod 2` で `g = 0`、`a = b = s = 1` とすると `ab = -s^2` なのに `g + s = g - s` となり、
  `P` の 2 列も一致して対角化できない）

だけである。**係数は任意の可換環でよい。** ただし対角化の Step 3（`det P̌_μ` の 29 行の鎖）は、具体版が成分の分数
`-ρ/d` などを `/` のまま計算するので、その段だけは**体**で述べる（`det_of_quotient_entries_eq_mul_inv` の docstring）。
そこに効いているのは `u, d ≠ 0`、`d u = 2 q`、（`det P ≠ 0` には）`ρ ≠ 0` だけである。複素数であることも、`γ_1` が実数であることも、
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

対角化の Step 2 の前置き `skew2_diag_offdiag`（`diag(g+s, g-s)` の非対角成分が `0`）は、ファイル全体の `CommRing R` を受けているが、
使うのは `0` があること（`Zero`）と行列の記法だけである。

対角化 `A = P D P⁻¹` の Step 4 の鎖に効いているのは、`P` の右逆元 `Q`（`P Q = I`）があることと、
積の単位元・結合律だけである（`eq_conj_of_mul_eq`。モノイドで述べる）。人手証明 `diagonalization_check_P_D` は
Step 3 の `det P̌_μ ≠ 0` から `two_sided_inverse_of_two_by_two_with_nonzero_det` で逆元を構成しており、
導出側では、具体版の 2 段目と同じ補題で出した `P̌ P̌^{-1} = I` を仮定 `hQ` に渡す。行列式も、係数の可換性も、
左逆元も、この鎖には効いていない。
-/
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.FinCases
import Ising2D.NecSuf.TwoByTwoKernelAndDeterminant
import Ising2D.NecSuf.MatrixVectorIdentityScalarDifference
import Ising2D.NecSuf.MatColumnwise
import Ising2D.NecSuf.ColumnMatrixTimesDiagonalMatrix

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
    _ = lam ^ 2 - 2 * g * lam + (((g ^ 2 - g * s) + g * s) - s ^ 2) := by rw [mul_comm s g]
                                                                                  -- 積の可換律
    _ = lam ^ 2 - 2 * g * lam + (((g ^ 2 + (-(g * s))) + g * s) - s ^ 2) := by
          rw [sub_eq_add_neg (g ^ 2) (g * s)]                                     -- 差は逆元の和
    _ = lam ^ 2 - 2 * g * lam + ((g ^ 2 + ((-(g * s)) + g * s)) - s ^ 2) := by
          rw [add_assoc (g ^ 2) (-(g * s)) (g * s)]                               -- 和の結合律
    _ = lam ^ 2 - 2 * g * lam + ((g ^ 2 + 0) - s ^ 2) := by rw [neg_add_cancel (g * s)]
                                                                                  -- 左から足す逆元 `(-x) + x = 0`
    _ = lam ^ 2 - 2 * g * lam + (g ^ 2 - s ^ 2) := by rw [add_zero]               -- 加法の単位元

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

/-- **対角化の Step 2 の前置き**（具体版 `checkDmat_offdiag`）: `diag(g+s, g-s)` は対角行列（非対角成分が `0`）。 -/
theorem skew2_diag_offdiag (g s : R) :
    ∀ k l, k ≠ l → (!![g + s, 0; 0, g - s] : Matrix (Fin 2) (Fin 2) R) k l = 0 := by
  intro k l hkl
  fin_cases k <;> fin_cases l
  · exact absurd rfl hkl
  · rfl
  · rfl
  · exact absurd rfl hkl

/-- **対角化の Step 2**（具体版 `AMat_mul_checkPmat`）: `P` の列が `c(-s, b)` と `c(s, b)` なら
`A P = P diag(g+s, g-s)`。具体版と同じ 6 段: `P = [v_+ v_-]`、列ごとの作用（`mul_cols_eq_cols_mulVec`）、
固有ベクトルの式を 2 列へ同時適用、`g ± s` を対角成分へ書き換え、対角行列の右乗（`cols_mul_diagonal_eq_cols_smul`）を右辺から左辺へ、`P = [v_+ v_-]` を戻す。 -/
theorem skew2_mul_of_cols (g a b s c : R) (hab : a * b = -s ^ 2) {P : Matrix (Fin 2) (Fin 2) R}
    (hcol0 : (fun k => P k 0) = c • ![-s, b]) (hcol1 : (fun k => P k 1) = c • ![s, b]) :
    !![g, a; -b, g] * P = P * !![g + s, 0; 0, g - s] := by
  set v : Fin 2 → Fin 2 → R := ![c • ![-s, b], c • ![s, b]] with hv
  -- 前置き（具体版 `checkPmat_eq_cols`）: `P = [v_+ v_-]`
  have hP : P = Matrix.of (fun j k => v k j) := by
    ext j k
    fin_cases k
    · exact congrFun hcol0 j
    · exact congrFun hcol1 j
  -- 具体版 `AMat_mulVec_checkCols`: 列 `k` の `A (c v_±) = (g ± s) (c v_±)` を 2 列へ同時に当てる
  have heig : Matrix.of (fun i k => (!![g, a; -b, g] *ᵥ v k) i)
      = Matrix.of (fun i k => (![g + s, g - s] k • v k) i) := by
    ext i k
    fin_cases k
    · exact congrFun (mulVec_smul_of_mulVec_eq (skew2_mulVec_pos g a b s hab) c) i
    · exact congrFun (mulVec_smul_of_mulVec_eq (skew2_mulVec_neg g a b s hab) c) i
  calc !![g, a; -b, g] * P
      = !![g, a; -b, g] * Matrix.of (fun j k => v k j) := by rw [hP]      -- 1 段目: `P = [v_+ v_-]`
    _ = Matrix.of (fun i k => (!![g, a; -b, g] *ᵥ v k) i) :=
        mul_cols_eq_cols_mulVec _ _                                        -- 2 段目: 列ごとの作用
    _ = Matrix.of (fun i k => (![g + s, g - s] k • v k) i) :=
        heig                                                               -- 3 段目: 2 列へ同時適用
    _ = Matrix.of (fun i k => ((!![g + s, 0; 0, g - s] : Matrix (Fin 2) (Fin 2) R) k k • v k) i) := by
        ext i k
        fin_cases k <;> rfl                                                -- 4 段目: 対角成分の書き換え
    _ = Matrix.of (fun j k => v k j) * !![g + s, 0; 0, g - s] :=
        (cols_mul_diagonal_eq_cols_smul _ _ (skew2_diag_offdiag g s) (fun x => mul_zero x) mul_comm).symm
                                                                           -- 5 段目: 対角行列の右乗を右辺から左辺へ
    _ = P * !![g + s, 0; 0, g - s] := by rw [hP]                          -- 6 段目: `P = [v_+ v_-]` を戻す

/-- **対角化の Step 3 の鎖の 1〜28 行目**（具体版 `det_checkPmat_eq_mul_inv`）:
成分が `-ρ/d, ρ/d; 1/u, 1/u` の行列の行列式は `(-ρ) q^{-1}`。具体版の 28 行と 1 段ずつ同じ `calc` である。

具体版の略記 `ρ := r_ℂ`、`u := 2_ℂ s`、`d := u b`、`q := (2_ℂ ℓ) b` を、ここでは任意の元 `ρ, u, d, q` とし、
具体版が前置き (d) として示す `d u = 2 q` を仮定 `hdu` で受ける。前置き (c) `1 + 1 = 2`（11 行目）は体の
`one_add_one_eq_two` である。

仮定について:
* `hu`（25 行目の `u u^{-1} = 1`）と `hd`（27 行目の `d d^{-1} = 1`）は外すと通らない。`ZMod 2` で
  `ρ = d = q = 1`、`u = 0` とすると `d u = 0 = 2 q` なのに、`1/0 = 0` から左辺は `0`、右辺は `1` である。
  `ρ = u = q = 1`、`d = 0` でも同じく左辺は `0`、右辺は `1` である。
  この反例は標数 2 と Lean の `x/0 = 0` の規約に依る。標数が 2 でない体では、`u = 0` か `d = 0` なら `d u = 2 q` から
  `q = 0` が出て両辺とも `0` なので、主張だけなら外せる。`hu`・`hd` が要るのは、25 行目・27 行目の段を通すためである。
  逆に標数 2 の体では `d u ≠ 0 = 2 q` となり、`hu`・`hd`・`hdu` は同時には成り立たない（この主張は標数 2 では空である）。
* 具体版が前置き (b) の群の積で示す `q ≠ 0`（16 行目の `q^{-1} q = 1`）は仮定しない。`d u = 2 q` と
  `d, u ≠ 0` から `2 q ≠ 0`、したがって `q ≠ 0` が出る。具体版で `q ≠ 0` が `2_ℂ`・`ℓ`・`b` の各々から
  出ていることは、この鎖には効いていない。
* 係数は**体**（`Field`）とする。使うのは、`/` が逆元との積であること（`def_complex_quotient`）、`u, d, q` の逆元、
  積の可換律・結合律・単位元、和の分配律、`-` と `-1` 倍の関係、`1 + 1 = 2` である。0 でない元すべてに逆元が
  あることは `u, d, q` の 3 つにしか使わないが、可換環に `/` と一部の元の逆元だけを足す標準の型クラスは無いので、
  `Field` で述べる。`ℂ` であることも、`ρ` が実数であることも、`d = u b` の分解も、`ℓ = s s` も効いていない。 -/
theorem det_of_quotient_entries_eq_mul_inv {F : Type*} [Field F] (ρ u d q : F)
    (hu : u ≠ 0) (hd : d ≠ 0) (hdu : d * u = 2 * q) :
    (!![-ρ / d, ρ / d; 1 / u, 1 / u] : Matrix (Fin 2) (Fin 2) F).det = (-ρ) * q⁻¹ := by
  have hq0 : q ≠ 0 := right_ne_zero_of_mul (hdu ▸ mul_ne_zero hd hu)
                                        -- `2 q = d u ≠ 0`（具体版は前置き (b) の群の積）
  calc (!![-ρ / d, ρ / d; 1 / u, 1 / u] : Matrix (Fin 2) (Fin 2) F).det
      = (-ρ / d) * (1 / u) - (ρ / d) * (1 / u) :=
        Matrix.det_fin_two_of _ _ _ _
                                        -- 1 行目: `def_det_two_by_two`
    _ = ((-ρ) * d⁻¹) * (1 * u⁻¹) - (ρ * d⁻¹) * (1 * u⁻¹) := by
        simp only [div_eq_mul_inv]      -- 2 行目: `def_complex_quotient` を 4 か所へ
    _ = ((-ρ) * d⁻¹) * u⁻¹ - (ρ * d⁻¹) * u⁻¹ := by
        simp only [one_mul]             -- 3 行目: 積の単位元を 2 か所へ
    _ = (-ρ) * (d⁻¹ * u⁻¹) - ρ * (d⁻¹ * u⁻¹) := by
        rw [mul_assoc (-ρ), mul_assoc ρ]
                                        -- 4 行目: 積の結合律を 2 か所へ
    _ = (-ρ) * (d⁻¹ * u⁻¹) + -(ρ * (d⁻¹ * u⁻¹)) := sub_eq_add_neg _ _
                                        -- 5 行目: `def_complex_difference`
    _ = (-ρ) * (d⁻¹ * u⁻¹) + (-1) * (ρ * (d⁻¹ * u⁻¹)) := by
        rw [neg_one_mul]                -- 6 行目: `multiply_by_minus_one`
    _ = (-ρ) * (d⁻¹ * u⁻¹) + ((-1) * ρ) * (d⁻¹ * u⁻¹) := by
        rw [mul_assoc (-1 : F) ρ]       -- 7 行目: 積の結合律を右辺から左辺へ
    _ = (-ρ) * (d⁻¹ * u⁻¹) + (-ρ) * (d⁻¹ * u⁻¹) := by
        rw [neg_one_mul]                -- 8 行目: `multiply_by_minus_one` を右辺から左辺へ
    _ = 1 * ((-ρ) * (d⁻¹ * u⁻¹)) + 1 * ((-ρ) * (d⁻¹ * u⁻¹)) := by
        rw [one_mul]                    -- 9 行目: 積の単位元を右辺から左辺へ 2 か所へ
    _ = (1 + 1) * ((-ρ) * (d⁻¹ * u⁻¹)) := (add_mul _ _ _).symm
                                        -- 10 行目: 右からの分配律を右辺から左辺へ
    _ = 2 * ((-ρ) * (d⁻¹ * u⁻¹)) := by
        rw [one_add_one_eq_two]         -- 11 行目: 前置き (c)
    _ = (2 * (-ρ)) * (d⁻¹ * u⁻¹) := (mul_assoc _ _ _).symm
                                        -- 12 行目: 積の結合律を右辺から左辺へ
    _ = ((-ρ) * 2) * (d⁻¹ * u⁻¹) := by
        rw [mul_comm (2 : F) (-ρ)]      -- 13 行目: 積の可換律
    _ = (-ρ) * (2 * (d⁻¹ * u⁻¹)) := mul_assoc _ _ _
                                        -- 14 行目: 積の結合律
    _ = (-ρ) * (1 * (2 * (d⁻¹ * u⁻¹))) := by
        rw [one_mul]                    -- 15 行目: 積の単位元を右辺から左辺へ
    _ = (-ρ) * ((q⁻¹ * q) * (2 * (d⁻¹ * u⁻¹))) := by
        rw [inv_mul_cancel₀ hq0]        -- 16 行目: `q` の逆元を右辺から左辺へ
    _ = (-ρ) * (q⁻¹ * (q * (2 * (d⁻¹ * u⁻¹)))) := by
        rw [mul_assoc q⁻¹ q]            -- 17 行目: 積の結合律
    _ = (-ρ) * (q⁻¹ * ((q * 2) * (d⁻¹ * u⁻¹))) := by
        rw [mul_assoc q (2 : F)]        -- 18 行目: 積の結合律を右辺から左辺へ
    _ = (-ρ) * (q⁻¹ * ((2 * q) * (d⁻¹ * u⁻¹))) := by
        rw [mul_comm q (2 : F)]         -- 19 行目: 積の可換律
    _ = (-ρ) * (q⁻¹ * ((d * u) * (d⁻¹ * u⁻¹))) := by
        rw [hdu]                        -- 20 行目: 前置き (d)（仮定 `hdu`）を右辺から左辺へ
    _ = (-ρ) * (q⁻¹ * (d * (u * (d⁻¹ * u⁻¹)))) := by
        rw [mul_assoc d u]              -- 21 行目: 積の結合律
    _ = (-ρ) * (q⁻¹ * (d * ((u * d⁻¹) * u⁻¹))) := by
        rw [mul_assoc u d⁻¹]            -- 22 行目: 積の結合律を右辺から左辺へ
    _ = (-ρ) * (q⁻¹ * (d * ((d⁻¹ * u) * u⁻¹))) := by
        rw [mul_comm u d⁻¹]             -- 23 行目: 積の可換律
    _ = (-ρ) * (q⁻¹ * (d * (d⁻¹ * (u * u⁻¹)))) := by
        rw [mul_assoc d⁻¹ u]            -- 24 行目: 積の結合律
    _ = (-ρ) * (q⁻¹ * (d * (d⁻¹ * 1))) := by
        rw [mul_inv_cancel₀ hu]         -- 25 行目: `u` の逆元
    _ = (-ρ) * (q⁻¹ * (d * d⁻¹)) := by
        rw [mul_one]                    -- 26 行目: 積の単位元
    _ = (-ρ) * (q⁻¹ * 1) := by
        rw [mul_inv_cancel₀ hd]         -- 27 行目: `d` の逆元
    _ = (-ρ) * q⁻¹ := by
        rw [mul_one]                    -- 28 行目: 積の単位元

/-- **対角化の Step 3**（具体版 `det_checkPmat`）: 成分が `-ρ/d, ρ/d; 1/u, 1/u` の行列の行列式は `(-ρ)/q`
（29 行。28 行目までは `det_of_quotient_entries_eq_mul_inv`）。 -/
theorem det_of_quotient_entries {F : Type*} [Field F] (ρ u d q : F)
    (hu : u ≠ 0) (hd : d ≠ 0) (hdu : d * u = 2 * q) :
    (!![-ρ / d, ρ / d; 1 / u, 1 / u] : Matrix (Fin 2) (Fin 2) F).det = (-ρ) / q := by
  rw [det_of_quotient_entries_eq_mul_inv ρ u d q hu hd hdu]  -- 1〜28 行目
  exact (div_eq_mul_inv _ _).symm       -- 29 行目: `def_complex_quotient`（`z → -ρ`, `w → q`）を右辺から左辺へ

/-- **対角化の Step 3 の結論**（具体版 `det_checkPmat_ne_zero`）: `ρ ≠ 0` なら `det P ≠ 0`。
具体版と同じく、鎖の最後から 2 行目 `(-ρ) q^{-1}` について、`-ρ = (-1) ρ`（`multiply_by_minus_one`）と
`-1 ≠ 0`・`ρ ≠ 0` の積、`q^{-1} ≠ 0`（逆元）の積で示す。具体版は `-1_ℂ ≠ 0`・`ρ ≠ 0` を `ℂ` の第 1 成分の比較で、
`ρ ≠ 0` を `r > 0` から出す。ここでは `-1 ≠ 0` は体の `1 ≠ 0` から、`ρ ≠ 0` は仮定 `hρ` で受ける
（`ρ` が正の実数であることは効いていない）。`q ≠ 0` は上と同じく `d u = 2 q` と `d, u ≠ 0` から出す。

`hρ` は外すと通らない（`ρ = 0` なら左辺の行列の第 1 行が `0` で `det P = 0`）。`hu`・`hd` も、この主張では
どの体でも外すと通らない（`1/0 = 0`・`ρ/0 = 0` の規約のもとで、`u = 0` なら第 2 行、`d = 0` なら第 1 行が `0`）。 -/
theorem det_of_quotient_entries_ne_zero {F : Type*} [Field F] (ρ u d q : F)
    (hu : u ≠ 0) (hd : d ≠ 0) (hdu : d * u = 2 * q) (hρ : ρ ≠ 0) :
    (!![-ρ / d, ρ / d; 1 / u, 1 / u] : Matrix (Fin 2) (Fin 2) F).det ≠ 0 := by
  have hq0 : q ≠ 0 := right_ne_zero_of_mul (hdu ▸ mul_ne_zero hd hu)
                                        -- `2 q = d u ≠ 0`
  have hm1 : (-1 : F) ≠ 0 := neg_ne_zero.mpr one_ne_zero
                                        -- `-1 ≠ 0`（体の `1 ≠ 0`）
  have hnegρ : -ρ ≠ 0 := by
    rw [← neg_one_mul]                  -- `multiply_by_minus_one`: `-ρ = (-1) ρ`
    exact mul_ne_zero hm1 hρ            -- 0 でない元の積
  rw [det_of_quotient_entries_eq_mul_inv ρ u d q hu hd hdu]
                                        -- 鎖の最後から 2 行目 `(-ρ) q^{-1}`
  exact mul_ne_zero hnegρ (inv_ne_zero hq0)
                                        -- `q^{-1} ≠ 0`（逆元）と 0 でない元の積

/-- **対角化の Step 4**（具体版 `AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv`）:
`A P = P D` かつ `P Q = I` なら `A = P D Q`。
`A` から始めて `A = A I = A(P Q) = (A P) Q = (P D) Q` とつなぐ、具体版の 4 行の鎖と同じ手順である。
具体版は `Q → P̌_μ^{-1}` で、2 段目の `P̌_μ P̌_μ^{-1} = I` を `inv_eq_detInv_smul_adjTwo`・`mul_detInv_smul_adjTwo`
（人手 `two_sided_inverse_of_two_by_two_with_nonzero_det`）から出す。ここではその等式を仮定 `hQ` として受ける。

効いているのは積の右単位元（1 段目）・結合律（3 段目）と `hQ`（2 段目）だけなので、**モノイドで述べる**。
行列であることも、2×2 であることも、係数が環であることも、`det P` が単元であることも効いていない。
`Q` が左逆元であること（`Q P = I`）も使わない（人手の `P̌_μ^{-1}` は両側逆元だが、この鎖が引くのは `g g^{-1} = I` の側だけ）。
`Monoid` は左単位元 `1 x = x` も含むが、この鎖は使わない（Lean の標準の型クラスに右単位元と結合律だけのものが無いので含めている）。
`hQ` は外せない: 行列のモノイドで `P = 0`、`D = 0`、`Q = 0`、`A = I` とすると `A P = P D` なのに `A ≠ P D Q`。 -/
theorem eq_conj_of_mul_eq {G : Type*} [Monoid G]
    {A P D Q : G} (h : A * P = P * D) (hQ : P * Q = 1) :
    A = P * D * Q :=
  calc A = A * 1 := (mul_one A).symm                                             -- 具体版 1 行目: 単位元は右単位元
    _ = A * (P * Q) := by rw [hQ]                                                 -- 具体版 2 行目: `P P^{-1} = I`
    _ = (A * P) * Q := (mul_assoc _ _ _).symm                                     -- 具体版 3 行目: 積の結合則
    _ = (P * D) * Q := by rw [h]                                                  -- 具体版 4 行目: Step 2

end Ising2D.NecSuf
