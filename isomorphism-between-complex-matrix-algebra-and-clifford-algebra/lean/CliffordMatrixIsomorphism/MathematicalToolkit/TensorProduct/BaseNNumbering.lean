/-
節「テンソル積」のうち、写像 {1,…,k} → {1,…,n} の全体の集合と、その n 進の番号付け。人手証明と 1 対 1 に対応させる。

  本文のラベル                                   このファイル
  def_set_of_maps_between_initial_segments       MapsBetweenInitialSegments（X_{n,k} := Idx k → Idx n）・
                                                 emptyMap（∅_n）・MapsBetweenInitialSegments.ext（各点の値での等しさ）
  def_power_of_nonnegative_integer               natPower（n^0 := 1、n^k := n · n^{k-1}）
  def_base_n_numbering_of_maps                   digitHigh（a）・digitLow（r）・digit_decomposition（存在）・
                                                 digit_unique（一意性）・baseNNumbering（η_{n,k}）
  claim_base_n_numbering_is_numbering_of_maps    baseNNumbering_isNumbering・isFiniteSet_maps

本文の η_{n,k} の定義は k ≥ 1 の段で組 (a, r) の存在と一意性を示す。存在は余りのある割り算で
q := (m-1) / n^{k-1}、ρ := (m-1) mod n^{k-1}、a := q + 1、r := ρ + 1 と置いて示すので、Lean でも a・r をこの式で定め
（`digitHigh`・`digitLow`）、本文の三つの不等式と等式の鎖を `digit_decomposition` に、一意性を `digit_unique` に書く。
Lean の帰納的定義は k + 1 の段を k の段から作るので、本文の n^{k-1}・η_{n,k-1} は n^k・η_{n,k} と読む。
番号の整数の計算（ℕ の加減・積・割り算と順序）は `omega` と ℕ の割り算の補題で行う。本文も ℤ の算術を既知として使う。

この節の定義と主張は ℂ を含まないので、必要十分版はこのファイルをそのまま引く（必要十分版を別に置かない）。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.Numbering

namespace CliffordMatrixIsomorphism

/-- 本文 `def_set_of_maps_between_initial_segments`：X_{n,k} := {1,…,n}^{1,…,k}。 -/
abbrev MapsBetweenInitialSegments (n k : ℕ) : Type := Idx k → Idx n

/-- 本文 `def_set_of_maps_between_initial_segments`：X_{n,0} のただ一つの元 ∅_n。 -/
def emptyMap (n : ℕ) : MapsBetweenInitialSegments n 0 :=
  fun s => absurd (le_trans s.2.1 s.2.2) (by omega)

/-- 本文 `def_set_of_maps_between_initial_segments`：X_{n,k} の二元は、すべての s で値が等しければ等しい。 -/
theorem MapsBetweenInitialSegments.ext {n k : ℕ} {x y : MapsBetweenInitialSegments n k}
    (h : ∀ s : Idx k, x s = y s) : x = y :=
  funext h

/-- 本文 `def_set_of_maps_between_initial_segments`：X_{n,0} の元は ∅_n ただ一つである。 -/
theorem eq_emptyMap {n : ℕ} (x : MapsBetweenInitialSegments n 0) : x = emptyMap n :=
  MapsBetweenInitialSegments.ext (fun s => absurd (le_trans s.2.1 s.2.2) (by omega))

/-- 本文 `def_power_of_nonnegative_integer`：n^0 := 1、n^k := n · n^{k-1}。 -/
def natPower (n : ℕ) : ℕ → ℕ
  | 0 => 1
  | k + 1 => n * natPower n k

/-- 本文 `def_base_n_numbering_of_maps` の a := q + 1（q := (m-1) / n^{k-1}）。 -/
def digitHigh (n k m : ℕ) : ℕ := (m - 1) / natPower n k + 1

/-- 本文 `def_base_n_numbering_of_maps` の r := ρ + 1（ρ := (m-1) mod n^{k-1}）。 -/
def digitLow (n k m : ℕ) : ℕ := (m - 1) % natPower n k + 1

