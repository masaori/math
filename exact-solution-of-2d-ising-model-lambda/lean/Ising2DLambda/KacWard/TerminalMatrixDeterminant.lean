/-
端末行列と Kac--Ward 行列の行列式の一致の具体版。
整数から定数多項式への写像について、行指定の置換展開・有限積・積・有限和の
順に計算する準備の八つの等号と、乗法性を使う本体の五つの等号を本文に対応させる。
-/
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.KacWard.ReversalMatrixDeterminant

namespace Ising2DLambda.KacWard

open scoped BigOperators
open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
open Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 整数包含と定数多項式への埋め込みの合成。 -/
noncomputable def integerConstantPolynomialHom : ℤ →+* QbarPoly :=
  Polynomial.C.comp (Int.castRingHom Qbar)

/-- 本文の転倒数による符号を使った、行指定の多項式行列式の定義。 -/
theorem qbarPolynomialDeterminant_eq_signedPermutationSum
    {ι : Type} [Fintype ι] [LinearOrder ι] (A : QbarPolynomialMatrix ι) :
    Matrix.det A = ∑ σ : Equiv.Perm ι,
      integerConstantPolynomialHom (sign (fun i j : ι => i < j) σ) *
        ∏ i, A i (σ i) := by
  classical
  calc
    Matrix.det A = Matrix.det A.transpose := (Matrix.det_transpose A).symm
    _ = ∑ σ : Equiv.Perm ι, ((Equiv.Perm.sign σ : ℤ) : QbarPoly) *
        ∏ i, A.transpose (σ i) i := Matrix.det_apply' _
    _ = ∑ σ : Equiv.Perm ι,
        integerConstantPolynomialHom (sign (fun i j : ι => i < j) σ) *
          ∏ i, A i (σ i) := by
      simp only [IntegerMatrix.inversionSign_eq_mathlibSign, Matrix.transpose_apply,
        integerConstantPolynomialHom, RingHom.coe_comp, Function.comp_apply,
        Int.coe_castRingHom, map_intCast]

/-- 準備の八つの等号。整数行列式の値一は定数多項式へ送っても一になる。 -/
theorem polynomialReversalMatrix_determinant (L : ℕ) :
    Matrix.det (polynomialReversalMatrix L) = 1 := by
  classical
  calc
    Matrix.det (polynomialReversalMatrix L) =
        ∑ σ : Equiv.Perm (OrientedEdge L),
          integerConstantPolynomialHom (sign (fun e f => e < f) σ) *
            ∏ e, polynomialReversalMatrix L e (σ e) :=
      qbarPolynomialDeterminant_eq_signedPermutationSum _
    _ = ∑ σ : Equiv.Perm (OrientedEdge L),
        integerConstantPolynomialHom (sign (fun e f => e < f) σ) *
          ∏ e, integerConstantPolynomialHom (reversalMatrix L e (σ e)) := rfl
    _ = ∑ σ : Equiv.Perm (OrientedEdge L),
        integerConstantPolynomialHom (sign (fun e f => e < f) σ) *
          integerConstantPolynomialHom (∏ e, reversalMatrix L e (σ e)) := by
      simp only [map_prod]
    _ = ∑ σ : Equiv.Perm (OrientedEdge L),
        integerConstantPolynomialHom
          (sign (fun e f => e < f) σ * ∏ e, reversalMatrix L e (σ e)) := by
      simp only [map_mul]
    _ = integerConstantPolynomialHom
        (∑ σ : Equiv.Perm (OrientedEdge L),
          sign (fun e f => e < f) σ * ∏ e, reversalMatrix L e (σ e)) := by
      rw [map_sum]
    _ = integerConstantPolynomialHom (IntegerMatrix.determinant (reversalMatrix L)) := by
      rw [IntegerMatrix.determinant_eq_signedPermutationSum]
    _ = integerConstantPolynomialHom 1 := by rw [reversalMatrix_determinant]
    _ = 1 := map_one _

/-- 端末行列の定義、行列式の乗法性、準備の等式の順に進む本文の五つの等号。 -/
theorem terminalMatrix_determinant (L : ℕ) (z : Qbar) (s : SpinStructure) :
    Matrix.det (terminalMatrix L z s) =
      kacWardDeterminant (kacWardTransitionMatrix L z s) := by
  calc
    Matrix.det (terminalMatrix L z s) =
        Matrix.det (polynomialReversalMatrix L * spinKacWardPolynomialMatrix L z s) := rfl
    _ = Matrix.det (polynomialReversalMatrix L) *
        Matrix.det (spinKacWardPolynomialMatrix L z s) := Matrix.det_mul _ _
    _ = 1 * Matrix.det (spinKacWardPolynomialMatrix L z s) := by
      rw [polynomialReversalMatrix_determinant]
    _ = Matrix.det (spinKacWardPolynomialMatrix L z s) := one_mul _
    _ = kacWardDeterminant (kacWardTransitionMatrix L z s) := rfl

end Ising2DLambda.KacWard
