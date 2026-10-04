/-
端末行列の成分を、実際の向き付き辺と四つのねじれから計算する具体版。
行の選択には回転位相の根の条件を使わない。L=1 でも二つの項を別々に保つ。
-/
import Ising2DLambda.KacWard.ReversalFreeMovedSupportEven
import Ising2DLambda.KacWard.ReversalDirectionShift
import Ising2DLambda.KacWard.ReversalMatrix
import Ising2DLambda.KacWard.DeterminantConstantTerm

namespace Ising2DLambda.KacWard

open Finset Polynomial Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- 終点から始まり、直ちに同じ辺を反転しない後続辺の有限集合。 -/
def nonbacktrackingSuccessors {L : ℕ} (e : OrientedEdge L) : Finset (OrientedEdge L) :=
  univ.filter (fun f => orientedTarget e = orientedSource f ∧ f ≠ reversal e)

/-- 横周期の切断線を横切る、自然数値の指示子。 -/
def horizontalSeamParity {L : ℕ} (e : OrientedEdge L) : ℕ :=
  if e.1.val < L ^ 2 ∧ edgeColumn L e.1 = L - 1 then 1 else 0

/-- 縦周期の切断線を横切る、自然数値の指示子。 -/
def verticalSeamParity {L : ℕ} (e : OrientedEdge L) : ℕ :=
  if ¬ e.1.val < L ^ 2 ∧ edgeRow L e.1 = L - 1 then 1 else 0

/-- 本文の整数のねじれ符号。Bool の false/true を自然数の 0/1 へ移す。 -/
def twistSign {L : ℕ} (s : SpinStructure) (e : OrientedEdge L) : ℤ :=
  (-1) ^ (s.1.toNat * horizontalSeamParity e + s.2.toNat * verticalSeamParity e)

/-- 本文の三つの回転位相。定義域外の反対方向へは零を割り当てて全域化する。 -/
noncomputable def rotationPhase {L : ℕ} (z : Qbar) (e f : OrientedEdge L) : Qbar :=
  if directionNumber f = directionNumber e then 1
  else if directionNumber f = directionNumber e + 1 then z
  else if directionNumber f = directionNumber e - 1 then z⁻¹
  else 0

/-- 実際の後続辺・ねじれ符号・回転位相から定める四つの遷移行列。 -/
noncomputable def kacWardTransitionMatrix (L : ℕ) (z : Qbar) (s : SpinStructure) :
    Matrix (OrientedEdge L) (OrientedEdge L) Qbar :=
  fun e f => if f ∈ nonbacktrackingSuccessors e
    then (twistSign s f : Qbar) * rotationPhase z e f else 0

/-- 実際の遷移行列を既存の K(x)=I-x C(M) の定義へ供給する。 -/
noncomputable def spinKacWardPolynomialMatrix (L : ℕ) (z : Qbar) (s : SpinStructure) :
    QbarPolynomialMatrix (OrientedEdge L) :=
  kacWardPolynomialMatrix (kacWardTransitionMatrix L z s)

/-- 整数の反転行列の各成分を Qbar を経て定数多項式へ送る。 -/
noncomputable def polynomialReversalMatrix (L : ℕ) :
    QbarPolynomialMatrix (OrientedEdge L) :=
  (reversalMatrix L).map (fun n : ℤ => C (n : Qbar))

/-- 本文の端末行列 Kt(x)=J K(x)。 -/
noncomputable def terminalMatrix (L : ℕ) (z : Qbar) (s : SpinStructure) :
    QbarPolynomialMatrix (OrientedEdge L) :=
  polynomialReversalMatrix L * spinKacWardPolynomialMatrix L z s

/-- 反転辺の終点は元の辺の始点である。二つの向きの端点を直接開く。 -/
lemma orientedTarget_reversal {L : ℕ} (e : OrientedEdge L) :
    orientedTarget (reversal e) = orientedSource e := by
  rcases e with ⟨edge, false | true⟩
  · calc
      orientedTarget (reversal (edge, false)) = orientedTarget (edge, true) := rfl
      _ = boundary0 L edge := rfl
      _ = orientedSource (edge, false) := rfl
  · calc
      orientedTarget (reversal (edge, true)) = orientedTarget (edge, false) := rfl
      _ = boundary1 L edge := rfl
      _ = orientedSource (edge, true) := rfl

