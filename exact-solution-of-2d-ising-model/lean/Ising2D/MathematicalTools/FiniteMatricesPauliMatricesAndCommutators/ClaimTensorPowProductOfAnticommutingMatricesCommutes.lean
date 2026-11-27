/-
# `Mat(2^M, ℂ)` の反可換な二つの行列の積は可換（**具体版**）

対応する人手証明のラベル: `product_of_anticommuting_matrices_commutes`
（`structured-latex/content/002_linear_space_general.ts`）の、行列が `Mat(2^M, ℂ)` の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean` の `NecSuf.commute_mul_of_anticomm'`。
具体版をその系として導くのは `ClaimProductOfAnticommutingMatricesCommutesFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* 仮定 `GX = −(XG)`・`GY = −(YG)` を、番号で読んだ成分の行列（`Fin n` の添字の行列）`Gν`・`Xν`・`Yν` の
  `GνXν = −(XνGν)`・`GνYν = −(YνGν)` へ移す（成分ごとに `tensorPow_mul_apply_eq_mat_mult`・`matrix_mul_apply_sum`（`mat_mult`）と
  `matrix_conf_neg_apply`・`matrix_neg_apply`（`def_matrix_negation`）を通す）。
* `Gν`・`Xν`・`Yν` について人手の主張（`ClaimProductOfAnticommutingMatricesCommutes.lean` の `matrix_mul_comm_of_anticomm_pair`）を引き、
  `Gν(XνYν) = (XνYν)Gν` を得る。人手の主張は任意の `n` について述べてあり、ここはその `2^M` の場合である。
* 行列の等号を、番号で読んだ全ての成分の等号にする（`tensorPow_entries_by_kronecker_numbering`、`def_complex_matrices`）。
  成分の等号は、外側と内側の積を `mat_mult`（`tensorPow_mul_matrix_conf_apply_eq_mat_mult`・`matrix_conf_mul_tensorPow_apply_eq_mat_mult`・
  `tensorPow_mul_apply_eq_mat_mult`・`matrix_mul_apply_sum`）で番号の上の和にして `Gν(XνYν) = (XνYν)Gν` の成分で読む。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimProductOfAnticommutingMatricesCommutes
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

/-- **`product_of_anticommuting_matrices_commutes`**（`Mat(2^M, ℂ)`）: `GX = −(XG)` かつ `GY = −(YG)` なら
`G(XY) = (XY)G`（`G, X, Y ∈ TensorPow M`）。 -/
theorem mul_comm_of_anticomm_pair_tensorPow {M : ℕ} (G X Y : TensorPow M)
    (hX : G * X = -(X * G)) (hY : G * Y = -(Y * G)) : G * (X * Y) = (X * Y) * G := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `G_{jl}`・`X_{jl}`・`Y_{jl}`（`Mat(2^M, ℂ)` の元）
  set Gν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => G (σ j) (σ l) with hGν
  set Xν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => X (σ j) (σ l) with hXν
  set Yν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => Y (σ j) (σ l) with hYν
  -- 仮定 `GX = −(XG)` を番号で読んだ成分の行列へ移す
  have hXν' : Gν * Xν = -(Xν * Gν) := Matrix.ext fun i k =>   -- 全ての成分が一致する（`def_complex_matrices`）
    calc (Gν * Xν) i k
        = ∑ j : Fin n, Gν i j * Xν j k := matrix_mul_apply_sum _ _ _ _              -- `mat_mult`
      _ = ∑ j : Fin n, G (σ i) (σ j) * X (σ j) (σ k) := by
          simp only [hGν, hXν, Matrix.of_apply]                                     -- 番号で読んだ成分の行列 `Gν`・`Xν` の定義
      _ = (G * X) (σ i) (σ k) := (tensorPow_mul_apply_eq_mat_mult M n hord σ hσ G X i k).symm  -- `mat_mult`
      _ = (-(X * G)) (σ i) (σ k) := by rw [hX]                                      -- 仮定 `GX = −(XG)`
      _ = -((X * G) (σ i) (σ k)) := matrix_conf_neg_apply _ _ _                     -- `def_matrix_negation`
      _ = -∑ j : Fin n, X (σ i) (σ j) * G (σ j) (σ k) := by
          rw [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ X G i k]                -- `mat_mult`
      _ = -∑ j : Fin n, Xν i j * Gν j k := by
          simp only [hGν, hXν, Matrix.of_apply]                                     -- 番号で読んだ成分の行列 `Gν`・`Xν` の定義
      _ = -((Xν * Gν) i k) := by rw [matrix_mul_apply_sum]                          -- `mat_mult`
      _ = (-(Xν * Gν)) i k := (matrix_neg_apply _ _ _).symm                         -- `def_matrix_negation`
  -- 仮定 `GY = −(YG)` を番号で読んだ成分の行列へ移す
  have hYν' : Gν * Yν = -(Yν * Gν) := Matrix.ext fun i k =>   -- 全ての成分が一致する（`def_complex_matrices`）
    calc (Gν * Yν) i k
        = ∑ j : Fin n, Gν i j * Yν j k := matrix_mul_apply_sum _ _ _ _              -- `mat_mult`
      _ = ∑ j : Fin n, G (σ i) (σ j) * Y (σ j) (σ k) := by
          simp only [hGν, hYν, Matrix.of_apply]                                     -- 番号で読んだ成分の行列 `Gν`・`Yν` の定義
      _ = (G * Y) (σ i) (σ k) := (tensorPow_mul_apply_eq_mat_mult M n hord σ hσ G Y i k).symm  -- `mat_mult`
      _ = (-(Y * G)) (σ i) (σ k) := by rw [hY]                                      -- 仮定 `GY = −(YG)`
      _ = -((Y * G) (σ i) (σ k)) := matrix_conf_neg_apply _ _ _                     -- `def_matrix_negation`
      _ = -∑ j : Fin n, Y (σ i) (σ j) * G (σ j) (σ k) := by
          rw [tensorPow_mul_apply_eq_mat_mult M n hord σ hσ Y G i k]                -- `mat_mult`
      _ = -∑ j : Fin n, Yν i j * Gν j k := by
          simp only [hGν, hYν, Matrix.of_apply]                                     -- 番号で読んだ成分の行列 `Gν`・`Yν` の定義
      _ = -((Yν * Gν) i k) := by rw [matrix_mul_apply_sum]                          -- `mat_mult`
      _ = (-(Yν * Gν)) i k := (matrix_neg_apply _ _ _).symm                         -- `def_matrix_negation`
  -- 人手の主張を `Gν`・`Xν`・`Yν` について引く
  have hcomm : Gν * (Xν * Yν) = (Xν * Yν) * Gν :=
    matrix_mul_comm_of_anticomm_pair Gν Xν Yν hXν' hYν'                             -- `product_of_anticommuting_matrices_commutes`
  -- 内側の積 `XY` の成分は `XνYν` の成分（`mat_mult` を 2 回）
  have hXY : ∀ j l : Fin n, (X * Y) (σ j) (σ l) = (Xν * Yν) j l := fun j l =>
    calc (X * Y) (σ j) (σ l)
        = ∑ m : Fin n, X (σ j) (σ m) * Y (σ m) (σ l) :=
          tensorPow_mul_apply_eq_mat_mult M n hord σ hσ X Y j l                     -- `mat_mult`
      _ = ∑ m : Fin n, Xν j m * Yν m l := by
          simp only [hXν, hYν, Matrix.of_apply]                                     -- 番号で読んだ成分の行列 `Xν`・`Yν` の定義
      _ = (Xν * Yν) j l := (matrix_mul_apply_sum _ _ _ _).symm                      -- `mat_mult`
  -- 全ての成分が一致する（`def_complex_matrices`）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (G * (X * Y)) (σ i) (σ k)
      = ∑ j : Fin n, G (σ i) (σ j) * (X * Y) (σ j) (σ k) :=
        tensorPow_mul_matrix_conf_apply_eq_mat_mult M n hord σ hσ G (X * Y) i k     -- `mat_mult`
    _ = ∑ j : Fin n, Gν i j * (Xν * Yν) j k := by
        simp only [hXY, hGν, Matrix.of_apply]                                       -- 上の `hXY`、番号で読んだ成分の行列 `Gν` の定義
    _ = (Gν * (Xν * Yν)) i k := (matrix_mul_apply_sum _ _ _ _).symm                 -- `mat_mult`
    _ = ((Xν * Yν) * Gν) i k := by rw [hcomm]                                       -- 上の `Gν(XνYν) = (XνYν)Gν`
    _ = ∑ j : Fin n, (Xν * Yν) i j * Gν j k := matrix_mul_apply_sum _ _ _ _         -- `mat_mult`
    _ = ∑ j : Fin n, (X * Y) (σ i) (σ j) * G (σ j) (σ k) := by
        simp only [hXY, hGν, Matrix.of_apply]                                       -- 上の `hXY`、番号で読んだ成分の行列 `Gν` の定義
    _ = ((X * Y) * G) (σ i) (σ k) :=
        (matrix_conf_mul_tensorPow_apply_eq_mat_mult M n hord σ hσ (X * Y) G i k).symm  -- `mat_mult`

end Ising2D
