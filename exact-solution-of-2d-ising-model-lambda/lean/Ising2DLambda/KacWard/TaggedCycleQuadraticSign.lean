/-
「非零項の位相は補辺の二次符号と短い対の横断数に等しい」（`claim_tagged_matching_quadratic_crossing_weight`）の
具体版のうち、証明の二つ目の式鎖の二・三行目を一つの交互閉路について行う段。

実際の非零項 `(D, T)` の交互閉路（最小元 `m`）の射影した閉歩道 `w_r = ι(c(2r))`（`taggedCycleWalk`）を、
長さ `k_C = n + 1` の辺列 `γ_C : Fin (n + 1) → OrientedEdge L` として取り出し、

  `−Π_{r<k_C} ε_{a,b}(w_{r+1}) ρ(w_r, w_{r+1}) = χ_{a,b}(h(γ_C), v(γ_C)) (−1)^{c(γ_C)}`

を示す。左辺の積は `claim_tagged_matching_cycle_weight` の具体版 `taggedMatchingTerm_cycleWeight` の
閉路ごとの因子 `taggedCyclePhase` である。

  人手証明                                               このファイル
  γ_C は閉じた非後退辺列（claim_projected_edge_cycle_nonbacktracking）
                                                         `taggedCycleFinWalk_closed`
  γ_C の無向辺は相異なる（claim_projected_cycle_distinct_edges）
                                                         `taggedCycleFinWalk_injective`
  回転位相積は循環総回転数の冪（claim_closed_walk_rotation_phase）
                                                         `rotationPhase_eq_zpow_stepTurning`・
                                                         `taggedCyclePhase_eq_turning`
  位相と二次符号（claim_edge_distinct_walk_quadratic_sign を各閉路へ適用）
                                                         `taggedCyclePhase_quadraticSign`

`claim_closed_walk_rotation_phase` の一行は、隣接二辺の回転位相 `ρ(e, f)` が一歩の回転数 `t(e, f)` の
`ζ_8` 冪であること（回転位相と一歩の回転数の定義が同じ方向番号の場合分けを持つ）と、整数指数の加法則で行う。
住処は有限集合・`ℕ`・`ℤ`・`Qbar` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.EdgeDistinctWalkQuadraticSign
import Ising2DLambda.KacWard.TaggedMatchingCycleWeight
import Ising2DLambda.KacWard.ProjectedCycleDistinctEdges

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

variable {L : ℕ}

/-- 隣接二辺の回転位相は、一歩の回転数を指数とする `z` の整数冪である。
    反対方向の組は非後退の条件で除かれる。 -/
theorem rotationPhase_eq_zpow_stepTurning [NeZero L] (z : Qbar)
    (e f : OrientedEdge L) (hf : f ∈ nonbacktrackingSuccessors e) :
    rotationPhase z e f = z ^ stepTurning e f := by
  have hadv := step_advances_direction e f hf
  have htable : ∀ a b : ZMod 4,
      b = a ∨ b = a + 1 ∨ b = a - 1 ∨ b = a + 2 := by decide
  have hreverse : directionNumber f ≠ directionNumber e + 2 := by
    intro h
    have hs : orientedSource f = orientedTarget e := (Finset.mem_filter.mp hf).2.1.symm
    have hr : orientedSource (reversal e) = orientedTarget e := by
      rcases e with ⟨edge, false | true⟩ <;> rfl
    have heq : f = reversal e := sourceDirection_bijective.1
      (Prod.ext (hs.trans hr.symm) (h.trans (directionNumber_reversal e).symm))
    exact (Finset.mem_filter.mp hf).2.2 heq
  clear hadv
  rcases htable (directionNumber e) (directionNumber f) with h | h | h | h
  · simp [rotationPhase, stepTurning, hf, h]
  · have h1 : directionNumber e + 1 ≠ directionNumber e := by
      generalize directionNumber e = a; revert a; decide
    simp [rotationPhase, stepTurning, hf, h, h1]
  · have h1 : directionNumber e - 1 ≠ directionNumber e := by
      generalize directionNumber e = a; revert a; decide
    have h2 : directionNumber e - 1 ≠ directionNumber e + 1 := by
      generalize directionNumber e = a; revert a; decide
    simp [rotationPhase, stepTurning, hf, h, h1, h2]
  · exact (hreverse h).elim

