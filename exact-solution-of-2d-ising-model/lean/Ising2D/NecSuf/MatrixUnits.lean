/-
# 必要十分版: 行列単位の積公式と単位元の分解

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明:
`parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ`
(`<centralizer_is_scalar>`) の Step 2 に現れる 2 つの等式

  `E_{IJ} E_{KL} = δ_{JK} E_{IL}`,  `I = Σ_P E_{PP}`

具体版（`Mat(2, ℂ)^{⊗M}` = `TensorPow M` の側）は `Ising2D/Representation.lean` の
`Ising2D.E_mul_E` と `Ising2D.one_eq_sum_E` にあり、いずれも本ファイルの必要十分版からの
特殊化として導出される。

## 必要十分版が何を明らかにするか

* 積公式 `E_{IJ} E_{KL} = δ_{JK} E_{IL}` に効いているのは
  **係数が半環であることだけ**である。係数が ℂ であることも、可換であることも、
  行列が正方であることすら効いていない（4 つの添字は 4 つの別々の型でよく、
  一致が要求されるのは「積がつながる」ための `J`, `K` の型だけである）。
  人手証明が `{1,2}^M` という具体的な添字集合をとっていることも本質的でない。
* 単位元の分解 `I = Σ_P E_{PP}` には、係数が半環であることに加えて
  **添字集合が有限であること**（和が取れること）と**等号判定可能であること**が要る。
-/
import Mathlib.Data.Matrix.Basis

namespace Ising2D
namespace NecSuf

section MatrixUnits

variable {α : Type*} [Semiring α]
variable {l m n : Type*} [DecidableEq l] [DecidableEq m] [DecidableEq n]

/-- **行列単位の積公式の必要十分版**: `E_{ij} E_{kl} = δ_{jk} E_{il}`。

`Matrix.single i j (1 : α)` が人手証明の `E_{ij}` にあたる。
添字の型は 4 つとも独立でよく（`i : l`, `j k : m`, `x : n`）、
係数 `α` は可換でなくてよい。 -/
theorem single_mul_single_eq_ite [Fintype m] (i : l) (j k : m) (x : n) :
    Matrix.single i j (1 : α) * Matrix.single k x (1 : α) =
      if j = k then Matrix.single i x (1 : α) else 0 := by
  by_cases h : j = k
  · subst h
    rw [if_pos rfl, Matrix.single_mul_single_same, one_mul]
  · rw [if_neg h]
    simp [h]

/-- **単位元の分解の必要十分版**: `I = Σ_P E_{PP}`。

mathlib の `Matrix.sum_single_one` の向きを人手証明に合わせただけ。 -/
theorem one_eq_sum_single [Fintype n] :
    (1 : Matrix n n α) = ∑ P : n, Matrix.single P P (1 : α) :=
  Matrix.sum_single_one.symm

end MatrixUnits

end NecSuf
end Ising2D
