/-
章「近傍割り当ての反射推移閉包」の Lean 具体版。
人手証明の正本は
structured-latex/content/neighborhood-assignment-reachability-closure.ts。

対応表（人手証明 → この file）
  def_neighborhood_assignment_composition_power
    `compositionPower`
  def_neighborhood_assignment_reachability_approximation
    `reachabilityApproximation`, `mem_reachabilityApproximation`
  claim_reachability_approximation_monotone
    `reachabilityApproximation_monotone`
  claim_reachability_approximation_recursion
    `reachabilityApproximation_recursion`
  claim_reachability_approximation_stable_forever
    `reachabilityApproximation_stable_forever`
  claim_reachability_approximation_stabilizes
    `membershipCount`, `membershipCount_le_sq`, `membershipCount_mono`,
    `membershipCount_lt_of_ne`, `reachabilityApproximation_stabilizes`
  def_neighborhood_assignment_reflexive_transitive_closure
    `reachabilityClosure`
  claim_composition_power_included_in_closure
    `compositionPower_included_in_reachabilityApproximation`,
    `compositionPower_included_in_closure`
  claim_composition_power_additive
    `compositionPower_additive`
  claim_reflexive_transitive_closure_reflexive
    `reachabilityClosure_self_mem`
  claim_reflexive_transitive_closure_contains_original
    `reachabilityClosure_contains_original`
  claim_reflexive_transitive_closure_transitive
    `reachabilityClosure_isTransitive`
  claim_reflexive_transitive_closure_idempotent
    `reachabilityClosure_isCompositionIdempotent`
  claim_reflexive_transitive_closure_minimal
    `compositionPower_included_of_upper_bound`, `reachabilityClosure_minimal`
  claim_reflexive_transitive_closure_finite_decidable
    `mem_compositionPower_succ_iff`, `closureScan`, `card_closureScan`,
    `instDecidableMemReachabilityClosure`

比較回数のコストモデル自体は形式化していない。形式化しているのは、所属判定が
決定可能であること（`instDecidableMemReachabilityClosure`）と、人手証明が数える
走査の組の総数が `(|V|²+1)·|V|³` であること（`card_closureScan`）である。

必要十分版と具体版からの導出は
`CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure` に置く。

住処: 有限型、有限部分集合、有限写像、自然数だけ。ℝ / ℂ は現れない。
-/
import CellularAutomata.NeighborhoodAssignmentCompositionIdempotents
import CellularAutomata.NeighborhoodAssignmentUnionDistributivity

namespace CellularAutomata.NeighborhoodAssignmentReachabilityClosure

open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.OrderedNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentUnionDistributivity
open CellularAutomata.NeighborhoodAssignmentCompositionIdempotents

variable {V : Type} [Fintype V] [DecidableEq V]

/-- `def_neighborhood_assignment_composition_power` の合成冪
    `N^{⟨0⟩} = I_V`, `N^{⟨k+1⟩} = N^{⟨k⟩} ⋆ N`。 -/
def compositionPower (N : NeighborhoodAssignment V) : ℕ → NeighborhoodAssignment V
  | 0 => identityNeighborhood V
  | k + 1 => composedNeighborhood (compositionPower N k) N

/-- `def_neighborhood_assignment_reachability_approximation` の有限近似
    `N^{≤k}(v) = ⋃_{j=0}^{k} N^{⟨j⟩}(v)`。 -/
def reachabilityApproximation (N : NeighborhoodAssignment V) (k : ℕ) :
    NeighborhoodAssignment V :=
  fun v => (Finset.range (k + 1)).biUnion fun j => compositionPower N j v

omit [Fintype V] in
/-- 有限近似への所属は、`k` 以下のある合成冪への所属と同値である。 -/
theorem mem_reachabilityApproximation (N : NeighborhoodAssignment V) (k : ℕ) (v w : V) :
    w ∈ reachabilityApproximation N k v ↔ ∃ j ≤ k, w ∈ compositionPower N j v := by
  simp only [reachabilityApproximation, Finset.mem_biUnion, Finset.mem_range]
  constructor
  · rintro ⟨j, hj, hw⟩
    exact ⟨j, Nat.lt_succ_iff.mp hj, hw⟩
  · rintro ⟨j, hj, hw⟩
    exact ⟨j, Nat.lt_succ_iff.mpr hj, hw⟩

omit [Fintype V] in
/-- `claim_composition_power_included_in_closure` の前半。
    `j ≤ k` なら `N^{⟨j⟩} ⊑ N^{≤k}` である。 -/
