/-
「対数順序群の順序は線形順序である」の必要十分版。

具体版が使うのは、写像 `f : X → Y` と `Y` の順序の反射律・推移律・反対称律・全順序性、
および `f` を元へ戻す左逆写像 `g`（反対称律でだけ使う）である。`X` が有限台写像であること、
`Y` が ℚ であること、`f` が有限積であることは仮定しない。手順は具体版と同じ
（各律を `Y` へ落とし、反対称律だけ `g` で戻す）。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FreeEntropy

variable {X Y : Type*} [LinearOrder Y]

/-- `f` で引き戻した関係。 -/
def pullbackLE (f : X → Y) (a b : X) : Prop := f a ≤ f b

/-- 反射律・推移律・全順序性は `Y` の順序だけから、反対称律は左逆写像 `g` を足して従う。
    `LinearOrder Y` のうち、決定可能性は判定にだけ使い、この定理では使わない。 -/
theorem pullback_linear_order_necSuf (f : X → Y) (g : Y → X) (hg : ∀ a, g (f a) = a) :
    (∀ a, pullbackLE f a a) ∧
    (∀ a b c, pullbackLE f a b → pullbackLE f b c → pullbackLE f a c) ∧
    (∀ a b, pullbackLE f a b → pullbackLE f b a → a = b) ∧
    (∀ a b, pullbackLE f a b ∨ pullbackLE f b a) := by
  refine ⟨fun a => le_refl _, fun a b c h1 h2 => le_trans h1 h2, ?_, fun a b => le_total _ _⟩
  intro a b h1 h2
  have hq : f a = f b := le_antisymm h1 h2
  calc
    a = g (f a) := (hg a).symm
    _ = g (f b) := by rw [hq]
    _ = b := hg b

end Ising2DLambda.NecSuf.FreeEntropy
