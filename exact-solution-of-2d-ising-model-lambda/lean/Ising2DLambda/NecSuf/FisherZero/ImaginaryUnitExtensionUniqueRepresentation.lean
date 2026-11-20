/-
「順序付き部分体に虚数単位を足した表示は一意である」の必要十分版。

具体版の証明が使うのは次だけである。
- 台が除法環であること（`b-b' ≠ 0` の逆元で `ω = (b-b')⁻¹((b-b')ω)`）。
  積の可換性は使わない（式鎖は右分配法則と加法の可換群の性質だけで閉じる）。
- 部分集合 `S` が差・積・逆元で閉じること（`(b-b')⁻¹(a'-a) ∈ S`）。零元・単位元・和の閉性は使わない。
- `ω ∉ S` であること。具体版はこれを正錐と `ω·ω = -1` から
  `claim_imaginary_unit_outside_ordered_subfield` で得るので、正錐と `ω·ω = -1` は
  この一つの事実を通してだけ効く。これを削ると主張は成り立たない（`ω ∈ S` なら
  `0 + 1·ω = ω + 0·ω` が二つの表示になる）。
-/
import Mathlib.Algebra.Ring.Basic
import Mathlib.Algebra.GroupWithZero.Basic
import Mathlib.Algebra.Group.Basic
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.FisherZero

/-- 具体版と同じ段（式鎖、`b-b' ≠ 0` を仮定して `ω ∈ S` を導く背理、`b = b'`、`a = a'`）で示す。 -/
theorem imaginaryUnitExtension_unique_representation_necSuf {K : Type*} [DivisionRing K]
    (S : Set K)
    (hsub : ∀ x y : K, x ∈ S → y ∈ S → x - y ∈ S)
    (hmul : ∀ x y : K, x ∈ S → y ∈ S → x * y ∈ S)
    (hinv : ∀ x : K, x ∈ S → x⁻¹ ∈ S)
    (omega : K) (hout : omega ∉ S)
    (a a' b b' : K) (ha : a ∈ S) (ha' : a' ∈ S) (hb : b ∈ S) (hb' : b' ∈ S)
    (h : a + b * omega = a' + b' * omega) :
    a = a' ∧ b = b' := by
  have hchain : (b - b') * omega = a' - a := by
    calc (b - b') * omega = b * omega - b' * omega := sub_mul b b' omega
      _ = (a + b * omega) - (a + b' * omega) := by abel
      _ = (a' + b' * omega) - (a + b' * omega) := by rw [h]
      _ = a' - a := by abel
  have hzero : b - b' = 0 := by
    by_contra hne
    have hmem : omega ∈ S := by
      have hω : omega = (b - b')⁻¹ * (a' - a) := by
        calc omega = (b - b')⁻¹ * ((b - b') * omega) := by
              rw [← mul_assoc, inv_mul_cancel₀ hne, one_mul]
          _ = (b - b')⁻¹ * (a' - a) := by rw [hchain]
      rw [hω]
      exact hmul _ _ (hinv _ (hsub _ _ hb hb')) (hsub _ _ ha' ha)
    exact hout hmem
  have hbb : b = b' := by
    calc b = b' + (b - b') := by abel
      _ = b' + 0 := by rw [hzero]
      _ = b' := add_zero b'
  refine ⟨?_, hbb⟩
  calc a = (a + b * omega) - b * omega := by abel
    _ = (a' + b' * omega) - b * omega := by rw [h]
    _ = (a' + b' * omega) - b' * omega := by rw [hbb]
    _ = a' := by abel

end Ising2DLambda.NecSuf.FisherZero