theorem compositionPower_included_in_reachabilityApproximation
    (N : NeighborhoodAssignment V) {j k : ℕ} (hjk : j ≤ k) :
    PointwiseInclusion (compositionPower N j) (reachabilityApproximation N k) := by
  intro v w hw
  exact (mem_reachabilityApproximation N k v w).mpr ⟨j, hjk, hw⟩

omit [Fintype V] in
/-- `claim_reachability_approximation_monotone`。合併は各成分を含む。 -/
theorem reachabilityApproximation_monotone (N : NeighborhoodAssignment V) (k : ℕ) :
    PointwiseInclusion (reachabilityApproximation N k) (reachabilityApproximation N (k + 1)) := by
  intro v w hw
  obtain ⟨j, hj, hwj⟩ := (mem_reachabilityApproximation N k v w).mp hw
  exact (mem_reachabilityApproximation N (k + 1) v w).mpr ⟨j, Nat.le_succ_of_le hj, hwj⟩

omit [Fintype V] in
/-- `claim_reachability_approximation_recursion`。
    `N^{≤k+1} = I_V ⊔ (N^{≤k} ⋆ N)`。添字 `j = 0` の項を分け、
    残りを `j+1` で番号付け直す。 -/
theorem reachabilityApproximation_recursion (N : NeighborhoodAssignment V) (k : ℕ) :
    reachabilityApproximation N (k + 1) =
      pointwiseUnion (identityNeighborhood V)
        (composedNeighborhood (reachabilityApproximation N k) N) := by
  funext v
  ext w
  simp only [pointwiseUnion, Finset.mem_union, composedNeighborhood, Finset.mem_biUnion]
  constructor
  · intro hw
    obtain ⟨j, hj, hwj⟩ := (mem_reachabilityApproximation N (k + 1) v w).mp hw
    match j, hwj with
    | 0, hwj => exact Or.inl hwj
    | (i + 1), hwj =>
        -- N^{⟨i+1⟩}(v) = ⋃_{u ∈ N^{⟨i⟩}(v)} N(u)
        rw [compositionPower, composedNeighborhood, Finset.mem_biUnion] at hwj
        obtain ⟨u, huI, hwN⟩ := hwj
        have hi : i ≤ k := Nat.lt_succ_iff.mp (Nat.lt_of_succ_le hj)
        exact Or.inr ⟨u, (mem_reachabilityApproximation N k v u).mpr ⟨i, hi, huI⟩, hwN⟩
  · intro hw
    rcases hw with hw | ⟨u, huA, hwN⟩
    · exact (mem_reachabilityApproximation N (k + 1) v w).mpr
        ⟨0, Nat.zero_le _, hw⟩
    · obtain ⟨i, hi, huI⟩ := (mem_reachabilityApproximation N k v u).mp huA
      refine (mem_reachabilityApproximation N (k + 1) v w).mpr ⟨i + 1, Nat.succ_le_succ hi, ?_⟩
      rw [compositionPower]
      exact inner_mem_composedNeighborhood (compositionPower N i) N v u w huI hwN

omit [Fintype V] in
/-- `claim_reachability_approximation_stable_forever`。`m` についての帰納法。 -/
theorem reachabilityApproximation_stable_forever (N : NeighborhoodAssignment V) {k : ℕ}
    (hStable : reachabilityApproximation N (k + 1) = reachabilityApproximation N k) :
    ∀ m : ℕ, reachabilityApproximation N (k + m) = reachabilityApproximation N k := by
  intro m
  induction m with
  | zero => rfl
  | succ m ih =>
      calc reachabilityApproximation N (k + (m + 1))
          = pointwiseUnion (identityNeighborhood V)
              (composedNeighborhood (reachabilityApproximation N (k + m)) N) :=
            reachabilityApproximation_recursion N (k + m)
        _ = pointwiseUnion (identityNeighborhood V)
              (composedNeighborhood (reachabilityApproximation N k) N) := by rw [ih]
        _ = reachabilityApproximation N (k + 1) :=
            (reachabilityApproximation_recursion N k).symm
        _ = reachabilityApproximation N k := hStable

/-- `claim_reachability_approximation_stabilizes` の証明で使う所属の総数
    `c(k) = Σ_{v∈V} |N^{≤k}(v)| ∈ ℕ`。 -/
def membershipCount (N : NeighborhoodAssignment V) (k : ℕ) : ℕ :=
  ∑ v : V, (reachabilityApproximation N k v).card

