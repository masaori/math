/-
具体版が必要十分版の特殊化として得られることの明示。

具体版の T（`oddFlip`）は、必要十分版の `flipOn` に値の反転 `negSpin` と
述語 `parity`（座標和の偶奇）を代入したものに一致する（`oddFlip_eq_flipOn`）。
`negSpin` が対合であること（`negSpin_negSpin`）だけを渡せば、
具体版と同じ二つの主張（対合性と全単射性）が必要十分版から出る。
これは、この主張に本質的なのが「値の反転が対合であること」だけで、
値が ±1 の整数であることも、述語が座標和の偶奇であることも本質的でないことを示す。

住処: `Fin`、`Nat`、`Bool`、整数 ±1 のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.OddFlipInvolution
import Ising3DCut.NecSuf.NullModel.OddFlipInvolution

namespace Ising3DCut.NullModel

/-- 具体版の T は、必要十分版の `flipOn` の特殊化である。 -/
theorem oddFlip_eq_flipOn {L : ℕ} :
    (oddFlip (L := L)) = NecSuf.NullModel.flipOn negSpin parity := rfl

/-- `claim_odd_flip_involution` の前半（`T(Tσ) = σ`）を必要十分版から導いたもの。 -/
theorem oddFlip_oddFlip_from_necSuf {L : ℕ} (σ : Config L) :
    oddFlip (oddFlip σ) = σ := by
  rw [oddFlip_eq_flipOn]
  exact NecSuf.NullModel.flipOn_flipOn negSpin parity negSpin_negSpin σ

/-- `claim_odd_flip_involution` の後半（T は全単射）を必要十分版から導いたもの。 -/
theorem oddFlip_bijective_from_necSuf {L : ℕ} :
    Function.Bijective (oddFlip (L := L)) := by
  rw [oddFlip_eq_flipOn]
  exact NecSuf.NullModel.flipOn_bijective negSpin parity negSpin_negSpin

end Ising3DCut.NullModel
