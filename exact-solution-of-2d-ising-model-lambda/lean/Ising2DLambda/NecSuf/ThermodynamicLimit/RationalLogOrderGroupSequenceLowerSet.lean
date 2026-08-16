/-
「列が定める下組は下に閉じている」の必要十分版。

具体版が使うのは、関係 `le` が (1) 推移的であること、(2) 右から同じ元を足しても保たれること、
だけである。加法は `Add X` で足り（結合則・交換則・単位元・逆元は使わない）、`Zero X` は
`0 ≤ ε` を述べる名前としてだけ要る。順序の線形性・有理数倍・`Λ_ℚ` は使わない。
下組の定義は具体版と同じ形（∃ ε, 0 ≤ ε ∧ ε ≠ 0 ∧ ∃ N ≥ 1 ∀ L ≥ N, μ + ε ≤ l L）で置く。
-/
import Mathlib.Data.Set.Defs
import Mathlib.Data.Nat.Notation

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {X : Type*} [Add X] [Zero X]

/-- 関係 `le` と列 `l` が定める下組（具体版 `rationalLogOrderSequenceLowerSet` と同じ形）。 -/
def lowerSetOfSequence (le : X → X → Prop) (l : ℕ → X) : Set X :=
  { μ | ∃ ε : X, le 0 ε ∧ ε ≠ 0 ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ L : ℕ, N ≤ L → le (μ + ε) (l L) }

/-- `μ ∈ A` かつ `μ' ≤ μ` なら `μ' ∈ A`。証人 `ε, N` を引き継ぎ、加法単調性と推移律だけで示す。 -/
theorem mem_lowerSetOfSequence_of_le_necSuf (le : X → X → Prop)
    (htrans : ∀ {x y z : X}, le x y → le y z → le x z)
    (hadd : ∀ {x y : X} (z : X), le x y → le (x + z) (y + z))
    (l : ℕ → X) {μ μ' : X} (hμ : μ ∈ lowerSetOfSequence le l) (hle : le μ' μ) :
    μ' ∈ lowerSetOfSequence le l := by
  obtain ⟨ε, hε0, hεne, N, hN1, hN⟩ := hμ
  refine ⟨ε, hε0, hεne, N, hN1, ?_⟩
  intro L hL
  exact htrans (hadd ε hle) (hN L hL)

end Ising2DLambda.NecSuf.ThermodynamicLimit
