/-
「有理数の平方は二にならない」の必要十分版。

値には零元・積・負号、符号の三分と負から正への移行を要求する。
零の枝には目標値が非零であることと零どうしの積、
負の枝には左右の負号の積と二重負号の法則が要る。
加法・除法・積の結合則や可換則・値全体の順序は使わない。

対数の値には加法だけ、指数には前順序・加法・減法・零・一の指定を残す。
指数の十等号には二つの素数指数の値・表示式・対数の成分式・積の対数則を使う。
指数の二場合には一以上か零以下かの二分、左右の加法の単調性、
0 < 1 と 1 < 1 + 1 が要る。指数全体の加法群・乗法・全順序は使わない。
本文の27計算行を再現し、途中の平方保存・指数の二倍・矛盾は仮定しない。
-/
import Mathlib.Order.Basic

namespace Ising2DLambda.NecSuf.FisherZero

universe u v w

/-- 符号の帰着、対数の成分計算、離散順序の二場合で平方を排除する。 -/
theorem no_rational_square_two_necSuf
    {Value : Type u} {LogValue : Type v} {Index : Type w}
    [Zero Value] [Mul Value] [Neg Value] [Add LogValue]
    [Zero Index] [One Index] [Add Index] [Sub Index] [Preorder Index]
    (target : Value) (positive negative : Value → Prop)
    (exponent : Value → Index) (log : Value → LogValue)
    (component : LogValue → Index) (primeExpTwo primeExpOne : Index)
    (hCases : ∀ q, negative q ∨ q = 0 ∨ positive q)
    (hTargetNonzero : target ≠ 0)
    (hZeroProduct : (0 : Value) * 0 = 0)
    (hNegPositive : ∀ q, negative q → positive (-q))
    (hNegMul : ∀ a b : Value, (-a) * b = -(a * b))
    (hMulNeg : ∀ a b : Value, a * (-b) = -(a * b))
    (hNegNeg : ∀ a : Value, -(-a) = a)
    (hPrimeTwo : primeExpTwo = 1)
    (hPrimeOne : primeExpOne = 0)
    (hRepresentation : exponent target = primeExpTwo - primeExpOne)
    (hLogComponent : ∀ r, component (log r) = exponent r)
    (hLogMul : ∀ r s, positive r → positive s → log (r * s) = log r + log s)
    (hComponentAdd : ∀ a b, component (a + b) = component a + component b)
    (hIndexSubZero : ∀ a : Index, a - 0 = a)
    (hIndexZeroAdd : ∀ a : Index, 0 + a = a)
    (hIndexCases : ∀ m : Index, 1 ≤ m ∨ m ≤ 0)
    (hIndexAddRight : ∀ a b : Index, a ≤ b → ∀ c, a + c ≤ b + c)
    (hIndexAddLeft : ∀ a b : Index, a ≤ b → ∀ c, c + a ≤ c + b)
    (hZeroLtOne : (0 : Index) < 1)
    (hOneLtDoubleOne : (1 : Index) < 1 + 1) :
    ∀ q : Value, q * q ≠ target := by
  -- 正の値に対する、本文の指数の十等号と離散順序の二場合。
  have noSquareOfPositive : ∀ r, positive r → r * r ≠ target := by
    intro r hr hSquare
    let m : Index := exponent r
    have hDouble : (1 : Index) = m + m := by
      calc
        (1 : Index) = 1 - 0 := (hIndexSubZero 1).symm
        _ = primeExpTwo - 0 := by rw [hPrimeTwo]
        _ = primeExpTwo - primeExpOne := by rw [hPrimeOne]
        _ = exponent target := hRepresentation.symm
        _ = exponent (r * r) := by rw [hSquare]
        _ = component (log (r * r)) := (hLogComponent _).symm
        _ = component (log r + log r) := congrArg component (hLogMul r r hr hr)
        _ = component (log r) + component (log r) := hComponentAdd _ _
        _ = exponent r + exponent r := by rw [hLogComponent]
        _ = m + m := rfl
    let twoIndex : Index := 1 + 1
    rcases hIndexCases m with hHigh | hLow
    · have hGreater : m + m > 1 := by
        calc
          m + m ≥ 1 + m := hIndexAddRight 1 m hHigh m
          _ ≥ 1 + 1 := hIndexAddLeft 1 m hHigh 1
          _ = twoIndex := rfl
          _ > 1 := hOneLtDoubleOne
      exact (ne_of_gt hGreater) hDouble.symm
    · have hLess : m + m < 1 := by
        calc
          m + m ≤ 0 + m := hIndexAddRight m 0 hLow m
          _ ≤ 0 + 0 := hIndexAddLeft m 0 hLow 0
          _ = 0 := hIndexZeroAdd 0
          _ < 1 := hZeroLtOne
      exact (ne_of_lt hLess) hDouble.symm
  -- 本文の零・正・負の枝。証明は具体版と同じ三分律の順で記述する。
  intro q hSquare
  rcases hCases q with hNeg | hZero | hPos
  · let r : Value := -q
    apply noSquareOfPositive r (hNegPositive q hNeg)
    calc
      r * r = (-q) * (-q) := rfl
      _ = -(q * (-q)) := hNegMul q (-q)
      _ = -(-(q * q)) := congrArg Neg.neg (hMulNeg q q)
      _ = q * q := hNegNeg _
      _ = target := hSquare
  · have hZero : q * q = 0 := by
      calc
        q * q = 0 * 0 := by rw [hZero]
        _ = 0 := hZeroProduct
    exact hTargetNonzero (hSquare.symm.trans hZero)
  · let r : Value := q
    apply noSquareOfPositive r hPos
    calc
      r * r = q * q := rfl
      _ = target := hSquare

end Ising2DLambda.NecSuf.FisherZero
