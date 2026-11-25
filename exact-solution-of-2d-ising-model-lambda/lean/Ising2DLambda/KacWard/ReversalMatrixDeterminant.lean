/-
反転置換行列の行列式は一である。
実際の向き付き辺を、台の辺ごとに二点の組へ分ける。各組の互換の合成が
反転そのものであることを確かめ、符号の積と唯一の非零置換項を順に計算する。
-/
import Ising2DLambda.IntegerMatrix.Determinant
import Ising2DLambda.KacWard.ReversalMatrix
import Ising2DLambda.KacWard.TranspositionSignFiniteOrderedSet
import Mathlib.Data.Prod.Lex

namespace Ising2DLambda.KacWard

open scoped BigOperators
open Ising2DLambda.PartitionPolynomial
open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign

/-- 辺の番号、向きの順に比較する辞書式順序。 -/
instance orientedEdgeLinearOrder (L : ℕ) : LinearOrder (OrientedEdge L) :=
  inferInstanceAs (LinearOrder (Fin (2 * L ^ 2) ×ₗ Bool))

/-- 内部の辺番号を一だけ増やす本文の番号付けでも、この比較は変わらない。 -/
theorem orientedEdge_lt_iff (L : ℕ) (e f : OrientedEdge L) :
    e < f ↔ e.1.val < f.1.val ∨ e.1 = f.1 ∧ e.2 < f.2 := by
  exact Prod.Lex.toLex_lt_toLex (α := Fin (2 * L ^ 2)) (β := Bool)

/-- 既存の反転写像を、その対合性によって置換として表す。 -/
def reversalPerm (L : ℕ) : Equiv.Perm (OrientedEdge L) where
  toFun := reversal
  invFun := reversal
  left_inv := reversal_involutive
  right_inv := reversal_involutive

/-- 一つの台の辺に付く二方向だけを交換する。 -/
def edgeDirectionTransposition {L : ℕ} (e : Edge L) : Equiv.Perm (OrientedEdge L) :=
  finiteTranspositionPerm (e, false) (e, true)

private def edgeDirectionPair {L : ℕ} (e : Edge L) : Finset (OrientedEdge L) :=
  {(e, false), (e, true)}

private theorem mem_edgeDirectionPair {L : ℕ} (e : Edge L) (x : OrientedEdge L) :
    x ∈ edgeDirectionPair e ↔ x.1 = e := by
  constructor
  · intro hx
    rcases Finset.mem_insert.mp hx with hx | hx
    · exact congrArg (fun y : OrientedEdge L => y.1) hx
    · exact congrArg (fun y : OrientedEdge L => y.1) (Finset.mem_singleton.mp hx)
  · intro hx
    rcases x with ⟨f, d⟩
    change f = e at hx
    subst f
    cases d
    · exact Finset.mem_insert_self _ _
    · exact Finset.mem_insert_of_mem (Finset.mem_singleton_self _)


private theorem directionPair_disjoint {L : ℕ} {e f : Edge L} (hef : e ≠ f) :
    Disjoint (edgeDirectionPair e) (edgeDirectionPair f) := by
  apply Finset.disjoint_left.mpr
  intro x he hf
  exact hef (((mem_edgeDirectionPair e x).mp he).symm.trans
    ((mem_edgeDirectionPair f x).mp hf))

private theorem directionTransposition_local {L : ℕ} (e : Edge L) (x : OrientedEdge L)
    (hx : x ∈ edgeDirectionPair e) : edgeDirectionTransposition e x = reversalPerm L x := by
  have he : x.1 = e := (mem_edgeDirectionPair e x).mp hx
  rcases x with ⟨f, d⟩
  change f = e at he
  subst f
  cases d <;> simp [edgeDirectionTransposition, finiteTranspositionPerm_apply,
    finiteTransposition,
    reversalPerm, reversal]

private theorem directionTransposition_outside {L : ℕ} (e : Edge L) (x : OrientedEdge L)
    (hx : x ∉ edgeDirectionPair e) : edgeDirectionTransposition e x = x := by
  change finiteTransposition _ _ x = x
  apply finiteTransposition_apply_of_ne
  · intro he
    exact hx ((mem_edgeDirectionPair e x).mpr (by rw [he]))
  · intro he
    exact hx ((mem_edgeDirectionPair e x).mpr (by rw [he]))

