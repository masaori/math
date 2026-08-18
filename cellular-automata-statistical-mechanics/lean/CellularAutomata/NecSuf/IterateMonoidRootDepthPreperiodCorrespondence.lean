/-
章「根付き木の深さと最小前周期層の対応」の必要十分版。

具体版と同じ手順を保つ。切り上げ値を Nat.find で取り、周期の倍数の伝播と衝突の
前送りで切り上げ位置での根到達を示し、根到達と最小前周期の最小性から前方の
非到達を示し、両者から深さとの一致を自然数の最小元の一意性で得る。

一つの型 X、自己写像 F、一つの点 x、根の値 r に対し、実際に使う構造は次だけである。
* 切り上げ値の定義には、最小前周期にあたる自然数 μ と周期にあたる自然数 λ、および
  切り上げ集合 {d | μ ≤ d λ} の非空性（具体版では μ(y) ≤ μ_F ≤ e_F = m_F λ_F の
  鎖が与える）だけ。
* 切り上げ位置での根到達には、位置 μ での λ 周期の衝突と、位置 m λ での根到達、
  μ ≤ m λ だけ。λ ≥ 1 も μ の最小性も要らない。
* 前方の非到達には、さらに λ ≥ 1（d λ < m λ を得るため）と μ の最小性
  （正の幅の衝突が起きる位置は μ 以上）だけ。
* 深さとの一致には、上の二つの主張だけ。
* X の有限性・等号判定は、全点の対応表を有限走査する段階にだけ要る。

二値状態、セル、近傍、局所規則、反復モノイド、ファイバー族の構造、R / C は使わない。
-/
import CellularAutomata.NecSuf.MinimalPreperiodPeriod

namespace CellularAutomata.NecSuf.IterateMonoidRootDepthPreperiodCorrespondence

open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.MinimalPreperiodPeriod

variable {X : Type} (F : X → X) (x : X) (r : X)

/-- 切り上げ値 `c := min {d | μ ≤ d λ}`。要るのは集合の非空性だけである。 -/
noncomputable def roundedPreperiod (μ lam : ℕ) (hex : ∃ d : ℕ, μ ≤ d * lam) : ℕ := by
  classical
  exact Nat.find hex

theorem roundedPreperiod_spec (μ lam : ℕ) (hex : ∃ d : ℕ, μ ≤ d * lam) :
    μ ≤ roundedPreperiod μ lam hex * lam := by
  classical
  exact Nat.find_spec hex

theorem roundedPreperiod_le (μ lam : ℕ) (hex : ∃ d : ℕ, μ ≤ d * lam) {d : ℕ}
    (hd : μ ≤ d * lam) : roundedPreperiod μ lam hex ≤ d := by
  classical
  exact Nat.find_min' hex hd

/-- 切り上げ位置での根到達。位置 μ での λ 周期の衝突（`hμcol`）、位置 m λ での
    根到達（`hroot`）、`μ ≤ m λ`（`hμm`。切り上げ値が m 以下であることに使う）
    だけが要る。λ ≥ 1 も μ の最小性も X の有限性も要らない。 -/
theorem roundedPreperiod_reaches_root {μ lam m : ℕ}
    (hex : ∃ d : ℕ, μ ≤ d * lam)
    (hμcol : iterate F (μ + lam) x = iterate F μ x)
    (hroot : iterate F (m * lam) x = r)
    (hμm : μ ≤ m * lam) :
    iterate F (roundedPreperiod μ lam hex * lam) x = r := by
  set c := roundedPreperiod μ lam hex with hc
  have hcμ : μ ≤ c * lam := roundedPreperiod_spec μ lam hex
  have hcm : c ≤ m := roundedPreperiod_le μ lam hex hμm
  obtain ⟨h, hmh⟩ : ∃ h : ℕ, m = c + h := Nat.exists_eq_add_of_le hcm
  have hmult : iterate F (μ + h * lam) x = iterate F μ x :=
    period_multiples F x hμcol h
  set a := c * lam - μ with ha'
  have hshift := collision_shift F x hmult a
  have ha : μ + a = c * lam := by omega
  have hleft : μ + h * lam + a = m * lam := by
    have hmlam : m * lam = c * lam + h * lam := by rw [hmh, Nat.add_mul]
    omega
  calc
    iterate F (c * lam) x = iterate F (μ + a) x := by rw [ha]
    _ = iterate F (μ + h * lam + a) x := hshift.symm
    _ = iterate F (m * lam) x := by rw [hleft]
    _ = r := hroot

/-- 切り上げ位置より前の非到達。さらに λ ≥ 1（`hlam`。`d λ < m λ` を得るため）と
    μ の最小性（`hμmin`。正の幅の衝突が起きる位置は μ 以上）だけが要る。 -/
