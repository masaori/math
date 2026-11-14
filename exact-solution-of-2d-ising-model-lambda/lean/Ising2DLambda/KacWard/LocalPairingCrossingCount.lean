import Ising2DLambda.KacWard.LocalPairingTaggedMatchingCorrespondence
import Ising2DLambda.KacWard.TaggedShortPairCrossingSplit

/-!
`claim_local_pairing_signed_sum`（偶部分グラフ上の局所対合の符号付き和は一である）の
二つ目の等式のうち、横断数の一致 `t(D,T) = t_P(κ)` の段と、二つの等式の合成の具体版。

人手証明の段落「各交差は同じ頂点の四方向を全て使う二本の直進通過なので、その個数は
`Σ_v c_v(κ_v) = t_P(κ) = t(D,T)` である」と、それに続く合成との対応:

* `shortPairsTransverse_iff_straight`（一歩の回転数が零であることは `stepTurning_eq_zero_iff`）: 二つの短い対が横断するのは、始点が等しく、ともに直進し
  （後の半辺の方向番号が先の半辺の方向番号に二を足したもの）、方向軸が異なるときである
  （`def_transverse_crossing`。反転は方向番号を二だけ進める `claim_reversal_direction_shift`）。
* `shortPair_port_form`・`shortPair_directions`: 非零項の短い対は、始点 `v` の選んだ方向番号 `i` の
  半辺と、対合族が指す方向番号 `κ_v(i)` の半辺の組である（`claim_tagged_matching_local_pairs`）。
* `localPairing_straight_pair_crossing`・`localPairing_crossing_straight`: 方向番号 `Fin 4` の上の
  有限の確認。異なる方向軸の二本の直進通過があるのは `S_v(P)=I` かつ `κ_v(0)=2, κ_v(1)=3` のとき
  だけで、そのとき四つの方向番号は全て直進の対に入る。
* `shortPairs_not_transverse_of_noncrossing`・`vertexShortPairs_of_crossing`:
  `c_v(κ_v)=0` の頂点を始点とする短い対はどれとも横断せず、`c_v(κ_v)=1` の頂点を始点とする短い対は
  横断する二つの対のどちらかである。
* `shortPairCrossingNumber_eq_localPairingCrossingCount`: 横断する順序のない対を頂点ごとの束に分け、
  束の大きさが `c_v(κ_v)` であることから `t(D,T) = t_P(κ)`。
* `nonzeroTaggedMatchings_signed_crossing_sum_eq_one`: 一対一対応による和の再添字付け
  （`nonzeroTaggedMatchings_sum_eq_localPairing_sum`）と一つ目の等式
  （`localPairingFamilies_signed_sum_eq_one`）の合成。

順序のない対は、`shortPairCrossingNumber` と同じく第一成分の小さい側を先に置いた対で数える。
住処は有限集合と `ℕ`・`ℤ` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.TransferMatrix Ising2DLambda.FisherZero

variable {L : ℕ} [NeZero L]

/-- 同じ始点の相異なる二つの半辺の対どうしの横断は、始点の一致・両方の直進・方向軸の違いである。 -/
theorem shortPairsTransverse_iff_straight (p q : OrientedEdge L × OrientedEdge L)
    (hp : orientedSource p.2 = orientedSource p.1) (hpne : p.2 ≠ p.1)
    (hq : orientedSource q.2 = orientedSource q.1) (hqne : q.2 ≠ q.1) :
    shortPairsTransverse p q ↔
      orientedSource p.1 = orientedSource q.1 ∧
        directionNumber p.2 = directionNumber p.1 + 2 ∧
        directionNumber q.2 = directionNumber q.1 + 2 ∧
        directionAxis (directionNumber p.1) ≠ directionAxis (directionNumber q.1) := by
  have hsucc : ∀ r : OrientedEdge L × OrientedEdge L, orientedSource r.2 = orientedSource r.1 →
      r.2 ≠ r.1 → r.2 ∈ nonbacktrackingSuccessors (reversal r.1) := by
    intro r hr hrne
    refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_, ?_⟩
    · rw [orientedTarget_reversal, hr]
    · rw [reversal_involutive]
      exact hrne
  unfold shortPairsTransverse edgeTransverseCrossing
  rw [stepTurning_eq_zero_iff _ _ (hsucc p hp hpne), stepTurning_eq_zero_iff _ _ (hsucc q hq hqne),
    orientedTarget_reversal, orientedTarget_reversal, directionNumber_reversal,
    directionNumber_reversal, directionAxis_add_two, directionAxis_add_two]
  constructor
  · rintro ⟨_, _, hv, h1, h2, h3⟩
    exact ⟨hv, h1, h2, h3⟩
  · rintro ⟨hv, h1, h2, h3⟩
    exact ⟨hsucc p hp hpne, hsucc q hq hqne, hv, h1, h2, h3⟩

