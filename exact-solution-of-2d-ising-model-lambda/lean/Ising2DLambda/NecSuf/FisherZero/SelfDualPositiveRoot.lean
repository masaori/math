/-
「正の根の特定」の必要十分版。
値の表示、正錐への所属、二根の場合分けだけを要求し、体・順序・二次体の構造を要求しない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 本文の表示を同じ五等号で構成する。体や加法の法則は不要であり、
一とその負号の保存、および指定された s での左単位元だけを用いる。 -/
theorem selfDualRootPlus_mem_necSuf
    {A K : Type*} [One A] [Neg A] [One K] [Neg K] [Add K] [Mul K]
    (j : A → K) (s : K) (hOne : j 1 = 1) (hNegOne : j (-1) = -(j 1))
    (hOneMul : (1 : K) * s = s) :
    ∃ a b : A, -1 + s = j a + j b * s := by
  refine ⟨-1, 1, ?_⟩
  calc
    -1 + s = (-(1 : K)) + s := rfl
    _ = (-(j 1)) + s := congrArg (fun x : K => -x + s) hOne.symm
    _ = j (-1) + s := congrArg (fun x : K => x + s) hNegOne.symm
    _ = j (-1) + 1 * s := congrArg (fun x : K => j (-1) + x) hOneMul.symm
    _ = j (-1) + j 1 * s := congrArg (fun x : K => j (-1) + x * s) hOne.symm

/-- 根の表示復元、包含の一・負号保存、左単位元則を本文の五等号へ対応させる。
表示の一意性は二つの係数を比較するために必要であり、表示の結論は仮定しない。
体構造と平方根の関係は一意性を与える側でのみ必要となる。 -/
theorem selfDualRootPlus_representation_necSuf
    {A K : Type*} [One A] [Neg A] [One K] [Neg K] [Add K] [Mul K]
    (j : A → K) (s : K) (p : A × A)
    (hSpec : -1 + s = j p.1 + j p.2 * s)
    (hOne : j 1 = 1) (hNegOne : j (-1) = -(j 1))
    (hOneMul : (1 : K) * s = s)
    (hUnique : ∀ a b c d : A,
      j a + j b * s = j c + j d * s → a = c ∧ b = d) :
    p = (-1, 1) := by
  have hvalue : j p.1 + j p.2 * s = j (-1) + j 1 * s := calc
    _ = -1 + s := hSpec.symm
    _ = (-(j 1)) + s := congrArg (fun x : K => -x + s) hOne.symm
    _ = j (-1) + s := congrArg (fun x : K => x + s) hNegOne.symm
    _ = j (-1) + 1 * s := congrArg (fun x : K => j (-1) + x) hOneMul.symm
    _ = j (-1) + j 1 * s := congrArg (fun x : K => j (-1) + x * s) hOne.symm
  have hcoeff := hUnique p.1 p.2 (-1) 1 hvalue
  exact Prod.ext hcoeff.1 hcoeff.2

theorem represented_value_mem_necSuf
    {A K : Type} (combine : A → A → K) (a b : A) :
    ∃ a' b' : A, combine a b = combine a' b' := by
  exact ⟨a, b, rfl⟩

theorem representation_of_value_necSuf
    {A K : Type} (combine : A → A → K) (rep : K → A × A)
    (hUnique : ∀ x a b, x = combine a b → rep x = (a, b))
    (a b : A) : rep (combine a b) = (a, b) := by
  exact hUnique (combine a b) a b rfl

theorem positive_of_representation_necSuf
    {A K : Type} (rep : K → A × A) (positive : A × A → Prop)
    (x : K) (a b : A) (hrep : rep x = (a, b)) (hab : positive (a, b)) :
    positive (rep x) := by
  rw [hrep]
  exact hab

theorem not_positive_of_representation_necSuf
    {A K : Type} (rep : K → A × A) (positive : A × A → Prop)
    (x : K) (a b : A) (hrep : rep x = (a, b)) (hab : ¬ positive (a, b)) :
    ¬ positive (rep x) := by
  rw [hrep]
  exact hab

theorem positive_root_unique_necSuf
    {K : Type} (rootPlus rootMinus x : K) (positive : K → Prop)
    (hroots : x = rootPlus ∨ x = rootMinus)
    (hxPositive : positive x) (hminus : ¬ positive rootMinus) :
    x = rootPlus := by
  rcases hroots with hplus | hminusEq
  · exact hplus
  · exfalso
    apply hminus
    rw [← hminusEq]
    exact hxPositive

end Ising2DLambda.NecSuf.FisherZero
