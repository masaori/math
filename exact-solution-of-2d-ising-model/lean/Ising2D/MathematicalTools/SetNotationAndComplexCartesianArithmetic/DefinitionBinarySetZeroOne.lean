/-
# 二値の集合 {0,1} と Lean の `Fin 2` の間の写像（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_binary_set_zero_one`、ラベル **`def_binary_set_zero_one`**）

人手は二値の集合を `{0,1} := {k ∈ ℤ | k = 0_ℤ ∨ k = 1_ℤ}` と定め、二値の語 `{0,1}^r` の成分・`R_μ^{(e)}` の上付きの `e`・
`h : {0,1} → ℝ` の引数などをこの集合の元で書く。Lean の具体版はこれらに `Fin 2` を使う。`Fin 2` は添字の集合 `{1,2}` を表すのにも使う
（`def_index_set_from_one_to_n` の写像 `finIndexToZZ 2` の像。行列の成分の添字・`𝓘_M = {1,2}^M` の成分）ので、
二値の集合として読む箇所では、名前を付けた別の写像 `finBinaryToZZ : Fin 2 → ℤ`（`e ↦ ι_{ℕ→ℤ}(e.val)`。`ι_{ℕ→ℤ}` は
`inclusion_nn_to_zz` の具体版 `inclusionNNtoZZ`）を通す。二つの写像は同じ `e : Fin 2` を 1 だけずれた整数へ送る。
`finBinaryToZZ` が `Fin 2` から `{k ∈ ℤ | k = 0_ℤ ∨ k = 1_ℤ}` への全単射であることを補題一本 `finBinaryToZZ_bijective_onto_binary_set` で示す。
Lean の `Fin 2` の数字 `(0 : Fin 2)`・`(1 : Fin 2)` が人手の `0`・`1` へ写ることを `finBinaryToZZ_zero`・`finBinaryToZZ_one` で示す。

人手の本文は集合を定めるだけで、写像も全単射の主張も持たない（人手は二値の値を初めから `{0,1}` の元として書くので、行き来が無い）。
写像と補題は Lean だけの段であり、人手の証明との対応は無い。定義と、定義の一致を述べる補題なので、必要十分版は置かない。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionInclusionOfNaturalNumbersIntoIntegers

namespace Ising2D

/-- **`def_binary_set_zero_one`**: Lean の `e : Fin 2` を、人手の二値の集合 `{0,1} ⊂ ℤ` の元 `ι_{ℕ→ℤ}(e.val)` へ送る写像。 -/
def finBinaryToZZ (e : Fin 2) : ℤ :=
  inclusionNNtoZZ e.val

/-- **`def_binary_set_zero_one`**: Lean の `(0 : Fin 2)` は人手の `0_ℤ ∈ {0,1}` へ写る（Lean だけの段の補題）。
`(0 : Fin 2)` の値は `0 ∈ ℕ` で、`ι_{ℕ→ℤ}(0_ℕ) := 0_ℤ` である。 -/
theorem finBinaryToZZ_zero : finBinaryToZZ 0 = 0 :=
  rfl

/-- **`def_binary_set_zero_one`**: Lean の `(1 : Fin 2)` は人手の `1_ℤ ∈ {0,1}` へ写る（Lean だけの段の補題）。
`(1 : Fin 2)` の値は `1 ∈ ℕ` で、`ι_{ℕ→ℤ}(0_ℕ + 1_ℕ) := ι_{ℕ→ℤ}(0_ℕ) + 1_ℤ = 0_ℤ + 1_ℤ` である。 -/
theorem finBinaryToZZ_one : finBinaryToZZ 1 = 1 := by
  simp only [finBinaryToZZ, inclusionNNtoZZ_eq_natCast, Fin.val_one, Nat.cast_one]

/-- **`def_binary_set_zero_one`**: `finBinaryToZZ` は `Fin 2` から人手の二値の集合 `{k ∈ ℤ | k = 0_ℤ ∨ k = 1_ℤ}` への全単射である。
一つ目は単射、二つ目は値がその集合に入ること、三つ目は全射である（Lean だけの段の補題）。
`ι_{ℕ→ℤ}` を Lean の `Nat.cast` へ移し（`inclusionNNtoZZ_eq_natCast`）、`e.val < 2` の ℕ と ℤ の一次の式として示す。
全射の段は、`0_ℤ` には `(0 : Fin 2)`、`1_ℤ` には `(1 : Fin 2)` を取る（`finBinaryToZZ_zero`・`finBinaryToZZ_one`）。 -/
theorem finBinaryToZZ_bijective_onto_binary_set :
    (∀ e e' : Fin 2, finBinaryToZZ e = finBinaryToZZ e' → e = e') ∧
      (∀ e : Fin 2, finBinaryToZZ e = 0 ∨ finBinaryToZZ e = 1) ∧
      (∀ k : ℤ, k = 0 ∨ k = 1 → ∃ e : Fin 2, finBinaryToZZ e = k) := by
  refine ⟨?_, ?_, ?_⟩
  · -- 単射: `ι(e.val) = ι(e'.val)` から `e.val = e'.val`、`Fin` の元は値で決まる
    intro e e' h
    simp only [finBinaryToZZ, inclusionNNtoZZ_eq_natCast] at h
    exact Fin.ext (by omega)
  · -- 値の範囲: `e.val < 2` から `ι(e.val) = 0_ℤ` か `ι(e.val) = 1_ℤ`
    intro e
    simp only [finBinaryToZZ, inclusionNNtoZZ_eq_natCast]
    have he := e.isLt
    omega
  · -- 全射: `0_ℤ` は `(0 : Fin 2)` の像、`1_ℤ` は `(1 : Fin 2)` の像
    intro k hk
    rcases hk with rfl | rfl
    · exact ⟨0, finBinaryToZZ_zero⟩
    · exact ⟨1, finBinaryToZZ_one⟩

end Ising2D