theorem orientedSource_portEquiv_symm (v : Vertex L) (i : Fin 4) :
    orientedSource (portEquiv.symm (v, i)) = v := by
  have h₀ := congrArg Prod.fst (Equiv.apply_symm_apply portEquiv (v, i))
  rw [portEquiv_apply] at h₀
  exact h₀

/-- 方向番号は、全単射 `portEquiv` の方向番号 `Fin 4` を `ZMod 4` へ送ったものである。 -/
theorem directionNumber_eq_port (h : OrientedEdge L) :
    directionNumber h = ZMod.finEquiv 4 (portEquiv h).2 := by
  rw [portEquiv_apply]
  simp

theorem directionNumber_portEquiv_symm (v : Vertex L) (i : Fin 4) :
    directionNumber (portEquiv.symm (v, i)) = ZMod.finEquiv 4 i := by
  rw [directionNumber_eq_port, Equiv.apply_symm_apply]

/-- 異なる方向軸の二本の直進通過があるのは、四つの方向が全て選ばれ、`κ(0)=2, κ(1)=3` のときだけである。 -/
theorem localPairing_straight_pair_crossing (S : Finset (Fin 4)) (κ : Fin 4 → Fin 4)
    (hκ : κ ∈ localPairingChoices S) (i j : Fin 4) (hi : i ∈ S) (hj : j ∈ S)
    (hsi : ZMod.finEquiv 4 (κ i) = ZMod.finEquiv 4 i + 2)
    (hsj : ZMod.finEquiv 4 (κ j) = ZMod.finEquiv 4 j + 2)
    (hax : directionAxis (ZMod.finEquiv 4 i) ≠ directionAxis (ZMod.finEquiv 4 j)) :
    S = Finset.univ ∧ κ 0 = 2 ∧ κ 1 = 3 := by
  revert S κ i j
  decide +kernel

/-- `κ(0)=2, κ(1)=3` の対合では、四つの方向番号は全て直進の対に入る。 -/
theorem localPairing_crossing_straight (κ : Fin 4 → Fin 4)
    (hκ : κ ∈ localPairingChoices Finset.univ) (h0 : κ 0 = 2) (h1 : κ 1 = 3) (i : Fin 4) :
    ZMod.finEquiv 4 (κ i) = ZMod.finEquiv 4 i + 2 := by
  revert κ i
  decide +kernel

open scoped Classical

section Term

variable {z : Qbar} {s : SpinStructure} {D : PerfectMatching (OrientedEdge L)}
  {t : Finset (OrientedEdge L × OrientedEdge L)}

