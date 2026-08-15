/-
「ブロック敷き詰め評価の対数化」の必要十分版。

格子・分配多項式・実数・実対数・冪を外し、具体版が実際に使った性質だけを残す。
- 値の側 `K` に前順序 `leK`、像の側 `A` に前順序 `leA` があり、写像 `ell` が順序を保つこと
  （実対数の単調性。等号を含む弱い形で足りる）。
- 下側・上側の値の像が、二つの基準の像の「尺度倍の和」へ開けること（積の対数と冪の対数の
  展開は、この等式一つに畳んで仮定する。展開の内部は具体版の補題であり、ここでは使わない）。
- 尺度作用が和と尺度倍の合成に分配すること（`scaleAdd`・`scaleScale`）と、
  係数の積の相殺（有理数の約分）。
残す仮定はこれだけであり、`A` の加法が可換であることも `K` に乗法があることも要らない。
両場合（`0<t≤1` と `1≤t`）は `leK`・`leA` の向きを反転して同じ定理から得る。
-/
namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 二辺から挟まれた値の像を尺度作用で運び、二項へ開いて係数を相殺する。 -/
theorem scaled_map_twoSided_bounds_necSuf
    {K A C : Type}
    (leK : K → K → Prop) (leA : A → A → Prop)
    (ell : K → A) (addA : A → A → A) (scale : C → A → A) (mulCoeff : C → C → C)
    (lower x upper t p : K) (c cLowT cLowP cUpP dCoeff eCoeff : C)
    (mapMono : ∀ {u v : K}, leK u v → leA (ell u) (ell v))
    (scaleMono : ∀ {u v : A}, leA u v → leA (scale c u) (scale c v))
    (xLower : leK lower x) (xUpper : leK x upper)
    (ellLower : ell lower = addA (scale cLowT (ell t)) (scale cLowP (ell p)))
    (ellUpper : ell upper = scale cUpP (ell p))
    (scaleAdd : ∀ (u v : A) (c1 c2 : C),
      scale c (addA (scale c1 u) (scale c2 v)) =
        addA (scale (mulCoeff c c1) u) (scale (mulCoeff c c2) v))
    (scaleScale : ∀ (u : A) (c1 : C), scale c (scale c1 u) = scale (mulCoeff c c1) u)
    (cancelT : mulCoeff c cLowT = dCoeff)
    (cancelLowP : mulCoeff c cLowP = eCoeff)
    (cancelUpP : mulCoeff c cUpP = eCoeff) :
    leA (addA (scale dCoeff (ell t)) (scale eCoeff (ell p))) (scale c (ell x)) ∧
      leA (scale c (ell x)) (scale eCoeff (ell p)) := by
  constructor
  · -- 下側: 単調性 → 像の展開 → 尺度作用の分配 → 係数の相殺
    have h := scaleMono (mapMono xLower)
    rw [ellLower, scaleAdd, cancelT, cancelLowP] at h
    exact h
  · have h := scaleMono (mapMono xUpper)
    rw [ellUpper, scaleScale, cancelUpP] at h
    exact h

end Ising2DLambda.NecSuf.ThermodynamicLimit
