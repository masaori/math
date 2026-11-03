/-
# 転置で不変で、成分が共役で動かない行列はエルミート（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealSymmetricMatrixIsHermitian.lean`
（人手 `real_symmetric_matrix_is_hermitian`）。
具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealSymmetricMatrixIsHermitianFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `r` を取る段と、成分の鎖の 1 行目（共役転置の定義） | `hermitian_of_star_fixed_symmetric_entries` の 1 段目 |
| 成分の鎖の 2〜4 行目（`r` の取り方 → `complex_conjugate_of_real_inclusion` → `r` の取り方） | 仮定 `hA l k` を、共役で動かないこと `hS` に渡す 1 段 |
| 成分の鎖の 5・6 行目（`def_matrix_transpose` → `A^⊤ = A`） | 同じ 2 段 |

## 何が効いているか / 効いていないか

- 「`r_ℂ` の形に書ける」（`ℝ` の像に入る）を、係数の型 `R` の任意の性質 `S` に置き換えた。
  効いているのは **`S` に入る元が共役（`star`）で動かないこと**（`hS`）と、**転置で不変なこと**（`hT`）だけである。
  具体版の 2〜4 段目（実数 `r` を取り出して `\overline{r_ℂ} = r_ℂ` を使う段）は、`S` を `ℝ` の像に取ったときに `hS` を与える計算で、
  手順（成分を共役転置の定義で読み、共役で動かないことに渡し、転置の定義と転置での不変性で戻す）は同じである。
- 係数に要る構造は `Star R`（共役が定義されていること）だけで、和・積・`star` の対合性（`star (star x) = x`）も使わない。
  `ℂ` であることも、体・環であることも効いていない。行列の添字 `n` は任意の型で、有限であることも効いていない。
- 削れない理由: `hS` を落とすと、`S` を「すべての元」に取れて、`ℂ` の行列 `(i)`（1 行 1 列）は転置で不変だがエルミートでない。
  `hT` を落とすと、`ℂ` の行列 `((0, 1), (0, 0))` は成分が実数（`star` で動かない）だがエルミートでない。
  この 2 つの反例は、ファイル末尾の `example` で確かめてある。
-/
import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.Data.Complex.Basic  -- 末尾の反例の `example` だけが使う

namespace Ising2D.NecSuf

open Matrix

/-- **共役で動かない性質に成分がすべて入り、転置で不変な正方行列はエルミート**（具体版 `real_symmetric_isHermitian`）。 -/
theorem hermitian_of_star_fixed_symmetric_entries {R n : Type*} [Star R] (S : R → Prop)
    (hS : ∀ x, S x → star x = x) (A : Matrix n n R) (hA : ∀ p q, S (A p q)) (hT : Aᵀ = A) :
    A.IsHermitian := by
  show Aᴴ = A
  ext k l
  calc Aᴴ k l
      = star (A l k) := rfl                                                 -- 共役転置の定義
    _ = A l k := hS (A l k) (hA l k)                                        -- 仮定 `hA l k` を、共役で動かないこと `hS` に
    _ = Aᵀ k l := rfl                                                       -- 転置の定義
    _ = A k l := by rw [hT]                                                 -- `A^⊤ = A`

/-- `hS` を削れない理由: 1 行 1 列の行列 `(i)` は転置で不変だがエルミートでない。 -/
example : (Matrix.of fun _ _ => Complex.I : Matrix (Fin 1) (Fin 1) ℂ)ᵀ = Matrix.of (fun _ _ => Complex.I) ∧
    ¬ Matrix.IsHermitian (Matrix.of fun _ _ => Complex.I : Matrix (Fin 1) (Fin 1) ℂ) := by
  refine ⟨rfl, fun h => ?_⟩
  have h00 := congrFun (congrFun h 0) 0
  simp [Matrix.conjTranspose_apply, Complex.ext_iff] at h00
  norm_num at h00

/-- `hT` を削れない理由: 成分が実数の行列 `((0, 1), (0, 0))` はエルミートでない。 -/
example : (∀ p q, star ((!![0, 1; 0, 0] : Matrix (Fin 2) (Fin 2) ℂ) p q) = (!![0, 1; 0, 0] : Matrix (Fin 2) (Fin 2) ℂ) p q) ∧
    ¬ (!![0, 1; 0, 0] : Matrix (Fin 2) (Fin 2) ℂ).IsHermitian := by
  refine ⟨fun p q => ?_, fun h => ?_⟩
  · fin_cases p <;> fin_cases q <;> simp
  · have h01 := congrFun (congrFun h 0) 1
    simp [Matrix.conjTranspose_apply] at h01

end Ising2D.NecSuf
