/-
「低温展開の自明セクター表示」の必要十分版。
具体版の添字の取り替えと同じく、有限集合の間の写像が両向きに往復し、
重みがその写像で保存されることだけを使う。

両向きの所属と往復から終域を像として書き、逆写像から単射性を得る。
重みを置き換えた後、具体版と同じく始域の有限集合への一元追加で帰納する。
空集合では両辺が空和、一元追加では単射性により像にも新しい一元だけが加わる。
仮定に要るのは、値の型が可換加法モノイドであること（有限和の記法）、
両向きの所属、往復の二等式、重みの保存だけである。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- 再添字付けの本体。値は可換加法モノイド、写像は始域上で単射であれば足りる。 -/
private theorem sum_forward_eq_sum_image_aux
    {A B M : Type*} [DecidableEq A] [DecidableEq B] [AddCommMonoid M]
    (forward : A → B) (targetWeight : B → M)
    (source : Finset A) :
    (∀ a ∈ source, ∀ a' ∈ source, forward a = forward a' → a = a') →
      ∑ a ∈ source, targetWeight (forward a) =
        ∑ b ∈ source.image forward, targetWeight b := by
  classical
  induction source using Finset.induction_on with
  | empty =>
    intro _
    simp only [image_empty, sum_empty]
  | insert a s ha ih =>
    intro hinjective
    have hinjective' : ∀ x ∈ s, ∀ y ∈ s, forward x = forward y → x = y := by
      intro x hx y hy hxy
      exact hinjective x (mem_insert_of_mem hx) y (mem_insert_of_mem hy) hxy
    have hnot : forward a ∉ s.image forward := by
      intro hmem
      obtain ⟨a', ha', hEq⟩ := mem_image.mp hmem
      have hsame := hinjective a' (mem_insert_of_mem ha') a (mem_insert_self a s) hEq
      exact ha (hsame ▸ ha')
    calc
      ∑ x ∈ insert a s, targetWeight (forward x)
          = targetWeight (forward a) + ∑ x ∈ s, targetWeight (forward x) := sum_insert ha
      _ = targetWeight (forward a) + ∑ b ∈ s.image forward, targetWeight b :=
        congrArg (fun value => targetWeight (forward a) + value) (ih hinjective')
      _ = ∑ b ∈ insert (forward a) (s.image forward), targetWeight b := (sum_insert hnot).symm
      _ = ∑ b ∈ (insert a s).image forward, targetWeight b := by rw [image_insert]

/-- 互いに逆な写像が重みを保つなら、二つの有限和は等しい。 -/
theorem weighted_sum_eq_of_inverse_necSuf
    {A B M : Type*} [DecidableEq A] [DecidableEq B] [AddCommMonoid M]
    (source : Finset A) (target : Finset B)
    (forward : A → B) (backward : B → A)
    (hforward : ∀ a ∈ source, forward a ∈ target)
    (hbackward : ∀ b ∈ target, backward b ∈ source)
    (hleft : ∀ a ∈ source, backward (forward a) = a)
    (hright : ∀ b ∈ target, forward (backward b) = b)
    (sourceWeight : A → M) (targetWeight : B → M)
    (hweight : ∀ a ∈ source, sourceWeight a = targetWeight (forward a)) :
    ∑ a ∈ source, sourceWeight a = ∑ b ∈ target, targetWeight b := by
  classical
  have htarget : source.image forward = target := by
    ext b
    constructor
    · intro hb
      obtain ⟨a, ha, hab⟩ := mem_image.mp hb
      exact hab ▸ hforward a ha
    · intro hb
      exact mem_image.mpr ⟨backward b, hbackward b hb, hright b hb⟩
  have hinjective : ∀ a ∈ source, ∀ a' ∈ source, forward a = forward a' → a = a' := by
    intro a ha a' ha' haa'
    calc
      a = backward (forward a) := (hleft a ha).symm
      _ = backward (forward a') := congrArg backward haa'
      _ = a' := hleft a' ha'
  calc
    ∑ a ∈ source, sourceWeight a = ∑ a ∈ source, targetWeight (forward a) :=
      sum_congr rfl hweight
    _ = ∑ b ∈ source.image forward, targetWeight b :=
      sum_forward_eq_sum_image_aux forward targetWeight source hinjective
    _ = ∑ b ∈ target, targetWeight b := by rw [htarget]

end Ising2DLambda.NecSuf.FisherZero
