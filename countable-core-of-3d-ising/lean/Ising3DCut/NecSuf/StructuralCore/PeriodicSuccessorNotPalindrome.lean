/-
人手証明「奇数軌道では多重度は回文でない」の必要十分版。

有限周期後続系から、証明が実際に使う次のデータだけを残す: 有限な配位型と辺型、
各配位の破れ数、破れ数 0 の witness、各配位から選んだ長さ L の整数 ±1 の輪、
全辺破れなら輪の隣接値がすべて異なること。後続写像、座標、方向、群構造は仮定しない。

証明手順は具体版と同じ（下端の正値性、奇数輪による全辺破れの否定、上端の零、
端点多重度の不一致）。住処は有限型、自然数、整数 ±1、有限積だけである。
-/
import Ising3DCut.NecSuf.NullModel.OddPeriodicCycle
import Ising3DCut.NecSuf.NullModel.PeriodicNotPalindrome

namespace Ising3DCut.NecSuf.StructuralCore

variable {Config Edge : Type} [Fintype Config] [DecidableEq Config] [Fintype Edge]
variable {L : ℕ} (brokenCount : Config → ℕ)

/-- 抽象化した破れ数の水準集合の個数。 -/
def periodicMultiplicity (m : ℕ) : ℕ :=
  (Finset.univ.filter fun σ : Config => brokenCount σ = m).card

/-- 破れ数 0 の witness から下端の多重度は正になる。 -/
lemma one_le_periodicMultiplicity_zero (σzero : Config) (hzero : brokenCount σzero = 0) :
    1 ≤ periodicMultiplicity brokenCount 0 := by
  rw [periodicMultiplicity, Finset.one_le_card]
  exact ⟨σzero, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hzero⟩⟩

/-- 奇数輪の有限積だけから、全辺破れの配位を排除する。 -/
lemma no_config_full (hodd : Odd L) (value : Config → Fin L → ℤ)
    (hvalue : ∀ σ k, value σ k = 1 ∨ value σ k = -1)
    (hfull_opposite : ∀ σ, brokenCount σ = Fintype.card Edge →
      ∀ k, value σ k ≠ value σ (finRotate L k))
    (σ : Config) : brokenCount σ ≠ Fintype.card Edge := by
  intro hfull
  exact Ising3DCut.NecSuf.NullModel.no_odd_cycle_all_opposite hodd
    (value σ) (hvalue σ) (hfull_opposite σ hfull)

/-- 全辺破れの配位が無いので上端の多重度は零である。 -/
lemma periodicMultiplicity_full_eq_zero (hodd : Odd L) (value : Config → Fin L → ℤ)
    (hvalue : ∀ σ k, value σ k = 1 ∨ value σ k = -1)
    (hfull_opposite : ∀ σ, brokenCount σ = Fintype.card Edge →
      ∀ k, value σ k ≠ value σ (finRotate L k)) :
    periodicMultiplicity brokenCount (Fintype.card Edge) = 0 := by
  rw [periodicMultiplicity, Finset.card_eq_zero, Finset.filter_eq_empty_iff]
  intro σ _
  exact no_config_full brokenCount hodd value hvalue hfull_opposite σ

/-- 奇数軌道で端点多重度が一致しないことの必要十分版。 -/
theorem periodicMultiplicity_not_palindrome (hodd : Odd L)
    (σzero : Config) (hzero : brokenCount σzero = 0)
    (value : Config → Fin L → ℤ)
    (hvalue : ∀ σ k, value σ k = 1 ∨ value σ k = -1)
    (hfull_opposite : ∀ σ, brokenCount σ = Fintype.card Edge →
      ∀ k, value σ k ≠ value σ (finRotate L k)) :
    periodicMultiplicity brokenCount 0 ≠
      periodicMultiplicity brokenCount (Fintype.card Edge - 0) := by
  rw [Nat.sub_zero]
  exact Ising3DCut.NecSuf.NullModel.ne_of_one_le_of_eq_zero
    (one_le_periodicMultiplicity_zero brokenCount σzero hzero)
    (periodicMultiplicity_full_eq_zero brokenCount hodd value hvalue hfull_opposite)

end Ising3DCut.NecSuf.StructuralCore
