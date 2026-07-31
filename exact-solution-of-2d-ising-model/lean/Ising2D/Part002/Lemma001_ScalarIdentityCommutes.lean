/-
# スカラー倍の恒等行列は全行列と可換

対応する人手証明:
`parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ`
(`<scalar_identity_commutes>`)

原文: 体 `K`、`n ∈ ℤ_{≥1}`、`c ∈ K`、`A ∈ Mat(n, K)` について `[c · I, A] = 0`。

## 2 本立て（`exact-solution-of-2d-ising-model/README.md` 4 節）

* **具体版**（このファイル）: 原文と 1 対 1 に対応する形、すなわち体 `K` 上の
  `n × n` 行列 `Mat(n, K) = Matrix (Fin n) (Fin n) K` について述べる
  （`scalar_identity_commutes_fin`）。
* **必要十分版**: `Ising2D/NecSuf/ScalarCentral.lean` の
  `Ising2D.NecSuf.smul_one_commute` / `Ising2D.NecSuf.smul_one_sub_comm`
  （任意の `S`-代数）。**具体版はすべてこの必要十分版の特殊化として導出する**（下記）。

必要十分版が示しているのは、この主張に効いているのが**スカラー作用と積の両立則だけ**であり、
行列であること・係数が体であること・次数 `n ≥ 1` は一切効いていない、ということである。
-/
import Mathlib.Data.Matrix.Basic
import Ising2D.NecSuf.ScalarCentral
import Ising2D.Representation

namespace Ising2D

section General

variable {n : Type*} [Fintype n] [DecidableEq n]
variable {K : Type*} [CommRing K]

/-- **`<scalar_identity_commutes>` の形式化**: `[c · I, A] = (c • I) A - A (c • I) = 0`。

必要十分版 `Ising2D.NecSuf.smul_one_sub_comm` を `R := Matrix n n K` へ特殊化したもの。 -/
theorem scalar_identity_commutes (c : K) (A : Matrix n n K) :
    (c • (1 : Matrix n n K)) * A - A * (c • (1 : Matrix n n K)) = 0 :=
  NecSuf.smul_one_sub_comm c A

/-- 同じ内容を mathlib の `Commute` で述べたもの（必要十分版 `NecSuf.smul_one_commute` の特殊化）。 -/
theorem scalar_identity_commute (c : K) (A : Matrix n n K) :
    Commute (c • (1 : Matrix n n K)) A :=
  NecSuf.smul_one_commute c A

end General

/-! ## 原文と 1 対 1 に対応する形

原文は「体 `K`、`n ∈ ℤ_{≥1}`、`A ∈ Mat(n, K)`」と述べているので、その通りの形でも立てる。
`Mat(n, K)` は `Matrix (Fin n) (Fin n) K` である。

仮定 `1 ≤ n` は**証明では使わない**。必要十分版から分かるとおり `n = 0`（自明な零環）でも
主張は成り立つので、原文の `n ≥ 1` はこの主張にとって本質的な仮定ではない。
原文との対応を明示するために引数としては残してある。 -/
theorem scalar_identity_commutes_fin {K : Type*} [Field K] {n : ℕ} (_hn : 1 ≤ n)
    (c : K) (A : Matrix (Fin n) (Fin n) K) :
    (c • (1 : Matrix (Fin n) (Fin n) K)) * A - A * (c • (1 : Matrix (Fin n) (Fin n) K)) = 0 :=
  scalar_identity_commutes c A

/-- `TensorPow M`（= `Mat(2, ℂ)^{⊗M}` の推奨表現）での系。 -/
theorem scalar_identity_commutes_tensorPow {M : ℕ} (c : ℂ) (A : TensorPow M) :
    (c • (1 : TensorPow M)) * A - A * (c • (1 : TensorPow M)) = 0 :=
  scalar_identity_commutes c A

end Ising2D
