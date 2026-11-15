/-
「符号付き偶部分グラフ多項式の軌道ごとの明示積」（`claim_signed_even_subgraph_orbit_product`）の
具体版のうち、定数項と一意性から `P^{a,b}_L = Q^{a,b}_L` を合成する段。平方の段
`(P^{a,b}_L)^2 = D^{a,b}_L` は `SignedEvenSubgraphOrbitProductSquare.lean` の `orbitExplicitProduct_sq`。

  人手証明                                                    このファイル・引く具体版
  定数項の式鎖
    一行目: `P^{a,b}_L` の定義                                 `orbitExplicitProduct`
    二行目: 有限積の定数項は各因子の定数項の積
            （def_qbar_polynomial_ring の積の係数を因子ごとに）  `coeff_zero_finset_prod`
    三行目: `F_O` の定義から定数項は一                          `oneElementOrbitFactor_coeff_zero`
    四行目: def_dispersion_polynomial から `ac_0(Δ_O) = 1`     `dispersionPolynomial_coeff_zero`
  `P = S`（claim_qbar_polynomial_square_root_unique と平方・定数項）
                                                              `qbarPolynomialSquareRoot_unique`・`orbitExplicitProduct_sq`
  `S = Q`（claim_determinant_polynomial_square_root_exists）   `kacWardDeterminant_existsUnique_qbarPolynomialSquareRoot`・
                                                              `kacWardDeterminant_squareRoot_eq_signedEvenSubgraphPolynomial`

本文の `S^{a,b}_L` は `claim_determinant_polynomial_square_root_exists` が存在を述べる平方根で、
ここでは存在と一意性の具体版から取り出す。必要十分版を呼ばない。住処は Qbar と Qbar[x]。
-/
import Ising2DLambda.KacWard.SignedEvenSubgraphOrbitProductSquare
import Ising2DLambda.KacWard.DeterminantPolynomialSquareRootExists

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Classical

/-- 二行目の根拠: 有限積の定数項は各因子の定数項の積
（`def_qbar_polynomial_ring` の積の係数 `ac_0(fg) = ac_0(f)·ac_0(g)` を因子の個数について繰り返す）。 -/
theorem coeff_zero_finset_prod {β : Type*} (A : Finset β) (f : β → QbarPoly) :
    (∏ i ∈ A, f i).coeff 0 = ∏ i ∈ A, (f i).coeff 0 := by
  induction A using Finset.induction_on with
  | empty => simp
  | insert a A ha ih =>
      rw [Finset.prod_insert ha, Finset.prod_insert ha, Polynomial.mul_coeff_zero, ih]

/-- 三行目の根拠: 一元軌道の因子 `F_O` の定数項は一（`1 - 2x - x^2`・`1 + 2x - x^2`・`1 + x^2`）。 -/
theorem oneElementOrbitFactor_coeff_zero (O : Finset (Qbar × Qbar)) :
    (oneElementOrbitFactor O).coeff 0 = 1 := by
  unfold oneElementOrbitFactor
  split_ifs <;> simp [Polynomial.coeff_one, Polynomial.coeff_X, Polynomial.coeff_X_pow]

/-- 四行目の根拠: `Δ(x; ϖ, ς) = (1 + x^2)^2 - x(1 - x^2)(ϖ + ϖ⁻¹ + ς + ς⁻¹)` の定数項は一
（`def_dispersion_polynomial`）。 -/
theorem dispersionPolynomial_coeff_zero (varpi varsigma : Qbar) :
    (dispersionPolynomial varpi varsigma).coeff 0 = 1 := by
  rw [Polynomial.coeff_zero_eq_eval_zero]
  simp [dispersionPolynomial]

/-- 定数項の式鎖: `ac_0(P^{a,b}_L) = 1`。 -/
theorem orbitExplicitProduct_coeff_zero (L : ℕ) [NeZero L] (s : SpinStructure) :
    (orbitExplicitProduct L s).coeff 0 = 1 := by
  set M := modeInversionOrbits L s
  calc (orbitExplicitProduct L s).coeff 0
      = ((∏ O ∈ M.filter (fun O => O.card = 1), oneElementOrbitFactor O) *
          (∏ O ∈ M.filter (fun O => O.card = 2), orbitDispersion O) *
          (∏ O ∈ M.filter (fun O => O.card = 4), orbitDispersion O ^ 2)).coeff 0 := by
        -- 一行目: `P^{a,b}_L` の定義
        rfl
    _ = (∏ O ∈ M.filter (fun O => O.card = 1), (oneElementOrbitFactor O).coeff 0) *
          (∏ O ∈ M.filter (fun O => O.card = 2), (orbitDispersion O).coeff 0) *
          (∏ O ∈ M.filter (fun O => O.card = 4), (orbitDispersion O).coeff 0 ^ 2) := by
        -- 二行目: 有限積の定数項は各因子の定数項の積
        rw [Polynomial.mul_coeff_zero, Polynomial.mul_coeff_zero, coeff_zero_finset_prod,
          coeff_zero_finset_prod, coeff_zero_finset_prod]
        congr 1
        exact Finset.prod_congr rfl (fun O _ => by rw [pow_two, Polynomial.mul_coeff_zero, pow_two])
    _ = (∏ O ∈ M.filter (fun O => O.card = 2), (orbitDispersion O).coeff 0) *
          (∏ O ∈ M.filter (fun O => O.card = 4), (orbitDispersion O).coeff 0 ^ 2) := by
        -- 三行目: `F_O` の定義から定数項は一
        rw [Finset.prod_congr rfl (fun O _ => oneElementOrbitFactor_coeff_zero O),
          Finset.prod_const_one, one_mul]
    _ = 1 := by
        -- 四行目: `def_dispersion_polynomial` から `ac_0(Δ_O) = 1`
        simp only [orbitDispersion, dispersionPolynomial_coeff_zero, one_pow,
          Finset.prod_const_one, mul_one]

/-- `claim_signed_even_subgraph_orbit_product` の具体版: 明示積 `P^{a,b}_L` は、係数の包含
`ℤ ↪ Qbar` で送った `Q^{a,b}_L` に等しい。 -/
theorem orbitExplicitProduct_eq_signedEvenSubgraphPolynomial {L : ℕ} [NeZero L] (z : Qbar)
    (hz4 : z ^ 4 = -1) (s : SpinStructure) :
    orbitExplicitProduct L s =
      (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar) := by
  -- `claim_determinant_polynomial_square_root_exists`: 平方根 `S^{a,b}_L` を取る
  obtain ⟨S, hS, -⟩ := kacWardDeterminant_existsUnique_qbarPolynomialSquareRoot (L := L) z hz4 s
  -- 平方の段: `P^{a,b}_L · P^{a,b}_L = D^{a,b}_L`
  have hPP : orbitExplicitProduct L s * orbitExplicitProduct L s =
      kacWardDeterminant (kacWardTransitionMatrix L z s) := by
    rw [← pow_two]
    exact orbitExplicitProduct_sq z hz4 s
  calc orbitExplicitProduct L s
      = S :=
        -- `claim_qbar_polynomial_square_root_unique` と上で示した平方・定数項
        qbarPolynomialSquareRoot_unique _ _ (orbitExplicitProduct_coeff_zero L s) hS.1
          (hPP.trans hS.2.symm)
    _ = (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
          (Int.castRingHom Qbar) :=
        -- `claim_determinant_polynomial_square_root_exists`
        kacWardDeterminant_squareRoot_eq_signedEvenSubgraphPolynomial z hz4 s S hS

end Ising2DLambda.KacWard
