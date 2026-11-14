/-
# 冪等行列のトレースは像の次元（具体版を必要十分版から導く）

具体版 `DefinitionTrace.lean` の `trace_of_idempotent`（人手 `trace_of_idempotent`）を、
必要十分版 `Ising2D/NecSuf/TraceOfIdempotent.lean` の `trace_of_idempotent` の係数 `K := ℂ` の特殊化として得る。
二つの証明は準備・Step 1〜3 の段が同じ並びである（対応表は必要十分版の冒頭）。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace
import Ising2D.NecSuf.TraceOfIdempotent

namespace Ising2D

/-- `trace_of_idempotent` を `NecSuf.trace_of_idempotent`（`K := ℂ`）の特殊化として得る。 -/
theorem trace_of_idempotent_of_necSuf {n : Type*} [Fintype n] [DecidableEq n]
    (Q : Matrix n n ℂ) (hQ : Q ^ 2 = Q) :
    Q.trace = (Module.finrank ℂ (LinearMap.range (Matrix.toLin' Q)) : ℂ) :=
  NecSuf.trace_of_idempotent Q hQ

end Ising2D
