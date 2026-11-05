/-
# 正定値行列の正の元の倍は正定値（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPositiveRealMultiplePreservesPositiveDefinite.lean`
（人手 `positive_real_multiple_preserves_positive_definite`）。具体版をこのファイルの特殊化として導くのは
`.../ClaimPositiveRealMultiplePreservesPositiveDefiniteFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| エルミート性（`real_multiple_isHermitian`） | `star_fixed_smul_isHermitian`（`NecSuf/StarFixedScalarMultipleOfHermitian.lean`） |
| `conjugate_bilinear_value_of_positive_real_multiple` の 1〜9 段（4 段目は `ℂ` の積の可換律） | `conjBilin_smul'` の 1〜9 段（同じ並び。4 段目は仮定 `hcomm`） |
| 同じ鎖の 10〜13 段（`α_ℂ r_ℂ = (αr)_ℂ`、`definition_of_cc` の積と ℝ の四則） | `conjBilin_smul'` の 10 段目、仮定 `hincl`（包含は積を保つ） |
| `α, r ∈ ℝ_{>0}` なので `αr ∈ ℝ_{>0}` | `smul_preserves_pos'` の `mul_pos` |

## 何が効いているか / 効いていないか

- **鎖の 1〜9 段に効いているのは、係数の積の結合律と左分配律（`Finset.mul_sum`）と、`ι(α)` が係数の全ての元と交換すること
  （仮定 `hcomm`。4 段目の `\overline{x_k}` と `ι(α)` の入れ替え）だけである。** 係数全体の積の可換律は効いていない。
  `hcomm` を落とすと 4 段目が通らず、実際に `x^*(αA)x = α(x^*Ax)` は一般に成り立たない（`R := Mat(2,ℂ)` と 1 行 1 列の行列で、
  `α` と `\overline{x_1}` が交換しなければ両辺は違う）。符号反転・逆元は使わないので、環でなく半環でよい（単位元は鎖では使わないが、
  `x^*Ay` の式 `conjBilin'` が `Semiring` の上で定義してあるので要る）。共役は写像 `star : R → R` があるだけでよく、
  その性質（積・和を保つ、対合）は使わない。
- **10〜13 段に効いているのは、包含 `ι : S → R` が積を保つこと（仮定 `hincl`）だけである。** 具体版はこれを `ℂ` の積の定義から
  4 段で計算する（人手の `real_inclusion_preserves_product` と同じ計算）。`hincl` を落とすと、10 段目で `ι(α)ι(r)` を
  `ι(αr)` へつなぐ手段が無くなり、`x^*(ι(α)A)x` が正の元の包含であることが言えない。包含が和を保つこと・単射であることは効いていない。
- **正値性に効いているのは、`S` で正の元どうしの積が正であること（`mul_pos`。`MulZeroClass`・`Preorder`・`PosMulStrictMono`）だけである。**
  `PosMulStrictMono` を落とすと `0 < αr` が出ない（`mul_pos` は `α · 0 = 0` を使うので `MulZeroClass` も要る）。
  `S = ℝ` であること、ℝ の和・完備性は効いていない。`R` の順序も使わない（正値性は「正の元の包含である」の形で受け渡す。
  `NecSuf/TraceOfPositiveDefinite.lean` と同じ形）。
- 添字は `Fin n` でなくてよい。有限なら（和のため）何でもよい。
-/
import Ising2D.NecSuf.TraceOfPositiveDefinite
import Mathlib.Algebra.Order.GroupWithZero.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι : Type*} [Fintype ι] {R : Type*} [Semiring R] [Star R] {S : Type*}

/-- **`x^*Ax = ι(r)` なら `x^*(ι(α)A)x = ι(αr)`**（具体版 `conjugate_bilinear_value_of_positive_real_multiple`。
1〜9 段の並びは同じで、具体版の 10〜13 段が仮定 `hincl` の 1 段に当たる）。 -/
theorem conjBilin_smul' [Mul S] (incl : S → R) (hincl : ∀ a b : S, incl a * incl b = incl (a * b))
    (α : S) (hcomm : ∀ y : R, y * incl α = incl α * y)
    (A : Matrix ι ι R) (x : ι → R) {r : S} (hr : conjBilin' x A x = incl r) :
    conjBilin' x (incl α • A) x = incl (α * r) :=
  calc conjBilin' x (incl α • A) x
      = ∑ k, ∑ l, (star (x k) * (incl α • A) k l) * x l := rfl                  -- `x^*Ay` の式
    _ = ∑ k, ∑ l, (star (x k) * (incl α * A k l)) * x l := rfl                  -- スカラー倍の定義を各項へ
    _ = ∑ k, ∑ l, ((star (x k) * incl α) * A k l) * x l := by
        simp only [← mul_assoc (star (x _))]                                      -- 積の結合律を各項へ
    _ = ∑ k, ∑ l, ((incl α * star (x k)) * A k l) * x l := by
        simp only [hcomm (star (x _))]                                            -- 仮定 `hcomm`（`ι(α)` は交換する）を各項へ
    _ = ∑ k, ∑ l, (incl α * (star (x k) * A k l)) * x l := by
        simp only [mul_assoc (incl α) (star (x _)) (A _ _)]                       -- 積の結合律を各項へ
    _ = ∑ k, ∑ l, incl α * ((star (x k) * A k l) * x l) := by
        simp only [mul_assoc (incl α) (star (x _) * A _ _)]                       -- 積の結合律を各項へ
    _ = incl α * ∑ k, ∑ l, (star (x k) * A k l) * x l := by
        simp only [Finset.mul_sum]                                                -- 左分配律
    _ = incl α * conjBilin' x A x := rfl                                          -- `x^*Ay` の式
    _ = incl α * incl r := by rw [hr]                                             -- `r` の取り方
    _ = incl (α * r) := hincl α r                                                 -- 仮定 `hincl`（包含は積を保つ）

/-- **正値性の段**（具体版 `positive_real_multiple_preserves_positive_definite` の正値性）: 零でない全ての `x` で
`x^*Ax` が正の元の包含なら、`0 < α` のとき `x^*(ι(α)A)x` も正の元の包含である。 -/
theorem smul_preserves_pos' [MulZeroClass S] [Preorder S] [PosMulStrictMono S]
    (incl : S → R) (hincl : ∀ a b : S, incl a * incl b = incl (a * b)) {α : S} (hα : 0 < α)
    (hcomm : ∀ y : R, y * incl α = incl α * y) {A : Matrix ι ι R}
    (hA : ∀ x : ι → R, x ≠ 0 → ∃ r : S, 0 < r ∧ conjBilin' x A x = incl r) (x : ι → R) (hx : x ≠ 0) :
    ∃ s : S, 0 < s ∧ conjBilin' x (incl α • A) x = incl s := by
  obtain ⟨r, hr, hrA⟩ := hA x hx                                                 -- `A` の正値性
  exact ⟨α * r, mul_pos hα hr, conjBilin_smul' incl hincl α hcomm A x hrA⟩      -- 正の元の積は正

end Ising2D.NecSuf
