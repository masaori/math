/-
章「反復モノイドの巡回部がなす有限巡回群」の必要十分版。

具体版と同じ手順（巡回部の合成閉性、E_F の左右単位元性、指数 e_F+n(λ_F-1) による左右逆元、
K_F=F^{e_F+1} の群冪 F^{e_F+r}、一周期内の相異性、巡回部の生成と位数、有限決定）を保ち、
実際に使う構造だけを残す。

* 逆元の左右恒等性、群冪の反復写像表示、一周期内の相異性には、型 X、自己写像 F : X → X、
  衝突開始位置の存在（前章の e_F・λ_F・周期の伝播・一周期内の単射性を与える）だけが要る。
  X の有限性はその存在を与える側にだけ現れ、この章の定理には現れない。
* X → X の等号判定（`DecidableEq (X → X)`）は、巡回部を前章の `Finset` として書き、
  閉性・単位元性・所属・生成・位数を「∈ C_F」「= C_F」の形で述べる段階にだけ要る。
  使わない定理には `omit` を付けた。
* 二値状態、セル、近傍、局所規則は現れない。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidCycleIdempotent

namespace CellularAutomata.NecSuf.IterateMonoidCyclicGroup

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail
open CellularAutomata.NecSuf.IterateMonoidStabilizationIndex
open CellularAutomata.NecSuf.IterateMonoidMinimalPeriod
open CellularAutomata.NecSuf.IterateMonoidTailCycleDecomposition
open CellularAutomata.NecSuf.IterateMonoidCycleIdempotent

variable {X : Type} [DecidableEq (X → X)]
variable (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n)

/-! `C_F` の演算は写像の合成そのものである。 -/

omit [DecidableEq (X → X)] in
/-- `K_F := F^(e_F+1)`。 -/
noncomputable def cycleSuccessor : X → X :=
  iterateMap F (minStablePeriodMultiple F hex + 1)

/-- 巡回部は写像の合成について閉じる。 -/
theorem cyclePart_comp_closed
    {G H : X → X}
    (hG : G ∈ cyclePart F hex) (hH : H ∈ cyclePart F hex) :
    G ∘ H ∈ cyclePart F hex := by
  rcases Finset.mem_image.mp hG with ⟨a, ha, rfl⟩
  rcases Finset.mem_image.mp hH with ⟨b, hb, rfl⟩
  rw [iterateMap_comp_add]
  apply (mem_tail_minCollisionStart_iff_mem_cyclePart F hex _).mp
  refine ⟨minCollisionStart F hex + a + b, ?_⟩
  congr 1
  omega

/-- 巡回部の合成は可換である（反復回数の加法則と自然数の加法の可換律だけを使う）。 -/
theorem cyclePart_comp_comm
    {G H : X → X}
    (hG : G ∈ cyclePart F hex) (hH : H ∈ cyclePart F hex) :
    G ∘ H = H ∘ G := by
  rcases Finset.mem_image.mp hG with ⟨a, _, rfl⟩
  rcases Finset.mem_image.mp hH with ⟨b, _, rfl⟩
  rw [iterateMap_comp_add, iterateMap_comp_add, Nat.add_comm]

