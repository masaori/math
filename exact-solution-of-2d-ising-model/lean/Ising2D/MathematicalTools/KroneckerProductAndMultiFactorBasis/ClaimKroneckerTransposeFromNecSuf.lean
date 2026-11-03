/-
# クロネッカー積の転置（具体版を必要十分版から導く）

具体版 `ClaimKroneckerTranspose.lean` の主張 `siteProd_transpose` を、必要十分版 `Ising2D/NecSuf/KroneckerTranspose.lean` の
`kroneckerProdOf_transpose` の係数 `R := ℂ`、サイトの添字 `ι := Fin M`、因子の添字 `α = β := Fin 2` の特殊化として得る。
人手のラベルは `kronecker_transpose`。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerTranspose
import Ising2D.NecSuf.KroneckerTranspose

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 具体版のクロネッカー積 `siteProd` は、必要十分版の `kroneckerProdOf` の `R := ℂ`, `ι := Fin M`, `α = β := Fin 2` の場合である。 -/
theorem siteProd_eq_kroneckerProdOf (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M x = NecSuf.kroneckerProdOf x :=
  Matrix.ext fun s t => siteProd_apply M x s t

/-- `siteProd_transpose`（人手 `kronecker_transpose`）を `NecSuf.kroneckerProdOf_transpose` の特殊化として得る。 -/
theorem siteProd_transpose_of_necSuf (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) :
    (siteProd M x)ᵀ = siteProd M (fun k => (x k)ᵀ) := by
  rw [siteProd_eq_kroneckerProdOf, siteProd_eq_kroneckerProdOf]
  exact NecSuf.kroneckerProdOf_transpose x

end Ising2D
