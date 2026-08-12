/-
章「Fisher 零点」の「全スピン反転は各辺の破れを保つ」の具体版。
人手証明と同じく、両端のスピンへ整数の加法逆元を取り、その写像の単射性を使う。
住処: Z。R / C は現れない。
-/
import Ising2DLambda.PartitionPolynomial.Basic

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

/-- 一つのスピンの符号反転。 -/
def spinReversal (s : SpinValue) : SpinValue :=
  ⟨-(s.1), by rcases s.2 with h | h <;> simp [h]⟩

/-- 全スピン反転 `ν_L`（`def_global_spin_reversal`）。 -/
def globalSpinReversal (L : ℕ) (σ : Config L) : Config L := fun v => spinReversal (σ v)

theorem spinReversal_injective : Function.Injective spinReversal := by
  intro a b hab
  apply Subtype.ext
  have hvalues := congrArg Subtype.val hab
  simpa [spinReversal] using neg_injective hvalues

/-- 全スピン反転は各辺の破れを保つ。 -/
theorem globalSpinReversal_brokenEdge_iff (L : ℕ) (σ : Config L) (e : Edge L) :
    globalSpinReversal L σ (boundary0 L e) ≠ globalSpinReversal L σ (boundary1 L e) ↔
      σ (boundary0 L e) ≠ σ (boundary1 L e) := by
  constructor
  · intro hreversed horiginal
    apply hreversed
    apply Subtype.ext
    simp [globalSpinReversal, horiginal]
  · intro horiginal hreversed
    apply horiginal
    apply Subtype.ext
    have hvalues := congrArg Subtype.val hreversed
    simpa [globalSpinReversal, spinReversal] using neg_injective hvalues

end Ising2DLambda.FisherZero
