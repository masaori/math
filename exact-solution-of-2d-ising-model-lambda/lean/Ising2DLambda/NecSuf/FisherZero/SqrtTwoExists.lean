/-
「二の平方根の存在」の必要十分版。

二次係数の四段、非零性から根を供給する一段、根から目的の等式へ至る十一段を
等式と含意として受け取る。型には零元以外の構造を要求しない。
-/

namespace Ising2DLambda.NecSuf.FisherZero

universe u v w

/-- `claim_sqrt_two_exists` の証明手順を必要十分な仮定へ薄めた版。 -/
theorem sqrt_two_exists_necSuf
    {Coeff : Type u} {Root : Type v} {Value : Type w}
    [Zero Coeff] [Zero Value]
    (coeffStart coeffAfterAdd coeffAfterPower coeffAfterConst coeffFinal : Coeff)
    (rootValue : Root → Value)
    (lhs afterEvalFactors afterEvalProduct afterPower afterZero afterInverse
      afterConst afterAssociation afterEvalAdd afterDefinition afterRoot : Root → Value)
    (target : Value)
    (hCoeffAdd : coeffStart = coeffAfterAdd)
    (hCoeffPower : coeffAfterAdd = coeffAfterPower)
    (hCoeffConst : coeffAfterPower = coeffAfterConst)
    (hCoeffZero : coeffAfterConst = coeffFinal)
    (hCoeffNonzero : coeffFinal ≠ 0)
    (hRootExists : coeffStart = coeffFinal → coeffFinal ≠ 0 →
      ∃ s : Root, rootValue s = 0)
    (hEvalFactors : ∀ s, lhs s = afterEvalFactors s)
    (hEvalProduct : ∀ s, afterEvalFactors s = afterEvalProduct s)
    (hPower : ∀ s, afterEvalProduct s = afterPower s)
    (hZero : ∀ s, afterPower s = afterZero s)
    (hInverse : ∀ s, afterZero s = afterInverse s)
    (hConst : ∀ s, afterInverse s = afterConst s)
    (hAssociation : ∀ s, afterConst s = afterAssociation s)
    (hEvalAdd : ∀ s, afterAssociation s = afterEvalAdd s)
    (hDefinition : ∀ s, afterEvalAdd s = afterDefinition s)
    (hUseRoot : ∀ s, rootValue s = 0 → afterDefinition s = afterRoot s)
    (hFinalZero : ∀ s, afterRoot s = target) :
    ∃ s : Root, lhs s = target := by
  have hCoeff : coeffStart = coeffFinal := by
    calc
      coeffStart = coeffAfterAdd := hCoeffAdd
      _ = coeffAfterPower := hCoeffPower
      _ = coeffAfterConst := hCoeffConst
      _ = coeffFinal := hCoeffZero
  obtain ⟨s, hsRoot⟩ := hRootExists hCoeff hCoeffNonzero
  refine ⟨s, ?_⟩
  calc
    lhs s = afterEvalFactors s := hEvalFactors s
    _ = afterEvalProduct s := hEvalProduct s
    _ = afterPower s := hPower s
    _ = afterZero s := hZero s
    _ = afterInverse s := hInverse s
    _ = afterConst s := hConst s
    _ = afterAssociation s := hAssociation s
    _ = afterEvalAdd s := hEvalAdd s
    _ = afterDefinition s := hDefinition s
    _ = afterRoot s := hUseRoot s hsRoot
    _ = target := hFinalZero s

end Ising2DLambda.NecSuf.FisherZero
