/-
有限格子の Fisher 零点の代数性の必要十分版。
本文と同じく、別の点での非零評価から候補の非零性を導き、その候補を根の証拠に取る。
試験評価が零を保つことだけが必要であり、環の演算や順序はこの合成では使わない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.FisherZero

/-- 非零評価から非零性を導いて根の証拠を構成する。 -/
theorem nonzero_root_witness_necSuf {P V W : Type} [Zero P] [Zero V] [Zero W]
    (evaluate : V → P → V) (xi : V) (f : P)
    (testEvaluate : P → W) (testValue : W)
    (hzero : testEvaluate 0 = 0) (hvalue : testEvaluate f = testValue)
    (hne : testValue ≠ 0) (hroot : evaluate xi f = 0) :
    ∃ g : P, g ≠ 0 ∧ evaluate xi g = 0 := by
  have hf : f ≠ 0 := by
    intro hfzero
    have htestzero : testEvaluate f = 0 := by rw [hfzero, hzero]
    exact hne (hvalue.symm.trans htestzero)
  exact ⟨f, hf, hroot⟩

end Ising2DLambda.NecSuf.FisherZero
