/-
# 1 行ぶんのスピン配置の全体 `𝔐` の上の有限和と Lean の `SpinConf M` の上の和（具体版）

正本: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
（`partition_function_2d_ising_definition_inverse_of_row_configuration_numbering`、ラベル **`def_inverse_of_row_configuration_numbering`**、
`partition_function_2d_ising_definition_finite_sum_of_complex_numbers_over_row_configurations`、
ラベル **`def_finite_sum_of_complex_numbers_over_row_configurations`**、
`partition_function_2d_ising_definition_finite_sum_of_real_numbers_over_row_configurations`、
ラベル **`def_finite_sum_of_real_numbers_over_row_configurations`**）

人手は `ord : 𝔐 → {1,…,2^{M_col}}` が全単射（`row_configuration_numbering_bijective`）であることから逆写像 `ord^{-1}` を書き、
写像 `a : 𝔐 → ℂ`（または `ℝ`）について `Σ_{s∈𝔐} a(s) := Σ_{k=1}^{2^{M_col}} a(ord^{-1}(k))` と定める。
右辺は添字の集合 `{1,…,2^{M_col}}` の上の有限和（`def_finite_sum_of_complex_numbers`・`def_finite_sum_of_real_numbers`）である。

Lean の具体版は `𝔐` の上の和を mathlib の `Finset.sum`（有限集合 `Finset.univ : Finset (SpinConf M)` の上の和）で書く。
定義が違うので、Lean の `SpinConf M` の上の和が本文の定義の右辺に等しいことを、足す集合ごとに補題一本で示す。
人手の添字 `k ∈ {1,…,n}` は Lean の `k : Fin n` を名前を付けた写像 `finIndexToZZ n` で送った値であり、
`ord^{-1}` は Lean の `σ : Fin n → SpinConf M` で、`ord(σ(k)) = finIndexToZZ n k` によって定まる（`ord` は単射なので一つに決まる）。
`ord^{-1}` が在ること（`def_inverse_of_row_configuration_numbering`）は、`ord` の値が全て `{1,…,n}` に入り、
`{1,…,n}` の全ての元が `ord` の値であるような `n`（すなわち `n = 2^{M_col}`）と、その `σ` が在ることとして述べる。
二つの和の補題は、そのような `n` と `σ` について `Σ_{s∈𝔐} a(s)`（Lean の `∑ s, a s`）が `Σ_{k=1}^{n} a(σ(k))` に等しいことを言う。
`n` を `2^{M_col}` と書かずに条件で定めるのは、主張の型に ℕ・ℤ の冪の記号を持ち込まないためである。

人手の本文は和を定めるだけで、Lean の和との一致の主張を持たない。補題は Lean だけの段であり、
定義の一致を述べる補題なので、必要十分版は置かない。
-/
import Mathlib.Algebra.BigOperators.Fin
import Ising2D.Basic
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimRowConfigurationNumberingBijective
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIndexSetFromOneToN

namespace Ising2D

/-- **`def_inverse_of_row_configuration_numbering`**: 人手の `ord^{-1} : {1,…,2^{M_col}} → 𝔐` は在る。
Lean の添字 `k : Fin n` の像 `finIndexToZZ n k` を人手の添字とし、`n` を `2^{M_col}` と書く代わりに
「`ord` の値は全て `{1,…,n}` の元の像であり、`{1,…,n}` の全ての元の像は `ord` の値である」という条件で定める
（主張の型に冪の記号を出さないため。`row_configuration_numbering_bijective` から `n = 2^{M_col}` に決まる）。
`σ : Fin n → SpinConf M` が人手の `ord^{-1}` で、`ord(σ(k)) = finIndexToZZ n k` を満たす（`ord` は単射なので一つに決まる）。 -/
theorem exists_inverse_of_row_configuration_numbering (M : ℕ) :
    ∃ (n : ℕ) (σ : Fin n → SpinConf M),
      (∀ μ : SpinConf M, ∃ k : Fin n, rowConfigOrd μ = finIndexToZZ n k) ∧
        ∀ k, rowConfigOrd (σ k) = finIndexToZZ n k := by
  have hn : inclusionNNtoZZ (2 ^ M) = (2 : ℤ) ^ M := by
    rw [inclusionNNtoZZ_eq_natCast]; push_cast; rfl
  -- `ord` の値は全て `{1,…,2^{M_col}}` に入る（`row_configuration_numbering_bijective` の値域）
  have hord : ∀ μ : SpinConf M, ∃ k : Fin (2 ^ M), rowConfigOrd μ = finIndexToZZ (2 ^ M) k := by
    intro μ
    have h := (row_configuration_numbering_bijective (M := M)).mapsTo (Set.mem_univ μ)
    obtain ⟨k, hk⟩ := (finIndexToZZ_bijective_onto_index_set (2 ^ M)).2.2 _ h.1 (hn ▸ h.2)
    exact ⟨k, hk.symm⟩
  -- `{1,…,2^{M_col}}` の各元は `ord` の値である（`row_configuration_numbering_bijective` の全射）
  have hinv : ∀ k : Fin (2 ^ M), ∃ μ : SpinConf M, rowConfigOrd μ = finIndexToZZ (2 ^ M) k := by
    intro k
    have h := (finIndexToZZ_bijective_onto_index_set (2 ^ M)).2.1 k
    rw [hn] at h
    obtain ⟨μ, -, hμ⟩ := (row_configuration_numbering_bijective (M := M)).surjOn ⟨h.1, h.2⟩
    exact ⟨μ, hμ⟩
  choose σ hσ using hinv
  exact ⟨2 ^ M, σ, hord, hσ⟩

