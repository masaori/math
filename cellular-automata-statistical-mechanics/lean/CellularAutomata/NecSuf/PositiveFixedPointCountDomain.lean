/-
正の不動点数の定義域の必要十分版。本文の同値列・衝突証人・剰余判定の順を保つ。
元数の上界には有限部分集合の包含だけが要る。倍数条件には各点の周期判定と
その周期の像の所属条件だけが要り、台全体の有限性は不要である。
有限性は、周期の表を台全体から作る段と、全軌道に元数以下の衝突を保証する段に残る。
有理数への入力には正の自然数だけが要り、反復も不要である。
一セル反転の帰納法は任意の対合に、奇数回の零個は不動点を持たない対合に広がる。
有限性はその不動点を数える段、二値性は全配位の個数を2へ評価する段にだけ残る。
抽象化は本ファイル内だけで行い、最後で具体版を特殊化として導出する。

本文ラベルとの対応（具体版と同じ順序）:
claim_fixed_point_count_bounded_by_cardinality → count_bounds → Derivation.bounds
claim_positive_count_domain_iff_period_divides → domain_iff_period_divides, zero_iff
  → Derivation.domain, Derivation.zero
claim_positive_count_domain_small_witness → collision_witness, nonempty_iff_small_witness
  → Derivation.small_witness
claim_positive_count_domain_finitely_decidable → mem_lengthsFromData, lengths_bound,
  remainder_iff, decision_correct → Derivation.finite_table, period_bounds, data_table,
  remainder, decision
 def_positive_fixed_point_count_rational_input → rationalInput, rationalInput_value
  → Derivation.rational
claim_binary_ca_fixed_point_count_bound → BinaryDerivation.bounds
claim_binary_ca_positive_count_domain_nonempty → BinaryDerivation.small_witness
claim_single_cell_flip_positive_count_domain → even_iterate, odd_iterate, odd_count,
  even_count, involution_domain → FlipDerivation.odd, even, domain, one_excluded

有限周期表の計算は、既存の最小前周期・最小周期の有限走査で得た正しい表を入力する。
その走査を新しい仮定なしに作り直した、という主張ではない。
剰余判定の補題自体は自然数の全域演算を使えるが、本文へ渡す表は period_bounds により
正の周期だけを含む。零による除算を本文へ持ち込まない。
-/
import CellularAutomata.BinaryCAPositiveCountDomain

namespace CellularAutomata.NecSuf.PositiveFixedPointCountDomain

open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.PeriodicPointCount
open CellularAutomata.NecSuf.MinimalPreperiodPeriod

variable {X : Type}

/-- 有限台全体でなく、数える集合と有限な上界の集合だけを用いる。 -/
theorem count_bounds (s t : Finset X) (h : s ⊆ t) : 0 ≤ s.card ∧ s.card ≤ t.card := by
  refine ⟨Nat.zero_le _, ?_⟩
  calc s.card ≤ t.card := Finset.card_le_card h

def positiveDomain (count : ℕ → ℕ) : Set ℕ := {n | 1 ≤ n ∧ 0 < count n}

/-- 本文の点ごとの既存補題を明示的な入力とし、全台の有限性を使わない。 -/
theorem domain_iff_period_divides
    (fixed : ℕ → Finset X) (mu pi : X → ℕ) (periodic : X → Prop) (lengths : Finset ℕ)
    (hfix : ∀ n, 1 ≤ n → ∀ x, x ∈ fixed n ↔
      mu x = 0 ∧ ∃ k : ℕ, n = k * pi x)
    (hperiodic : ∀ x, periodic x ↔ mu x = 0)
    (hlengths : ∀ d, d ∈ lengths ↔ ∃ x, periodic x ∧ pi x = d)
    (n : ℕ) (hn : 1 ≤ n) :
    n ∈ positiveDomain (fun j => (fixed j).card) ↔
      ∃ d ∈ lengths, ∃ k : ℕ, 1 ≤ k ∧ n = k * d := by
  have hcount : n ∈ positiveDomain (fun j => (fixed j).card) ↔
      ∃ x, x ∈ fixed n := by
    simp only [positiveDomain, Set.mem_setOf_eq, hn, true_and]
    rw [Finset.card_pos]
    rfl
  rw [hcount]
  constructor
  · rintro ⟨x, hx⟩
    obtain ⟨hmu, k, hk⟩ := (hfix n hn x).1 hx
    have hp := (hperiodic x).2 hmu
    refine ⟨pi x, (hlengths _).2 ⟨x, hp, rfl⟩, k, ?_, hk⟩
    by_contra h
    have hk0 : k = 0 := by omega
    rw [hk0, Nat.zero_mul] at hk
    omega
  · rintro ⟨d, hd, k, _, hk⟩
    obtain ⟨x, hp, hpi⟩ := (hlengths d).1 hd
    have hmu := (hperiodic x).1 hp
    refine ⟨x, (hfix n hn x).2 ⟨hmu, k, ?_⟩⟩
    rw [hpi]
    exact hk

