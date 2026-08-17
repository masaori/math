/-
章「安定ファイバーの層別完全逆像」の必要十分版。

具体版と同じ順序を保ち、層別完全逆像に実際に要る性質を分離する。

* 正の層と零層の完全逆像には、ファイバーの点ごとの移送同値、零層保存、
  正の深さの一段減少だけが要る。有限性、反復、冪等性は要らない。
* 最小前周期の零層保存を自己写像から導く段階にだけ有限性を要る。
* 一つの層の完全逆像を有限表にする段階にだけ有限性と等号判定を要る。

二値状態、セル、近傍、局所規則、R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidStableFiberDepth

namespace CellularAutomata.NecSuf.IterateMonoidStableFiberLayerPreimage

open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.MinimalPreperiodPeriod

/-! ## 一般層: ファイバー族と深さ写像だけで成り立つ部分 -/

section GeneralLayer

variable {X Q : Type} (F : X → X) (B : Q → Set X) (μ : X → ℕ) (σ : Q → Q)

def fiberDepthLayer (q : Q) (k : ℕ) : Set X :=
  {y | y ∈ B q ∧ μ y = k}

/-- 正の層の完全逆像は一つ上の層である。使う仮定は三性質だけである。 -/
theorem positive_fiberDepthLayer_exact_preimage
    (hfiber : ∀ q y, F y ∈ B (σ q) ↔ y ∈ B q)
    (hzero : ∀ y, μ y = 0 → μ (F y) = 0)
    (hdec : ∀ y, 0 < μ y → μ (F y) = μ y - 1)
    (q : Q) (k : ℕ) (hk : 0 < k) :
    F ⁻¹' fiberDepthLayer B μ (σ q) k = fiberDepthLayer B μ q (k + 1) := by
  ext y
  change (F y ∈ B (σ q) ∧ μ (F y) = k) ↔ (y ∈ B q ∧ μ y = k + 1)
  constructor
  · intro hy
    have hypos : 0 < μ y := by
      by_contra h
      have hyzero : μ y = 0 := by omega
      have hnextZero := hzero y hyzero
      omega
    refine ⟨(hfiber q y).1 hy.1, ?_⟩
    have hstep := hdec y hypos
    omega
  · intro hy
    have hypos : 0 < μ y := by omega
    refine ⟨(hfiber q y).2 hy.1, ?_⟩
    have hstep := hdec y hypos
    omega

/-- 零層の完全逆像では零層と一層だけが合流する。 -/
theorem zero_fiberDepthLayer_exact_preimage
    (hfiber : ∀ q y, F y ∈ B (σ q) ↔ y ∈ B q)
    (hzero : ∀ y, μ y = 0 → μ (F y) = 0)
    (hdec : ∀ y, 0 < μ y → μ (F y) = μ y - 1)
    (q : Q) :
    F ⁻¹' fiberDepthLayer B μ (σ q) 0 =
      fiberDepthLayer B μ q 0 ∪ fiberDepthLayer B μ q 1 := by
  ext y
  change (F y ∈ B (σ q) ∧ μ (F y) = 0) ↔
    (y ∈ B q ∧ μ y = 0) ∨ (y ∈ B q ∧ μ y = 1)
  constructor
  · intro hy
    have hyq := (hfiber q y).1 hy.1
    by_cases hyzero : μ y = 0
    · exact Or.inl ⟨hyq, hyzero⟩
    · right
      have hypos : 0 < μ y := Nat.pos_of_ne_zero hyzero
      have hstep := hdec y hypos
      exact ⟨hyq, by omega⟩
  · rintro (hy | hy)
    · exact ⟨(hfiber q y).2 hy.1, hzero y hy.2⟩
    · refine ⟨(hfiber q y).2 hy.1, ?_⟩
      have hypos : 0 < μ y := by omega
      have hstep := hdec y hypos
      omega

end GeneralLayer

/-! ## 自己写像の最小前周期の零層保存 -/

section Preperiod

variable {X : Type} [Fintype X] (F : X → X)

theorem minPreperiod_map_eq_zero (y : X) (hzero : minPreperiod F y = 0) :
    minPreperiod F (F y) = 0 := by
  let p := minPeriod F y
  have hp : IsPeriodicityPair F y 0 p := by
    simpa [hzero] using minPeriod_spec F y
  have hpair : IsPeriodicityPair F (F y) 0 p := by
    refine ⟨hp.1, ?_⟩
    intro n _hn
    calc
      iterate F (n + p) (F y) = iterate F (n + p + 1) y :=
        CellularAutomata.NecSuf.IterateMonoidStableFiberDepth.iterate_map F (n + p) y
      _ = iterate F (n + 1 + p) y := by congr 1 <;> omega
      _ = iterate F (n + 1) y := hp.2 (n + 1) (by omega)
      _ = iterate F n (F y) :=
        (CellularAutomata.NecSuf.IterateMonoidStableFiberDepth.iterate_map F n y).symm
  exact Nat.eq_zero_of_le_zero (minPreperiod_le F (F y) ⟨p, hpair⟩)

end Preperiod

/-! ## 有限走査 -/

section FiniteScan

variable {X Q : Type} [Fintype X] [DecidableEq X]
variable (F : X → X) (B : Q → Set X) (μ : X → ℕ) (σ : Q → Q)

noncomputable def layerPreimageTable (q : Q) (k : ℕ) : Finset X :=
  by
    classical
    exact Finset.univ.filter fun y => F y ∈ fiberDepthLayer B μ (σ q) k

theorem mem_layerPreimageTable_iff (q : Q) (k : ℕ) (y : X) :
    y ∈ layerPreimageTable F (B := B) (μ := μ) σ q k ↔
      F y ∈ fiberDepthLayer B μ (σ q) k := by
  classical
  simp [layerPreimageTable]

end FiniteScan

end CellularAutomata.NecSuf.IterateMonoidStableFiberLayerPreimage