/-- 非零項の短い標識の対は、始点の選んだ方向番号 `i` の半辺と、対合族が指す `κ_v(i)` の半辺の組である。 -/
theorem shortPair_port_form (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (κ : Vertex L → Fin 4 → Fin 4)
    (hmate : ∀ v i, i ∈ selectedPortNumbers (taggedComplementEdges D t) v →
      perfectMatchingMate D (portEquiv.symm (v, i)) = portEquiv.symm (v, κ v i))
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ t) :
    (portEquiv p.1).2 ∈ selectedPortNumbers (taggedComplementEdges D t) (orientedSource p.1) ∧
      p.1 = portEquiv.symm (orientedSource p.1, (portEquiv p.1).2) ∧
      p.2 = portEquiv.symm (orientedSource p.1, κ (orientedSource p.1) (portEquiv p.1).2) := by
  obtain ⟨hLong, _⟩ := taggedMatching_nonzero_term_support z s D t hterm
  have hP : p.1.1 ∈ taggedComplementEdges D t :=
    (complement_iff_short_endpoint D t ht hLong p.1).mpr ⟨p, hp, Or.inl rfl⟩
  have hsel : (portEquiv p.1).2 ∈
      selectedPortNumbers (taggedComplementEdges D t) (orientedSource p.1) :=
    (base_mem_iff_port_selected _ p.1).mp hP
  have hpD := Finset.mem_filter.mp (ht hp)
  have hmate₁ : perfectMatchingMate D p.1 = p.2 :=
    perfectMatchingMate_eq_of_pair D p.1 p.2 hpD.2.1.ne' hpD.2.2
  have h1 : p.1 = portEquiv.symm (orientedSource p.1, (portEquiv p.1).2) :=
    (Equiv.symm_apply_apply portEquiv p.1).symm
  refine ⟨hsel, h1, ?_⟩
  rw [← hmate₁, ← hmate (orientedSource p.1) (portEquiv p.1).2 hsel]
  exact congrArg _ h1

/-- 短い標識の対の二つの半辺の方向番号。 -/
theorem shortPair_directions (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (κ : Vertex L → Fin 4 → Fin 4)
    (hmate : ∀ v i, i ∈ selectedPortNumbers (taggedComplementEdges D t) v →
      perfectMatchingMate D (portEquiv.symm (v, i)) = portEquiv.symm (v, κ v i))
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ t) :
    directionNumber p.1 = ZMod.finEquiv 4 (portEquiv p.1).2 ∧
      directionNumber p.2 =
        ZMod.finEquiv 4 (κ (orientedSource p.1) (portEquiv p.1).2) := by
  refine ⟨directionNumber_eq_port p.1, ?_⟩
  rw [(shortPair_port_form ht hterm κ hmate p hp).2.2, directionNumber_portEquiv_symm]

/-- 短い対が頂点 `v` の方向番号 `k` の半辺を含むなら、その対の先の半辺の方向番号は `k` か `κ_v` で `k` に移る。 -/
theorem shortPair_port_of_mem (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (κ : Vertex L → Fin 4 → Fin 4)
    (hmate : ∀ v i, i ∈ selectedPortNumbers (taggedComplementEdges D t) v →
      perfectMatchingMate D (portEquiv.symm (v, i)) = portEquiv.symm (v, κ v i))
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ t) (v : Vertex L) (hv : orientedSource p.1 = v)
    (k : Fin 4) (hk : portEquiv.symm (v, k) = p.1 ∨ portEquiv.symm (v, k) = p.2) :
    (portEquiv p.1).2 = k ∨ κ v (portEquiv p.1).2 = k := by
  obtain ⟨_, h1, h2⟩ := shortPair_port_form ht hterm κ hmate p hp
  rw [hv] at h1 h2
  rcases hk with hk | hk
  · left
    rw [← hk, Equiv.apply_symm_apply]
  · right
    rw [h2] at hk
    exact (Prod.mk.inj (portEquiv.symm.injective hk)).2.symm

