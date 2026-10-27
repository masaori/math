import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

noncomputable def modeBlockMatrix {E M P D R : Type*} [Zero R]
    (κ : E ≃ M) (mode : M → P) (direction : M → D)
    (small : P → Matrix D D R) : Matrix E E R := by
  classical
  exact fun g h =>
    if mode (κ g) = mode (κ h) then
      small (mode (κ h)) (direction (κ g)) (direction (κ h))
    else 0

end Ising2DLambda.NecSuf.KacWard
