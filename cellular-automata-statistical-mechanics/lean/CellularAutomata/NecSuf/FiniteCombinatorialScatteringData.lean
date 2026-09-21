/-
正本: content/finite-combinatorial-scattering-data.ts の必要十分版。

有限全称判定に必要なのは、入力型の有限性と比較対象の等号判定だけである。
整数位相持ち上げの三体等式に必要なのは、三つの内部状態型と可換加法群値の
位相移動だけである。二元状態、整数、結晶、セル、局所規則、実数、複素数、
除算、対数、極限は一般定理には要らない。
-/
import CellularAutomata.FiniteCombinatorialScatteringData

namespace CellularAutomata.NecSuf.FiniteCombinatorialScatteringData

variable {I X D G B C E : Type*}

/-- 内部写像と部分作用表の可換性。 -/
def OperatorCompatible (r : X → X) (action : I → X → Option X) : Prop :=
  ∀ i u, Option.map r (action i u) = action i (r u)

/-- 部分作用表の定義域上で、値表の差が指定表と一致すること。 -/
def DifferenceCompatible (action : I → X → Option X)
    (value : X → D) (difference : D → D → D) (expected : I → X → D) : Prop :=
  ∀ i u v, action i u = some v → difference (value v) (value u) = expected i u

/-- 指定した一入力における値表の正規化。 -/
def NormalizedAt (value : X → D) (base : X) (target : D) : Prop :=
  value base = target

/-- 可換性の全称判定には、有限入力と状態の等号判定だけを要る。 -/
instance operatorCompatible_decidable [Fintype I] [Fintype X] [DecidableEq X]
    (r : X → X) (action : I → X → Option X) :
    Decidable (OperatorCompatible r action) := by
  unfold OperatorCompatible
  infer_instance

/-- 差分条件の全称判定には、有限入力と差の値域の等号判定だけを要る。 -/
instance differenceCompatible_decidable [Fintype I] [Fintype X] [DecidableEq X]
    [DecidableEq D] (action : I → X → Option X) (value : X → D)
    (difference : D → D → D) (expected : I → X → D) :
    Decidable (DifferenceCompatible action value difference expected) := by
  unfold DifferenceCompatible
  infer_instance

/-- 正規化条件の判定には値域の等号判定だけを要る。 -/
instance normalizedAt_decidable [DecidableEq D]
    (value : X → D) (base : X) (target : D) :
    Decidable (NormalizedAt value base target) := by
  unfold NormalizedAt
  infer_instance

abbrev Affine (G X : Type*) := G × X

/-- 可換加法群値の位相移動を伴う型付き成分交換。 -/
def affineSwap [AddCommGroup G] (energy : G) :
    Affine G B × Affine G C → Affine G C × Affine G B :=
  fun ((degreeB, b), (degreeC, c)) =>
    ((degreeC + energy, c), (degreeB - energy, b))

def affineYangBaxterLeft [AddCommGroup G] (energyBC energyBE energyCE : G) :
    Affine G B × Affine G C × Affine G E →
      Affine G E × Affine G C × Affine G B :=
  fun (b, c, e) =>
    let (c', b') := affineSwap energyBC (b, c)
    let (e', b'') := affineSwap energyBE (b', e)
    let (e'', c'') := affineSwap energyCE (c', e')
    (e'', c'', b'')

def affineYangBaxterRight [AddCommGroup G] (energyBC energyBE energyCE : G) :
    Affine G B × Affine G C × Affine G E →
      Affine G E × Affine G C × Affine G B :=
  fun (b, c, e) =>
    let (e', c') := affineSwap energyCE (c, e)
    let (e'', b') := affineSwap energyBE (b, e')
    let (c'', b'') := affineSwap energyBC (b', c')
    (e'', c'', b'')

