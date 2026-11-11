/-
「偶辺鎖は正方形境界と二つの基本周回に分解できる」（`claim_even_edge_chain_torus_normal_form`）の具体版。
係数は本文と同じ `𝔽₂ = ZMod 2`、添字は `ZMod L` である。住処は ℕ と 𝔽₂ で、ℝ / ℂ は現れない。

人手証明との対応:
- `hrowshift`・`hrow`: 頂点条件を `j` にわたって足し、縦辺の行和が行によらず `v` であることを示す段。
- `cyclicPartialSum_step`: 部分和 `p^v_{i,j}`（`q_i`）の隣接差が `j ≠ 0` で零、`j = 0` で全和になる段。
- `hVvval`: `C^v` の縦辺係数 `V^v_{i,j}` を `j ≠ 0` と `j = 0` で求める段。
- `hevenv`: 各 `P_{i,j}` が頂点偶次数なので `C^v` も頂点偶次数である段。
- `hHshift`・`hHa`: 横辺係数が行の中で一定値 `a_i` である段。
- `hsuma`・`hqrow`: `C^h` の横辺係数 `H^h_{i,j}` を `i ≠ 0` と `i = 0` で求め、`Σ a_r = h` とする段。
- 最後の二つの `linear_combination`: 加えた正方形境界を再び加えて消し、`p_{i,j} := p^v_{i,j} + q_i` とする段。
-/
import Ising2DLambda.KacWard.EvenEdgeChainIntersection
import Ising2DLambda.NecSuf.KacWard.EvenEdgeChainTorusNormalForm
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

/-- `𝔽₂` では `2 = 0`。同じ正方形境界を二度加えると消える。 -/
theorem zmodTwo_two_eq_zero : (2 : ZMod 2) = 0 := by decide


open Finset


/-- 正方形境界 `P_{a,b}` の横辺 `(i,j)` の係数。上辺 `H_{a,b}` と下辺 `H_{a+1,b}`。 -/
def squareBoundaryHorizontal {L : ℕ} (a b i j : ZMod L) : ZMod 2 :=
  (if i = a ∧ j = b then 1 else 0) + (if i = a + 1 ∧ j = b then 1 else 0)

/-- 正方形境界 `P_{a,b}` の縦辺 `(i,j)` の係数。左辺 `V_{a,b}` と右辺 `V_{a,b+1}`。 -/
def squareBoundaryVertical {L : ℕ} (a b i j : ZMod L) : ZMod 2 :=
  (if i = a ∧ j = b then 1 else 0) + (if i = a ∧ j = b + 1 then 1 else 0)

/-- 基本周回 `R_h`（行 `0` の横辺の和）の横辺係数。縦辺係数は零。 -/
def fundamentalRowHorizontal {L : ℕ} (i _j : ZMod L) : ZMod 2 := if i = 0 then 1 else 0

/-- 基本周回 `R_v`（列 `0` の縦辺の和）の縦辺係数。横辺係数は零。 -/
def fundamentalColumnVertical {L : ℕ} (_i j : ZMod L) : ZMod 2 := if j = 0 then 1 else 0

/-- 部分和 `Σ_{r=1}^{j} f_r`（`j` は代表 `0,…,L-1` で読む。`j = 0` では空和）。 -/
def cyclicPartialSum {L : ℕ} (f : ZMod L → ZMod 2) (j : ZMod L) : ZMod 2 :=
  ∑ r ∈ range j.val, f ((r + 1 : ℕ) : ZMod L)

/-- 一つ前の添字と値が等しい写像は一定である。 -/
theorem cyclic_const_of_pred {L : ℕ} [NeZero L] {α : Type*} (f : ZMod L → α)
    (hf : ∀ j, f j = f (j - 1)) (j : ZMod L) : f j = f 0 := by
  have key : ∀ n : ℕ, f (n : ZMod L) = f 0 := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
      rw [hf]
      push_cast
      simpa using ih
  have := key j.val
  rwa [ZMod.natCast_zmod_val] at this

/-- 代表 `0,…,L-1` にわたる和は `ZMod L` 全体にわたる和である。 -/
theorem sum_range_eq_univ {L : ℕ} [NeZero L] (g : ZMod L → ZMod 2) :
    ∑ r ∈ range L, g (r : ZMod L) = ∑ x : ZMod L, g x := by
  refine Finset.sum_nbij' (fun r => (r : ZMod L)) (fun x => x.val) ?_ ?_ ?_ ?_ ?_
  · intro r _; exact mem_univ _
  · intro x _; exact mem_range.mpr (ZMod.val_lt x)
  · intro r hr; exact ZMod.val_natCast_of_lt (mem_range.mp hr)
  · intro x _; exact ZMod.natCast_zmod_val x
  · intro r _; rfl

