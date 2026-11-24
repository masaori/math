/-
# 添字の集合 {1,…,n} と Lean の `Fin n` の間の写像（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_index_set_from_one_to_n`、ラベル **`def_index_set_from_one_to_n`**）

人手は `n ∈ ℤ_{≥0}` について添字の集合を `{1,…,n} := {k ∈ ℤ_{≥1} | k ≤_ℤ n}` と定め、行列の成分・有限和・サイトの添字をこの集合の元で書く。
Lean の具体版は添字の型に `Fin n`（`v < n` を満たす `v ∈ ℕ` と、その証明の組）を使う。二つの集合は別の集合なので、
名前を付けた写像 `finIndexToZZ n : Fin n → ℤ`（`i ↦ ι_{ℕ→ℤ}(i.val) +_ℤ 1_ℤ`。`ι_{ℕ→ℤ}` は `inclusion_nn_to_zz` の具体版 `inclusionNNtoZZ`）を置き、
それが `Fin n` から `{k ∈ ℤ | 1_ℤ ≤ k ∧ k ≤ ι_{ℕ→ℤ}(n)}` への全単射であることを補題一本 `finIndexToZZ_bijective_onto_index_set` で示す。
人手の添字 `i ∈ {1,…,n}` と Lean の添字 `i' : Fin n` の行き来は、この写像（とその逆）を通す。Lean の `Fin n` の数字 `(k : Fin n)`（`k < n`）は
`Fin.ofNat` で `⟨k % n, _⟩` と定義され、`k % n = k` なので人手の添字 `k + 1` に当たる（`finIndexToZZ n ⟨k, _⟩ = ι(k) + 1` は定義どおり）。

人手の本文は集合を定めるだけで、写像も全単射の主張も持たない（人手は添字を初めから `{1,…,n}` の元として書くので、行き来が無い）。
写像と補題は Lean だけの段であり、人手の証明との対応は無い。定義と、定義の一致を述べる補題なので、必要十分版は置かない。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionInclusionOfNaturalNumbersIntoIntegers

namespace Ising2D

/-- **`def_index_set_from_one_to_n`**: Lean の添字 `i : Fin n` を、人手の添字の集合 `{1,…,n} ⊂ ℤ` の元 `ι_{ℕ→ℤ}(i.val) + 1_ℤ` へ送る写像。 -/
def finIndexToZZ (n : ℕ) (i : Fin n) : ℤ :=
  inclusionNNtoZZ i.val + 1

/-- **`def_index_set_from_one_to_n`**: `finIndexToZZ n` は `Fin n` から人手の添字の集合 `{k ∈ ℤ | 1_ℤ ≤ k ∧ k ≤ ι_{ℕ→ℤ}(n)}` への全単射である。
一つ目は単射、二つ目は値がその集合に入ること、三つ目は全射である（Lean だけの段の補題）。
`ι_{ℕ→ℤ}` を Lean の `Nat.cast` へ移し（`inclusionNNtoZZ_eq_natCast`）、ℤ と ℕ の一次の不等式として示す。
全射の段で `k − 1_ℤ` を ℕ の元の像として取り直すところは、`inclusionNNtoZZ_exists_preimage_of_nonneg` を通す。 -/
theorem finIndexToZZ_bijective_onto_index_set (n : ℕ) :
    (∀ i j : Fin n, finIndexToZZ n i = finIndexToZZ n j → i = j) ∧
      (∀ i : Fin n, 1 ≤ finIndexToZZ n i ∧ finIndexToZZ n i ≤ inclusionNNtoZZ n) ∧
      (∀ k : ℤ, 1 ≤ k → k ≤ inclusionNNtoZZ n → ∃ i : Fin n, finIndexToZZ n i = k) := by
  refine ⟨?_, ?_, ?_⟩
  · -- 単射: `ι(i) + 1 = ι(j) + 1` から `i.val = j.val`、`Fin` の元は値で決まる
    intro i j h
    simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast] at h
    exact Fin.ext (by omega)
  · -- 値の範囲: `0 ≤ i.val < n` から `1 ≤ ι(i.val) + 1 ≤ ι(n)`
    intro i
    simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
    have hi := i.isLt
    omega
  · -- 全射: `1 ≤ k ≤ ι(n)` なら `k − 1 = ι(m)` の `m` は `m < n` を満たし、`⟨m, _⟩` が `k` へ写る
    intro k hk1 hkn
    obtain ⟨m, hm⟩ := inclusionNNtoZZ_exists_preimage_of_nonneg (k - 1) (by omega)
    rw [inclusionNNtoZZ_eq_natCast] at hm hkn
    refine ⟨⟨m, by omega⟩, ?_⟩
    simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
    omega

end Ising2D