/-- 所属の総数は `|V|²` で抑えられる。 -/
theorem membershipCount_le_sq (N : NeighborhoodAssignment V) (k : ℕ) :
    membershipCount N k ≤ Fintype.card V ^ 2 := by
  have hEach : ∀ v : V, (reachabilityApproximation N k v).card ≤ Fintype.card V := by
    intro v
    exact Finset.card_le_univ _
  calc membershipCount N k
      ≤ ∑ _v : V, Fintype.card V := Finset.sum_le_sum fun v _ => hEach v
    _ = Fintype.card V * Fintype.card V := by
        simp [Finset.sum_const, Finset.card_univ]
    _ = Fintype.card V ^ 2 := (pow_two _).symm

/-- 所属の総数は単調に増える。 -/
theorem membershipCount_mono (N : NeighborhoodAssignment V) (k : ℕ) :
    membershipCount N k ≤ membershipCount N (k + 1) := by
  refine Finset.sum_le_sum fun v _ => Finset.card_le_card ?_
  intro w hw
  exact reachabilityApproximation_monotone N k v hw

/-- 一段で値が変われば、所属の総数は真に増える。 -/
theorem membershipCount_lt_of_ne (N : NeighborhoodAssignment V) {k : ℕ}
    (hNe : reachabilityApproximation N (k + 1) ≠ reachabilityApproximation N k) :
    membershipCount N k + 1 ≤ membershipCount N (k + 1) := by
  have hSub : ∀ v : V,
      reachabilityApproximation N k v ⊆ reachabilityApproximation N (k + 1) v := by
    intro v w hw
    exact reachabilityApproximation_monotone N k v hw
  -- ある v で真の部分集合になる。
  have hWitness : ∃ v : V,
      reachabilityApproximation N k v ⊂ reachabilityApproximation N (k + 1) v := by
    by_contra hAll
    push_neg at hAll
    apply hNe
    funext v
    have hRev : reachabilityApproximation N (k + 1) v ⊆ reachabilityApproximation N k v := by
      by_contra hcon
      exact hAll v (Finset.ssubset_def.mpr ⟨hSub v, hcon⟩)
    exact Finset.Subset.antisymm hRev (hSub v)
  obtain ⟨v₀, hv₀⟩ := hWitness
  have hLt : membershipCount N k < membershipCount N (k + 1) := by
    refine Finset.sum_lt_sum (fun v _ => Finset.card_le_card (hSub v)) ?_
    exact ⟨v₀, Finset.mem_univ v₀, Finset.card_lt_card hv₀⟩
  exact hLt

/-- `claim_reachability_approximation_stabilizes`。
    所属の総数の上界 `|V|²` と、未安定なら 1 以上増えることの矛盾で示す。 -/
theorem reachabilityApproximation_stabilizes (N : NeighborhoodAssignment V) :
    ∃ k ≤ Fintype.card V ^ 2,
      reachabilityApproximation N (k + 1) = reachabilityApproximation N k := by
  by_contra hNone
  push_neg at hNone
  -- すべての段で真に増えるので c(k) ≥ k となる。
  have hGrow : ∀ k ≤ Fintype.card V ^ 2 + 1, k ≤ membershipCount N k := by
    intro k
    induction k with
    | zero => intro _; exact Nat.zero_le _
    | succ k ih =>
        intro hk
        have hkLe : k ≤ Fintype.card V ^ 2 := Nat.lt_succ_iff.mp (Nat.lt_of_succ_le hk)
        have hPrev : k ≤ membershipCount N k := ih (Nat.le_of_succ_le hk)
        have hStep : membershipCount N k + 1 ≤ membershipCount N (k + 1) :=
          membershipCount_lt_of_ne N (hNone k hkLe)
        exact le_trans (Nat.succ_le_succ hPrev) hStep
  have hBig : Fintype.card V ^ 2 + 1 ≤ membershipCount N (Fintype.card V ^ 2 + 1) :=
    hGrow (Fintype.card V ^ 2 + 1) le_rfl
  have hSmall : membershipCount N (Fintype.card V ^ 2 + 1) ≤ Fintype.card V ^ 2 :=
    membershipCount_le_sq N (Fintype.card V ^ 2 + 1)
  omega

/-- `def_neighborhood_assignment_reflexive_transitive_closure` の反射推移閉包
    `N* := N^{≤|V|²}`。 -/
def reachabilityClosure (N : NeighborhoodAssignment V) : NeighborhoodAssignment V :=
  reachabilityApproximation N (Fintype.card V ^ 2)

