/-
# 多重添字の集合 `𝓘_M` の上の有限和と Lean の `Conf M` の上の和（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_000_definition_finite_sum_of_complex_numbers_over_multi_indices`、
ラベル **`def_finite_sum_of_complex_numbers_over_multi_indices`**、
`linear_space_general_000_definition_finite_sum_of_real_numbers_over_multi_indices`、
ラベル **`def_finite_sum_of_real_numbers_over_multi_indices`**）

人手は `ν : 𝓘_M → {1,…,2^M}` の逆写像 `ν^{-1}`（`def_inverse_of_kronecker_numbering`）を使い、
写像 `a : 𝓘_M → ℂ`（または `ℝ`）について `Σ_{I∈𝓘_M} a(I) := Σ_{k=1}^{2^M} a(ν^{-1}(k))` と定める。
右辺は添字の集合 `{1,…,2^M}` の上の有限和（`def_finite_sum_of_complex_numbers`・`def_finite_sum_of_real_numbers`）である。

Lean の具体版は `𝓘_M`（Lean の `Conf M`）の上の和を mathlib の `Finset.sum`（有限集合 `Finset.univ : Finset (Conf M)` の上の和）で書く。
定義が違うので、Lean の `Conf M` の上の和が本文の定義の右辺に等しいことを、足す集合ごとに補題一本で示す。
人手の添字 `k ∈ {1,…,n}` は Lean の `k : Fin n` を名前を付けた写像 `finIndexToZZ n` で送った値であり、
`ν^{-1}` は Lean の `σ : Fin n → Conf M` で、`ν(σ(k)) = finIndexToZZ n k` によって定まる
（`exists_inverse_of_kronecker_numbering`。`DefinitionKroneckerNumbering.lean`）。

人手の行列 `Mat(2^M, ℂ)`・数ベクトル `ℂ^{2^M}` の成分の番号 `p ∈ {1,…,2^M}` の上の和 `Σ_{p=1}^{2^M}` は、`def_kronecker` が
`I ∈ 𝓘_M` を番号 `ν(I)` と同一視して成分を並べるので、`Σ_{p=1}^{2^M} b_p = Σ_{k=1}^{2^M} b_{ν(ν^{-1}(k))} = Σ_{I∈𝓘_M} b_{ν(I)}` である。
Lean の行列・数ベクトルは添字型 `Conf M` の上の関数なので、その和も初めから `Conf M` の上の和として書かれている。

人手の本文は和を定めるだけで、Lean の和との一致の主張を持たない。補題は Lean だけの段であり、
定義の一致を述べる補題なので、必要十分版は置かない。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionKroneckerNumbering

namespace Ising2D

/-- **`def_finite_sum_of_complex_numbers_over_multi_indices`**: Lean の `Conf M` の上の複素数の `Finset.sum` は、
本文の `Σ_{I∈𝓘_M} a(I) := Σ_{k=1}^{2^M} a(ν^{-1}(k))` の右辺に等しい（Lean だけの段の補題。上の説明を見よ）。 -/
theorem finset_sum_conf_complex_eq_finite_sum_over_multi_indices (M : ℕ) :
    ∀ (n : ℕ), (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) →
      ∀ (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
        ∀ (a : Conf M → ℂ), ∑ I, a I = ∑ k, a (σ k) := by
  intro n hord σ hσ a
  -- `σ` は全単射: 単射は `finIndexToZZ n` の単射から、全射は `ν` の単射（`kronecker_numbering_injective`）から
  have hbij : Function.Bijective σ := by
    refine ⟨fun k k' h => (finIndexToZZ_bijective_onto_index_set n).1 k k' (by rw [← hσ, ← hσ, h]),
      fun I => ?_⟩
    obtain ⟨k, hk⟩ := hord I
    exact ⟨k, kronecker_numbering_injective _ _ (by rw [hσ, hk])⟩
  exact (Fintype.sum_bijective σ hbij (fun k => a (σ k)) a (fun _ => rfl)).symm

/-- **`def_finite_sum_of_real_numbers_over_multi_indices`**: Lean の `Conf M` の上の実数の `Finset.sum` は、
本文の `Σ_{I∈𝓘_M} a(I) := Σ_{k=1}^{2^M} a(ν^{-1}(k))` の右辺に等しい（Lean だけの段の補題。上の説明を見よ）。 -/
theorem finset_sum_conf_real_eq_finite_sum_over_multi_indices (M : ℕ) :
    ∀ (n : ℕ), (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) →
      ∀ (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
        ∀ (a : Conf M → ℝ), ∑ I, a I = ∑ k, a (σ k) := by
  intro n hord σ hσ a
  -- `σ` は全単射: 単射は `finIndexToZZ n` の単射から、全射は `ν` の単射（`kronecker_numbering_injective`）から
  have hbij : Function.Bijective σ := by
    refine ⟨fun k k' h => (finIndexToZZ_bijective_onto_index_set n).1 k k' (by rw [← hσ, ← hσ, h]),
      fun I => ?_⟩
    obtain ⟨k, hk⟩ := hord I
    exact ⟨k, kronecker_numbering_injective _ _ (by rw [hσ, hk])⟩
  exact (Fintype.sum_bijective σ hbij (fun k => a (σ k)) a (fun _ => rfl)).symm

end Ising2D
