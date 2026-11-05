/-
# 共役転置の積・線型結合の法則と、共役転置は行列のノルムと行列の列の極限を保つこと（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimStarPreservesNormAndLimits.lean`
（人手 `star_preserves_norm_and_limits`）。
具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimStarPreservesNormAndLimitsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_conjTranspose_mul_apply` の 7 段（共役転置の定義 → 積の定義 → 共役と有限和 → 共役と積を各項へ → 積の可換性を各項へ → 共役転置の定義を各項へ → 積の定義） | `conjTranspose_mul_matrix_apply'` の同じ 7 段（共役と有限和は仮定 `hsum`、共役と積は仮定 `hmul`） |
| `matrix_conjTranspose_add_smul_apply` の 8 段 | `conjTranspose_add_smul_matrix_apply'` の同じ 8 段（共役と 2 項の和は仮定 `hadd`、共役と積は仮定 `hmul`） |
| `matrix_conjTranspose_norm` の 5 段（ノルムの定義 → 共役転置の定義を各項へ → 共役はノルムを保つ → 有限和の順序の入れ替え → ノルムの定義） | `conjTranspose_norm'` の同じ 5 段（共役はノルムを保つは仮定 `hnorm`） |
| `matrix_conjTranspose_sub_apply` の 5 段 | `conjTranspose_sub_matrix_apply'` の同じ 5 段（共役と差は仮定 `hsub`） |
| `matrix_conjTranspose_tendsto` の各 `N` の 2 段と、列の書き換え | `conjTranspose_tendsto'` の同じ段 |

## 何が効いているか / 効いていないか

共役 `star` には `Star R` の演算だけを置き、具体版が引いた複素共役の性質は、使った形のまま仮定にした。
共役が対合であること（`\overline{\overline{z}} = z`）は、どの段にも効いていない。

- **(1) の第 1 式**: 効いているのは、共役が有限和と交換すること（`hsum`）、共役が積を同じ順の積へ移すこと（`hmul`）、
  **係数の積の交換律**（`CommMagma R`）だけである。`AddCommMonoid R` は行列の積の成分の有限和（`Finset.sum`）に要る。
  交換律は具体版の 5 段目（積の可換性を各項へ）が使い、この手順では削れない。`hmul` は共役が積の順を保つ形なので、
  交換律が無いと `(AB)^*` の成分 `Σ \overline{A_{lj}}\,\overline{B_{jk}}` と `(B^*A^*)` の成分 `Σ \overline{B_{jk}}\,\overline{A_{lj}}` が一致しない
  （反例: 係数を 2×2 の有理数行列の環に取り、`star` を恒等写像にすると `hsum`・`hmul` は成り立つが、1 行 1 列の行列 `A = (a)`, `B = (b)` で
  主張は `ab = ba` になり、`ab ≠ ba` の `a, b` で崩れる）。共役が積の順を逆にする係数（mathlib の `StarMul`）なら交換律無しで主張は成り立つが、
  それは 4 段目と 5 段目を 1 段にまとめる別の手順である。
- **(1) の第 2 式**: 効いているのは、共役が 2 項の和と交換すること（`hadd`）と `hmul` だけである。
  **交換律は効いていない**（スカラー倍の段は `α * A_{lk}` の形を保ったまま共役を各因子へ配るだけである）。
  加法の結合則・交換則・零も使わない（係数は `Add R`・`Mul R` だけ）。
- **(2)**: 係数の型 `α` は、Frobenius ノルムが定まるための `SeminormedAddCommGroup` と、共役 `Star α` と、共役が成分のノルムを保つこと（`hnorm`）だけである。
  この型クラスの公理（三角不等式・加法群であること）は証明の段には効かず、mathlib の Frobenius ノルムが定義されるためにだけ要る
  （`TransposePreservesMatrixNormAndLimits.lean` と同じ）。
- **(3)**: (2) の仮定に、共役が差と交換すること（`hsub`）を足しただけである。準備の `A_N^* − A^* = (A_N − A)^*` の段には、
  係数の差 `Sub α` と `Star α` と `hsub` しか効かず、ノルムも添字の有限性も効いていない。列の添字が `ℕ` であることも効かず、
  任意のフィルタでの収束について同じ手順で通る。