/-- 閉包は安定位置 `k ≤ |V|²` の有限近似に等しい。 -/
theorem reachabilityClosure_eq_of_stable (N : NeighborhoodAssignment V) {k : ℕ}
    (hk : k ≤ Fintype.card V ^ 2)
    (hStable : reachabilityApproximation N (k + 1) = reachabilityApproximation N k) :
    reachabilityClosure N = reachabilityApproximation N k := by
  have hSplit : k + (Fintype.card V ^ 2 - k) = Fintype.card V ^ 2 := by omega
  have := reachabilityApproximation_stable_forever N hStable (Fintype.card V ^ 2 - k)
  rw [hSplit] at this
  exact this

/-- `claim_composition_power_included_in_closure`。
    `M := max{m, |V|²}` を取り、安定の永続を二回使う。 -/
theorem compositionPower_included_in_closure (N : NeighborhoodAssignment V) (m : ℕ) :
    PointwiseInclusion (compositionPower N m) (reachabilityClosure N) := by
  obtain ⟨k₀, hk₀, hStable⟩ := reachabilityApproximation_stabilizes N
  set M := max m (Fintype.card V ^ 2) with hM
  have hmM : m ≤ M := le_max_left _ _
  have hk₀M : k₀ ≤ M := le_trans hk₀ (le_max_right _ _)
  have hMeq : reachabilityApproximation N M = reachabilityApproximation N k₀ := by
    have hSplit : k₀ + (M - k₀) = M := by omega
    have := reachabilityApproximation_stable_forever N hStable (M - k₀)
    rw [hSplit] at this
    exact this
  have hCloseEq : reachabilityClosure N = reachabilityApproximation N k₀ :=
    reachabilityClosure_eq_of_stable N hk₀ hStable
  intro v w hw
  have hwM : w ∈ reachabilityApproximation N M v :=
    compositionPower_included_in_reachabilityApproximation N hmM v hw
  rw [hMeq] at hwM
  rw [hCloseEq]
  exact hwM

omit [Fintype V] in
/-- `claim_composition_power_additive`。`j` についての帰納法。 -/
theorem compositionPower_additive (N : NeighborhoodAssignment V) (i j : ℕ) :
    composedNeighborhood (compositionPower N i) (compositionPower N j) =
      compositionPower N (i + j) := by
  induction j with
  | zero =>
      calc composedNeighborhood (compositionPower N i) (compositionPower N 0)
          = composedNeighborhood (compositionPower N i) (identityNeighborhood V) := rfl
        _ = compositionPower N i := composedNeighborhood_identity _
        _ = compositionPower N (i + 0) := by rw [Nat.add_zero]
  | succ j ih =>
      calc composedNeighborhood (compositionPower N i) (compositionPower N (j + 1))
          = composedNeighborhood (compositionPower N i)
              (composedNeighborhood (compositionPower N j) N) := rfl
        _ = composedNeighborhood
              (composedNeighborhood (compositionPower N i) (compositionPower N j)) N :=
            (composedNeighborhood_assoc _ _ _).symm
        _ = composedNeighborhood (compositionPower N (i + j)) N := by rw [ih]
        _ = compositionPower N (i + j + 1) := rfl
        _ = compositionPower N (i + (j + 1)) := by rw [Nat.add_assoc]

/-- `claim_reflexive_transitive_closure_reflexive`。`m := 0` の合成冪を使う。 -/
theorem reachabilityClosure_self_mem (N : NeighborhoodAssignment V) (v : V) :
    v ∈ reachabilityClosure N v := by
  have hSelf : v ∈ compositionPower N 0 v := by
    simp [compositionPower, identityNeighborhood]
  exact compositionPower_included_in_closure N 0 v hSelf

/-- `claim_reflexive_transitive_closure_contains_original`。`m := 1` の合成冪を使う。 -/
theorem reachabilityClosure_contains_original (N : NeighborhoodAssignment V) :
    PointwiseInclusion N (reachabilityClosure N) := by
  have hOne : compositionPower N 1 = N := by
    show composedNeighborhood (identityNeighborhood V) N = N
    exact identity_composedNeighborhood N
  intro v w hw
  refine compositionPower_included_in_closure N 1 v ?_
  rw [hOne]
  exact hw

/-- `claim_reflexive_transitive_closure_transitive`。
    証人の合成冪の指数を足し、`claim_composition_power_additive` を使う。 -/
