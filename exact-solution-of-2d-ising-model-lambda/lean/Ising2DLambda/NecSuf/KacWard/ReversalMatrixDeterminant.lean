/-
反転置換行列の行列式の必要十分版。
有限型 B は二方向の組を数えるためだけに使い、線型順序は転倒数の符号を
定義するためだけに使う。格子・端点・辺長・B 自体の順序は要求しない。
濃度の偶性を除くと組が一つの場合に行列式が -1 になるため、偶性は削れない。
互換分解、符号の積、反転以外の零項、行指定展開の順序は具体版と同じである。
-/
import Ising2DLambda.IntegerMatrix.Determinant

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators
open Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 各組の第二成分を反転する。 -/
def pairedReversal (B : Type*) (x : B × Bool) : B × Bool := (x.1, !x.2)

def pairedReversalPerm (B : Type*) : Equiv.Perm (B × Bool) where
  toFun := pairedReversal B
  invFun := pairedReversal B
  left_inv x := by rcases x with ⟨b, d⟩; cases d <;> rfl
  right_inv x := by rcases x with ⟨b, d⟩; cases d <;> rfl

private theorem pairedReversal_ne (B : Type*) (x : B × Bool) :
    pairedReversalPerm B x ≠ x := by
  rcases x with ⟨b, d⟩
  intro h
  have hd := congrArg Prod.snd h
  cases d <;> exact Bool.noConfusion hd

variable {B : Type*} [Fintype B] [LinearOrder (B × Bool)]

/-- 実際に定義した二方向反転の整数置換行列。 -/
def pairedReversalMatrix (B : Type*) [DecidableEq (B × Bool)] :
    IntegerMatrix.Square (B × Bool) :=
  fun e f => if f = pairedReversal B e then 1 else 0

/-- B の一つの要素に付く二方向だけを交換する。 -/
def pairedTransposition (e : B) : Equiv.Perm (B × Bool) :=
  transpositionPerm (e, false) (e, true)

private def pairedSupport (e : B) : Finset (B × Bool) :=
  {(e, false), (e, true)}

omit [Fintype B] in
private theorem mem_pairedSupport (e : B) (x : B × Bool) :
    x ∈ pairedSupport e ↔ x.1 = e := by
  constructor
  · intro hx
    rcases Finset.mem_insert.mp hx with hx | hx
    · exact congrArg (fun y : B × Bool => y.1) hx
    · exact congrArg (fun y : B × Bool => y.1) (Finset.mem_singleton.mp hx)
  · intro hx
    rcases x with ⟨f, d⟩
    change f = e at hx
    subst f
    cases d
    · exact Finset.mem_insert_self _ _
    · exact Finset.mem_insert_of_mem (Finset.mem_singleton_self _)

omit [Fintype B] in
private theorem pairedSupport_disjoint {e f : B} (hef : e ≠ f) :
    Disjoint (pairedSupport e) (pairedSupport f) := by
  apply Finset.disjoint_left.mpr
  intro x he hf
  exact hef (((mem_pairedSupport e x).mp he).symm.trans
    ((mem_pairedSupport f x).mp hf))

omit [Fintype B] in
private theorem pairedTransposition_local (e : B) (x : B × Bool)
    (hx : x ∈ pairedSupport e) : pairedTransposition e x = pairedReversalPerm B x := by
  have he : x.1 = e := (mem_pairedSupport e x).mp hx
  rcases x with ⟨f, d⟩
  change f = e at he
  subst f
  cases d <;> simp [pairedTransposition, transpositionPerm, transpositionOn,
    pairedReversalPerm, pairedReversal]

omit [Fintype B] in
private theorem pairedTransposition_outside (e : B) (x : B × Bool)
    (hx : x ∉ pairedSupport e) : pairedTransposition e x = x := by
  apply transpositionPerm_apply_of_ne
  · intro he
    exact hx ((mem_pairedSupport e x).mpr (by rw [he]))
  · intro he
    exact hx ((mem_pairedSupport e x).mpr (by rw [he]))

omit [Fintype B] in
private theorem pairedTransposition_stays (e : B) (x : B × Bool)
    (hx : x ∈ pairedSupport e) : pairedTransposition e x ∈ pairedSupport e := by
  rw [pairedTransposition_local e x hx]
  apply (mem_pairedSupport e _).mpr
  exact (mem_pairedSupport e x).mp hx

private theorem pairedSupports_cover (x : B × Bool) :
    pairedReversalPerm B x ≠ x ↔ ∃ e ∈ (Finset.univ : Finset B), x ∈ pairedSupport e := by
  constructor
  · intro _
    exact ⟨x.1, Finset.mem_univ _, (mem_pairedSupport x.1 x).mpr rfl⟩
  · intro _
    exact pairedReversal_ne B x

/-- B の相異なる要素の互換は互いに素な二点を動かすため可換である。 -/
theorem pairedTranspositions_pairwise_commute (B : Type*) [Fintype B] [LinearOrder (B × Bool)] :
    ((Finset.univ : Finset B) : Set B).Pairwise
      (fun e f => Commute (pairedTransposition e) (pairedTransposition f)) := by
  classical
  intro e _ f _ hef
  apply commute_of_disjoint_supports pairedSupport pairedTransposition
    (pairedSupport_disjoint hef)
  · intro d _ x hx
    exact pairedTransposition_stays d x hx
  · intro d _ x hx
    exact pairedTransposition_outside d x hx

