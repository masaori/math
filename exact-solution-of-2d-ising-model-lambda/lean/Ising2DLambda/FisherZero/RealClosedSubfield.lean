/-
人手証明の定義「実閉部分体と虚数単位」（ラベル `def_real_closed_subfield`）の具体版。

R を Qbar の部分体として持ち、本文の平方の三分法、虚数単位、一意表示をそのまま記録する。
本文中の帰結 ω⁴ = 1 は、本文と同じ三段で示す。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 三つの命題のちょうど一つが成り立つこと。 -/
def ExactlyOneOfThree (p q r : Prop) : Prop :=
  (p ∨ q ∨ r) ∧ ¬(p ∧ q) ∧ ¬(p ∧ r) ∧ ¬(q ∧ r)

/-- `def_real_closed_subfield` の四条件を Qbar 上で保持する具体的なデータ。 -/
structure RealClosedSubfieldData where
  carrier : Subfield Qbar
  omega : Qbar
  squareTrichotomy : ∀ z : carrier,
    ExactlyOneOfThree
      (z = 0)
      (∃ w : carrier, w ≠ 0 ∧ z = w * w)
      (∃ w : carrier, w ≠ 0 ∧ -z = w * w)
  omega_sq : omega * omega = -1
  unique_decomposition : ∀ xi : Qbar, ∃! ab : carrier × carrier,
    xi = (ab.1 : Qbar) + (ab.2 : Qbar) * omega

/-- `def_real_closed_subfield` の第五条件（自己双対点の平方根 s との整合）まで含めたデータ。
本文の五条件の組はこれに対応する。第一〜四条件だけを使う既存の定理は
`toRealClosedSubfieldData` を通して弱い側のデータを受け取る。 -/
structure RealClosedSubfieldSqrtTwoData (s : Qbar) extends RealClosedSubfieldData where
  sqrtTwo_square : ∃ w : toRealClosedSubfieldData.carrier,
    w ≠ 0 ∧ s = (w : Qbar) * (w : Qbar)

/-- 本文どおり、固定した虚数単位は四乗すると一になる。 -/
theorem realClosedOmega_pow_four (data : RealClosedSubfieldData) :
    data.omega ^ 4 = 1 := by
  calc
    data.omega ^ 4 = (data.omega * data.omega) * (data.omega * data.omega) := by ring
    _ = (-1) * (-1) := by rw [data.omega_sq]
    _ = 1 := by ring

end Ising2DLambda.FisherZero
