/-
「列挙に沿って前錐を一元ずつ大きくした列の和集合は、負の単位元を含まず符号の両側を覆う前錐である」の必要十分版。

証明の手順は具体版と同じ（各 `T_n` についての帰納法、単調性、和集合の四条件、`-1` の不在、符号の被覆）。
使う性質は次だけである。
- 台は可換環。一歩の延長（`preconeAdjoin_isPreconeOn_necSuf`）が乗法の交換則を、
  片側の選択（`neg_one_not_mem_adjoin_or_necSuf`）が符号反転と `-1` を使う。
- `E` は零元・単位元を含み、和・積・符号反転で閉じる。零元・単位元・和・積は一歩の延長に、
  符号反転は第三の場合の `-ξ(n) ∈ E` に要る。`E` が逆元で閉じることは使わない。
- 列挙 `ξ` は `E` の各元を値に取れば足りる（台全体への全射は要らない）。
- 前錐が `F ⊆ E` と `F` の正錐から来ることは使わない（具体版との対応は導出版が述べる）。
台が体であること、代数閉性、可算性そのものは要らない。
-/
import Ising2DLambda.NecSuf.FisherZero.SubfieldPrecone

namespace Ising2DLambda.NecSuf.FisherZero

open Classical in
/-- 列 `T_n`。`T_0 = T`、`T_{n+1}` は具体版と同じ三つの場合分けで定める。 -/
noncomputable def chainSet {K : Type*} [CommRing K] (E T : Set K) (ξ : ℕ → K) : ℕ → Set K
  | 0 => T
  | n + 1 =>
    if ξ n ∈ E then
      (if (-1 : K) ∈ adjoinSet (chainSet E T ξ n) (ξ n) then
        adjoinSet (chainSet E T ξ n) (-ξ n)
      else adjoinSet (chainSet E T ξ n) (ξ n))
    else chainSet E T ξ n

/-- 和集合 `T_∞`。 -/
def chainUnion {K : Type*} [CommRing K] (E T : Set K) (ξ : ℕ → K) : Set K :=
  {z | ∃ n : ℕ, z ∈ chainSet E T ξ n}