private theorem directionTransposition_stays {L : ℕ} (e : Edge L) (x : OrientedEdge L)
    (hx : x ∈ edgeDirectionPair e) : edgeDirectionTransposition e x ∈ edgeDirectionPair e := by
  rw [directionTransposition_local e x hx]
  apply (mem_edgeDirectionPair e _).mpr
  exact (mem_edgeDirectionPair e x).mp hx

/-- 相異なる台の辺の互換は互いに素な二点を動かすため可換である。 -/
theorem edgeDirectionTranspositions_pairwise_commute (L : ℕ) :
    ((Finset.univ : Finset (Edge L)) : Set (Edge L)).Pairwise
      (fun e f => Commute (edgeDirectionTransposition e) (edgeDirectionTransposition f)) := by
  intro e _ f _ hef
  have hdisj := directionPair_disjoint hef
  apply Equiv.ext
  intro x
  simp only [Equiv.Perm.mul_apply]
  by_cases hxe : x ∈ edgeDirectionPair e
  · have hxf : x ∉ edgeDirectionPair f :=
      fun hxf => Finset.disjoint_left.mp hdisj hxe hxf
    have htxe := directionTransposition_stays e x hxe
    have htxf : edgeDirectionTransposition e x ∉ edgeDirectionPair f :=
      fun h => Finset.disjoint_left.mp hdisj htxe h
    rw [directionTransposition_outside f x hxf,
      directionTransposition_outside f _ htxf]
  · by_cases hxf : x ∈ edgeDirectionPair f
    · have htxf := directionTransposition_stays f x hxf
      have htxe : edgeDirectionTransposition f x ∉ edgeDirectionPair e :=
        fun h => Finset.disjoint_left.mp hdisj h htxf
      rw [directionTransposition_outside e x hxe,
        directionTransposition_outside e _ htxe]
    · simp only [directionTransposition_outside e x hxe,
        directionTransposition_outside f x hxf]

/-- 反転は各辺の二方向の互換をすべて合成した置換である。 -/
theorem reversalPerm_eq_transpositionProduct (L : ℕ) :
    reversalPerm L = (Finset.univ : Finset (Edge L)).noncommProd
      edgeDirectionTransposition (edgeDirectionTranspositions_pairwise_commute L) := by
  classical
  apply Equiv.ext
  intro x
  let s : Finset (Edge L) := Finset.univ
  let comm : (s : Set (Edge L)).Pairwise
      (fun e f => Commute (edgeDirectionTransposition e) (edgeDirectionTransposition f)) :=
    edgeDirectionTranspositions_pairwise_commute L
  let commErase : ((s.erase x.1 : Finset (Edge L)) : Set (Edge L)).Pairwise
      (fun e f => Commute (edgeDirectionTransposition e) (edgeDirectionTransposition f)) :=
    fun _ he _ hf hne => comm (s.mem_of_mem_erase he) (s.mem_of_mem_erase hf) hne
  have hrest : ((s.erase x.1).noncommProd edgeDirectionTransposition commErase) x = x := by
    apply Finset.noncommProd_induction (s.erase x.1) edgeDirectionTransposition
      commErase (fun g => g x = x)
    · intro g h hg hh
      simp only [Equiv.Perm.mul_apply, hh, hg]
    · rfl
    · intro e he
      apply directionTransposition_outside e x
      intro hx
      have hex : x.1 = e := (mem_edgeDirectionPair e x).mp hx
      exact (Finset.mem_erase.mp he).1 hex.symm
  rw [← Finset.mul_noncommProd_erase s (Finset.mem_univ x.1)
    edgeDirectionTransposition comm]
  simp only [Equiv.Perm.mul_apply, hrest]
  exact (directionTransposition_local x.1 x
    ((mem_edgeDirectionPair x.1 x).mpr rfl)).symm