/-- 本文 `def_base_n_numbering_of_maps` の組 (a, r) の存在：m ∈ {1,…,n · n^{k-1}} なら
a ∈ {1,…,n}、r ∈ {1,…,n^{k-1}}、m = (a-1) · n^{k-1} + r。 -/
theorem digit_decomposition (n k m : ℕ) (hm1 : 1 ≤ m) (hm2 : m ≤ natPower n (k + 1)) :
    (1 ≤ digitHigh n k m ∧ digitHigh n k m ≤ n) ∧
      (1 ≤ digitLow n k m ∧ digitLow n k m ≤ natPower n k) ∧
      m = (digitHigh n k m - 1) * natPower n k + digitLow n k m := by
  -- 1 ≤ m ≤ n^k = n · n^{k-1}
  have hpow : natPower n (k + 1) = n * natPower n k := rfl
  -- n と n^{k-1} はどちらも 1 以上（どちらかが 0 なら積は 0）
  have hP : 1 ≤ natPower n k := by
    rcases Nat.eq_zero_or_pos (natPower n k) with h0 | h0
    · rw [hpow, h0, Nat.mul_zero] at hm2
      omega
    · exact h0
  -- 余りのある割り算 m - 1 = q · n^{k-1} + ρ、0 ≤ ρ < n^{k-1}
  set q := (m - 1) / natPower n k with hq
  set ρ := (m - 1) % natPower n k with hρ
  have hdiv : q * natPower n k + ρ = m - 1 := by
    rw [hq, hρ, Nat.mul_comm]
    exact Nat.div_add_mod (m - 1) (natPower n k)
  have hρlt : ρ < natPower n k := Nat.mod_lt _ hP
  -- q · n^{k-1} ≤ m - 1 ≤ n^k - 1 = n · n^{k-1} - 1 < n · n^{k-1} から q < n
  have hqlt : q * natPower n k < n * natPower n k := calc
    q * natPower n k ≤ q * natPower n k + ρ := Nat.le_add_right _ _
    _ = m - 1 := hdiv
    _ ≤ natPower n (k + 1) - 1 := by omega
    _ = n * natPower n k - 1 := by rw [hpow]
    _ < n * natPower n k := by rw [← hpow]; omega
  have hqn : q < n := Nat.lt_of_mul_lt_mul_right hqlt
  refine ⟨⟨Nat.le_add_left 1 q, hqn⟩, ⟨Nat.le_add_left 1 ρ, hρlt⟩, ?_⟩
  -- (a-1) · n^{k-1} + r = q · n^{k-1} + (ρ+1) = (q · n^{k-1} + ρ) + 1 = (m-1) + 1 = m
  show m = (q + 1 - 1) * natPower n k + (ρ + 1)
  calc m = (m - 1) + 1 := by omega
    _ = (q * natPower n k + ρ) + 1 := by rw [hdiv]
    _ = q * natPower n k + (ρ + 1) := by rw [Nat.add_assoc]
    _ = (q + 1 - 1) * natPower n k + (ρ + 1) := by rw [Nat.add_sub_cancel]