/-- 整数指数の加法則（`Finset.range` 上の有限和）。 -/
theorem zpow_sum_range {z : Qbar} (hz : z ≠ 0) (f : ℕ → ℤ) (k : ℕ) :
    z ^ (∑ r ∈ Finset.range k, f r) = ∏ r ∈ Finset.range k, z ^ f r := by
  induction k with
  | zero => simp
  | succ k ih => rw [Finset.sum_range_succ, Finset.prod_range_succ, zpow_add₀ hz, ih]

/-- 周期 `p` の列の値は、添字を `p` で割った余りの値に等しい。 -/
theorem periodic_eq_mod {α : Type*} (w : ℕ → α) (p : ℕ) (hper : ∀ r, w (r + p) = w r) (r : ℕ) :
    w r = w (r % p) := by
  have key : ∀ q r, w (r + p * q) = w r := by
    intro q
    induction q with
    | zero => intro r; simp
    | succ q ih =>
      intro r
      rw [Nat.mul_succ, ← Nat.add_assoc, hper, ih]
  conv_lhs => rw [← Nat.mod_add_div r p]
  exact key _ _

section Cycle

variable (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))

/-- 射影した閉歩道は閉路の長さ `k_C` を周期に持つ: `w_{r + k_C} = w_r`。 -/
theorem taggedCycleWalk_periodic (m : TaggedActive D t) (r : ℕ) :
    taggedCycleWalk D t m (r + taggedCycleLength D t m) = taggedCycleWalk D t m r := by
  obtain ⟨_, ⟨k, hk⟩, hper⟩ := taggedCycle_period D t m
  have hk2 : finitePermutationMinimalPeriod (concreteAlternatingSuccessor D t) m = 2 * k := by
    omega
  have hlen : taggedCycleLength D t m = k := by
    unfold taggedCycleLength
    omega
  rw [hk2] at hper
  simp only [taggedCycleWalk]
  rw [hlen, show 2 * (r + k) = 2 * r + 2 * k by ring, finiteMapIterate_add, hper]

/-- 長さ `n + 1 = k_C` の辺列 `γ_C`。第 `r` 辺は `w_r`。 -/
noncomputable def taggedCycleFinWalk (m : TaggedActive D t) (n : ℕ) : Fin (n + 1) → OrientedEdge L :=
  fun r => taggedCycleWalk D t m r.val

