/-
「下組の実現像の上限は列の実数極限に等しい」の必要十分版。

具体版と同じ手順（第一の事実: 全順序性と単調性で実現値の狭義比較を順序へ戻す、
第二の事実: `ρ(0) = ρ(0·0) = 0·ρ(0) = 0`、上から: `ρ(μ) = ρ(0+μ) ≤ ρ(ε+μ) = ρ(μ+ε) ≤ ρ(λ_L)` と極限、
下から: `b/c < r < r' < I/c` の有理数、`μ := r·g`、`ε := (r'−r)·g` の三つの鎖と収束から `N`）を、
次の仮定だけで行う。

- `G`: 有理数体上の加群（`Λ_ℚ` にあたる）。加法の結合則・可換則・単位元と、有理数倍の分配則
  `(r+s)·g = r·g + s·g`・`0·g = 0` だけを使う。逆元・素数による基底は使わない。
- `le`: `G` 上の関係（`≤_{Λ_ℚ}` にあたる）。全順序性 `le a b ∨ le b a` と加法単調性だけを仮定する。
  反射律・推移律・反対称律は使わない。
- `K`: Archimedes 的な線型順序体で、順序位相を持つ（実数体にあたる）。**完備性は使わない**。
  Archimedes 性は有理数の稠密性で、順序位相は「極限が広義の不等式を保つ」「収束の定義」で使う
  （`lt_mem_nhds` が順序位相を要るので、順序閉位相へは弱められない）。
- `ρ : G → K`（実現写像にあたる）は `le` について単調で、有理数倍と可換。加法性は使わない。
- `g ∈ G` で `0 < ρ(g)`（`ȷ(ℓ_2)` にあたる）。具体版はこれを第三の事実
  （`rat_Λ(ℓ_2) = 2`、`ι` の狭義順序保存、実対数の狭義単調性）から得る。
結論は「空でない」「`I` が最小上界」までで、`sSup` を持たない `K` でも述べられる。
-/
import Mathlib.Algebra.Order.Archimedean.Basic
import Mathlib.Topology.Order.OrderClosed
import Mathlib.Topology.Order.Basic
import Mathlib.Algebra.Module.Rat

namespace Ising2DLambda.NecSuf.RealEscape

open Filter Topology

variable {G K : Type*} [AddCommMonoid G] [Module ℚ G]
  [Field K] [LinearOrder K] [IsStrictOrderedRing K] [Archimedean K]
  [TopologicalSpace K] [OrderTopology K]

/-- 列 `l` が定める下組（`le` について）。 -/
def sequenceLowerSetNecSuf (le : G → G → Prop) (l : ℕ → G) : Set G :=
  { μ | ∃ ε : G, le 0 ε ∧ ε ≠ 0 ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ L : ℕ, N ≤ L → le (μ + ε) (l L) }

omit [AddCommMonoid G] [Module ℚ G] [Field K] [IsStrictOrderedRing K] [Archimedean K] [TopologicalSpace K]
  [OrderTopology K] in
/-- 第一の事実。 -/
theorem le_of_realize_lt_necSuf (le : G → G → Prop) (htotal : ∀ a b, le a b ∨ le b a)
    (ρ : G → K) (hmono : ∀ a b, le a b → ρ a ≤ ρ b) {α β : G} (h : ρ α < ρ β) : le α β := by
  rcases htotal α β with hab | hba
  · exact hab
  · exact absurd (hmono β α hba) (not_le.mpr h)

omit [Archimedean K] [TopologicalSpace K] [OrderTopology K] [LinearOrder K]
  [IsStrictOrderedRing K] in
/-- 第二の事実: `ρ(0) = 0`。 -/
theorem realize_zero_necSuf (ρ : G → K) (hsmul : ∀ (r : ℚ) (a : G), ρ (r • a) = (r : K) * ρ a) :
    ρ 0 = 0 := by
  calc
    ρ 0 = ρ ((0 : ℚ) • (0 : G)) := by rw [zero_smul]
    _ = ((0 : ℚ) : K) * ρ 0 := hsmul 0 0
    _ = 0 * ρ 0 := by rw [Rat.cast_zero]
    _ = 0 := zero_mul _

