/-
# 添字の集合 {1,…,m} の上の有限和と Lean の `Fin m` の上の和（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_008c_definition_finite_sum_of_complex_numbers`、ラベル **`def_finite_sum_of_complex_numbers`**、
`calc_formulae_definition_finite_sum_of_real_numbers`、ラベル **`def_finite_sum_of_real_numbers`**）

人手は `m ∈ ℤ_{≥1}` と添字の集合 `{1,…,m}` の上の族 `z_1,…,z_m` について、有限和を `m` についての帰納法で
`Σ_{j=1}^{1} z_j := z_1`、`Σ_{j=1}^{m+1} z_j := (Σ_{j=1}^{m} z_j) + z_{m+1}` と定める（左から順に足す）。
複素数と実数の二つの定義は、足す集合が違うだけで同じ式である。
行列の有限和（`def_finite_sum_of_matrices`。同じ式）の補題は、式に行列の和が現れるので、行列とその演算を本文の定義と対応させた後に置く。

Lean の具体版は和を mathlib の `Finset.sum`（有限集合 `Finset.univ : Finset (Fin m)` の上の和）で書く。
`Finset.sum` は多重集合の上の畳み込みとして定義され、本文の帰納法による定義とは定義が違うので、
人手の添字と Lean の添字を名前を付けた写像 `finIndexToZZ`（`def_index_set_from_one_to_n` の具体版）で対応させ、
`Fin m` の上の `Finset.sum` が本文の帰納の二つの式を満たすことを、足す集合ごとに補題一本で示す。
二つの式は本文の定義を一意に定めるので、`m ≥ 1` の和は本文の和と一致する。

- 一つ目の式: `Fin 1` の元 `l` の像が人手の添字 `1` なら、`Σ_{j : Fin 1} z_j = z_l`。
- 二つ目の式: `1 ≤ m` とする。`Fin (m+1)` の上の族 `z` と `Fin m` の上の族 `w` が、像の添字が等しい元で同じ値をとる
  （`w` は人手の `z_1,…,z_m` を `Fin m` の上で書いたもの）とき、像が人手の添字 `ι_{ℕ→ℤ}(m+1)` である元 `l` について
  `Σ_{j : Fin (m+1)} z_j = (Σ_{i : Fin m} w_i) + z_l`。

`m = 0`（`Fin 0` の上の和。Lean では `0`）は本文の定義の外である。本文が空の和を使う箇所は本文の側で扱う。

人手の本文は和を定めるだけで、Lean の和との一致の主張を持たない。補題は Lean だけの段であり、
定義の一致を述べる補題なので、必要十分版は置かない。
-/
import Mathlib.Algebra.BigOperators.Fin
import Ising2D.Basic
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIndexSetFromOneToN

namespace Ising2D

/-- **`def_finite_sum_of_complex_numbers`**: `Fin m` の上の複素数の `Finset.sum` は、本文の複素数の有限和の帰納の二つの式を、
添字を写像 `finIndexToZZ` で人手の添字の集合 `{1,…,m}` へ送って満たす（Lean だけの段の補題。上の説明を見よ）。 -/
theorem finset_sum_fin_complex_eq_finite_sum_of_complex_numbers :
    (∀ (z : Fin 1 → ℂ) (l : Fin 1), finIndexToZZ 1 l = 1 → ∑ j, z j = z l) ∧
      (∀ (m : ℕ), 1 ≤ m → ∀ (z : Fin (m + 1) → ℂ) (w : Fin m → ℂ),
        (∀ (i : Fin m) (j : Fin (m + 1)), finIndexToZZ m i = finIndexToZZ (m + 1) j → w i = z j) →
        ∀ (l : Fin (m + 1)), finIndexToZZ (m + 1) l = inclusionNNtoZZ (m + 1) →
          ∑ j, z j = (∑ i, w i) + z l) := by
  refine ⟨?_, ?_⟩
  · intro z l _
    rw [Fin.sum_univ_one, Subsingleton.elim l 0]
  · intro m _ z w hw l hl
    -- 像が `ι_{ℕ→ℤ}(m+1)` の元 `l` は `Fin (m+1)` の最後の元である
    have hlast : l = Fin.last m :=
      Fin.ext (by have h := (finIndexToZZ_eq_iff_val_add_one_eq (m + 1) l).1 hl; simp only [Fin.val_last]; omega)
    rw [Fin.sum_univ_castSucc, hlast]
    congr 1
    -- `Fin m` の元 `i` と、値を同じくする `Fin (m+1)` の元は同じ像を持つ（定義どおり）
    exact Finset.sum_congr rfl fun i _ => (hw i (Fin.castSucc i) rfl).symm

/-- **`def_finite_sum_of_real_numbers`**: `Fin m` の上の実数の `Finset.sum` は、本文の実数の有限和の帰納の二つの式を、
添字を写像 `finIndexToZZ` で人手の添字の集合 `{1,…,m}` へ送って満たす（Lean だけの段の補題。上の説明を見よ）。 -/
theorem finset_sum_fin_real_eq_finite_sum_of_real_numbers :
    (∀ (r : Fin 1 → ℝ) (l : Fin 1), finIndexToZZ 1 l = 1 → ∑ j, r j = r l) ∧
      (∀ (m : ℕ), 1 ≤ m → ∀ (r : Fin (m + 1) → ℝ) (w : Fin m → ℝ),
        (∀ (i : Fin m) (j : Fin (m + 1)), finIndexToZZ m i = finIndexToZZ (m + 1) j → w i = r j) →
        ∀ (l : Fin (m + 1)), finIndexToZZ (m + 1) l = inclusionNNtoZZ (m + 1) →
          ∑ j, r j = (∑ i, w i) + r l) := by
  refine ⟨?_, ?_⟩
  · intro r l _
    rw [Fin.sum_univ_one, Subsingleton.elim l 0]
  · intro m _ r w hw l hl
    -- 像が `ι_{ℕ→ℤ}(m+1)` の元 `l` は `Fin (m+1)` の最後の元である
    have hlast : l = Fin.last m :=
      Fin.ext (by have h := (finIndexToZZ_eq_iff_val_add_one_eq (m + 1) l).1 hl; simp only [Fin.val_last]; omega)
    rw [Fin.sum_univ_castSucc, hlast]
    congr 1
    -- `Fin m` の元 `i` と、値を同じくする `Fin (m+1)` の元は同じ像を持つ（定義どおり）
    exact Finset.sum_congr rfl fun i _ => (hw i (Fin.castSucc i) rfl).symm

end Ising2D
