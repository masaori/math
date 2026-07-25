/-
# スカラー倍の恒等行列は全行列と可換

対応する人手証明:
`parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ`
(`<scalar_identity_commutes>`)

原文: 体 `K`、`n ∈ ℤ_{≥1}`、`c ∈ K`、`A ∈ Mat(n, K)` について `[c · I, A] = 0`。
-/
import Mathlib.Data.Matrix.Basic
import Ising2D.Representation

namespace Ising2D

section General

variable {n : Type*} [Fintype n] [DecidableEq n]
variable {K : Type*} [CommRing K]

/-- **`<scalar_identity_commutes>` の形式化**: `[c · I, A] = (c • I) A - A (c • I) = 0`。 -/
theorem scalar_identity_commutes (c : K) (A : Matrix n n K) :
    (c • (1 : Matrix n n K)) * A - A * (c • (1 : Matrix n n K)) = 0 := by
  simp

/-- 同じ内容を mathlib の `Commute` で述べたもの。 -/
theorem scalar_identity_commute (c : K) (A : Matrix n n K) :
    Commute (c • (1 : Matrix n n K)) A := by
  unfold Commute SemiconjBy
  simp

end General

/-- `TensorPow M`（= `Mat(2, ℂ)^{⊗M}` の推奨表現）での系。 -/
theorem scalar_identity_commutes_tensorPow {M : ℕ} (c : ℂ) (A : TensorPow M) :
    (c • (1 : TensorPow M)) * A - A * (c • (1 : TensorPow M)) = 0 :=
  scalar_identity_commutes c A

end Ising2D