/-- 反転は各二点の組の互換をすべて合成した置換である。 -/
theorem pairedReversalPerm_eq_transpositionProduct (B : Type*) [Fintype B] [LinearOrder (B × Bool)] :
    pairedReversalPerm B = (Finset.univ : Finset B).noncommProd
      pairedTransposition (pairedTranspositions_pairwise_commute B) := by
  classical
  symm
  apply noncommProd_eq_of_disjoint_supports Finset.univ pairedSupport
    pairedTransposition (pairedTranspositions_pairwise_commute B)
  · intro e _ f _ hef
    exact pairedSupport_disjoint hef
  · intro e _ x hx
    exact pairedTransposition_local e x hx
  · intro e _ x hx
    exact pairedTransposition_outside e x hx
  · exact pairedSupports_cover

/-- 各二点の互換の符号を掛けると、反転の符号は `(-1)^|B|` になる。 -/
theorem pairedReversalPerm_sign (B : Type*) [Fintype B] [LinearOrder (B × Bool)] :
    sign (fun e f : B × Bool => e < f) (pairedReversalPerm B) = (-1 : ℤ) ^ Fintype.card B := by
  calc
    sign (fun e f : B × Bool => e < f) (pairedReversalPerm B) =
        sign (fun e f : B × Bool => e < f)
          ((Finset.univ : Finset B).noncommProd pairedTransposition
            (pairedTranspositions_pairwise_commute B)) := by
      rw [← pairedReversalPerm_eq_transpositionProduct]
    _ = ∏ e ∈ (Finset.univ : Finset B),
        sign (fun x y : B × Bool => x < y) (pairedTransposition e) :=
      sign_noncommProd _ trichotomous_of_linearOrder _ _ _
    _ = ∏ _e ∈ (Finset.univ : Finset B), (-1 : ℤ) := by
      apply Finset.prod_congr rfl
      intro e _
      exact sign_transposition (α := (B × Bool)) (e, false) (e, true) (by
        intro h
        have hd := congrArg (fun x : B × Bool => x.2) h
        exact Bool.noConfusion hd)
    _ = (-1 : ℤ) ^ (Finset.univ : Finset B).card := Finset.prod_const _
    _ = (-1 : ℤ) ^ Fintype.card B := by rw [Finset.card_univ]

/-- 本文の行指定置換展開では、反転置換の項以外は零になる。 -/
theorem pairedReversalMatrix_determinant_of_even (B : Type*) [Fintype B] [LinearOrder (B × Bool)]
    (hcard : Even (Fintype.card B)) :
    IntegerMatrix.determinant (pairedReversalMatrix B) = 1 := by
  obtain ⟨m, hm⟩ := hcard
  have hsign : sign (fun e f : B × Bool => e < f) (pairedReversalPerm B) = 1 := by
    calc
      sign (fun e f : B × Bool => e < f) (pairedReversalPerm B) =
          (-1 : ℤ) ^ Fintype.card B := pairedReversalPerm_sign B
      _ = (-1 : ℤ) ^ (m + m) := by rw [hm]
      _ = (-1 : ℤ) ^ (2 * m) := by rw [two_mul]
      _ = ((-1 : ℤ) ^ 2) ^ m := pow_mul _ _ _
      _ = (1 : ℤ) ^ m := by rw [neg_one_sq]
      _ = 1 := one_pow _
  have hzero (σ : Equiv.Perm (B × Bool)) (hσ : σ ≠ pairedReversalPerm B) :
      sign (fun e f : B × Bool => e < f) σ *
        ∏ e, pairedReversalMatrix B e (σ e) = 0 := by
    obtain ⟨e, he⟩ : ∃ e, σ e ≠ pairedReversalPerm B e := by
      classical
      by_contra h
      push Not at h
      exact hσ (Equiv.ext h)
    have hentry : pairedReversalMatrix B e (σ e) = 0 := if_neg he
    have hproduct : (∏ e, pairedReversalMatrix B e (σ e)) = 0 :=
      Finset.prod_eq_zero (Finset.mem_univ e) hentry
    calc
      sign (fun e f : B × Bool => e < f) σ *
          ∏ e, pairedReversalMatrix B e (σ e) =
          sign (fun e f : B × Bool => e < f) σ * 0 := by rw [hproduct]
      _ = 0 := mul_zero _
  calc
    IntegerMatrix.determinant (pairedReversalMatrix B) =
        ∑ σ : Equiv.Perm (B × Bool),
          sign (fun e f : B × Bool => e < f) σ *
            ∏ e, pairedReversalMatrix B e (σ e) :=
      IntegerMatrix.determinant_eq_signedPermutationSum _
    _ = sign (fun e f : B × Bool => e < f) (pairedReversalPerm B) *
        ∏ e, pairedReversalMatrix B e (pairedReversalPerm B e) :=
      Fintype.sum_eq_single (pairedReversalPerm B) hzero
    _ = sign (fun e f : B × Bool => e < f) (pairedReversalPerm B) *
        ∏ _e : B × Bool, (1 : ℤ) := by
      congr 1
      apply Finset.prod_congr rfl
      intro e _
      exact if_pos rfl
    _ = sign (fun e f : B × Bool => e < f) (pairedReversalPerm B) * 1 := by
      rw [Finset.prod_const_one]
    _ = sign (fun e f : B × Bool => e < f) (pairedReversalPerm B) := mul_one _
    _ = 1 := hsign

end Ising2DLambda.NecSuf.KacWard
