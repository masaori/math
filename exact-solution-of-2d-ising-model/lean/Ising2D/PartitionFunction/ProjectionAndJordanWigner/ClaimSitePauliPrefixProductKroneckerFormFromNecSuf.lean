/-
# `site_pauli_prefix_product_kronecker_form` の具体版を必要十分版から導く

必要十分版: `Ising2D/NecSuf/SitePauliPrefixProductKroneckerForm.lean` の `NecSuf.prefix_product_eq_map_prefixFamily`。
具体版（人手と 1 対 1）: `ClaimSitePauliPrefixProductKroneckerForm.lean` の `site_pauli_prefix_product_kronecker_form`。

特殊化: `R := Mat(2,ℂ)`（`MulOneClass` は行列の積と単位行列）、`S := TensorPow M`、`Φ := siteProd M`、
`hΦ := (siteProd_mul M · ·)`（`kronecker_product_rule` (1)）。左辺の有限積は `finiteMatrixProduct_eq_finProdLeft`（`ι := Conf M`）で
必要十分版の `NecSuf.finProdLeft` へ読み替える。`siteOpOf (siteProd M) k x` は `siteOp k x` そのもの（`rfl`）である。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimSitePauliPrefixProductKroneckerForm
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatricesFromNecSuf
import Ising2D.NecSuf.SitePauliPrefixProductKroneckerForm

namespace Ising2D

variable {M : ℕ}

/-- 具体版 `site_pauli_prefix_product_kronecker_form` を、必要十分版の特殊化として得た形。 -/
theorem site_pauli_prefix_product_kronecker_form_of_necSuf (r : ℕ) (h : r < M)
    (a : Fin (r + 1) → Matrix (Fin 2) (Fin 2) ℂ) :
    finiteMatrixProduct r (sitePauliFamily r h a) = siteProd M (prefixKroneckerFamily r a) := by
  rw [finiteMatrixProduct_eq_finProdLeft]
  exact NecSuf.prefix_product_eq_map_prefixFamily (siteProd M) (fun x y => siteProd_mul M x y) r h a

end Ising2D
