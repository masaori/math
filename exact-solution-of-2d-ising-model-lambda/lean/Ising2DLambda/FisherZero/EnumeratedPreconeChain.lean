/-
人手証明の主張「列挙に沿って前錐を一元ずつ大きくした列の和集合は、負の単位元を含まず
符号の両側を覆う前錐である」（ラベル `claim_enumerated_precone_chain_covers_signs`）の具体版。

列 `T_n` は本文の三つの場合分けをそのまま再帰で定める。場合分けは排中律で行い、
所属の判定手続きは主張しない（本文の注意と同じ）。
住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SubfieldPrecone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

open Classical in
/-- 本文の列 `T_n`。`T_0 = T`、`T_{n+1}` は三つの場合分けで定める。 -/
noncomputable def preconeChain (E : Subfield Qbar) (T : Set Qbar) (ξ : ℕ → Qbar) : ℕ → Set Qbar
  | 0 => T
  | n + 1 =>
    if ξ n ∈ E then
      (if (-1 : Qbar) ∈ preconeAdjoin (preconeChain E T ξ n) (ξ n) then
        preconeAdjoin (preconeChain E T ξ n) (-ξ n)
      else preconeAdjoin (preconeChain E T ξ n) (ξ n))
    else preconeChain E T ξ n

/-- 本文の和集合 `T_∞ = {z | ある n について z ∈ T_n}`。 -/
def preconeChainUnion (E : Subfield Qbar) (T : Set Qbar) (ξ : ℕ → Qbar) : Set Qbar :=
  {z | ∃ n : ℕ, z ∈ preconeChain E T ξ n}

/-- 本文の帰納法: 各 `T_n` は前錐で `-1` を含まず、`T_n ⊆ T_{n+1}`。 -/
theorem preconeChain_step (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T) (ξ : ℕ → Qbar) :
    ∀ n : ℕ, IsSubfieldPrecone F E CF (preconeChain E T ξ n) ∧
      (-1 : Qbar) ∉ preconeChain E T ξ n ∧
      (∀ z : Qbar, z ∈ preconeChain E T ξ n → z ∈ preconeChain E T ξ (n + 1)) := by
  -- まず「前錐で -1 を含まない」を n についての帰納法で示す
  have hP : ∀ n : ℕ, IsSubfieldPrecone F E CF (preconeChain E T ξ n) ∧
      (-1 : Qbar) ∉ preconeChain E T ξ n := by
    intro n
    induction n with
    | zero => exact ⟨hT, hneg⟩
    | succ n ih =>
      obtain ⟨hTn, hnegn⟩ := ih
      by_cases hE : ξ n ∈ E
      · by_cases hm : (-1 : Qbar) ∈ preconeAdjoin (preconeChain E T ξ n) (ξ n)
        · -- 第三の場合: T_n⟨-ξ(n)⟩
          have hEneg : -ξ n ∈ E := E.neg_mem hE
          have hside := neg_one_not_mem_preconeAdjoin_or F E CF _ hTn hnegn (ξ n) hE
          have hnot : (-1 : Qbar) ∉ preconeAdjoin (preconeChain E T ξ n) (-ξ n) := by
            rcases hside with h | h
            · exact absurd hm h
            · exact h
          rw [preconeChain, if_pos hE, if_pos hm]
          exact ⟨(preconeAdjoin_isSubfieldPrecone F E CF _ hTn (-ξ n) hEneg).1, hnot⟩
        · -- 第二の場合: T_n⟨ξ(n)⟩
          rw [preconeChain, if_pos hE, if_neg hm]
          exact ⟨(preconeAdjoin_isSubfieldPrecone F E CF _ hTn (ξ n) hE).1, hm⟩
      · -- 第一の場合: T_{n+1} = T_n
        rw [preconeChain, if_neg hE]
        exact ⟨hTn, hnegn⟩
  intro n
  refine ⟨(hP n).1, (hP n).2, ?_⟩
  -- 包含 T_n ⊆ T_{n+1}（三つの場合）
  intro z hz
  have hTn := (hP n).1
  by_cases hE : ξ n ∈ E
  · by_cases hm : (-1 : Qbar) ∈ preconeAdjoin (preconeChain E T ξ n) (ξ n)
    · rw [preconeChain, if_pos hE, if_pos hm]
      exact (preconeAdjoin_isSubfieldPrecone F E CF _ hTn (-ξ n) (E.neg_mem hE)).2.1 z hz
    · rw [preconeChain, if_pos hE, if_neg hm]
      exact (preconeAdjoin_isSubfieldPrecone F E CF _ hTn (ξ n) hE).2.1 z hz
  · rw [preconeChain, if_neg hE]
    exact hz

