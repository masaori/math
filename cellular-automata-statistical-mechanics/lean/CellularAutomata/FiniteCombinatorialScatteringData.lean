/-
正本: content/finite-combinatorial-scattering-data.ts の Lean 具体版。

SageMath 検算と同じ二元内部表について、部分作用表との可換性、
整数値表の差分条件、正規化を別々に示す。さらに、別の二元三型の
成分交換表と組ごとに一定な整数値表について、整数位相持ち上げの
Yang--Baxter 等式を示す。除算、対数、極限、実数体、複素数体は使わない。
-/
import Mathlib.Data.Int.Basic
import Mathlib.Tactic

namespace CellularAutomata.FiniteCombinatorialScatteringData

abbrev InternalState := Bool
abbrev Color := Bool
abbrev InternalPair := InternalState × InternalState

/-- SageMath 検算で固定した二元内部散乱表。 -/
def internalR : InternalPair → InternalPair := id

/-- SageMath 検算で固定した二つの部分作用表。 -/
def partialAction : Color → InternalPair → Option InternalPair
  | false, (false, false) => some (true, false)
  | false, (false, true) => some (true, true)
  | false, (true, false) => some (true, true)
  | true, (false, false) => some (true, true)
  | _, _ => none

inductive Side
  | left
  | right
  deriving DecidableEq

/-- 部分作用が定義される入力で、作用した因子を記録する表。 -/
def actionSide : Color → InternalPair → Side
  | false, (true, false) => .right
  | _, _ => .left

/-- SageMath 検算で固定した整数値表。 -/
def integerTable : InternalPair → ℤ
  | (false, false) => 0
  | (false, true) => -1
  | (true, false) => 1
  | (true, true) => 0

/-- 左右標識から定まる差分条件の右辺。 -/
def expectedDifference (i : Color) (u : InternalPair) : ℤ :=
  if i = false ∧ actionSide i u = .left ∧ actionSide i (internalR u) = .left then 1
  else if i = false ∧ actionSide i u = .right ∧ actionSide i (internalR u) = .right then -1
  else 0

/-- 固定した内部散乱表は全八入力で部分作用表と可換である。 -/
theorem internalR_operator_compatible (i : Color) (u : InternalPair) :
    Option.map internalR (partialAction i u) = partialAction i (internalR u) := by
  cases i <;> rcases u with ⟨x, y⟩ <;> cases x <;> cases y <;> rfl

/-- 部分作用が定義される全四入力で、整数差は指定された三分岐に一致する。 -/
theorem integerTable_difference_compatible (i : Color) (u v : InternalPair)
    (h : partialAction i u = some v) :
    integerTable v - integerTable u = expectedDifference i u := by
  cases i <;> rcases u with ⟨x, y⟩ <;> cases x <;> cases y <;>
    simp [partialAction] at h <;> subst v <;>
    simp [integerTable, expectedDifference, actionSide, internalR]

/-- 指定した基準入力における整数値表の正規化。 -/
theorem integerTable_normalized : integerTable (false, false) = 0 := by
  rfl

/-- 固定した有限表の三条件を互いに同一視せずまとめたもの。 -/
theorem fixed_internal_tables_compatible :
    (∀ i u, Option.map internalR (partialAction i u) = partialAction i (internalR u)) ∧
    (∀ i u v, partialAction i u = some v →
      integerTable v - integerTable u = expectedDifference i u) ∧
    integerTable (false, false) = 0 := by
  exact ⟨internalR_operator_compatible, integerTable_difference_compatible,
    integerTable_normalized⟩

inductive BState | zero | one
inductive CState | zero | one
inductive DState | zero | one

abbrev Affine (X : Type) := ℤ × X

/-- 内部成分を交換し、組に指定した整数だけ次数を移す持ち上げ。 -/
def affineSwap {X Y : Type} (energy : ℤ) :
    Affine X × Affine Y → Affine Y × Affine X :=
  fun ((degreeX, x), (degreeY, y)) =>
    ((degreeY + energy, y), (degreeX - energy, x))

def liftBC : Affine BState × Affine CState → Affine CState × Affine BState :=
  affineSwap 1

def liftBD : Affine BState × Affine DState → Affine DState × Affine BState :=
  affineSwap (-2)

def liftCD : Affine CState × Affine DState → Affine DState × Affine CState :=
  affineSwap 3

/-- 左辺の三つの型付き持ち上げを右から左へ適用する。 -/
def affineYangBaxterLeft :
    Affine BState × Affine CState × Affine DState →
      Affine DState × Affine CState × Affine BState :=
  fun (b, c, d) =>
    let (c', b') := liftBC (b, c)
    let (d', b'') := liftBD (b', d)
    let (d'', c'') := liftCD (c', d')
    (d'', c'', b'')

/-- 右辺の三つの型付き持ち上げを右から左へ適用する。 -/
def affineYangBaxterRight :
    Affine BState × Affine CState × Affine DState →
      Affine DState × Affine CState × Affine BState :=
  fun (b, c, d) =>
    let (d', c') := liftCD (c, d)
    let (d'', b') := liftBD (b, d')
    let (c'', b'') := liftBC (b', c')
    (d'', c'', b'')

/--
固定した二元三型の全内部入力と任意の整数次数について、二つの
三体合成は一致する。最終次数は順に `d_D + 1`, `d_C - 2`, `d_B + 1` である。
-/
theorem affine_yang_baxter (b : BState) (c : CState) (d : DState)
    (degreeB degreeC degreeD : ℤ) :
    affineYangBaxterLeft ((degreeB, b), (degreeC, c), (degreeD, d)) =
      affineYangBaxterRight ((degreeB, b), (degreeC, c), (degreeD, d)) ∧
    affineYangBaxterLeft ((degreeB, b), (degreeC, c), (degreeD, d)) =
      ((degreeD + 1, d), (degreeC - 2, c), (degreeB + 1, b)) := by
  constructor <;>
    simp [affineYangBaxterLeft, affineYangBaxterRight, liftBC, liftBD, liftCD,
      affineSwap] <;> omega

end CellularAutomata.FiniteCombinatorialScatteringData
