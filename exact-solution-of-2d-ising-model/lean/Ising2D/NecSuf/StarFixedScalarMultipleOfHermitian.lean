/-
# 共役で動かないスカラーによるエルミート行列のスカラー倍はエルミート（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealMultipleOfHermitianIsHermitian.lean`
（人手 `real_multiple_of_hermitian_is_hermitian`）。
具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealMultipleOfHermitianIsHermitianFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 1・2 行目（共役転置の定義 → スカラー倍の定義） | 同じ 2 段 |
| 3 行目 `complex_conjugate_of_product` | 仮定 `hmul : star (α * a) = star α * star a` |
| 4 行目 `complex_conjugate_of_real_inclusion` | 仮定 `hα : star α = α` |
| 5〜7 行目（共役転置の定義 → `A^* = A` → スカラー倍の定義） | 同じ 3 段 |

## 何が効いているか / 効いていないか

- 実数 `α` を、係数の型 `R` の **共役で動かない元**（`hα : star α = α`）に置き換えた。具体版の 4 行目は、
  `α` を実数に取ったときに `hα` を与える計算（`complex_conjugate_of_real_inclusion`）で、手順は同じである。
- 具体版の 3 行目 `complex_conjugate_of_product`（`\overline{zw} = \overline{z}\,\overline{w}`、積の順を保つ）は、
  `α` を左から掛けた積についてだけ使うので、その形のまま仮定 `hmul` にした。
- 係数に要る構造は、積（`Mul`）と共役（`Star`）が定義されていることだけである。積の可換性・結合性、
  `star` の対合性（`star (star x) = x`）、和・零・単位元・体であることは使わない。添字 `n` は任意の型で、有限であることも効いていない。
- 削れない理由: `hα` を落とすと、`α := i`、`A := (1)`（1 行 1 列）で `(iA)^* = (−i) ≠ (i)` となる（ファイル末尾の `example`）。
  `hmul` を落とすと、積の順を逆にする共役（例えば `R := Mat(2,ℂ)`、`star` を共役転置）では、エルミートな
  `α := diag(1, 2)` と、成分 `a := ((0,1),(1,0))` の 1 行 1 列の行列 `A` について `(αA)^* = (a α) ≠ (α a) = αA` となる。
-/
import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.Data.Complex.Basic  -- 末尾の反例の `example` だけが使う

namespace Ising2D.NecSuf

open Matrix

/-- **共役で動かないスカラーによるエルミート行列のスカラー倍はエルミート**（具体版 `real_multiple_isHermitian`）。 -/
theorem star_fixed_smul_isHermitian {R n : Type*} [Mul R] [Star R] {α : R}
    (hmul : ∀ a : R, star (α * a) = star α * star a) (hα : star α = α)
    {A : Matrix n n R} (hA : Aᴴ = A) : (α • A)ᴴ = α • A := by
  ext k l
  calc (α • A)ᴴ k l
      = star ((α • A) l k) := rfl                                           -- 共役転置の定義
    _ = star (α * A l k) := rfl                                             -- スカラー倍の定義
    _ = star α * star (A l k) := hmul (A l k)                               -- 仮定 `hmul`（積と共役）
    _ = α * star (A l k) := by rw [hα]                                      -- 仮定 `hα`
    _ = α * Aᴴ k l := rfl                                                   -- 共役転置の定義
    _ = α * A k l := by rw [hA]                                             -- `A^* = A`
    _ = (α • A) k l := rfl                                                  -- スカラー倍の定義

/-- `hα` を削れない理由: `α := i`、`A := (1)` で `(iA)^* ≠ iA`。 -/
example : (1 : Matrix (Fin 1) (Fin 1) ℂ)ᴴ = 1 ∧
    (Complex.I • (1 : Matrix (Fin 1) (Fin 1) ℂ))ᴴ ≠ Complex.I • (1 : Matrix (Fin 1) (Fin 1) ℂ) := by
  refine ⟨Matrix.conjTranspose_one, fun h => ?_⟩
  have h00 := congrFun (congrFun h 0) 0
  simp [Matrix.conjTranspose_apply, Complex.ext_iff] at h00
  norm_num at h00

end Ising2D.NecSuf
