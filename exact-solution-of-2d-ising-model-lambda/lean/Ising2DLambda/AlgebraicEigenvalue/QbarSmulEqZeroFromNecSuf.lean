/-
具体版 `qbarSmul_eq_zero` が、必要十分版 `smul_eq_zero_necSuf` の特殊化として得られること。

  必要十分版の記号        具体版での取り方
  ι                       RowConfig L（行配位の全体）
  K                       Qbar（ℚ の代数閉包）
  m                       Qbar の積
  inv                     Qbar の逆元（零元の逆元は 0 だが、仮定 hinv は零でない元にしか課さない）
  one / zero              Qbar の 1 / 0
  s                       qbarVectorSmul L（スカラー倍）
  o                       qbarZeroVector L（零ベクトル）

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarSmulEqZero
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.SmulEqZero

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版を必要十分版から導く（`claim_qbar_smul_eq_zero`）。 -/
theorem qbarSmul_eq_zero_from_necSuf (L : ℕ) [NeZero L] (z : Qbar) (v : QbarRowVector L)
    (h : qbarVectorSmul L z v = qbarZeroVector L) (hv : v ≠ qbarZeroVector L) :
    z = 0 :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.smul_eq_zero_necSuf
    (m := fun a b => a * b) (inv := fun a => a⁻¹) (one := (1 : Qbar)) (zero := (0 : Qbar))
    (s := qbarVectorSmul L) (o := qbarZeroVector L)
    (fun _ _ _ => rfl)
    (fun _ => rfl)
    (fun x => mul_one x)
    (fun y hy => mul_inv_cancel₀ hy)
    (fun x y w => mul_assoc x y w)
    (fun x => zero_mul x)
    z v h hv

end Ising2DLambda.AlgebraicEigenvalue
