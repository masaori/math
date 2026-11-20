import Ising2DLambda.FisherZero.ImaginaryUnitExtensionSquareRoot
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomials
import Ising2DLambda.FisherZero.ImaginaryUnitOutsideOrderedSubfield
import Ising2DLambda.FisherZero.QuadraticLinearValuesAdjoin
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 判別式を二係数表示へ戻し、平方根から二次式の根を作る。 -/
private theorem imaginaryUnitExtension_monicQuadraticRoot
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C →
      ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (omega p q : Qbar) (homega : omega * omega = -1)
    (hp : ∃ a b : Qbar, a ∈ F ∧ b ∈ F ∧ p = a + b * omega)
    (hq : ∃ c d : Qbar, c ∈ F ∧ d ∈ F ∧ q = c + d * omega) :
    ∃ r x y : Qbar, x ∈ F ∧ y ∈ F ∧ r = x + y * omega ∧
      r * r + p * r + q = 0 := by
  obtain ⟨a, b, ha, hb, hp⟩ := hp
  obtain ⟨c, d, hc, hd, hq⟩ := hq
  let A : Qbar := a * a - b * b - 4 * c
  let B : Qbar := 2 * a * b - 4 * d
  have hA : A ∈ F := by
    dsimp [A]
    exact F.sub_mem (F.sub_mem (F.mul_mem ha ha) (F.mul_mem hb hb))
      (F.mul_mem (natCast_mem_subfield F 4) hc)
  have hB : B ∈ F := by
    dsimp [B]
    exact F.sub_mem (F.mul_mem (F.mul_mem (natCast_mem_subfield F 2) ha) hb)
      (F.mul_mem (natCast_mem_subfield F 4) hd)
  have hdisc : p * p - 4 * q = A + B * omega := by
    dsimp [A, B]
    rw [hp, hq]
    linear_combination (b * b) * homega
  obtain ⟨u, v, hu, hv, hs⟩ :=
    imaginaryUnitExtension_squareRoot F C hC hpositive A B omega hA hB homega
  let s : Qbar := u + v * omega
  have hs' : s * s = p * p - 4 * q := by
    dsimp [s]
    rw [hs, ← hdisc]
  let x : Qbar := (-a + u) / 2
  let y : Qbar := (-b + v) / 2
  have hx : x ∈ F := by
    dsimp [x]
    exact F.div_mem (F.add_mem (F.neg_mem ha) hu) (natCast_mem_subfield F 2)
  have hy : y ∈ F := by
    dsimp [y]
    exact F.div_mem (F.add_mem (F.neg_mem hb) hv) (natCast_mem_subfield F 2)
  let r : Qbar := (-p + s) / 2
  have hr : r = x + y * omega := by
    dsimp [r, x, y, s]
    rw [hp]
    ring
  have hroot : r * r + p * r + q = 0 := by
    dsimp [r]
    field_simp
    linear_combination hs'
  exact ⟨r, x, y, hx, hy, hr, hroot⟩

/-- 一次式表示の部分体で先頭係数を割り、モニックな場合へ帰着する。 -/
theorem imaginaryUnitExtension_quadraticRoot
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C →
      ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (omega e p q : Qbar) (homega : omega * omega = -1)
    (he0 : e ≠ 0)
    (he : e ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)))
    (hp : p ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)))
    (hq : q ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar))) :
    ∃ r x y : Qbar, x ∈ F ∧ y ∈ F ∧ r = x + y * omega ∧
      e * (r * r) + p * r + q = 0 := by
  have hnot : omega ∉ F := imaginaryUnit_not_mem_orderedSubfield F C hC omega homega
  have hlin := quadraticLinearValues_eq_adjoin F (-1) omega
    (F.neg_mem F.one_mem) homega hnot
  have hP : p / e ∈ quadraticLinearValues F omega := by
    rw [hlin]
    exact (Subfield.closure _).div_mem hp he
  have hQ : q / e ∈ quadraticLinearValues F omega := by
    rw [hlin]
    exact (Subfield.closure _).div_mem hq he
  obtain ⟨a, b, ha, hb, hP⟩ := hP
  obtain ⟨c, d, hc, hd, hQ⟩ := hQ
  obtain ⟨r, x, y, hx, hy, hr, hroot⟩ :=
    imaginaryUnitExtension_monicQuadraticRoot F C hC hpositive omega
      (p / e) (q / e) homega ⟨a, b, ha, hb, hP⟩ ⟨c, d, hc, hd, hQ⟩
  refine ⟨r, x, y, hx, hy, hr, ?_⟩
  calc
    e * (r * r) + p * r + q = e * (r * r + (p / e) * r + q / e) := by
      field_simp [he0]
    _ = 0 := by rw [hroot]; ring

end Ising2DLambda.FisherZero
