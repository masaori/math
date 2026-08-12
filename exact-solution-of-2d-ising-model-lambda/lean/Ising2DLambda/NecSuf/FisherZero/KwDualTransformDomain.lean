/-
「双対変換の値は分母を零にしない」の必要十分版。

具体版の証明が使うのは、計算の三段の等式、終点が零なら逆元が零になること、
逆元が零なら単位元が零になること、単位元が零でないことだけである。
加法・乗法・逆元・体・可換性・代数閉性は、この組み立ての型には要求しない。
-/

namespace Ising2DLambda.NecSuf.FisherZero

universe u

/-- `claim_kw_dual_transform_domain` の証明手順を必要十分な仮定へ薄めた版。 -/
theorem kw_dual_transform_domain_necSuf
    {A : Type u} [Zero A]
    (start afterDefinition afterIdentity final inverse one : A)
    (hDefinition : start = afterDefinition)
    (hIdentity : afterDefinition = afterIdentity)
    (hDistributive : afterIdentity = final)
    (hCancel : final = 0 → inverse = 0)
    (hInverseContradiction : inverse = 0 → one = 0)
    (hOne : one ≠ 0) :
    start ≠ 0 := by
  intro hStart
  have hFinal : final = 0 := by
    calc
      final = afterIdentity := hDistributive.symm
      _ = afterDefinition := hIdentity.symm
      _ = start := hDefinition.symm
      _ = 0 := hStart
  have hInverseZero : inverse = 0 := hCancel hFinal
  have hOneZero : one = 0 := hInverseContradiction hInverseZero
  exact hOne hOneZero

end Ising2DLambda.NecSuf.FisherZero
