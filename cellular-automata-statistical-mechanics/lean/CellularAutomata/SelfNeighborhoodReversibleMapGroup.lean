/-
章「自己近傍舞台の可逆大域写像群」の Lean 具体版。
人手証明の正本は structured-latex/content/self-neighborhood-reversible-map-group.ts。

有限舞台 V、二元状態 State、自己近傍、局所真理値表という人手証明と同じ対象に固定する。
有限集合・写像・自然数だけを使い、R / C は現れない。
-/
import CellularAutomata.LocalityRestrictsCycleType

namespace CellularAutomata.SelfNeighborhoodReversibleMapGroup

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.LocalityRestrictsCycleType

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 自己近傍 N_self(v) = {v}。 -/
def selfNbhd (v : V) : Finset V := {v}

/-- 自己近傍舞台の局所規則族。 -/
abbrev SelfLocalRuleFamily := LocalRuleFamily (selfNbhd (V := V))

/-- 局所規則 f_v から得る一セル値写像 g_v。 -/
def valueMap (f : SelfLocalRuleFamily (V := V)) (v : V) : State → State :=
  fun a => f v (fun _ => a)

/-- 自己近傍舞台の大域写像はセルごとの値写像で書ける。 -/
theorem globalMap_self_apply (f : SelfLocalRuleFamily (V := V)) (x : V → State) (v : V) :
    globalMap (selfNbhd (V := V)) f x v = valueMap f v (x v) := by
  have h : restrict (selfNbhd (V := V) v) x = fun _ => x v := by
    funext u
    have huv : u.val = v := Finset.mem_singleton.mp u.property
    simp [restrict, huv]
  simp [globalMap, valueMap, h]

/-- 大域写像が単射なら、各セルの値写像は単射である。
    人手証明どおり、注目セル以外を基準値 zero にした二配位を使う。 -/
