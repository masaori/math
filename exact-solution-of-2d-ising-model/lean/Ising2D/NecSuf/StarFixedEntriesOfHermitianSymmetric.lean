/-
# エルミートかつ転置で不変な行列の成分は共役で動かない（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimHermitianAndTransposeInvariantMatrixIsRealSymmetric.lean`
（人手 `hermitian_and_transpose_invariant_matrix_is_real_symmetric`）。
具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimHermitianAndTransposeInvariantMatrixIsRealSymmetricFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 7 行の鎖の 3〜6 行目（共役転置の定義 → `A^* = A` → 転置の定義 → `A^⊤ = A`） | `star_fixed_entries_of_hermitian_symmetric` の `calc` の 4 段 |
| 7 行の鎖の 1・2・7 行目・`−b = b`・`b = 0` の鎖・`A_{kl} = a_ℂ` の鎖（`exists_real_of_star_eq`） | 仮定 `hS` に渡す 1 段 |
| `A^⊤ = A` と合わせて実対称 | `⟨_, hT⟩` |

## 何が効いているか / 効いていないか

- 「`r_ℂ` の形に書ける」（`ℝ` の像に入る）を、係数の型 `R` の任意の性質 `S` に置き換えた。
  効いているのは **共役で動かない元が `S` に入ること**（`hS`）、**`A^* = A`**（`hH`）、**`A^⊤ = A`**（`hT`）だけである。
  具体版の `exists_real_of_star_eq`（`ℂ = ℝ^2` の第 2 成分から `b = 0`）は、`S` を `ℝ` の像に取ったときに `hS` を与える計算で、
  手順（成分を共役で読み、共役転置の定義・`A^* = A`・転置の定義・`A^⊤ = A` で自分自身へ戻し、`hS` に渡す）は同じである。
  `ℂ` で `hS` が成り立つのは `ℝ` で `2` が可逆なこと（`b = ½(b + b)`）による。
- 係数に要る構造は `Star R`（共役が定義されていること）だけで、和・積・`star` の対合性も使わない。
  `ℂ` であることも、体・環であることも効いていない。行列の添字 `n` は任意の型で、有限であることも効いていない。
- 削れない理由: `hT` を落とすと、`ℂ` の行列 `((0, i), (−i, 0))` はエルミートだが成分 `i` は実でない。
  `hH` を落とすと、1 行 1 列の行列 `(i)` は転置で不変だが成分 `i` は実でない。
  `hS` を落とすと、`S` を偽に取れて結論が成り立たない。この 2 つの行列の反例は、ファイル末尾の `example` で確かめてある。
-/
import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.Data.Complex.Basic  -- 末尾の反例の `example` だけが使う

namespace Ising2D.NecSuf

open Matrix

/-- **エルミートかつ転置で不変な正方行列の成分は、共役で動かない元の性質 `S` に入る**
（具体版 `hermitian_and_transpose_invariant_matrix_is_real_symmetric`）。 -/
theorem star_fixed_entries_of_hermitian_symmetric {R n : Type*} [Star R] (S : R → Prop)
    (hS : ∀ x, star x = x → S x) (A : Matrix n n R) (hH : Aᴴ = A) (hT : Aᵀ = A) :
    (∀ p q, S (A p q)) ∧ Aᵀ = A := by
  refine ⟨fun k l => hS (A k l) ?_, hT⟩
  calc star (A k l)
      = Aᴴ l k := rfl                                                       -- 共役転置の定義
    _ = A l k := by rw [hH]                                                 -- `A^* = A`
    _ = Aᵀ k l := rfl                                                       -- 転置の定義
    _ = A k l := by rw [hT]                                                 -- `A^⊤ = A`

/-- `hT` を削れない理由: `((0, i), (−i, 0))` はエルミートだが、成分 `i` は実（`ℝ` の像）でない。 -/
example : (!![0, Complex.I; -Complex.I, 0] : Matrix (Fin 2) (Fin 2) ℂ).IsHermitian ∧
    ¬ ∃ r : ℝ, (!![0, Complex.I; -Complex.I, 0] : Matrix (Fin 2) (Fin 2) ℂ) 0 1 = (r : ℂ) := by
  refine ⟨?_, fun ⟨r, hr⟩ => ?_⟩
  · ext p q
    fin_cases p <;> fin_cases q <;> simp [Matrix.conjTranspose_apply]
  · have := congrArg Complex.im hr
    simp at this

/-- `hH` を削れない理由: 1 行 1 列の行列 `(i)` は転置で不変だが、成分 `i` は実でない。 -/
example : (Matrix.of fun _ _ => Complex.I : Matrix (Fin 1) (Fin 1) ℂ)ᵀ = Matrix.of (fun _ _ => Complex.I) ∧
    ¬ ∃ r : ℝ, (Matrix.of fun _ _ => Complex.I : Matrix (Fin 1) (Fin 1) ℂ) 0 0 = (r : ℂ) := by
  refine ⟨rfl, fun ⟨r, hr⟩ => ?_⟩
  have := congrArg Complex.im hr
  simp at this

end Ising2D.NecSuf
