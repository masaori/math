/-
「非零項の位相は補辺の二次符号と短い対の横断数に等しい」（`claim_tagged_matching_quadratic_crossing_weight`）の
具体版のうち、証明の二つ目の式

  `Π_C χ_{a,b}(h(γ_C), v(γ_C)) (−1)^{c_C}
     = χ_{a,b}(⊕_C h(γ_C), ⊕_C v(γ_C)) (−1)^{Σ_C c_C + Σ_{C<C'} c_mut(γ_C, γ_C')}`

を、実際の非零項 `(D, T)` の交互閉路の族について示す段。閉路は最小元 `m ∈ taggedCycleMinima` で表し、
`C < C'` は最小元の順序で読む（`shortPairCrossingNumber_cycleSplit` と同じ読み方）。
切断線偶奇の和 `⊕_C h(γ_C)` を補辺 `P` の切断線偶奇へ移す段（台の非交和）は、主張の合成の段で行う。

  人手証明                                               このファイル
  閉路の閉歩道 γ_C（閉じた非後退辺列、無向辺は相異なる）    `taggedCycleWalkData`・`taggedCycleMinWalk_injective`
  台 P_C は互いに素（claim_projected_cycle_distinct_edges と
  閉路の点の分離）                                        `taggedCycleWalk_edge_ne`
  claim_torus_quadratic_sign_polarization の反復             `torusQuadraticSign_walkFamily`（族の加法則）
  Σ_{C<C'} I_L(P_C, P_C') を閉路の順序で読む               `chainPairIntersectionSum_map_of_pairwise`
  claim_disjoint_walk_mutual_crossing_intersection           `closedWalkMutualCrossingNumber_eq_intersection`
  本文の式（上の横断数の和を指数へ足す）                   `taggedCycleFamily_quadraticSign`

指数の偶奇は `𝔽₂` の値の整数代表で読み、`(−1)` の冪へ戻す（`neg_one_pow_natCast_zmod_two_val`）。
住処は有限集合・`ℕ`・`𝔽₂`・`ℤ`・`Qbar` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.TaggedShortPairCrossingSplit
import Ising2DLambda.KacWard.WalkFamilyQuadraticSignProduct

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

variable {L : ℕ} [NeZero L]

/-- 狭義昇順の列について、列の前後で読んだ `Σ_{i<j} I_L(C_i, C_j)` は、添字の順序で読んだ対の和に等しい。 -/
theorem chainPairIntersectionSum_map_of_pairwise {ι : Type*} [LinearOrder ι]
    (f : ι → Finset (Edge L)) :
    ∀ l : List ι, l.Pairwise (· < ·) →
      chainPairIntersectionSum (l.map f) =
        ∑ a ∈ l.toFinset, ∑ b ∈ l.toFinset,
          if a < b then evenEdgeChainIntersection L (f a) (f b) else 0
  | [], _ => by simp [chainPairIntersectionSum]
  | x :: xs, h => by
    obtain ⟨hx, hxs⟩ := List.pairwise_cons.mp h
    have hnot : x ∉ xs.toFinset := fun hm => lt_irrefl x (hx x (List.mem_toFinset.mp hm))
    have hnd : xs.Nodup := hxs.imp ne_of_lt
    rw [List.map_cons, chainPairIntersectionSum, chainPairIntersectionSum_map_of_pairwise f xs hxs,
      List.toFinset_cons, Finset.sum_insert hnot, List.map_map]
    congr 1
    · -- 先頭の閉路と残りの閉路の対: 先頭は残りのどれよりも小さい
      rw [Finset.sum_insert hnot, if_neg (lt_irrefl x), zero_add, List.sum_toFinset _ hnd]
      congr 1
      refine List.map_congr_left fun b hb => ?_
      simp [hx b hb]
    · -- 残りの閉路どうしの対: 先頭との対は順序で落ちる
      refine Finset.sum_congr rfl fun a ha => ?_
      rw [Finset.sum_insert hnot, if_neg (not_lt_of_gt (hx a (List.mem_toFinset.mp ha))), zero_add]

section Cycles

variable (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))

