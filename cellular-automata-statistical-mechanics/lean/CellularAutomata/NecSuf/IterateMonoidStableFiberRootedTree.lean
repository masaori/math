/-
章「安定ファイバー上の一周期写像が定める根付き木」の必要十分版。

具体版と同じ手順を保ち、実際に使う構造だけを残す。一つの型 X、自己写像 R、
ファイバー族 B、根 root に対し、必要なのは R によるファイバー保存、根の不動性、
および各ファイバー元が R の有限反復で根へ到達することだけである。有限性と
等号判定は、辺・深さ・分岐数を有限表として列挙する段階にだけ要る。

二値状態、セル、近傍、局所規則、元の写像 F、周期、反復モノイド、R / C は使わない。
-/
import CellularAutomata.NecSuf.GlobalMapIteration

namespace CellularAutomata.NecSuf.IterateMonoidStableFiberRootedTree

open CellularAutomata.NecSuf.GlobalMapIteration

variable {X Q : Type} (R : X → X) (B : Q → Set X) (root : Q → X)

/-- 根への到達回数の最小値。存在以外の構造を要しない。 -/
noncomputable def rootDepth
    (hreach : ∀ q y, y ∈ B q → ∃ d, iterate R d y = root q)
    (q : Q) (y : X) (hy : y ∈ B q) : ℕ := by
  classical
  exact Nat.find (hreach q y hy)

theorem rootDepth_spec
    (hreach : ∀ q y, y ∈ B q → ∃ d, iterate R d y = root q)
    (q : Q) (y : X) (hy : y ∈ B q) :
    iterate R (rootDepth R B root hreach q y hy) y = root q := by
  classical
  exact Nat.find_spec (hreach q y hy)

theorem rootDepth_le
    (hreach : ∀ q y, y ∈ B q → ∃ d, iterate R d y = root q)
    (q : Q) (y : X) (hy : y ∈ B q) {d : ℕ}
    (hd : iterate R d y = root q) :
    rootDepth R B root hreach q y hy ≤ d := by
  classical
  exact Nat.find_min' (hreach q y hy) hd

/-- R の反復回数の加法則。 -/
theorem iterate_add (a b : ℕ) (y : X) :
    iterate R (a + b) y = iterate R b (iterate R a y) := by
  induction b with
  | zero => simp [iterate]
  | succ b ih => simpa [iterate, Nat.add_assoc] using congrArg R ih

theorem iterate_map (n : ℕ) (y : X) :
    iterate R n (R y) = iterate R (n + 1) y := by
  induction n with
  | zero => rfl
  | succ n ih => exact congrArg R ih

/-- ファイバー内の R の不動点は根だけである。 -/
theorem unique_fixed_point
    (hreach : ∀ q y, y ∈ B q → ∃ d, iterate R d y = root q)
    (q : Q) (y : X) (hy : y ∈ B q) (hfix : R y = y) : y = root q := by
  obtain ⟨d, hd⟩ := hreach q y hy
  have hiter : ∀ n : ℕ, iterate R n y = y := by
    intro n
    induction n with
    | zero => rfl
    | succ n ih => simpa [iterate, ih] using hfix
  exact (hiter d).symm.trans hd

/-- 深さが零であることと根であることは同値である。 -/
theorem rootDepth_eq_zero_iff_root
    (hroot : ∀ q, R (root q) = root q)
    (hreach : ∀ q y, y ∈ B q → ∃ d, iterate R d y = root q)
    (q : Q) (y : X) (hy : y ∈ B q) :
    rootDepth R B root hreach q y hy = 0 ↔ y = root q := by
  constructor
  · intro hzero
    have h := rootDepth_spec R B root hreach q y hy
    simpa [hzero, iterate] using h
  · intro hyroot
    apply Nat.eq_zero_of_le_zero
    apply rootDepth_le R B root hreach q y hy
    simpa [hyroot, iterate] using hroot q

/-- 非根の一段像は同じファイバーに属し、深さがちょうど一つ減る。 -/
theorem rootDepth_decrement
    (hpres : ∀ q y, y ∈ B q → R y ∈ B q)
    (hroot : ∀ q, R (root q) = root q)
    (hreach : ∀ q y, y ∈ B q → ∃ d, iterate R d y = root q)
    (q : Q) (y : X) (hy : y ∈ B q) (hne : y ≠ root q) :
    1 ≤ rootDepth R B root hreach q y hy ∧
      rootDepth R B root hreach q (R y) (hpres q y hy) =
        rootDepth R B root hreach q y hy - 1 := by
  let d := rootDepth R B root hreach q y hy
  have hdpos : 0 < d := by
    by_contra h
    have hd0 : d = 0 := by omega
    exact hne ((rootDepth_eq_zero_iff_root R B root hroot hreach q y hy).1 hd0)
  have hupper : rootDepth R B root hreach q (R y) (hpres q y hy) ≤ d - 1 := by
    apply rootDepth_le R B root hreach q (R y) (hpres q y hy)
    have hspec := rootDepth_spec R B root hreach q y hy
    rw [iterate_map]
    convert hspec using 1
    rw [show d - 1 + 1 = d by omega]
  have hlower : d ≤ rootDepth R B root hreach q (R y) (hpres q y hy) + 1 := by
    apply rootDepth_le R B root hreach q y hy
    have hspec := rootDepth_spec R B root hreach q (R y) (hpres q y hy)
    rw [← iterate_map]
    exact hspec
  exact ⟨hdpos, by omega⟩

/-- 自然数値の階数が各辺で厳密に減る有向グラフには閉路がない。 -/
theorem no_cycle_of_rank (rank : X → ℕ) {n : ℕ} (hn : 0 < n) (p : ℕ → X)
    (hcycle : p n = p 0)
    (hdec : ∀ i, i < n → rank (p (i + 1)) < rank (p i)) : False := by
  have hlt : ∀ i, i ≤ n → rank (p i) + i ≤ rank (p 0) := by
    intro i hi
    induction i with
    | zero => simp
    | succ i ih =>
      have hprev := ih (by omega)
      have hstep := hdec i (by omega)
      omega
  have hnle := hlt n (le_refl n)
  rw [hcycle] at hnle
  omega

section FiniteScan

variable [Fintype X] [DecidableEq X]

noncomputable def fiberTable (q : Q) : Finset X := by
  classical
  exact Finset.univ.filter (fun y => y ∈ B q)

noncomputable def edgeTable (q : Q) : Finset (X × X) := by
  classical
  exact (Finset.univ.filter (fun y => y ∈ B q ∧ y ≠ root q)).image (fun y => (y, R y))

theorem edgeTable_card (q : Q) (hrootmem : root q ∈ B q) :
    (edgeTable R B root q).card = (fiberTable B q).card - 1 := by
  classical
  rw [edgeTable, Finset.card_image_of_injOn (fun _ _ _ _ h => congrArg Prod.fst h)]
  rw [show Finset.univ.filter (fun y => y ∈ B q ∧ y ≠ root q) =
      (fiberTable B q).erase (root q) by ext y; simp [fiberTable, and_comm]]
  rw [Finset.card_erase_of_mem]
  simpa [fiberTable] using hrootmem

noncomputable def branchCount (q : Q) (y : X) : ℕ := by
  classical
  exact ((edgeTable R B root q).filter (fun e => e.2 = y)).card

end FiniteScan

end CellularAutomata.NecSuf.IterateMonoidStableFiberRootedTree
