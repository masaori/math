/-
必要十分版の二つの有限和計算を、正方格子の高温展開へ特殊化する。
一辺の二値評価と既証明のスピン和を渡し、有限和全体の評価は必要十分版の中で行う。
-/
import Ising2DLambda.FisherZero.HighTemperaturePolynomial
import Ising2DLambda.NecSuf.FisherZero.HighTemperaturePolynomial

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- 必要十分版から得る `2^(L²) Z_L = H_L`。 -/
theorem highTemperaturePolynomial_identity_from_necSuf (L : ℕ) [NeZero L] :
    2 ^ (L ^ 2) * partitionPolynomial L = highTemperaturePolynomial L := by
  classical
  have hpow : (2 : Polynomial ℤ) ^ (2 * L ^ 2) =
      2 ^ (L ^ 2) * 2 ^ (L ^ 2) := by
    rw [← pow_add]
    congr
    omega
  have hspin (A : Finset (Edge L)) :
      (∑ σ : Config L, ∏ e ∈ A, Polynomial.C
        ((σ (boundary0 L e)).1 * (σ (boundary1 L e)).1)) =
        if IsEvenEdgeSubset L A then (2 : Polynomial ℤ) ^ (L ^ 2) else 0 := by
    rw [edgeSubsetSpinSum_C, evenSubgraph_spinSum]
    simp only [apply_ite Polynomial.C, map_pow, map_ofNat, map_zero]
  have h := Ising2DLambda.NecSuf.FisherZero.highTemperaturePolynomial_identity_necSuf
    ((1 : Polynomial ℤ) + Polynomial.X)
    ((1 : Polynomial ℤ) - Polynomial.X)
    (2 : Polynomial ℤ) Polynomial.X (2 ^ (L ^ 2) : Polynomial ℤ)
    (fun (σ : Config L) (e : Edge L) => Polynomial.C
      ((σ (boundary0 L e)).1 * (σ (boundary1 L e)).1))
    (fun (σ : Config L) (e : Edge L) => σ (boundary0 L e) = σ (boundary1 L e))
    (IsEvenEdgeSubset L)
    (fun σ e => highTemperatureEdgeWeight_eq L σ e)
    hspin
    (by simpa only [card_edge] using hpow)
    (fun _ _ hmul => mul_left_cancel₀
      (pow_ne_zero _ (Polynomial.C_ne_zero.mpr (by norm_num : (2 : ℤ) ≠ 0))) hmul)
  simpa only [partitionPolynomial, highTemperaturePolynomial, brokenBondCount, card_edge]
    using h

end Ising2DLambda.FisherZero