/-- 本文 `def_base_n_numbering_of_maps` の組 (a, r) の一意性：a' ∈ {1,…,n}、r' ∈ {1,…,n^{k-1}} が
m = (a'-1) · n^{k-1} + r' を満たせば (a', r') = (a, r)。 -/
theorem digit_unique (n k m a' r' : ℕ) (ha'1 : 1 ≤ a') (hr'1 : 1 ≤ r') (hr'2 : r' ≤ natPower n k)
    (h : m = (a' - 1) * natPower n k + r') : a' = digitHigh n k m ∧ r' = digitLow n k m := by
  -- m - 1 = (a'-1) · n^{k-1} + (r'-1)
  have hm : m - 1 = (a' - 1) * natPower n k + (r' - 1) := by
    calc m - 1 = ((a' - 1) * natPower n k + r') - 1 := by rw [h]
      _ = (a' - 1) * natPower n k + (r' - 1) := by omega
  have hlt : r' - 1 < natPower n k := by omega
  -- 割り算の一意性
  have hq : (m - 1) / natPower n k = a' - 1 := by
    rw [hm, Nat.add_comm, Nat.add_mul_div_right _ _ (by omega), Nat.div_eq_of_lt hlt, Nat.zero_add]
  have hρ : (m - 1) % natPower n k = r' - 1 := by
    rw [hm, Nat.add_comm, Nat.add_mul_mod_self_right, Nat.mod_eq_of_lt hlt]
  constructor
  · unfold digitHigh; rw [hq]; omega
  · unfold digitLow; rw [hρ]; omega

/-- 本文 `def_base_n_numbering_of_maps`：η_{n,k} : {1,…,n^k} → X_{n,k}。
η_{n,0}(1) := ∅_n。k + 1 の段では η_{n,k+1}(m)(s) := η_{n,k}(r)(s)（s ≤ k）、η_{n,k+1}(m)(k+1) := a。 -/
def baseNNumbering (n : ℕ) : (k : ℕ) → Idx (natPower n k) → MapsBetweenInitialSegments n k
  | 0 => fun _ => emptyMap n
  | k + 1 => fun m s =>
    if hs : s.1 ≤ k then
      baseNNumbering n k ⟨digitLow n k m.1, (digit_decomposition n k m.1 m.2.1 m.2.2).2.1⟩
        ⟨s.1, s.2.1, hs⟩
    else ⟨digitHigh n k m.1, (digit_decomposition n k m.1 m.2.1 m.2.2).1⟩

/-- 本文 `def_base_n_numbering_of_maps` の η_{n,k}(m)(s) := η_{n,k-1}(r)(s)（s ∈ {1,…,k-1}）。 -/
theorem baseNNumbering_succ_of_le (n k : ℕ) (m : Idx (natPower n (k + 1))) (s : Idx (k + 1))
    (hs : s.1 ≤ k) :
    baseNNumbering n (k + 1) m s
      = baseNNumbering n k ⟨digitLow n k m.1, (digit_decomposition n k m.1 m.2.1 m.2.2).2.1⟩
          ⟨s.1, s.2.1, hs⟩ := by
  simp only [baseNNumbering, dif_pos hs]

/-- 本文 `def_base_n_numbering_of_maps` の η_{n,k}(m)(k) := a。 -/
theorem baseNNumbering_succ_last (n k : ℕ) (m : Idx (natPower n (k + 1))) (s : Idx (k + 1))
    (hs : ¬ s.1 ≤ k) :
    (baseNNumbering n (k + 1) m s).1 = digitHigh n k m.1 := by
  simp only [baseNNumbering, dif_neg hs]

/-- 本文 `claim_base_n_numbering_is_numbering_of_maps`：(n^k, η_{n,k}) は X_{n,k} の番号付けである。 -/
theorem baseNNumbering_isNumbering (n : ℕ) :
    ∀ k : ℕ, IsNumbering (natPower n k) (baseNNumbering n k)
  | 0 => by
    constructor
    · -- 単射の条件：m, m' ∈ {1} なら m = 1 = m'
      intro m m' _
      have h1 : m.1 = 1 := le_antisymm m.2.2 m.2.1
      have h2 : m'.1 = 1 := le_antisymm m'.2.2 m'.2.1
      exact Subtype.ext (h1.trans h2.symm)
    · -- 全射の条件：X_{n,0} の元は ∅_n ただ一つで、η_{n,0}(1) = ∅_n
      intro x
      refine ⟨⟨1, le_refl 1, le_refl 1⟩, ?_⟩
      show emptyMap n = x
      exact (eq_emptyMap x).symm
  | k + 1 => by
    -- 帰納法の仮定
    have ih := baseNNumbering_isNumbering n k
    -- (a_m, r_m) の性質
    have hdec := fun m : Idx (natPower n (k + 1)) => digit_decomposition n k m.1 m.2.1 m.2.2
    have hlast : k + 1 ≤ k + 1 := le_refl _
    have hnotle : ¬ (⟨k + 1, Nat.succ_pos k, hlast⟩ : Idx (k + 1)).1 ≤ k := Nat.not_succ_le_self k
    constructor
    · -- 単射の条件
      intro m m' hmm'
      -- a_m = η(m)(k) = η(m')(k) = a_{m'}
      have ha : digitHigh n k m.1 = digitHigh n k m'.1 := calc
        digitHigh n k m.1 = (baseNNumbering n (k + 1) m ⟨k + 1, Nat.succ_pos k, hlast⟩).1 :=
            (baseNNumbering_succ_last n k m ⟨k + 1, Nat.succ_pos k, hlast⟩ hnotle).symm
        _ = (baseNNumbering n (k + 1) m' ⟨k + 1, Nat.succ_pos k, hlast⟩).1 := by rw [hmm']
        _ = digitHigh n k m'.1 := baseNNumbering_succ_last n k m' ⟨k + 1, Nat.succ_pos k, hlast⟩ hnotle
      -- s ∈ {1,…,k-1} で η_{n,k-1}(r_m)(s) = η(m)(s) = η(m')(s) = η_{n,k-1}(r_{m'})(s)
      have hr' : baseNNumbering n k ⟨digitLow n k m.1, (hdec m).2.1⟩
          = baseNNumbering n k ⟨digitLow n k m'.1, (hdec m').2.1⟩ := by
        apply MapsBetweenInitialSegments.ext
        intro s
        have hs : s.1 ≤ k := s.2.2
        calc baseNNumbering n k ⟨digitLow n k m.1, (hdec m).2.1⟩ s
            = baseNNumbering n k ⟨digitLow n k m.1, (hdec m).2.1⟩ ⟨s.1, s.2.1, hs⟩ := rfl
          _ = baseNNumbering n (k + 1) m ⟨s.1, s.2.1, by omega⟩ :=
              (baseNNumbering_succ_of_le n k m ⟨s.1, s.2.1, by omega⟩ hs).symm
          _ = baseNNumbering n (k + 1) m' ⟨s.1, s.2.1, by omega⟩ := by rw [hmm']
          _ = baseNNumbering n k ⟨digitLow n k m'.1, (hdec m').2.1⟩ ⟨s.1, s.2.1, hs⟩ :=
              baseNNumbering_succ_of_le n k m' ⟨s.1, s.2.1, by omega⟩ hs
      -- 帰納法の仮定の単射の条件から r_m = r_{m'}
      have hr : digitLow n k m.1 = digitLow n k m'.1 :=
        congrArg Subtype.val (ih.injective _ _ hr')
      -- m = (a_m - 1) · n^{k-1} + r_m = (a_{m'} - 1) · n^{k-1} + r_{m'} = m'
      apply Subtype.ext
      calc m.1 = (digitHigh n k m.1 - 1) * natPower n k + digitLow n k m.1 := (hdec m).2.2
        _ = (digitHigh n k m'.1 - 1) * natPower n k + digitLow n k m'.1 := by rw [ha, hr]
        _ = m'.1 := ((hdec m').2.2).symm
    · -- 全射の条件
      intro x
      -- a := x(k)、x'(s) := x(s)（s ∈ {1,…,k-1}）
      set a : ℕ := (x ⟨k + 1, Nat.succ_pos k, hlast⟩).1 with ha_def
      have ha1 : 1 ≤ a := (x ⟨k + 1, Nat.succ_pos k, hlast⟩).2.1
      have ha2 : a ≤ n := (x ⟨k + 1, Nat.succ_pos k, hlast⟩).2.2
      let x' : MapsBetweenInitialSegments n k := fun s => x ⟨s.1, s.2.1, by omega⟩
      -- η_{n,k-1}(r) = x' を満たす r
      obtain ⟨r, hr⟩ := ih.surjective x'
      -- m := (a - 1) · n^{k-1} + r ∈ {1,…,n^k}
      set m : ℕ := (a - 1) * natPower n k + r.1 with hm_def
      have hm1 : 1 ≤ m := calc
        1 ≤ r.1 := r.2.1
        _ ≤ (a - 1) * natPower n k + r.1 := Nat.le_add_left _ _
        _ = m := rfl
      have hm2 : m ≤ natPower n (k + 1) := calc
        m = (a - 1) * natPower n k + r.1 := rfl
        _ ≤ (n - 1) * natPower n k + r.1 := by
            have := Nat.mul_le_mul_right (natPower n k) (Nat.sub_le_sub_right ha2 1)
            omega
        _ ≤ (n - 1) * natPower n k + natPower n k := by have := r.2.2; omega
        _ = n * natPower n k := by
            rw [← Nat.succ_mul, Nat.succ_eq_add_one, Nat.sub_add_cancel (le_trans ha1 ha2)]
        _ = natPower n (k + 1) := rfl
      -- 組の一意性から (a_m, r_m) = (a, r)
      obtain ⟨hau, hru⟩ := digit_unique n k m a r.1 ha1 r.2.1 r.2.2 rfl
      refine ⟨⟨m, hm1, hm2⟩, ?_⟩
      apply MapsBetweenInitialSegments.ext
      intro s
      by_cases hs : s.1 ≤ k
      · -- η(m)(s) = η_{n,k-1}(r_m)(s) = η_{n,k-1}(r)(s) = x'(s) = x(s)
        have hrm : (⟨digitLow n k m, (digit_decomposition n k m hm1 hm2).2.1⟩ : Idx (natPower n k))
            = r := Subtype.ext hru.symm
        calc baseNNumbering n (k + 1) ⟨m, hm1, hm2⟩ s
            = baseNNumbering n k ⟨digitLow n k m, (digit_decomposition n k m hm1 hm2).2.1⟩
                ⟨s.1, s.2.1, hs⟩ := baseNNumbering_succ_of_le n k ⟨m, hm1, hm2⟩ s hs
          _ = baseNNumbering n k r ⟨s.1, s.2.1, hs⟩ := by rw [hrm]
          _ = x' ⟨s.1, s.2.1, hs⟩ := by rw [hr]
          _ = x s := rfl
      · -- η(m)(k) = a_m = a = x(k)
        have hsk : s = ⟨k + 1, Nat.succ_pos k, hlast⟩ := Subtype.ext (by have := s.2.2; show s.1 = k + 1; omega)
        apply Subtype.ext
        calc (baseNNumbering n (k + 1) ⟨m, hm1, hm2⟩ s).1 = digitHigh n k m :=
              baseNNumbering_succ_last n k ⟨m, hm1, hm2⟩ s hs
          _ = a := hau.symm
          _ = (x s).1 := by rw [hsk]

/-- 本文 `claim_base_n_numbering_is_numbering_of_maps`：X_{n,k} は有限集合である。 -/
theorem isFiniteSet_maps (n k : ℕ) : IsFiniteSet (MapsBetweenInitialSegments n k) :=
  ⟨natPower n k, baseNNumbering n k, baseNNumbering_isNumbering n k⟩

end CliffordMatrixIsomorphism
