/-
「接続階段は元の持ち上げと始点でのみ、移動後の持ち上げと終点でのみ交わる」
の必要十分版。

格子から切り離すと、必要なのは単射な点列、上端以下にある元の点族、一定量だけ
座標を上げた移動後の点族、正の最初の当たり歩数だけである。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 最初の当たりで打ち切った単射な点列は、二つの点族と両端でだけ交わる。 -/
theorem first_hit_prefix_meets_families_only_at_ends_necSuf
    {I X : Type*} (path : ℕ → X) (original translated : I → X)
    (coordinate : X → ℤ) (hit : ℕ) (baseIndex : I) (lower upper shift : ℤ)
    (hinjective : Function.Injective path)
    (hbase : path 0 = original baseIndex)
    (hbaseCoordinate : coordinate (path 0) = upper)
    (hlower : ∀ i : I, lower ≤ coordinate (original i))
    (htranslatedCoordinate : ∀ i : I,
      coordinate (translated i) = coordinate (original i) + shift)
    (hgap : shift > upper - lower)
    (_hhitPositive : 1 ≤ hit)
    (horiginal : ∀ s : ℕ, 1 ≤ s → s ≤ hit → ∀ i : I, path s ≠ original i)
    (hhit : ∃ i : I, path hit = translated i)
    (hminimal : ∀ s : ℕ, 1 ≤ s → s < hit → ∀ i : I, path s ≠ translated i) :
    (∀ s s' : ℕ, s ≤ hit → s' ≤ hit → path s = path s' → s = s') ∧
      path 0 = original baseIndex ∧
      (∀ s : ℕ, 1 ≤ s → s ≤ hit → ∀ i : I, path s ≠ original i) ∧
      (∃ i : I, path hit = translated i) ∧
      (∀ s : ℕ, s < hit → ∀ i : I, path s ≠ translated i) := by
  constructor
  · intro s s' _hs _hs' heq
    exact hinjective heq
  constructor
  · exact hbase
  constructor
  · exact horiginal
  constructor
  · exact hhit
  · intro s hs i
    by_cases hs0 : s = 0
    · subst s
      intro heq
      have htranslated := htranslatedCoordinate i
      have horiginalLower := hlower i
      rw [← heq, hbaseCoordinate] at htranslated
      omega
    · exact hminimal s (Nat.one_le_iff_ne_zero.mpr hs0) hs i

end Ising2DLambda.NecSuf.KacWard
