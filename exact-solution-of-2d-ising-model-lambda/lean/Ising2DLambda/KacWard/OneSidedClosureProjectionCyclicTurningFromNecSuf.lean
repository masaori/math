/-
具体版が必要十分版の特殊化として得られることの導出。

一側閉包の頂点単純性、射影辺列の平面持ち上げとの平行移動関係、
離散 Whitney の結論を具体版へ渡す。
-/
import Ising2DLambda.KacWard.OneSidedClosureProjectionCyclicTurning

namespace Ising2DLambda.KacWard

/-- `claim_one_sided_closure_projection_cyclic_turning` を必要十分版から導く。 -/
theorem oneSidedClosureProjection_cyclicTurning_from_necSuf
    (closure lift : ℕ → ℤ × ℤ) (length : ℕ) (offset : ℤ × ℤ) (turning : ℤ)
    (hclosure : ∀ i < length, ∀ j < length, closure i = closure j → i = j)
    (htranslation : ∀ i < length, lift i = offset + closure i)
    (hwhitney :
      (∀ i < length, ∀ j < length, lift i = lift j → i = j) →
        turning = 4 ∨ turning = -4) :
    turning = 4 ∨ turning = -4 :=
  oneSidedClosureProjection_cyclicTurning
    closure lift length offset turning hclosure htranslation hwhitney

end Ising2DLambda.KacWard
