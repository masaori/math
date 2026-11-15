/-
「有理点での四つの符号付き偶部分グラフ多項式の符号」（`claim_signed_even_subgraph_rational_sign`）の
具体版のうち、モード `(1,1)` の所属の段。因子の符号の段と積の符号の合成は別のファイルで行う。

  人手証明                                                    このファイル
  `(1,1) ∈ 𝒰_a × 𝒲_b ⟺ 1^L = (−1)^a かつ 1^L = (−1)^b`         `horizontalTwistedModes`・`verticalTwistedModes` の定義
                  `⟺ 1 = (−1)^a かつ 1 = (−1)^b`（`1^L = 1`）
                  `⟺ (a,b) = (0,0)`（`(−1)^1 = −1 ≠ 1`）        `oneOne_mem_twistedModes_iff`
  `1⁻¹ = 1` なので `O(1,1) = {(1,1)}`                         `modeInversionOrbit_one_one`
  `(1,1) ∈ O(ϖ,ς)` なら `ϖ = 1` かつ `ς = 1`                    `eq_one_one_of_one_one_mem_modeInversionOrbit`
  `{(1,1)}` の形の一元軌道は `(a,b) = (0,0)` のときただ一つ      `oneElementOrbits_filter_one_one`

Lean の軌道の因子 `F_O` は代表元 `orbitRepresentative O` で場合を分けるので、最後の主張は
「一元軌道のうち代表元が `(1,1)` のものの集合」で述べる。`O ∈ 𝔐` の代表元は `O` に属するので、
代表元が `(1,1)` であることと `O = {(1,1)}` は同値である（`orbitRepresentative_eq_one_one_iff`）。

必要十分版の定理・定義は使わない。住処は Qbar と有限集合。実数体・複素数体は現れない。
-/
import Ising2DLambda.KacWard.SignedEvenSubgraphOrbitProductSquare

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Classical

/-- `(−1)^1 = −1 ≠ 1`（`Qbar` で `2 ≠ 0`）。 -/
theorem qbar_one_ne_neg_one : (1 : Qbar) ≠ -1 := by
  intro h
  have h2 : (2 : Qbar) = 0 := by linear_combination h
  exact two_ne_zero h2

/-- `1 = (−1)^a ⟺ a = 0`（`Bool.false` が本文の 0）。 -/
theorem one_eq_twistSign_iff (a : Bool) : ((1 : Qbar) = if a then -1 else 1) ↔ a = false := by
  cases a
  · simp
  · simp [qbar_one_ne_neg_one]

/-- 本文の三行: `(1,1) ∈ 𝒰_a × 𝒲_b ⟺ (a,b) = (0,0)`。 -/
theorem oneOne_mem_twistedModes_iff (L : ℕ) (s : SpinStructure) :
    ((1 : Qbar) ∈ horizontalTwistedModes L s ∧ (1 : Qbar) ∈ verticalTwistedModes L s) ↔
      s = (false, false) := by
  calc ((1 : Qbar) ∈ horizontalTwistedModes L s ∧ (1 : Qbar) ∈ verticalTwistedModes L s)
      ↔ ((1 : Qbar) ^ L = (if s.1 then -1 else 1) ∧ (1 : Qbar) ^ L = (if s.2 then -1 else 1)) :=
        -- `def_horizontal_twisted_modes`・`def_vertical_twisted_modes`
        Iff.rfl
    _ ↔ ((1 : Qbar) = (if s.1 then -1 else 1) ∧ (1 : Qbar) = (if s.2 then -1 else 1)) := by
        -- `1^L = 1`
        rw [one_pow]
    _ ↔ (s.1 = false ∧ s.2 = false) := by
        -- `(−1)^0 = 1`、`(−1)^1 = −1 ≠ 1`
        rw [one_eq_twistSign_iff, one_eq_twistSign_iff]
    _ ↔ s = (false, false) := by
        -- `def_spin_structures`（`𝒮 = {0,1} × {0,1}`）
        obtain ⟨a, b⟩ := s
        exact Prod.mk_inj.symm

/-- `1⁻¹ = 1` なので `O(1,1) = {(1,1)}`。 -/
theorem modeInversionOrbit_one_one : modeInversionOrbit 1 1 = {((1 : Qbar), (1 : Qbar))} := by
  simp [modeInversionOrbit, inv_one]

/-- `1 ∈ {z, z⁻¹}` なら `z = 1`（`z⁻¹ = 1` なら `z = 1⁻¹ = 1`）。 -/
theorem eq_one_of_one_mem_inversionPair {z : Qbar} (h : (1 : Qbar) ∈ ({z, z⁻¹} : Finset Qbar)) :
    z = 1 := by
  simp only [Finset.mem_insert, Finset.mem_singleton] at h
  rcases h with h | h
  · exact h.symm
  · calc z = (z⁻¹)⁻¹ := (inv_inv z).symm
      _ = (1 : Qbar)⁻¹ := by rw [← h]
      _ = 1 := inv_one

