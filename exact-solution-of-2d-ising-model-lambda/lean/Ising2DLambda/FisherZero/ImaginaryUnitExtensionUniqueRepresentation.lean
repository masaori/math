/-
人手証明の主張「順序付き部分体に虚数単位を足した表示は一意である」
（ラベル `claim_imaginary_unit_extension_unique_representation`）の具体版。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ImaginaryUnitOutsideOrderedSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_imaginary_unit_extension_unique_representation` の具体版。
人手証明の段: 式鎖 `(b-b')ω = bω - b'ω = (a+bω) - (a+b'ω) = (a'+b'ω) - (a+b'ω) = a' - a`。
`b-b' ≠ 0` なら `ω = (b-b')⁻¹((b-b')ω) = (b-b')⁻¹(a'-a) ∈ F` となり、
`claim_imaginary_unit_outside_ordered_subfield`（`imaginaryUnit_not_mem_orderedSubfield`）に矛盾する。
ゆえに `b = b' + (b-b') = b' + 0 = b'`、`a = (a+bω) - bω = (a'+b'ω) - bω = (a'+b'ω) - b'ω = a'`。 -/
theorem imaginaryUnitExtension_unique_representation
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1)
    (a a' b b' : Qbar) (ha : a ∈ F) (ha' : a' ∈ F) (hb : b ∈ F) (hb' : b' ∈ F)
    (h : a + b * omega = a' + b' * omega) :
    a = a' ∧ b = b' := by
  -- 式鎖
  have hchain : (b - b') * omega = a' - a := by
    calc (b - b') * omega = b * omega - b' * omega := sub_mul b b' omega
      _ = (a + b * omega) - (a + b' * omega) := by ring
      _ = (a' + b' * omega) - (a + b' * omega) := by rw [h]
      _ = a' - a := by ring
  -- `b - b' = 0`（そうでなければ ω ∈ F となり非所属の主張に矛盾）
  have hzero : b - b' = 0 := by
    by_contra hne
    have hmem : omega ∈ F := by
      have hω : omega = (b - b')⁻¹ * (a' - a) := by
        calc omega = (b - b')⁻¹ * ((b - b') * omega) := by
              rw [← mul_assoc, inv_mul_cancel₀ hne, one_mul]
          _ = (b - b')⁻¹ * (a' - a) := by rw [hchain]
      rw [hω]
      exact F.mul_mem (F.inv_mem (F.sub_mem hb hb')) (F.sub_mem ha' ha)
    exact imaginaryUnit_not_mem_orderedSubfield F C hC omega homega hmem
  have hbb : b = b' := by
    calc b = b' + (b - b') := by ring
      _ = b' + 0 := by rw [hzero]
      _ = b' := add_zero b'
  refine ⟨?_, hbb⟩
  calc a = (a + b * omega) - b * omega := by ring
    _ = (a' + b' * omega) - b * omega := by rw [h]
    _ = (a' + b' * omega) - b' * omega := by rw [hbb]
    _ = a' := by ring

end Ising2DLambda.FisherZero