/-- `claim_projected_edge_cycle_nonbacktracking`: 非零項の交互閉路の射影 `γ_C` は閉じた非後退辺列である。 -/
theorem taggedCycleFinWalk_closed [NeZero L] (z : Qbar) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (i : TaggedActive D t) (n : ℕ)
    (hn : taggedCycleLength D t
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i) = n + 1) :
    closedNonbacktrackingWalk (taggedCycleFinWalk D t
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i) n) := by
  set m := matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i
  set w := taggedCycleWalk D t m with hw
  obtain ⟨k', hk', hret, hsucc⟩ := taggedActive_projectedCycle_nonbacktracking z s D t ht hterm i
  -- `k'` 歩で戻ることから、`w` は周期 `k'` を持つ
  have hret' : finiteMapIterate (concreteAlternatingSuccessor D t) (2 * k') m = m :=
    Subtype.ext (by
      have h := congrArg reversal hret
      rwa [reversal_involutive, reversal_involutive] at h)
  have hperk : ∀ r, w (r + k') = w r := by
    intro r
    simp only [hw, taggedCycleWalk]
    rw [show 2 * (r + k') = 2 * r + 2 * k' by ring, finiteMapIterate_add, hret']
  -- 全ての `r` で `w_{r+1}` は `w_r` の非後退な後続辺
  have hall : ∀ r, w (r + 1) ∈ nonbacktrackingSuccessors (w r) := by
    intro r
    have h1 : w (r + 1) = w (r % k' + 1) := by
      rw [periodic_eq_mod w k' hperk (r + 1), periodic_eq_mod w k' hperk (r % k' + 1),
        Nat.add_mod r 1 k', Nat.add_mod (r % k') 1 k', Nat.mod_mod]
    rw [h1, periodic_eq_mod w k' hperk r]
    exact hsucc (r % k') (Nat.mod_lt r hk')
  refine ⟨fun j => ?_, ?_⟩
  · simp only [taggedCycleFinWalk, Fin.val_succ, Fin.val_castSucc]
    exact hall j.val
  · have hwrap : w (n + 1) = w 0 := by
      have := taggedCycleWalk_periodic D t m 0
      rw [Nat.zero_add, hn] at this
      exact this
    have hl := hall n
    rw [hwrap] at hl
    simpa [taggedCycleFinWalk, hw] using hl

/-- `claim_projected_cycle_distinct_edges`: `γ_C` の無向辺は相異なる。 -/
theorem taggedCycleFinWalk_injective (i : TaggedActive D t) (n : ℕ)
    (hn : taggedCycleLength D t
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i) = n + 1) :
    Function.Injective fun r => (taggedCycleFinWalk D t
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i) n r).1 := by
  intro r s hrs
  have hdist := taggedActive_projectedCycle_distinctEdges D t i
  have hk : finitePermutationMinimalPeriod
      (matchingPairPermutation (concreteShortInvolution D t) (concreteLongInvolution D t))
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i) / 2 =
        n + 1 := hn
  have hr : r.val < finitePermutationMinimalPeriod
      (matchingPairPermutation (concreteShortInvolution D t) (concreteLongInvolution D t))
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i) / 2 := by
    rw [hk]; exact r.isLt
  have hs : s.val < finitePermutationMinimalPeriod
      (matchingPairPermutation (concreteShortInvolution D t) (concreteLongInvolution D t))
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i) / 2 := by
    rw [hk]; exact s.isLt
  exact Fin.ext (hdist r.val s.val hr hs hrs)

/-- `claim_closed_walk_rotation_phase` を一つの閉路へ当てた形:
    `Π_{r<k_C} ε(w_{r+1}) ρ(w_r, w_{r+1}) = (Π_r ε(γ_C(r))) ζ_8^{t_∘(γ_C)}`。 -/
theorem taggedCyclePhase_eq_turning [NeZero L] {z : Qbar} (hz : z ≠ 0) (s : SpinStructure)
    (m : TaggedActive D t) (n : ℕ) (hn : taggedCycleLength D t m = n + 1)
    (hγ : closedNonbacktrackingWalk (taggedCycleFinWalk D t m n)) :
    taggedCyclePhase z s D t m =
      (∏ r, ((twistSign s (taggedCycleFinWalk D t m n r) : ℤ) : Qbar)) *
        z ^ cyclicTotalTurning (taggedCycleFinWalk D t m n) hγ := by
  set w := taggedCycleWalk D t m with hw
  have hwrap : w (n + 1) = w 0 := by
    have := taggedCycleWalk_periodic D t m 0
    rw [Nat.zero_add, hn] at this
    exact this
  have hsucc : ∀ r < n + 1, w (r + 1) ∈ nonbacktrackingSuccessors (w r) := by
    intro r hr
    rcases Nat.lt_succ_iff_lt_or_eq.mp hr with hlt | rfl
    · have := hγ.1 ⟨r, hlt⟩
      simpa [taggedCycleFinWalk, hw] using this
    · have := hγ.2
      simp only [taggedCycleFinWalk, Fin.val_last, Fin.val_zero] at this
      rw [hwrap]
      exact this
  -- ねじれ符号の積を一つずらす（w_{k_C} = w_0）
  have htwist : (∏ r ∈ Finset.range (n + 1), (twistSign s (w (r + 1)) : Qbar)) =
      ∏ r : Fin (n + 1), ((twistSign s (taggedCycleFinWalk D t m n r) : ℤ) : Qbar) := by
    rw [show (∏ r : Fin (n + 1), ((twistSign s (taggedCycleFinWalk D t m n r) : ℤ) : Qbar)) =
        ∏ r ∈ Finset.range (n + 1), ((twistSign s (w r) : ℤ) : Qbar) from
      Fin.prod_univ_eq_prod_range (fun r => ((twistSign s (w r) : ℤ) : Qbar)) (n + 1)]
    have h1 := Finset.prod_range_succ (fun r => ((twistSign s (w r) : ℤ) : Qbar)) (n + 1)
    have h2 := Finset.prod_range_succ' (fun r => ((twistSign s (w r) : ℤ) : Qbar)) (n + 1)
    rw [hwrap] at h1
    have hne : ((twistSign s (w 0) : ℤ) : Qbar) ≠ 0 := by
      unfold twistSign
      push_cast
      exact pow_ne_zero _ (by norm_num)
    exact mul_right_cancel₀ hne (h2.symm.trans h1)
  -- 回転位相の積は一歩の回転数の和の冪
  have hphase : (∏ r ∈ Finset.range (n + 1), rotationPhase z (w r) (w (r + 1))) =
      z ^ cyclicTotalTurning (taggedCycleFinWalk D t m n) hγ := by
    rw [Finset.prod_congr rfl fun r hr =>
      rotationPhase_eq_zpow_stepTurning z _ _ (hsucc r (Finset.mem_range.mp hr)),
      ← zpow_sum_range hz, cyclicTotalTurning_eq, edgeSequenceTotalTurning_eq,
      Finset.sum_range_succ]
    congr 1
    congr 1
    · rw [← Fin.sum_univ_eq_sum_range (fun r => stepTurning (w r) (w (r + 1))) n]
      rfl
    · simp only [taggedCycleFinWalk, Fin.val_last, Fin.val_zero]
      rw [hwrap]
  unfold taggedCyclePhase
  rw [hn, Finset.prod_mul_distrib, htwist, hphase]

/-- 一つの交互閉路について、証明の二つ目の式鎖の二・三行目:
    `−Π_{r<k_C} ε(w_{r+1}) ρ(w_r, w_{r+1}) = χ_{a,b}(h(γ_C), v(γ_C)) (−1)^{c(γ_C)}`。 -/
theorem taggedCyclePhase_quadraticSign [NeZero L] {z : Qbar} (hz4 : z ^ 4 = -1) (s : SpinStructure)
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (i : TaggedActive D t) (n : ℕ)
    (hn : taggedCycleLength D t
      (matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i) = n + 1) :
    let m := matchingPairComponentMinimum (concreteShortInvolution D t) (concreteLongInvolution D t) i
    (-taggedCyclePhase z s D t m) =
      ((torusQuadraticSign s.1 s.2
          (decide ((edgeSequenceSeamParities (List.ofFn (taggedCycleFinWalk D t m n))).1 = 1))
          (decide ((edgeSequenceSeamParities (List.ofFn (taggedCycleFinWalk D t m n))).2 = 1)) : ℤ) :
          Qbar) *
        (-1 : Qbar) ^ closedWalkCrossingNumber (taggedCycleFinWalk D t m n)
          (taggedCycleFinWalk_closed D t z s ht hterm i n hn) := by
  intro m
  have hγ := taggedCycleFinWalk_closed D t z s ht hterm i n hn
  have hz : z ≠ 0 := by
    intro h
    rw [h] at hz4
    norm_num at hz4
  rw [taggedCyclePhase_eq_turning D t hz s m n hn hγ, ← neg_mul]
  exact edgeDistinctWalk_quadraticSign s hz4 _ hγ (taggedCycleFinWalk_injective D t i n hn)

end Cycle

end Ising2DLambda.KacWard