set_option maxHeartbeats 1000000
/-- 反転の符号は、互換の個数 `2L²` が偶数であることから一になる。 -/
theorem reversalPerm_sign (L : ℕ) :
    finiteOrderedSign (reversalPerm L) = 1 := by
  classical
  letI : LinearOrder (OrientedEdge L) := orientedEdgeLinearOrder L
  calc
    finiteOrderedSign (reversalPerm L) =
        finiteOrderedSign
          ((Finset.univ : Finset (Edge L)).noncommProd edgeDirectionTransposition
            (edgeDirectionTranspositions_pairwise_commute L)) := by
      rw [← reversalPerm_eq_transpositionProduct]
    _ = ∏ e ∈ (Finset.univ : Finset (Edge L)),
        finiteOrderedSign (edgeDirectionTransposition e) :=
      finiteOrderedSign_noncommProd _ _ _
    _ = ∏ _e ∈ (Finset.univ : Finset (Edge L)), (-1 : ℤ) := by
      apply Finset.prod_congr rfl
      intro e _
      have hperm : edgeDirectionTransposition e =
          finiteTranspositionPerm (J := OrientedEdge L) (e, false) (e, true) := by
        ext x
        rfl
      rw [hperm]
      exact finiteTransposition_sign (by
        intro h
        have hd := congrArg (fun x : OrientedEdge L => x.2) h
        exact Bool.noConfusion hd)
    _ = (-1 : ℤ) ^ (Finset.univ : Finset (Edge L)).card := Finset.prod_const _
    _ = (-1 : ℤ) ^ Fintype.card (Edge L) := by rw [Finset.card_univ]
    _ = (-1 : ℤ) ^ (2 * L ^ 2) := by rw [card_edge]
    _ = ((-1 : ℤ) ^ 2) ^ (L ^ 2) := pow_mul _ _ _
    _ = (1 : ℤ) ^ (L ^ 2) := by rw [neg_one_sq]
    _ = 1 := one_pow _
set_option maxHeartbeats 200000

/-- 本文の行指定置換展開では、反転置換の項以外は零になる。
反転が置換であること（本文「反転は置換である」）は、対合性から逆写像を自身に取って作る。 -/
theorem reversalMatrix_determinant (L : ℕ) :
    IntegerMatrix.determinant (reversalMatrix L) = 1 := by
  classical
  let ι : Equiv.Perm (OrientedEdge L) :=
    ⟨reversal, reversal, reversal_involutive, reversal_involutive⟩
  have hι : ι = reversalPerm L := rfl
  have hzero (σ : Equiv.Perm (OrientedEdge L)) (hσ : σ ≠ ι) :
      finiteOrderedSign σ *
        ∏ e, reversalMatrix L e (σ e) = 0 := by
    obtain ⟨e, he⟩ : ∃ e, σ e ≠ ι e := by
      by_contra h
      push Not at h
      exact hσ (Equiv.ext h)
    have hentry : reversalMatrix L e (σ e) = 0 := if_neg he
    have hproduct : (∏ e, reversalMatrix L e (σ e)) = 0 :=
      Finset.prod_eq_zero (Finset.mem_univ e) hentry
    calc
      finiteOrderedSign σ *
          ∏ e, reversalMatrix L e (σ e) =
          finiteOrderedSign σ * 0 := by rw [hproduct]
      _ = 0 := mul_zero _
  calc
    IntegerMatrix.determinant (reversalMatrix L) =
        ∑ σ : Equiv.Perm (OrientedEdge L),
          finiteOrderedSign σ *
            ∏ e, reversalMatrix L e (σ e) :=
      IntegerMatrix.determinant_eq_independentSignedPermutationSum _
    _ = finiteOrderedSign ι *
        ∏ e, reversalMatrix L e (ι e) :=
      Fintype.sum_eq_single ι hzero
    _ = finiteOrderedSign ι *
        ∏ _e : OrientedEdge L, (1 : ℤ) := by
      congr 1
      apply Finset.prod_congr rfl
      intro e _
      exact if_pos rfl
    _ = finiteOrderedSign ι * 1 := by
      rw [Finset.prod_const_one]
    _ = finiteOrderedSign ι := mul_one _
    _ = 1 := by rw [hι]; exact reversalPerm_sign L

end Ising2DLambda.KacWard
