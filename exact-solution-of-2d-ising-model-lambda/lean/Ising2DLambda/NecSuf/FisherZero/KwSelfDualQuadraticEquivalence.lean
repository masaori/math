/-
「自己双対条件は二次方程式と同値」の必要十分版。

準備の五段、第一の方向の二段と四段、第二の方向の七段、零の消去を
等式と含意として受け取る。演算は各段へ隔離されるため、型には零元以外の構造を要求しない。
-/

namespace Ising2DLambda.NecSuf.FisherZero

universe u

/-- `claim_kw_self_dual_quadratic_equivalence` の証明手順を必要十分な仮定へ薄めた版。 -/
theorem kw_self_dual_quadratic_equivalence_necSuf
    {A : Type u} [Zero A]
    (start target quadratic
      product productAfterDefinition productAfterAssociation productAfterCommutation
      productAfterInverse productCommon
      forwardProduct forwardAfterSelf forwardQuadratic forwardAfterCancellation
      forwardAfterProduct forwardAfterCollect
      differenceProduct differenceAfterDistribution differenceAfterCommutation
      differenceAfterProduct differenceAfterExpansion differenceAfterSubtraction
      differenceAfterDoubling differenceAfterCommuting differenceAfterAssociating
      differenceAfterNegation
      differenceAfterAssumption difference : A)
    (hProductDefinition : product = productAfterDefinition)
    (hProductAssociation : productAfterDefinition = productAfterAssociation)
    (hProductCommutation : productAfterAssociation = productAfterCommutation)
    (hProductInverse : productAfterCommutation = productAfterInverse)
    (hProductUnit : productAfterInverse = productCommon)
    (hSelfImpliesForward : start = target → forwardProduct = forwardAfterSelf)
    (hForwardUsesProduct : product = productCommon → forwardAfterSelf = productCommon)
    (hForwardCancellation : forwardQuadratic = forwardAfterCancellation)
    (hForwardQuadraticStart : forwardAfterCancellation = forwardAfterProduct)
    (hForwardSubstitution : forwardProduct = productCommon →
      forwardAfterProduct = forwardAfterCollect)
    (hForwardZero : forwardAfterCollect = 0)
    (hQuadraticFromForward : forwardQuadratic = 0 → quadratic = 0)
    (hDifferenceDistribution : differenceProduct = differenceAfterDistribution)
    (hDifferenceCommutation : differenceAfterDistribution = differenceAfterCommutation)
    (hDifferenceProduct : product = productCommon →
      differenceAfterCommutation = differenceAfterProduct)
    (hDifferenceExpansion : differenceAfterProduct = differenceAfterExpansion)
    (hDifferenceSubtraction : differenceAfterExpansion = differenceAfterSubtraction)
    (hDifferenceDoubling : differenceAfterSubtraction = differenceAfterDoubling)
    (hDifferenceCommuting : differenceAfterDoubling = differenceAfterCommuting)
    (hDifferenceAssociating : differenceAfterCommuting = differenceAfterAssociating)
    (hDifferenceNegation : differenceAfterAssociating = differenceAfterNegation)
    (hDifferenceAssumption : quadratic = 0 →
      differenceAfterNegation = differenceAfterAssumption)
    (hDifferenceZero : differenceAfterAssumption = 0)
    (hCancel : differenceProduct = 0 → difference = 0)
    (hDifferenceImpliesSelf : difference = 0 → start = target) :
    start = target ↔ quadratic = 0 := by
  have hProductCommon : product = productCommon := by
    calc
      product = productAfterDefinition := hProductDefinition
      _ = productAfterAssociation := hProductAssociation
      _ = productAfterCommutation := hProductCommutation
      _ = productAfterInverse := hProductInverse
      _ = productCommon := hProductUnit
  constructor
  · intro hSelf
    have hForwardProduct : forwardProduct = productCommon := by
      calc
        forwardProduct = forwardAfterSelf := hSelfImpliesForward hSelf
        _ = productCommon := hForwardUsesProduct hProductCommon
    have hForwardQuadratic : forwardQuadratic = 0 := by
      calc
        forwardQuadratic = forwardAfterCancellation := hForwardCancellation
        _ = forwardAfterProduct := hForwardQuadraticStart
        _ = forwardAfterCollect := hForwardSubstitution hForwardProduct
        _ = 0 := hForwardZero
    exact hQuadraticFromForward hForwardQuadratic
  · intro hQuadratic
    have hDifferenceProductZero : differenceProduct = 0 := by
      calc
        differenceProduct = differenceAfterDistribution := hDifferenceDistribution
        _ = differenceAfterCommutation := hDifferenceCommutation
        _ = differenceAfterProduct := hDifferenceProduct hProductCommon
        _ = differenceAfterExpansion := hDifferenceExpansion
        _ = differenceAfterSubtraction := hDifferenceSubtraction
        _ = differenceAfterDoubling := hDifferenceDoubling
        _ = differenceAfterCommuting := hDifferenceCommuting
        _ = differenceAfterAssociating := hDifferenceAssociating
        _ = differenceAfterNegation := hDifferenceNegation
        _ = differenceAfterAssumption := hDifferenceAssumption hQuadratic
        _ = 0 := hDifferenceZero
    exact hDifferenceImpliesSelf (hCancel hDifferenceProductZero)

end Ising2DLambda.NecSuf.FisherZero
