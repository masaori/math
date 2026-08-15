/-
「有限系の自由エントロピー密度の上からの評価」の必要十分版。

格子・分配多項式・有理数体・対数順序群・有理数倍を外し、具体版の証明が実際に使っている性質だけを残す:
  (1) 上界 `x ≤ y` を第一の写像 `ell`（具体版では `log : ℚ_{>0} → Λ`）が順序を保って運ぶこと、
  (2) その像を第二の写像 `emb`（具体版では `λ ↦ (1/L²)·ι(λ) : Λ → Λ_ℚ`）が順序を保って運ぶこと、
  (3) 上界の像 `ell y` が目標の形 `target` に等しいこと（具体版では対数の加法性・冪・`log 2 = ℓ_2`）、
  (4) `target` の像 `emb target` が最終形 `final` に等しいこと（具体版では `ι` の加法性・整数倍との交換・
      有理数倍の分配則と結合則・約分）。
削れなかった仮定について:
  - `ellMono`・`embMono` は、二段の順序の移送そのものであり外せない（順序を反映することは使わない。
    具体版が引く二主張は同値だが、使うのは → と ← の一方向ずつである）。
  - `ellY`・`embTarget` は等式の書き換えであり、具体版の鎖の等号段に対応する。
    対数であること・有理数倍であることは本質でなく、等式が成り立つことだけを使う。
-/
namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 上界を順序を保つ二つの写像で運び、像を等式で整えるだけで最終形へ着く。 -/
theorem upperBound_transport_through_two_monotone_maps_necSuf
    {K A B : Type}
    (leK : K → K → Prop) (leA : A → A → Prop) (leB : B → B → Prop)
    (ell : K → A) (emb : A → B)
    (x y : K) (target : A) (final : B)
    (ellMono : ∀ {u v : K}, leK u v → leA (ell u) (ell v))
    (embMono : ∀ {u v : A}, leA u v → leB (emb u) (emb v))
    (xUpper : leK x y)
    (ellY : ell y = target)
    (embTarget : emb target = final) :
    leB (emb (ell x)) final := by
  -- 第一段: ell x ≤_A ell y（具体版の Λ の鎖の ≤ 段）
  have hA : leA (ell x) (ell y) := ellMono xUpper
  -- 上界の像を目標の形へ（具体版の Λ の鎖の等号段）
  rw [ellY] at hA
  -- 第二段: emb (ell x) ≤_B emb target（具体版の Λ_ℚ の鎖の ≤ 段）
  have hB : leB (emb (ell x)) (emb target) := embMono hA
  -- 像を最終形へ（具体版の Λ_ℚ の鎖の等号段）
  rw [embTarget] at hB
  exact hB

end Ising2DLambda.NecSuf.ThermodynamicLimit
