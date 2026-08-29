/-
章「大域写像の可逆性の有限決定」の具体版。
人手証明の正本は structured-latex/content/reversibility-finite-decidability.ts。

前章までの大域写像 F・反復 F^n・最小前周期 μ(y)・最小周期 π(y)・周期点を受けて、人手証明と同じ
対象・仮定・順序で、像 Im(F)・単射・全射の定義、「単射 ⟺ 全射」（有限集合の元の個数の数え上げ）、
「単射 ⟺ 全ての配位で μ(y) = 0」（最小前周期の最小性と反復の帰納的定義）、
単射性が全対の走査（|A^V|^2 = 2^{2|V|} 個の対）または全配位の最小前周期の走査（2^{|V|} 個）で
決まることを形式化する。
ℕ について使うのは加法・減法・大小比較・等号だけで、R / C は使わない。
「可逆」「時間反転」「情報保存」の名前は使わず、写像の単射・全射としてだけ定義する。
等号検査回数のコストモデル自体は形式化していない（前章までと同じ）。

数え上げで使う既製の事実は人手証明が根拠として名指しした初等的なものだけである:
  有限集合の部分集合の元の個数は全体以下（`Finset.card_le_card`）、
  元の個数が等しい部分集合は全体に一致（`Finset.eq_of_subset_of_card_le`）、
  単射な写像による像の元の個数は始域と等しい（`Finset.card_image_of_injective`）、
  写像による像の元の個数は始域以下（`Finset.card_image_le`）、
  有限集合から元を 1 個除いた集合の元の個数（`Finset.card_erase_of_mem`）。

対応表（人手証明 → この file）
  def_finite_self_map_injective_surjective              `image`, `mem_image`, `Injective`, `Surjective`
  claim_finite_self_map_injective_iff_surjective        `card_image_le_card_univ`, `image_eq_univ_iff_card`,
                                                   `card_image_of_injective_eq`, `image_eq_image_erase`,
                                                   `injective_iff_surjective`
  claim_finite_self_map_injective_iff_all_periodic      `minPreperiod_eq_zero_of_injective`,
                                                   `surjective_of_forall_minPreperiod_zero`,
                                                   `injective_iff_forall_minPreperiod_zero`,
                                                   `injective_iff_forall_isPeriodicPoint`
  claim_finite_self_map_injectivity_finite_decidability `injective_iff_forall_pairs`, `card_config_pairs`,
                                                   `instance : Decidable (Injective N f)`,
                                                   `injective_iff_forall_config_minPreperiod_zero`,
                                                   `card_univ_config`（前章）
必要十分版（NecSuf.ReversibilityFiniteDecidability）からの導出は末尾の節にある。
-/
import CellularAutomata.PeriodicPointCount
import CellularAutomata.NecSuf.ReversibilityFiniteDecidability

namespace CellularAutomata.ReversibilityFiniteDecidability

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.MinimalPreperiodPeriod
open CellularAutomata.PeriodicPointCount

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 像 Im(F) := { F y : y ∈ A^V }（`def_finite_self_map_injective_surjective`）。 -/
def image : Finset (V → State) := Finset.univ.image (globalMap N f)

theorem mem_image (z : V → State) : z ∈ image N f ↔ ∃ y : V → State, globalMap N f y = z := by
  simp [image]

omit [Fintype V] [DecidableEq V] in
/-- F が単射（`def_finite_self_map_injective_surjective`）: ∀ y y', F y = F y' → y = y'。 -/
def Injective : Prop := ∀ y y' : V → State, globalMap N f y = globalMap N f y' → y = y'

/-- F が全射（`def_finite_self_map_injective_surjective`）: Im(F) = A^V。 -/
def Surjective : Prop := image N f = Finset.univ

/-- 前段: |Im(F)| ≤ |A^V|（Im(F) ⊆ A^V）。 -/
theorem card_image_le_card_univ : (image N f).card ≤ (Finset.univ : Finset (V → State)).card :=
  Finset.card_le_card (Finset.subset_univ _)

/-- 前段: |Im(F)| = |A^V| ⟺ Im(F) = A^V。 -/
theorem image_eq_univ_iff_card :
    image N f = Finset.univ ↔ (image N f).card = (Finset.univ : Finset (V → State)).card := by
  constructor
  · intro h; rw [h]
  · intro h
    exact Finset.eq_of_subset_of_card_le (Finset.subset_univ _) (le_of_eq h.symm)

