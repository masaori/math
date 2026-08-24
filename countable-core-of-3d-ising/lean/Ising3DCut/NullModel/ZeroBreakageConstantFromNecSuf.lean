/-
具体版の第三段が必要十分版の特殊化として得られることの明示。

有限型を破れ数 `0` の水準集合、写された先を `Spin`、単射を「原点での値をとる写像」に取る。
単射性は具体版で示した定値性定理から、下界は既存の全上・全下の二配位から与える。

必要十分版の `Fintype.card` と具体版の `multiplicity L 0` が数える集合は
定義がそのまま一致するので、元の個数もそのまま一致する。

住処: `Fin`、`Nat`、整数 ±1、有限型のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.ZeroBreakageConstant
import Ising3DCut.NecSuf.NullModel.ZeroBreakageConstant

namespace Ising3DCut.NullModel

/-- `claim_zero_breakage_multiplicity_is_two` の第一段を、座標和と一段の前任点だけを
残した必要十分版から導いたもの。 -/
theorem eq_zeroSite_value_of_brokenCount_zero_from_necSuf
    {L : ℕ} (hL : 0 < L) (σ : Config L) (h : brokenCount σ = 0) (a : Site L) :
    σ a = σ (zeroSite hL) := by
  have hedge := (brokenCount_eq_zero_iff σ).mp h
  apply NecSuf.NullModel.value_eq_root_of_rank_predecessor
    coordSum (zeroSite hL) σ
  · intro b hb
    apply Subtype.ext
    funext i
    have hi3 : i = 0 ∨ i = 1 ∨ i = 2 := by omega
    unfold coordSum at hb
    rcases hi3 with hi | hi | hi <;> subst hi <;> simp [zeroSite] <;> omega
  · intro b hb
    have hnonzero : ¬ ∀ i, b.1 i = 0 := by
      intro hzero
      have : coordSum b = 0 := by simp [coordSum, hzero]
      omega
    push_neg at hnonzero
    obtain ⟨i, hi⟩ := hnonzero
    have hipos : 0 < b.1 i := Nat.pos_of_ne_zero hi
    have hbound : ∀ j, Function.update b.1 i (b.1 i - 1) j < L := by
      intro j
      by_cases hj : j = i
      · subst hj
        simp only [Function.update_self]
        exact lt_of_le_of_lt (Nat.sub_le _ _) (b.2 j)
      · rw [Function.update_of_ne hj]
        exact b.2 j
    let b' : Site L := ⟨Function.update b.1 i (b.1 i - 1), hbound⟩
    have hb'i : b'.1 i = b.1 i - 1 := Function.update_self _ _ _
    have hbi := b.2 i
    have hnext : b'.1 i + 1 < L := by
      rw [hb'i]
      omega
    let e : Edge L := ⟨b', i, hnext⟩
    have hend1 : endpoint1 e = b := by
      apply Subtype.ext
      funext j
      by_cases hj : j = i
      · subst hj
        show Function.update b'.1 j (b'.1 j + 1) j = b.1 j
        rw [Function.update_self, hb'i]
        omega
      · show Function.update b'.1 i (b'.1 i + 1) j = b.1 j
        rw [Function.update_of_ne hj]
        show Function.update b.1 i (b.1 i - 1) j = b.1 j
        rw [Function.update_of_ne hj]
    have hvalue : σ b' = σ b := by
      have heq := hedge e
      rw [hend1] at heq
      exact heq
    have hsum : coordSum b' + 1 = coordSum b := by
      have h0 : b'.1 0 = if (0 : Fin 3) = i then b.1 0 - 1 else b.1 0 := by
        by_cases hj : (0 : Fin 3) = i
        · subst hj; simp [b', Function.update_self]
        · simp [b', Function.update_of_ne hj, hj]
      have h1 : b'.1 1 = if (1 : Fin 3) = i then b.1 1 - 1 else b.1 1 := by
        by_cases hj : (1 : Fin 3) = i
        · subst hj; simp [b', Function.update_self]
        · simp [b', Function.update_of_ne hj, hj]
      have h2 : b'.1 2 = if (2 : Fin 3) = i then b.1 2 - 1 else b.1 2 := by
        by_cases hj : (2 : Fin 3) = i
        · subst hj; simp [b', Function.update_self]
        · simp [b', Function.update_of_ne hj, hj]
      have hi3 : i = 0 ∨ i = 1 ∨ i = 2 := by omega
      unfold coordSum
      rcases hi3 with hi | hi | hi <;> subst hi <;> simp_all <;> omega
    exact ⟨b', by omega, hvalue⟩

/-- `claim_zero_breakage_multiplicity_is_two` の第三段を必要十分版から導いたもの。 -/
theorem multiplicity_zero_eq_two_from_necSuf {L : ℕ} (hL : 0 < L) :
    multiplicity L 0 = 2 := by
  let valueAtOrigin : LevelSet L 0 → Spin := fun σ => σ.1 (zeroSite hL)
  have hinjective : Function.Injective valueAtOrigin := by
    intro σ τ hvalue
    apply Subtype.ext
    funext a
    have hσzero : brokenCount σ.1 = 0 := (Finset.mem_filter.mp σ.2).2
    have hτzero : brokenCount τ.1 = 0 := (Finset.mem_filter.mp τ.2).2
    rw [eq_zeroSite_value_of_brokenCount_zero_from_necSuf hL σ.1 hσzero a,
      eq_zeroSite_value_of_brokenCount_zero_from_necSuf hL τ.1 hτzero a]
    exact hvalue
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
  exact NecSuf.NullModel.card_eq_of_injective_of_le
    valueAtOrigin hinjective 2 hspin (two_le_multiplicity_zero hL)

end Ising3DCut.NullModel
