/-
# クロネッカー積の各因子についての線型性（具体版を必要十分版から導く）

具体版 `ClaimKroneckerMultilinear.lean` の主張 `siteProd_update_sum_smul`・`siteProd_update_smul`・
`vecKron_update_sum_smul`・`vecKron_update_smul` を、必要十分版 `Ising2D/NecSuf/KroneckerMultilinear.lean` の
係数 `R := ℂ`、サイトの添字 `ι := Fin M`、因子の添字 `α = β := Fin 2` の特殊化として得る。人手のラベルは `kronecker_multilinear`。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerMultilinear
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerTransposeFromNecSuf
import Ising2D.NecSuf.KroneckerMultilinear

namespace Ising2D

variable {M : ℕ}

/-- 具体版の数ベクトルのクロネッカー積 `vecKron` は、必要十分版の `vecKronOf` の `R := ℂ`, `ι := Fin M`, `α := Fin 2` の場合である。 -/
theorem vecKron_eq_vecKronOf (v : Fin M → Fin 2 → ℂ) : vecKron M v = NecSuf.vecKronOf v :=
  funext fun I => vecKron_apply M v I

/-- `siteProd_update_sum_smul` を `NecSuf.kroneckerProdOf_update_sum_smul` の特殊化として得る。 -/
theorem siteProd_update_sum_smul_of_necSuf (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (j : Fin M)
    {ι : Type*} (t : Finset ι) (c : ι → ℂ) (B : ι → Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (Function.update x j (∑ a ∈ t, c a • B a))
      = ∑ a ∈ t, c a • siteProd M (Function.update x j (B a)) := by
  simp only [siteProd_eq_kroneckerProdOf]
  exact NecSuf.kroneckerProdOf_update_sum_smul x j t c B

/-- `siteProd_update_smul` を `NecSuf.kroneckerProdOf_update_smul` の特殊化として得る。 -/
theorem siteProd_update_smul_of_necSuf (x : Fin M → Matrix (Fin 2) (Fin 2) ℂ) (j : Fin M) (c : ℂ)
    (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (Function.update x j (c • A)) = c • siteProd M (Function.update x j A) := by
  simp only [siteProd_eq_kroneckerProdOf]
  exact NecSuf.kroneckerProdOf_update_smul x j c A

/-- `vecKron_update_sum_smul` を `NecSuf.vecKronOf_update_sum_smul` の特殊化として得る。 -/
theorem vecKron_update_sum_smul_of_necSuf (v : Fin M → Fin 2 → ℂ) (j : Fin M)
    {ι : Type*} (t : Finset ι) (c : ι → ℂ) (w : ι → Fin 2 → ℂ) :
    vecKron M (Function.update v j (∑ a ∈ t, c a • w a))
      = ∑ a ∈ t, c a • vecKron M (Function.update v j (w a)) := by
  simp only [vecKron_eq_vecKronOf]
  exact NecSuf.vecKronOf_update_sum_smul v j t c w

/-- `vecKron_update_smul` を `NecSuf.vecKronOf_update_smul` の特殊化として得る。 -/
theorem vecKron_update_smul_of_necSuf (v : Fin M → Fin 2 → ℂ) (j : Fin M) (c : ℂ) (w : Fin 2 → ℂ) :
    vecKron M (Function.update v j (c • w)) = c • vecKron M (Function.update v j w) := by
  simp only [vecKron_eq_vecKronOf]
  exact NecSuf.vecKronOf_update_smul v j c w

end Ising2D