/-- （⇒ の中間段）F が単射なら |Im(F)| = |A^V|（有限集合の間の全単射）。 -/
theorem card_image_of_injective_eq (hinj : Injective N f) :
    (image N f).card = (Finset.univ : Finset (V → State)).card :=
  Finset.card_image_of_injective _ (fun y y' h => hinj y y' h)

/-- （⇐ の中間段）y₀ ≠ y₁、F y₀ = F y₁ のとき、B := A^V ∖ {y₁} について Im(F) = { F y : y ∈ B }。 -/
theorem image_eq_image_erase {y₀ y₁ : V → State} (hne : y₀ ≠ y₁)
    (heq : globalMap N f y₀ = globalMap N f y₁) :
    image N f = (Finset.univ.erase y₁).image (globalMap N f) := by
  apply Finset.Subset.antisymm
  · intro z hz
    obtain ⟨y, hy⟩ := (mem_image N f z).1 hz
    rw [Finset.mem_image]
    by_cases hy1 : y = y₁
    · -- y = y₁ なら y₀ ∈ B かつ F y = F y₁ = F y₀。
      refine ⟨y₀, ?_, ?_⟩
      · exact Finset.mem_erase.2 ⟨hne, Finset.mem_univ _⟩
      · rw [heq, ← hy1, hy]
    · -- y ≠ y₁ なら y ∈ B かつ F y = F y。
      exact ⟨y, Finset.mem_erase.2 ⟨hy1, Finset.mem_univ _⟩, hy⟩
  · -- ⊇ は B ⊆ A^V から。
    exact Finset.image_subset_image (Finset.subset_univ _)

/-- 有限舞台上では単射性と全射性は同値（`claim_finite_self_map_injective_iff_surjective`）。 -/
theorem injective_iff_surjective : Injective N f ↔ Surjective N f := by
  constructor
  · -- (⇒) |Im(F)| = |A^V| から前段により Im(F) = A^V。
    intro hinj
    exact (image_eq_univ_iff_card N f).2 (card_image_of_injective_eq N f hinj)
  · -- (⇐) 全射とし、単射でないと仮定して矛盾を導く。
    intro hsurj
    by_contra hnot
    -- 単射の定義の否定: y₀ ≠ y₁ かつ F y₀ = F y₁。
    have hex : ∃ y₀ y₁ : V → State, globalMap N f y₀ = globalMap N f y₁ ∧ y₀ ≠ y₁ := by
      by_contra hno
      apply hnot
      intro y y' h
      by_contra hne
      exact hno ⟨y, y', h, hne⟩
    obtain ⟨y₀, y₁, heq, hne⟩ := hex
    -- |B| = |A^V| - 1。
    have hB : (Finset.univ.erase y₁).card = (Finset.univ : Finset (V → State)).card - 1 :=
      Finset.card_erase_of_mem (Finset.mem_univ _)
    -- Im(F) = { F y : y ∈ B } なので |Im(F)| ≤ |B|（有限集合からの全射の終域は始域以下）。
    have hle : (image N f).card ≤ (Finset.univ.erase y₁).card := by
      rw [image_eq_image_erase N f hne heq]
      exact Finset.card_image_le
    -- 全射性により |Im(F)| = |A^V|。
    have hcard : (image N f).card = (Finset.univ : Finset (V → State)).card :=
      (image_eq_univ_iff_card N f).1 hsurj
    -- |A^V| ≥ 1（y₁ ∈ A^V）。
    have hpos : 1 ≤ (Finset.univ : Finset (V → State)).card :=
      Finset.card_pos.2 ⟨y₁, Finset.mem_univ _⟩
    -- |A^V| ≤ |A^V| - 1 < |A^V|、ℕ の大小関係の非反射性に矛盾。
    omega

