/-
「分配多項式は四つの行列式の定数項一の平方根の和の半分である」
（`claim_determinant_square_root_torus_formula`）の具体版。

  人手証明                                                  このファイル・引く具体版
  一行目: `Z_L = ½(2 Z_L)`（`Qbar` の四則と `½·2 = 1`）       `Polynomial.C_mul`・`one_mul`
  二行目: `claim_finite_torus_polynomial` を係数ごとに送る      `finiteTorusPolynomial`・`Polynomial.map_sum`
  三行目: `S^{a,b}_L = Q^{a,b}_L`
          （`claim_determinant_polynomial_square_root_exists`） `kacWardDeterminant_squareRoot_eq_signedEvenSubgraphPolynomial`

本文の `Z_L ∈ ℤ[x]` と `Q^{a,b}_L ∈ ℤ[x]` を `Qbar[x]` で読むことは、係数の包含 `ℤ ↪ Qbar`
（`Polynomial.map (Int.castRingHom Qbar)`）で送ることとして書く。本文の `½` は定数多項式
`Polynomial.C (1/2)` である。本文の `(a,b) ∈ 𝒮` は `SpinStructure = Bool × Bool` の元で、
`claim_finite_torus_polynomial` の具体版の添字 `Fin 2 × Fin 2` へは成分ごとの全単射
`spinStructureFinEquiv` で移す（和の添字の付け替えであり、本文の式鎖の行には現れない）。
平方根 `S^{a,b}_L` は、定数項一の平方根であるという仮定 `hS` だけで受ける
（その存在は `kacWardDeterminant_existsUnique_qbarPolynomialSquareRoot`）。
住処は `ℤ[x]`・`Qbar[x]` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.DeterminantPolynomialSquareRootExists
import Ising2DLambda.KacWard.LowTemperaturePartitionBounds

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial

/-- 二行目の根拠: `claim_finite_torus_polynomial` の `ℤ[x]` の等式を係数ごとに `Qbar[x]` へ送り、
和の添字を `𝒮` へ付け替えたもの。`Σ_{(a,b)∈𝒮} Q^{a,b}_L = 2 Z_L`（`Qbar[x]` の中）。 -/
theorem finiteTorusPolynomial_map_qbar (L : ℕ) [NeZero L] :
    (∑ s : SpinStructure,
      (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar)) =
      2 * (partitionPolynomial L).map (Int.castRingHom Qbar) := by
  have h := congrArg (Polynomial.map (Int.castRingHom Qbar)) (finiteTorusPolynomial L)
  simp only [Polynomial.map_sum, Polynomial.map_mul, Polynomial.map_ofNat] at h
  rw [← h]
  exact Fintype.sum_equiv spinStructureFinEquiv _ _ (fun s => rfl)

/-- `claim_determinant_square_root_torus_formula` の具体版:
`Z_L = ½ Σ_{(a,b)∈𝒮} S^{a,b}_L`（`Qbar[x]` の中）。 -/
theorem partitionPolynomial_eq_half_sum_kacWardSquareRoots {L : ℕ} [NeZero L]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (S : SpinStructure → QbarPoly)
    (hS : ∀ s : SpinStructure,
      qbarPolynomialSquareRoot (kacWardDeterminant (kacWardTransitionMatrix L z s)) (S s)) :
    (partitionPolynomial L).map (Int.castRingHom Qbar) =
      Polynomial.C (1 / 2 : Qbar) * ∑ s : SpinStructure, S s := by
  calc (partitionPolynomial L).map (Int.castRingHom Qbar)
      = Polynomial.C (1 / 2 : Qbar) * (2 * (partitionPolynomial L).map (Int.castRingHom Qbar)) := by
        -- 一行目: `Qbar` の四則と `½·2 = 1`
        rw [← mul_assoc, ← Polynomial.C_ofNat, ← Polynomial.C_mul]
        norm_num
    _ = Polynomial.C (1 / 2 : Qbar) * ∑ s : SpinStructure,
          (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
            (Int.castRingHom Qbar) := by
        -- 二行目: `claim_finite_torus_polynomial` を係数ごとに `Qbar[x]` へ送る
        rw [finiteTorusPolynomial_map_qbar]
    _ = Polynomial.C (1 / 2 : Qbar) * ∑ s : SpinStructure, S s := by
        -- 三行目: 定数項一の平方根の一意性から `S^{a,b}_L = Q^{a,b}_L`
        congr 1
        apply Finset.sum_congr rfl
        intro s _
        exact (kacWardDeterminant_squareRoot_eq_signedEvenSubgraphPolynomial z hz s (S s) (hS s)).symm

/-- 本文の「四項に掛かる係数 `½` はいずれも正である」（`ℚ` の中）。 -/
theorem torusFormula_half_pos : (0 : ℚ) < 1 / 2 := by norm_num

end Ising2DLambda.KacWard
