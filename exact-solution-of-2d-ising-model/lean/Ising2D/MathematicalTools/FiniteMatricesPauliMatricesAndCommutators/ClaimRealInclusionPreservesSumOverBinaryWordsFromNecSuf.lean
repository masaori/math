/-
# `{0,1}^r` の上の実数の和の包含は、包含の和に等しい（具体版を必要十分版から導く）

具体版 `ClaimRealInclusionPreservesSumOverBinaryWords.lean`（人手 `real_inclusion_preserves_sum_over_binary_words`）を、
必要十分版 `Ising2D/NecSuf/BinaryWordSum.lean` の `binWordSum_map` の `α := ℝ`、`β := ℂ`、`f := (↑· : ℝ → ℂ)` の特殊化として得る。
`hf` には具体版 `real_inclusion_add`（人手 `real_inclusion_preserves_sum`）を右辺から左辺へ渡す。
効いているのは包含が二項の和を保つことだけで、包含の単射性・積との両立・零元は効いていない。

`binWordSum_ofReal` は、`TensorPow M` の鎖が `ℂ` と `ℝ` の和をどちらも `NecSuf.binWordSum` で持つ箇所
（`CheckFermiSetup.trace_Vprime`）で使う系で、具体版 `binaryWordComplexSum_ofReal` から運んで得る。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimRealInclusionPreservesSumOverBinaryWords
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWordsFromNecSuf

namespace Ising2D

/-- 具体版 `binaryWordComplexSum_ofReal` を、必要十分版 `NecSuf.binWordSum_map`（`f := (↑· : ℝ → ℂ)`、
`hf := real_inclusion_add` を右辺から左辺へ）の特殊化として得る。 -/
theorem binaryWordComplexSum_ofReal_of_necSuf (r : ℕ) (x : (Fin (r + 1) → Fin 2) → ℝ) :
    binaryWordComplexSum r (fun ε => (x ε : ℂ)) = ((binaryWordRealSum r x : ℝ) : ℂ) := by
  rw [binaryWordComplexSum_eq_binWordSum, binaryWordRealSum_eq_binWordSum]
  exact (NecSuf.binWordSum_map (fun a : ℝ => (a : ℂ)) (fun a b => (real_inclusion_add a b).symm) r x).symm

/-- `real_inclusion_preserves_sum_over_binary_words` の、`NecSuf.binWordSum`（`α := ℂ` と `α := ℝ`）での形。
人手と 1 対 1 の具体版 `binaryWordComplexSum_ofReal` を、二つの和の一致で運んで得る（通しの証明が具体版を通るようにするため）。 -/
theorem binWordSum_ofReal (r : ℕ) (x : (Fin (r + 1) → Fin 2) → ℝ) :
    NecSuf.binWordSum r (fun ε => (x ε : ℂ)) = ((NecSuf.binWordSum r x : ℝ) : ℂ) := by
  rw [← binaryWordComplexSum_eq_binWordSum, ← binaryWordRealSum_eq_binWordSum]
  exact binaryWordComplexSum_ofReal r x

end Ising2D