/-- **`def_finite_sum_of_complex_numbers_over_row_configurations`**: Lean の `SpinConf M` の上の複素数の `Finset.sum` は、
本文の `Σ_{s∈𝔐} a(s) := Σ_{k=1}^{2^{M_col}} a(ord^{-1}(k))` の右辺に等しい（Lean だけの段の補題。上の説明を見よ）。 -/
theorem finset_sum_spinConf_complex_eq_finite_sum_over_row_configurations (M : ℕ) :
    ∀ (n : ℕ), (∀ μ : SpinConf M, ∃ k : Fin n, rowConfigOrd μ = finIndexToZZ n k) →
      ∀ (σ : Fin n → SpinConf M), (∀ k, rowConfigOrd (σ k) = finIndexToZZ n k) →
        ∀ (a : SpinConf M → ℂ), ∑ s, a s = ∑ k, a (σ k) := by
  intro n hord σ hσ a
  -- `σ` は全単射: 単射は `finIndexToZZ n` の単射から、全射は `ord` の単射（`row_configuration_numbering_bijective`）から
  have hbij : Function.Bijective σ := by
    refine ⟨fun k k' h => (finIndexToZZ_bijective_onto_index_set n).1 k k' (by rw [← hσ, ← hσ, h]),
      fun μ => ?_⟩
    obtain ⟨k, hk⟩ := hord μ
    exact ⟨k, (row_configuration_numbering_bijective (M := M)).injOn (Set.mem_univ _) (Set.mem_univ _)
      (by rw [hσ, hk])⟩
  exact (Fintype.sum_bijective σ hbij (fun k => a (σ k)) a (fun _ => rfl)).symm

/-- **`def_finite_sum_of_real_numbers_over_row_configurations`**: Lean の `SpinConf M` の上の実数の `Finset.sum` は、
本文の `Σ_{s∈𝔐} a(s) := Σ_{k=1}^{2^{M_col}} a(ord^{-1}(k))` の右辺に等しい（Lean だけの段の補題。上の説明を見よ）。 -/
theorem finset_sum_spinConf_real_eq_finite_sum_over_row_configurations (M : ℕ) :
    ∀ (n : ℕ), (∀ μ : SpinConf M, ∃ k : Fin n, rowConfigOrd μ = finIndexToZZ n k) →
      ∀ (σ : Fin n → SpinConf M), (∀ k, rowConfigOrd (σ k) = finIndexToZZ n k) →
        ∀ (a : SpinConf M → ℝ), ∑ s, a s = ∑ k, a (σ k) := by
  intro n hord σ hσ a
  -- `σ` は全単射: 単射は `finIndexToZZ n` の単射から、全射は `ord` の単射（`row_configuration_numbering_bijective`）から
  have hbij : Function.Bijective σ := by
    refine ⟨fun k k' h => (finIndexToZZ_bijective_onto_index_set n).1 k k' (by rw [← hσ, ← hσ, h]),
      fun μ => ?_⟩
    obtain ⟨k, hk⟩ := hord μ
    exact ⟨k, (row_configuration_numbering_bijective (M := M)).injOn (Set.mem_univ _) (Set.mem_univ _)
      (by rw [hσ, hk])⟩
  exact (Fintype.sum_bijective σ hbij (fun k => a (σ k)) a (fun _ => rfl)).symm

end Ising2D
