/-
「四境界条件の混合の双対恒等式」の必要十分版。
人手証明と同じ四段の等式の鎖だけを仮定する。

要るのは五つの元が同じ型に属することと、隣り合う四組の等式だけである。
加法・乗法・冪・整数係数多項式・格子・境界セクターの構造は、この組み立ての段では使わない。
-/

namespace Ising2DLambda.NecSuf.FisherZero

universe u

/-- `claim_mixed_boundary_duality_identity` の四段の等式の鎖を必要十分な仮定へ薄めた版。 -/
theorem four_step_equality_chain_necSuf
    {A : Type u} (start first second third finish : A)
    (hStartFirst : start = first)
    (hFirstSecond : first = second)
    (hSecondThird : second = third)
    (hThirdFinish : third = finish) :
    start = finish := by
  calc
    start = first := hStartFirst
    _ = second := hFirstSecond
    _ = third := hSecondThird
    _ = finish := hThirdFinish

end Ising2DLambda.NecSuf.FisherZero
