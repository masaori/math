/-
「横断のない閉歩道の回転位相は頂点単純閉路族の位相と交差形式に還元される」
（`claim_crossing_free_contact_elimination_phase`）の具体版。辺の標識が相異なり横断数が零の、実際の閉じた
非後退辺列 `γ : Fin (m + 1) → OrientedEdge L` について、接触点分割 `smoothedSplitWalkA`・`smoothedSplitWalkB`
（閉性は `contactSplitWalkA_closed`・`contactSplitWalkB_closed`）を接触対数についての整礎帰納法で繰り返し、
頂点単純で横断のない閉じた非後退辺列の族を作る。本文の `ζ_8` は `z ^ 4 = -1` を満たす `z : Qbar`。

族 `(δ_i)_{1≤i≤n}` は横断消去の帰納法の具体版と同じく `ClosedNonbacktrackingWalkData L` のリストで表し、
台の合併は `chainListUnion`、`Σ_{1≤i<j≤n} I_L(C_i, C_j)` は `chainPairIntersectionSum` で表す。
符号の指数は `ZMod 2` の値の整数代表 `ZMod.val` で読む。

人手証明との対応:
- 「`n_ct(γ) = 0` なら `n = 1`、`δ_1 = γ`」: `crossing_free_contact_elimination_phase` の基底。各子の通過する
  頂点が相異なることは、接触対数が零であることの言い換え `contactPairCount_eq_zero_iff_pass_vertices_injective`。
- 「接触対 `k < l` を一つ選ぶ」: `exists_contact_pair_of_contactPairCount_pos`。
- 「二本の台は互いに素で元の台を尽くす」: `smoothedSplitWalks_support_disjoint`・`smoothedSplitWalks_support_union`。
- 「`claim_crossing_free_contact_split_children` により両子の横断数は零である」:
  `crossing_free_contact_split_children`。二本の辺の標識が相異なることは `smoothedSplitWalkA_edge_injective`・
  `smoothedSplitWalkB_edge_injective`。
- 接触対数の式鎖の二行目 `claim_contact_split_pair_descent` を実際の二本へ当てたもの:
  `contact_split_walks_pair_descent`。本文のその主張の証明と同じく、接触対の集合を「両方が区間 `(k, l]` に
  属する」部分 `S_A`、「両方が属さない」部分 `S_B` と残りに分け、子の接触対を `S_A`・`S_B` へ 1 対 1 に
  送り（`contactPairCount_reindex`。順序なしの対として数えるので、位置の対を小さい添字から並べ直す
  `orderedIndexPair` で送る）、選んだ接触対 `(k, l)` が残りに属することから狭義の不等号を得る。
  一行目（`n_ct(γ_B) ∈ ℕ` を足す）は `Nat.le_add_right`・`Nat.le_add_left`。
- 「両族を連結して `(δ_i)_{1≤i≤p+q}` と置く」: リストの連結 `αs ++ βs`。台の分割は `chainListUnion_append`・
  `subset_chainListUnion`。
- 切断線偶奇の式の一行目「二本への帰納法の仮定と有限和の分割」: `List.sum_append` と `Nat.add_mod`。
  二行目 `claim_contact_split_seam_parity`: `closedWalk_smoothing_split_seam_parity`（添字区間による二本の
  切断線偶奇の和で、接触か横断かに依らない）。
- 「交差形式の分配」: `evenEdgeChainIntersection_chainListUnion`。
- 位相の式の一行目 `claim_crossing_free_contact_split_phase`: `crossing_free_contact_split_phase`。
  二行目「二本への帰納法の仮定」、三行目「交差形式の分配、有限積の分割、`𝔽₂` の加法」:
  `zpow_add₀`、`List.prod_append`、`neg_one_pow_zmod_two_val_add`（`(−1)` の冪の指数を `𝔽₂` の和で足す）と
  `chainPairIntersectionSum_append`。