theorem before_roundedPreperiod_not_root {μ lam m : ℕ}
    (hex : ∃ d : ℕ, μ ≤ d * lam)
    (hlam : 1 ≤ lam)
    (hμmin : ∀ n p : ℕ, 1 ≤ p → iterate F (n + p) x = iterate F n x → μ ≤ n)
    (hroot : iterate F (m * lam) x = r)
    (hμm : μ ≤ m * lam)
    {d : ℕ} (hd : d < roundedPreperiod μ lam hex) :
    iterate F (d * lam) x ≠ r := by
  intro hdroot
  have hnot : ¬ μ ≤ d * lam := by
    intro hle
    exact (Nat.not_le_of_lt hd) (roundedPreperiod_le μ lam hex hle)
  have hcm : roundedPreperiod μ lam hex ≤ m := roundedPreperiod_le μ lam hex hμm
  have hdm : d * lam < m * lam :=
    Nat.mul_lt_mul_of_pos_right (lt_of_lt_of_le hd hcm) hlam
  set p := m * lam - d * lam with hp'
  have hp : 1 ≤ p := by omega
  have hsum : d * lam + p = m * lam := by omega
  have hcol : iterate F (d * lam + p) x = iterate F (d * lam) x := by
    calc
      iterate F (d * lam + p) x = iterate F (m * lam) x := by rw [hsum]
      _ = r := hroot
      _ = iterate F (d * lam) x := hdroot.symm
  exact hnot (hμmin (d * lam) p hp hcol)

/-- 一周期単位の根への深さ `min {d | F^{dλ}(x) = r}`。要るのは非空性だけである。 -/
noncomputable def rootDepthByPeriod (lam : ℕ)
    (hexd : ∃ d : ℕ, iterate F (d * lam) x = r) : ℕ := by
  classical
  exact Nat.find hexd

theorem rootDepthByPeriod_spec (lam : ℕ)
    (hexd : ∃ d : ℕ, iterate F (d * lam) x = r) :
    iterate F (rootDepthByPeriod F x r lam hexd * lam) x = r := by
  classical
  exact Nat.find_spec hexd

theorem rootDepthByPeriod_le (lam : ℕ)
    (hexd : ∃ d : ℕ, iterate F (d * lam) x = r) {d : ℕ}
    (hd : iterate F (d * lam) x = r) :
    rootDepthByPeriod F x r lam hexd ≤ d := by
  classical
  exact Nat.find_min' hexd hd

/-- 深さは切り上げ値に一致する。切り上げ位置での根到達と前方の非到達の
    二主張だけから、自然数の最小元の一意性（両側の ≤）で従う。 -/
theorem rootDepthByPeriod_eq_roundedPreperiod {μ lam m : ℕ}
    (hex : ∃ d : ℕ, μ ≤ d * lam)
    (hexd : ∃ d : ℕ, iterate F (d * lam) x = r)
    (hlam : 1 ≤ lam)
    (hμcol : iterate F (μ + lam) x = iterate F μ x)
    (hμmin : ∀ n p : ℕ, 1 ≤ p → iterate F (n + p) x = iterate F n x → μ ≤ n)
    (hroot : iterate F (m * lam) x = r)
    (hμm : μ ≤ m * lam) :
    rootDepthByPeriod F x r lam hexd = roundedPreperiod μ lam hex := by
  apply Nat.le_antisymm
  · exact rootDepthByPeriod_le F x r lam hexd
      (roundedPreperiod_reaches_root F x r hex hμcol hroot hμm)
  · by_contra hnot
    have hlt : rootDepthByPeriod F x r lam hexd < roundedPreperiod μ lam hex :=
      Nat.lt_of_not_ge hnot
    exact before_roundedPreperiod_not_root F x r hex hlam hμmin hroot hμm hlt
      (rootDepthByPeriod_spec F x r lam hexd)

section FiniteScan

variable [Fintype X] [DecidableEq X]

/-- 全点の `(点, μ, c, d)` の対応表。X の有限性と等号判定はここにだけ要る。 -/
noncomputable def correspondenceTable (pre cval dep : X → ℕ) :
    Finset (X × ℕ × ℕ × ℕ) := by
  classical
  exact Finset.univ.image (fun y => (y, pre y, cval y, dep y))

theorem mem_correspondenceTable (pre cval dep : X → ℕ) (y : X) :
    (y, pre y, cval y, dep y) ∈ correspondenceTable pre cval dep := by
  classical
  exact Finset.mem_image.mpr ⟨y, Finset.mem_univ y, rfl⟩

end FiniteScan

end CellularAutomata.NecSuf.IterateMonoidRootDepthPreperiodCorrespondence
