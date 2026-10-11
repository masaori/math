/- 対角相似とスカラー倍による行列式の保存。具体的な多項式行列で
単位行列の置換展開、スカラーの冪、逆行列の行列式の積を計算する。 -/
import Ising2DLambda.KacWard.GaugedTerminalMatrix
import Ising2DLambda.KacWard.TerminalMatrixDeterminant
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantScalar

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial

/-- 向き付き辺で添字づけた単位行列の行列式を、恒等置換の一項へ縮める。 -/
theorem polynomialOrientedIdentity_determinant (L : ℕ) :
    Matrix.det (1 : QbarPolynomialMatrix (OrientedEdge L)) = 1 := by
  classical
  let I : QbarPolynomialMatrix (OrientedEdge L) := 1
  let w : Equiv.Perm (OrientedEdge L) → QbarPoly := fun σ =>
    Polynomial.C ((NecSuf.AlgebraicEigenvalue.sign (fun i j => i < j) σ : ℤ) : Qbar)
  have hw : w 1 = 1 := by
    calc
      w 1 = Polynomial.C (1 : Qbar) := by
        simp [w, IntegerMatrix.inversionSign_eq_mathlibSign]
      _ = 1 := map_one Polynomial.C
  have hzero (σ : Equiv.Perm (OrientedEdge L)) (hσ : σ ≠ 1) :
      w σ * ∏ i, I i (σ i) = 0 := by
    have hmove : ∃ i, σ i ≠ i := by
      by_contra! h
      exact hσ (Equiv.ext h)
    obtain ⟨i, hi⟩ := hmove
    have hentry : I i (σ i) = 0 := by
      simp only [I, Matrix.one_apply, if_neg (Ne.symm hi)]
    have hprod : ∏ j, I j (σ j) = 0 := Finset.prod_eq_zero (mem_univ i) hentry
    calc
      w σ * ∏ j, I j (σ j) = w σ * 0 := congrArg (w σ * ·) hprod
      _ = 0 := mul_zero _
  calc
    Matrix.det I = ∑ σ : Equiv.Perm (OrientedEdge L), w σ * ∏ i, I i (σ i) :=
      qbarPolynomial_det_row_expansion I
    _ = w 1 * ∏ i, I i ((1 : Equiv.Perm (OrientedEdge L)) i) := by
      apply Finset.sum_eq_single 1
      · intro σ _ hσ
        exact hzero σ hσ
      · simp only [mem_univ, not_true_eq_false, false_implies]
    _ = w 1 * ∏ _i : OrientedEdge L, (1 : QbarPoly) := by
      simp only [Equiv.Perm.one_apply, I, Matrix.one_apply_eq]
    _ = 1 * ∏ _i : OrientedEdge L, (1 : QbarPoly) := by rw [hw]
    _ = 1 * 1 := by rw [Finset.prod_const_one]
    _ = 1 := one_mul _

/-- スカラーの冪の八等号。指数は向き付き辺の個数である。 -/
theorem gaugeScalar_pow_card (L : ℕ) (z : Qbar) (hz : z ^ 4 = -1) :
    qbarConst (z ^ 2) ^ Fintype.card (OrientedEdge L) = 1 := by
  have hcard : Fintype.card (OrientedEdge L) = 4 * L ^ 2 := by
    change Fintype.card (Edge L × Bool) = _
    rw [Fintype.card_prod, card_edge, Fintype.card_bool]
    ring
  have hz8 : z ^ 8 = 1 := by
    calc
      z ^ 8 = (z ^ 4) ^ 2 := pow_mul z 4 2
      _ = (-1 : Qbar) ^ 2 := congrArg (· ^ (2 : ℕ)) hz
      _ = 1 := neg_one_sq
  calc
    qbarConst (z ^ 2) ^ Fintype.card (OrientedEdge L) =
        qbarConst (z ^ 2) ^ (4 * L ^ 2) := by rw [hcard]
    _ = qbarConst ((z ^ 2) ^ (4 * L ^ 2)) := (map_pow Polynomial.C _ _).symm
    _ = qbarConst (z ^ (2 * (4 * L ^ 2))) := congrArg qbarConst (pow_mul z 2 _).symm
    _ = qbarConst (z ^ (8 * L ^ 2)) := by rw [show 2 * (4 * L ^ 2) = 8 * L ^ 2 by omega]
    _ = qbarConst ((z ^ 8) ^ (L ^ 2)) := congrArg qbarConst (pow_mul z 8 _)
    _ = qbarConst ((1 : Qbar) ^ (L ^ 2)) := by rw [hz8]
    _ = qbarConst (1 : Qbar) := congrArg qbarConst (one_pow _)
    _ = 1 := map_one Polynomial.C

/-- 本文の十二等号。既製の行列式の乗法性やスカラー倍には委ねない。 -/
theorem gaugedTerminalMatrix_determinant (L : ℕ) [NeZero L]
    (z : Qbar) (hz : z ^ 4 = -1) (s : SpinStructure) :
    Matrix.det (gaugedTerminalMatrix L z s) =
      kacWardDeterminant (kacWardTransitionMatrix L z s) := by
  classical
  have hpos : 0 < L := NeZero.pos L
  letI : Nonempty (OrientedEdge L) := by
    change Nonempty (Fin (2 * L ^ 2) × Bool)
    exact ⟨(⟨0, by positivity⟩, false)⟩
  let V := polynomialDiagonalGaugeInverse L z s
  let U := polynomialDiagonalGauge L z s
  let T := terminalMatrix L z s
  let c := qbarConst (z ^ 2)
  have hinverse : Matrix.det V * Matrix.det U = 1 := by
    calc
      Matrix.det V * Matrix.det U = Matrix.det (V * U) :=
        (qbarPolynomial_det_mul V U).symm
      _ = Matrix.det (1 : QbarPolynomialMatrix (OrientedEdge L)) :=
        congrArg Matrix.det (polynomialDiagonalGauge_mul_inverse L z hz s).2
      _ = 1 := polynomialOrientedIdentity_determinant L
  calc
    Matrix.det (gaugedTerminalMatrix L z s) = Matrix.det (c • ((V * T) * U)) := rfl
    _ = c ^ Fintype.card (OrientedEdge L) * Matrix.det ((V * T) * U) :=
      qbarPolynomial_det_smul c _
    _ = 1 * Matrix.det ((V * T) * U) := by rw [gaugeScalar_pow_card L z hz]
    _ = Matrix.det ((V * T) * U) := one_mul _
    _ = Matrix.det (V * T) * Matrix.det U := qbarPolynomial_det_mul _ _
    _ = (Matrix.det V * Matrix.det T) * Matrix.det U := by
      rw [qbarPolynomial_det_mul V T]
    _ = Matrix.det V * (Matrix.det T * Matrix.det U) := mul_assoc _ _ _
    _ = Matrix.det V * (Matrix.det U * Matrix.det T) :=
      congrArg (Matrix.det V * ·) (mul_comm _ _)
    _ = (Matrix.det V * Matrix.det U) * Matrix.det T := (mul_assoc _ _ _).symm
    _ = 1 * Matrix.det T := by rw [hinverse]
    _ = Matrix.det T := one_mul _
    _ = kacWardDeterminant (kacWardTransitionMatrix L z s) := terminalMatrix_determinant L z s

end Ising2DLambda.KacWard