/-- 零と正の二分には、数える値が自然数であることだけが要る。 -/
theorem zero_iff (count : ℕ → ℕ) (n : ℕ) (hn : 1 ≤ n) :
    count n = 0 ↔ n ∉ positiveDomain count := by
  simp only [positiveDomain, Set.mem_setOf_eq, hn, true_and, not_lt, Nat.le_zero]

/-- 衝突からの証人は、有限性ではなく一つの衝突とその添字上界を使う。 -/
theorem collision_witness (F : X → X) (x : X) (i j bound : ℕ)
    (hij : i < j) (hj : j ≤ bound) (hc : iterate F i x = iterate F j x) :
    1 ≤ j - i ∧ j - i ≤ bound ∧
      iterate F (j - i) (iterate F i x) = iterate F i x := by
  refine ⟨by omega, by omega, ?_⟩
  calc
    iterate F (j - i) (iterate F i x) = iterate F (j - i + i) x :=
      congrFun (CellularAutomata.NecSuf.IterateMonoid.iterateMap_comp_add F (j - i) i) x
    _ = iterate F j x := by congr 1; omega
    _ = iterate F i x := hc.symm

/-- 元数以下の衝突を全点に保証するためには有限性を残す。 -/
theorem nonempty_iff_small_witness [Fintype X] (F : X → X) :
    Nonempty X ↔ ∃ p, p ∈ positiveDomain (fixedPointCount F) ∧ p ≤ Fintype.card X := by
  constructor
  · rintro ⟨x⟩
    obtain ⟨i, j, hij, hj, hc⟩ := orbit_collision F x
    obtain ⟨hp, hb, hr⟩ := collision_witness F x i j _ hij hj hc
    have hm := (mem_fixedPoints F (j-i) (iterate F i x)).2 hr
    exact ⟨j-i, ⟨hp, Finset.card_pos.mpr ⟨_, hm⟩⟩, hb⟩
  · rintro ⟨p, hp, _⟩
    have hb := (count_bounds (fixedPoints F p) Finset.univ (Finset.subset_univ _)).2
    rw [Finset.card_univ] at hb
    exact Fintype.card_pos_iff.mp (lt_of_lt_of_le hp.2 hb)

/-- 有限な標本だけから、mu=0 の pi 値の表を作る。 -/
def lengthsFromData (sample : Finset X) (mu pi : X → ℕ) : Finset ℕ :=
  (sample.filter (fun x => mu x = 0)).image pi

theorem mem_lengthsFromData (sample : Finset X) (mu pi : X → ℕ) (d : ℕ) :
    d ∈ lengthsFromData sample mu pi ↔ ∃ x ∈ sample, mu x = 0 ∧ pi x = d := by
  simp only [lengthsFromData, Finset.mem_image, Finset.mem_filter]
  constructor
  · rintro ⟨x, ⟨hx, hm⟩, hp⟩
    exact ⟨x, hx, hm, hp⟩
  · rintro ⟨x, hx, hm, hp⟩
    exact ⟨x, ⟨hx, hm⟩, hp⟩