theorem chainSet_step_necSuf {K : Type*} [CommRing K] (E C T : Set K)
    (hE0 : (0 : K) ∈ E) (hE1 : (1 : K) ∈ E)
    (hEadd : ∀ x y : K, x ∈ E → y ∈ E → x + y ∈ E)
    (hEmul : ∀ x y : K, x ∈ E → y ∈ E → x * y ∈ E)
    (hEneg : ∀ x : K, x ∈ E → -x ∈ E)
    (hT : IsPreconeOn E C T) (hneg : (-1 : K) ∉ T) (ξ : ℕ → K) :
    ∀ n : ℕ, IsPreconeOn E C (chainSet E T ξ n) ∧ (-1 : K) ∉ chainSet E T ξ n ∧
      (∀ z : K, z ∈ chainSet E T ξ n → z ∈ chainSet E T ξ (n + 1)) := by
  have hstep := fun (T' : Set K) (hT' : IsPreconeOn E C T') (a : K) (ha : a ∈ E) =>
    preconeAdjoin_isPreconeOn_necSuf E C T' hE0 hE1 hEadd hEmul hT' a ha
  have hP : ∀ n : ℕ, IsPreconeOn E C (chainSet E T ξ n) ∧ (-1 : K) ∉ chainSet E T ξ n := by
    intro n
    induction n with
    | zero => exact ⟨hT, hneg⟩
    | succ n ih =>
      obtain ⟨hTn, hnegn⟩ := ih
      by_cases hE : ξ n ∈ E
      · by_cases hm : (-1 : K) ∈ adjoinSet (chainSet E T ξ n) (ξ n)
        · have hside := neg_one_not_mem_adjoin_or_necSuf _ hTn.add_mem hTn.mul_mem hnegn (ξ n)
            (hTn.sq_mem (ξ n) hE)
          have hnot : (-1 : K) ∉ adjoinSet (chainSet E T ξ n) (-ξ n) := by
            rcases hside with h | h
            · exact absurd hm h
            · exact h
          rw [chainSet, if_pos hE, if_pos hm]
          exact ⟨(hstep _ hTn (-ξ n) (hEneg _ hE)).1, hnot⟩
        · rw [chainSet, if_pos hE, if_neg hm]
          exact ⟨(hstep _ hTn (ξ n) hE).1, hm⟩
      · rw [chainSet, if_neg hE]
        exact ⟨hTn, hnegn⟩
  intro n
  refine ⟨(hP n).1, (hP n).2, ?_⟩
  intro z hz
  have hTn := (hP n).1
  by_cases hE : ξ n ∈ E
  · by_cases hm : (-1 : K) ∈ adjoinSet (chainSet E T ξ n) (ξ n)
    · rw [chainSet, if_pos hE, if_pos hm]
      exact (hstep _ hTn (-ξ n) (hEneg _ hE)).2.1 z hz
    · rw [chainSet, if_pos hE, if_neg hm]
      exact (hstep _ hTn (ξ n) hE).2.1 z hz
  · rw [chainSet, if_neg hE]
    exact hz

/-- 具体版と同じ段（帰納法、単調性、和集合の四条件、`-1` の不在、符号の被覆）で示す。 -/
theorem chainUnion_covers_signs_necSuf {K : Type*} [CommRing K] (E C T : Set K)
    (hE0 : (0 : K) ∈ E) (hE1 : (1 : K) ∈ E)
    (hEadd : ∀ x y : K, x ∈ E → y ∈ E → x + y ∈ E)
    (hEmul : ∀ x y : K, x ∈ E → y ∈ E → x * y ∈ E)
    (hEneg : ∀ x : K, x ∈ E → -x ∈ E)
    (hT : IsPreconeOn E C T) (hneg : (-1 : K) ∉ T) (ξ : ℕ → K)
    (hξ : ∀ z : K, z ∈ E → ∃ n : ℕ, ξ n = z) :
    IsPreconeOn E C (chainUnion E T ξ) ∧ (-1 : K) ∉ chainUnion E T ξ ∧
      (∀ z : K, z ∈ E → z ∈ chainUnion E T ξ ∨ -z ∈ chainUnion E T ξ) := by
  have hstep := chainSet_step_necSuf E C T hE0 hE1 hEadd hEmul hEneg hT hneg ξ
  have hadj := fun (T' : Set K) (hT' : IsPreconeOn E C T') (a : K) (ha : a ∈ E) =>
    preconeAdjoin_isPreconeOn_necSuf E C T' hE0 hE1 hEadd hEmul hT' a ha
  -- 単調性（k についての帰納法）
  have hmono : ∀ m n : ℕ, m ≤ n → ∀ z : K, z ∈ chainSet E T ξ m → z ∈ chainSet E T ξ n := by
    intro m n hmn
    obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hmn
    clear hmn
    induction k with
    | zero => intro z hz; exact hz
    | succ k ih => intro z hz; exact (hstep (m + k)).2.2 z (ih z hz)
  refine ⟨⟨?_, ?_, ?_, ?_, ?_⟩, ?_, ?_⟩
  · rintro z ⟨n, hz⟩
    exact (hstep n).1.subset z hz
  · rintro a b ⟨m, ha⟩ ⟨n, hb⟩
    exact ⟨max m n, (hstep (max m n)).1.add_mem a b
      (hmono m _ (le_max_left m n) a ha) (hmono n _ (le_max_right m n) b hb)⟩
  · rintro a b ⟨m, ha⟩ ⟨n, hb⟩
    exact ⟨max m n, (hstep (max m n)).1.mul_mem a b
      (hmono m _ (le_max_left m n) a ha) (hmono n _ (le_max_right m n) b hb)⟩
  · intro y hy
    exact ⟨0, hT.sq_mem y hy⟩
  · intro c hc
    exact ⟨0, hT.cone_subset c hc⟩
  · rintro ⟨n, hn⟩
    exact (hstep n).2.1 hn
  · intro z hz
    obtain ⟨n, rfl⟩ := hξ z hz
    have hTn := (hstep n).1
    by_cases hm : (-1 : K) ∈ adjoinSet (chainSet E T ξ n) (ξ n)
    · right
      refine ⟨n + 1, ?_⟩
      rw [chainSet, if_pos hz, if_pos hm]
      exact (hadj _ hTn (-ξ n) (hEneg _ hz)).2.2
    · left
      refine ⟨n + 1, ?_⟩
      rw [chainSet, if_pos hz, if_neg hm]
      exact (hadj _ hTn (ξ n) hz).2.2

end Ising2DLambda.NecSuf.FisherZero
