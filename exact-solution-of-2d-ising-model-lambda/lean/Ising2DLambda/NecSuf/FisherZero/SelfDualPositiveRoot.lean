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

/-- 減法の記法、一・負号の保存と指定した積の法則だけで係数を構成する。
体の構造も平方根の関係も、この所属の証明には要らない。 -/
theorem selfDualRootMinus_mem_necSuf
    {A K : Type*} [One A] [Neg A] [One K] [Neg K] [Add K] [Mul K] [Sub K]
    (j : A → K) (s : K) (hSub : (-1 : K) - s = -1 + (-s))
    (hOne : j 1 = 1) (hNegOne : j (-1) = -(j 1))
    (hOneMul : (1 : K) * s = s) (hNegMul : (-1 : K) * s = -(1 * s)) :
    ∃ a b : A, -1 - s = j a + j b * s := by
  refine ⟨-1, -1, ?_⟩
  calc
    -1 - s = -1 + (-s) := hSub
    _ = (-(j 1)) + (-s) := congrArg (fun x : K => -x + (-s)) hOne.symm
    _ = j (-1) + (-s) := congrArg (fun x : K => x + (-s)) hNegOne.symm
    _ = j (-1) + (-(1 * s)) := congrArg (fun x : K => j (-1) + (-x)) hOneMul.symm
    _ = j (-1) + ((-1) * s) := congrArg (fun x : K => j (-1) + x) hNegMul.symm
    _ = j (-1) + ((-(j 1)) * s) :=
      congrArg (fun x : K => j (-1) + (-x) * s) hOne.symm
    _ = j (-1) + j (-1) * s :=
      congrArg (fun x : K => j (-1) + x * s) hNegOne.symm

/-- 表示復元と係数一意性を、減法・包含保存・指定した積の法則で結ぶ。
平方根と体構造は一意性を供給する側だけで使い、係数対の結論は仮定しない。 -/
theorem selfDualRootMinus_representation_necSuf
    {A K : Type*} [One A] [Neg A] [One K] [Neg K] [Add K] [Mul K] [Sub K]
    (j : A → K) (s : K) (p : A × A)
    (hSpec : -1 - s = j p.1 + j p.2 * s)
    (hSub : (-1 : K) - s = -1 + (-s))
    (hOne : j 1 = 1) (hNegOne : j (-1) = -(j 1))
    (hOneMul : (1 : K) * s = s) (hNegMul : (-1 : K) * s = -(1 * s))
    (hUnique : ∀ a b c d : A,
      j a + j b * s = j c + j d * s → a = c ∧ b = d) :
    p = (-1, -1) := by
  have hvalue : j p.1 + j p.2 * s = j (-1) + j (-1) * s := calc
    _ = -1 - s := hSpec.symm
    _ = -1 + (-s) := hSub
    _ = (-(j 1)) + (-s) := congrArg (fun x : K => -x + (-s)) hOne.symm
    _ = j (-1) + (-s) := congrArg (fun x : K => x + (-s)) hNegOne.symm
    _ = j (-1) + (-(1 * s)) := congrArg (fun x : K => j (-1) + (-x)) hOneMul.symm
    _ = j (-1) + ((-1) * s) := congrArg (fun x : K => j (-1) + x) hNegMul.symm
    _ = j (-1) + ((-(j 1)) * s) :=
      congrArg (fun x : K => j (-1) + (-x) * s) hOne.symm
    _ = j (-1) + j (-1) * s :=
      congrArg (fun x : K => j (-1) + x * s) hNegOne.symm
  have hcoeff := hUnique p.1 p.2 (-1) (-1) hvalue
  exact Prod.ext hcoeff.1 hcoeff.2

