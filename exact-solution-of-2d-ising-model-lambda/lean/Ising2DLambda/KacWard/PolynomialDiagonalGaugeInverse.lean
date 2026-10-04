/-
対角変換の両側逆関係を Qbar から定数多項式へ移す具体版。
本文の有限和の空集合三行・挿入四行、単位行列の二場合各三行、
行列積の七行を独立に書く。必要十分版は呼ばない。
-/
import Ising2DLambda.KacWard.DiagonalGaugeInverse

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped BigOperators

/-- 対角変換の各成分を、既存の定数埋込みで多項式へ送る。 -/
noncomputable def polynomialDiagonalGauge (L : ℕ) (z : Qbar) (s : SpinStructure) :
    QbarPolynomialMatrix (OrientedEdge L) :=
  (diagonalGauge L z s).map qbarConst

/-- 逆行列の各成分を、同じ定数埋込みで多項式へ送る。 -/
noncomputable def polynomialDiagonalGaugeInverse (L : ℕ) (z : Qbar) (s : SpinStructure) :
    QbarPolynomialMatrix (OrientedEdge L) :=
  (diagonalGaugeInverse L z s).map qbarConst

/-- 本文の有限和の準備。空集合三等号と、一元挿入四等号。 -/
lemma polynomialDiagonalGauge_const_sum (L : ℕ) (a : OrientedEdge L → Qbar)
    (S : Finset (OrientedEdge L)) :
    qbarConst (∑ g ∈ S, a g) = ∑ g ∈ S, qbarConst (a g) := by
  induction S using Finset.induction_on with
  | empty =>
      calc
        qbarConst (∑ g ∈ (∅ : Finset (OrientedEdge L)), a g) = qbarConst 0 := by
          rw [Finset.sum_empty]
        _ = 0 := Polynomial.C_0
        _ = ∑ g ∈ (∅ : Finset (OrientedEdge L)), qbarConst (a g) :=
          Finset.sum_empty.symm
  | @insert h S hh ih =>
      calc
        qbarConst (∑ g ∈ insert h S, a g) = qbarConst (a h + ∑ g ∈ S, a g) := by
          rw [Finset.sum_insert hh]
        _ = qbarConst (a h) + qbarConst (∑ g ∈ S, a g) := Polynomial.C_add
        _ = qbarConst (a h) + ∑ g ∈ S, qbarConst (a g) := by rw [ih]
        _ = ∑ g ∈ insert h S, qbarConst (a g) := (Finset.sum_insert hh).symm

/-- 本文の単位行列の準備。対角・非対角それぞれ三等号。 -/
lemma polynomialDiagonalGauge_const_identity (L : ℕ) (e f : OrientedEdge L) :
    qbarConst ((1 : Matrix (OrientedEdge L) (OrientedEdge L) Qbar) e f) =
      (1 : QbarPolynomialMatrix (OrientedEdge L)) e f := by
  by_cases hef : e = f
  · subst f
    calc
      qbarConst ((1 : Matrix (OrientedEdge L) (OrientedEdge L) Qbar) e e) =
          qbarConst 1 := by rw [Matrix.one_apply_eq]
      _ = 1 := Polynomial.C_1
      _ = (1 : QbarPolynomialMatrix (OrientedEdge L)) e e := by rw [Matrix.one_apply_eq]
  · calc
      qbarConst ((1 : Matrix (OrientedEdge L) (OrientedEdge L) Qbar) e f) =
          qbarConst 0 := by rw [Matrix.one_apply_ne hef]
      _ = 0 := Polynomial.C_0
      _ = (1 : QbarPolynomialMatrix (OrientedEdge L)) e f := by rw [Matrix.one_apply_ne hef]

/-- 実際の対角変換と逆行列を定数多項式へ送っても、両側逆の関係は保たれる。 -/
theorem polynomialDiagonalGauge_mul_inverse (L : ℕ) (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    polynomialDiagonalGauge L z s * polynomialDiagonalGaugeInverse L z s = 1 ∧
      polynomialDiagonalGaugeInverse L z s * polynomialDiagonalGauge L z s = 1 := by
  have hproduct (M N : Matrix (OrientedEdge L) (OrientedEdge L) Qbar)
      (hMN : M * N = 1) : M.map qbarConst * N.map qbarConst = 1 := by
    apply Matrix.ext
    intro e f
    -- 本文の共通七等号。両方の組で同じ成分計算を使う。
    calc
      (M.map qbarConst * N.map qbarConst) e f =
          ∑ g, M.map qbarConst e g * N.map qbarConst g f := rfl
      _ = ∑ g, qbarConst (M e g) * qbarConst (N g f) := rfl
      _ = ∑ g, qbarConst (M e g * N g f) :=
        Finset.sum_congr rfl (fun _ _ => Polynomial.C_mul.symm)
      _ = qbarConst (∑ g, M e g * N g f) :=
        (polynomialDiagonalGauge_const_sum L (fun g => M e g * N g f) Finset.univ).symm
      _ = qbarConst ((M * N) e f) := rfl
      _ = qbarConst ((1 : Matrix (OrientedEdge L) (OrientedEdge L) Qbar) e f) := by
        rw [hMN]
      _ = (1 : QbarPolynomialMatrix (OrientedEdge L)) e f :=
        polynomialDiagonalGauge_const_identity L e f
  have hUV := diagonalGauge_mul_inverse L z hz s
  constructor
  · exact hproduct (diagonalGauge L z s) (diagonalGaugeInverse L z s) hUV.1
  · exact hproduct (diagonalGaugeInverse L z s) (diagonalGauge L z s) hUV.2

end Ising2DLambda.KacWard
