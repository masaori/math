/-
章「トーラス上の Kac--Ward 行列式」の
「符号付き偶部分グラフ多項式はセクター生成多項式の符号付き和である」
（`claim_signed_even_subgraph_sector_sum`）の具体版。

人手証明と同じく、偶部分グラフの有限和を巻き付き偶奇の四つの値で分け、
各セクター上で一定の符号を有限和の外へ出す。住処は有限集合と Z[x] である。
-/
import Ising2DLambda.FisherZero.LowTemperatureTrivialSectorExpression
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphSectorSum

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.FisherZero

/-- スピン構造と巻き付きセクターが定める符号係数。 -/
noncomputable def signedEvenSubgraphCoefficient (a b : Fin 2) (sector : Fin 2 × Fin 2) :
    Polynomial ℤ :=
  (-1 : Polynomial ℤ) ^
    ((1 + a.val) * sector.1.val + (1 + b.val) * sector.2.val +
      sector.1.val * sector.2.val)

/-- 符号付き偶部分グラフ多項式 `Q_L^{a,b}`。 -/
noncomputable def signedEvenSubgraphPolynomial (L : ℕ) [NeZero L] (a b : Fin 2) :
    Polynomial ℤ := by
  classical
  exact ∑ A ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
    signedEvenSubgraphCoefficient a b (torusHomologySector L A) * Polynomial.X ^ A.card

/-- `claim_signed_even_subgraph_sector_sum` の具体版。 -/
theorem signedEvenSubgraphPolynomial_eq_sectorSum (L : ℕ) [NeZero L] (a b : Fin 2) :
    signedEvenSubgraphPolynomial L a b =
      ∑ sector : Fin 2 × Fin 2,
        signedEvenSubgraphCoefficient a b sector * sectorGeneratingPolynomial L sector := by
  classical
  rw [signedEvenSubgraphPolynomial]
  have h := Ising2DLambda.NecSuf.KacWard.weightedSum_eq_sum_label_fibers_necSuf
    ((univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L))
    (torusHomologySector L) (signedEvenSubgraphCoefficient a b)
    (fun A => (Polynomial.X : Polynomial ℤ) ^ A.card)
  simpa only [sectorGeneratingPolynomial, IsInTorusHomologySector,
    Finset.filter_filter, and_assoc] using h

end Ising2DLambda.KacWard