/-- 部分和の隣接差: `f_j + p_{j-1} + p_j` は `j ≠ 0` で零、`j = 0` で全和。 -/
theorem cyclicPartialSum_step {L : ℕ} [NeZero L]
    (f : ZMod L → ZMod 2) (j : ZMod L) :
    f j + cyclicPartialSum f (j - 1) + cyclicPartialSum f j =
      if j = 0 then ∑ k, f k else 0 := by
  obtain ⟨n, hn⟩ : ∃ n, j.val = n := ⟨_, rfl⟩
  cases n with
  | zero =>
    have hj : j = 0 := (ZMod.val_eq_zero j).mp hn
    subst hj
    obtain ⟨k, hk⟩ : ∃ k, L = k + 1 := Nat.exists_eq_succ_of_ne_zero (NeZero.ne L)
    subst hk
    have hneg : ((0 : ZMod (k + 1)) - 1).val = k := by
      rw [zero_sub]; exact ZMod.val_neg_one k
    simp only [if_true, cyclicPartialSum, hneg, ZMod.val_zero, range_zero, sum_empty,
      add_zero]
    rw [← sum_range_eq_univ, Finset.sum_range_succ' (fun r => f (r : ZMod (k + 1))) k]
    push_cast
    ring
  | succ m =>
    have hj : j ≠ 0 := by
      intro h; subst h; simp at hn
    have hlt : m + 1 < L := hn ▸ ZMod.val_lt j
    have hjcast : j = ((m + 1 : ℕ) : ZMod L) := by rw [← hn, ZMod.natCast_zmod_val]
    have hprev : j - 1 = (m : ZMod L) := by rw [hjcast]; push_cast; ring
    have hprevval : (j - 1).val = m := by
      rw [hprev]; exact ZMod.val_natCast_of_lt (by omega)
    have hsucc : cyclicPartialSum f j = cyclicPartialSum f (j - 1) + f j := by
      unfold cyclicPartialSum
      rw [hn, hprevval, Finset.sum_range_succ, ← hjcast]
    rw [if_neg hj, hsucc]
    linear_combination (f j + cyclicPartialSum f (j - 1)) * zmodTwo_two_eq_zero

/-- `Σ_{a,b} p_{a,b} P_{a,b}` の横辺 `(i,j)` の係数は `p_{i,j} + p_{i-1,j}`。 -/
theorem sum_mul_squareBoundaryHorizontal {L : ℕ} [NeZero L] (p : ZMod L → ZMod L → ZMod 2)
    (i j : ZMod L) :
    ∑ a, ∑ b, p a b * squareBoundaryHorizontal a b i j = p i j + p (i - 1) j := by
  have hshift : ∀ a : ZMod L, (i = a + 1) ↔ (a = i - 1) := by
    intro a; constructor
    · intro h; rw [h]; ring
    · intro h; rw [h]; ring
  simp only [squareBoundaryHorizontal, hshift, mul_add, sum_add_distrib, mul_ite, mul_one,
    mul_zero, ite_and]
  simp

/-- `Σ_{a,b} p_{a,b} P_{a,b}` の縦辺 `(i,j)` の係数は `p_{i,j} + p_{i,j-1}`。 -/
theorem sum_mul_squareBoundaryVertical {L : ℕ} [NeZero L] (p : ZMod L → ZMod L → ZMod 2)
    (i j : ZMod L) :
    ∑ a, ∑ b, p a b * squareBoundaryVertical a b i j = p i j + p i (j - 1) := by
  have hshift : ∀ b : ZMod L, (j = b + 1) ↔ (b = j - 1) := by
    intro b; constructor
    · intro h; rw [h]; ring
    · intro h; rw [h]; ring
  simp only [squareBoundaryVertical, hshift, mul_add, sum_add_distrib, mul_ite, mul_one,
    mul_zero, ite_and]
  simp

/-- 偶辺鎖の標準形（必要十分版）。各頂点の条件
`H_{i,j}+H_{i,j-1}+V_{i,j}+V_{i-1,j}=0` を満たす係数について、
`C = h R_h + v R_v + Σ p_{i,j} P_{i,j}` を係数ごとに述べる。 -/
theorem evenEdgeChain_torusNormalForm {L : ℕ} [NeZero L]
    (H V : ZMod L → ZMod L → ZMod 2)
    (heven : ∀ i j, H i j + H i (j - 1) + V i j + V (i - 1) j = 0) :
    ∃ p : ZMod L → ZMod L → ZMod 2,
      (∀ i j, H i j =
          (∑ i', H i' (-1)) * fundamentalRowHorizontal i j + (∑ j', V (-1) j') * 0 +
            ∑ a, ∑ b, p a b * squareBoundaryHorizontal a b i j) ∧
      (∀ i j, V i j =
          (∑ i', H i' (-1)) * 0 + (∑ j', V (-1) j') * fundamentalColumnVertical i j +
            ∑ a, ∑ b, p a b * squareBoundaryVertical a b i j) := by
  -- 頂点条件を `j` にわたって足すと、横辺は二度現れて消え、縦辺の行和は行によらない。
  have hrowshift : ∀ i, ∑ j, V i j = ∑ j, V (i - 1) j := by
    intro i
    have hs : ∑ j, (H i j + H i (j - 1) + V i j + V (i - 1) j) = 0 := by simp [heven]
    have hH : ∑ j, H i (j - 1) = ∑ j, H i j :=
      (Equiv.subRight (1 : ZMod L)).sum_comp (fun j => H i j)
    simp only [sum_add_distrib, hH] at hs
    linear_combination hs - (∑ j, H i j + ∑ j, V (i - 1) j) * zmodTwo_two_eq_zero
  -- 従って縦辺の行和は `v` に等しい。
  have hrow : ∀ i, ∑ j, V i j = ∑ j', V (-1) j' := by
    intro i
    rw [cyclic_const_of_pred (fun i => ∑ j, V i j) hrowshift i,
      cyclic_const_of_pred (fun i => ∑ j, V i j) hrowshift (-1)]
  -- `p^v_{i,j} := Σ_{r=1}^{j} V_{i,r}`、`C^v := C + Σ p^v_{i,j} P_{i,j}`。
  set pv : ZMod L → ZMod L → ZMod 2 := fun i j => cyclicPartialSum (V i) j with hpv
  set Hv : ZMod L → ZMod L → ZMod 2 := fun i j => H i j + pv i j + pv (i - 1) j with hHv
  set Vv : ZMod L → ZMod L → ZMod 2 := fun i j => V i j + pv i j + pv i (j - 1) with hVv
  -- `C^v` の縦辺係数は `j ≠ 0` で零、`j = 0` で `v`。
  have hVvval : ∀ i j, Vv i j = (∑ j', V (-1) j') * fundamentalColumnVertical i j := by
    intro i j
    have hstep := cyclicPartialSum_step (V i) j
    simp only [hVv, hpv]
    unfold fundamentalColumnVertical
    split_ifs at hstep ⊢ with hj
    · rw [mul_one, ← hrow i, ← hstep]; ring
    · rw [mul_zero, ← hstep]; ring
  -- 各 `P_{i,j}` は頂点偶次数なので、`C^v` も頂点偶次数。
  have hevenv : ∀ i j, Hv i j + Hv i (j - 1) + Vv i j + Vv (i - 1) j = 0 := by
    intro i j
    simp only [hHv, hVv]
    linear_combination heven i j +
      (pv i j + pv (i - 1) j + pv i (j - 1) + pv (i - 1) (j - 1)) * zmodTwo_two_eq_zero
  -- 縦辺係数を代入すると、横辺係数は行の中で一定。
  have hHshift : ∀ i j, Hv i j = Hv i (j - 1) := by
    intro i j
    have h1 := hVvval i j
    have h2 := hVvval (i - 1) j
    have h3 : fundamentalColumnVertical (L := L)  (i - 1) j =
        fundamentalColumnVertical i j := rfl
    rw [h3] at h2
    linear_combination hevenv i j - h1 - h2 -
      (Hv i (j - 1) + (∑ j', V (-1) j') * fundamentalColumnVertical i j) * zmodTwo_two_eq_zero
  -- 行 `i` に共通な係数 `a_i`。
  set a : ZMod L → ZMod 2 := fun i => Hv i 0 with ha
  have hHa : ∀ i j, Hv i j = a i := fun i j => cyclic_const_of_pred (Hv i) (hHshift i) j
  -- `Σ_i a_i = h`（正方形境界は切断線の横辺を偶数回含む）。
  have hsuma : ∑ i, a i = ∑ i', H i' (-1) := by
    have hshiftpv : ∑ i, pv (i - 1) (-1) = ∑ i, pv i (-1) :=
      (Equiv.subRight (1 : ZMod L)).sum_comp (fun i => pv i (-1))
    calc ∑ i, a i = ∑ i, Hv i (-1) := by simp only [hHa]
      _ = ∑ i, H i (-1) + ∑ i, pv i (-1) + ∑ i, pv (i - 1) (-1) := by
        simp only [hHv, sum_add_distrib]
      _ = ∑ i', H i' (-1) := by
        rw [hshiftpv]; linear_combination (∑ i, pv i (-1)) * zmodTwo_two_eq_zero
  -- `q_i := Σ_{r=1}^{i} a_r`。`C^h := C^v + Σ_i q_i Σ_j P_{i,j}` の横辺係数は `h R_h`。
  set q : ZMod L → ZMod 2 := cyclicPartialSum a with hq
  have hqrow : ∀ i, a i + q (i - 1) + q i =
      (∑ i', H i' (-1)) * fundamentalRowHorizontal i (0 : ZMod L) := by
    intro i
    have hstep := cyclicPartialSum_step a i
    unfold fundamentalRowHorizontal
    split_ifs at hstep ⊢ with hi
    · rw [mul_one, ← hsuma, ← hstep]
    · rw [mul_zero, ← hstep]
  -- 両側へ加えた正方形境界をもう一度加えて消し、`p_{i,j} := p^v_{i,j} + q_i` と置く。
  refine ⟨fun i j => pv i j + q i, ?_, ?_⟩
  · intro i j
    rw [sum_mul_squareBoundaryHorizontal]
    have e1 : Hv i j = a i := hHa i j
    simp only [hHv] at e1
    have e2 := hqrow i
    have e3 : fundamentalRowHorizontal (L := L)  i j =
        fundamentalRowHorizontal i 0 := rfl
    rw [e3]
    linear_combination e1 + e2 - (pv i j + pv (i - 1) j + q i + q (i - 1)) * zmodTwo_two_eq_zero
  · intro i j
    rw [sum_mul_squareBoundaryVertical]
    have e1 := hVvval i j
    simp only [hVv] at e1
    linear_combination e1 - (pv i j + pv i (j - 1) + q i) * zmodTwo_two_eq_zero


/-- 本文の辺鎖 `C`（辺の有限集合）の横辺・縦辺係数について述べた形。 -/
theorem evenEdgeChain_torusNormalForm_of_finset {L : ℕ} [NeZero L] (C : Finset (Edge L))
    (heven : ∀ i j, horizontalChainCoefficient L C i j + horizontalChainCoefficient L C i (j - 1) +
      verticalChainCoefficient L C i j + verticalChainCoefficient L C (i - 1) j = 0) :
    ∃ p : ZMod L → ZMod L → ZMod 2,
      (∀ i j, horizontalChainCoefficient L C i j =
          (∑ i', horizontalChainCoefficient L C i' (-1)) * fundamentalRowHorizontal i j +
            (∑ j', verticalChainCoefficient L C (-1) j') * 0 +
            ∑ a, ∑ b, p a b * squareBoundaryHorizontal a b i j) ∧
      (∀ i j, verticalChainCoefficient L C i j =
          (∑ i', horizontalChainCoefficient L C i' (-1)) * 0 +
            (∑ j', verticalChainCoefficient L C (-1) j') * fundamentalColumnVertical i j +
            ∑ a, ∑ b, p a b * squareBoundaryVertical a b i j) :=
  evenEdgeChain_torusNormalForm (horizontalChainCoefficient L C) (verticalChainCoefficient L C) heven

/-- 具体版の主張が必要十分版の `R = 𝔽₂` への特殊化であること。 -/
theorem evenEdgeChain_torusNormalForm_from_necSuf {L : ℕ} [NeZero L]
    (H V : ZMod L → ZMod L → ZMod 2)
    (heven : ∀ i j, H i j + H i (j - 1) + V i j + V (i - 1) j = 0) :
    ∃ p : ZMod L → ZMod L → ZMod 2,
      (∀ i j, H i j =
          (∑ i', H i' (-1)) * fundamentalRowHorizontal i j + (∑ j', V (-1) j') * 0 +
            ∑ a, ∑ b, p a b * squareBoundaryHorizontal a b i j) ∧
      (∀ i j, V i j =
          (∑ i', H i' (-1)) * 0 + (∑ j', V (-1) j') * fundamentalColumnVertical i j +
            ∑ a, ∑ b, p a b * squareBoundaryVertical a b i j) :=
  Ising2DLambda.NecSuf.KacWard.ringEvenEdgeChain_torusNormalForm zmodTwo_two_eq_zero H V heven

end Ising2DLambda.KacWard
