/-
「開境界密度の下からの評価（t が 1 以下の場合）」の必要十分版。

格子・分配多項式・実数・対数・冪を外し、下界を写像で運ぶこと、像の尺度分解、
尺度係数の合成と相殺だけを残す。人手証明の対数側の鎖
`ι(2)·log t = ι(1/L²)·ι(2L²)·log t = ι(1/L²)·log(t^{2L²}) ≤ ι(1/L²)·log Z` と同じ順で辿る。
-/
namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 下界を写像と尺度作用で運び、係数を合成して相殺する。
`K` の順序も `A` の順序も反射律・推移律を要求しない（使わないため）。 -/
theorem scaled_map_lowerBound_necSuf
    {K A C : Type}
    (leK : K → K → Prop) (leA : A → A → Prop)
    (ell : K → A) (scale : C → A → A) (mulCoeff : C → C → C)
    (x pPow p : K) (c cp twoC : C)
    (mapMono : ∀ {u v : K}, leK u v → leA (ell u) (ell v))
    (scaleMono : ∀ {u v : A}, leA u v → leA (scale c u) (scale c v))
    (xLower : leK pPow x)
    (ellP : ell pPow = scale cp (ell p))
    (scaleComp : scale c (scale cp (ell p)) = scale (mulCoeff c cp) (ell p))
    (cancelP : mulCoeff c cp = twoC) :
    leA (scale twoC (ell p)) (scale c (ell x)) := by
  have h := scaleMono (mapMono xLower)
  rw [ellP, scaleComp, cancelP] at h
  exact h

end Ising2DLambda.NecSuf.ThermodynamicLimit
