/-
「偶辺鎖は正方形境界と二つの基本周回に分解できる」（`claim_even_edge_chain_torus_normal_form`）の
必要十分版。

具体版と同じ手順（縦辺の部分和による消去 → 横辺が行ごとに一定になること → 行の部分和による消去）を、
係数を可換環 `R` に置いて書く。仮定は `(2 : R) = 0` だけである。これを外すと、同じ正方形境界を
二度加えて消す段（部分和の差が一つの係数になる段、頂点条件が保たれる段、最後に両辺へ加えた正方形境界を
消す段）が通らない。添字は巡回群 `ZMod L`（`L ≠ 0`）のままにする。部分和が代表 `0,…,L-1` の
順序で定義されるからである。
-/
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.KacWard

open Finset

variable {R : Type*} [CommRing R]

/-- 正方形境界 `P_{a,b}` の横辺 `(i,j)` の係数。上辺 `H_{a,b}` と下辺 `H_{a+1,b}`。 -/
def ringSquareBoundaryHorizontal {L : ℕ} (a b i j : ZMod L) : R :=
  (if i = a ∧ j = b then 1 else 0) + (if i = a + 1 ∧ j = b then 1 else 0)

/-- 正方形境界 `P_{a,b}` の縦辺 `(i,j)` の係数。左辺 `V_{a,b}` と右辺 `V_{a,b+1}`。 -/
def ringSquareBoundaryVertical {L : ℕ} (a b i j : ZMod L) : R :=
  (if i = a ∧ j = b then 1 else 0) + (if i = a ∧ j = b + 1 then 1 else 0)

/-- 基本周回 `R_h`（行 `0` の横辺の和）の横辺係数。縦辺係数は零。 -/
def ringFundamentalRowHorizontal {L : ℕ} (i _j : ZMod L) : R := if i = 0 then 1 else 0

/-- 基本周回 `R_v`（列 `0` の縦辺の和）の縦辺係数。横辺係数は零。 -/
def ringFundamentalColumnVertical {L : ℕ} (_i j : ZMod L) : R := if j = 0 then 1 else 0

/-- 部分和 `Σ_{r=1}^{j} f_r`（`j` は代表 `0,…,L-1` で読む。`j = 0` では空和）。 -/
def ringCyclicPartialSum {L : ℕ} (f : ZMod L → R) (j : ZMod L) : R :=
  ∑ r ∈ range j.val, f ((r + 1 : ℕ) : ZMod L)

/-- 一つ前の添字と値が等しい写像は一定である。 -/
theorem ringCyclic_const_of_pred {L : ℕ} [NeZero L] {α : Type*} (f : ZMod L → α)
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
theorem ringSum_range_eq_univ {L : ℕ} [NeZero L] (g : ZMod L → R) :
    ∑ r ∈ range L, g (r : ZMod L) = ∑ x : ZMod L, g x := by
  refine Finset.sum_nbij' (fun r => (r : ZMod L)) (fun x => x.val) ?_ ?_ ?_ ?_ ?_
  · intro r _; exact mem_univ _
  · intro x _; exact mem_range.mpr (ZMod.val_lt x)
  · intro r hr; exact ZMod.val_natCast_of_lt (mem_range.mp hr)
  · intro x _; exact ZMod.natCast_zmod_val x
  · intro r _; rfl

