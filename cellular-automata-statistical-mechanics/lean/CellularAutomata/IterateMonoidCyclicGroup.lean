/-
章「反復モノイドの巡回部がなす有限巡回群」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid-cyclic-group.ts。

巡回部の合成閉性、唯一の冪等元の単位元性、逆元、周期を一つ進める元による
巡回生成を、人手証明と同じ順序で形式化する。有限集合と自然数だけを使い、
R / C は使わない。
-/
import CellularAutomata.IterateMonoidCycleIdempotent
import CellularAutomata.NecSuf.IterateMonoidCyclicGroup

namespace CellularAutomata.IterateMonoidCyclicGroup

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidPrincipalIdealTail
open CellularAutomata.IterateMonoidStabilizationIndex
open CellularAutomata.IterateMonoidMinimalPeriod
open CellularAutomata.IterateMonoidTailCycleDecomposition
open CellularAutomata.IterateMonoidCycleIdempotent

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-! `C_F` の演算は写像の合成そのものである。 -/

/-- `K_F := F^(e_F+1)`。 -/
noncomputable def cycleSuccessor : (V → State) → (V → State) :=
  iterateMap N f (minStablePeriodMultiple N f + 1)

/-- 巡回部は写像の合成について閉じる。 -/
theorem cyclePart_comp_closed
    {G H : (V → State) → (V → State)}
    (hG : G ∈ cyclePart N f) (hH : H ∈ cyclePart N f) :
    G ∘ H ∈ cyclePart N f := by
  rcases Finset.mem_image.mp hG with ⟨a, ha, rfl⟩
  rcases Finset.mem_image.mp hH with ⟨b, hb, rfl⟩
  rw [iterateMap_comp_add]
  apply (mem_tail_minCollisionStart_iff_mem_cyclePart N f _).mp
  refine ⟨minCollisionStart N f + a + b, ?_⟩
  congr 1
  omega

/-- 巡回部の合成は可換である（反復回数の加法則と自然数の加法の可換律だけを使う）。 -/
theorem cyclePart_comp_comm
    {G H : (V → State) → (V → State)}
    (hG : G ∈ cyclePart N f) (hH : H ∈ cyclePart N f) :
    G ∘ H = H ∘ G := by
  rcases Finset.mem_image.mp hG with ⟨a, _, rfl⟩
  rcases Finset.mem_image.mp hH with ⟨b, _, rfl⟩
  rw [iterateMap_comp_add, iterateMap_comp_add, Nat.add_comm]

