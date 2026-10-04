/-
反転置換行列の行列式は一である。
実際の向き付き辺を、台の辺ごとに二点の組へ分ける。各組の互換の合成が
反転そのものであることを確かめ、符号の積と唯一の非零置換項を順に計算する。
-/
import Ising2DLambda.IntegerMatrix.Determinant
import Ising2DLambda.KacWard.ReversalMatrix
import Mathlib.Data.Prod.Lex

namespace Ising2DLambda.KacWard

open scoped BigOperators
open Ising2DLambda.PartitionPolynomial
open Ising2DLambda.NecSuf.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

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
  transpositionPerm (e, false) (e, true)

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
  cases d <;> simp [edgeDirectionTransposition, transpositionPerm, transpositionOn,
    reversalPerm, reversal, reverseBool]

private theorem directionTransposition_outside {L : ℕ} (e : Edge L) (x : OrientedEdge L)
    (hx : x ∉ edgeDirectionPair e) : edgeDirectionTransposition e x = x := by
  apply transpositionPerm_apply_of_ne
  · intro he
    exact hx ((mem_edgeDirectionPair e x).mpr (by rw [he]))
  · intro he
    exact hx ((mem_edgeDirectionPair e x).mpr (by rw [he]))

private theorem directionTransposition_stays {L : ℕ} (e : Edge L) (x : OrientedEdge L)
    (hx : x ∈ edgeDirectionPair e) : edgeDirectionTransposition e x ∈ edgeDirectionPair e := by
  rw [directionTransposition_local e x hx]
  apply (mem_edgeDirectionPair e _).mpr
  exact (mem_edgeDirectionPair e x).mp hx

private theorem directionPairs_cover {L : ℕ} (x : OrientedEdge L) :
    reversalPerm L x ≠ x ↔ ∃ e ∈ (Finset.univ : Finset (Edge L)), x ∈ edgeDirectionPair e := by
  constructor
  · intro _
    exact ⟨x.1, Finset.mem_univ _, (mem_edgeDirectionPair x.1 x).mpr rfl⟩
  · intro _
    exact reversal_ne x

/-- 相異なる台の辺の互換は互いに素な二点を動かすため可換である。 -/
theorem edgeDirectionTranspositions_pairwise_commute (L : ℕ) :
    ((Finset.univ : Finset (Edge L)) : Set (Edge L)).Pairwise
      (fun e f => Commute (edgeDirectionTransposition e) (edgeDirectionTransposition f)) := by
  intro e _ f _ hef
  apply commute_of_disjoint_supports edgeDirectionPair edgeDirectionTransposition
    (directionPair_disjoint hef)
  · intro d _ x hx
    exact directionTransposition_stays d x hx
  · intro d _ x hx
    exact directionTransposition_outside d x hx

/-- 反転は各辺の二方向の互換をすべて合成した置換である。 -/
theorem reversalPerm_eq_transpositionProduct (L : ℕ) :
    reversalPerm L = (Finset.univ : Finset (Edge L)).noncommProd
      edgeDirectionTransposition (edgeDirectionTranspositions_pairwise_commute L) := by
  symm
  apply noncommProd_eq_of_disjoint_supports Finset.univ edgeDirectionPair
    edgeDirectionTransposition (edgeDirectionTranspositions_pairwise_commute L)
  · intro e _ f _ hef
    exact directionPair_disjoint hef
  · intro e _ x hx
    exact directionTransposition_local e x hx
  · intro e _ x hx
    exact directionTransposition_outside e x hx
  · exact directionPairs_cover

/-- 反転の符号は、互換の個数 `2L²` が偶数であることから一になる。 -/
theorem reversalPerm_sign (L : ℕ) :
    sign (fun e f : OrientedEdge L => e < f) (reversalPerm L) = 1 := by
  calc
    sign (fun e f : OrientedEdge L => e < f) (reversalPerm L) =
        sign (fun e f : OrientedEdge L => e < f)
          ((Finset.univ : Finset (Edge L)).noncommProd edgeDirectionTransposition
            (edgeDirectionTranspositions_pairwise_commute L)) := by
      rw [← reversalPerm_eq_transpositionProduct]
    _ = ∏ e ∈ (Finset.univ : Finset (Edge L)),
        sign (fun x y : OrientedEdge L => x < y) (edgeDirectionTransposition e) :=
      sign_noncommProd _ trichotomous_of_linearOrder _ _ _
    _ = ∏ _e ∈ (Finset.univ : Finset (Edge L)), (-1 : ℤ) := by
      apply Finset.prod_congr rfl
      intro e _
      exact sign_transposition (α := OrientedEdge L) (e, false) (e, true) (by
        intro h
        have hd := congrArg (fun x : OrientedEdge L => x.2) h
        exact Bool.noConfusion hd)
    _ = (-1 : ℤ) ^ (Finset.univ : Finset (Edge L)).card := Finset.prod_const _
    _ = (-1 : ℤ) ^ Fintype.card (Edge L) := by rw [Finset.card_univ]
    _ = (-1 : ℤ) ^ (2 * L ^ 2) := by rw [card_edge]
    _ = ((-1 : ℤ) ^ 2) ^ (L ^ 2) := pow_mul _ _ _
    _ = (1 : ℤ) ^ (L ^ 2) := by rw [neg_one_sq]
    _ = 1 := one_pow _

/-- 本文の行指定置換展開では、反転置換の項以外は零になる。 -/
theorem reversalMatrix_determinant (L : ℕ) :
    IntegerMatrix.determinant (reversalMatrix L) = 1 := by
  classical
  have hzero (σ : Equiv.Perm (OrientedEdge L)) (hσ : σ ≠ reversalPerm L) :
      sign (fun e f : OrientedEdge L => e < f) σ *
        ∏ e, reversalMatrix L e (σ e) = 0 := by
    obtain ⟨e, he⟩ : ∃ e, σ e ≠ reversalPerm L e := by
      by_contra h
      push Not at h
      exact hσ (Equiv.ext h)
    have hentry : reversalMatrix L e (σ e) = 0 := if_neg he
    have hproduct : (∏ e, reversalMatrix L e (σ e)) = 0 :=
      Finset.prod_eq_zero (Finset.mem_univ e) hentry
    calc
      sign (fun e f : OrientedEdge L => e < f) σ *
          ∏ e, reversalMatrix L e (σ e) =
          sign (fun e f : OrientedEdge L => e < f) σ * 0 := by rw [hproduct]
      _ = 0 := mul_zero _
  calc
    IntegerMatrix.determinant (reversalMatrix L) =
        ∑ σ : Equiv.Perm (OrientedEdge L),
          sign (fun e f : OrientedEdge L => e < f) σ *
            ∏ e, reversalMatrix L e (σ e) :=
      IntegerMatrix.determinant_eq_signedPermutationSum _
    _ = sign (fun e f : OrientedEdge L => e < f) (reversalPerm L) *
        ∏ e, reversalMatrix L e (reversalPerm L e) :=
      Fintype.sum_eq_single (reversalPerm L) hzero
    _ = sign (fun e f : OrientedEdge L => e < f) (reversalPerm L) *
        ∏ _e : OrientedEdge L, (1 : ℤ) := by
      congr 1
      apply Finset.prod_congr rfl
      intro e _
      exact if_pos rfl
    _ = sign (fun e f : OrientedEdge L => e < f) (reversalPerm L) * 1 := by
      rw [Finset.prod_const_one]
    _ = sign (fun e f : OrientedEdge L => e < f) (reversalPerm L) := mul_one _
    _ = 1 := reversalPerm_sign L

end Ising2DLambda.KacWard
