/-
「非零項の位相は補辺の二次符号と短い対の横断数に等しい」（`claim_tagged_matching_quadratic_crossing_weight`）の
具体版。実際の非零項 `(D, T)` について

  `M_{D,T}(x) = χ_{a,b}(h(P), v(P)) (−1)^{t(D,T)} x^{|P|}`

を、本文の証明の式鎖の順に示す。閉路は最小元 `m ∈ taggedCycleMinima` で表す。

  人手証明                                               このファイル・引く具体版
  補辺 P の切断線偶奇 h(P), v(P)                           `edgeSetSeamParities`
  台 P_C は互いに素で P = ⊔_C P_C
  （claim_projected_cycle_distinct_edges・
   claim_projected_cycle_support_union）                   `taggedCycleBaseEdge_injOn`・
                                                         `taggedCycleBaseEdge_image`
  切断線偶奇は台の非交和で加わる                           `taggedCycleSeam_sum_mod`
  |P| = Σ_C k_C                                          `taggedComplementEdges_card`
  一つ目の式（横断対の分割）                               `shortPairCrossingNumber_cycleSplit`
  二つ目の式（閉路族の二次符号の積）                       `taggedCycleFamily_quadraticSign`
  式鎖の一行目（claim_tagged_matching_cycle_weight）        `taggedMatchingTerm_cycleWeight`
  式鎖の二・三行目（各閉路の因子）                         `taggedCyclePhase_quadraticSign`
  本文の主張                                             `taggedMatchingTerm_quadraticCrossingWeight`

住処は有限集合・`ℕ`・`ℤ`・`Qbar`・`Qbar[X]` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.TaggedCycleFamilyQuadraticSign
import Ising2DLambda.KacWard.TaggedComplementActiveVerticesConcrete
import Ising2DLambda.KacWard.TaggedComplementActiveVertices

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

variable {L : ℕ}

/-- 無向辺の集合 `P` の横・縦の切断線偶奇 `h(P), v(P) ∈ {0, 1}`。切断線指示子は向きに依らないので、
    無向辺 `e` を向き付き辺 `(e, false)` で読む。 -/
def edgeSetSeamParities (P : Finset (Edge L)) : ℕ × ℕ :=
  ((∑ e ∈ P, horizontalSeamParity ((e, false) : OrientedEdge L)) % 2,
    (∑ e ∈ P, verticalSeamParity ((e, false) : OrientedEdge L)) % 2)

/-- 切断線指示子は無向辺だけで決まる。 -/
theorem horizontalSeamParity_base (x : OrientedEdge L) :
    horizontalSeamParity x = horizontalSeamParity ((x.1, false) : OrientedEdge L) := rfl

/-- 切断線指示子は無向辺だけで決まる。 -/
theorem verticalSeamParity_base (x : OrientedEdge L) :
    verticalSeamParity x = verticalSeamParity ((x.1, false) : OrientedEdge L) := rfl

section Cycles

variable [NeZero L]
variable (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))

/-- 閉路の添字 `(C, r)` から、閉歩道 `γ_C` の第 `r` 辺の無向辺 `(w_r).1` への写像は単射である
    （各閉路の中は `claim_projected_cycle_distinct_edges`、相異なる閉路の間は台の非交）。 -/
theorem taggedCycleBaseEdge_injOn :
    Set.InjOn (fun a : (_ : TaggedActive D t) × ℕ => (taggedCycleWalk D t a.1 a.2).1)
      (taggedCycleIndices D t) := by
  rintro ⟨ma, ra⟩ ha ⟨mb, rb⟩ hb hab
  obtain ⟨hma, hra⟩ := Finset.mem_sigma.mp ha
  obtain ⟨hmb, hrb⟩ := Finset.mem_sigma.mp hb
  have hra' : ra < taggedCycleLength D t ma := Finset.mem_range.mp hra
  have hrb' : rb < taggedCycleLength D t mb := Finset.mem_range.mp hrb
  by_cases hm : ma = mb
  · subst hm
    have hk := taggedCycleLength_pos D t ma
    have hinj := taggedCycleMinWalk_injective D t ma hma
    have hr := congrArg Fin.val
      (@hinj ⟨ra, by omega⟩ ⟨rb, by omega⟩ hab)
    simp only at hr
    subst hr
    rfl
  · exact absurd hab (taggedCycleWalk_edge_ne D t ma mb hma hmb hm ra rb)