theorem lengths_bound (sample : Finset X) (mu pi : X → ℕ) (bound : ℕ)
    (h : ∀ x ∈ sample, mu x = 0 → 1 ≤ pi x ∧ pi x ≤ bound) :
    lengthsFromData sample mu pi ⊆ Finset.Icc 1 bound := by
  intro d hd
  obtain ⟨x, hx, hm, rfl⟩ := (mem_lengthsFromData sample mu pi d).1 hd
  exact Finset.mem_Icc.mpr (h x hx hm)

/-- 剰余による判定には自然数の有限表だけが要る。 -/
theorem remainder_iff (lengths : Finset ℕ) (n : ℕ) (hn : 1 ≤ n) :
    (∃ d ∈ lengths, ∃ k : ℕ, 1 ≤ k ∧ n = k * d) ↔
      ∃ d ∈ lengths, n % d = 0 := by
  constructor
  · rintro ⟨d, hd, k, _, hk⟩
    exact ⟨d, hd, Nat.mod_eq_zero_of_dvd ⟨k, by rw [hk, Nat.mul_comm]⟩⟩
  · rintro ⟨d, hd, hmod⟩
    obtain ⟨k, hk⟩ := Nat.dvd_of_mod_eq_zero hmod
    refine ⟨d, hd, k, ?_, by rw [hk, Nat.mul_comm]⟩
    by_contra h
    have hk0 : k = 0 := by omega
    rw [hk0, Nat.mul_zero] at hk
    omega

def decideFromTable (table : Finset ℕ) (n : ℕ) : Bool :=
  decide (1 ≤ n ∧ ∃ d ∈ table, n % d = 0)

theorem decision_correct (count : ℕ → ℕ) (table : Finset ℕ)
    (h : ∀ n, 1 ≤ n → (n ∈ positiveDomain count ↔ ∃ d ∈ table, n % d = 0))
    (n : ℕ) : decideFromTable table n = true ↔ n ∈ positiveDomain count := by
  simp only [decideFromTable, decide_eq_true_eq]
  by_cases hn : 1 ≤ n
  · simp only [hn, true_and]
    exact (h n hn).symm
  · simp [positiveDomain, hn]

