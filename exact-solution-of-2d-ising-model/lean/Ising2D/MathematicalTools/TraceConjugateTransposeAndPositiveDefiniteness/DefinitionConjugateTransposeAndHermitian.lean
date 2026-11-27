/-
# 共役転置とエルミート行列の定義と、Lean の `Matrix.conjTranspose`・`Matrix.IsHermitian` との一致（具体版）

正本: `structured-latex/content/009_eigenvalues_of_V.ts`（`eigenvalues_of_V_011_definition_hermitian_positive_definite`、
ラベル **`def_hermitian_positive_definite`**）

人手は `A = (A_{kl}) ∈ Mat(n, ℂ)` の共役転置を成分の式 `(A^*)_{kl} := \overline{A_{lk}}`（`\overline{\phantom{z}}` は `def_complex_conjugate`）で定め、
`A^* = A` を満たす `A` をエルミートという。

Lean の `Aᴴ`（mathlib の `Matrix.conjTranspose`）は `Aᴴ k l = star (A l k)` と定義されており、`star` は `def_complex_conjugate` の具体版
`complex_star_mk` の共役である。したがって共役転置の一致は定義を開くだけで示せる（`rfl`）。
- 添字が `Fin n` の行列（本文の `Mat(n, ℂ)`。人手の番号 `k ∈ {1,…,n}` は Lean の `k : Fin n` を `finIndexToZZ n` で送った値）は
  `matrix_fin_conjTranspose_apply`。
- 添字が `Conf M` の行列（本文の `Mat(2^M, ℂ)`）は、成分の式が各成分だけで閉じるので、`DefinitionMatrixOperationsOverMultiIndices.lean` の
  符号反転・差と同じく番号 `k = ν(K)`・`l = ν(L)` で読んだものを `Conf M` の添字のまま書く（`matrix_conf_conjTranspose_apply`）。
  `def_kronecker` の「`I` を番号 `ν(I)` と同一視する」に頼ることも同じである。
- エルミート（`A^* = A`）は mathlib の `A.IsHermitian` の定義 `Aᴴ = A` そのものである（`matrix_conf_isHermitian_iff`。`Iff.rfl`）。

人手の本文は演算と性質の名前を定めるだけで、Lean の定義との一致の主張を持たない。補題は Lean だけの段であり、
定義の一致を述べる補題なので、必要十分版は置かない。
-/
import Mathlib.LinearAlgebra.Matrix.Hermitian
import Ising2D.Basic

namespace Ising2D

open Matrix

/-- **`def_hermitian_positive_definite`**（共役転置、`Mat(n, ℂ)`）: Lean の `Matrix (Fin n) (Fin n) ℂ` の共役転置の成分は、本文の
`(A^*)_{kl} := \overline{A_{lk}}` である（Lean だけの段の補題。冒頭の説明を見よ）。 -/
theorem matrix_fin_conjTranspose_apply {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (k l : Fin n) :
    Aᴴ k l = star (A l k) :=
  rfl                                                     -- mathlib の共役転置は成分の共役を転置の位置に置く

/-- **`def_hermitian_positive_definite`**（共役転置、`Mat(2^M, ℂ)`）: Lean の `Matrix (Conf M) (Conf M) ℂ` の共役転置の成分は、本文の
`(A^*)_{kl} := \overline{A_{lk}}` を番号 `k = ν(K)`・`l = ν(L)` で読んだもの `(A^*)_{KL} = \overline{A_{LK}}` である
（Lean だけの段の補題。冒頭の説明を見よ）。 -/
theorem matrix_conf_conjTranspose_apply {M : ℕ} (A : Matrix (Conf M) (Conf M) ℂ) (K L : Conf M) :
    Aᴴ K L = star (A L K) :=
  rfl                                                     -- mathlib の共役転置は成分の共役を転置の位置に置く

/-- **`def_hermitian_positive_definite`**（エルミート、`Mat(2^M, ℂ)`）: Lean の `A.IsHermitian` は、本文の「`A^* = A` を満たすとき
`A` はエルミートであるという」の `A^* = A` である（Lean だけの段の補題。冒頭の説明を見よ）。 -/
theorem matrix_conf_isHermitian_iff {M : ℕ} (A : Matrix (Conf M) (Conf M) ℂ) :
    A.IsHermitian ↔ Aᴴ = A :=
  Iff.rfl                                                 -- mathlib の `IsHermitian` は `Aᴴ = A` と定義されている

end Ising2D