/-- 主張: 実現値の列が `I` に収束するなら、下組の実現像は空でなく、`I` はその最小上界である。 -/
theorem sequence_lowerSet_isLUB_necSuf (le : G → G → Prop) (htotal : ∀ a b, le a b ∨ le b a)
    (hadd : ∀ a b, le a b → ∀ n, le (a + n) (b + n))
    (ρ : G → K) (hmono : ∀ a b, le a b → ρ a ≤ ρ b)
    (hsmul : ∀ (r : ℚ) (a : G), ρ (r • a) = (r : K) * ρ a)
    (g : G) (hc : 0 < ρ g) (l : ℕ → G) (I : K) (hlim : Tendsto (fun L => ρ (l L)) atTop (𝓝 I)) :
    (ρ '' sequenceLowerSetNecSuf le l).Nonempty ∧ IsLUB (ρ '' sequenceLowerSetNecSuf le l) I := by
  -- 上から
  have hupper : I ∈ upperBounds (ρ '' sequenceLowerSetNecSuf le l) := by
    rintro _ ⟨μ, ⟨ε, hε0, -, N, -, hN⟩, rfl⟩
    have h0 : le (0 + μ) (ε + μ) := hadd 0 ε hε0 μ
    have hbound : ∀ L : ℕ, N ≤ L → ρ μ ≤ ρ (l L) := fun L hL =>
      calc
        ρ μ = ρ (0 + μ) := by rw [zero_add]
        _ ≤ ρ (ε + μ) := hmono _ _ h0
        _ = ρ (μ + ε) := by rw [add_comm]
        _ ≤ ρ (l L) := hmono _ _ (hN L hL)
    exact ge_of_tendsto hlim (eventually_atTop.2 ⟨N, hbound⟩)
  -- 下から
  have hlower : ∀ b : K, b < I → ∃ μ ∈ sequenceLowerSetNecSuf le l, b < ρ μ := by
    intro b hb
    have hbc : b / ρ g < I / ρ g := div_lt_div_of_pos_right hb hc
    obtain ⟨r, hr1, hr2⟩ := exists_rat_btwn hbc
    obtain ⟨r', hr'1, hr'2⟩ := exists_rat_btwn hr2
    set s : ℚ := r' - r with hsdef
    have hs : 0 < s := sub_pos.mpr (Rat.cast_lt.mp hr'1)
    have hμ : b < ρ (r • g) :=
      calc
        b = (b / ρ g) * ρ g := (div_mul_cancel₀ b (ne_of_gt hc)).symm
        _ < (r : K) * ρ g := mul_lt_mul_of_pos_right hr1 hc
        _ = ρ (r • g) := (hsmul r g).symm
    have hμε : ρ (r • g + s • g) < I :=
      calc
        ρ (r • g + s • g) = ρ ((r + s) • g) := by rw [add_smul]
        _ = ((r + s : ℚ) : K) * ρ g := hsmul _ _
        _ = (r' : K) * ρ g := by rw [hsdef, add_sub_cancel]
        _ < (I / ρ g) * ρ g := mul_lt_mul_of_pos_right hr'2 hc
        _ = I := div_mul_cancel₀ I (ne_of_gt hc)
    have hε : ρ 0 < ρ (s • g) :=
      calc
        ρ 0 = 0 := realize_zero_necSuf ρ hsmul
        _ < (s : K) * ρ g := mul_pos (Rat.cast_pos.mpr hs) hc
        _ = ρ (s • g) := (hsmul s g).symm
    have hε0 : le 0 (s • g) := le_of_realize_lt_necSuf le htotal ρ hmono hε
    have hεne : s • g ≠ 0 := by
      intro h
      rw [h] at hε
      exact lt_irrefl _ hε
    obtain ⟨N, hN⟩ := eventually_atTop.1 (hlim.eventually (lt_mem_nhds hμε))
    refine ⟨r • g, ⟨s • g, hε0, hεne, max N 1, le_max_right N 1, fun L hL => ?_⟩, hμ⟩
    exact le_of_realize_lt_necSuf le htotal ρ hmono (hN L (le_trans (le_max_left N 1) hL))
  -- 最小上界と空でないこと
  have hleast : I ∈ lowerBounds (upperBounds (ρ '' sequenceLowerSetNecSuf le l)) := by
    intro b hb
    by_contra hbI
    obtain ⟨μ, hμ, hbμ⟩ := hlower b (lt_of_not_ge hbI)
    exact absurd (hb ⟨μ, hμ, rfl⟩) (not_le.mpr hbμ)
  obtain ⟨μ, hμ, -⟩ := hlower (I - 1) (sub_one_lt I)
  exact ⟨⟨ρ μ, μ, hμ, rfl⟩, hupper, hleast⟩

end Ising2DLambda.NecSuf.RealEscape
