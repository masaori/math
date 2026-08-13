/- 二つの人手証明の論理的な手順だけを残した必要十分版。 -/

namespace Ising2DLambda.NecSuf.FisherZero

theorem self_dual_quadratic_roots_necSuf
    (quadratic rootPlus rootMinus factor firstZero secondZero : Prop)
    (hFactor : quadratic → factor)
    (hZeroProduct : factor → firstZero ∨ secondZero)
    (hFirstRoot : firstZero → rootPlus)
    (hSecondRoot : secondZero → rootMinus)
    (hPlusFirst : rootPlus → firstZero)
    (hMinusSecond : rootMinus → secondZero)
    (hFirstFactor : firstZero → factor)
    (hSecondFactor : secondZero → factor)
    (hFactorQuadratic : factor → quadratic) :
    quadratic ↔ rootPlus ∨ rootMinus := by
  constructor
  · intro hQuadratic
    rcases hZeroProduct (hFactor hQuadratic) with hFirst | hSecond
    · exact Or.inl (hFirstRoot hFirst)
    · exact Or.inr (hSecondRoot hSecond)
  · intro hRoot
    apply hFactorQuadratic
    rcases hRoot with hPlus | hMinus
    · exact hFirstFactor (hPlusFirst hPlus)
    · exact hSecondFactor (hMinusSecond hMinus)

theorem self_dual_quadratic_roots_distinct_necSuf
    (rootEqual sEqualsNeg productZero sZero twoZero : Prop)
    (hTwoNonzero : ¬ twoZero)
    (hEqualImpliesNeg : rootEqual → sEqualsNeg)
    (hNegImpliesProduct : sEqualsNeg → productZero)
    (hCancel : productZero → sZero)
    (hSquareContradiction : sZero → twoZero) :
    ¬ rootEqual := by
  intro hEqual
  exact hTwoNonzero (hSquareContradiction (hCancel (hNegImpliesProduct (hEqualImpliesNeg hEqual))))

end Ising2DLambda.NecSuf.FisherZero