theorem valueMap_injective_of_globalMap_injective (f : SelfLocalRuleFamily (V := V))
    (hF : Function.Injective (globalMap (selfNbhd (V := V)) f)) (v : V) :
    Function.Injective (valueMap f v) := by
  intro a a' haa'
  let x : V → State := fun u => if u = v then a else State.zero
  let x' : V → State := fun u => if u = v then a' else State.zero
  have hx : globalMap (selfNbhd (V := V)) f x =
      globalMap (selfNbhd (V := V)) f x' := by
    funext u
    rw [globalMap_self_apply, globalMap_self_apply]
    by_cases huv : u = v
    · subst huv
      simpa [x, x'] using haa'
    · simp [x, x', huv]
  have hxx' := hF hx
  have hv := congrFun hxx' v
  simpa [x, x'] using hv

/-- 二元状態集合上の全単射は恒等写像か否定写像である。 -/
theorem binary_bijection_is_identity_or_negation {g : State → State}
    (hg : Function.Bijective g) : g = id ∨ g = nu :=
  selfRule_eq_id_or_neg hg.1

/-- 反転集合 S が定める大域写像 F_S。 -/
def flipMap (S : Finset V) (x : V → State) (v : V) : State :=
  if v ∈ S then nu (x v) else x v

/-- F_S は自分自身を逆写像に持つ。 -/
theorem flipMap_involution (S : Finset V) (x : V → State) :
    flipMap S (flipMap S x) = x := by
  funext v
  by_cases hv : v ∈ S
  · cases h : x v <;> simp [flipMap, hv, h, nu]
  · simp [flipMap, hv]

theorem flipMap_injective (S : Finset V) : Function.Injective (flipMap S) := by
  intro x y hxy
  rw [← flipMap_involution S x, ← flipMap_involution S y, hxy]

/-- F_S は自己近傍舞台の局所規則族から得られる。 -/
def flipRuleFamily (S : Finset V) : SelfLocalRuleFamily (V := V) :=
  fun v z => if v ∈ S then nu (z ⟨v, Finset.mem_singleton_self v⟩)
    else z ⟨v, Finset.mem_singleton_self v⟩

theorem globalMap_flipRuleFamily (S : Finset V) :
    globalMap (selfNbhd (V := V)) (flipRuleFamily S) = flipMap S := by
  funext x v
  simp [globalMap_self_apply, valueMap, flipRuleFamily, flipMap]

/-- 可逆な自己近傍大域写像は、ある反転集合 S の F_S に一致する。 -/
theorem exists_flipMap_of_injective (f : SelfLocalRuleFamily (V := V))
    (hF : Function.Injective (globalMap (selfNbhd (V := V)) f)) :
    ∃ S : Finset V, globalMap (selfNbhd (V := V)) f = flipMap S := by
  classical
  let S : Finset V := Finset.univ.filter (fun v => valueMap f v = nu)
  refine ⟨S, ?_⟩
  funext x v
  rw [globalMap_self_apply]
  have hgInj := valueMap_injective_of_globalMap_injective f hF v
  rcases selfRule_eq_id_or_neg hgInj with hid | hnu
  · have hv : v ∉ S := by
      simp only [S, Finset.mem_filter, Finset.mem_univ, true_and]
      intro heq
      have : (id : State → State) = nu := hid.symm.trans heq
      have hz := congrFun this State.zero
      simp [nu] at hz
    simp [flipMap, hv, hid]
  · have hv : v ∈ S := by simp [S, hnu]
    simp [flipMap, hv, hnu]

/-- 可逆な自己近傍大域写像全体。反転集合の像として有限表にする。 -/
noncomputable def reversibleMaps : Finset ((V → State) → V → State) := by
  classical
  exact Finset.univ.image (flipMap : Finset V → (V → State) → V → State)

/-- 反転集合から大域写像への対応は単射である。 -/
theorem flipMap_family_injective : Function.Injective (flipMap : Finset V → (V → State) → V → State) := by
  intro S T hST
  ext v
  by_contra hmem
  have hx := congrFun (congrFun hST (fun _ => State.zero)) v
  simp only [flipMap] at hx
  by_cases hvS : v ∈ S <;> by_cases hvT : v ∈ T <;>
    simp [hvS, hvT, nu] at hx hmem

/-- 可逆な自己近傍大域写像は反転集合によって一意に分類される。 -/
theorem mem_reversibleMaps_iff (F : (V → State) → V → State) :
    F ∈ reversibleMaps (V := V) ↔
      ∃ f : SelfLocalRuleFamily (V := V),
        Function.Injective (globalMap (selfNbhd (V := V)) f) ∧
        F = globalMap (selfNbhd (V := V)) f := by
  classical
  constructor
  · rw [reversibleMaps, Finset.mem_image]
    rintro ⟨S, -, rfl⟩
    exact ⟨flipRuleFamily S, by simpa [globalMap_flipRuleFamily] using flipMap_injective S,
      (globalMap_flipRuleFamily S).symm⟩
  · rintro ⟨f, hf, rfl⟩
    obtain ⟨S, hS⟩ := exists_flipMap_of_injective f hf
    rw [reversibleMaps, Finset.mem_image]
    exact ⟨S, Finset.mem_univ _, hS.symm⟩

/-- 可逆な自己近傍大域写像の個数は 2^{|V|}。 -/
theorem card_reversibleMaps :
    (reversibleMaps (V := V)).card = 2 ^ Fintype.card V := by
  classical
  rw [reversibleMaps, Finset.card_image_of_injective _ flipMap_family_injective,
    Finset.card_univ, Fintype.card_finset]

/-- 有限部分集合の対称差。 -/
def symmDiff (S T : Finset V) : Finset V := (S \ T) ∪ (T \ S)

/-- 合成は反転集合の対称差に一致する。 -/
theorem flipMap_comp (S T : Finset V) :
    flipMap S ∘ flipMap T = flipMap (symmDiff S T) := by
  funext x v
  by_cases hs : v ∈ S <;> by_cases ht : v ∈ T <;>
    cases h : x v <;> simp [Function.comp_apply, flipMap, symmDiff, hs, ht, h, nu]

theorem flipMap_comm (S T : Finset V) : flipMap S ∘ flipMap T = flipMap T ∘ flipMap S := by
  rw [flipMap_comp, flipMap_comp]
  congr 1
  ext v
  simp [symmDiff, and_comm, or_comm]

/-- 可逆写像表は合成で閉じる。 -/
theorem reversibleMaps_comp_closed {F G : (V → State) → V → State}
    (hF : F ∈ reversibleMaps (V := V)) (hG : G ∈ reversibleMaps (V := V)) :
    F ∘ G ∈ reversibleMaps (V := V) := by
  classical
  rw [reversibleMaps, Finset.mem_image] at hF hG ⊢
  obtain ⟨S, -, rfl⟩ := hF
  obtain ⟨T, -, rfl⟩ := hG
  exact ⟨symmDiff S T, Finset.mem_univ _, (flipMap_comp S T).symm⟩

/-- 空反転集合は合成単位元である。 -/
theorem flipMap_empty : flipMap (∅ : Finset V) = id := by
  funext x v
  simp [flipMap]

/-- 空でない反転集合の写像は固定点を持たない。 -/
theorem flipMap_fixedPointFree (S : Finset V) (hS : S.Nonempty) (x : V → State) :
    flipMap S x ≠ x := by
  obtain ⟨v, hv⟩ := hS
  intro h
  have hx := congrFun h v
  cases hval : x v <;> simp [flipMap, hv, hval, nu] at hx

/-- 空でない反転集合の各軌道は二元である。 -/
theorem flipMap_orbit_card_two (S : Finset V) (hS : S.Nonempty) (x : V → State) :
    ({x, flipMap S x} : Finset (V → State)).card = 2 := by
  rw [Finset.card_pair]
  exact Ne.symm (flipMap_fixedPointFree S hS x)

/-- 空でない反転集合の巡回型は 2^{|V|-1} 個の 2 からなる。 -/
theorem cycleType_flipMap_of_nonempty (S : Finset V) (hS : S.Nonempty) :
    ReversibleGlobalMapCycleType.cycleType
        (⟨flipMap S, flipMap_injective S⟩ :
          ReversibleGlobalMapCycleType.ReversibleMap V) =
      Multiset.replicate (2 ^ (Fintype.card V - 1)) 2 := by
  classical
  let F : ReversibleGlobalMapCycleType.ReversibleMap V := ⟨flipMap S, flipMap_injective S⟩
  let σ := ReversibleGlobalMapCycleType.toPerm F
  have hpow : σ ^ 2 = 1 := by
    apply Equiv.ext
    intro x
    simpa [σ, F, pow_two] using flipMap_involution S x
  have hsupport : σ.support = Finset.univ := by
    ext x
    simp [Equiv.Perm.mem_support, σ, F, flipMap_fixedPointFree S hS x]
  have htype := Equiv.Perm.cycleType_of_pow_prime_eq_one (p := 2) hpow
  have hsum : σ.cycleType.sum = 2 ^ Fintype.card V := by
    rw [σ.sum_cycleType, hsupport, Finset.card_univ, Fintype.card_fun,
      CellularAutomata.EssentialDependency.card_state]
  have hVpos : 0 < Fintype.card V := by
    obtain ⟨v, -⟩ := hS
    exact Fintype.card_pos_iff.mpr ⟨v⟩
  have hpow_split : 2 ^ Fintype.card V = 2 * 2 ^ (Fintype.card V - 1) := by
    obtain ⟨n, hn⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hVpos)
    rw [hn]
    calc
      2 ^ (n + 1) = 2 ^ n * 2 := pow_succ 2 n
      _ = 2 * 2 ^ n := Nat.mul_comm _ _
      _ = 2 * 2 ^ (n + 1 - 1) := by rw [Nat.add_sub_cancel]
  have hcard : σ.cycleType.card = 2 ^ (Fintype.card V - 1) := by
    have hcount : σ.cycleType.card * 2 = 2 ^ Fintype.card V := by
      rw [htype] at hsum
      simpa only [Multiset.sum_replicate, nsmul_eq_mul, Nat.cast_id] using hsum
    have hmul : σ.cycleType.card * 2 = 2 ^ (Fintype.card V - 1) * 2 := by
      calc
        σ.cycleType.card * 2 = 2 ^ Fintype.card V := hcount
        _ = 2 * 2 ^ (Fintype.card V - 1) := hpow_split
        _ = 2 ^ (Fintype.card V - 1) * 2 := Nat.mul_comm _ _
    exact Nat.mul_right_cancel (by decide : 0 < 2) hmul
  have hfinal : ReversibleGlobalMapCycleType.cycleType F =
      Multiset.replicate (2 ^ (Fintype.card V - 1)) 2 := by
    have htypeF : (ReversibleGlobalMapCycleType.toPerm F).cycleType =
        Multiset.replicate (ReversibleGlobalMapCycleType.toPerm F).cycleType.card 2 := by
      simpa [σ] using htype
    have hcardF : (ReversibleGlobalMapCycleType.toPerm F).cycleType.card =
        2 ^ (Fintype.card V - 1) := by simpa [σ] using hcard
    have hconfig : Fintype.card (ReversibleGlobalMapCycleType.Config V) =
        2 ^ Fintype.card V := by
      simp [ReversibleGlobalMapCycleType.Config, Fintype.card_fun,
        CellularAutomata.EssentialDependency.card_state]
    have hrepSum : (Multiset.replicate (2 ^ (Fintype.card V - 1)) 2).sum =
        Fintype.card (ReversibleGlobalMapCycleType.Config V) := by
      rw [Multiset.sum_replicate, nsmul_eq_mul, hconfig, Nat.mul_comm]
      exact hpow_split.symm
    rw [ReversibleGlobalMapCycleType.cycleType, htypeF, hcardF, hrepSum,
      Nat.sub_self]
    simp
  simpa [F] using hfinal

/-- 空反転集合の巡回型は全配位数個の 1 からなる。 -/
theorem cycleType_flipMap_empty :
    ReversibleGlobalMapCycleType.cycleType
        (⟨flipMap (∅ : Finset V), flipMap_injective ∅⟩ :
          ReversibleGlobalMapCycleType.ReversibleMap V) =
      Multiset.replicate (2 ^ Fintype.card V) 1 := by
  classical
  let F : ReversibleGlobalMapCycleType.ReversibleMap V :=
    ⟨flipMap (∅ : Finset V), flipMap_injective ∅⟩
  have hp : ReversibleGlobalMapCycleType.toPerm F = 1 := by
    apply Equiv.ext
    intro x
    simpa [F, ReversibleGlobalMapCycleType.toPerm_apply, flipMap_empty]
  have hfinal : ReversibleGlobalMapCycleType.cycleType F =
      Multiset.replicate (2 ^ Fintype.card V) 1 := by
    rw [ReversibleGlobalMapCycleType.cycleType, hp]
    simp [ReversibleGlobalMapCycleType.Config, Fintype.card_fun,
      CellularAutomata.EssentialDependency.card_state]
  simpa [F] using hfinal

end CellularAutomata.SelfNeighborhoodReversibleMapGroup
