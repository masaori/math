/-
# `S_1^{(+)} = iK_1H_1^{(+)}`・`S_2 = iK_2^*H_2` の Pauli 行列による表示（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
（`eigenvalues_of_V_014_claim_iH_is_real_symmetric`、ラベル **`iH_is_real_symmetric`**）

人手 `iH_is_real_symmetric` の Step 1 と Step 2 の鎖（`S_2 = K_2^*Σσ^x_m`・`S_1^{(+)} = K_1Σσ^z_mσ^z_{m+1} - K_1G`）と 1 対 1 に対応する。
Step 3（成分が実で転置について対称）は、この表示を経ない別の論法で `S1plus_isHermitian`・`S1plus_transpose`・`S2_isHermitian`・`S2_transpose`
（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPositiveDefinite.lean`）が持っている。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| Step 1 の `Z_mY_m = -iσ^x_m` | `Z_mul_Y_same`（`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`） |
| Step 1 の `H_2` の鎖の 3 行（`def_H2` → 上で得た `Z_mY_m` → `finite_sum_of_scalar_multiples`） | `H2_eq_neg_I_smul_sum_sigmaX` の `calc` の 3 段 |
| Step 1 の `S_2` の鎖の 8 行（`S_2` の定義 → `H_2` の表示 → `scalar_multiple_is_associative` → ℂ の積の結合律 → 交換律 → 結合律 → `i(-i) = 1` → 乗法の単位元） | `S2_eq_K2star_smul_sum_sigmaX` の `calc` の 7 段（先頭の「`S_2` の定義」の行は Lean では主張の左辺そのもの） |
| Step 2 の `Y_mZ_{m+1} = -iσ^z_mσ^z_{m+1}`（`1 ≤ m ≤ M_col-1`） | `Y_castSucc_mul_Z_succ`（`Y_mul_Z_next_of_not_last` を人手の差の形の添字へ） |
| Step 2 の境界項 `Y_{M_col}Z_1 = -iG`（`G = σ^y_1σ^x_2⋯σ^x_{M_col-1}σ^y_{M_col}`） | `Y_last_mul_Z_zero`（`Y_last_mul_Z_first` を人手の差の形の添字へ） |
| Step 2 の `S_1^{(+)}` の鎖の 13 行 | `S1plus_eq_K1_smul_sub` の `calc` の 12 段（先頭の「`S_1^{(+)}` の定義」の行は Lean では主張の左辺そのもの） |

- 人手の `K_1, K_2^* ∈ ℝ` は、Lean では `ℂ` の元 `K1`・`K2star` として受け取る（`ClaimPositiveDefinite.lean` の `S1plus_isHermitian` ほかと同じ）。
  鎖は係数の実性を使わないので、仮定 `star K1 = K1` は置かない。
- 人手は `M_col ≥ 2` で述べる。`H_2`・`S_2` の鎖は `M = r + 1`、`S_1^{(+)}` の鎖は `M = r + 2` の場合を述べる
  （Lean の添字は 0 始まりなので、人手の `m` は `Fin.castSucc m`、`m + 1` は `Fin.succ m`、`M_col` は `Fin.last (r + 1)`、`1` は `0`）。
  人手の `H_1^{(+)}` の差の形は `H1plus_eq_sub`（`def_H1_plus`）で読み替える。
- 人手の `G` は、サイトごとの因子の族 `boundaryYXYFamily` をクロネッカー積 `siteProd` に入れたものとして書く
  （`EigenvectorOfMaxEigenvalue/ClaimH1PlusInSigmaZForm.lean`）。同じ文字の `boundaryG`（`σ^z_{M_col}σ^z_1`）とは別のものである。
- `scalar_multiple_is_associative` の Lean の具体版は無く、mathlib の `smul_smul` を使う（状態台帳に記録がある）。
  ℂ の積の結合律・交換律・単位元（`complex_numbers_form_a_field`）は `mul_assoc`・`mul_comm`・`one_mul`、`i·(-i) = 1_ℂ` は `I_mul_neg_I`
  （`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`）。

具体的な複素行列の等式であり、主張に固有なのは各段で引いた主張（それぞれ必要十分版を持つ）だけなので、必要十分版は置かない。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimH1PlusInSigmaZForm
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixSumFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixDifferenceFromNecSuf

namespace Ising2D

open Matrix

/-- **人手 `iH_is_real_symmetric` Step 1 の `H_2` の鎖**: `H_2 = -iΣ_{m=1}^{M_col} σ^x_m`（`M = r + 1`）。 -/
theorem H2_eq_neg_I_smul_sum_sigmaX (r : ℕ) :
    H2 (r + 1) = (-Complex.I) • ∑ m : Fin (r + 1), sigmaX m :=
  calc H2 (r + 1)
      = ∑ m : Fin (r + 1), Z m * Y m := rfl                                  -- `def_H2`
    _ = ∑ m : Fin (r + 1), (-Complex.I) • sigmaX m :=
        Finset.sum_congr rfl fun m _ => Z_mul_Y_same m                       -- 上で得た `Z_mY_m = -iσ^x_m`
    _ = (-Complex.I) • ∑ m : Fin (r + 1), sigmaX m :=
        finite_sum_smul_tensorPow _ r _                                      -- `finite_sum_of_scalar_multiples`（`m, n → 2^{M_col}`, `r → M_col`, `c → -i`, `(X_1, …, X_r) → (σ^x_1, …, σ^x_{M_col})`）

/-- **人手 `iH_is_real_symmetric` Step 1 の `S_2` の鎖**: `S_2 = (iK_2^*)H_2 = K_2^*Σ_{m=1}^{M_col} σ^x_m`（`M = r + 1`）。 -/
theorem S2_eq_K2star_smul_sum_sigmaX (K2star : ℂ) (r : ℕ) :
    (Complex.I * K2star) • H2 (r + 1) = K2star • ∑ m : Fin (r + 1), sigmaX m :=
  calc (Complex.I * K2star) • H2 (r + 1)
      = (Complex.I * K2star) • ((-Complex.I) • ∑ m : Fin (r + 1), sigmaX m) := by
        rw [H2_eq_neg_I_smul_sum_sigmaX]                                     -- 上で得た `H_2` の表示
    _ = ((Complex.I * K2star) * (-Complex.I)) • ∑ m : Fin (r + 1), sigmaX m :=
        smul_smul _ _ _                                                      -- `scalar_multiple_is_associative`（`a → iK_2^*`, `b → -i`）
    _ = (Complex.I * (K2star * (-Complex.I))) • ∑ m : Fin (r + 1), sigmaX m := by
        rw [mul_assoc]                                                       -- ℂ の積の結合律
    _ = (Complex.I * ((-Complex.I) * K2star)) • ∑ m : Fin (r + 1), sigmaX m := by
        rw [mul_comm K2star (-Complex.I)]                                    -- ℂ の積の交換律
    _ = ((Complex.I * (-Complex.I)) * K2star) • ∑ m : Fin (r + 1), sigmaX m := by
        rw [← mul_assoc]                                                     -- ℂ の積の結合律
    _ = (1 * K2star) • ∑ m : Fin (r + 1), sigmaX m := by
        rw [I_mul_neg_I]                                                     -- `i·(-i) = 1_ℂ`
    _ = K2star • ∑ m : Fin (r + 1), sigmaX m := by
        rw [one_mul]                                                         -- ℂ の乗法の単位元

/-- 人手 Step 2 の `Y_mZ_{m+1} = -iσ^z_mσ^z_{m+1}`（`1 ≤ m ≤ M_col - 1`）を、`H1plus_eq_sub` の添字（`Fin.castSucc m`・`Fin.succ m`）で。 -/
theorem Y_castSucc_mul_Z_succ {r : ℕ} (m : Fin (r + 1)) :
    Y (Fin.castSucc m) * Z (Fin.succ m)
      = (-Complex.I) • (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)) := by
  have hlt : ((Fin.castSucc m : Fin (r + 2)) : ℕ) + 1 < r + 2 := by
    simp only [Fin.val_castSucc]; omega
  have hnext : nextSite (Fin.castSucc m) = Fin.succ m :=
    Fin.ext (by rw [nextSite_val_of_lt hlt]; simp)
  rw [← hnext]
  exact Y_mul_Z_next_of_not_last _ (Nat.ne_of_lt hlt)

/-- 人手 Step 2 の境界項 `Y_{M_col}Z_1 = -iG` を、`H1plus_eq_sub` の添字（`Fin.last (r + 1)`・`0`）で。 -/
theorem Y_last_mul_Z_zero (r : ℕ) :
    Y (Fin.last (r + 1)) * Z (0 : Fin (r + 2))
      = (-Complex.I) • siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) := by
  have hl : (Fin.last (r + 1) : Fin (r + 2)) = lastSite (r + 2) (by omega) := Fin.ext (by simp [lastSite])
  have hf : (0 : Fin (r + 2)) = firstSite (r + 2) (by omega) := Fin.ext (by simp [firstSite])
  rw [hl, hf]
  exact Y_last_mul_Z_first (by omega)

/-- **人手 `iH_is_real_symmetric` Step 2 の `S_1^{(+)}` の鎖**:
`S_1^{(+)} = (iK_1)H_1^{(+)} = K_1Σ_{m=1}^{M_col-1} σ^z_mσ^z_{m+1} - K_1G`（`M = r + 2`）。人手の 13 行のうち先頭の「`S_1^{(+)}` の定義」の行は主張の左辺そのもので、残る 12 行が `calc` の 12 段と 1 対 1。 -/
theorem S1plus_eq_K1_smul_sub (K1 : ℂ) (r : ℕ) :
    (Complex.I * K1) • H1plus (r + 2)
      = K1 • (∑ m : Fin (r + 1), sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m))
        - K1 • siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) := by
  set G := siteProd (r + 2) (boundaryYXYFamily (r + 2) (by omega)) with hG
  set D := ∑ m : Fin (r + 1), sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m) with hD
  calc (Complex.I * K1) • H1plus (r + 2)
      = (Complex.I * K1) • ((∑ m : Fin (r + 1), Y (Fin.castSucc m) * Z (Fin.succ m))
          - Y (Fin.last (r + 1)) * Z 0) := by
        rw [H1plus_eq_sub]                                                   -- `def_H1_plus`
    _ = (Complex.I * K1) • ((∑ m : Fin (r + 1), (-Complex.I) • (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)))
          - Y (Fin.last (r + 1)) * Z 0) := by
        rw [Finset.sum_congr rfl fun m _ => Y_castSucc_mul_Z_succ m]          -- 上で得た `Y_mZ_{m+1} = (-i)σ^z_mσ^z_{m+1}` を各項へ
    _ = (Complex.I * K1) • ((∑ m : Fin (r + 1), (-Complex.I) • (sigmaZ (Fin.castSucc m) * sigmaZ (Fin.succ m)))
          - (-Complex.I) • G) := by
        rw [Y_last_mul_Z_zero]                                               -- 上で得た `Y_{M_col}Z_1 = (-i)G`
    _ = (Complex.I * K1) • ((-Complex.I) • D - (-Complex.I) • G) := by
        rw [finite_sum_smul_tensorPow (-Complex.I) r]                        -- `finite_sum_of_scalar_multiples`（`m, n → 2^{M_col}`, `r → M_col-1`, `c → -i`, `(X_1, …, X_r) → (σ^z_1σ^z_2, …, σ^z_{M_col-1}σ^z_{M_col})`）
    _ = (Complex.I * K1) • ((-Complex.I) • (D - G)) := by
        rw [smul_sub_tensorPow (-Complex.I) D G]                             -- `scalar_multiple_distributes_over_matrix_difference`（`c → -i`, `A → Σσ^zσ^z`, `B → G`）を右辺から左辺へ
    _ = ((Complex.I * K1) * (-Complex.I)) • (D - G) :=
        smul_smul _ _ _                                                      -- `scalar_multiple_is_associative`（`a → iK_1`, `b → -i`）
    _ = (Complex.I * (K1 * (-Complex.I))) • (D - G) := by
        rw [mul_assoc]                                                       -- ℂ の積の結合律
    _ = (Complex.I * ((-Complex.I) * K1)) • (D - G) := by
        rw [mul_comm K1 (-Complex.I)]                                        -- ℂ の積の交換律
    _ = ((Complex.I * (-Complex.I)) * K1) • (D - G) := by
        rw [← mul_assoc]                                                     -- ℂ の積の結合律
    _ = (1 * K1) • (D - G) := by
        rw [I_mul_neg_I]                                                     -- `i·(-i) = 1_ℂ`
    _ = K1 • (D - G) := by
        rw [one_mul]                                                         -- ℂ の乗法の単位元
    _ = K1 • D - K1 • G :=
        smul_sub_tensorPow K1 D G                                            -- `scalar_multiple_distributes_over_matrix_difference`（`c → K_1`, `A → Σσ^zσ^z`, `B → G`）

end Ising2D