/-- `c_v(κ_v) = 0` なら、頂点 `v` を始点とする短い対はどれとも横断しない。 -/
theorem shortPairs_not_transverse_of_noncrossing (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (κ : Vertex L → Fin 4 → Fin 4)
    (hκ : κ ∈ vertexLocalPairingChoices (taggedComplementEdges D t))
    (hmate : ∀ v i, i ∈ selectedPortNumbers (taggedComplementEdges D t) v →
      perfectMatchingMate D (portEquiv.symm (v, i)) = portEquiv.symm (v, κ v i))
    (v : Vertex L)
    (hc : ¬ (selectedPortNumbers (taggedComplementEdges D t) v = Finset.univ ∧
      κ v 0 = 2 ∧ κ v 1 = 3))
    (p : OrientedEdge L × OrientedEdge L) (hp : p ∈ t)
    (q : OrientedEdge L × OrientedEdge L) (hq : q ∈ t) (hv : orientedSource p.1 = v) :
    ¬ shortPairsTransverse p q := by
  obtain ⟨_, hShort⟩ := taggedMatching_nonzero_term_support z s D t hterm
  intro htr
  obtain ⟨hsrc, hsp, hsq, hax⟩ :=
    (shortPairsTransverse_iff_straight p q (hShort p hp).1 (hShort p hp).2
      (hShort q hq).1 (hShort q hq).2).mp htr
  obtain ⟨hdp1, hdp2⟩ := shortPair_directions ht hterm κ hmate p hp
  obtain ⟨hdq1, hdq2⟩ := shortPair_directions ht hterm κ hmate q hq
  have hip := (shortPair_port_form ht hterm κ hmate p hp).1
  have hiq := (shortPair_port_form ht hterm κ hmate q hq).1
  rw [hv] at hdp2 hip
  rw [← hsrc, hv] at hdq2 hiq
  rw [hdp1, hdp2] at hsp
  rw [hdq1, hdq2] at hsq
  rw [hdp1, hdq1] at hax
  exact hc (localPairing_straight_pair_crossing _ (κ v)
    ((vertexLocalPairingChoices_mem_iff _ κ).mp hκ v) _ _ hip hiq hsp hsq hax)

/-- `c_v(κ_v) = 1` なら、頂点 `v` を始点とする短い対は、横断する二つの対 `a`・`b` のどちらかである。 -/
theorem vertexShortPairs_of_crossing (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (κ : Vertex L → Fin 4 → Fin 4)
    (hκ : κ ∈ vertexLocalPairingChoices (taggedComplementEdges D t))
    (hmate : ∀ v i, i ∈ selectedPortNumbers (taggedComplementEdges D t) v →
      perfectMatchingMate D (portEquiv.symm (v, i)) = portEquiv.symm (v, κ v i))
    (v : Vertex L)
    (hc : selectedPortNumbers (taggedComplementEdges D t) v = Finset.univ ∧
      κ v 0 = 2 ∧ κ v 1 = 3) :
    ∃ a ∈ t, ∃ b ∈ t, orientedSource a.1 = v ∧ orientedSource b.1 = v ∧
      shortPairsTransverse a b ∧ a.1 ≠ b.1 ∧
      ∀ p ∈ t, orientedSource p.1 = v → p = a ∨ p = b := by
  obtain ⟨_, hShort⟩ := taggedMatching_nonzero_term_support z s D t hterm
  obtain ⟨hS, h0, h1⟩ := hc
  have hκv := (vertexLocalPairingChoices_mem_iff _ κ).mp hκ v
  rw [hS] at hκv
  have hinv := (Finset.mem_filter.mp hκv).2.2.2
  have h2 : κ v 2 = 0 := by rw [← h0, hinv]
  have h3 : κ v 3 = 1 := by rw [← h1, hinv]
  -- 方向番号 0 と 1 の半辺を含む短い対 `a`・`b`
  have hport : ∀ k : Fin 4, (portEquiv.symm (v, k)).1 ∈ taggedComplementEdges D t ∧
      orientedSource (portEquiv.symm (v, k)) = v := by
    intro k
    refine ⟨(mem_selectedPortNumbers_iff _ v k).mp ?_, orientedSource_portEquiv_symm v k⟩
    rw [hS]
    exact Finset.mem_univ k
  obtain ⟨a, ⟨ha, hva, hka⟩, hua⟩ :=
    (taggedMatching_local_pair_unique z s D t ht hterm v _).mp (hport 0)
  obtain ⟨b, ⟨hb, hvb, hkb⟩, hub⟩ :=
    (taggedMatching_local_pair_unique z s D t ht hterm v _).mp (hport 1)
  -- 頂点 `v` を始点とする短い対は `a` か `b` である
  have hab : ∀ p ∈ t, orientedSource p.1 = v → p = a ∨ p = b := by
    intro p hp hv
    obtain ⟨_, hp1, hp2⟩ := shortPair_port_form ht hterm κ hmate p hp
    rw [hv] at hp1 hp2
    generalize (portEquiv p.1).2 = i at hp1 hp2
    fin_cases i
    · exact Or.inl (hua p ⟨hp, hv, Or.inl hp1.symm⟩)
    · exact Or.inr (hub p ⟨hp, hv, Or.inl hp1.symm⟩)
    · exact Or.inl (hua p ⟨hp, hv, Or.inr (hp2.trans (by rw [← h2]; rfl)).symm⟩)
    · exact Or.inr (hub p ⟨hp, hv, Or.inr (hp2.trans (by rw [← h3]; rfl)).symm⟩)
  -- `a` と `b` は横断する
  have haxis : ∀ p ∈ t, orientedSource p.1 = v → ∀ k : Fin 4,
      (portEquiv.symm (v, k) = p.1 ∨ portEquiv.symm (v, k) = p.2) →
        directionAxis (directionNumber p.1) = directionAxis (ZMod.finEquiv 4 k) := by
    intro p hp hv k hk
    rw [directionNumber_eq_port]
    rcases shortPair_port_of_mem ht hterm κ hmate p hp v hv k hk with hi | hi
    · rw [hi]
    · rw [← hi, localPairing_crossing_straight (κ v) hκv h0 h1, directionAxis_add_two]
  have htrab : shortPairsTransverse a b := by
    apply (shortPairsTransverse_iff_straight a b (hShort a ha).1 (hShort a ha).2
      (hShort b hb).1 (hShort b hb).2).mpr
    obtain ⟨hda1, hda2⟩ := shortPair_directions ht hterm κ hmate a ha
    obtain ⟨hdb1, hdb2⟩ := shortPair_directions ht hterm κ hmate b hb
    rw [hva] at hda2
    rw [hvb] at hdb2
    refine ⟨hva.trans hvb.symm, ?_, ?_, ?_⟩
    · rw [hda1, hda2, localPairing_crossing_straight (κ v) hκv h0 h1]
    · rw [hdb1, hdb2, localPairing_crossing_straight (κ v) hκv h0 h1]
    · rw [haxis a ha hva 0 hka, haxis b hb hvb 1 hkb]
      decide
  have hne : a.1 ≠ b.1 := by
    intro heq
    have hax := ((shortPairsTransverse_iff_straight a b (hShort a ha).1 (hShort a ha).2
      (hShort b hb).1 (hShort b hb).2).mp htrab).2.2.2
    exact hax (by rw [heq])
  exact ⟨a, ha, b, hb, hva, hvb, htrab, hne, hab⟩

/-- 頂点ごとに数え直して `t(D,T) = t_P(κ)`: 横断する順序のない対を頂点ごとの束に分け、
    `c_v = 0` の頂点では束が空、`c_v = 1` の頂点では束が `{(a,b),(b,a)}` のうち第一成分の順に並ぶ一つ。 -/
theorem shortPairCrossingNumber_eq_localPairingCrossingCount (P : Finset (Edge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (hP : taggedComplementEdges D t = P)
    (κ : Vertex L → Fin 4 → Fin 4) (hκ : κ ∈ vertexLocalPairingChoices P)
    (hmate : ∀ v i, i ∈ selectedPortNumbers P v →
      perfectMatchingMate D (portEquiv.symm (v, i)) = portEquiv.symm (v, κ v i)) :
    shortPairCrossingNumber t = localPairingCrossingCount P κ := by
  subst hP
  obtain ⟨_, hShort⟩ := taggedMatching_nonzero_term_support z s D t hterm
  unfold shortPairCrossingNumber localPairingCrossingCount
  rw [Finset.card_eq_sum_card_fiberwise (f := fun pq => orientedSource pq.1.1)
    (t := Finset.univ) (fun _ _ => Finset.mem_univ _)]
  apply Finset.sum_congr rfl
  intro v _
  unfold localPairingCrossingIndicator
  split_ifs with hc
  · -- `c_v = 1`
    obtain ⟨a, ha, b, hb, hva, hvb, hab, hne, hcover⟩ :=
      vertexShortPairs_of_crossing ht hterm κ hκ hmate v hc
    have hfiber : ((t ×ˢ t).filter fun pq => pq.1.1 < pq.2.1 ∧ shortPairsTransverse pq.1 pq.2).filter
        (fun pq => orientedSource pq.1.1 = v) =
        ({(a, b), (b, a)} : Finset _).filter fun pq => pq.1.1 < pq.2.1 := by
      ext ⟨p, q⟩
      simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_insert,
        Finset.mem_singleton, Prod.mk.injEq]
      constructor
      · rintro ⟨⟨⟨hp, hq⟩, hlt, htr⟩, hv⟩
        have hvq : orientedSource q.1 = v :=
          (((shortPairsTransverse_iff_straight p q (hShort p hp).1 (hShort p hp).2
            (hShort q hq).1 (hShort q hq).2).mp htr).1).symm.trans hv
        refine ⟨?_, hlt⟩
        rcases hcover p hp hv with rfl | rfl <;> rcases hcover q hq hvq with rfl | rfl
        · exact absurd hlt (lt_irrefl _)
        · exact Or.inl ⟨rfl, rfl⟩
        · exact Or.inr ⟨rfl, rfl⟩
        · exact absurd hlt (lt_irrefl _)
      · rintro ⟨⟨rfl, rfl⟩ | ⟨rfl, rfl⟩, hlt⟩
        · exact ⟨⟨⟨ha, hb⟩, hlt, hab⟩, hva⟩
        · exact ⟨⟨⟨hb, ha⟩, hlt, edgeTransverseCrossing_symm hab⟩, hvb⟩
    rw [hfiber]
    rcases lt_or_gt_of_ne hne with h | h
    · simp [Finset.filter_insert, Finset.filter_singleton, h, not_lt.mpr h.le]
    · simp [Finset.filter_insert, Finset.filter_singleton, h, not_lt.mpr h.le]
  · -- `c_v = 0`
    rw [Finset.card_eq_zero]
    apply Finset.eq_empty_iff_forall_notMem.mpr
    rintro ⟨p, q⟩ hpq
    obtain ⟨hpq, hv⟩ := Finset.mem_filter.mp hpq
    obtain ⟨hmem, _, htr⟩ := Finset.mem_filter.mp hpq
    obtain ⟨hp, hq⟩ := Finset.mem_product.mp hmem
    exact shortPairs_not_transverse_of_noncrossing ht hterm κ hκ hmate v hc p hp q hq hv htr

end Term

/-- 対合族から作った項の横断数は `t_P(κ)` である。 -/
theorem localPairingTaggedMatching_crossingNumber (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (P : Finset (Edge L)) (κ : Vertex L → Fin 4 → Fin 4)
    (hκ : κ ∈ vertexLocalPairingChoices P) :
    shortPairCrossingNumber (localPairingTaggedMatching P κ hκ).2 =
      localPairingCrossingCount P κ := by
  obtain ⟨_, ht, hterm, hP⟩ := Finset.mem_filter.mp (localPairingTaggedMatching_mem z hz s P κ hκ)
  exact shortPairCrossingNumber_eq_localPairingCrossingCount P ht hterm hP κ hκ
    (localPairingTaggedMatching_mate P κ hκ)

/-- `claim_local_pairing_signed_sum` の二つ目の等式: 補辺が偶部分グラフ `P` に等しい非零の
    標識付き完全マッチングにわたる `(-1)^{t(D,T)}` の和は一である。 -/
theorem nonzeroTaggedMatchings_signed_crossing_sum_eq_one (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (P : Finset (Edge L)) (hP : IsEvenEdgeSubset L P) :
    ∑ x ∈ nonzeroTaggedMatchings z s P, (-1 : ℤ) ^ shortPairCrossingNumber x.2 = 1 := by
  calc
    ∑ x ∈ nonzeroTaggedMatchings z s P, (-1 : ℤ) ^ shortPairCrossingNumber x.2
        = ∑ κ ∈ vertexLocalPairingChoices P, (-1 : ℤ) ^ localPairingCrossingCount P κ := by
          -- 一対一対応による和の再添字付けと、その下での `t(D,T) = t_P(κ)`
          apply nonzeroTaggedMatchings_sum_eq_localPairing_sum z hz s P
          intro κ hκ
          rw [localPairingTaggedMatching_crossingNumber z hz s P κ hκ]
    _ = 1 := localPairingFamilies_signed_sum_eq_one P hP

end Ising2DLambda.KacWard
