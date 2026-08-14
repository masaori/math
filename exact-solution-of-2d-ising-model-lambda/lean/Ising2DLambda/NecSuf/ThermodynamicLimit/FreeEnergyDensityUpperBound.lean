/-
「自由エネルギー密度の上からの評価」の必要十分版。

格子・分配多項式・実数・対数・冪を外し、上界を写像で移すこと、二項の像の分解、
二つの尺度係数の相殺だけを残す。
-/
namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 上界を写像と非負尺度作用で運び、二項へ分けて係数を相殺する。 -/
theorem scaled_map_upperBound_necSuf
    {K A C : Type}
    (leK : K → K → Prop) (leA : A → A → Prop)
    (mulK : K → K → K) (ell : K → A)
    (addA : A → A → A) (scale : C → A → A)
    (mulCoeff : C → C → C)
    (x pPow qPow p q : K) (c cp cq oneC twoC : C)
    (mapMono : ∀ {u v : K}, leK u v → leA (ell u) (ell v))
    (scaleMono : ∀ {u v : A}, leA u v → leA (scale c u) (scale c v))
    (xUpper : leK x (mulK pPow qPow))
    (ellMul : ell (mulK pPow qPow) = addA (ell pPow) (ell qPow))
    (ellP : ell pPow = scale cp (ell p))
    (ellQ : ell qPow = scale cq (ell q))
    (scaleAdd : scale c (addA (scale cp (ell p)) (scale cq (ell q))) =
      addA (scale (mulCoeff c cp) (ell p)) (scale (mulCoeff c cq) (ell q)))
    (cancelP : mulCoeff c cp = oneC)
    (cancelQ : mulCoeff c cq = twoC) :
    leA (scale c (ell x))
      (addA (scale oneC (ell p)) (scale twoC (ell q))) := by
  have h := scaleMono (mapMono xUpper)
  rw [ellMul, ellP, ellQ, scaleAdd, cancelP, cancelQ] at h
  exact h

end Ising2DLambda.NecSuf.ThermodynamicLimit
