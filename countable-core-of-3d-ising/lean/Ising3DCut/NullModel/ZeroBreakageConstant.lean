/-
人手証明の主張「破れ数ゼロの配位は全上と全下の二つに限る」
（ラベル `claim_zero_breakage_multiplicity_is_two`）の具体版の第一部。

人手証明の段との対応:

  m_L(σ) = 0 ⇔ D_L(σ) = ∅ ⇔ すべての辺で両端点の値が等しい   `brokenCount_eq_zero_iff`
  第一段。座標和 s(a) についての帰納法で σ(a) = σ(o) を示す   `eq_zeroSite_value_of_brokenCount_zero`

第二段（定値配位の破れ数が 0 であること）は既に
`Ising3DCut.NullModel.PartitionSupportEndpoints` の `brokenCount_constConfig` にある。
第三段。原点での値への単射と既存の二つの定値配位を束ねる   `multiplicity_zero_eq_two`

住処: `Fin`、`Nat`、整数 ±1、有限集合のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.PartitionSupportEndpoints

namespace Ising3DCut.NullModel

/-- 破れ数が `0` であることと、すべての辺で両端点の値が等しいことは同値である。 -/
theorem brokenCount_eq_zero_iff {L : ℕ} (σ : Config L) :
    brokenCount σ = 0 ↔ ∀ e : Edge L, σ (endpoint0 e) = σ (endpoint1 e) := by
  constructor
  · intro h e
    have hempty : brokenSet σ = ∅ := Finset.card_eq_zero.mp h
    by_contra hne
    have hmem : e ∈ brokenSet σ := by simp [brokenSet, hne]
    rw [hempty] at hmem
    simp at hmem
  · intro h
    have hempty : brokenSet σ = ∅ := by
      ext e
      simp [brokenSet, h e]
    rw [brokenCount, hempty, Finset.card_empty]

/-- 第一段。破れ数 `0` の配位は、箱のすべての点で原点と同じ値をとる。
座標和 `coordSum` についての強い帰納法による。 -/
theorem eq_zeroSite_value_of_brokenCount_zero
    {L : ℕ} (hL : 0 < L) (σ : Config L) (h : brokenCount σ = 0) (a : Site L) :
    σ a = σ (zeroSite hL) := by
  have hedge := (brokenCount_eq_zero_iff σ).mp h
  induction hs : coordSum a using Nat.strong_induction_on generalizing a with
  | _ n ih =>
    subst hs
    by_cases hzero : ∀ i, a.1 i = 0
    · have : a = zeroSite hL := Subtype.ext (funext fun i => hzero i)
      rw [this]
    · -- 和が正なので、ある方向の座標が 1 以上である
      push_neg at hzero
      obtain ⟨i, hi⟩ := hzero
      have hipos : 0 < a.1 i := Nat.pos_of_ne_zero hi
      -- a' = a − ε_i（第 i 成分だけを 1 減らした点）
      have hbound : ∀ j, Function.update a.1 i (a.1 i - 1) j < L := by
        intro j
        by_cases hj : j = i
        · subst hj
          simp only [Function.update_self]
          exact lt_of_le_of_lt (Nat.sub_le _ _) (a.2 j)
        · rw [Function.update_of_ne hj]
          exact a.2 j
      let a' : Site L := ⟨Function.update a.1 i (a.1 i - 1), hbound⟩
      have ha'i : a'.1 i = a.1 i - 1 := Function.update_self _ _ _
      have hai := a.2 i
      have hnext : a'.1 i + 1 < L := by
        rw [ha'i]; omega
      -- a' と a を結ぶ辺
      let e : Edge L := ⟨a', i, hnext⟩
      have hend1 : endpoint1 e = a := by
        apply Subtype.ext
        funext j
        by_cases hj : j = i
        · subst hj
          show Function.update a'.1 j (a'.1 j + 1) j = a.1 j
          rw [Function.update_self, ha'i]
          omega
        · show Function.update a'.1 i (a'.1 i + 1) j = a.1 j
          rw [Function.update_of_ne hj]
          show Function.update a.1 i (a.1 i - 1) j = a.1 j
          rw [Function.update_of_ne hj]
      have hstep : σ a' = σ a := by
        have := hedge e
        rw [hend1] at this
        exact this
      -- 座標和は 1 だけ小さい
      have hsum : coordSum a' + 1 = coordSum a := by
        have h0 : a'.1 0 = if (0 : Fin 3) = i then a.1 0 - 1 else a.1 0 := by
          by_cases hj : (0 : Fin 3) = i
          · subst hj; simp [a', Function.update_self]
          · simp [a', Function.update_of_ne hj, hj]
        have h1 : a'.1 1 = if (1 : Fin 3) = i then a.1 1 - 1 else a.1 1 := by
          by_cases hj : (1 : Fin 3) = i
          · subst hj; simp [a', Function.update_self]
          · simp [a', Function.update_of_ne hj, hj]
        have h2 : a'.1 2 = if (2 : Fin 3) = i then a.1 2 - 1 else a.1 2 := by
          by_cases hj : (2 : Fin 3) = i
          · subst hj; simp [a', Function.update_self]
          · simp [a', Function.update_of_ne hj, hj]
        have hi3 : i = 0 ∨ i = 1 ∨ i = 2 := by omega
        unfold coordSum
        rcases hi3 with h | h | h <;> subst h <;>
          simp_all <;> omega
      have hlt : coordSum a' < coordSum a := by omega
      rw [← hstep]
      exact ih (coordSum a') hlt a' rfl

/-- 第三段。破れ数 `0` の配位は、原点での値によって一意に決まり、
二つの定値配位が実在するので、多重度はちょうど `2` である。 -/
theorem multiplicity_zero_eq_two {L : ℕ} (hL : 0 < L) :
    multiplicity L 0 = 2 := by
  let valueAtOrigin : LevelSet L 0 → Spin := fun σ => σ.1 (zeroSite hL)
  have hinjective : Function.Injective valueAtOrigin := by
    intro σ τ hvalue
    apply Subtype.ext
    funext a
    have hσzero : brokenCount σ.1 = 0 := by
      exact (Finset.mem_filter.mp σ.2).2
    have hτzero : brokenCount τ.1 = 0 := by
      exact (Finset.mem_filter.mp τ.2).2
    rw [eq_zeroSite_value_of_brokenCount_zero hL σ.1 hσzero a,
      eq_zeroSite_value_of_brokenCount_zero hL τ.1 hτzero a]
    exact hvalue
  have hupper : multiplicity L 0 ≤ Fintype.card Spin := by
    simpa [multiplicity] using Fintype.card_le_of_injective valueAtOrigin hinjective
  let spinEquivBool : Spin ≃ Bool := {
    toFun z := if z.1 = 1 then true else false
    invFun b := if b then ⟨1, Or.inl rfl⟩ else ⟨-1, Or.inr rfl⟩
    left_inv z := by
      apply Subtype.ext
      rcases z.2 with hz | hz <;> simp [hz]
    right_inv b := by cases b <;> simp }
  have hspin : Fintype.card Spin = 2 := by
    rw [Fintype.card_congr spinEquivBool]
    rfl
  have hlower := two_le_multiplicity_zero hL
  omega
