import Mathlib.Data.Complex.Basic

namespace Ising2DLambda.NecSuf.RealEscape

/-- 一意な二係数表示と係数の実数像だけを用いる複素実現。 -/
noncomputable def complexRealization {α β : Type*}
    (decomposition : α → β × β) (realization : β → ℝ) (xi : α) : ℂ :=
  (realization (decomposition xi).1 : ℂ) +
    Complex.I * (realization (decomposition xi).2 : ℂ)

end Ising2DLambda.NecSuf.RealEscape