- 添字はいずれも任意の型でよく、正方であることも `Fin n` の番号付けも効いていない。有限であることは、積の成分とノルムの定義の和が有限和であるために要る。
-/
import Mathlib.Analysis.Matrix.Normed

namespace Ising2D.NecSuf

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusSeminormedAddCommGroup

section Product

variable {ι σ κ R : Type*} [Fintype σ] [CommMagma R] [AddCommMonoid R] [Star R]

/-- **(1) の第 1 式**の成分の鎖（具体版 `matrix_conjTranspose_mul_apply`）。 -/
theorem conjTranspose_mul_matrix_apply'
    (hsum : ∀ f : σ → R, star (∑ j, f j) = ∑ j, star (f j))
    (hmul : ∀ a b : R, star (a * b) = star a * star b)
    (A : Matrix ι σ R) (B : Matrix σ κ R) (k : κ) (l : ι) :
    (A * B)ᴴ k l = (Bᴴ * Aᴴ) k l :=
  calc (A * B)ᴴ k l
      = star ((A * B) l k) := rfl                                             -- 共役転置の定義
    _ = star (∑ j, A l j * B j k) := rfl                                      -- 積の定義
    _ = ∑ j, star (A l j * B j k) := hsum _                                   -- 共役と有限和
    _ = ∑ j, star (A l j) * star (B j k) :=
        Finset.sum_congr rfl fun _ _ => hmul _ _                              -- 共役と積を各項へ
    _ = ∑ j, star (B j k) * star (A l j) :=
        Finset.sum_congr rfl fun _ _ => mul_comm _ _                          -- 係数の積の交換律を各項へ
    _ = ∑ j, Bᴴ k j * Aᴴ j l := rfl                                           -- 共役転置の定義を各項へ
    _ = (Bᴴ * Aᴴ) k l := rfl                                                  -- 積の定義

