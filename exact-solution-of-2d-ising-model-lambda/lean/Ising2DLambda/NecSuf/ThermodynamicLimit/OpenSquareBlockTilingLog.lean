/-
「開境界正方形のブロック敷き詰め評価の対数化（Λ の鎖）」の必要十分版。

格子・分配多項式・有理数体・対数順序群・対数・冪・整数倍を外し、
具体版の証明が実際に使っている性質だけを残す:
  (1) 値の側 `K` の二側の評価 `leK lower x`・`leK x upper` を、写像 `ell`
      （具体版では `log : ℚ_{>0} → Λ`）が順序を保って運ぶこと（`ellMono`）。
  (2) 下側・上側の値の像が目標の形に等しいこと（`ellLower`・`ellUpper`。
      具体版では準備の第二の六段・第三の三段の展開。展開の内部は具体版の補題であり、
      ここでは等式一つに畳んで仮定する）。
削れなかった仮定について:
  - `ellMono` は順序の移送そのものであり外せない。具体版が引く `logRat_le_iff` は同値だが、
    使うのは → の一方向だけである（順序を反映することは使わない）。
  - `ellLower`・`ellUpper` は等式の書き換えであり、具体版の鎖の等号段（準備を右辺から
    左辺の向きで読む段と最終段）に対応する。対数であることは本質でなく、
    等式が成り立つことだけを使う。
残す仮定はこれだけであり、`A` に加法があることも `K` に乗法があることも要らない。
両場合（`0<q≤1` と `1≤q`）は `lower`・`upper` と目標の形を入れ替えて同じ定理から得る。
-/
namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 二側の評価を順序を保つ写像で運び、両端の像を等式で目標の形へ整える。 -/
theorem twoSided_bounds_transport_through_monotone_map_necSuf
    {K A : Type}
    (leK : K → K → Prop) (leA : A → A → Prop)
    (ell : K → A)
    (lower x upper : K) (lowForm upForm : A)
    (ellMono : ∀ {u v : K}, leK u v → leA (ell u) (ell v))
    (xLower : leK lower x) (xUpper : leK x upper)
    (ellLower : ell lower = lowForm)
    (ellUpper : ell upper = upForm) :
    leA lowForm (ell x) ∧ leA (ell x) upForm := by
  constructor
  · -- 下側: 順序の移送（具体版の logRat_le_iff の →）→ 像を目標の形へ（準備の第二）
    have h := ellMono xLower
    rw [ellLower] at h
    exact h
  · -- 上側: 順序の移送 → 像を目標の形へ（準備の第三）
    have h := ellMono xUpper
    rw [ellUpper] at h
    exact h

end Ising2DLambda.NecSuf.ThermodynamicLimit