/-- 閉路の辺の無向辺の全体は補辺 `P` に等しい（`claim_projected_cycle_support_union`）。 -/
theorem taggedCycleBaseEdge_image (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    (taggedCycleIndices D t).image (fun a => (taggedCycleWalk D t a.1 a.2).1) =
      taggedComplementEdges D t := by
  ext e
  constructor
  · -- 閉路の辺 `w_r = ι(c(2r))` の無向辺は、活性な点 `c(2r)` の無向辺なので P に入る
    intro he
    obtain ⟨a, _, rfl⟩ := Finset.mem_image.mp he
    exact (taggedComplement_iff_active_concrete z s D t ht hterm
      (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * a.2) a.1).1).2
      (by rw [taggedActiveByLabels_eq_concreteTaggedActiveVertices D t]
          exact (finiteMapIterate (concreteAlternatingSuccessor D t) (2 * a.2) a.1).2)
  · -- P の辺 e について (e, false) は活性で、その閉路の偶数番目か奇数番目の点である
    intro he
    let a0 : OrientedEdge L := (e, false)
    have hact : a0 ∈ concreteTaggedActiveVertices D t := by
      rw [← taggedActiveByLabels_eq_concreteTaggedActiveVertices D t]
      exact (taggedComplement_iff_active_concrete z s D t ht hterm a0).1 he
    let τ := concreteShortInvolution D t
    let υ := concreteLongInvolution D t
    let xx : TaggedActive D t := ⟨a0, hact⟩
    let m := matchingPairComponentMinimum τ υ xx
    have hm : m ∈ taggedCycleMinima D t := Finset.mem_image_of_mem _ (Finset.mem_univ _)
    have horbit : xx ∈ finitePermutationOrbit (concreteAlternatingSuccessor D t) m := by
      change xx ∈ finitePermutationOrbit (matchingPairPermutation τ υ) m
      rw [matchingPairPermutation_orbit_eq_component,
        matchingPairComponent_basepoint τ υ xx m (matchingPairComponentMinimum_mem τ υ xx)]
      exact Or.inl (finitePermutationOrbit_self_mem _ _)
    obtain ⟨j, hj⟩ := (finitePermutationOrbitEnumeration_bijective
      (concreteAlternatingSuccessor D t) m).2 ⟨xx, horbit⟩
    have hjval : taggedCyclePoint D t m j.val = a0 := congrArg (fun y => y.1.1) hj
    have hjlt : j.val < 2 * taggedCycleLength D t m := by
      rw [← taggedCycle_period_eq D t m]
      exact j.isLt
    have hk := taggedCycleLength_pos D t m
    apply Finset.mem_image.mpr
    rcases Nat.even_or_odd j.val with ⟨q, hq⟩ | ⟨q, hq⟩
    · -- j = 2q: ι(w_q) = c(2q) = (e, false)
      refine ⟨⟨m, q⟩, Finset.mem_sigma.mpr ⟨hm, Finset.mem_range.mpr
        (show q < taggedCycleLength D t m by omega)⟩, ?_⟩
      have h1 := (taggedCycleWalk_pair_points D t m hm q).1
      rw [show 2 * q = j.val by omega, hjval] at h1
      have h2 := congrArg (fun x : OrientedEdge L => x.1) h1
      simpa [reversal, a0] using h2
    · -- j = 2q + 1: w_{q+1} = c(2q+1) = (e, false)。添字は周期 k_C で読み直す
      refine ⟨⟨m, (q + 1) % taggedCycleLength D t m⟩,
        Finset.mem_sigma.mpr ⟨hm, Finset.mem_range.mpr (Nat.mod_lt _ hk)⟩, ?_⟩
      have h2 := (taggedCycleWalk_pair_points D t m hm q).2.1
      rw [show 2 * q + 1 = j.val by omega, hjval,
        periodic_eq_mod (taggedCycleWalk D t m) _ (taggedCycleWalk_periodic D t m) (q + 1)] at h2
      simp only
      rw [h2]

/-- 閉歩道 `γ_C` の辺列に沿う指示子の和は、閉路の添字にわたる和である。 -/
theorem taggedCycleFinWalk_indicator_sum (c : OrientedEdge L → ℕ) (m : TaggedActive D t) :
    ((List.ofFn (taggedCycleFinWalk D t m (taggedCycleLength D t m - 1))).map c).sum =
      ∑ r ∈ Finset.range (taggedCycleLength D t m), c (taggedCycleWalk D t m r) := by
  have hk := taggedCycleLength_pos D t m
  rw [List.map_ofFn, List.sum_ofFn, ← Fin.sum_univ_eq_sum_range (fun r => c (taggedCycleWalk D t m r)),
    show taggedCycleLength D t m = taggedCycleLength D t m - 1 + 1 by omega]
  rfl

