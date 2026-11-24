/-
# 実ベクトルのノルムの二乗（必要十分版からの導出）

具体版 `RealMatrixBilinearFormAndNorm.lean` の `Ising2D.vecNormSq` と、必要十分版
`Ising2D/NecSuf/RealVectorSquaredNorm.lean` の `NecSuf.vecNormSq'` は、同じ式 `x ⬝ᵥ x` で定義した同じ値である
（対応する人手の項目は無い補助の定義）。必要十分版の主張（`NecSuf.vecNormSq_absVec` など）から具体版を導くときは、
この一致で具体版の `vecNormSq` へ読み替える。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.NecSuf.RealVectorSquaredNorm

namespace Ising2D

variable {n : Type*} [Fintype n]

/-- 具体版の `‖x‖²` は、必要十分版の `‖x‖²` と一致する（同じ式の定義）。 -/
theorem vecNormSq_eq_vecNormSq_necSuf (x : n → ℝ) : vecNormSq x = NecSuf.vecNormSq' x :=
  rfl

end Ising2D
