/-
# 成分がすべて実数の行列の積（必要十分版）

具体版: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimProductOfRealEntryMatricesHasRealEntries.lean`
（人手 `product_of_real_entry_matrices_has_real_entries`）。
具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimProductOfRealEntryMatricesFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 1 段目（`mat_mult`） | `mul_entries_mem` の 1 段目 |
| 2〜3 段目（`s_j, t_j` の取り方、`real_inclusion_preserves_product` を各項へ） | 各項 `A_{ij}B_{jk}` を、仮定 `hA i j`・`hB j k` と積で閉じること `hmul` で性質に入れる段 |
| 4 段目（`real_inclusion_preserves_finite_sum`） | 空でない有限和が性質に入ること（`finset_sum_mem_of_add_closed`。和で閉じること `hadd` からの帰納法） |

- `finset_sum_mem_of_add_closed` の帰納法は、人手 `real_inclusion_preserves_finite_sum` の帰納法（`m = 1` と、末尾に `r_{m+1}` を足す段）と
  同じ 2 つの場合を持つが、Lean の `Finset.Nonempty.cons_induction` に合わせて項を先頭に足す（`f a + Σ_s f`）。
  論証は和の可換性を使わず、和で閉じること `hadd` を当てる向きが変わるだけである。

## 何が効いているか / 効いていないか

- 「`r_ℂ` の形に書ける」（`ℝ` の像に入る）を、係数の型 `R` の任意の性質 `S` に置き換えた。
- 効いているのは、**`S` が積で閉じていること**（`hmul`。具体版の 2〜3 段目の、各項が実数の積の像になる段）と、
  **`S` が和で閉じていること**（`hadd`。4 段目の、実数の有限和の像になる段）、そして**和を取る添字が空でないこと**
  （`Nonempty β`。人手の `n ≥ 1`）である。
- 削れない理由:
  - `hmul` を落とすと各項 `A_{ij}B_{jk}` が `S` に入る根拠が無い（`S` を「純虚数」に取ると和で閉じるが、`i·i = -1` は入らない）。
  - `hadd` を落とすと項の和が `S` に入る根拠が無い（`S` を「`±1`」に取ると積で閉じるが、`1 + 1 = 2` は入らない）。
  - `Nonempty β` を落とすと、空の和 `0` が `S` に入る根拠が無い（`S` を「正の実数の像」に取ると和と積で閉じるが `0` は入らない）。
    具体版では `0 = 0_ℂ` が `ℝ` の像なので空の和でも成り立つが、それは `S` が `0` を含むという、論証が使わない性質による。
- 係数に `AddCommMonoid R` を置いたのは、Lean の行列の積と有限和 `∑`（`Finset.sum`）がそれを要求するためで、
  論証は加法の結合性・可換性・零元を使わない（空でない有限和を、1 項の和と項を 1 つ足す段の帰納法で読むだけ）。
  積の結合性・単位元・分配法則も使わない（`Mul R` だけ）。
- 行・列の添字 `α`・`γ` は任意の型で、有限であることも正方であることも効いていない。
-/
import Mathlib.Data.Matrix.Mul

namespace Ising2D.NecSuf

/-- **空でない有限和**（具体版の 4 段目 `real_inclusion_preserves_finite_sum` に当たる）: 和で閉じた性質に各項が入るなら、
空でない有限集合の上の和もその性質に入る。1 項の和と、項を 1 つ足す段の帰納法。 -/
theorem finset_sum_mem_of_add_closed {R ι : Type*} [AddCommMonoid R] (S : R → Prop)
    (hadd : ∀ a b, S a → S b → S (a + b)) (f : ι → R) {s : Finset ι} (hs : s.Nonempty) :
    (∀ j ∈ s, S (f j)) → S (∑ j ∈ s, f j) := by
  induction hs using Finset.Nonempty.cons_induction with
  | singleton a =>
    intro hf
    rw [Finset.sum_singleton]                                               -- 1 項の和
    exact hf a (Finset.mem_singleton_self a)
  | cons a s ha _ ih =>
    intro hf
    rw [Finset.sum_cons]                                                    -- 項を 1 つ足す段
    exact hadd _ _ (hf a (Finset.mem_cons_self a s))
      (ih fun j hj => hf j (Finset.mem_cons_of_mem hj))                     -- 帰納法の仮定と、和で閉じること

/-- **積（具体版 `matrix_mul_hasRealEntries`）**: 積と和で閉じた性質に成分がすべて入る 2 つの行列の積も、
和を取る添字が空でなければ、成分はすべてその性質に入る。 -/
theorem mul_entries_mem {R α β γ : Type*} [Fintype β] [Nonempty β] [AddCommMonoid R] [Mul R]
    (S : R → Prop) (hmul : ∀ a b, S a → S b → S (a * b)) (hadd : ∀ a b, S a → S b → S (a + b))
    (A : Matrix α β R) (B : Matrix β γ R) (hA : ∀ p q, S (A p q)) (hB : ∀ p q, S (B p q)) :
    ∀ i k, S ((A * B) i k) := by
  intro i k
  have h : (A * B) i k = ∑ j, A i j * B j k := rfl                          -- 積の定義（具体版の 1 段目）
  rw [h]
  exact finset_sum_mem_of_add_closed S hadd (fun j => A i j * B j k) Finset.univ_nonempty
    fun j _ => hmul _ _ (hA i j) (hB j k)                                   -- 各項は積で閉じること（2〜3 段目）、和は空でない有限和（4 段目）

end Ising2D.NecSuf
