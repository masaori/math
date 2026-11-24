/-
# 実ベクトルのノルム `‖x‖ = √(xᵀx)`（**必要十分版**の側の定義）

具体版の同じ定義と性質は `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/RealMatrixBilinearFormAndNorm.lean`
の `Ising2D.vecNorm`・`vecNormSq_nonneg`・`vecNormSq_smul`・`vecNorm_sq`・`vecNorm_eq_one_of_vecNormSq_eq_one`・`vecNormSq_eq_one_of_vecNorm_eq_one` である
（対応する人手の項目は無い補助の定義。人手の `def_matrix_norm` の `K = ℝ` の数ベクトルのノルムを Lean で書いたもの）。
具体版の `vecNorm` とこのファイルの `vecNorm'` が同じ値であることは、具体版と同じフォルダの
`RealMatrixBilinearFormAndNormFromNecSuf.lean` が述べる。

## 何が効いているか / 効いていないか

| 具体版 | 必要十分版 | 仮定 |
| --- | --- | --- |
| `sqrt_of_real_one_is_one`（`√1 = 1`。`ClaimSqrtOfRealOneIsOne.lean`） | `sqrt_one'`（同じ手順） | なし（具体版と同じ） |
| `vecNorm`（`√(x ⬝ᵥ x)`） | `vecNorm'`（同じ式） | なし（具体版と同じ） |
| `vecNormSq_nonneg`（二乗の和は非負） | `vecNormSq'_nonneg`（同じ手順） | なし（具体版と同じ） |
| `vecNormSq_smul`（`‖cx‖² = c²‖x‖²`） | `vecNormSq'_smul`（同じ手順） | なし（具体版と同じ） |
| `vecNorm_sq`（`‖x‖^2 = ‖x‖²`） | `vecNorm'_sq`（同じ手順） | なし（具体版と同じ） |
| `vecNorm_eq_one_of_vecNormSq_eq_one`・`vecNormSq_eq_one_of_vecNorm_eq_one` | `vecNorm'_eq_one_of_vecNormSq'_eq_one`・`vecNormSq'_eq_one_of_vecNorm'_eq_one`（同じ手順） | なし（具体版と同じ） |

* 係数は具体版と同じ `ℝ` に固定する。`√` が `ℝ` の平方根なので、係数を一般の順序体へ上げる余地は無い。
* このファイルを置くのは、ノルムを使う必要十分版（`RayleighSupAndSectorRayleighSup.lean`・`EvenSectorUpperBound.lean`）が
  具体版の定義を参照せずに済むようにするためである（具体版と必要十分版は互いを参照しない。`lean/README.md`）。
-/
import Ising2D.NecSuf.RealVectorSquaredNorm
import Ising2D.NecSuf.PowerOfOneIsOne
import Mathlib.Analysis.SpecialFunctions.Sqrt

namespace Ising2D.NecSuf

variable {n : Type*} [Fintype n]

/-- `√1 = 1`（具体版 `Ising2D.sqrt_of_real_one_is_one` と同じ手順: `y = 1` が `1 ≥ 0` と `1^2 = 1` を満たし、そのような `y` はただ一つ）。 -/
theorem sqrt_one' : Real.sqrt 1 = 1 := by
  have h1 : (1 : ℝ) ^ 2 = 1 := one_pow' 2                                    -- `1^m = 1`（`m → 2`）
  exact (Real.sqrt_eq_iff_eq_sq zero_le_one zero_le_one).mpr h1.symm

/-- `‖x‖ = √(xᵀx)`（具体版 `Ising2D.vecNorm` と同じ式）。 -/
noncomputable def vecNorm' (x : n → ℝ) : ℝ := Real.sqrt (vecNormSq' x)

/-- `‖x‖² ≥ 0`（具体版 `Ising2D.vecNormSq_nonneg` と同じ手順: 和に開き、各項の二乗が非負）。 -/
theorem vecNormSq'_nonneg (x : n → ℝ) : 0 ≤ vecNormSq' x := by
  rw [vecNormSq'_eq_sum]
  exact Finset.sum_nonneg fun i _ => sq_nonneg _

/-- `‖cx‖² = c²‖x‖²`（具体版 `Ising2D.vecNormSq_smul` と同じ手順: 和に開き、各項の `(c x_i)² = c² x_i²` を外へ出す）。 -/
theorem vecNormSq'_smul (c : ℝ) (x : n → ℝ) :
    vecNormSq' (c • x) = c ^ 2 * vecNormSq' x := by
  simp [vecNormSq'_eq_sum, Finset.mul_sum, mul_pow]

/-- `‖x‖² = 1` から `‖x‖ = √1 = 1`（具体版 `Ising2D.vecNorm_eq_one_of_vecNormSq_eq_one` と同じ手順）。 -/
theorem vecNorm'_eq_one_of_vecNormSq'_eq_one {x : n → ℝ} (h : vecNormSq' x = 1) : vecNorm' x = 1 := by
  rw [vecNorm', h, sqrt_one']

/-- `‖x‖^2 = ‖x‖²`（具体版 `Ising2D.vecNorm_sq` と同じ手順: `√y` の二乗は `y`）。 -/
theorem vecNorm'_sq (x : n → ℝ) : vecNorm' x ^ 2 = vecNormSq' x :=
  Real.sq_sqrt (vecNormSq'_nonneg x)

/-- `‖x‖ = 1` から `‖x‖² = 1`（具体版 `Ising2D.vecNormSq_eq_one_of_vecNorm_eq_one` と同じ手順: `‖x‖^2 = ‖x‖²` を経る）。 -/
theorem vecNormSq'_eq_one_of_vecNorm'_eq_one {x : n → ℝ} (h : vecNorm' x = 1) : vecNormSq' x = 1 := by
  rw [← vecNorm'_sq, h, one_pow]

end Ising2D.NecSuf
