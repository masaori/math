/-
# 全ての因子で可換ならクロネッカー積は可換（具体版を必要十分版から導く）

具体版 `ClaimTensorCommutationFromAllSites.lean` の `siteProd_commute_of_sitewise_commute` を、必要十分版
`Ising2D/NecSuf/SitewiseCommute.lean` の `commute_of_sitewise_commute` の `P := siteProd M` の特殊化として得る。
人手のラベルは `tensor_commutation_from_all_sites`。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimTensorCommutationFromAllSites
import Ising2D.NecSuf.SitewiseCommute

namespace Ising2D

/-- `tensor_commutation_from_all_sites` を `NecSuf.commute_of_sitewise_commute`（`P := siteProd M`）の特殊化として得る。 -/
theorem siteProd_commute_of_sitewise_commute_of_necSuf {M : ℕ} (x y : Fin M → Matrix (Fin 2) (Fin 2) ℂ)
    (h : ∀ i, y i * x i = x i * y i) :
    siteProd M x * siteProd M y = siteProd M y * siteProd M x :=
  NecSuf.commute_of_sitewise_commute (siteProd M) (siteProd_mul M) x y h

end Ising2D
