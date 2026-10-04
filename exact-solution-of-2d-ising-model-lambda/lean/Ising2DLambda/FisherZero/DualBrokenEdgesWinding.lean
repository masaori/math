/-
「破れた辺の双対像の二つの巻き付き偶奇は零である」の具体版。
双対境界の指示子を原像へ移し、自然数の和と余りで本文の二つの計算列を検証する。
-/
import Ising2DLambda.FisherZero.DualBrokenEdgesEven
import Ising2DLambda.FisherZero.TorusHomologySector

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 本文の c(+1)=0、c(-1)=1。自然数の値は `.val` で明示的に取り出す。 -/
def spinBinaryCode (s : SpinValue) : Fin 2 := if s.1 = -1 then 1 else 0

lemma spinBinaryCode_injective : Function.Injective spinBinaryCode := by
  rintro ⟨s, rfl | rfl⟩ ⟨t, rfl | rfl⟩ h <;> simp_all [spinBinaryCode]

/-- 本文の準備式：両端の四つの場合による破れ指示子の符号化。 -/
lemma brokenEdge_binary_encoding (L : ℕ) [NeZero L] (sigma : Config L) (e : Edge L) :
    (if e ∈ brokenEdgeSet L sigma then (1 : ℕ) else 0) =
      ((spinBinaryCode (sigma (boundary0 L e))).val +
        (spinBinaryCode (sigma (boundary1 L e))).val) % 2 := by
  simp only [brokenEdgeSet, mem_filter, mem_univ, true_and]
  rcases sigma (boundary0 L e) with ⟨s, rfl | rfl⟩ <;>
    rcases sigma (boundary1 L e) with ⟨t, rfl | rfl⟩ <;>
    norm_num [spinBinaryCode]
  all_goals
    intro h
    have hv := congrArg (fun s : SpinValue => s.1) h
    norm_num at hv

/-- Fin 2 の和から本文の自然数の和と余りへ移す、値写像の明示的な対応。 -/
private lemma finTwo_indicator_sum_val {ι : Type*} [Fintype ι]
    (p : ι → Prop) [DecidablePred p] :
    (∑ i : ι, if p i then (1 : Fin 2) else 0).val =
      (∑ i : ι, if p i then (1 : ℕ) else 0) % 2 := by
  classical
  have hsum (s : Finset ι) :
      (∑ i ∈ s, if p i then (1 : Fin 2) else 0).val =
        (∑ i ∈ s, if p i then (1 : ℕ) else 0) % 2 := by
    induction s using Finset.induction_on with
    | empty => simp
    | @insert a s ha ih =>
      rw [sum_insert ha, sum_insert ha, Fin.val_add, ih]
      by_cases h : p a <;> simp [h, Nat.add_mod]
  exact hsum univ

/-- 横方向の鎖の先頭四行：定義、双対原像、逆写像、巡回再添字付け。 -/
lemma horizontalWindingParity_dualBrokenEdgeSet_val (L : ℕ) [NeZero L]
    (sigma : Config L) :
    (horizontalWindingParity L (dualBrokenEdgeSet L sigma)).val =
      (∑ i : ZMod L, if edgeOfRow L true i (-1) ∈ brokenEdgeSet L sigma
        then (1 : ℕ) else 0) % 2 := by
  calc
    _ = (∑ i : ZMod L, if edgeOfRow L false i (-1) ∈ dualBrokenEdgeSet L sigma
        then (1 : ℕ) else 0) % 2 := finTwo_indicator_sum_val _
    _ = (∑ i : ZMod L, if (dualEdgeEquiv L).symm (edgeOfRow L false i (-1)) ∈
        brokenEdgeSet L sigma then (1 : ℕ) else 0) % 2 := by
      simp_rw [mem_dualBrokenEdgeSet_iff]
    _ = (∑ i : ZMod L, if edgeOfRow L true (i - 1) (-1) ∈ brokenEdgeSet L sigma
        then (1 : ℕ) else 0) % 2 := by simp_rw [dualEdgeEquiv_symm_horizontal]
    _ = _ := by
      exact congrArg (· % 2) (Equiv.sum_comp (Equiv.subRight (1 : ZMod L))
        (fun i => if edgeOfRow L true i (-1) ∈ brokenEdgeSet L sigma then (1 : ℕ) else 0))

/-- 縦方向の鎖の先頭四行：定義、双対原像、逆写像、巡回再添字付け。 -/
lemma verticalWindingParity_dualBrokenEdgeSet_val (L : ℕ) [NeZero L]
    (sigma : Config L) :
    (verticalWindingParity L (dualBrokenEdgeSet L sigma)).val =
      (∑ j : ZMod L, if edgeOfRow L false (-1) j ∈ brokenEdgeSet L sigma
        then (1 : ℕ) else 0) % 2 := by
  calc
    _ = (∑ j : ZMod L, if edgeOfRow L true (-1) j ∈ dualBrokenEdgeSet L sigma
        then (1 : ℕ) else 0) % 2 := finTwo_indicator_sum_val _
    _ = (∑ j : ZMod L, if (dualEdgeEquiv L).symm (edgeOfRow L true (-1) j) ∈
        brokenEdgeSet L sigma then (1 : ℕ) else 0) % 2 := by
      simp_rw [mem_dualBrokenEdgeSet_iff]
    _ = (∑ j : ZMod L, if edgeOfRow L false (-1) (j - 1) ∈ brokenEdgeSet L sigma
        then (1 : ℕ) else 0) % 2 := by simp_rw [dualEdgeEquiv_symm_vertical]
    _ = _ := by
      exact congrArg (· % 2) (Equiv.sum_comp (Equiv.subRight (1 : ZMod L))
        (fun j => if edgeOfRow L false (-1) j ∈ brokenEdgeSet L sigma then (1 : ℕ) else 0))

