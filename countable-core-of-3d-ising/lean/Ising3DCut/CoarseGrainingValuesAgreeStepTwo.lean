import Ising3DCut.CoarseGrainingValuesAgree
import Ising3DCut.AllEdgeVariablesToOneIndeterminateComposed

/-!
人手証明「粗視化の値の一致から Z_L の等式へ」の Lean 具体版（第二歩）。

具体箱型 `Config L` で `ε_{L,q}(𝒵_L) = Z_L(q)`（第一歩の `ε_{L,q} = ev_q ∘ κ_L` と
`κ_L(𝒵_L) = Z_L(X)` の合成）を示し、そこから
「粗視化の値が一致すれば `Z_L(q) = Z_L(q')`」を導く。
-/

namespace Ising3DCut.NullModel

/-- `ε_{L,q}(𝒵_L) = Z_L(q)`：全辺変数を `q` へ置いた多変数分配多項式の値は、
自由境界の分配多項式の `q` での値に等しい。 -/
theorem allEdgesToRational_multivariatePartitionPolynomial_eq_eval (L : ℕ) (q : ℚ) :
    allEdgesToRational q
        (multivariatePartitionPolynomial (fun σ : Config L => brokenSet σ)) =
      evalAtRational q (partitionPolynomial L) := by
  rw [allEdgesToRational_eq_evalAtRational_comp_allEdgesToOneIndeterminate,
    RingHom.comp_apply,
    allEdgesToOneIndeterminate_multivariatePartitionPolynomial_eq_partitionPolynomial]

/-- 粗視化の値の一致から `Z_L` の等式へ：`ε_{L,q}(𝒵_L) = ε_{L,q'}(𝒵_L)` ならば
`Z_L(q) = Z_L(q')`。 -/
theorem partitionPolynomial_eval_eq_of_allEdgesToRational_eq (L : ℕ) (q q' : ℚ)
    (h : allEdgesToRational q
          (multivariatePartitionPolynomial (fun σ : Config L => brokenSet σ)) =
        allEdgesToRational q'
          (multivariatePartitionPolynomial (fun σ : Config L => brokenSet σ))) :
    evalAtRational q (partitionPolynomial L) = evalAtRational q' (partitionPolynomial L) := by
  rw [← allEdgesToRational_multivariatePartitionPolynomial_eq_eval,
    ← allEdgesToRational_multivariatePartitionPolynomial_eq_eval]
  exact h

end Ising3DCut.NullModel