/-- 部分和の隣接差: `f_j + p_{j-1} + p_j` は `j ≠ 0` で零、`j = 0` で全和。 -/
theorem ringCyclicPartialSum_step {L : ℕ} [NeZero L] (htwo : (2 : R) = 0)
    (f : ZMod L → R) (j : ZMod L) :
    f j + ringCyclicPartialSum f (j - 1) + ringCyclicPartialSum f j =
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
    simp only [if_true, ringCyclicPartialSum, hneg, ZMod.val_zero, range_zero, sum_empty,
      add_zero]
    rw [← ringSum_range_eq_univ, Finset.sum_range_succ' (fun r => f (r : ZMod (k + 1))) k]
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
    have hsucc : ringCyclicPartialSum f j = ringCyclicPartialSum f (j - 1) + f j := by
      unfold ringCyclicPartialSum
      rw [hn, hprevval, Finset.sum_range_succ, ← hjcast]
    rw [if_neg hj, hsucc]
    linear_combination (f j + ringCyclicPartialSum f (j - 1)) * htwo

/-- `Σ_{a,b} p_{a,b} P_{a,b}` の横辺 `(i,j)` の係数は `p_{i,j} + p_{i-1,j}`。 -/
theorem ringSum_mul_squareBoundaryHorizontal {L : ℕ} [NeZero L] (p : ZMod L → ZMod L → R)
    (i j : ZMod L) :
    ∑ a, ∑ b, p a b * ringSquareBoundaryHorizontal a b i j = p i j + p (i - 1) j := by
  have hshift : ∀ a : ZMod L, (i = a + 1) ↔ (a = i - 1) := by
    intro a; constructor
    · intro h; rw [h]; ring
    · intro h; rw [h]; ring
  simp only [ringSquareBoundaryHorizontal, hshift, mul_add, sum_add_distrib, mul_ite, mul_one,
    mul_zero, ite_and]
  simp

/-- `Σ_{a,b} p_{a,b} P_{a,b}` の縦辺 `(i,j)` の係数は `p_{i,j} + p_{i,j-1}`。 -/
theorem ringSum_mul_squareBoundaryVertical {L : ℕ} [NeZero L] (p : ZMod L → ZMod L → R)
    (i j : ZMod L) :
    ∑ a, ∑ b, p a b * ringSquareBoundaryVertical a b i j = p i j + p i (j - 1) := by
  have hshift : ∀ b : ZMod L, (j = b + 1) ↔ (b = j - 1) := by
    intro b; constructor
    · intro h; rw [h]; ring
    · intro h; rw [h]; ring
  simp only [ringSquareBoundaryVertical, hshift, mul_add, sum_add_distrib, mul_ite, mul_one,
    mul_zero, ite_and]
  simp

/-- 偶辺鎖の標準形（必要十分版）。各頂点の条件
`H_{i,j}+H_{i,j-1}+V_{i,j}+V_{i-1,j}=0` を満たす係数について、
`C = h R_h + v R_v + Σ p_{i,j} P_{i,j}` を係数ごとに述べる。 -/
theorem ringEvenEdgeChain_torusNormalForm {L : ℕ} [NeZero L] (htwo : (2 : R) = 0)
    (H V : ZMod L → ZMod L → R)
    (heven : ∀ i j, H i j + H i (j - 1) + V i j + V (i - 1) j = 0) :
    ∃ p : ZMod L → ZMod L → R,
      (∀ i j, H i j =
          (∑ i', H i' (-1)) * ringFundamentalRowHorizontal i j + (∑ j', V (-1) j') * 0 +
            ∑ a, ∑ b, p a b * ringSquareBoundaryHorizontal a b i j) ∧
      (∀ i j, V i j =
          (∑ i', H i' (-1)) * 0 + (∑ j', V (-1) j') * ringFundamentalColumnVertical i j +
            ∑ a, ∑ b, p a b * ringSquareBoundaryVertical a b i j) := by
  -- 頂点条件を `j` にわたって足すと、横辺は二度現れて消え、縦辺の行和は行によらない。
  have hrowshift : ∀ i, ∑ j, V i j = ∑ j, V (i - 1) j := by
    intro i
    have hs : ∑ j, (H i j + H i (j - 1) + V i j + V (i - 1) j) = 0 := by simp [heven]
    have hH : ∑ j, H i (j - 1) = ∑ j, H i j :=
      (Equiv.subRight (1 : ZMod L)).sum_comp (fun j => H i j)
    simp only [sum_add_distrib, hH] at hs
    linear_combination hs - (∑ j, H i j + ∑ j, V (i - 1) j) * htwo
  -- 従って縦辺の行和は `v` に等しい。
  have hrow : ∀ i, ∑ j, V i j = ∑ j', V (-1) j' := by
    intro i
    rw [ringCyclic_const_of_pred (fun i => ∑ j, V i j) hrowshift i,
      ringCyclic_const_of_pred (fun i => ∑ j, V i j) hrowshift (-1)]
  -- `p^v_{i,j} := Σ_{r=1}^{j} V_{i,r}`、`C^v := C + Σ p^v_{i,j} P_{i,j}`。
  set pv : ZMod L → ZMod L → R := fun i j => ringCyclicPartialSum (V i) j with hpv
  set Hv : ZMod L → ZMod L → R := fun i j => H i j + pv i j + pv (i - 1) j with hHv
  set Vv : ZMod L → ZMod L → R := fun i j => V i j + pv i j + pv i (j - 1) with hVv
  -- `C^v` の縦辺係数は `j ≠ 0` で零、`j = 0` で `v`。
  have hVvval : ∀ i j, Vv i j = (∑ j', V (-1) j') * ringFundamentalColumnVertical i j := by
    intro i j
    have hstep := ringCyclicPartialSum_step htwo (V i) j
    simp only [hVv, hpv]
    unfold ringFundamentalColumnVertical
    split_ifs at hstep ⊢ with hj
    · rw [mul_one, ← hrow i, ← hstep]; ring
    · rw [mul_zero, ← hstep]; ring
  -- 各 `P_{i,j}` は頂点偶次数なので、`C^v` も頂点偶次数。
  have hevenv : ∀ i j, Hv i j + Hv i (j - 1) + Vv i j + Vv (i - 1) j = 0 := by
    intro i j
    simp only [hHv, hVv]
    linear_combination heven i j +
      (pv i j + pv (i - 1) j + pv i (j - 1) + pv (i - 1) (j - 1)) * htwo
  -- 縦辺係数を代入すると、横辺係数は行の中で一定。
  have hHshift : ∀ i j, Hv i j = Hv i (j - 1) := by
    intro i j
    have h1 := hVvval i j
    have h2 := hVvval (i - 1) j
    have h3 : ringFundamentalColumnVertical (L := L) (R := R) (i - 1) j =
        ringFundamentalColumnVertical i j := rfl
    rw [h3] at h2
    linear_combination hevenv i j - h1 - h2 -
      (Hv i (j - 1) + (∑ j', V (-1) j') * ringFundamentalColumnVertical i j) * htwo
  -- 行 `i` に共通な係数 `a_i`。
  set a : ZMod L → R := fun i => Hv i 0 with ha
  have hHa : ∀ i j, Hv i j = a i := fun i j => ringCyclic_const_of_pred (Hv i) (hHshift i) j
  -- `Σ_i a_i = h`（正方形境界は切断線の横辺を偶数回含む）。
  have hsuma : ∑ i, a i = ∑ i', H i' (-1) := by
    have hshiftpv : ∑ i, pv (i - 1) (-1) = ∑ i, pv i (-1) :=
      (Equiv.subRight (1 : ZMod L)).sum_comp (fun i => pv i (-1))
    calc ∑ i, a i = ∑ i, Hv i (-1) := by simp only [hHa]
      _ = ∑ i, H i (-1) + ∑ i, pv i (-1) + ∑ i, pv (i - 1) (-1) := by
        simp only [hHv, sum_add_distrib]
      _ = ∑ i', H i' (-1) := by
        rw [hshiftpv]; linear_combination (∑ i, pv i (-1)) * htwo
  -- `q_i := Σ_{r=1}^{i} a_r`。`C^h := C^v + Σ_i q_i Σ_j P_{i,j}` の横辺係数は `h R_h`。
  set q : ZMod L → R := ringCyclicPartialSum a with hq
  have hqrow : ∀ i, a i + q (i - 1) + q i =
      (∑ i', H i' (-1)) * ringFundamentalRowHorizontal i (0 : ZMod L) := by
    intro i
    have hstep := ringCyclicPartialSum_step htwo a i
    unfold ringFundamentalRowHorizontal
    split_ifs at hstep ⊢ with hi
    · rw [mul_one, ← hsuma, ← hstep]
    · rw [mul_zero, ← hstep]
  -- 両側へ加えた正方形境界をもう一度加えて消し、`p_{i,j} := p^v_{i,j} + q_i` と置く。
  refine ⟨fun i j => pv i j + q i, ?_, ?_⟩
  · intro i j
    rw [ringSum_mul_squareBoundaryHorizontal]
    have e1 : Hv i j = a i := hHa i j
    simp only [hHv] at e1
    have e2 := hqrow i
    have e3 : ringFundamentalRowHorizontal (L := L) (R := R) i j =
        ringFundamentalRowHorizontal i 0 := rfl
    rw [e3]
    linear_combination e1 + e2 - (pv i j + pv (i - 1) j + q i + q (i - 1)) * htwo
  · intro i j
    rw [ringSum_mul_squareBoundaryVertical]
    have e1 := hVvval i j
    simp only [hVv] at e1
    linear_combination e1 - (pv i j + pv i (j - 1) + q i) * htwo

end Ising2DLambda.NecSuf.KacWard