/-- `E_F` は巡回部上の左単位元である。 -/
theorem cycleIdempotent_comp_eq
    {G : (V → State) → (V → State)} (hG : G ∈ cyclePart N f) :
    cycleIdempotent N f ∘ G = G := by
  rcases Finset.mem_image.mp hG with ⟨r, hr, rfl⟩
  let e := minStablePeriodMultiple N f
  let n := minCollisionStart N f + r
  have he := minStablePeriodMultiple_spec N f
  rcases he.2 with ⟨q, hq⟩
  rw [cycleIdempotent, iterateMap_comp_add]
  have hp := minPeriod_multiple_after_start N f (n := n) (by simp [n]) q
  have heq : e = q * minPositivePeriod N f := by
    simpa [e, Nat.mul_comm] using hq
  simpa [e, n, heq, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using hp.symm

/-- `E_F` は巡回部上の右単位元である。 -/
theorem comp_cycleIdempotent_eq
    {G : (V → State) → (V → State)} (hG : G ∈ cyclePart N f) :
    G ∘ cycleIdempotent N f = G := by
  rcases Finset.mem_image.mp hG with ⟨r, hr, rfl⟩
  rw [cycleIdempotent, iterateMap_comp_add, Nat.add_comm, ← iterateMap_comp_add]
  exact cycleIdempotent_comp_eq N f hG

/-- 人手証明の指数 `m=e_F+n(λ_F-1)` が与える逆元は巡回部に属する。 -/
theorem inverse_candidate_mem_cyclePart (n : ℕ) :
    iterateMap N f
        (minStablePeriodMultiple N f + n * (minPositivePeriod N f - 1)) ∈
      cyclePart N f := by
  apply (mem_tail_minCollisionStart_iff_mem_cyclePart N f _).mp
  refine ⟨minStablePeriodMultiple N f + n * (minPositivePeriod N f - 1) -
      minCollisionStart N f, ?_⟩
  congr 1
  have he := (minStablePeriodMultiple_spec N f).1
  omega

/-- 人手証明の候補は左右逆元である。 -/
theorem inverse_candidate_two_sided (n : ℕ) :
    let H := iterateMap N f
      (minStablePeriodMultiple N f + n * (minPositivePeriod N f - 1))
    iterateMap N f n ∘ H = cycleIdempotent N f ∧
      H ∘ iterateMap N f n = cycleIdempotent N f := by
  dsimp
  let e := minStablePeriodMultiple N f
  let lam := minPositivePeriod N f
  have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos N f
  have hindex : n + (e + n * (lam - 1)) = e + n * lam := by
    have hle : n ≤ n * lam := Nat.le_mul_of_pos_right n hlam
    have hmul : n * (lam - 1) = n * lam - n := by
      rw [Nat.mul_sub_left_distrib]
      simp
    omega
  have heStart : minCollisionStart N f ≤ e := (minStablePeriodMultiple_spec N f).1
  have hp := minPeriod_multiple_after_start N f heStart n
  have hprod : iterateMap N f n ∘ iterateMap N f (e + n * (lam - 1)) =
      cycleIdempotent N f := by
    rw [iterateMap_comp_add, hindex]
    simpa [cycleIdempotent, e, lam] using hp.symm
  exact ⟨hprod, by
    rw [iterateMap_comp_add, Nat.add_comm]
    simpa only [← iterateMap_comp_add] using hprod⟩

/-- `K_F` は巡回部に属する。 -/
theorem cycleSuccessor_mem_cyclePart : cycleSuccessor N f ∈ cyclePart N f := by
  apply (mem_tail_minCollisionStart_iff_mem_cyclePart N f _).mp
  refine ⟨minStablePeriodMultiple N f + 1 - minCollisionStart N f, ?_⟩
  simp only [cycleSuccessor]
  congr 1
  have he := (minStablePeriodMultiple_spec N f).1
  omega

/-- 単位元から始める `K_F` の群冪。 -/
noncomputable def cyclePower : ℕ → ((V → State) → (V → State))
  | 0 => cycleIdempotent N f
  | r + 1 => cyclePower r ∘ cycleSuccessor N f

/-- 群冪は `F^(e_F+r)` に等しい。 -/
theorem cyclePower_eq_iterateMap (r : ℕ) :
    cyclePower N f r = iterateMap N f (minStablePeriodMultiple N f + r) := by
  induction r with
  | zero => rfl
  | succ r ih =>
      rw [cyclePower, ih, cycleSuccessor, iterateMap_comp_add]
      let e := minStablePeriodMultiple N f
      let lam := minPositivePeriod N f
      have he := minStablePeriodMultiple_spec N f
      rcases he.2 with ⟨q, hq⟩
      have heStart : minCollisionStart N f ≤ e + (r + 1) :=
        he.1.trans (Nat.le_add_right _ _)
      have hp := minPeriod_multiple_after_start N f heStart q
      have heq : e = q * lam := by simpa [e, lam, Nat.mul_comm] using hq
      simpa [e, lam, heq, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using hp.symm

/-- 最初の `λ_F` 個の群冪は互いに異なる。 -/
theorem cyclePower_injective_in_period {r s : ℕ}
    (hr : r < minPositivePeriod N f) (hs : s < minPositivePeriod N f)
    (h : cyclePower N f r = cyclePower N f s) : r = s := by
  rw [cyclePower_eq_iterateMap, cyclePower_eq_iterateMap] at h
  have he := minStablePeriodMultiple_spec N f
  rcases he.2 with ⟨q, hq⟩
  let μ := minCollisionStart N f
  let lam := minPositivePeriod N f
  have heq : minStablePeriodMultiple N f = q * lam := by
    simpa [lam, Nat.mul_comm] using hq
  have hreduce (x : ℕ) : iterateMap N f (minStablePeriodMultiple N f + x) =
      iterateMap N f (μ + ((minStablePeriodMultiple N f - μ) + x) % lam) := by
    have h' := iterateMap_reduce_to_cycle N f ((minStablePeriodMultiple N f - μ) + x)
    have hstart : μ ≤ minStablePeriodMultiple N f := by simpa [μ] using he.1
    convert h' using 1 <;> congr 1 <;> omega
  have hmod : ((minStablePeriodMultiple N f - μ) + r) % lam =
      ((minStablePeriodMultiple N f - μ) + s) % lam := by
    apply iterateMap_injective_in_cycle N f
      (Nat.mod_lt _ (by simpa [lam] using minPositivePeriod_pos N f))
      (Nat.mod_lt _ (by simpa [lam] using minPositivePeriod_pos N f))
    exact (hreduce r).symm.trans (h.trans (hreduce s))
  have hmodeq : (minStablePeriodMultiple N f - μ) + r ≡
      (minStablePeriodMultiple N f - μ) + s [MOD lam] := hmod
  have hrs : r ≡ s [MOD lam] := Nat.ModEq.add_left_cancel' _ hmodeq
  change r % lam = s % lam at hrs
  have hr' : r < lam := by simpa [lam] using hr
  have hs' : s < lam := by simpa [lam] using hs
  calc
    r = r % lam := (Nat.mod_eq_of_lt hr').symm
    _ = s % lam := hrs
    _ = s := Nat.mod_eq_of_lt hs'

/-- `K_F` の最初の `λ_F` 個の群冪は巡回部をちょうど尽くす。 -/
theorem cyclePower_range_eq_cyclePart :
    (Finset.range (minPositivePeriod N f)).image (cyclePower N f) = cyclePart N f := by
  apply Finset.eq_of_subset_of_card_le
  · intro G hG
    rcases Finset.mem_image.mp hG with ⟨r, _hr, rfl⟩
    rw [cyclePower_eq_iterateMap]
    apply (mem_tail_minCollisionStart_iff_mem_cyclePart N f _).mp
    refine ⟨minStablePeriodMultiple N f + r - minCollisionStart N f, ?_⟩
    congr 1
    have he := (minStablePeriodMultiple_spec N f).1
    omega
  · rw [card_cyclePart, Finset.card_image_iff.mpr]
    · simp
    · intro r hr s hs h
      exact cyclePower_injective_in_period N f
        (Finset.mem_range.mp hr) (Finset.mem_range.mp hs) h

/-- 巡回部の元数、したがって巡回群の位数は `λ_F` である。 -/
theorem cyclePart_card_eq_minPositivePeriod :
    (cyclePart N f).card = minPositivePeriod N f :=
  card_cyclePart N f

/-- 有限真理値表から有限走査できる `C_F` の合成表。 -/
noncomputable def cycleMultiplicationTable : Finset
    (((V → State) → (V → State)) ×
      ((V → State) → (V → State)) ×
      ((V → State) → (V → State))) := by
  classical
  exact ((cyclePart N f).product (cyclePart N f)).image
    (fun pair => (pair.1, pair.2, pair.1 ∘ pair.2))

/-- 合成表から有限走査できる逆元候補の表。 -/
noncomputable def cycleInverseTable : Finset
    (((V → State) → (V → State)) ×
      ((V → State) → (V → State))) := by
  classical
  exact ((cyclePart N f).product (cyclePart N f)).filter
    (fun pair => pair.1 ∘ pair.2 = cycleIdempotent N f)

/-- 巡回部への所属、合成、単位元・生成元の等号は有限型上で決定可能である。 -/
noncomputable instance (G : (V → State) → (V → State)) :
    Decidable (G ∈ cyclePart N f) := Finset.decidableMem G (cyclePart N f)

/-! ## 必要十分版からの導出

具体版は必要十分版を X := V → State、F := globalMap N f へ特殊化したものである。 -/

section Derivation

/-- `K_F` は必要十分版の特殊化に一致する。 -/
theorem cycleSuccessor_eq_necessary_sufficient :
    cycleSuccessor N f = CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cycleSuccessor (globalMap N f) (necSufHex N f) := by
  rw [cycleSuccessor, CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cycleSuccessor, minStablePeriodMultiple_eq_necessary_sufficient,
    iterateMap_eq_necessary_sufficient]

/-- 群冪は必要十分版の特殊化に一致する。 -/
theorem cyclePower_eq_necessary_sufficient (r : ℕ) :
    cyclePower N f r = CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cyclePower (globalMap N f) (necSufHex N f) r := by
  induction r with
  | zero =>
      simp only [cyclePower, CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cyclePower]
      exact cycleIdempotent_eq_necessary_sufficient N f
  | succ r ih =>
      simp only [cyclePower, CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cyclePower]
      rw [ih, cycleSuccessor_eq_necessary_sufficient]

theorem cyclePart_comp_closed_from_necessary_sufficient
    {G H : (V → State) → (V → State)}
    (hG : G ∈ cyclePart N f) (hH : H ∈ cyclePart N f) :
    G ∘ H ∈ cyclePart N f := by
  rw [cyclePart_eq_necessary_sufficient] at hG hH ⊢
  exact CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cyclePart_comp_closed (globalMap N f) (necSufHex N f) hG hH

theorem cyclePart_comp_comm_from_necessary_sufficient
    {G H : (V → State) → (V → State)}
    (hG : G ∈ cyclePart N f) (hH : H ∈ cyclePart N f) :
    G ∘ H = H ∘ G := by
  rw [cyclePart_eq_necessary_sufficient] at hG hH
  exact CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cyclePart_comp_comm
    (globalMap N f) (necSufHex N f) hG hH

theorem cycleIdempotent_two_sided_unit_from_necessary_sufficient
    {G : (V → State) → (V → State)} (hG : G ∈ cyclePart N f) :
    cycleIdempotent N f ∘ G = G ∧ G ∘ cycleIdempotent N f = G := by
  rw [cyclePart_eq_necessary_sufficient] at hG
  rw [cycleIdempotent_eq_necessary_sufficient]
  exact ⟨CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cycleIdempotent_comp_eq (globalMap N f) (necSufHex N f) hG,
    CellularAutomata.NecSuf.IterateMonoidCyclicGroup.comp_cycleIdempotent_eq (globalMap N f) (necSufHex N f) hG⟩

theorem inverse_candidate_two_sided_from_necessary_sufficient (n : ℕ) :
    iterateMap N f n ∘ iterateMap N f
        (minStablePeriodMultiple N f + n * (minPositivePeriod N f - 1)) =
      cycleIdempotent N f ∧
    iterateMap N f
        (minStablePeriodMultiple N f + n * (minPositivePeriod N f - 1)) ∘
      iterateMap N f n = cycleIdempotent N f := by
  rw [iterateMap_eq_necessary_sufficient, iterateMap_eq_necessary_sufficient,
    minStablePeriodMultiple_eq_necessary_sufficient, minPositivePeriod_eq_necessary_sufficient,
    cycleIdempotent_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoidCyclicGroup.inverse_candidate_two_sided (globalMap N f) (necSufHex N f) n

theorem cyclePower_range_eq_cyclePart_from_necessary_sufficient :
    (Finset.range (minPositivePeriod N f)).image (cyclePower N f) = cyclePart N f := by
  rw [cyclePart_eq_necessary_sufficient, minPositivePeriod_eq_necessary_sufficient]
  have hfun : cyclePower N f = CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cyclePower (globalMap N f) (necSufHex N f) :=
    funext (cyclePower_eq_necessary_sufficient N f)
  rw [hfun]
  exact CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cyclePower_range_eq_cyclePart (globalMap N f) (necSufHex N f)

theorem cyclePart_card_eq_minPositivePeriod_from_necessary_sufficient :
    (cyclePart N f).card = minPositivePeriod N f := by
  rw [cyclePart_eq_necessary_sufficient, minPositivePeriod_eq_necessary_sufficient]
  exact CellularAutomata.NecSuf.IterateMonoidCyclicGroup.cyclePart_card_eq_minPositivePeriod (globalMap N f) (necSufHex N f)

end Derivation

end CellularAutomata.IterateMonoidCyclicGroup
