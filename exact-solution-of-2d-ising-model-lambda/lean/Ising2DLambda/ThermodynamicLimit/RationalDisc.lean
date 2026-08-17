/-
章「熱力学極限」の「有理点を中心とする有理半径の円板（代数的数の部分集合）」（`def_rational_disc`）の具体版。
定義ブロックなので必要十分版は無い。

  人手証明                                                                    このファイル
  ξ = a + b·ω のちょうど 1 つの組 (a,b) ∈ R×R（def_real_closed_subfield 第 4 条件）  `realClosedComponents`（既存）
  dsq₂(ξ,c) := (a-c₁)·(a-c₁) + (b-c₂)·(b-c₂) ∈ R                              `distanceSquaredToRationalPoint`
  D(c,r) := { ξ | dsq₂(ξ,c) <_R r·r } ⊂ Qbar                                  `rationalDisc`
  dsq₂(ξ,(q,0)) = dsq(ξ,q)（両辺の定義式の一致、b-0=b）                       `distanceSquaredToRationalPoint_real_axis`

住処: Q と Qbar（R は Qbar の実閉部分体の担い手）。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.DistanceSquaredToRational
import Ising2DLambda.FisherZero.RealAlgebraicOrder

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 有理点 `c = (c₁, c₂)` との距離の二乗（`def_rational_disc` の `dsq₂`）。 -/
noncomputable def distanceSquaredToRationalPoint
    (data : RealClosedSubfieldData) (xi : Qbar) (c : ℚ × ℚ) : data.carrier :=
  let ab := realClosedComponents data xi
  let c1R : data.carrier := ⟨(c.1 : Qbar), rational_mem_realClosedCarrier data c.1⟩
  let c2R : data.carrier := ⟨(c.2 : Qbar), rational_mem_realClosedCarrier data c.2⟩
  (ab.1 - c1R) * (ab.1 - c1R) + (ab.2 - c2R) * (ab.2 - c2R)

/-- `def_rational_disc` の具体版: 中心 `c`・半径 `r` の円板 `D(c, r) ⊂ Qbar`。 -/
noncomputable def rationalDisc
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) : Set Qbar :=
  { xi | realAlgebraicLt data
      (distanceSquaredToRationalPoint data xi c)
      ⟨((r.1 * r.1 : ℚ) : Qbar), rational_mem_realClosedCarrier data (r.1 * r.1)⟩ }

/-- 実軸上の有理点との距離の二乗は既存の `distanceSquaredToRational` に一致する
（人手証明: 両辺の定義式の一致、`b - 0 = b`）。 -/
theorem distanceSquaredToRationalPoint_real_axis
    (data : RealClosedSubfieldData) (xi : Qbar) (q : ℚ) :
    distanceSquaredToRationalPoint data xi (q, 0) = distanceSquaredToRational data xi q := by
  unfold distanceSquaredToRationalPoint distanceSquaredToRational
  -- (b - 0) * (b - 0) = b * b
  have h0 : (⟨((0 : ℚ) : Qbar), rational_mem_realClosedCarrier data 0⟩ : data.carrier) = 0 := by
    apply Subtype.ext
    simp
  simp only [h0, sub_zero]

end Ising2DLambda.ThermodynamicLimit
