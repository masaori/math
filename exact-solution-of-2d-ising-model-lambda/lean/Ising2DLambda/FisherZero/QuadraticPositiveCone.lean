/-
「二次体の正錐の定義」の Lean 形式化。
Q_s を Qbar の部分集合として置き、存在証拠から唯一の有理係数対を取り出す写像を定め、
本文の三条件をその係数対だけに対する述語として置く。実数・複素数の順序は使わない。
-/
import Ising2DLambda.FisherZero.QuadraticRepresentationUnique

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_quadratic_field_set` の具体版。 -/
def quadraticFieldSet (s : Qbar) : Set Qbar :=
  {xi | ∃ a b : ℚ,
    xi = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s}

/-- `Q_s` の元を、台集合への所属証拠を持つ元として表す型。 -/
abbrev QuadraticFieldElement (s : Qbar) := {xi : Qbar // xi ∈ quadraticFieldSet s}

/-- `def_quadratic_representation_map` の具体版。 -/
noncomputable def quadraticRepresentation (s : Qbar) (xi : QuadraticFieldElement s) : ℚ × ℚ :=
  let a := Classical.choose xi.property
  let b := Classical.choose (Classical.choose_spec xi.property)
  (a, b)

/-- 選ばれた表示は元を実際に表す。 -/
theorem quadraticRepresentation_spec (s : Qbar) (xi : QuadraticFieldElement s) :
    (xi : Qbar) = algebraMap ℚ Qbar (quadraticRepresentation s xi).1 +
      algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s := by
  exact Classical.choose_spec (Classical.choose_spec xi.property)

/-- `s²=2` のもとでは、表示写像の値は任意の表示と一致する。 -/
theorem quadraticRepresentation_eq
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) (a b : ℚ)
    (hxi : (xi : Qbar) = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s) :
    quadraticRepresentation s xi = (a, b) := by
  have hUnique := quadraticRepresentationUnique s hs
    (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2 a b
    ((quadraticRepresentation_spec s xi).symm.trans hxi)
  exact Prod.ext hUnique.1 hUnique.2

/-- `def_quadratic_positive_cone` の三つの有理条件。 -/
def quadraticCoefficientPositive (ab : ℚ × ℚ) : Prop :=
  (0 ≤ ab.1 ∧ 0 ≤ ab.2 ∧ ab ≠ (0, 0)) ∨
  (0 < ab.1 ∧ ab.2 < 0 ∧ 2 * ab.2 * ab.2 < ab.1 * ab.1) ∨
  (ab.1 < 0 ∧ 0 < ab.2 ∧ ab.1 * ab.1 < 2 * ab.2 * ab.2)

/-- `def_quadratic_positive_cone` の具体版。 -/
noncomputable def quadraticPositiveCone (s : Qbar) : Set (QuadraticFieldElement s) :=
  {xi | quadraticCoefficientPositive (quadraticRepresentation s xi)}

/-- `s` 自身を `Q_s` の元として持ち上げる。 -/
def quadraticGenerator (s : Qbar) : QuadraticFieldElement s :=
  ⟨s, 0, 1, by simp⟩

/-- 本文どおり `rep_s(s)=(0,1)` である。 -/
theorem quadraticRepresentation_generator
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticRepresentation s (quadraticGenerator s) = (0, 1) := by
  apply quadraticRepresentation_eq s hs (quadraticGenerator s) 0 1
  simp [quadraticGenerator]

/-- 本文どおり、選んだ根 `s` は正錐に属する。 -/
theorem quadraticGenerator_mem_positiveCone
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticGenerator s ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticGenerator s))
  rw [quadraticRepresentation_generator s hs]
  exact Or.inl ⟨le_rfl, zero_le_one, by norm_num⟩

/-- `remark_positive_cone_sign_choice` の台集合の等号。 -/
theorem quadraticFieldSet_neg (s : Qbar) : quadraticFieldSet s = quadraticFieldSet (-s) := by
  ext xi
  constructor
  · rintro ⟨a, b, rfl⟩
    refine ⟨a, -b, ?_⟩
    simp
  · rintro ⟨a, b, rfl⟩
    refine ⟨a, -b, ?_⟩
    simp

end Ising2DLambda.FisherZero