/-- 切断線偶奇は台の非交和で加わる: 閉路ごとの切断線偶奇の和の偶奇は、補辺の切断線偶奇に等しい。 -/
theorem taggedCycleSeam_sum_mod (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    (∑ m ∈ (taggedCycleMinima D t).attach,
        (taggedCycleWalkData D t z s ht hterm m).seam.1) % 2 =
      (edgeSetSeamParities (taggedComplementEdges D t)).1 ∧
    (∑ m ∈ (taggedCycleMinima D t).attach,
        (taggedCycleWalkData D t z s ht hterm m).seam.2) % 2 =
      (edgeSetSeamParities (taggedComplementEdges D t)).2 := by
  have key : ∀ c : OrientedEdge L → ℕ, (∀ x : OrientedEdge L, c x = c ((x.1, false) : OrientedEdge L)) →
      (∑ m ∈ (taggedCycleMinima D t).attach,
          ((List.ofFn (taggedCycleWalkData D t z s ht hterm m).walk).map c).sum % 2) % 2 =
        (∑ e ∈ taggedComplementEdges D t, c ((e, false) : OrientedEdge L)) % 2 := by
    intro c hc
    rw [← Finset.sum_nat_mod, ← taggedCycleBaseEdge_image D t z s ht hterm,
      Finset.sum_image (taggedCycleBaseEdge_injOn D t)]
    congr 1
    rw [taggedCycleIndices, Finset.sum_sigma,
      ← Finset.sum_attach (taggedCycleMinima D t)]
    refine Finset.sum_congr rfl fun m _ => ?_
    exact (taggedCycleFinWalk_indicator_sum D t c m.1).trans (Finset.sum_congr rfl fun r _ => hc _)
  refine ⟨?_, ?_⟩
  · simp only [ClosedNonbacktrackingWalkData.seam, edgeSequenceSeamParities_apply, edgeSetSeamParities]
    exact key horizontalSeamParity horizontalSeamParity_base
  · simp only [ClosedNonbacktrackingWalkData.seam, edgeSequenceSeamParities_apply, edgeSetSeamParities]
    exact key verticalSeamParity verticalSeamParity_base

/-- 台の非交和: `|P| = Σ_C k_C`。 -/
theorem taggedComplementEdges_card (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    (taggedComplementEdges D t).card =
      ∑ m ∈ (taggedCycleMinima D t).attach, taggedCycleLength D t m.1 := by
  rw [← taggedCycleBaseEdge_image D t z s ht hterm,
    Finset.card_image_of_injOn (taggedCycleBaseEdge_injOn D t), taggedCycleIndices,
    Finset.card_sigma, ← Finset.sum_attach (taggedCycleMinima D t)]
  simp only [Finset.card_range]

/-- 式鎖の二・三行目を最小元で表した閉路について読んだ形:
    `−Π_r ε(w_{r+1}) ρ(w_r, w_{r+1}) = χ_{a,b}(h(γ_C), v(γ_C)) (−1)^{c_C}`。 -/
theorem taggedCyclePhase_quadraticSign_minimum {z : Qbar} (hz4 : z ^ 4 = -1) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (m : {m // m ∈ taggedCycleMinima D t}) :
    -taggedCyclePhase z s D t m.1 =
      ((torusQuadraticSign s.1 s.2 (decide ((taggedCycleWalkData D t z s ht hterm m).seam.1 = 1))
          (decide ((taggedCycleWalkData D t z s ht hterm m).seam.2 = 1)) : ℤ) : Qbar) *
        (-1 : Qbar) ^ (taggedCycleWalkData D t z s ht hterm m).crossing := by
  obtain ⟨m, hm⟩ := m
  obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp hm
  have hn : taggedCycleLength D t
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i) =
      (taggedCycleLength D t
        (matchingPairComponentMinimum (concreteShortInvolution D t)
          (concreteLongInvolution D t) i) - 1) + 1 := by
    have := taggedCycleLength_pos D t
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i)
    omega
  exact taggedCyclePhase_quadraticSign D t hz4 s ht hterm i _ hn

/-- 本文の主張: 非零項 `(D, T)` について `M_{D,T}(x) = χ_{a,b}(h(P), v(P)) (−1)^{t(D,T)} x^{|P|}`。
    `P` は補辺 `taggedComplementEdges D t`、`t(D,T)` は短い標識の対の横断対の個数 `shortPairCrossingNumber t`。 -/
theorem taggedMatchingTerm_quadraticCrossingWeight (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    matchingSignPolynomial D *
        ((-1 : Polynomial Qbar) ^ t.card *
          (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
          (∏ p ∈ t, gaugedShortContribution z s p)) =
      qbarConst (((torusQuadraticSign s.1 s.2
          (decide ((edgeSetSeamParities (taggedComplementEdges D t)).1 = 1))
          (decide ((edgeSetSeamParities (taggedComplementEdges D t)).2 = 1)) : ℤ) : Qbar) *
        (-1 : Qbar) ^ shortPairCrossingNumber t) *
      Polynomial.X ^ (taggedComplementEdges D t).card := by
  have hseam := taggedCycleSeam_sum_mod D t z s ht hterm
  have hcard := taggedComplementEdges_card D t z s ht hterm
  have hsplit := shortPairCrossingNumber_cycleSplit D t z s ht hterm
  have hfam := taggedCycleFamily_quadraticSign D t z s ht hterm s.1 s.2
  -- 列の積を閉路の集合にわたる積へ移す
  have hlist : ∀ (F : TaggedActive D t → Polynomial Qbar) (l : List (TaggedActive D t)),
      l.Nodup → l.toFinset = taggedCycleMinima D t →
        (l.map F).prod = ∏ m ∈ (taggedCycleMinima D t).attach, F m.1 := by
    intro F l hnd hl
    rw [Finset.prod_attach (taggedCycleMinima D t) F, ← hl, List.prod_toFinset F hnd]
  -- 式鎖の一行目（claim_tagged_matching_cycle_weight）
  rw [taggedMatchingTerm_cycleWeight z hz s D t ht hterm]
  calc _
    _ = ∏ m ∈ (taggedCycleMinima D t).attach, Polynomial.X ^ taggedCycleLength D t m.1 *
          qbarConst (((torusQuadraticSign s.1 s.2
              (decide ((taggedCycleWalkData D t z s ht hterm m).seam.1 = 1))
              (decide ((taggedCycleWalkData D t z s ht hterm m).seam.2 = 1)) : ℤ) : Qbar) *
            (-1 : Qbar) ^ (taggedCycleWalkData D t z s ht hterm m).crossing) := by
        -- 式鎖の二・三行目（各閉路の因子）
        refine (hlist _ _ (by convert Finset.sort_nodup (taggedCycleMinima D t) (· ≤ ·))
          (by convert Finset.sort_toFinset (taggedCycleMinima D t) (· ≤ ·))).trans ?_
        refine Finset.prod_congr rfl fun m _ => ?_
        rw [← taggedCyclePhase_quadraticSign_minimum D t hz s ht hterm m]
        simp only [taggedCyclePhase, qbarConst, Polynomial.C_neg]
        ring
    _ = Polynomial.X ^ (∑ m ∈ (taggedCycleMinima D t).attach, taggedCycleLength D t m.1) *
          qbarConst (∏ m ∈ (taggedCycleMinima D t).attach,
            ((torusQuadraticSign s.1 s.2
              (decide ((taggedCycleWalkData D t z s ht hterm m).seam.1 = 1))
              (decide ((taggedCycleWalkData D t z s ht hterm m).seam.2 = 1)) : ℤ) : Qbar) *
            (-1 : Qbar) ^ (taggedCycleWalkData D t z s ht hterm m).crossing) := by
        -- 有限積の分配律と、X の冪の積は指数の和の冪
        simp only [qbarConst]
        rw [Finset.prod_mul_distrib, Finset.prod_pow_eq_pow_sum, map_prod]
    _ = Polynomial.X ^ (taggedComplementEdges D t).card *
          qbarConst (((torusQuadraticSign s.1 s.2
            (decide ((edgeSetSeamParities (taggedComplementEdges D t)).1 = 1))
            (decide ((edgeSetSeamParities (taggedComplementEdges D t)).2 = 1)) : ℤ) : Qbar) *
          (-1 : Qbar) ^ shortPairCrossingNumber t) := by
        -- 閉路族の二次符号の積、横断対の分割、台の非交和
        rw [hfam, hsplit, ← hseam.1, ← hseam.2, hcard]
        rfl
    _ = _ := mul_comm _ _

end Cycles

end Ising2DLambda.KacWard