/-- 正錐の第三条件を、表示と三つの基本比較、指定した積の法則から構成する。
比較の前後は等号なので順序の推移律は使わず、LT だけで足りる。
加法、体構造、全順序性は不要。第三条件の挿入は正錐の定義を接続する規則である。 -/
theorem positive_of_representation_necSuf
    {A K : Type*} [Zero A] [One A] [OfNat A 2] [Neg A] [Mul A] [LT A]
    (rep : K → A × A) (positive : A × A → Prop) (x : K)
    (hrep : rep x = (-1, 1))
    (hNeg : (-1 : A) < 0) (hPos : (0 : A) < 1) (hTwo : (1 : A) < 2)
    (hNegMul : (-1 : A) * (-1) = 1 * 1)
    (hOneMul : (1 : A) * 1 = 1) (hMulOne : (2 : A) * 1 = 2)
    (hAssoc : ∀ b : A, 2 * (b * b) = (2 * b) * b)
    (hThird : ∀ p : A × A,
      p.1 < 0 → 0 < p.2 → p.1 * p.1 < (2 * p.2) * p.2 → positive p) :
    positive (rep x) := by
  let p : A × A := rep x
  let a : A := p.1
  let b : A := p.2
  have ha : a = -1 := congrArg Prod.fst hrep
  have hb : b = 1 := congrArg Prod.snd hrep
  have haNeg : a < 0 := calc
    a = -1 := ha
    _ < 0 := hNeg
  have hbPos : 0 < b := calc
    (0 : A) < 1 := hPos
    _ = b := hb.symm
  have hSquare : a * a < (2 * b) * b := calc
    a * a = (-1) * (-1) := congrArg (fun t : A => t * t) ha
    _ = 1 * 1 := hNegMul
    _ = 1 := hOneMul
    _ < 2 := hTwo
    _ = 2 * 1 := hMulOne.symm
    _ = 2 * (1 * 1) := congrArg (fun t : A => 2 * t) hOneMul.symm
    _ = 2 * (b * b) := congrArg (fun t : A => 2 * (t * t)) hb.symm
    _ = (2 * b) * b := hAssoc b
  exact hThird p haNeg hbPos hSquare

/-- 正錐三条件から必要な符号を取り出し、それぞれを負の係数と矛盾させる。
乗法・全順序・体構造は不要。三条件の取り出しは正錐の定義仕様であり、
非所属の結論は仮定しない。順序の非両立性は三つの符号否定に必要。 -/
theorem not_positive_of_representation_necSuf
    {A K : Type*} [Zero A] [One A] [Neg A] [LE A] [LT A]
    (rep : K → A × A) (positive first second third : A × A → Prop) (x : K)
    (hrep : rep x = (-1, -1)) (hNeg : (-1 : A) < 0)
    (hNotLe : ∀ a : A, a < 0 → ¬ 0 ≤ a)
    (hNotLt : ∀ a : A, a < 0 → ¬ 0 < a)
    (hFirstSign : ∀ p, first p → 0 ≤ p.1)
    (hSecondSign : ∀ p, second p → 0 < p.1)
    (hThirdSign : ∀ p, third p → 0 < p.2)
    (hCases : ∀ p, positive p → first p ∨ second p ∨ third p) :
    ¬ positive (rep x) := by
  let p : A × A := rep x
  let a : A := p.1
  let b : A := p.2
  have ha : a = -1 := congrArg Prod.fst hrep
  have hb : b = -1 := congrArg Prod.snd hrep
  have haNeg : a < 0 := calc
    a = -1 := ha
    _ < 0 := hNeg
  have hbNeg : b < 0 := calc
    b = -1 := hb
    _ < 0 := hNeg
  have haNotNonneg : ¬ 0 ≤ a := hNotLe a haNeg
  have haNotPos : ¬ 0 < a := hNotLt a haNeg
  have hbNotPos : ¬ 0 < b := hNotLt b hbNeg
  have hFirst : ¬ first p := fun h => haNotNonneg (hFirstSign p h)
  have hSecond : ¬ second p := fun h => haNotPos (hSecondSign p h)
  have hThird : ¬ third p := fun h => hbNotPos (hThirdSign p h)
  intro hPositive
  rcases hCases p hPositive with hfirst | hsecond | hthird
  · exact hFirst hfirst
  · exact hSecond hsecond
  · exact hThird hthird

/-- 二つの等式による場合分けと述語への代入だけを使う。
体・順序・多項式は不要。二根の被覆、対象の所属、負根の非所属は、
それぞれ場合分け、所属の移送、矛盾の導出に必要である。 -/
theorem positive_root_unique_necSuf
    {K : Type} (rootPlus rootMinus x : K) (positive : K → Prop)
    (hroots : x = rootPlus ∨ x = rootMinus)
    (hxPositive : positive x) (hminus : ¬ positive rootMinus) :
    x = rootPlus := by
  rcases hroots with hplus | hminusEq
  · exact hplus
  · -- 本文と同じく、所属の移送・非所属・矛盾の順に置く。
    have hminusPositive : positive rootMinus := hminusEq ▸ hxPositive
    have hminusNotPositive : ¬ positive rootMinus := hminus
    have hcontradiction : False := hminusNotPositive hminusPositive
    exact hcontradiction.elim

end Ising2DLambda.NecSuf.FisherZero
