/-
# 実ベクトルのノルムの二乗とノルム（必要十分版からの導出）

具体版 `RealMatrixBilinearFormAndNorm.lean` の `Ising2D.vecNormSq` と、必要十分版
`Ising2D/NecSuf/RealVectorSquaredNorm.lean` の `NecSuf.vecNormSq'` は、同じ式 `x ⬝ᵥ x` で定義した同じ値である
（対応する人手の項目は無い補助の定義）。具体版の `Ising2D.vecNorm` と必要十分版 `Ising2D/NecSuf/RealVectorNorm.lean` の
`NecSuf.vecNorm'` も、同じ式 `√(x ⬝ᵥ x)` で定義した同じ値である。具体版 `mulVec_dotProduct_selfadjoint` は、
係数を可換半環へ上げた必要十分版 `NecSuf.mulVec_dotProduct_selfadjoint'`（`NecSuf/RayleighSupAndSectorRayleighSup.lean`）の係数を `ℝ` にしたものである。必要十分版の主張（`NecSuf.vecNormSq_absVec` など）から具体版を導くときは、
この一致で具体版の `vecNormSq` へ読み替える。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.NecSuf.RealVectorSquaredNorm
import Ising2D.NecSuf.RealVectorNorm
import Ising2D.NecSuf.RayleighSupAndSectorRayleighSup

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

/-- 具体版の `‖x‖²` は、必要十分版の `‖x‖²` と一致する（同じ式の定義）。 -/
theorem vecNormSq_eq_vecNormSq_necSuf (x : n → ℝ) : vecNormSq x = NecSuf.vecNormSq' x :=
  rfl

/-- 具体版の `‖x‖` は、必要十分版の `‖x‖` と一致する（同じ式の定義）。 -/
theorem vecNorm_eq_vecNorm_necSuf (x : n → ℝ) : vecNorm x = NecSuf.vecNorm' x :=
  rfl

/-- 具体版 `mulVec_dotProduct_selfadjoint` は、必要十分版 `NecSuf.mulVec_dotProduct_selfadjoint'` の係数を `ℝ` にしたもの。 -/
theorem mulVec_dotProduct_selfadjoint_of_necSuf {A : Matrix n n ℝ} (hA : A.IsSymm) (x y : n → ℝ) :
    x ⬝ᵥ A *ᵥ y = (A *ᵥ x) ⬝ᵥ y :=
  NecSuf.mulVec_dotProduct_selfadjoint' hA x y

end Ising2D