/-- 横方向の本文の鎖を自然数で計算する。必要十分版を呼ばない。 -/
lemma horizontalWindingParity_dualBrokenEdgeSet_zero (L : ℕ) [NeZero L]
    (sigma : Config L) : horizontalWindingParity L (dualBrokenEdgeSet L sigma) = 0 := by
  apply Fin.ext
  calc
    _ = (∑ i : ZMod L, if edgeOfRow L true i (-1) ∈ brokenEdgeSet L sigma
        then (1 : ℕ) else 0) % 2 := horizontalWindingParity_dualBrokenEdgeSet_val L sigma
    _ = (∑ i : ZMod L,
        ((spinBinaryCode (sigma (boundary0 L (edgeOfRow L true i (-1))))).val +
        (spinBinaryCode (sigma (boundary1 L (edgeOfRow L true i (-1))))).val) % 2) % 2 := by
      simp_rw [brokenEdge_binary_encoding]
    _ = (∑ i : ZMod L,
        ((spinBinaryCode (sigma (i, -1))).val +
        (spinBinaryCode (sigma (i + 1, -1))).val) % 2) % 2 := by
      simp_rw [edgeOfRow_boundary0, edgeOfRow_boundary1_vertical]
    _ = (∑ i : ZMod L, ((spinBinaryCode (sigma (i, -1))).val +
        (spinBinaryCode (sigma (i + 1, -1))).val)) % 2 :=
      (sum_nat_mod univ 2 _).symm
    _ = ((∑ i : ZMod L, (spinBinaryCode (sigma (i, -1))).val) +
        (∑ i : ZMod L, (spinBinaryCode (sigma (i + 1, -1))).val)) % 2 := by
      rw [sum_add_distrib]
    _ = ((∑ i : ZMod L, (spinBinaryCode (sigma (i, -1))).val) +
        (∑ i : ZMod L, (spinBinaryCode (sigma (i, -1))).val)) % 2 := by
      exact congrArg (fun n : ℕ =>
        ((∑ i : ZMod L, (spinBinaryCode (sigma (i, -1))).val) + n) % 2)
        (Equiv.sum_comp (Equiv.addRight (1 : ZMod L))
          (fun i => (spinBinaryCode (sigma (i, -1))).val))
    _ = (2 * ∑ i : ZMod L, (spinBinaryCode (sigma (i, -1))).val) % 2 := by rw [two_mul]
    _ = 0 := by simp

/-- 縦方向の本文の鎖を自然数で計算する。必要十分版を呼ばない。 -/
lemma verticalWindingParity_dualBrokenEdgeSet_zero (L : ℕ) [NeZero L]
    (sigma : Config L) : verticalWindingParity L (dualBrokenEdgeSet L sigma) = 0 := by
  apply Fin.ext
  calc
    _ = (∑ j : ZMod L, if edgeOfRow L false (-1) j ∈ brokenEdgeSet L sigma
        then (1 : ℕ) else 0) % 2 := verticalWindingParity_dualBrokenEdgeSet_val L sigma
    _ = (∑ j : ZMod L,
        ((spinBinaryCode (sigma (boundary0 L (edgeOfRow L false (-1) j)))).val +
        (spinBinaryCode (sigma (boundary1 L (edgeOfRow L false (-1) j)))).val) % 2) % 2 := by
      simp_rw [brokenEdge_binary_encoding]
    _ = (∑ j : ZMod L,
        ((spinBinaryCode (sigma (-1, j))).val +
        (spinBinaryCode (sigma (-1, j + 1))).val) % 2) % 2 := by
      simp_rw [edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal]
    _ = (∑ j : ZMod L, ((spinBinaryCode (sigma (-1, j))).val +
        (spinBinaryCode (sigma (-1, j + 1))).val)) % 2 :=
      (sum_nat_mod univ 2 _).symm
    _ = ((∑ j : ZMod L, (spinBinaryCode (sigma (-1, j))).val) +
        (∑ j : ZMod L, (spinBinaryCode (sigma (-1, j + 1))).val)) % 2 := by
      rw [sum_add_distrib]
    _ = ((∑ j : ZMod L, (spinBinaryCode (sigma (-1, j))).val) +
        (∑ j : ZMod L, (spinBinaryCode (sigma (-1, j))).val)) % 2 := by
      exact congrArg (fun n : ℕ =>
        ((∑ j : ZMod L, (spinBinaryCode (sigma (-1, j))).val) + n) % 2)
        (Equiv.sum_comp (Equiv.addRight (1 : ZMod L))
          (fun j => (spinBinaryCode (sigma (-1, j))).val))
    _ = (2 * ∑ j : ZMod L, (spinBinaryCode (sigma (-1, j))).val) % 2 := by rw [two_mul]
    _ = 0 := by simp

/-- `claim_dual_broken_edges_winding_zero` の具体版。 -/
theorem dualBrokenEdgeSet_winding_zero (L : ℕ) [NeZero L] (sigma : Config L) :
    torusHomologySector L (dualBrokenEdgeSet L sigma) = (0, 0) := by
  exact Prod.ext (horizontalWindingParity_dualBrokenEdgeSet_zero L sigma)
    (verticalWindingParity_dualBrokenEdgeSet_zero L sigma)

end Ising2DLambda.FisherZero
