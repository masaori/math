/-
「有限集合の元の個数より一つ多い自然数を写すと、二つの自然数が同じ元へ行く」と
「二つの整数倍のずらしの値が部分体に入れば積も入る」「和と積も入る」の必要十分版。

鳩の巣: 具体版の証明が使うのは、定義域が有限で全順序を持つこと（相異なる二元が大小のどちらかで並ぶ）と、
定義域の元の個数が値域の元の個数より大きいことだけである。定義域が `ℕ_{<|P|+1}` であることも、
個数の差がちょうど一であることも使わない。

積: 台は除法環でよい。可換性は使わない（整数の像は全ての元と可換なので `(c-c')·x·(c-c')⁻¹ = x`）。
標数零も使わない。使うのは整数 `c - c'` の像が零でないことだけである
（標数 `p` の体でも `p` が `c - c'` を割らなければ成り立つ）。部分集合 `S` について使うのは、
差と商で閉じることと、`c - c'` の像を含むことだけで、零元・単位元を含むことも積の閉性も使わない。
和: 使うのは、`S` が差と積で閉じることと、`c` の像を含むことと、積の主張の結論だけである。
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Algebra.Field.Basic
import Mathlib.Data.Int.Cast.Lemmas
import Mathlib.Tactic.NoncommRing
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.FisherZero

/-- 具体版と同じ段（単射性の導出、像の個数、部分集合の個数の上界）で示す。 -/
theorem pigeonhole_lt_necSuf {A B : Type*} [Fintype A] [Fintype B] [DecidableEq B] [LinearOrder A]
    (hcard : Fintype.card B < Fintype.card A) (φ : A → B) :
    ∃ c c' : A, c < c' ∧ φ c = φ c' := by
  by_contra hno
  simp only [not_exists, not_and] at hno
  have hinj : Function.Injective φ := by
    intro c c' hcc'
    by_contra hne
    rcases lt_or_gt_of_ne hne with hlt | hgt
    · exact hno c c' hlt hcc'
    · exact hno c' c hgt hcc'.symm
  have himage : (Finset.univ.image φ).card = Fintype.card A := by
    rw [Finset.card_image_of_injective _ hinj, Finset.card_univ]
  have hsub : (Finset.univ.image φ).card ≤ Fintype.card B := by
    exact (Finset.card_le_card (Finset.subset_univ _)).trans_eq Finset.card_univ
  omega

/-- 具体版と同じ式鎖 `x = ((c-c')x)/(c-c') = (u-u')/(c-c')` で示す。
`((c-c')x)/(c-c') = x` は、整数の像の可換性 `Int.cast_comm` と逆元の性質で得る（可換性の公理は使わない）。 -/
theorem mul_mem_of_two_shifted_mem_necSuf {K : Type*} [DivisionRing K] (S : Set K)
    (hsub : ∀ a b : K, a ∈ S → b ∈ S → a - b ∈ S) (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S)
    (α β : K) (c c' : ℤ) (hne : ((c - c' : ℤ) : K) ≠ 0) (hS : ((c - c' : ℤ) : K) ∈ S)
    (hu : α + β + (c : K) * (α * β) ∈ S) (hu' : α + β + (c' : K) * (α * β) ∈ S) :
    α * β ∈ S := by
  have hchain : α * β
      = ((α + β + (c : K) * (α * β)) - (α + β + (c' : K) * (α * β))) / ((c - c' : ℤ) : K) := by
    calc α * β = ((c - c' : ℤ) : K) * (α * β) / ((c - c' : ℤ) : K) := by
            rw [div_eq_mul_inv, Int.cast_comm, mul_assoc, mul_inv_cancel₀ hne, mul_one]
      _ = ((α + β + (c : K) * (α * β)) - (α + β + (c' : K) * (α * β))) / ((c - c' : ℤ) : K) := by
            congr 1
            push_cast
            noncomm_ring
  rw [hchain]
  exact hdiv _ _ (hsub _ _ hu hu') hS

/-- 具体版と同じ段（積の主張、`α+β = u - c·αβ`）で示す。 -/
theorem add_mem_and_mul_mem_of_two_shifted_mem_necSuf {K : Type*} [DivisionRing K] (S : Set K)
    (hsub : ∀ a b : K, a ∈ S → b ∈ S → a - b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S)
    (α β : K) (c c' : ℤ) (hne : ((c - c' : ℤ) : K) ≠ 0) (hS : ((c - c' : ℤ) : K) ∈ S)
    (hc : (c : K) ∈ S)
    (hu : α + β + (c : K) * (α * β) ∈ S) (hu' : α + β + (c' : K) * (α * β) ∈ S) :
    α + β ∈ S ∧ α * β ∈ S := by
  have hm : α * β ∈ S := mul_mem_of_two_shifted_mem_necSuf S hsub hdiv α β c c' hne hS hu hu'
  have hchain : α + β = (α + β + (c : K) * (α * β)) - (c : K) * (α * β) := by abel
  refine ⟨?_, hm⟩
  rw [hchain]
  exact hsub _ _ hu (hmul _ _ hc hm)

end Ising2DLambda.NecSuf.FisherZero
