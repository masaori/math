import Mathlib

/-!
`claim_local_pairing_signed_sum` の二つ目の等式のうち、横断数の一致 `t(D,T) = t_P(κ)` の段の必要十分版。

具体版 `Ising2DLambda.KacWard.shortPairCrossingNumber_eq_localPairingCrossingCount` と同じ手順
（横断する順序のない対を頂点ごとの束に分ける → `c_v = 0` の頂点では束が空 → `c_v = 1` の頂点では
頂点の対が二つ `a`・`b` だけで、束は `{(a,b),(b,a)}` のうち第一成分の順に並ぶ一つ）を、次の仮定だけで行う。

* 半辺の型 `H` は線形順序を持てばよい（順序のない対を第一成分の小さい側で代表するため）。
  格子・方向番号の個数・直進・方向軸は使わない。
* 対の集合 `t` と、各対の頂点 `vtx`、対どうしの横断の関係 `R`。`R` は対称で（`(b,a)` を束に入れるため）、
  横断する二つの対は同じ頂点を持つ（束に分けるため）。
* 頂点の数 `c v` は零か一。零の頂点を持つ対はどれとも横断しない。一の頂点では、その頂点の対は横断する
  二つの対 `a`・`b`（第一成分が異なる）のどちらかである。具体版では、この二つが方向番号 `Fin 4` の
  上の有限の確認（四方向が全て選ばれ、`κ_v = {{0,2},{1,3}}`）から出る。
-/

namespace Ising2DLambda.NecSuf.KacWard

open Finset
open scoped Classical

theorem crossing_pair_count_eq_vertex_sum {H V : Type*} [LinearOrder H] [Fintype V]
    (t : Finset (H × H)) (vtx : H × H → V) (R : H × H → H × H → Prop) (c : V → ℕ)
    (hsymm : ∀ p q, R p q → R q p)
    (hloc : ∀ p q, R p q → vtx p = vtx q)
    (hc : ∀ v, c v = 0 ∨ c v = 1)
    (hzero : ∀ v, c v = 0 → ∀ p ∈ t, ∀ q ∈ t, vtx p = v → ¬ R p q)
    (hone : ∀ v, c v = 1 → ∃ a ∈ t, ∃ b ∈ t, vtx a = v ∧ vtx b = v ∧ R a b ∧ a.1 ≠ b.1 ∧
      ∀ p ∈ t, vtx p = v → p = a ∨ p = b) :
    ((t ×ˢ t).filter fun pq => pq.1.1 < pq.2.1 ∧ R pq.1 pq.2).card = ∑ v, c v := by
  rw [Finset.card_eq_sum_card_fiberwise (f := fun pq => vtx pq.1)
    (t := Finset.univ) (fun _ _ => Finset.mem_univ _)]
  apply Finset.sum_congr rfl
  intro v _
  rcases hc v with h0 | h1
  · -- `c v = 0`: 束は空
    rw [h0, Finset.card_eq_zero]
    apply Finset.eq_empty_iff_forall_notMem.mpr
    rintro ⟨p, q⟩ hpq
    obtain ⟨hpq, hv⟩ := Finset.mem_filter.mp hpq
    obtain ⟨hmem, _, hR⟩ := Finset.mem_filter.mp hpq
    obtain ⟨hp, hq⟩ := Finset.mem_product.mp hmem
    exact hzero v h0 p hp q hq hv hR
  · -- `c v = 1`: 束は `{(a,b),(b,a)}` のうち第一成分の順に並ぶ一つ
    obtain ⟨a, ha, b, hb, hva, hvb, hab, hne, hcover⟩ := hone v h1
    have hfiber : ((t ×ˢ t).filter fun pq => pq.1.1 < pq.2.1 ∧ R pq.1 pq.2).filter
        (fun pq => vtx pq.1 = v) =
        ({(a, b), (b, a)} : Finset _).filter fun pq => pq.1.1 < pq.2.1 := by
      ext ⟨p, q⟩
      simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_insert,
        Finset.mem_singleton, Prod.mk.injEq]
      constructor
      · rintro ⟨⟨⟨hp, hq⟩, hlt, hR⟩, hv⟩
        have hvq : vtx q = v := (hloc p q hR).symm.trans hv
        refine ⟨?_, hlt⟩
        rcases hcover p hp hv with rfl | rfl <;> rcases hcover q hq hvq with rfl | rfl
        · exact absurd hlt (lt_irrefl _)
        · exact Or.inl ⟨rfl, rfl⟩
        · exact Or.inr ⟨rfl, rfl⟩
        · exact absurd hlt (lt_irrefl _)
      · rintro ⟨⟨rfl, rfl⟩ | ⟨rfl, rfl⟩, hlt⟩
        · exact ⟨⟨⟨ha, hb⟩, hlt, hab⟩, hva⟩
        · exact ⟨⟨⟨hb, ha⟩, hlt, hsymm _ _ hab⟩, hvb⟩
    rw [hfiber, h1]
    rcases lt_or_gt_of_ne hne with h | h
    · simp [Finset.filter_insert, Finset.filter_singleton, h, not_lt.mpr h.le]
    · simp [Finset.filter_insert, Finset.filter_singleton, h, not_lt.mpr h.le]

end Ising2DLambda.NecSuf.KacWard
