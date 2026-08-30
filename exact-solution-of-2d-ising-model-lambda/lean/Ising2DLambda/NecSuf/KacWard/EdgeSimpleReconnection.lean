/-
「台の辺が相異なる閉歩道の出辺交換は非後退接続を与える」の必要十分版。
歩道・添字集合・格子は使わず、向き付き辺を第 1 成分（台の辺）と第 2 成分（向き）の
整数の対として、向きが二値であることと、台の辺の一致から対の一致が従うこと
（台の辺の相異性の、この二項への制限）だけを仮定して、y が x の反転にならないことを示す。

- 仮定 `hd`（向きは 0 か 1）は、固定点 x = (x.1, 1 - x.2) を除くのに必要である。
  向きに 1 - d = d の解（例えば有理数 1/2）を許す環では反転が固定点を持ち得る。
- 仮定 `hcase`（台の辺の一致から対の一致）は、x と異なる位置の項が x と同じ台の辺を
  逆向きに持つ場合を除くのに必要である（台の辺の相異性の使い所はここだけ。
  前節の反例の辺列は三番目と六番目でこの仮定が破れる）。
-/
import Mathlib.Data.Int.Basic
import Mathlib.Order.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 向きが二値で、台の辺の一致が対の一致を与えるなら、y は x の反転でない。 -/
theorem reversal_avoidance_necSuf {U : Type} (x y : U × ℤ)
    (hd : x.2 = 0 ∨ x.2 = 1)
    (hcase : y.1 = x.1 → y = x) :
    y ≠ (x.1, 1 - x.2) := by
  intro h
  have h1 : y.1 = x.1 := by rw [h]
  have hyx : y = x := hcase h1
  have h2 : x.2 = 1 - x.2 := by
    have hsnd : y.2 = 1 - x.2 := congrArg Prod.snd h
    rw [hyx] at hsnd
    exact hsnd
  rcases hd with h0 | h1'
  · rw [h0] at h2
    omega
  · rw [h1'] at h2
    omega

end Ising2DLambda.NecSuf.KacWard