def rationalInput (count : ℕ → ℕ) (n : positiveDomain count) : {q : ℚ // 0 < q} :=
  ⟨(count n.val : ℚ) / 1, by
    rw [div_one]
    exact_mod_cast n.property.2⟩

theorem rationalInput_value (count : ℕ → ℕ) (n : positiveDomain count) :
    (rationalInput count n).val = (count n.val : ℚ) / 1 := by
  unfold rationalInput
  rfl

/-- 自然数回の反復と二回で戻ることだけを使う、具体版と同じ帰納法。 -/
theorem even_iterate (F : X → X) (hF : ∀ x, F (F x) = x) (k : ℕ) (x : X) :
    iterate F (2*k) x = x := by
  induction k with
  | zero => rfl
  | succ k ih =>
    calc
      iterate F (2*(k+1)) x = iterate F (2+2*k) x := by congr 1; omega
      _ = iterate F 2 (iterate F (2*k) x) :=
        (congrFun (CellularAutomata.NecSuf.IterateMonoid.iterateMap_comp_add F 2 (2*k)) x).symm
      _ = iterate F 2 x := congrArg (iterate F 2) ih
      _ = x := hF x

theorem odd_iterate (F : X → X) (hF : ∀ x, F (F x) = x) (k : ℕ) (x : X) :
    iterate F (2*k+1) x = F x := by
  calc
    iterate F (2*k+1) x = F (iterate F (2*k) x) := rfl
    _ = F x := congrArg F (even_iterate F hF k x)

theorem odd_count [Fintype X] (F : X → X) (hF : ∀ x, F (F x) = x)
    (hfree : ∀ x, F x ≠ x) (k : ℕ) : fixedPointCount F (2*k+1) = 0 := by
  have he : fixedPoints F (2*k+1) = ∅ := by
    apply Finset.eq_empty_iff_forall_notMem.mpr
    intro x hx
    have hf := (mem_fixedPoints F _ x).1 hx
    rw [odd_iterate F hF] at hf
    exact hfree x hf
  unfold fixedPointCount
  rw [he, Finset.card_empty]

theorem even_count [Fintype X] (F : X → X) (hF : ∀ x, F (F x) = x)
    (k : ℕ) : fixedPointCount F (2*k+2) = Fintype.card X := by
  have hf : fixedPoints F (2*k+2) = Finset.univ := by
    apply Finset.eq_univ_of_forall
    intro x
    apply (mem_fixedPoints F _ x).2
    have he : 2*k+2 = 2*(k+1) := by omega
    rw [he, even_iterate F hF]
  calc
    fixedPointCount F (2*k+2) = (fixedPoints F (2*k+2)).card := rfl
    _ = (Finset.univ : Finset X).card := congrArg Finset.card hf
    _ = Fintype.card X := Finset.card_univ

theorem involution_domain [Fintype X] [Nonempty X] (F : X → X)
    (hF : ∀ x, F (F x) = x) (hfree : ∀ x, F x ≠ x) (n : ℕ) :
    n ∈ positiveDomain (fixedPointCount F) ↔ ∃ m : ℕ, 1 ≤ m ∧ n = 2*m := by
  constructor
  · intro hn
    have hr := Nat.mod_lt n (by decide : 0 < 2)
    have hd := Nat.div_add_mod n 2
    rcases (show n % 2 = 0 ∨ n % 2 = 1 by omega) with h | h
    · refine ⟨n/2, ?_, by omega⟩
      have hp := hn.1
      omega
    · have he : n = 2*(n/2)+1 := by omega
      have hp := hn.2
      rw [he, odd_count F hF hfree] at hp
      omega
  · rintro ⟨m, hm, rfl⟩
    refine ⟨by omega, ?_⟩
    have he : 2*m = 2*(m-1)+2 := by omega
    rw [he, even_count F hF]
    exact Fintype.card_pos

namespace Derivation

open CellularAutomata.PositiveFixedPointCountDomain

variable [Fintype X] (F : X → X)

theorem bounds (n : ℕ) :
    0 ≤ fixedPointCount F n ∧ fixedPointCount F n ≤ Fintype.card X := by
  have h := count_bounds (fixedPoints F n) Finset.univ (Finset.subset_univ _)
  rw [Finset.card_univ] at h
  exact h

theorem domain (n : ℕ) (hn : 1 ≤ n) :
    n ∈ CellularAutomata.PositiveFixedPointCountDomain.positiveDomain F ↔
      ∃ d ∈ realizedLengths F, ∃ k : ℕ, 1 ≤ k ∧ n = k*d := by
  apply domain_iff_period_divides (fixedPoints F) (minPreperiod F) (minPeriod F)
    (IsPeriodicPoint F) (realizedLengths F)
  · exact mem_fixedPoints_iff_minPeriod_dvd F
  · exact isPeriodicPoint_iff_minPreperiod_zero F
  · exact mem_realizedLengths F
  · exact hn

theorem small_witness : Nonempty X ↔ ∃ p,
    p ∈ CellularAutomata.PositiveFixedPointCountDomain.positiveDomain F ∧ p ≤ Fintype.card X := by
  apply nonempty_iff_small_witness

theorem finite_table :
    lengthsFromData (Finset.univ : Finset X) (minPreperiod F) (minPeriod F) = realizedLengths F := by
  classical
  ext d
  rw [mem_lengthsFromData, mem_realizedLengths]
  simp only [Finset.mem_univ, true_and]
  constructor
  · rintro ⟨x, hm, hp⟩
    exact ⟨x, (isPeriodicPoint_iff_minPreperiod_zero F x).2 hm, hp⟩
  · rintro ⟨x, hp, he⟩
    exact ⟨x, (isPeriodicPoint_iff_minPreperiod_zero F x).1 hp, he⟩

theorem period_bounds : realizedLengths F ⊆ Finset.Icc 1 (Fintype.card X) := by
  rw [← finite_table F]
  apply lengths_bound
  intro x _ _
  have hp := minPreperiod_add_minPeriod_le F x
  exact ⟨one_le_minPeriod F x, by omega⟩

theorem remainder (n : ℕ) (hn : 1 ≤ n) :
    n ∈ CellularAutomata.PositiveFixedPointCountDomain.positiveDomain F ↔
      ∃ d ∈ realizedLengths F, n % d = 0 := by
  rw [domain F n hn]
  exact remainder_iff (realizedLengths F) n hn

theorem zero (n : ℕ) (hn : 1 ≤ n) :
    fixedPointCount F n = 0 ↔
      ¬ ∃ d ∈ realizedLengths F, ∃ k : ℕ, 1 ≤ k ∧ n = k*d := by
  rw [← domain F n hn]
  exact zero_iff (fixedPointCount F) n hn

theorem data_table (mu pi : X → ℕ)
    (hmu : ∀ x, mu x = minPreperiod F x) (hpi : ∀ x, pi x = minPeriod F x) :
    CellularAutomata.PositiveFixedPointCountDomain.lengthsFromPeriodData mu pi =
      realizedLengths F := by
  have hm : mu = minPreperiod F := funext hmu
  have hp : pi = minPeriod F := funext hpi
  rw [hm, hp]
  exact finite_table F

theorem decision (table : Finset ℕ) (ht : table = realizedLengths F) (n : ℕ) :
    CellularAutomata.PositiveFixedPointCountDomain.decideFromTable table n = true ↔
      n ∈ CellularAutomata.PositiveFixedPointCountDomain.positiveDomain F := by
  subst table
  apply decision_correct
  intro j hj
  exact remainder F j hj

theorem rational (n : CellularAutomata.PositiveFixedPointCountDomain.positiveDomain F) :
    CellularAutomata.PositiveFixedPointCountDomain.rationalInput F n =
      rationalInput (fixedPointCount F) n := by
  apply Subtype.ext
  rfl

end Derivation

namespace BinaryDerivation

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V) (f : (v : V) → (↥(N v) → State) → State)

