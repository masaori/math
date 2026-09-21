/-
章「Onsager 閉形式への接続」の
「一側閉包のトーラス射影の循環総回転数は正負 4 のいずれかである」
（`claim_one_sided_closure_projection_cyclic_turning`）の具体版。

人手証明と同じく、一側閉包の頂点単純性と、射影辺列の平面持ち上げが閉包の
一定平行移動であることを合成し、持ち上げ点の相異性を離散 Whitney の結論へ渡す。
住処は ℕ と ℤ × ℤ だけである。
-/
import Ising2DLambda.NecSuf.KacWard.OneSidedClosureProjectionCyclicTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `claim_one_sided_closure_projection_cyclic_turning` の具体版。 -/
theorem oneSidedClosureProjection_cyclicTurning
    (closure lift : ℕ → ℤ × ℤ) (length : ℕ) (offset : ℤ × ℤ) (turning : ℤ)
    (hclosure : ∀ i < length, ∀ j < length, closure i = closure j → i = j)
    (htranslation : ∀ i < length, lift i = offset + closure i)
    (hwhitney :
      (∀ i < length, ∀ j < length, lift i = lift j → i = j) →
        turning = 4 ∨ turning = -4) :
    turning = 4 ∨ turning = -4 := by
  apply translated_injective_path_whitney_turning_necSuf
    {i : ℕ | i < length} closure lift offset turning
  · intro i hi j hj hij
    exact hclosure i hi j hj hij
  · intro i hi
    exact htranslation i hi
  · intro hlift
    exact hwhitney (fun i hi j hj hij => hlift hi hj hij)

end Ising2DLambda.KacWard
