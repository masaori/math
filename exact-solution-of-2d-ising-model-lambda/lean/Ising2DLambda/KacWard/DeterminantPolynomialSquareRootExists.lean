/-
「四つの行列式には定数項一の多項式平方根が存在する」
（`claim_determinant_polynomial_square_root_exists`）の具体版。実際の四つの Kac--Ward 行列式
`D^{a,b}_L`（`kacWardDeterminant (kacWardTransitionMatrix L z s)`）について、

  `Q^{a,b}_L`（`ℤ[x]` の多項式を係数の包含 `ℤ ↪ Qbar` で送ったもの）が定数項一の平方根であり、
  定数項一の平方根はそれ一つしかない

ことを、本文の証明の順に示す。

  人手証明                                               このファイル・引く具体版
  定数項の式鎖（def_signed_even_subgraph_polynomial）    `signedEvenSubgraphPolynomial_coeff_zero`
    一行目: 係数の包含は係数ごと                          `Polynomial.coeff_map`
    二行目: 次数零の係数は |A| = 0 の項の和               `signedEvenSubgraphPolynomial_coeff_zero_eq_sum`
    三行目: |A| = 0 の偶部分グラフは空集合だけ            `emptyEdgeSubset_isEven`・`Finset.card_eq_zero`
    四行目: 空集合の巻き付き偶奇は零                      `torusHomologySector_empty`
  平方（claim_determinant_signed_even_subgraph_square）  `kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq`
  存在の証人                                             `kacWardDeterminant_qbarPolynomialSquareRoot`
  一意性（claim_qbar_polynomial_square_root_unique）     `qbarPolynomialSquareRoot_unique`

本文の `(a,b) ∈ 𝒮` は `SpinStructure = Bool × Bool` で持ち、`Q^{a,b}_L` の側の `Fin 2` とは
`spinComponentFin` で結ぶ。本文の `ζ_8` は `z ^ 4 = -1` を満たす `z : Qbar` で受ける。
住処は有限集合・`ℤ`・`Qbar`・`Qbar[X]` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.DeterminantSignedEvenSubgraphSquare
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialSquareRootUniqueness

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.FisherZero
open scoped Classical

/-- 空の辺部分集合は偶部分グラフである（`def_even_edge_subset`。各頂点の端点数は `0 = 2·0`）。 -/
theorem emptyEdgeSubset_isEven (L : ℕ) [NeZero L] : IsEvenEdgeSubset L ∅ := by
  intro v
  have hzero : edgeSubsetIncidenceCount L ∅ v = 0 := Finset.sum_empty
  rw [hzero]
  exact ⟨0, rfl⟩

/-- 空の辺部分集合の二つの巻き付き偶奇はどちらも零である（`def_torus_winding_parities`）。 -/
theorem torusHomologySector_empty (L : ℕ) [NeZero L] :
    torusHomologySector L ∅ = (0, 0) := by
  simp [torusHomologySector, horizontalWindingParity, verticalWindingParity]