theorem bounds (n : ℕ) :
    0 ≤ fixedPointCount (globalMap N f) n ∧
      fixedPointCount (globalMap N f) n ≤ 2 ^ Fintype.card V := by
  have h := Derivation.bounds (globalMap N f) n
  rw [CellularAutomata.GlobalMapIteration.card_config] at h
  exact h

theorem small_witness : ∃ p,
    p ∈ CellularAutomata.PositiveFixedPointCountDomain.positiveDomain (globalMap N f) ∧
      p ≤ 2 ^ Fintype.card V := by
  have hx : Nonempty (V → State) := ⟨fun _ => State.zero⟩
  obtain ⟨p, hp, hb⟩ := (Derivation.small_witness (globalMap N f)).1 hx
  rw [CellularAutomata.GlobalMapIteration.card_config] at hb
  exact ⟨p, hp, hb⟩

end BinaryDerivation

namespace FlipDerivation

open CellularAutomata.EssentialDependency
open CellularAutomata.BinaryCAPositiveCountDomain

/-- 二回で戻ることは局所真理値表の具体計算から渡す。 -/
theorem involutive : ∀ x, singleMap (singleMap x) = x := by
  intro x
  rw [config_exhaustive x]
  exact twice (x ())

theorem free : ∀ x, singleMap x ≠ x := by
  intro x h
  rw [config_exhaustive x, single_step] at h
  have hv := congrFun h ()
  cases hx : x () <;> simp [config, hx, nu] at hv

theorem odd (k : ℕ) : fixedPointCount singleMap (2*k+1) = 0 := by
  apply odd_count singleMap involutive free

theorem even (k : ℕ) : fixedPointCount singleMap (2*k+2) = 2 := by
  rw [even_count singleMap involutive]
  rw [CellularAutomata.GlobalMapIteration.card_config]
  simp

theorem domain (n : ℕ) :
    n ∈ CellularAutomata.PositiveFixedPointCountDomain.positiveDomain singleMap ↔
      ∃ m : ℕ, 1 ≤ m ∧ n = 2*m := by
  letI : Nonempty (Unit → State) := ⟨config State.zero⟩
  apply involution_domain singleMap involutive free

theorem one_excluded :
    1 ∉ CellularAutomata.PositiveFixedPointCountDomain.positiveDomain singleMap := by
  rw [domain]
  rintro ⟨m, hm, he⟩
  omega

end FlipDerivation
end CellularAutomata.NecSuf.PositiveFixedPointCountDomain