/-- **(1) の第 1 式**（具体版 `matrix_conjTranspose_mul`）。 -/
theorem conjTranspose_mul_matrix'
    (hsum : ∀ f : σ → R, star (∑ j, f j) = ∑ j, star (f j))
    (hmul : ∀ a b : R, star (a * b) = star a * star b)
    (A : Matrix ι σ R) (B : Matrix σ κ R) : (A * B)ᴴ = Bᴴ * Aᴴ :=
  Matrix.ext (conjTranspose_mul_matrix_apply' hsum hmul A B)   -- すべての成分が等しい

end Product

section LinearCombination

variable {ι κ R : Type*} [Add R] [Mul R] [Star R]

/-- **(1) の第 2 式**の成分の鎖（具体版 `matrix_conjTranspose_add_smul_apply`）。交換律は使わない。 -/
theorem conjTranspose_add_smul_matrix_apply'
    (hadd : ∀ a b : R, star (a + b) = star a + star b)
    (hmul : ∀ a b : R, star (a * b) = star a * star b)
    (α β : R) (A B : Matrix ι κ R) (k : κ) (l : ι) :
    (α • A + β • B)ᴴ k l = (star α • Aᴴ + star β • Bᴴ) k l :=
  calc (α • A + β • B)ᴴ k l
      = star ((α • A + β • B) l k) := rfl                                     -- 共役転置の定義
    _ = star ((α • A) l k + (β • B) l k) := rfl                               -- 和の定義
    _ = star (α * A l k + β * B l k) := rfl                                   -- スカラー倍の定義
    _ = star (α * A l k) + star (β * B l k) := hadd _ _                       -- 共役と 2 項の和
    _ = star α * star (A l k) + star β * star (B l k) := by
        rw [hmul, hmul]                                                       -- 共役と積を各項へ
    _ = star α * Aᴴ k l + star β * Bᴴ k l := rfl                              -- 共役転置の定義を各項へ
    _ = (star α • Aᴴ) k l + (star β • Bᴴ) k l := rfl                          -- スカラー倍の定義
    _ = (star α • Aᴴ + star β • Bᴴ) k l := rfl                                -- 和の定義

/-- **(1) の第 2 式**（具体版 `matrix_conjTranspose_add_smul`）。 -/
theorem conjTranspose_add_smul_matrix'
    (hadd : ∀ a b : R, star (a + b) = star a + star b)
    (hmul : ∀ a b : R, star (a * b) = star a * star b)
    (α β : R) (A B : Matrix ι κ R) :
    (α • A + β • B)ᴴ = star α • Aᴴ + star β • Bᴴ :=
  Matrix.ext (conjTranspose_add_smul_matrix_apply' hadd hmul α β A B)   -- すべての成分が等しい

end LinearCombination

section Difference

variable {m n α : Type*} [Sub α] [Star α]

/-- **(3) の準備**の成分の鎖（具体版 `matrix_conjTranspose_sub_apply`）。 -/
theorem conjTranspose_sub_matrix_apply' (hsub : ∀ a b : α, star (a - b) = star a - star b)
    (AN A : Matrix m n α) (k : n) (l : m) :
    (ANᴴ - Aᴴ) k l = (AN - A)ᴴ k l :=
  calc (ANᴴ - Aᴴ) k l
      = ANᴴ k l - Aᴴ k l := rfl                                               -- 差の定義
    _ = star (AN l k) - star (A l k) := rfl                                   -- 共役転置の定義を各項へ
    _ = star (AN l k - A l k) := (hsub _ _).symm                              -- 共役と差
    _ = star ((AN - A) l k) := rfl                                            -- 差の定義
    _ = (AN - A)ᴴ k l := rfl                                                  -- 共役転置の定義

/-- **(3) の準備**（具体版 `matrix_conjTranspose_sub`）。 -/
theorem conjTranspose_sub_matrix' (hsub : ∀ a b : α, star (a - b) = star a - star b)
    (AN A : Matrix m n α) : ANᴴ - Aᴴ = (AN - A)ᴴ :=
  Matrix.ext (conjTranspose_sub_matrix_apply' hsub AN A)   -- すべての成分が等しい

end Difference

section NormAndLimits

variable {m n α : Type*} [Fintype m] [Fintype n] [SeminormedAddCommGroup α] [Star α]

/-- **(2)**（具体版 `matrix_conjTranspose_norm`）。 -/
theorem conjTranspose_norm' (hnorm : ∀ a : α, ‖star a‖ = ‖a‖) (A : Matrix m n α) : ‖Aᴴ‖ = ‖A‖ :=
  calc ‖Aᴴ‖
      = (∑ k, ∑ l, ‖Aᴴ k l‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := Matrix.frobenius_norm_def _   -- ノルムの定義
    _ = (∑ k, ∑ l, ‖star (A l k)‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := rfl                   -- 共役転置の定義を各項へ
    _ = (∑ k, ∑ l, ‖A l k‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := by simp only [hnorm]         -- 共役はノルムを保つ（各項へ）
    _ = (∑ l, ∑ k, ‖A l k‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := by rw [Finset.sum_comm]      -- 有限和の順序の入れ替え
    _ = ‖A‖ := (Matrix.frobenius_norm_def A).symm                                   -- ノルムの定義

/-- **(3)**（具体版 `matrix_conjTranspose_tendsto`）。 -/
theorem conjTranspose_tendsto' {ι : Type*} {l : Filter ι}
    (hnorm : ∀ a : α, ‖star a‖ = ‖a‖) (hsub : ∀ a b : α, star (a - b) = star a - star b)
    (A : ι → Matrix m n α) (Alim : Matrix m n α)
    (h : Tendsto (fun N => ‖A N - Alim‖) l (𝓝 0)) :
    Tendsto (fun N => ‖(A N)ᴴ - Alimᴴ‖) l (𝓝 0) := by
  have heq : ∀ N, ‖(A N)ᴴ - Alimᴴ‖ = ‖A N - Alim‖ := fun N =>
    calc ‖(A N)ᴴ - Alimᴴ‖
        = ‖(A N - Alim)ᴴ‖ := by rw [conjTranspose_sub_matrix' hsub]           -- 準備
      _ = ‖A N - Alim‖ := conjTranspose_norm' hnorm _                         -- (2) の `A → A_N − A`
  rw [funext heq]
  exact h

end NormAndLimits

end Ising2D.NecSuf
