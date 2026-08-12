/-
「双対変換の対合性」の必要十分版。

具体版の証明が使うのは、二つの積が同じ値へ至る二本の鎖、差に因子を掛けた値を
零へ至らせる四段の鎖、その因子による零の消去、差が零なら始点と終点が等しいことだけである。
演算そのものは仮定が与える各段に隔離されるので、この組み立ての型には零元以外の代数構造を要求しない。
-/

namespace Ising2DLambda.NecSuf.FisherZero

universe u

/-- `claim_kw_dual_transform_involution` の証明手順を必要十分な仮定へ薄めた版。 -/
theorem kw_dual_transform_involution_necSuf
    {A : Type u} [Zero A]
    (start target doubleProduct doubleAfterDefinition doubleAfterAssociation
      doubleAfterCommutation doubleAfterInverse common
      xiProduct xiAfterSubstitution xiAfterReassociation
      differenceProduct differenceAfterDistribution differenceAfterCommutation
      differenceAfterSubstitution difference : A)
    (hDoubleDefinition : doubleProduct = doubleAfterDefinition)
    (hDoubleAssociation : doubleAfterDefinition = doubleAfterAssociation)
    (hDoubleCommutation : doubleAfterAssociation = doubleAfterCommutation)
    (hDoubleInverse : doubleAfterCommutation = doubleAfterInverse)
    (hDoubleUnit : doubleAfterInverse = common)
    (hXiSubstitution : xiProduct = xiAfterSubstitution)
    (hXiReassociation : xiAfterSubstitution = xiAfterReassociation)
    (hXiCommon : xiAfterReassociation = common)
    (hDifferenceDistribution : differenceProduct = differenceAfterDistribution)
    (hDifferenceCommutation : differenceAfterDistribution = differenceAfterCommutation)
    (hDifferenceSubstitution :
      doubleProduct = common → xiProduct = common →
        differenceAfterCommutation = differenceAfterSubstitution)
    (hDifferenceZero : differenceAfterSubstitution = 0)
    (hCancel : differenceProduct = 0 → difference = 0)
    (hDifferenceImpliesEquality : difference = 0 → start = target) :
    start = target := by
  have hDoubleCommon : doubleProduct = common := by
    calc
      doubleProduct = doubleAfterDefinition := hDoubleDefinition
      _ = doubleAfterAssociation := hDoubleAssociation
      _ = doubleAfterCommutation := hDoubleCommutation
      _ = doubleAfterInverse := hDoubleInverse
      _ = common := hDoubleUnit
  have hXiCommon' : xiProduct = common := by
    calc
      xiProduct = xiAfterSubstitution := hXiSubstitution
      _ = xiAfterReassociation := hXiReassociation
      _ = common := hXiCommon
  have hDifferenceProductZero : differenceProduct = 0 := by
    calc
      differenceProduct = differenceAfterDistribution := hDifferenceDistribution
      _ = differenceAfterCommutation := hDifferenceCommutation
      _ = differenceAfterSubstitution := hDifferenceSubstitution hDoubleCommon hXiCommon'
      _ = 0 := hDifferenceZero
  have hDifference : difference = 0 := hCancel hDifferenceProductZero
  exact hDifferenceImpliesEquality hDifference

end Ising2DLambda.NecSuf.FisherZero
