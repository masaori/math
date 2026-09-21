/-
「一側閉包のトーラス射影の循環総回転数は正負 4 のいずれかである」の必要十分版。

前段の幾何から切り離すと、本質は、閉包の頂点単純性が一定の平行移動を通して
射影辺列の平面持ち上げへ移り、その単純性を仮定とする離散 Whitney の結論を
適用できることだけである。点の型には加法可換群以外の構造を要求しない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 単射な点列の一定平行移動も単射であり、離散 Whitney の結論を受ける。 -/
theorem translated_injective_path_whitney_turning_necSuf
    {I G : Type*} [AddCommGroup G]
    (indices : Set I) (closure lift : I → G) (offset : G) (turning : ℤ)
    (hclosure : Set.InjOn closure indices)
    (htranslation : ∀ i ∈ indices, lift i = offset + closure i)
    (hwhitney : Set.InjOn lift indices → turning = 4 ∨ turning = -4) :
    turning = 4 ∨ turning = -4 := by
  have hlift : Set.InjOn lift indices := by
    intro i hi j hj hij
    apply hclosure hi hj
    apply add_left_cancel (a := offset)
    rw [← htranslation i hi, ← htranslation j hj]
    exact hij
  exact hwhitney hlift

end Ising2DLambda.NecSuf.KacWard
