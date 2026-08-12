/-
「同じ破れた辺の集合を与える配位は全スピン反転を除いて一意である」の必要十分版。
格子の連結性を使い終えた時点で必要なのは、基点との一致・不一致が全点で一定であることと、
各点の二つの値が「同じ値」または指定した反転値のどちらかであることだけである。
-/
namespace Ising2DLambda.NecSuf.FisherZero

theorem eq_or_map_of_constant_agreement {V S : Type}
    (base : V) (reverse : S → S) (σ τ : V → S)
    (hdichotomy : ∀ v, τ v = σ v ∨ τ v = reverse (σ v))
    (hconstant : ∀ v w, (τ v = σ v ↔ τ w = σ w)) :
    τ = σ ∨ τ = fun v => reverse (σ v) := by
  by_cases hbase : τ base = σ base
  · left
    funext v
    exact (hconstant v base).mpr hbase
  · right
    funext v
    rcases hdichotomy v with heq | hreverse
    · exact False.elim (hbase ((hconstant v base).mp heq))
    · exact hreverse

end Ising2DLambda.NecSuf.FisherZero