-/
import Ising2DLambda.KacWard.CrossingFreeContactSplitPhase
import Ising2DLambda.KacWard.EdgeDistinctCrossingEliminationParity
import Ising2DLambda.KacWard.ContactPairCount

namespace Ising2DLambda.KacWard

open Finset
open Ising2DLambda.PartitionPolynomial
open Ising2DLambda.AlgebraicEigenvalue

variable {L m : ℕ} [NeZero L]

section PairCount

/-- 二つの添字を小さい方から並べた対（接触対を順序なしの二元集合として数えるための並べ直し）。 -/
def orderedIndexPair (a b : Fin (m + 1)) : Fin (m + 1) × Fin (m + 1) :=
  if a < b then (a, b) else (b, a)

omit [NeZero L] in
/-- 子の位置から元の添字への単射 `idx` が添字の集合 `P` の上への 1 対 1 対応なら、子の接触対の個数は、
元の接触対のうち両方の添字が `P` に属するものの個数に等しい（本文の `S_A`・`S_B` との 1 対 1 対応）。 -/
theorem contactPairCount_reindex (γ : Fin (m + 1) → OrientedEdge L) {n : ℕ}
    (δ : Fin (n + 1) → OrientedEdge L) (hδ : closedNonbacktrackingWalk δ)
    (idx : Fin (n + 1) → Fin (m + 1)) (hidx : Function.Injective idx)
    (happ : ∀ j, δ j = γ (idx j)) (P : Fin (m + 1) → Prop) [DecidablePred P]
    (hP : ∀ r, P r ↔ ∃ j, idx j = r) :
    contactPairCount δ hδ =
      (((univ ×ˢ univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
          p.1 < p.2 ∧ orientedTarget (γ p.1) = orientedTarget (γ p.2)).filter
        fun p => P p.1 ∧ P p.2).card := by
  classical
  unfold contactPairCount
  refine Finset.card_bij (fun p _ => orderedIndexPair (idx p.1) (idx p.2)) ?_ ?_ ?_
  · -- 子の接触対は、両方の添字が `P` に属する元の接触対へ送られる。
    rintro ⟨i, j⟩ hp
    simp only [mem_filter, mem_product, mem_univ, true_and] at hp
    obtain ⟨hij, htgt⟩ := hp
    rw [happ, happ] at htgt
    have hne : idx i ≠ idx j := fun h => (ne_of_lt hij) (hidx h)
    have hPi : P (idx i) := (hP _).2 ⟨i, rfl⟩
    have hPj : P (idx j) := (hP _).2 ⟨j, rfl⟩
    unfold orderedIndexPair
    split_ifs with hlt
    · simp only [mem_filter, mem_product, mem_univ, true_and]
      exact ⟨⟨hlt, htgt⟩, hPi, hPj⟩
    · simp only [mem_filter, mem_product, mem_univ, true_and]
      exact ⟨⟨lt_of_le_of_ne (not_lt.mp hlt) (Ne.symm hne), htgt.symm⟩, hPj, hPi⟩
  · -- 送り方は単射である（位置の対は小さい方から並んでいる）。
    rintro ⟨i, j⟩ hp ⟨i', j'⟩ hp' heq
    simp only [mem_filter, mem_product, mem_univ, true_and] at hp hp'
    have hij := hp.1
    have hij' := hp'.1
    simp only [orderedIndexPair] at heq
    split_ifs at heq with h1 h2 h2
    · obtain ⟨ha, hb⟩ := Prod.mk.inj heq
      rw [hidx ha, hidx hb]
    · obtain ⟨ha, hb⟩ := Prod.mk.inj heq
      have hi := hidx ha
      have hj := hidx hb
      subst hi hj
      exact absurd (lt_trans hij hij') (lt_irrefl _)
    · obtain ⟨ha, hb⟩ := Prod.mk.inj heq
      have hi := hidx ha
      have hj := hidx hb
      subst hi hj
      exact absurd (lt_trans hij hij') (lt_irrefl _)
    · obtain ⟨ha, hb⟩ := Prod.mk.inj heq
      rw [hidx ha, hidx hb]
  · -- 送り方は全射である（両方の添字が `P` に属する元の接触対は、子の位置の対から来る）。
    rintro ⟨a, b⟩ hab
    simp only [mem_filter, mem_product, mem_univ, true_and] at hab
    obtain ⟨⟨hlt, htgt⟩, hPa, hPb⟩ := hab
    obtain ⟨i, rfl⟩ := (hP a).1 hPa
    obtain ⟨j, rfl⟩ := (hP b).1 hPb
    have hne : i ≠ j := fun h => (ne_of_lt hlt) (congrArg idx h)
    rcases lt_or_gt_of_ne hne with hij | hji
    · refine ⟨(i, j), ?_, ?_⟩
      · simp only [mem_filter, mem_product, mem_univ, true_and]
        exact ⟨hij, by rw [happ, happ]; exact htgt⟩
      · simp [orderedIndexPair, hlt]
    · refine ⟨(j, i), ?_, ?_⟩
      · simp only [mem_filter, mem_product, mem_univ, true_and]
        exact ⟨hji, by rw [happ, happ]; exact htgt.symm⟩
      · simp [orderedIndexPair, not_lt.mpr (le_of_lt hlt)]

omit [NeZero L] in
/-- 接触対の個数の具体版の定義は、接触対の集合の元の個数である。 -/
theorem contactPairCount_eq_card (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    contactPairCount γ hγ =
      ((univ ×ˢ univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
          p.1 < p.2 ∧ orientedTarget (γ p.1) = orientedTarget (γ p.2)).card := by
  classical
  unfold contactPairCount
  congr 1

/-- `claim_contact_split_pair_descent` を実際の二本へ当てたもの:
`n_ct(γ_A) + n_ct(γ_B) < n_ct(γ)`。 -/
theorem contact_split_walks_pair_descent (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hkl : k < l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    contactPairCount (smoothedSplitWalkA γ hγ k l) (contactSplitWalkA_closed γ hγ hinj hkl hcontact)
      + contactPairCount (smoothedSplitWalkB γ hγ k l)
          (contactSplitWalkB_closed γ hγ hinj hkl hcontact)
      < contactPairCount γ hγ := by
  classical
  -- 接触対の集合 `S` と、その二つの部分 `S_A`・`S_B`。
  set S := (univ ×ˢ univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ orientedTarget (γ p.1) = orientedTarget (γ p.2) with hS
  set SA := S.filter fun p =>
    p.1 ∈ smoothingIndexBlockA γ hγ k l ∧ p.2 ∈ smoothingIndexBlockA γ hγ k l with hSA
  set SB := S.filter fun p =>
    p.1 ∈ smoothingIndexBlockB γ hγ k l ∧ p.2 ∈ smoothingIndexBlockB γ hγ k l with hSB
  -- 子の接触対は `S_A`・`S_B` と 1 対 1 に対応する。
  have hA : contactPairCount (smoothedSplitWalkA γ hγ k l)
      (contactSplitWalkA_closed γ hγ hinj hkl hcontact) = SA.card :=
    contactPairCount_reindex γ _ _ (smoothedSplitIndexA k l) (smoothedSplitIndexA_injective hkl)
      (smoothedSplitWalkA_apply γ hγ k l) (· ∈ smoothingIndexBlockA γ hγ k l)
      (smoothedSplitIndexA_range γ hγ hkl)
  have hB : contactPairCount (smoothedSplitWalkB γ hγ k l)
      (contactSplitWalkB_closed γ hγ hinj hkl hcontact) = SB.card :=
    contactPairCount_reindex γ _ _ (smoothedSplitIndexB k l) (smoothedSplitIndexB_injective hkl)
      (smoothedSplitWalkB_apply γ hγ k l) (· ∈ smoothingIndexBlockB γ hγ k l)
      (smoothedSplitIndexB_range γ hγ hkl)
  rw [hA, hB, contactPairCount_eq_card]
  -- `A` と `B` は交わらないので `S_A` と `S_B` も交わらない。
  have hdisj : Disjoint SA SB := by
    rw [Finset.disjoint_left]
    intro p hpA hpB
    exact (mem_filter.mp hpB).2.1 (mem_filter.mp hpA).2.1
  -- 選んだ接触対 `(k, l)` は `S` に属し、`k ∉ A`・`l ∉ B` なので `S_A` にも `S_B` にも属さない。
  have hkS : (k, l) ∈ S := by
    simp only [hS, mem_filter, mem_product, mem_univ, true_and]
    exact ⟨hkl, hcontact⟩
  have hlA : l ∈ smoothingIndexBlockA γ hγ k l := by
    change (closedWalkTextIndex k).val < (closedWalkTextIndex l).val ∧
      (closedWalkTextIndex l).val ≤ (closedWalkTextIndex l).val
    rw [closedWalkTextIndex_lt_iff, closedWalkTextIndex_le_iff]
    exact ⟨hkl, le_refl _⟩
  have hkSA : (k, l) ∉ SA := by
    intro h
    exact lt_irrefl _ (mem_filter.mp h).2.1.1
  have hkSB : (k, l) ∉ SB := by
    intro h
    exact (mem_filter.mp h).2.2 hlA
  have hkU : (k, l) ∉ SA ∪ SB := by
    rw [mem_union]
    rintro (h | h)
    · exact hkSA h
    · exact hkSB h
  calc SA.card + SB.card < SA.card + SB.card + 1 := Nat.lt_succ_self _
    _ = (insert (k, l) (SA ∪ SB)).card := by
        rw [card_insert_of_notMem hkU, card_union_of_disjoint hdisj]
    _ ≤ S.card :=
        card_le_card (insert_subset hkS (union_subset (filter_subset _ _) (filter_subset _ _)))

end PairCount

/-- `(−1)` の冪の指数を `𝔽₂` の和で足す: `(−1)^{(a+b).val} = (−1)^{a.val} (−1)^{b.val}`。 -/
theorem neg_one_pow_zmod_two_val_add (a b : ZMod 2) :
    (-1 : Qbar) ^ (a + b).val = (-1 : Qbar) ^ a.val * (-1 : Qbar) ^ b.val := by
  rw [ZMod.val_add, ← pow_add, neg_one_pow_eq_pow_mod_two (R := Qbar) (n := a.val + b.val)]

omit [NeZero L] in
/-- 接触対数が正なら、接触対 `k < l` がある（`def_contact_pair_count`）。 -/
theorem exists_contact_pair_of_contactPairCount_pos (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hpos : 0 < contactPairCount γ hγ) :
    ∃ k l : Fin (m + 1), k < l ∧ orientedTarget (γ k) = orientedTarget (γ l) := by
  classical
  rw [contactPairCount_eq_card] at hpos
  obtain ⟨p, hp⟩ := Finset.card_pos.mp hpos
  simp only [mem_filter, mem_product, mem_univ, true_and] at hp
  exact ⟨p.1, p.2, hp.1, hp.2⟩

/-- 本文の主張の結論: 頂点単純で横断のない閉じた非後退辺列の族 `(δ_i)_{1≤i≤n}`（`n ≥ 1`）があり、
各子は辺の標識と通過する頂点がそれぞれ相異なり横断を持たず、台は互いに素で合併は `C_γ`、
切断線偶奇の和は `(h(γ), v(γ))`、`ζ_8^{t_∘(γ)} = (−1)^{(n−1) + Σ_{i<j} I_L(C_i, C_j)} Π_i ζ_8^{t_∘(δ_i)}`。 -/
def ContactEliminationFamily (z : Qbar) (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) : Prop :=
  ∃ δs : List (ClosedNonbacktrackingWalkData L), δs ≠ [] ∧
    (∀ δ ∈ δs, (Function.Injective fun r => (δ.walk r).1) ∧
      Function.Injective (orientedTarget ∘ δ.walk) ∧ δ.crossing = 0) ∧
    (δs.map (·.support)).Pairwise Disjoint ∧
    chainListUnion (δs.map (·.support)) = closedWalkSupport γ ∧
    ((δs.map fun δ => δ.seam.1).sum % 2, (δs.map fun δ => δ.seam.2).sum % 2) =
      edgeSequenceSeamParities (List.ofFn γ) ∧
    z ^ cyclicTotalTurning γ hγ =
      (-1 : Qbar) ^ (((δs.length - 1 : ℕ) : ZMod 2)
          + chainPairIntersectionSum (δs.map (·.support))).val *
        (δs.map fun δ => z ^ δ.turning).prod

/-- `claim_crossing_free_contact_elimination_phase`: 辺の標識が相異なり横断のない閉じた非後退辺列は、
接触対数についての整礎帰納法で、本文の性質を持つ頂点単純な族へ分かれる。 -/
theorem crossing_free_contact_elimination_phase {z : Qbar} (hz4 : z ^ 4 = -1)
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (hinj : Function.Injective fun r => (γ r).1) (hzero : closedWalkCrossingNumber γ hγ = 0) :
    ContactEliminationFamily z γ hγ := by
  have hz : z ≠ 0 := by
    intro h
    rw [h] at hz4
    norm_num at hz4
  -- n_ct(γ) ∈ ℕ に関する整礎帰納法
  suffices H : ∀ N : ℕ, ∀ {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
      (hγ : closedNonbacktrackingWalk γ), (Function.Injective fun r => (γ r).1) →
      closedWalkCrossingNumber γ hγ = 0 → contactPairCount γ hγ = N →
      ContactEliminationFamily z γ hγ from
    H _ γ hγ hinj hzero rfl
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
  intro m γ hγ hinj hzero hN
  rcases Nat.eq_zero_or_pos N with h0 | hpos
  · -- n_ct(γ) = 0 なら n = 1、δ_1 = γ
    refine ⟨[⟨m, γ, hγ⟩], List.cons_ne_nil _ _, ?_, List.pairwise_singleton _ _, ?_, ?_, ?_⟩
    · intro δ hδ
      rw [List.mem_singleton.mp hδ]
      exact ⟨hinj, (contactPairCount_eq_zero_iff_pass_vertices_injective γ hγ).mp (hN.trans h0),
        hzero⟩
    · simp [chainListUnion, ClosedNonbacktrackingWalkData.support]
    · simp [ClosedNonbacktrackingWalkData.seam, edgeSequenceSeamParities]
    · simp [chainPairIntersectionSum, ClosedNonbacktrackingWalkData.turning]
  · -- 接触対 k < l を選ぶ
    obtain ⟨k, l, hkl, hcontact⟩ :=
      exists_contact_pair_of_contactPairCount_pos γ hγ (hN ▸ hpos)
    -- 二本 γ_A・γ_B
    set γA := smoothedSplitWalkA γ hγ k l with hγA
    set γB := smoothedSplitWalkB γ hγ k l with hγB
    have hA := contactSplitWalkA_closed γ hγ hinj hkl hcontact
    have hB := contactSplitWalkB_closed γ hγ hinj hkl hcontact
    -- 両子の横断数は零
    obtain ⟨hzA, hzB⟩ := crossing_free_contact_split_children γ hγ hinj hzero hkl hcontact
    -- 接触対数の減少
    have hdesc := contact_split_walks_pair_descent γ hγ hinj hkl hcontact
    have hltA : contactPairCount γA hA < N :=
      hN ▸ lt_of_le_of_lt (Nat.le_add_right _ _) hdesc
    have hltB : contactPairCount γB hB < N :=
      hN ▸ lt_of_le_of_lt (Nat.le_add_left _ _) hdesc
    -- 帰納法を二本へ適用する
    obtain ⟨αs, hαne, hαgood, hαdisj, hαunion, hαseam, hαphase⟩ :=
      ih _ hltA γA hA (smoothedSplitWalkA_edge_injective γ hγ hinj hkl) hzA rfl
    obtain ⟨βs, hβne, hβgood, hβdisj, hβunion, hβseam, hβphase⟩ :=
      ih _ hltB γB hB (smoothedSplitWalkB_edge_injective γ hγ hinj hkl) hzB rfl
    -- 二本の台の分割 C_A ∩ C_B = ∅、C_A ∪ C_B = C_γ
    have hABdisj := smoothedSplitWalks_support_disjoint γ hγ hinj hkl
    have hABunion := smoothedSplitWalks_support_union γ hγ hkl
    -- 両族を連結して (δ_i)_{1≤i≤p+q} と置く
    refine ⟨αs ++ βs, by simp [hαne], ?_, ?_, ?_, ?_, ?_⟩
    · intro δ hδ
      rcases List.mem_append.mp hδ with h | h
      · exact hαgood δ h
      · exact hβgood δ h
    · -- 連結族の台も互いに素
      rw [List.map_append, List.pairwise_append]
      refine ⟨hαdisj, hβdisj, fun C hC D hD => ?_⟩
      have hCA : C ⊆ closedWalkSupport γA := hαunion ▸ subset_chainListUnion hC
      have hDB : D ⊆ closedWalkSupport γB := hβunion ▸ subset_chainListUnion hD
      exact Finset.disjoint_of_subset_left hCA (Finset.disjoint_of_subset_right hDB hABdisj)
    · -- 連結族の台は元の台を尽くす
      rw [List.map_append, chainListUnion_append, hαunion, hβunion, hABunion]
    · -- ⊕(h(δ_i), v(δ_i)) = (h(γ_A), v(γ_A)) ⊕ (h(γ_B), v(γ_B)) = (h(γ), v(γ))
      have hαh := congrArg Prod.fst hαseam
      have hαv := congrArg Prod.snd hαseam
      have hβh := congrArg Prod.fst hβseam
      have hβv := congrArg Prod.snd hβseam
      simp only at hαh hαv hβh hβv
      calc (((αs ++ βs).map fun δ => δ.seam.1).sum % 2, ((αs ++ βs).map fun δ => δ.seam.2).sum % 2)
          = ((((αs.map fun δ => δ.seam.1).sum % 2) + ((βs.map fun δ => δ.seam.1).sum % 2)) % 2,
              (((αs.map fun δ => δ.seam.2).sum % 2) + ((βs.map fun δ => δ.seam.2).sum % 2)) % 2) := by
            rw [List.map_append, List.sum_append, List.map_append, List.sum_append, Nat.add_mod,
              Nat.add_mod ((αs.map fun δ => δ.seam.2).sum)]
        _ = (((edgeSequenceSeamParities (List.ofFn γA)).1
                + (edgeSequenceSeamParities (List.ofFn γB)).1) % 2,
              ((edgeSequenceSeamParities (List.ofFn γA)).2
                + (edgeSequenceSeamParities (List.ofFn γB)).2) % 2) := by
            rw [hαh, hαv, hβh, hβv]
        _ = edgeSequenceSeamParities (List.ofFn γ) := closedWalk_smoothing_split_seam_parity γ hγ hkl
    · -- ζ_8^{t_∘(γ)} = (−1)^{1+I_L(C_A,C_B)} ζ_8^{t_∘(γ_A)+t_∘(γ_B)} = …
      have hp : 1 ≤ αs.length := List.length_pos_iff.mpr hαne
      have hq : 1 ≤ βs.length := List.length_pos_iff.mpr hβne
      have hlen : (αs ++ βs).length - 1 = (αs.length - 1) + (βs.length - 1) + 1 := by
        rw [List.length_append]; omega
      have hdist : evenEdgeChainIntersection L (closedWalkSupport γA) (closedWalkSupport γB) =
          chainCrossIntersectionSum (αs.map (·.support)) (βs.map (·.support)) := by
        rw [← hαunion, ← hβunion]
        exact evenEdgeChainIntersection_chainListUnion hαdisj hβdisj
      -- 符号の指数の 𝔽₂ での和
      have hexp : (1 + evenEdgeChainIntersection L (closedWalkSupport γA) (closedWalkSupport γB))
            + (((αs.length - 1 : ℕ) : ZMod 2) + chainPairIntersectionSum (αs.map (·.support)))
            + (((βs.length - 1 : ℕ) : ZMod 2) + chainPairIntersectionSum (βs.map (·.support)))
          = (((αs ++ βs).length - 1 : ℕ) : ZMod 2)
              + chainPairIntersectionSum ((αs ++ βs).map (·.support)) := by
        rw [hdist, hlen, List.map_append, chainPairIntersectionSum_append]
        push_cast
        ring
      set e0 : ZMod 2 :=
        1 + evenEdgeChainIntersection L (closedWalkSupport γA) (closedWalkSupport γB) with he0
      set eA : ZMod 2 :=
        ((αs.length - 1 : ℕ) : ZMod 2) + chainPairIntersectionSum (αs.map (·.support)) with heA
      set eB : ZMod 2 :=
        ((βs.length - 1 : ℕ) : ZMod 2) + chainPairIntersectionSum (βs.map (·.support)) with heB
      calc z ^ cyclicTotalTurning γ hγ
          = (-1 : Qbar) ^ (1 + evenEdgeChainIntersection L (closedWalkSupport γA)
                (closedWalkSupport γB)).val
              * z ^ (cyclicTotalTurning γA hA + cyclicTotalTurning γB hB) :=
            crossing_free_contact_split_phase hz4 γ hγ hinj hzero hkl hcontact
        _ = (-1 : Qbar) ^ (1 + evenEdgeChainIntersection L (closedWalkSupport γA)
                (closedWalkSupport γB)).val
              * (z ^ cyclicTotalTurning γA hA * z ^ cyclicTotalTurning γB hB) := by
            rw [zpow_add₀ hz]
        _ = (-1 : Qbar) ^ (1 + evenEdgeChainIntersection L (closedWalkSupport γA)
                (closedWalkSupport γB)).val
              * (((-1 : Qbar) ^ (((αs.length - 1 : ℕ) : ZMod 2)
                    + chainPairIntersectionSum (αs.map (·.support))).val
                  * (αs.map fun δ => z ^ δ.turning).prod)
                * ((-1 : Qbar) ^ (((βs.length - 1 : ℕ) : ZMod 2)
                    + chainPairIntersectionSum (βs.map (·.support))).val
                  * (βs.map fun δ => z ^ δ.turning).prod)) := by
            rw [← hαphase, ← hβphase]
        _ = (-1 : Qbar) ^ ((1 + evenEdgeChainIntersection L (closedWalkSupport γA)
                (closedWalkSupport γB))
                + (((αs.length - 1 : ℕ) : ZMod 2) + chainPairIntersectionSum (αs.map (·.support)))
                + (((βs.length - 1 : ℕ) : ZMod 2)
                  + chainPairIntersectionSum (βs.map (·.support)))).val
              * ((αs.map fun δ => z ^ δ.turning).prod * (βs.map fun δ => z ^ δ.turning).prod) := by
            rw [neg_one_pow_zmod_two_val_add (e0 + eA) eB, neg_one_pow_zmod_two_val_add e0 eA]
            ring
        _ = (-1 : Qbar) ^ ((((αs ++ βs).length - 1 : ℕ) : ZMod 2)
                + chainPairIntersectionSum ((αs ++ βs).map (·.support))).val
              * ((αs ++ βs).map fun δ => z ^ δ.turning).prod := by
            rw [hexp]
            simp only [List.map_append, List.prod_append]

end Ising2DLambda.KacWard