/-- 本文の列の単調性: `m ≤ n` なら `T_m ⊆ T_n`（`k = n - m` についての帰納法）。 -/
theorem preconeChain_mono (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T) (ξ : ℕ → Qbar)
    (m : ℕ) : ∀ k : ℕ, ∀ z : Qbar, z ∈ preconeChain E T ξ m → z ∈ preconeChain E T ξ (m + k) := by
  intro k
  induction k with
  | zero => intro z hz; exact hz
  | succ k ih =>
    intro z hz
    exact (preconeChain_step F E CF T hT hneg ξ (m + k)).2.2 z (ih z hz)

theorem preconeChain_mono_le (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T) (ξ : ℕ → Qbar)
    (m n : ℕ) (hmn : m ≤ n) (z : Qbar) (hz : z ∈ preconeChain E T ξ m) :
    z ∈ preconeChain E T ξ n := by
  have h := preconeChain_mono F E CF T hT hneg ξ m (n - m) z hz
  rwa [Nat.add_sub_cancel' hmn] at h

/-- `claim_enumerated_precone_chain_covers_signs` の具体版。本文の段
（前錐であること、`-1` を含まないこと、符号の両側を覆うこと）の順に示す。 -/
theorem preconeChainUnion_covers_signs (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T) (ξ : ℕ → Qbar)
    (hξ : Function.Surjective ξ) :
    IsSubfieldPrecone F E CF (preconeChainUnion E T ξ) ∧
      (-1 : Qbar) ∉ preconeChainUnion E T ξ ∧
      (∀ z : Qbar, z ∈ E → z ∈ preconeChainUnion E T ξ ∨ -z ∈ preconeChainUnion E T ξ) := by
  have hstep := preconeChain_step F E CF T hT hneg ξ
  have hmono := preconeChain_mono_le F E CF T hT hneg ξ
  refine ⟨⟨hT.subfield_le, hT.cone_F, ?_, ?_, ?_, ?_, ?_⟩, ?_, ?_⟩
  · -- T_∞ ⊆ E
    rintro z ⟨n, hz⟩
    exact (hstep n).1.subset z hz
  · -- 和の条件（k = max(m, n)）
    rintro a b ⟨m, ha⟩ ⟨n, hb⟩
    refine ⟨max m n, (hstep (max m n)).1.add_mem a b ?_ ?_⟩
    · exact hmono m (max m n) (le_max_left m n) a ha
    · exact hmono n (max m n) (le_max_right m n) b hb
  · -- 積の条件（k = max(m, n)）
    rintro a b ⟨m, ha⟩ ⟨n, hb⟩
    refine ⟨max m n, (hstep (max m n)).1.mul_mem a b ?_ ?_⟩
    · exact hmono m (max m n) (le_max_left m n) a ha
    · exact hmono n (max m n) (le_max_right m n) b hb
  · -- 平方の条件（T_0 から）
    intro y hy
    exact ⟨0, hT.sq_mem y hy⟩
  · -- 正錐の包含（T_0 から）
    intro c hc
    exact ⟨0, hT.cone_subset c hc⟩
  · -- -1 ∉ T_∞
    rintro ⟨n, hn⟩
    exact (hstep n).2.1 hn
  · -- 符号の両側を覆うこと
    intro z hz
    obtain ⟨n, rfl⟩ := hξ z
    have hTn := (hstep n).1
    by_cases hm : (-1 : Qbar) ∈ preconeAdjoin (preconeChain E T ξ n) (ξ n)
    · right
      refine ⟨n + 1, ?_⟩
      rw [preconeChain, if_pos hz, if_pos hm]
      exact (preconeAdjoin_isSubfieldPrecone F E CF _ hTn (-ξ n) (E.neg_mem hz)).2.2
    · left
      refine ⟨n + 1, ?_⟩
      rw [preconeChain, if_pos hz, if_neg hm]
      exact (preconeAdjoin_isSubfieldPrecone F E CF _ hTn (ξ n) hz).2.2

end Ising2DLambda.FisherZero