/-- `(1,1) ∈ O(ϖ,ς)` なら `ϖ = 1` かつ `ς = 1`（`O` の定義から `1 ∈ {ϖ,ϖ⁻¹}` かつ `1 ∈ {ς,ς⁻¹}`）。 -/
theorem eq_one_one_of_one_one_mem_modeInversionOrbit {varpi varsigma : Qbar}
    (h : ((1 : Qbar), (1 : Qbar)) ∈ modeInversionOrbit varpi varsigma) :
    varpi = 1 ∧ varsigma = 1 := by
  rw [modeInversionOrbit_eq_product, Finset.mem_product] at h
  exact ⟨eq_one_of_one_mem_inversionPair h.1, eq_one_of_one_mem_inversionPair h.2⟩

/-- `{(1,1)} ∈ 𝔐^{a,b}_L ⟺ (a,b) = (0,0)`。 -/
theorem singleton_one_one_mem_modeInversionOrbits_iff (L : ℕ) [NeZero L] (s : SpinStructure) :
    ({((1 : Qbar), (1 : Qbar))} : Finset (Qbar × Qbar)) ∈ modeInversionOrbits L s ↔
      s = (false, false) := by
  rw [← oneOne_mem_twistedModes_iff L s]
  constructor
  · intro h
    obtain ⟨m, hm⟩ := mem_modeInversionOrbits h
    -- `(1,1) ∈ O(m)` から `m = (1,1)`
    have hmem : ((1 : Qbar), (1 : Qbar)) ∈ modeInversionOrbit m.1.1 m.1.2 := by
      rw [hm]
      exact Finset.mem_singleton_self _
    obtain ⟨h1, h2⟩ := eq_one_one_of_one_one_mem_modeInversionOrbit hmem
    obtain ⟨hU, hW⟩ := m.2
    exact ⟨h1 ▸ hU, h2 ▸ hW⟩
  · intro h
    -- `m := (1,1) ∈ 𝒦` の軌道は `O(1,1) = {(1,1)}`
    refine Finset.mem_image.mpr ⟨⟨((1 : Qbar), (1 : Qbar)), h⟩, Finset.mem_univ _, ?_⟩
    exact modeInversionOrbit_one_one

/-- 空でない有限集合の代表元はその集合に属する。 -/
theorem orbitRepresentative_mem {O : Finset (Qbar × Qbar)} (hne : O.Nonempty) :
    orbitRepresentative O ∈ O := by
  rw [orbitRepresentative, dif_pos hne]
  exact hne.choose_spec

/-- `O ∈ 𝔐` の代表元が `(1,1)` であることと `O = {(1,1)}` は同値である。 -/
theorem orbitRepresentative_eq_one_one_iff {L : ℕ} [NeZero L] {s : SpinStructure}
    {O : Finset (Qbar × Qbar)} (hO : O ∈ modeInversionOrbits L s) :
    orbitRepresentative O = ((1 : Qbar), (1 : Qbar)) ↔ O = {((1 : Qbar), (1 : Qbar))} := by
  obtain ⟨m, rfl⟩ := mem_modeInversionOrbits hO
  have hne : (modeInversionOrbit m.1.1 m.1.2).Nonempty :=
    ⟨_, mem_modeInversionOrbit_self m.1.1 m.1.2⟩
  constructor
  · intro h
    -- 代表元 `(1,1)` は `O(m)` に属するので `m = (1,1)`、よって `O(m) = O(1,1) = {(1,1)}`
    have hmem := orbitRepresentative_mem hne
    rw [h] at hmem
    obtain ⟨h1, h2⟩ := eq_one_one_of_one_one_mem_modeInversionOrbit hmem
    rw [h1, h2, modeInversionOrbit_one_one]
  · intro h
    have hmem := orbitRepresentative_mem hne
    rw [h] at hmem ⊢
    exact Finset.mem_singleton.mp hmem

/-- 本文「`{(1,1)}` の形の一元軌道は、`(a,b) = (0,0)` のとき `𝔐^{0,0}_L` にただ一つ属し、
それ以外のときは属さない」: 一元軌道のうち代表元が `(1,1)` のものの集合は、
`(a,b) = (0,0)` なら `{{(1,1)}}`、それ以外なら空集合である。 -/
theorem oneElementOrbits_filter_one_one (L : ℕ) [NeZero L] (s : SpinStructure) :
    ((modeInversionOrbits L s).filter (fun O => O.card = 1)).filter
        (fun O => orbitRepresentative O = ((1 : Qbar), (1 : Qbar))) =
      if s = (false, false) then {{((1 : Qbar), (1 : Qbar))}} else ∅ := by
  ext O
  simp only [Finset.mem_filter]
  constructor
  · rintro ⟨⟨hO, -⟩, hrep⟩
    have hO1 := (orbitRepresentative_eq_one_one_iff hO).mp hrep
    have hs := (singleton_one_one_mem_modeInversionOrbits_iff L s).mp (hO1 ▸ hO)
    rw [if_pos hs, hO1]
    exact Finset.mem_singleton_self _
  · intro h
    by_cases hs : s = (false, false)
    · rw [if_pos hs, Finset.mem_singleton] at h
      have hO : O ∈ modeInversionOrbits L s :=
        h ▸ (singleton_one_one_mem_modeInversionOrbits_iff L s).mpr hs
      exact ⟨⟨hO, h ▸ Finset.card_singleton _⟩, (orbitRepresentative_eq_one_one_iff hO).mpr h⟩
    · rw [if_neg hs] at h
      exact absurd h (Finset.notMem_empty O)

end Ising2DLambda.KacWard