/-- `E_F` は巡回部上の左単位元である。 -/
theorem cycleIdempotent_comp_eq
    {G : X → X} (hG : G ∈ cyclePart F hex) :
    cycleIdempotent F hex ∘ G = G := by
  rcases Finset.mem_image.mp hG with ⟨r, hr, rfl⟩
  let e := minStablePeriodMultiple F hex
  let n := minCollisionStart F hex + r
  have he := minStablePeriodMultiple_spec F hex
  rcases he.2 with ⟨q, hq⟩
  rw [cycleIdempotent, iterateMap_comp_add]
  have hp := minPeriod_multiple_after_start F hex (n := n) (by simp [n]) q
  have heq : e = q * minPositivePeriod F hex := by
    simpa [e, Nat.mul_comm] using hq
  simpa [e, n, heq, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using hp.symm

/-- `E_F` は巡回部上の右単位元である。 -/
theorem comp_cycleIdempotent_eq
    {G : X → X} (hG : G ∈ cyclePart F hex) :
    G ∘ cycleIdempotent F hex = G := by
  rcases Finset.mem_image.mp hG with ⟨r, hr, rfl⟩
  rw [cycleIdempotent, iterateMap_comp_add, Nat.add_comm, ← iterateMap_comp_add]
  exact cycleIdempotent_comp_eq F hex hG

/-- 人手証明の指数 `m=e_F+n(λ_F-1)` が与える逆元は巡回部に属する。 -/
theorem inverse_candidate_mem_cyclePart (n : ℕ) :
    iterateMap F
        (minStablePeriodMultiple F hex + n * (minPositivePeriod F hex - 1)) ∈
      cyclePart F hex := by
  apply (mem_tail_minCollisionStart_iff_mem_cyclePart F hex _).mp
  refine ⟨minStablePeriodMultiple F hex + n * (minPositivePeriod F hex - 1) -
      minCollisionStart F hex, ?_⟩
  congr 1
  have he := (minStablePeriodMultiple_spec F hex).1
  omega

omit [DecidableEq (X → X)] in
/-- 人手証明の候補は左右逆元である。 -/
theorem inverse_candidate_two_sided (n : ℕ) :
    let H := iterateMap F
      (minStablePeriodMultiple F hex + n * (minPositivePeriod F hex - 1))
    iterateMap F n ∘ H = cycleIdempotent F hex ∧
      H ∘ iterateMap F n = cycleIdempotent F hex := by
  dsimp
  let e := minStablePeriodMultiple F hex
  let lam := minPositivePeriod F hex
  have hlam : 0 < lam := by simpa [lam] using minPositivePeriod_pos F hex
  have hindex : n + (e + n * (lam - 1)) = e + n * lam := by
    have hle : n ≤ n * lam := Nat.le_mul_of_pos_right n hlam
    have hmul : n * (lam - 1) = n * lam - n := by
      rw [Nat.mul_sub_left_distrib]
      simp
    omega
  have heStart : minCollisionStart F hex ≤ e := (minStablePeriodMultiple_spec F hex).1
  have hp := minPeriod_multiple_after_start F hex heStart n
  have hprod : iterateMap F n ∘ iterateMap F (e + n * (lam - 1)) =
      cycleIdempotent F hex := by
    rw [iterateMap_comp_add, hindex]
    simpa [cycleIdempotent, e, lam] using hp.symm
  exact ⟨hprod, by
    rw [iterateMap_comp_add, Nat.add_comm]
    simpa only [← iterateMap_comp_add] using hprod⟩

/-- `K_F` は巡回部に属する。 -/
theorem cycleSuccessor_mem_cyclePart : cycleSuccessor F hex ∈ cyclePart F hex := by
  apply (mem_tail_minCollisionStart_iff_mem_cyclePart F hex _).mp
  refine ⟨minStablePeriodMultiple F hex + 1 - minCollisionStart F hex, ?_⟩
  simp only [cycleSuccessor]
  congr 1
  have he := (minStablePeriodMultiple_spec F hex).1
  omega

omit [DecidableEq (X → X)] in
/-- 単位元から始める `K_F` の群冪。 -/
noncomputable def cyclePower : ℕ → (X → X)
  | 0 => cycleIdempotent F hex
  | r + 1 => cyclePower r ∘ cycleSuccessor F hex

omit [DecidableEq (X → X)] in
/-- 群冪は `F^(e_F+r)` に等しい。 -/
theorem cyclePower_eq_iterateMap (r : ℕ) :
    cyclePower F hex r = iterateMap F (minStablePeriodMultiple F hex + r) := by
  induction r with
  | zero => rfl
  | succ r ih =>
      rw [cyclePower, ih, cycleSuccessor, iterateMap_comp_add]
      let e := minStablePeriodMultiple F hex
      let lam := minPositivePeriod F hex
      have he := minStablePeriodMultiple_spec F hex
      rcases he.2 with ⟨q, hq⟩
      have heStart : minCollisionStart F hex ≤ e + (r + 1) :=
        he.1.trans (Nat.le_add_right _ _)
      have hp := minPeriod_multiple_after_start F hex heStart q
      have heq : e = q * lam := by simpa [e, lam, Nat.mul_comm] using hq
      simpa [e, lam, heq, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using hp.symm

omit [DecidableEq (X → X)] in
/-- 最初の `λ_F` 個の群冪は互いに異なる。 -/
theorem cyclePower_injective_in_period {r s : ℕ}
    (hr : r < minPositivePeriod F hex) (hs : s < minPositivePeriod F hex)
    (h : cyclePower F hex r = cyclePower F hex s) : r = s := by
  rw [cyclePower_eq_iterateMap, cyclePower_eq_iterateMap] at h
  have he := minStablePeriodMultiple_spec F hex
  rcases he.2 with ⟨q, hq⟩
  let μ := minCollisionStart F hex
  let lam := minPositivePeriod F hex
  have heq : minStablePeriodMultiple F hex = q * lam := by
    simpa [lam, Nat.mul_comm] using hq
  have hreduce (x : ℕ) : iterateMap F (minStablePeriodMultiple F hex + x) =
      iterateMap F (μ + ((minStablePeriodMultiple F hex - μ) + x) % lam) := by
    have h' := iterateMap_reduce_to_cycle F hex ((minStablePeriodMultiple F hex - μ) + x)
    have hstart : μ ≤ minStablePeriodMultiple F hex := by simpa [μ] using he.1
    convert h' using 1 <;> congr 1 <;> omega
  have hmod : ((minStablePeriodMultiple F hex - μ) + r) % lam =
      ((minStablePeriodMultiple F hex - μ) + s) % lam := by
    apply iterateMap_injective_in_cycle F hex
      (Nat.mod_lt _ (by simpa [lam] using minPositivePeriod_pos F hex))
      (Nat.mod_lt _ (by simpa [lam] using minPositivePeriod_pos F hex))
    exact (hreduce r).symm.trans (h.trans (hreduce s))
  have hmodeq : (minStablePeriodMultiple F hex - μ) + r ≡
      (minStablePeriodMultiple F hex - μ) + s [MOD lam] := hmod
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
    (Finset.range (minPositivePeriod F hex)).image (cyclePower F hex) = cyclePart F hex := by
  apply Finset.eq_of_subset_of_card_le
  · intro G hG
    rcases Finset.mem_image.mp hG with ⟨r, _hr, rfl⟩
    rw [cyclePower_eq_iterateMap]
    apply (mem_tail_minCollisionStart_iff_mem_cyclePart F hex _).mp
    refine ⟨minStablePeriodMultiple F hex + r - minCollisionStart F hex, ?_⟩
    congr 1
    have he := (minStablePeriodMultiple_spec F hex).1
    omega
  · rw [card_cyclePart, Finset.card_image_iff.mpr]
    · simp
    · intro r hr s hs h
      exact cyclePower_injective_in_period F hex
        (Finset.mem_range.mp hr) (Finset.mem_range.mp hs) h

/-- 巡回部の元数、したがって巡回群の位数は `λ_F` である。 -/
theorem cyclePart_card_eq_minPositivePeriod :
    (cyclePart F hex).card = minPositivePeriod F hex :=
  card_cyclePart F hex

/-- 有限真理値表から有限走査できる `C_F` の合成表。 -/
noncomputable def cycleMultiplicationTable : Finset
    ((X → X) ×
      (X → X) ×
      (X → X)) := by
  classical
  exact ((cyclePart F hex).product (cyclePart F hex)).image
    (fun pair => (pair.1, pair.2, pair.1 ∘ pair.2))

/-- 合成表から有限走査できる逆元候補の表。 -/
noncomputable def cycleInverseTable : Finset
    ((X → X) ×
      (X → X)) := by
  classical
  exact ((cyclePart F hex).product (cyclePart F hex)).filter
    (fun pair => pair.1 ∘ pair.2 = cycleIdempotent F hex)

/-- 巡回部への所属、合成、単位元・生成元の等号は有限型上で決定可能である。 -/
noncomputable instance (G : X → X) :
    Decidable (G ∈ cyclePart F hex) := Finset.decidableMem G (cyclePart F hex)

end CellularAutomata.NecSuf.IterateMonoidCyclicGroup