/-- （⇒）F が単射なら全ての配位で μ(y) = 0（`claim_finite_self_map_injective_iff_all_periodic`）。 -/
theorem minPreperiod_eq_zero_of_injective (hinj : Injective N f) (y : V → State) :
    minPreperiod N f y = 0 := by
  by_contra hne
  -- μ(y) ≥ 1 と仮定する。
  have hμ1 : 1 ≤ minPreperiod N f y := by omega
  -- (μ(y), π(y)) ∈ P(y)、π(y) ≥ 1、F^{μ(y)+π(y)} y = F^{μ(y)} y。
  have hcol := (isPeriodicityPair_iff_collision N f y _ _).1 (minPeriod_spec N f y)
  obtain ⟨hπ1, hcoll⟩ := hcol
  -- m := μ(y) - 1、μ(y) = m + 1。
  set m := minPreperiod N f y - 1 with hm
  have hμm : minPreperiod N f y = m + 1 := by omega
  -- μ(y) + π(y) = (m + π(y)) + 1。
  have hsum : minPreperiod N f y + minPeriod N f y = (m + minPeriod N f y) + 1 := by omega
  -- F^{(m+π(y))+1} y = F (F^{m+π(y)} y)、F^{m+1} y = F (F^m y)。
  rw [hsum, hμm, iterate_succ, iterate_succ] at hcoll
  -- F の単射性により F^{m+π(y)} y = F^m y。
  have hcoll' : iterate N f (m + minPeriod N f y) y = iterate N f m y := hinj _ _ hcoll
  -- (m, π(y)) ∈ P(y)、よって m ∈ I(y)。
  have hpair : IsPeriodicityPair N f y m (minPeriod N f y) :=
    (isPeriodicityPair_iff_collision N f y m _).2 ⟨hπ1, hcoll'⟩
  -- 最小性により μ(y) ≤ m = μ(y) - 1、矛盾。
  have hle : minPreperiod N f y ≤ m := minPreperiod_le N f y ⟨_, hpair⟩
  omega

/-- （⇐）全ての配位で μ(y) = 0 なら F は全射（`claim_finite_self_map_injective_iff_all_periodic`）。 -/
theorem surjective_of_forall_minPreperiod_zero (h : ∀ y : V → State, minPreperiod N f y = 0) :
    Surjective N f := by
  unfold Surjective
  apply Finset.Subset.antisymm (Finset.subset_univ _)
  intro y _
  -- μ(y) = 0 なので y ∈ Per(F)、すなわち n ≥ 1、F^n y = y。
  obtain ⟨n, hn, hFn⟩ := (isPeriodicPoint_iff_minPreperiod_zero N f y).2 (h y)
  -- k := n - 1、n = k + 1、F^{k+1} y = F (F^k y)。
  set k := n - 1 with hk
  have hnk : n = k + 1 := by omega
  rw [hnk, iterate_succ] at hFn
  -- z := F^k y が y = F z を満たす。
  exact (mem_image N f y).2 ⟨iterate N f k y, hFn⟩

/-- 単射性は全ての配位の最小前周期が 0 であることと同値（`claim_finite_self_map_injective_iff_all_periodic`）。 -/
theorem injective_iff_forall_minPreperiod_zero :
    Injective N f ↔ ∀ y : V → State, minPreperiod N f y = 0 := by
  constructor
  · exact minPreperiod_eq_zero_of_injective N f
  · intro h
    exact (injective_iff_surjective N f).2 (surjective_of_forall_minPreperiod_zero N f h)

/-- 言い換え: 単射 ⟺ Per(F) = A^V（`claim_periodic_iff_min_preperiod_zero` による）。 -/
theorem injective_iff_forall_isPeriodicPoint :
    Injective N f ↔ ∀ y : V → State, IsPeriodicPoint N f y := by
  rw [injective_iff_forall_minPreperiod_zero]
  constructor
  · intro h y; exact (isPeriodicPoint_iff_minPreperiod_zero N f y).2 (h y)
  · intro h y; exact (isPeriodicPoint_iff_minPreperiod_zero N f y).1 (h y)

/-! ## 有限決定（`claim_finite_self_map_injectivity_finite_decidability`） -/

