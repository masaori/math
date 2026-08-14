/-
「奇数側だけ反転する写像は各辺の破れを反転する」の必要十分版。

具体版の証明で使うのは、二端点で述語の値が異なることと、値の置換 `f` が
`f x ≠ y ↔ x = y` を満たすことだけである。点が格子点であること、述語が座標和の
偶奇であること、値が整数 ±1 であることは使わない。

  使っている性質                         なぜ削れないか
  `p u ≠ p v`                             同じ側なら両端をともに反転するか、ともに保つため。
  `f x ≠ y ↔ x = y`                       一端だけを反転した後の不一致を、反転前の一致へ戻すため。

証明手順は具体版と同じ（二端点の述語の値による場合分け）。

住処: 任意の型、有限集合 `Bool`、等号と不等号のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NecSuf.NullModel.OddFlipInvolution

namespace Ising3DCut.NecSuf.NullModel

variable {V S : Type*} (f : S → S) (p : V → Bool)

/-- 片側だけを `f` で置き換えると、変換後の不一致は変換前の一致と同値になる。 -/
theorem flipOn_reverses_edge
    (hf : ∀ x y, f x ≠ y ↔ x = y) {u v : V} (hp : p u ≠ p v) (σ : V → S) :
    flipOn f p σ u ≠ flipOn f p σ v ↔ σ u = σ v := by
  cases hu : p u <;> cases hv : p v
  · exact False.elim (hp (hu.trans hv.symm))
  · simpa [flipOn, hu, hv, ne_comm, eq_comm] using hf (σ v) (σ u)
  · simpa [flipOn, hu, hv] using hf (σ u) (σ v)
  · exact False.elim (hp (hu.trans hv.symm))

end Ising3DCut.NecSuf.NullModel
