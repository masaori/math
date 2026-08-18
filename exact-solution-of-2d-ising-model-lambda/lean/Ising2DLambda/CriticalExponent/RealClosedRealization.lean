/-
人手証明 `def_real_closed_realization` の具体版。

固定した実閉部分体 R の元を実数として読むために必要なデータを、
単位的環準同型と狭義単調性だけに固定する。このファイルはその存在を主張しない。
-/
import Ising2DLambda.FisherZero.RealAlgebraicOrder
import Mathlib.Data.Real.Basic

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.FisherZero

/-- 実閉部分体から実数体への順序を保つ実現データ。 -/
structure RealClosedRealization (base : RealClosedSubfieldData) where
  toRingHom : base.carrier →+* ℝ
  map_lt : ∀ a b : base.carrier,
    realAlgebraicLt base a b → toRingHom a < toRingHom b

end Ising2DLambda.CriticalExponent