theorem reachabilityClosure_isTransitive (N : NeighborhoodAssignment V) :
    IsTransitive (reachabilityClosure N) := by
  intro v u w huC hwC
  obtain ⟨i, _, huI⟩ :=
    (mem_reachabilityApproximation N (Fintype.card V ^ 2) v u).mp huC
  obtain ⟨j, _, hwJ⟩ :=
    (mem_reachabilityApproximation N (Fintype.card V ^ 2) u w).mp hwC
  have hwComp : w ∈ composedNeighborhood (compositionPower N i) (compositionPower N j) v :=
    inner_mem_composedNeighborhood (compositionPower N i) (compositionPower N j) v u w huI hwJ
  rw [compositionPower_additive N i j] at hwComp
  exact compositionPower_included_in_closure N (i + j) v hwComp

/-- `claim_reflexive_transitive_closure_idempotent`。
    反射性と推移性から、既証明の同値の推移的な側を使う。 -/
theorem reachabilityClosure_isCompositionIdempotent (N : NeighborhoodAssignment V) :
    IsCompositionIdempotent (reachabilityClosure N) :=
  (compositionIdempotent_iff_transitive_of_self_mem (reachabilityClosure N)
      (reachabilityClosure_self_mem N)).mpr (reachabilityClosure_isTransitive N)

/-- `claim_reflexive_transitive_closure_minimal` の帰納段。
    自己近傍を含み推移的で `N` を含む `M` は、すべての合成冪を含む。 -/
theorem compositionPower_included_of_upper_bound (N M : NeighborhoodAssignment V)
    (hSelf : ∀ v : V, v ∈ M v) (hTrans : IsTransitive M) (hNM : PointwiseInclusion N M)
    (m : ℕ) : PointwiseInclusion (compositionPower N m) M := by
  have hIdem : composedNeighborhood M M = M :=
    (compositionIdempotent_iff_transitive_of_self_mem M hSelf).mpr hTrans
  induction m with
  | zero =>
      intro v w hw
      have hwv : w = v := by
        simpa [compositionPower, identityNeighborhood] using hw
      rw [hwv]
      exact hSelf v
  | succ m ih =>
      have hStep : PointwiseInclusion (composedNeighborhood (compositionPower N m) N)
          (composedNeighborhood M M) := composedNeighborhood_monotone ih hNM
      intro v w hw
      have hwMM : w ∈ composedNeighborhood M M v := hStep v hw
      rw [hIdem] at hwMM
      exact hwMM

/-- `claim_reflexive_transitive_closure_minimal`。
    閉包は「自己近傍を含み推移的で `N` を含む」割り当てのうち最小である。 -/
theorem reachabilityClosure_minimal (N M : NeighborhoodAssignment V)
    (hSelf : ∀ v : V, v ∈ M v) (hTrans : IsTransitive M) (hNM : PointwiseInclusion N M) :
    PointwiseInclusion (reachabilityClosure N) M := by
  intro v w hw
  obtain ⟨j, _, hwj⟩ := (mem_reachabilityApproximation N (Fintype.card V ^ 2) v w).mp hw
  exact compositionPower_included_of_upper_bound N M hSelf hTrans hNM j v hwj

omit [Fintype V] in
/-- `claim_reflexive_transitive_closure_finite_decidable` の一段の所属条件。
    `w ∈ N^{⟨j+1⟩}(v)` は `∃ u, u ∈ N^{⟨j⟩}(v) ∧ w ∈ N(u)` と同値である。 -/
theorem mem_compositionPower_succ_iff (N : NeighborhoodAssignment V) (j : ℕ) (v w : V) :
    w ∈ compositionPower N (j + 1) v ↔ ∃ u : V, u ∈ compositionPower N j v ∧ w ∈ N u := by
  show w ∈ composedNeighborhood (compositionPower N j) N v ↔ _
  rw [composedNeighborhood, Finset.mem_biUnion]

/-- 人手証明が数える走査の組。段 `j = 0,…,|V|²`、行き先 `v`、到達点 `w`、中継 `u`。 -/
def closureScan : Finset (ℕ × V × V × V) :=
  (Finset.range (Fintype.card V ^ 2 + 1)) ×ˢ (Finset.univ ×ˢ (Finset.univ ×ˢ Finset.univ))

omit [DecidableEq V] in
/-- 走査する組の総数は `(|V|²+1)·|V|³` である。 -/
theorem card_closureScan :
    (closureScan (V := V)).card = (Fintype.card V ^ 2 + 1) * Fintype.card V ^ 3 := by
  simp [closureScan, Finset.card_product, pow_succ]
  ring

/-- 閉包への所属は有限手続きで決定できる。 -/
instance instDecidableMemReachabilityClosure (N : NeighborhoodAssignment V) (v w : V) :
    Decidable (w ∈ reachabilityClosure N v) := by
  unfold reachabilityClosure
  infer_instance

end CellularAutomata.NeighborhoodAssignmentReachabilityClosure
