/-
# 添字の集合 {1,…,n} と Lean の `Fin n` の間の写像（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_definition_index_set_from_one_to_n`、ラベル **`def_index_set_from_one_to_n`**）

人手は `n ∈ ℤ_{≥0}` について添字の集合を `{1,…,n} := {k ∈ ℤ_{≥1} | k ≤_ℤ n}` と定め、行列の成分・有限和・サイトの添字をこの集合の元で書く。
Lean の具体版は添字の型に `Fin n`（`v < n` を満たす `v ∈ ℕ` と、その証明の組）を使う。二つの集合は別の集合なので、
名前を付けた写像 `finIndexToZZ n : Fin n → ℤ`（`i ↦ ι_{ℕ→ℤ}(i.val) +_ℤ 1_ℤ`。`ι_{ℕ→ℤ}` は `inclusion_nn_to_zz` の具体版 `inclusionNNtoZZ`）を置き、
それが `Fin n` から `{k ∈ ℤ | 1_ℤ ≤ k ∧ k ≤ ι_{ℕ→ℤ}(n)}` への全単射であることを補題一本 `finIndexToZZ_bijective_onto_index_set` で示す。
像の ℤ の順序が `Fin n` の元の値の順序と一致することを `finIndexToZZ_lt_iff_val_lt` で、像と `ι_{ℕ→ℤ}(k)` の比較・等号が値の比較・等号と一致することを
`finIndexToZZ_le_inclusion_iff_val_lt`・`finIndexToZZ_eq_iff_val_add_one_eq` で示す（人手の添字の比較を Lean の定義の場合分けへ移す）。
像が `ι_{ℕ→ℤ}(l) + 1_ℤ` に等しいことが値の等号 `i.val = l` と同値であることを `finIndexToZZ_eq_inclusion_add_one_iff_val_eq` で示す
（人手の添字から、自然数の添字を持つ Lean の定義（`Yflat`・`Zflat` など）の添字へ移す）。
`m ≤ n` のとき、人手は `{1,…,m}` の元をそのまま `{1,…,n}` の元として書く（例: 開鎖項 `D_0` の和の添字 `m ∈ {1,…,M_col-1}` をサイトの添字に使う）。
Lean は型 `Fin m` の元から型 `Fin n` の元へ mathlib の `Fin.castLE` で移るので、移っても人手の添字が変わらないこと
`finIndexToZZ n (Fin.castLE h j) = finIndexToZZ m j` を `finIndexToZZ_castLE` で示す。
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

/-- **`def_index_set_from_one_to_n`**: `finIndexToZZ n` の像の ℤ の順序は、`Fin n` の元の値（ℕ）の順序と一致する:
`ι_{ℕ→ℤ}(i.val) + 1_ℤ < ι_{ℕ→ℤ}(j.val) + 1_ℤ ⇔ i.val < j.val`。
人手は添字 `i, j ∈ {1,…,n}` を ℤ の順序で直接比べ、Lean の具体版の定義（`jwFamily` など）は `Fin n` の元の値を ℕ の順序で比べるので、
人手の比較から Lean の定義の場合分けへ移すために置く（Lean だけの段の補題）。 -/
theorem finIndexToZZ_lt_iff_val_lt (n : ℕ) (i j : Fin n) :
    finIndexToZZ n i < finIndexToZZ n j ↔ (i : ℕ) < (j : ℕ) := by
  simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
  omega

/-- **`def_index_set_from_one_to_n`**: 人手の添字 `finIndexToZZ n m` と `ι_{ℕ→ℤ}(n)` の等号は、Lean の `Fin n` の元の値の等号 `m.val + 1 = n` と同値である
（Lean だけの段の補題。Lean の定義が最後のサイトを値の等号で判定するので、人手の添字の比較から移すために置く）。 -/
theorem finIndexToZZ_eq_iff_val_add_one_eq (n : ℕ) (m : Fin n) :
    finIndexToZZ n m = inclusionNNtoZZ n ↔ (m : ℕ) + 1 = n := by
  simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
  omega

/-- **`def_index_set_from_one_to_n`**: 人手の添字 `finIndexToZZ n i` が `ι_{ℕ→ℤ}(k)` 以下であることは、Lean の `Fin n` の元の値の不等式 `i.val < k` と同値である
（Lean だけの段の補題。人手の「第 `1` から第 `k` 因子」は、添字が `ι_{ℕ→ℤ}(k)` 以下であることに当たる。Lean の定義 `prefixKroneckerFamily` などは値の `< k` で場合を分けるので、移すために置く）。 -/
theorem finIndexToZZ_le_inclusion_iff_val_lt (n : ℕ) (i : Fin n) (k : ℕ) :
    finIndexToZZ n i ≤ inclusionNNtoZZ k ↔ (i : ℕ) < k := by
  simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
  omega

/-- **`def_index_set_from_one_to_n`**: 人手の添字 `finIndexToZZ n i` が `ι_{ℕ→ℤ}(l) +_ℤ 1_ℤ` に等しいことは、Lean の `Fin n` の元の値の等号 `i.val = l` と同値である
（Lean だけの段の補題。人手の添字 `j` から、自然数の添字 `l = j - 1` を取る Lean の定義（`Yflat`・`Zflat` など）の添字へ移すために置く）。 -/
theorem finIndexToZZ_eq_inclusion_add_one_iff_val_eq (n : ℕ) (i : Fin n) (l : ℕ) :
    finIndexToZZ n i = inclusionNNtoZZ l + 1 ↔ (i : ℕ) = l := by
  simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
  omega

/-- **`def_index_set_from_one_to_n`**: `m ≤ n` のとき、Lean の `Fin.castLE h : Fin m → Fin n` は人手の添字を変えない:
`finIndexToZZ n (Fin.castLE h j) = finIndexToZZ m j`。人手は `{1,…,m}` の元 `k` を、`k ≤ m ≤ n` なのでそのまま `{1,…,n}` の元として書き、
Lean は型 `Fin m` の元から型 `Fin n` の元へ `Fin.castLE` で移るので、移した元の像が同じ整数であることを示す（Lean だけの段の補題）。
`Fin.castLE h j` の値は `j` の値と定義として等しいので、両辺は `finIndexToZZ` の定義で同じ式 `ι_{ℕ→ℤ}(j.val) + 1_ℤ` になる。 -/
theorem finIndexToZZ_castLE {m n : ℕ} (h : m ≤ n) (j : Fin m) :
    finIndexToZZ n (Fin.castLE h j) = finIndexToZZ m j :=
  rfl

end Ising2D