/-- 二行目: `Q^{a,b}_L` の次数零の係数は、`|A| = 0` の偶部分グラフの符号の和である。 -/
theorem signedEvenSubgraphPolynomial_coeff_zero_eq_sum (L : ℕ) [NeZero L] (a b : Fin 2) :
    (signedEvenSubgraphPolynomial L a b).coeff 0 =
      ∑ A ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
        if A.card = 0 then (signedEvenSubgraphCoefficient a b (torusHomologySector L A)).coeff 0
        else 0 := by
  unfold signedEvenSubgraphPolynomial
  rw [Polynomial.finsetSum_coeff]
  apply Finset.sum_congr rfl
  intro A _
  rw [Polynomial.coeff_mul_X_pow']
  by_cases hcard : A.card = 0
  · simp [hcard]
  · have hnot : ¬ A.card ≤ 0 := by omega
    simp [hcard, hnot]

/-- 定数項の式鎖: `ac_0(Q^{a,b}_L) = 1`（`ℤ[x]` の中）。 -/
theorem signedEvenSubgraphPolynomial_coeff_zero (L : ℕ) [NeZero L] (a b : Fin 2) :
    (signedEvenSubgraphPolynomial L a b).coeff 0 = 1 := by
  calc (signedEvenSubgraphPolynomial L a b).coeff 0
      = ∑ A ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          if A.card = 0 then (signedEvenSubgraphCoefficient a b (torusHomologySector L A)).coeff 0
          else 0 :=
        -- 二行目: 次数零の係数は |A| = 0 の項だけから来る
        signedEvenSubgraphPolynomial_coeff_zero_eq_sum L a b
    _ = (signedEvenSubgraphCoefficient a b (torusHomologySector L ∅)).coeff 0 := by
        -- 三行目: |A| = 0 の偶部分グラフは空集合だけで、空集合は偶部分グラフである
        rw [Finset.sum_eq_single (∅ : Finset (Edge L))]
        · simp
        · intro A _ hA
          have hcard : A.card ≠ 0 := fun h => hA (Finset.card_eq_zero.mp h)
          simp [hcard]
        · intro hnot
          exact False.elim (hnot (Finset.mem_filter.mpr
            ⟨Finset.mem_univ _, emptyEdgeSubset_isEven L⟩))
    _ = (signedEvenSubgraphCoefficient a b (0, 0)).coeff 0 := by
        -- 四行目: 空集合の巻き付き偶奇は零
        rw [torusHomologySector_empty]
    _ = 1 := by
        -- 五行目: 指数は (1+a)·0 + (1+b)·0 + 0·0 = 0 なので (-1)^0 = 1
        simp [signedEvenSubgraphCoefficient]

/-- 存在の証人: `Q^{a,b}_L` は `D^{a,b}_L` の定数項一の平方根である。 -/
theorem kacWardDeterminant_qbarPolynomialSquareRoot {L : ℕ} [NeZero L] (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    qbarPolynomialSquareRoot (kacWardDeterminant (kacWardTransitionMatrix L z s))
      ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar)) := by
  constructor
  · -- 定数項: 係数の包含は係数ごとに施され、`ac_0(Q^{a,b}_L) = 1`
    calc ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
          (Int.castRingHom Qbar)).coeff 0
        = (Int.castRingHom Qbar)
            ((signedEvenSubgraphPolynomial L (spinComponentFin s.1)
              (spinComponentFin s.2)).coeff 0) := Polynomial.coeff_map _ 0
      _ = (Int.castRingHom Qbar) 1 := by rw [signedEvenSubgraphPolynomial_coeff_zero]
      _ = 1 := map_one _
  · -- 平方: `claim_determinant_signed_even_subgraph_square`
    rw [← pow_two]
    exact (kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq z hz s).symm

/-- `claim_determinant_polynomial_square_root_exists` の具体版（一意性）: `D^{a,b}_L` の定数項一の
平方根 `S^{a,b}_L` は `Q^{a,b}_L` に等しい（`claim_qbar_polynomial_square_root_unique`）。 -/
theorem kacWardDeterminant_squareRoot_eq_signedEvenSubgraphPolynomial {L : ℕ} [NeZero L]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (S : QbarPoly)
    (hS : qbarPolynomialSquareRoot (kacWardDeterminant (kacWardTransitionMatrix L z s)) S) :
    S = (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar) := by
  have hQ := kacWardDeterminant_qbarPolynomialSquareRoot (L := L) z hz s
  exact qbarPolynomialSquareRoot_unique _ _ hS.1 hQ.1 (hS.2.trans hQ.2.symm)

/-- `claim_determinant_polynomial_square_root_exists` の具体版: `D^{a,b}_L` の定数項一の多項式平方根は
ちょうど一つ存在する。 -/
theorem kacWardDeterminant_existsUnique_qbarPolynomialSquareRoot {L : ℕ} [NeZero L]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    ∃! S : QbarPoly,
      qbarPolynomialSquareRoot (kacWardDeterminant (kacWardTransitionMatrix L z s)) S :=
  ⟨_, kacWardDeterminant_qbarPolynomialSquareRoot z hz s,
    fun S hS => kacWardDeterminant_squareRoot_eq_signedEvenSubgraphPolynomial z hz s S hS⟩

end Ising2DLambda.KacWard