omit [NeZero L] in
/-- 閉路の点は、添字を周期で割った余りで読める。 -/
theorem taggedCyclePoint_mod (m : TaggedActive D t) (j : ℕ) :
    taggedCyclePoint D t m j =
      taggedCyclePoint D t m (j % finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m) := by
  obtain ⟨_, _, hper⟩ := taggedCycle_period D t m
  unfold taggedCyclePoint
  exact congrArg Subtype.val
    (periodic_eq_mod (fun j => finiteMapIterate (concreteAlternatingSuccessor D t) j m) _
      (fun r => by rw [finiteMapIterate_add, hper]) j)

omit [NeZero L] in
/-- 相異なる閉路の点は相異なる。 -/
theorem taggedCyclePoint_ne_of_ne (m m' : TaggedActive D t) (hm : m ∈ taggedCycleMinima D t)
    (hm' : m' ∈ taggedCycleMinima D t) (hne : m ≠ m') (j j' : ℕ) :
    taggedCyclePoint D t m j ≠ taggedCyclePoint D t m' j' := by
  intro h
  rw [taggedCyclePoint_mod D t m j, taggedCyclePoint_mod D t m' j'] at h
  exact hne (taggedCyclePoint_inj D t m m' hm hm' _ _
    (Nat.mod_lt _ (taggedCycle_period D t m).1) (Nat.mod_lt _ (taggedCycle_period D t m').1) h).1

omit [NeZero L] in
/-- 射影した閉歩道の辺はその閉路の点である: `w_r = w_{r + k_C} = c(2(r + k_C − 1) + 1)`。 -/
theorem taggedCycleWalk_eq_point (m : TaggedActive D t) (hm : m ∈ taggedCycleMinima D t) (r : ℕ) :
    taggedCycleWalk D t m r =
      taggedCyclePoint D t m (2 * (r + taggedCycleLength D t m - 1) + 1) := by
  have hk := taggedCycleLength_pos D t m
  rw [← taggedCycleWalk_periodic D t m r]
  have h := (taggedCycleWalk_pair_points D t m hm (r + taggedCycleLength D t m - 1)).2.1
  rw [show r + taggedCycleLength D t m - 1 + 1 = r + taggedCycleLength D t m by omega] at h
  exact h

/-- 台 `P_C` は互いに素: 相異なる二つの交互閉路の射影した閉歩道は、無向辺を共有しない。 -/
theorem taggedCycleWalk_edge_ne (m m' : TaggedActive D t) (hm : m ∈ taggedCycleMinima D t)
    (hm' : m' ∈ taggedCycleMinima D t) (hne : m ≠ m') (r r' : ℕ) :
    (taggedCycleWalk D t m r).1 ≠ (taggedCycleWalk D t m' r').1 := by
  intro h
  have hrev : ∀ e f : OrientedEdge L, e.1 = f.1 → e = f ∨ e = reversal f := by
    rintro ⟨e, b⟩ ⟨f, c⟩ hef
    simp only at hef
    subst hef
    cases b <;> cases c <;> simp [reversal]
  rcases hrev _ _ h with heq | heq
  · -- 向きも一致するなら ι(w_r) = ι(w'_{r'})、すなわち c_C(2r) = c_{C'}(2r')
    have h2 := congrArg reversal heq
    rw [(taggedCycleWalk_pair_points D t m hm r).1, (taggedCycleWalk_pair_points D t m' hm' r').1] at h2
    exact taggedCyclePoint_ne_of_ne D t m m' hm hm' hne _ _ h2
  · -- 向きが逆なら ι(w_r) = w'_{r'}、すなわち c_C(2r) は C' の点
    have h2 := congrArg reversal heq
    rw [reversal_involutive, (taggedCycleWalk_pair_points D t m hm r).1,
      taggedCycleWalk_eq_point D t m' hm' r'] at h2
    exact taggedCyclePoint_ne_of_ne D t m m' hm hm' hne _ _ h2

omit [NeZero L] in
/-- 最小元で表した閉路の辺列 `γ_C` の無向辺は相異なる（`claim_projected_cycle_distinct_edges`）。 -/
theorem taggedCycleMinWalk_injective (m : TaggedActive D t) (hm : m ∈ taggedCycleMinima D t) :
    Function.Injective fun r => (taggedCycleFinWalk D t m (taggedCycleLength D t m - 1) r).1 := by
  obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp hm
  exact taggedCycleFinWalk_injective D t i _
    (by have := taggedCycleLength_pos D t
          (matchingPairComponentMinimum (concreteShortInvolution D t)
            (concreteLongInvolution D t) i); omega)

/-- 交互閉路（最小元 `m`）の閉歩道 `γ_C`（長さ `k_C`）。 -/
noncomputable def taggedCycleWalkData (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (m : {m // m ∈ taggedCycleMinima D t}) : ClosedNonbacktrackingWalkData L :=
  ⟨taggedCycleLength D t m.1 - 1, taggedCycleFinWalk D t m.1 (taggedCycleLength D t m.1 - 1),
    taggedCycleMinWalk_closed D t z s ht hterm m.1 m.2⟩

/-- 本文の証明の二つ目の式: 交互閉路の族について
    `Π_C χ_{a,b}(h(γ_C), v(γ_C)) (−1)^{c_C}
       = χ_{a,b}(⊕_C h(γ_C), ⊕_C v(γ_C)) (−1)^{Σ_C c_C + Σ_{C<C'} c_mut(γ_C, γ_C')}`。 -/
theorem taggedCycleFamily_quadraticSign (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (a b : Bool) :
    (∏ m ∈ (taggedCycleMinima D t).attach,
        ((torusQuadraticSign a b (decide ((taggedCycleWalkData D t z s ht hterm m).seam.1 = 1))
            (decide ((taggedCycleWalkData D t z s ht hterm m).seam.2 = 1)) : ℤ) : Qbar) *
          (-1 : Qbar) ^ (taggedCycleWalkData D t z s ht hterm m).crossing) =
      ((torusQuadraticSign a b
          (decide ((∑ m ∈ (taggedCycleMinima D t).attach,
            (taggedCycleWalkData D t z s ht hterm m).seam.1) % 2 = 1))
          (decide ((∑ m ∈ (taggedCycleMinima D t).attach,
            (taggedCycleWalkData D t z s ht hterm m).seam.2) % 2 = 1)) : ℤ) : Qbar) *
        (-1 : Qbar) ^ (∑ m ∈ (taggedCycleMinima D t).attach,
            (taggedCycleWalkData D t z s ht hterm m).crossing +
          ∑ q ∈ ((taggedCycleMinima D t).attach ×ˢ (taggedCycleMinima D t).attach).filter
              (fun q => q.1 < q.2),
            closedWalkMutualCrossingNumber
              (taggedCycleWalkData D t z s ht hterm q.1).walk
              (taggedCycleWalkData D t z s ht hterm q.1).closed
              (taggedCycleWalkData D t z s ht hterm q.2).walk
              (taggedCycleWalkData D t z s ht hterm q.2).closed) := by
  set M := taggedCycleMinima D t
  set γ := taggedCycleWalkData D t z s ht hterm
  set χ : ClosedNonbacktrackingWalkData L → Qbar := fun δ =>
    ((torusQuadraticSign a b (decide (δ.seam.1 = 1)) (decide (δ.seam.2 = 1)) : ℤ) : Qbar) with hχ
  set N := ∑ q ∈ (M.attach ×ˢ M.attach).filter (fun q => q.1 < q.2),
    closedWalkMutualCrossingNumber (γ q.1).walk (γ q.1).closed (γ q.2).walk (γ q.2).closed with hN
  -- 閉路を最小元の昇順に並べた列
  set l := M.attach.sort (· ≤ ·) with hl
  have hlt : l.Pairwise (· < ·) := List.sortedLT_iff_pairwise.mp (Finset.sortedLT_sort _)
  have hnd : l.Nodup := hlt.imp ne_of_lt
  have hlS : l.toFinset = M.attach := Finset.sort_toFinset _ _
  have hinj : ∀ δ ∈ l.map γ, Function.Injective fun r => (δ.walk r).1 := by
    intro δ hδ
    obtain ⟨m, _, rfl⟩ := List.mem_map.mp hδ
    exact taggedCycleMinWalk_injective D t m.1 m.2
  -- 族の加法則（claim_torus_quadratic_sign_polarization の反復）
  have hfam := torusQuadraticSign_walkFamily a b (l.map γ) hinj
  -- 列にわたる和・積は閉路の集合にわたる和・積
  have hsum1 : ((l.map γ).map fun δ => δ.seam.1).sum = ∑ m ∈ M.attach, (γ m).seam.1 := by
    rw [List.map_map, ← hlS, List.sum_toFinset _ hnd]
    rfl
  have hsum2 : ((l.map γ).map fun δ => δ.seam.2).sum = ∑ m ∈ M.attach, (γ m).seam.2 := by
    rw [List.map_map, ← hlS, List.sum_toFinset _ hnd]
    rfl
  have hprod : ((l.map γ).map χ).prod = ∏ m ∈ M.attach, χ (γ m) := by
    rw [List.map_map, ← hlS, List.prod_toFinset _ hnd]
    rfl
  -- Σ_{C<C'} I_L(P_C, P_C') = Σ_{C<C'} c_mut(γ_C, γ_C')（claim_disjoint_walk_mutual_crossing_intersection）
  have hpair : chainPairIntersectionSum ((l.map γ).map (·.support)) = ((N : ℕ) : ZMod 2) := by
    rw [List.map_map]
    rw [show ((·.support) ∘ γ) = fun m => (γ m).support from rfl,
      chainPairIntersectionSum_map_of_pairwise (fun m => (γ m).support) l hlt, hN]
    push_cast
    rw [Finset.sum_filter, Finset.sum_product]
    refine Finset.sum_congr (by ext x; simp [hl]) fun m _ =>
      Finset.sum_congr (by ext x; simp [hl]) fun m' _ => ?_
    split_ifs with hmm
    · exact (closedWalkMutualCrossingNumber_eq_intersection _ _ _ _
        (taggedCycleMinWalk_injective D t m.1 m.2) (taggedCycleMinWalk_injective D t m'.1 m'.2)
        (fun r r' => taggedCycleWalk_edge_ne D t m.1 m'.1 m.2 m'.2
          (fun h => (ne_of_lt hmm) (Subtype.ext h)) r.val r'.val)).symm
    · rfl
  rw [hsum1, hsum2, hprod, hpair, neg_one_pow_natCast_zmod_two_val] at hfam
  have hsq : (-1 : Qbar) ^ N * (-1 : Qbar) ^ N = 1 := by
    rw [← pow_add, ← two_mul, pow_mul]
    norm_num
  calc (∏ m ∈ M.attach, χ (γ m) * (-1 : Qbar) ^ (γ m).crossing)
      -- 有限積の分配律と、(−1) の冪の積は指数の和の冪
      = (∏ m ∈ M.attach, χ (γ m)) * (-1 : Qbar) ^ (∑ m ∈ M.attach, (γ m).crossing) := by
        rw [Finset.prod_mul_distrib, Finset.prod_pow_eq_pow_sum]
    -- (−1)^N (−1)^N = 1 を挟む
    _ = ((-1 : Qbar) ^ N * ∏ m ∈ M.attach, χ (γ m)) *
          ((-1 : Qbar) ^ (∑ m ∈ M.attach, (γ m).crossing) * (-1 : Qbar) ^ N) := by
        rw [show ((-1 : Qbar) ^ N * ∏ m ∈ M.attach, χ (γ m)) *
            ((-1 : Qbar) ^ (∑ m ∈ M.attach, (γ m).crossing) * (-1 : Qbar) ^ N) =
            (∏ m ∈ M.attach, χ (γ m)) * (-1 : Qbar) ^ (∑ m ∈ M.attach, (γ m).crossing) *
              ((-1 : Qbar) ^ N * (-1 : Qbar) ^ N) by ring, hsq, mul_one]
    -- 族の加法則と指数の加法則
    _ = _ := by
        rw [← hfam, ← pow_add]

end Cycles

end Ising2DLambda.KacWard
