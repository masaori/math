/-
具体版の線形順序性を必要十分版の引き戻しから導く。
住処は ℕ・ℤ・ℚ・Λ だけで、実数・複素数は現れない。
-/
import Ising2DLambda.FreeEntropy.LogOrderGroupOrder
import Ising2DLambda.NecSuf.FreeEntropy.LogOrderGroupOrder

namespace Ising2DLambda.FreeEntropy

/-- 具体版の関係は必要十分版の引き戻しそのものである。 -/
theorem logOrderLE_eq_pullback :
    logOrderLE = Ising2DLambda.NecSuf.FreeEntropy.pullbackLE rationalOfLog := rfl

/-- 反射律・推移律・反対称律・全順序性を必要十分版から導く。 -/
theorem logOrderLE_linear_order_from_necSuf :
    (∀ a, logOrderLE a a) ∧
    (∀ a b c, logOrderLE a b → logOrderLE b c → logOrderLE a c) ∧
    (∀ a b, logOrderLE a b → logOrderLE b a → a = b) ∧
    (∀ a b, logOrderLE a b ∨ logOrderLE b a) := by
  rw [logOrderLE_eq_pullback]
  exact Ising2DLambda.NecSuf.FreeEntropy.pullback_linear_order_necSuf
    rationalOfLog logRat logRat_rationalOfLog

end Ising2DLambda.FreeEntropy
