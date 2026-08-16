import Ising3DCut.AllEdgeVariablesToOneIndeterminateStepTwo

/-!
人手証明「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の Lean 具体版（合成）。

第一歩（`κ_L(𝒵_L) = Σ_σ X ^ #B(σ)`）と第二歩（`Σ_σ X ^ #B(σ) = Z_L(X)`）を
具体箱型 `Config L`・破れ辺集合 `brokenSet` で一つの定理へ合成する。
-/

namespace Ising3DCut.NullModel

open Polynomial

/-- `κ_L(𝒵_L) = Z_L(X)`：全辺変数を単一不定元へ置く環準同型で、
多変数分配多項式は自由境界の分配多項式へ写る。 -/
theorem allEdgesToOneIndeterminate_multivariatePartitionPolynomial_eq_partitionPolynomial
    (L : ℕ) :
    allEdgesToOneIndeterminate
        (multivariatePartitionPolynomial (fun σ : Config L => brokenSet σ)) =
      partitionPolynomial L := by
  rw [allEdgesToOneIndeterminate_multivariatePartitionPolynomial]
  exact sum_X_pow_brokenCount_eq_partitionPolynomial L

end Ising3DCut.NullModel
