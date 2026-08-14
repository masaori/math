/-
具体版が必要十分版の特殊化として得られることの明示。

辺の型を有限型 ι、「反転前に破れている」を条件 P、「反転後に破れている」を条件 Q に
取り、各辺で破れが反転すること（`oddFlip_reverses_edge`）から Q が P の否定と
同値であることを渡すと、破れ数の補数の具体版の主張が必要十分版から出る。

住処: `Fin`、`Nat`、`Bool`、整数 ±1、有限集合のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.BrokenComplement
import Ising3DCut.NecSuf.NullModel.BrokenComplement

namespace Ising3DCut.NullModel

/-- `claim_broken_complement` の具体版を必要十分版から導いたもの。 -/
theorem brokenCount_oddFlip_from_necSuf {L : ℕ} (σ : Config L) :
    brokenCount (oddFlip σ) = Fintype.card (Edge L) - brokenCount σ := by
  have h : ∀ e : Edge L,
      (oddFlip σ (endpoint0 e) ≠ oddFlip σ (endpoint1 e)) ↔
        ¬ (σ (endpoint0 e) ≠ σ (endpoint1 e)) := by
    intro e
    rw [oddFlip_reverses_edge σ e, not_not]
  simpa [brokenCount, brokenSet] using
    NecSuf.NullModel.card_filter_of_iff_not
      (fun e : Edge L => σ (endpoint0 e) ≠ σ (endpoint1 e))
      (fun e : Edge L => oddFlip σ (endpoint0 e) ≠ oddFlip σ (endpoint1 e)) h

end Ising3DCut.NullModel
