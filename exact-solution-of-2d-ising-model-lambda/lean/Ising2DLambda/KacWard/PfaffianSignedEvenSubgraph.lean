/-
「反対称化した行列の Pfaffian は符号付き偶部分グラフ多項式に等しい」（`claim_pfaffian_signed_even_subgraph`）の
具体版。実際の反対称行列 `K^as`（`gaugedTerminalMatrix L z s`）について

  `Pf(K^as) = Q^{a,b}_L`（右辺は `ℤ[x]` の多項式を係数の包含 `ℤ ↪ Qbar` で送ったもの）

を、本文の式鎖の順に示す。

  人手証明                                               このファイル・引く具体版
  一行目から四行目                                       `gaugedPfaffian_eq_seamSignedEvenSubgraphSum`
  五行目（def_torus_quadratic_sign と指数の偶奇）         `torusQuadraticSign_eq_neg_one_pow`
  六行目（claim_edge_set_horizontal_seam_parity_
    equals_winding_parity）                              `edgeSetHorizontalSeamParity_eq_windingParity`
  七行目（claim_edge_set_vertical_seam_parity_
    equals_winding_parity）                              `edgeSetVerticalSeamParity_eq_windingParity`
  八行目（def_signed_even_subgraph_polynomial と
    係数の送り）                                         `signedEvenSubgraphPolynomial` と `Polynomial.map`

本文の `(a,b) ∈ 𝒮 = {0,1}²` は、`Kac--Ward` 行列の側では `SpinStructure = Bool × Bool`（`true` が 1）、
`Q^{a,b}_L` の側では `Fin 2 × Fin 2` で持つ。両者は `spinComponentFin` で結ぶ。
住処は有限集合・`ℕ`・`ℤ`・`Qbar`・`Qbar[X]` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.PfaffianComplementFiberSum
import Ising2DLambda.KacWard.EdgeSetSeamWindingParity
import Ising2DLambda.KacWard.SignedEvenSubgraphSectorSum

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.TransferMatrix Ising2DLambda.FisherZero
open scoped Classical

variable {L : ℕ} [NeZero L]

/-- スピン構造の成分 `a ∈ {0,1}`（`Bool`、`true` が 1）を `Fin 2` の元として読む。 -/
def spinComponentFin (a : Bool) : Fin 2 := if a then 1 else 0

theorem spinComponentFin_val (a : Bool) : (spinComponentFin a).val = a.toNat := by
  cases a <;> rfl

/-- 五行目: `h, v ∈ {0,1}` について `χ_{a,b}(h,v) = (-1)^{(1+a)h+(1+b)v+hv}`
（`def_torus_quadratic_sign` の `1 - a` を、指数の偶奇が等しい `1 + a` に替える）。 -/
theorem torusQuadraticSign_eq_neg_one_pow (a b : Bool) (h v : ℕ) (hh : h < 2) (hv : v < 2) :
    torusQuadraticSign a b (decide (h = 1)) (decide (v = 1)) =
      (-1 : ℤ) ^ ((1 + a.toNat) * h + (1 + b.toNat) * v + h * v) := by
  interval_cases h <;> interval_cases v <;> cases a <;> cases b <;> decide

/-- `claim_pfaffian_signed_even_subgraph` の具体版: `Pf(K^as) = Q^{a,b}_L`。 -/
theorem gaugedPfaffian_eq_signedEvenSubgraphPolynomial (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) :
    qbarPolynomialPfaffian (gaugedTerminalMatrix L z s) =
      (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar) := by
  calc qbarPolynomialPfaffian (gaugedTerminalMatrix L z s)
      = ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          qbarConst (seamQuadraticSign s P) * Polynomial.X ^ P.card :=
        -- 一行目から四行目
        gaugedPfaffian_eq_seamSignedEvenSubgraphSum z hz s
    _ = ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          qbarConst ((((-1 : ℤ) ^ ((1 + s.1.toNat) * (edgeSetSeamParities P).1 +
            (1 + s.2.toNat) * (edgeSetSeamParities P).2 +
            (edgeSetSeamParities P).1 * (edgeSetSeamParities P).2) : ℤ) : Qbar)) *
            Polynomial.X ^ P.card := by
        -- 五行目: `def_torus_quadratic_sign` と指数の偶奇
        apply Finset.sum_congr rfl
        intro P _
        have hh : (edgeSetSeamParities P).1 < 2 := Nat.mod_lt _ (by norm_num)
        have hv : (edgeSetSeamParities P).2 < 2 := Nat.mod_lt _ (by norm_num)
        rw [seamQuadraticSign, torusQuadraticSign_eq_neg_one_pow _ _ _ _ hh hv]
    _ = ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          qbarConst ((((-1 : ℤ) ^ ((1 + s.1.toNat) * (horizontalWindingParity L P : ℕ) +
            (1 + s.2.toNat) * (edgeSetSeamParities P).2 +
            (horizontalWindingParity L P : ℕ) * (edgeSetSeamParities P).2) : ℤ) : Qbar)) *
            Polynomial.X ^ P.card := by
        -- 六行目: `claim_edge_set_horizontal_seam_parity_equals_winding_parity`
        apply Finset.sum_congr rfl
        intro P _
        rw [edgeSetHorizontalSeamParity_eq_windingParity]
    _ = ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          qbarConst ((((-1 : ℤ) ^ ((1 + s.1.toNat) * (horizontalWindingParity L P : ℕ) +
            (1 + s.2.toNat) * (verticalWindingParity L P : ℕ) +
            (horizontalWindingParity L P : ℕ) * (verticalWindingParity L P : ℕ)) : ℤ) : Qbar)) *
            Polynomial.X ^ P.card := by
        -- 七行目: `claim_edge_set_vertical_seam_parity_equals_winding_parity`
        apply Finset.sum_congr rfl
        intro P _
        rw [edgeSetVerticalSeamParity_eq_windingParity]
    _ = (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
          (Int.castRingHom Qbar) := by
        -- 八行目: `def_signed_even_subgraph_polynomial` と係数の包含 `ℤ ↪ Qbar`
        rw [signedEvenSubgraphPolynomial, Polynomial.map_sum]
        apply Finset.sum_congr rfl
        intro P _
        rw [Polynomial.map_mul, Polynomial.map_pow, Polynomial.map_X, signedEvenSubgraphCoefficient,
          Polynomial.map_pow, Polynomial.map_neg, Polynomial.map_one, torusHomologySector,
          spinComponentFin_val, spinComponentFin_val, qbarConst]
        simp

end Ising2DLambda.KacWard
