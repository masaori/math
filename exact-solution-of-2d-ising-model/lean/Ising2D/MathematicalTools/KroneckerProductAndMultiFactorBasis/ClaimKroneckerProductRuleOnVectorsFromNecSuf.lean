/-
# クロネッカー積の積の規則の (3)（具体版を必要十分版から導く）

具体版 `ClaimKroneckerProductRuleOnVectors.lean` の 2 つの主張を、必要十分版
`Ising2D/NecSuf/KroneckerProductRuleOnVectors.lean` の `R := ℂ`、`ι := Fin 2`、`hmed := mul_mul_mul_comm`（ℂ の乗法の可換則と結合則）
の特殊化として得る。人手のラベルは `kronecker_product_rule`（(3) と証明の準備）と `def_kronecker`（(1)・(2)）。

ℂ の `Finset.prod` と `NecSuf.finProdLeft` の一致は `complex_finset_prod_eq_finProdLeft`
（`ClaimRealInclusionPreservesFiniteProductFromNecSuf.lean`）で受ける。これにより `siteProd` は `NecSuf.matKron'`、
`vecKron` は `NecSuf.vecKron'` に一致する（`siteProd_eq_matKron'`・`vecKron_eq_vecKron'`）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerProductRuleOnVectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteProductFromNecSuf
import Ising2D.NecSuf.KroneckerProductRuleOnVectors

namespace Ising2D

open Matrix

/-- 行列のクロネッカー積 `siteProd`（人手 `def_kronecker` (2)）は `NecSuf.matKron'` の `R := ℂ`、`ι := Fin 2` である。 -/
theorem siteProd_eq_matKron' (M : ℕ) (A : Fin (M + 1) → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd (M + 1) A = NecSuf.matKron' M A := by
  ext I J
  exact complex_finset_prod_eq_finProdLeft M _

/-- 数ベクトルのクロネッカー積 `vecKron`（人手 `def_kronecker` (1)）は `NecSuf.vecKron'` の `R := ℂ`、`ι := Fin 2` である。 -/
theorem vecKron_eq_vecKron' (M : ℕ) (v : Fin (M + 1) → Fin 2 → ℂ) :
    vecKron (M + 1) v = NecSuf.vecKron' M v := by
  funext I
  exact complex_finset_prod_eq_finProdLeft M _

/-- `sum_over_multi_index_of_product_eq_product_of_sums` を `NecSuf.sum_pi_finProdLeft_eq_finProdLeft_sum`
（`R := ℂ`、`ι := Fin 2`）の特殊化として得る。 -/
theorem sum_over_multi_index_of_product_eq_product_of_sums_of_necSuf (M : ℕ) (c : Fin (M + 1) → Fin 2 → ℂ) :
    ∑ K : Conf (M + 1), ∏ k, c k (K k) = ∏ k, ∑ t : Fin 2, c k t := by
  rw [complex_finset_prod_eq_finProdLeft M (fun k => ∑ t : Fin 2, c k t),
    ← NecSuf.sum_pi_finProdLeft_eq_finProdLeft_sum M c]
  exact Finset.sum_congr rfl fun K _ => complex_finset_prod_eq_finProdLeft M _

/-- `kronecker_product_rule_mulVec` を `NecSuf.matKron'_mulVec_vecKron'`（`R := ℂ`、`ι := Fin 2`、
`hmed := mul_mul_mul_comm`）の特殊化として得る。 -/
theorem kronecker_product_rule_mulVec_of_necSuf (M : ℕ) (A : Fin (M + 1) → Matrix (Fin 2) (Fin 2) ℂ)
    (v : Fin (M + 1) → Fin 2 → ℂ) :
    siteProd (M + 1) A *ᵥ vecKron (M + 1) v = vecKron (M + 1) (fun k => A k *ᵥ v k) := by
  rw [siteProd_eq_matKron', vecKron_eq_vecKron', vecKron_eq_vecKron']
  exact NecSuf.matKron'_mulVec_vecKron' mul_mul_mul_comm M A v

end Ising2D