/-- 後続辺の定義、端点、対合性、等号対称性の四段。 -/
lemma mem_nonbacktrackingSuccessors_reversal {L : ℕ} (e f : OrientedEdge L) :
    f ∈ nonbacktrackingSuccessors (reversal e) ↔
      orientedSource f = orientedSource e ∧ f ≠ e := by
  calc
    _ ↔ orientedTarget (reversal e) = orientedSource f ∧
        f ≠ reversal (reversal e) := by
      simp only [nonbacktrackingSuccessors, mem_filter, mem_univ, true_and]
    _ ↔ orientedSource e = orientedSource f ∧ f ≠ reversal (reversal e) := by
      rw [orientedTarget_reversal]
    _ ↔ orientedSource e = orientedSource f ∧ f ≠ e := by
      rw [reversal_involutive]
    _ ↔ orientedSource f = orientedSource e ∧ f ≠ e := by
      simp only [@eq_comm _ (orientedSource e) (orientedSource f)]

/-- 端末行列の成分。恒等行列由来の項と遷移由来の項を別々に残す。 -/
theorem terminalMatrix_entry (L : ℕ) [NeZero L] (z : Qbar) (s : SpinStructure)
    (e f : OrientedEdge L) :
    terminalMatrix L z s e f =
      (if f = reversal e then 1 else 0) - X *
        (if orientedSource f = orientedSource e ∧ f ≠ e
          then C ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) else 0) := by
  have hzero (g : OrientedEdge L) (hg : g ≠ reversal e) :
      C (reversalMatrix L e g : Qbar) * spinKacWardPolynomialMatrix L z s g f = 0 := by
    calc
      _ = C ((0 : ℤ) : Qbar) * spinKacWardPolynomialMatrix L z s g f := by
        rw [show reversalMatrix L e g = 0 from if_neg hg]
      _ = C (0 : Qbar) * spinKacWardPolynomialMatrix L z s g f := by rw [Int.cast_zero]
      _ = 0 * spinKacWardPolynomialMatrix L z s g f := by rw [C_0]
      _ = 0 := zero_mul _
  have hidentity : (1 : QbarPolynomialMatrix (OrientedEdge L)) (reversal e) f =
      (if f = reversal e then 1 else 0) := by
    calc
      (1 : QbarPolynomialMatrix (OrientedEdge L)) (reversal e) f =
          (if reversal e = f then 1 else 0) := rfl
      _ = (if f = reversal e then 1 else 0) := by
        simp only [@eq_comm _ (reversal e) f]
  have hcoefficient : C (kacWardTransitionMatrix L z s (reversal e) f) =
      (if orientedSource f = orientedSource e ∧ f ≠ e
        then C ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) else 0) := by
    calc
      _ = C (if f ∈ nonbacktrackingSuccessors (reversal e)
          then (twistSign s f : Qbar) * rotationPhase z (reversal e) f else 0) := rfl
      _ = C (if orientedSource f = orientedSource e ∧ f ≠ e
          then (twistSign s f : Qbar) * rotationPhase z (reversal e) f else 0) := by
        simp only [mem_nonbacktrackingSuccessors_reversal]
      _ = (if orientedSource f = orientedSource e ∧ f ≠ e
          then C ((twistSign s f : Qbar) * rotationPhase z (reversal e) f) else C 0) := by
        rw [apply_ite C]
      _ = _ := by rw [C_0]
  calc
    terminalMatrix L z s e f =
        ∑ g, C (reversalMatrix L e g : Qbar) * spinKacWardPolynomialMatrix L z s g f := rfl
    _ = C (reversalMatrix L e (reversal e) : Qbar) *
        spinKacWardPolynomialMatrix L z s (reversal e) f :=
      Fintype.sum_eq_single (reversal e) hzero
    _ = C ((1 : ℤ) : Qbar) * spinKacWardPolynomialMatrix L z s (reversal e) f := by
      rw [show reversalMatrix L e (reversal e) = 1 from if_pos rfl]
    _ = C (1 : Qbar) * spinKacWardPolynomialMatrix L z s (reversal e) f := by rw [Int.cast_one]
    _ = 1 * spinKacWardPolynomialMatrix L z s (reversal e) f := by rw [C_1]
    _ = spinKacWardPolynomialMatrix L z s (reversal e) f := one_mul _
    _ = (1 : QbarPolynomialMatrix (OrientedEdge L)) (reversal e) f -
        X * C (kacWardTransitionMatrix L z s (reversal e) f) := rfl
    _ = (if f = reversal e then 1 else 0) -
        X * C (kacWardTransitionMatrix L z s (reversal e) f) := by rw [hidentity]
    _ = _ := by rw [hcoefficient]

end Ising2DLambda.KacWard
