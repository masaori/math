/-
具体版が必要十分版の特殊化として得られることの明示。

具体版の `oddFlip` は必要十分版の `flipOn` に `negSpin` と `parity` を代入したものに
一致する。辺の両端の偶奇が異なることと、±1 の符号反転が満たす同値だけを渡すと、
各辺の破れを反転する具体版の主張が必要十分版から出る。

住処: `Fin`、`Nat`、`Bool`、整数 ±1 のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.OddFlipReversesEdges
import Ising3DCut.NecSuf.NullModel.OddFlipReversesEdges
import Ising3DCut.NullModel.OddFlipInvolutionFromNecSuf

namespace Ising3DCut.NullModel

/-- `claim_odd_flip_reverses_edges` の具体版を必要十分版から導いたもの。 -/
theorem oddFlip_reverses_edge_from_necSuf {L : ℕ} (σ : Config L) (e : Edge L) :
    oddFlip σ (endpoint0 e) ≠ oddFlip σ (endpoint1 e) ↔
      σ (endpoint0 e) = σ (endpoint1 e) := by
  rw [oddFlip_eq_flipOn]
  exact NecSuf.NullModel.flipOn_reverses_edge negSpin parity negSpin_ne_iff_eq
    (edge_endpoints_parity_differ e) σ

end Ising3DCut.NullModel
