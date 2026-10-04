/-
反転置換行列の二乗は単位行列である。
本文と同じく、和のうち反転辺以外の項が零になることを先に示し、
唯一の項を残して反転の対合性を使う。成分の住処は ℤ。
-/
import Ising2DLambda.IntegerMatrix.Basic
import Ising2DLambda.KacWard.Basic

namespace Ising2DLambda.KacWard

open scoped BigOperators

def reversalMatrix (L : ℕ) : IntegerMatrix.Square (OrientedEdge L) :=
  fun e f => if f = reversal e then 1 else 0

theorem reversalMatrix_mul_self (L : ℕ) :
    IntegerMatrix.product (reversalMatrix L) (reversalMatrix L) =
      IntegerMatrix.identity (OrientedEdge L) := by
  apply Matrix.ext
  intro e f
  -- 本文の準備: 反転辺でない添字の項は零になる。
  have hzero (g : OrientedEdge L) (hg : g ≠ reversal e) :
      reversalMatrix L e g * reversalMatrix L g f = 0 := by
    calc
      reversalMatrix L e g * reversalMatrix L g f =
          0 * reversalMatrix L g f := by
        rw [show reversalMatrix L e g = 0 from if_neg hg]
      _ = 0 := zero_mul _
  calc
    IntegerMatrix.product (reversalMatrix L) (reversalMatrix L) e f =
        ∑ g, reversalMatrix L e g * reversalMatrix L g f := rfl
    _ = reversalMatrix L e (reversal e) * reversalMatrix L (reversal e) f :=
      Fintype.sum_eq_single (reversal e) hzero
    _ = 1 * reversalMatrix L (reversal e) f := by
      rw [show reversalMatrix L e (reversal e) = 1 from if_pos rfl]
    _ = reversalMatrix L (reversal e) f := one_mul _
    _ = (if f = reversal (reversal e) then 1 else 0) := rfl
    _ = (if f = e then 1 else 0) := by rw [reversal_involutive]
    _ = (if e = f then 1 else 0) := by simp only [@eq_comm _ f e]
    _ = IntegerMatrix.identity (OrientedEdge L) e f := rfl

end Ising2DLambda.KacWard