/--
型付き成分交換へ可換加法群値の一定位相移動を載せた三つの持ち上げは、
両方の順序で同じ内部状態と同じ位相を返す。
-/
theorem affineSwap_yang_baxter [AddCommGroup G]
    (energyBC energyBE energyCE : G) (b : B) (c : C) (e : E)
    (degreeB degreeC degreeE : G) :
    affineYangBaxterLeft energyBC energyBE energyCE
        ((degreeB, b), (degreeC, c), (degreeE, e)) =
      affineYangBaxterRight energyBC energyBE energyCE
        ((degreeB, b), (degreeC, c), (degreeE, e)) ∧
    affineYangBaxterLeft energyBC energyBE energyCE
        ((degreeB, b), (degreeC, c), (degreeE, e)) =
      ((degreeE + energyBE + energyCE, e),
        (degreeC + energyBC - energyCE, c),
        (degreeB - energyBC - energyBE, b)) := by
  constructor <;>
    simp [affineYangBaxterLeft, affineYangBaxterRight, affineSwap, sub_eq_add_neg,
      add_assoc, add_comm, add_left_comm]

/-! ## 具体版の導出 -/

section Derivation

open CellularAutomata.FiniteCombinatorialScatteringData

theorem internalR_operator_compatible_of_necSuf :
    OperatorCompatible internalR partialAction :=
  internalR_operator_compatible

theorem integerTable_difference_compatible_of_necSuf :
    DifferenceCompatible partialAction integerTable (fun x y => x - y)
      expectedDifference :=
  integerTable_difference_compatible

theorem integerTable_normalized_of_necSuf :
    NormalizedAt integerTable (false, false) 0 :=
  integerTable_normalized

/-- 具体版の三体等式は可換加法群上の一般定理の特殊化である。 -/
theorem affine_yang_baxter_of_necSuf (b : BState) (c : CState) (d : DState)
    (degreeB degreeC degreeD : ℤ) :
    CellularAutomata.FiniteCombinatorialScatteringData.affineYangBaxterLeft
        ((degreeB, b), (degreeC, c), (degreeD, d)) =
      CellularAutomata.FiniteCombinatorialScatteringData.affineYangBaxterRight
        ((degreeB, b), (degreeC, c), (degreeD, d)) ∧
    CellularAutomata.FiniteCombinatorialScatteringData.affineYangBaxterLeft
        ((degreeB, b), (degreeC, c), (degreeD, d)) =
      ((degreeD + 1, d), (degreeC - 2, c), (degreeB + 1, b)) := by
  have h := affineSwap_yang_baxter (G := ℤ) (B := BState) (C := CState) (E := DState)
    1 (-2) 3 b c d degreeB degreeC degreeD
  constructor
  · simpa [CellularAutomata.FiniteCombinatorialScatteringData.affineYangBaxterLeft,
      CellularAutomata.FiniteCombinatorialScatteringData.affineYangBaxterRight,
      CellularAutomata.FiniteCombinatorialScatteringData.liftBC,
      CellularAutomata.FiniteCombinatorialScatteringData.liftBD,
      CellularAutomata.FiniteCombinatorialScatteringData.liftCD,
      CellularAutomata.FiniteCombinatorialScatteringData.affineSwap,
      CellularAutomata.NecSuf.FiniteCombinatorialScatteringData.affineYangBaxterLeft,
      CellularAutomata.NecSuf.FiniteCombinatorialScatteringData.affineYangBaxterRight,
      CellularAutomata.NecSuf.FiniteCombinatorialScatteringData.affineSwap] using h.1
  · change affineYangBaxterLeft 1 (-2) 3
        ((degreeB, b), (degreeC, c), (degreeD, d)) =
      ((degreeD + 1, d), (degreeC - 2, c), (degreeB + 1, b))
    rw [h.2]
    apply Prod.ext
    · apply Prod.ext
      · change degreeD + (-2 : ℤ) + 3 = degreeD + 1
        omega
      · rfl
    · apply Prod.ext
      · apply Prod.ext
        · change degreeC + 1 - 3 = degreeC - 2
          omega
        · rfl
      · apply Prod.ext
        · change degreeB - 1 - (-2 : ℤ) = degreeB + 1
          omega
        · rfl

end Derivation

end CellularAutomata.NecSuf.FiniteCombinatorialScatteringData
