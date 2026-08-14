/-
「双対変換は零と一の間の有理数を保つ」の必要十分版。

具体版の三つの鎖が使うのは、値が二因子の積であること、二因子が台集合に属して
積で閉じること、二因子の正値性、正の右因子を掛けた比較、積が上端に等しいことだけである。
体・順序環・逆元・有理数・代数的数という構造は、この組み立てには要求しない。
-/

namespace Ising2DLambda.NecSuf.FisherZero

universe u

/-- `claim_kw_dual_preserves_unit_interval` の三つの鎖を必要十分な仮定へ薄めた版。 -/
theorem kw_dual_preserves_unit_interval_necSuf
    {A : Type u}
    (carrier : A → Prop) (lt : A → A → Prop)
    (zero one oneMinus onePlus t value : A) (mul : A → A → A)
    (hOneMinusCarrier : carrier oneMinus)
    (hTCarrier : carrier t)
    (hMulCarrier : carrier oneMinus → carrier t → carrier (mul oneMinus t))
    (hValue : value = mul oneMinus t)
    (hOneMinusPositive : lt zero oneMinus)
    (hTPositive : lt zero t)
    (hMulPositive : lt zero oneMinus → lt zero t → lt zero (mul oneMinus t))
    (hOneMinusLtOnePlus : lt oneMinus onePlus)
    (hMulLtMul : lt oneMinus onePlus → lt zero t →
      lt (mul oneMinus t) (mul onePlus t))
    (hInverse : mul onePlus t = one) :
    carrier value ∧ lt zero value ∧ lt value one := by
  have hValueCarrier : carrier value := by
    rw [hValue]
    exact hMulCarrier hOneMinusCarrier hTCarrier
  have hValuePositive : lt zero value := by
    rw [hValue]
    exact hMulPositive hOneMinusPositive hTPositive
  have hValueLtOne : lt value one := by
    rw [hValue, ← hInverse]
    exact hMulLtMul hOneMinusLtOnePlus hTPositive
  exact ⟨hValueCarrier, hValuePositive, hValueLtOne⟩

end Ising2DLambda.NecSuf.FisherZero
