/-
具体版 `shiftMatrix_eigenvalue_rootOfUnity` が、必要十分版
`eigenvalue_pow_eq_one_necSuf` の特殊化として得られること。

  必要十分版の記号        具体版での取り方
  ι                       RowConfig L（行配位の全体）
  K                       Qbar（ℚ の代数閉包）
  M                       QbarRowMatrix L（代数的数を成分とする行列）
  add / mul / neg         Qbar の和・積・加法の逆元
  one / zero              Qbar の 1 / 0
  s / o                   qbarVectorSmul L / qbarZeroVector L
  act                     qbarAction L（行列の列ベクトルへの作用）
  An                      (Ev_ξ(U))^L
  Id                      I^Qbar_L
  y                       z^L（必要十分版では冪であることを使わない）
  hcancel                 qbarSmul_eq_zero（前セクションの主張）

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftMatrixEigenvalueRootOfUnity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.EigenvaluePowEqOne

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.TransferMatrix

/-- 具体版を必要十分版から導く（`claim_shift_matrix_eigenvalue_root_of_unity`）。 -/
theorem shiftMatrix_eigenvalue_rootOfUnity_from_necSuf
    (L : ℕ) [NeZero L] (ξ : Qbar) (z : Qbar)
    (h : IsQbarEigenvalue L (qbarMatrixEval L ξ (shiftMatrix L)) z) :
    z ∈ RootOfUnity L := by
  obtain ⟨v, hv, hne⟩ := h
  show z ^ L = 1
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.eigenvalue_pow_eq_one_necSuf
    (add := fun a b => a + b) (mul := fun a b => a * b) (neg := fun a => -a)
    (one := (1 : Qbar)) (zero := (0 : Qbar))
    (s := qbarVectorSmul L) (o := qbarZeroVector L) (act := qbarAction L)
    (An := qbarMatrixPow L (qbarMatrixEval L ξ (shiftMatrix L)) L)
    (Id := qbarIdentityMatrix L) (v := v) (y := z ^ L)
    (qbarMatrixEval_shiftMatrix_pow_L L ξ)
    (qbarAction_pow_smul L (qbarMatrixEval L ξ (shiftMatrix L)) z v hv L)
    (qbarIdentity_action L v)
    (fun _ _ _ => rfl)
    (fun _ => rfl)
    (fun a b c => add_mul a b c)
    (fun x => one_mul x)
    (add_neg_cancel (1 : Qbar))
    (neg_add_cancel (1 : Qbar))
    (fun x => zero_mul x)
    (fun x => add_zero x)
    (fun x => zero_add x)
    (fun a b c => add_assoc a b c)
    (fun w hw => qbarSmul_eq_zero L w v hw hne)

end Ising2DLambda.AlgebraicEigenvalue