/-- （像の走査）単射性は A^V × A^V 上の全称文であり、走査する対の有限集合で言い換えられる。 -/
theorem injective_iff_forall_pairs :
    Injective N f ↔
      ∀ q ∈ (Finset.univ : Finset (V → State)) ×ˢ (Finset.univ : Finset (V → State)),
        globalMap N f q.1 = globalMap N f q.2 → q.1 = q.2 := by
  constructor
  · intro h q _; exact h q.1 q.2
  · intro h y y' hyy'
    exact h (y, y') (Finset.mem_product.2 ⟨Finset.mem_univ _, Finset.mem_univ _⟩) hyy'

/-- 走査する対の総数は |A^V|^2 = 2^{2|V|}。 -/
theorem card_config_pairs :
    ((Finset.univ : Finset (V → State)) ×ˢ (Finset.univ : Finset (V → State))).card =
      2 ^ (2 * Fintype.card V) := by
  rw [Finset.card_product, card_univ_config, ← pow_add, ← two_mul]

/-- 単射性は決定可能（有限個の対それぞれについて 2 回の配位の等号検査で決まる含意の連言）。 -/
instance : Decidable (Injective N f) :=
  decidable_of_iff _ (injective_iff_forall_pairs N f).symm

/-- （最小前周期の走査）単射性は 2^{|V|} 個の配位それぞれの μ(y) = 0 の連言である。 -/
theorem injective_iff_forall_config_minPreperiod_zero :
    Injective N f ↔
      ∀ y ∈ (Finset.univ : Finset (V → State)), minPreperiod N f y = 0 := by
  rw [injective_iff_forall_minPreperiod_zero]
  constructor
  · intro h y _; exact h y
  · intro h y; exact h y (Finset.mem_univ _)

/-! ## 必要十分版からの導出 -/

theorem image_eq_necessary_sufficient :
    image N f =
      CellularAutomata.NecSuf.ReversibilityFiniteDecidability.image (globalMap N f) := by
  classical
  ext z
  simp only [mem_image, CellularAutomata.NecSuf.ReversibilityFiniteDecidability.mem_image]

omit [Fintype V] [DecidableEq V] in
theorem injective_iff_necessary_sufficient :
    Injective N f ↔
      CellularAutomata.NecSuf.ReversibilityFiniteDecidability.Injective (globalMap N f) :=
  Iff.rfl

theorem surjective_iff_necessary_sufficient :
    Surjective N f ↔
      CellularAutomata.NecSuf.ReversibilityFiniteDecidability.Surjective (globalMap N f) := by
  unfold Surjective CellularAutomata.NecSuf.ReversibilityFiniteDecidability.Surjective
  rw [image_eq_necessary_sufficient N f]

theorem injective_iff_surjective_from_necessary_sufficient :
    Injective N f ↔ Surjective N f := by
  rw [injective_iff_necessary_sufficient N f, surjective_iff_necessary_sufficient N f]
  exact CellularAutomata.NecSuf.ReversibilityFiniteDecidability.injective_iff_surjective
    (globalMap N f)

theorem injective_iff_forall_minPreperiod_zero_from_necessary_sufficient :
    Injective N f ↔ ∀ y : V → State, minPreperiod N f y = 0 := by
  rw [injective_iff_necessary_sufficient N f,
    CellularAutomata.NecSuf.ReversibilityFiniteDecidability.injective_iff_forall_minPreperiod_zero]
  simp only [CellularAutomata.MinimalPreperiodPeriod.minPreperiod_eq_necessary_sufficient]

theorem injective_iff_forall_isPeriodicPoint_from_necessary_sufficient :
    Injective N f ↔ ∀ y : V → State, IsPeriodicPoint N f y := by
  rw [injective_iff_necessary_sufficient N f,
    CellularAutomata.NecSuf.ReversibilityFiniteDecidability.injective_iff_forall_isPeriodicPoint]
  simp only [CellularAutomata.PeriodicPointCount.isPeriodicPoint_iff_necessary_sufficient]

theorem injective_iff_forall_pairs_from_necessary_sufficient :
    Injective N f ↔
      ∀ q ∈ (Finset.univ : Finset (V → State)) ×ˢ (Finset.univ : Finset (V → State)),
        globalMap N f q.1 = globalMap N f q.2 → q.1 = q.2 :=
  CellularAutomata.NecSuf.ReversibilityFiniteDecidability.injective_iff_forall_pairs
    (globalMap N f)

/-- 具体版の対数 2^{2|V|} は、必要十分版の |X|^2 に |A^V| = 2^{|V|} を代入した特殊化である。 -/
theorem card_config_pairs_from_necessary_sufficient :
    ((Finset.univ : Finset (V → State)) ×ˢ (Finset.univ : Finset (V → State))).card =
      2 ^ (2 * Fintype.card V) := by
  rw [CellularAutomata.NecSuf.ReversibilityFiniteDecidability.card_pairs, card_config,
    ← pow_mul, Nat.mul_comm]

theorem injective_iff_forall_config_minPreperiod_zero_from_necessary_sufficient :
    Injective N f ↔
      ∀ y ∈ (Finset.univ : Finset (V → State)), minPreperiod N f y = 0 := by
  rw [injective_iff_necessary_sufficient N f,
    CellularAutomata.NecSuf.ReversibilityFiniteDecidability.injective_iff_forall_elem_minPreperiod_zero]
  simp only [CellularAutomata.MinimalPreperiodPeriod.minPreperiod_eq_necessary_sufficient]

end CellularAutomata.ReversibilityFiniteDecidability
