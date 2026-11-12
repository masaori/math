/-
「逆元操作のモード軌道は一元・二元・四元のいずれかである」（`claim_mode_inversion_orbit_cardinality`）の具体版。

本文と同じ順に次を示す。必要十分版を呼ばない。
- 四点がモード集合に属すること: `claim_dispersion_inversion_invariant` の具体版から `ϖ⁻¹ ∈ 𝒰_a`、`ς⁻¹ ∈ 𝒲_b`。
- `z = z⁻¹` の同値の四行: `z·z = z·z⁻¹`（`z ≠ 0` で `z` を掛ける操作は単射）、`z² = 1`（`z·z⁻¹ = 1`）、
  `(z−1)(z+1) = 0`（分配律）、`z ∈ {1,−1}`（整域）。`z ≠ 0` は同主張の証明の三行（`twistedMode_ne_zero`）。
- `n(z) := |{z, z⁻¹}|` の場合分け（`z = z⁻¹` なら一、そうでなければ二）。
- 元数の三行: `|O| = |{ϖ,ϖ⁻¹} × {ς,ς⁻¹}| = |{ϖ,ϖ⁻¹}|·|{ς,ς⁻¹}| = n(ϖ)·n(ς)`。
- 四通りの積から `|O| ∈ {1,2,4}`、および `|O| = 1` の同値の四行。

住処は Qbar と ℕ。実数体・複素数体は使わない。
-/
import Ising2DLambda.KacWard.DispersionInversionInvariant

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Classical

/-- 逆元操作が作る軌道 `O(ϖ,ς) := {(ϖ,ς), (ϖ⁻¹,ς), (ϖ,ς⁻¹), (ϖ⁻¹,ς⁻¹)}`。 -/
noncomputable def modeInversionOrbit (varpi varsigma : Qbar) : Finset (Qbar × Qbar) :=
  {(varpi, varsigma), (varpi⁻¹, varsigma), (varpi, varsigma⁻¹), (varpi⁻¹, varsigma⁻¹)}

/-- `n(z) := |{z, z⁻¹}|`。 -/
noncomputable def modeInversionPairCard (z : Qbar) : ℕ := ({z, z⁻¹} : Finset Qbar).card

/-- 本文の同値の四行: `z ≠ 0` なら `z = z⁻¹ ↔ z ∈ {1, −1}`。 -/
theorem mode_eq_inv_iff {z : Qbar} (hz : z ≠ 0) : z = z⁻¹ ↔ z = 1 ∨ z = -1 := by
  calc z = z⁻¹ ↔ z * z = z * z⁻¹ := (mul_right_injective₀ hz).eq_iff.symm
    _ ↔ z ^ 2 = 1 := by rw [mul_inv_cancel₀ hz, sq]
    _ ↔ (z - 1) * (z + 1) = 0 := by
        constructor <;> intro h <;> linear_combination h
    _ ↔ z = 1 ∨ z = -1 := by rw [mul_eq_zero, sub_eq_zero, add_eq_zero_iff_eq_neg]

/-- `n(z)` の場合分け: `z = z⁻¹` なら一、そうでなければ二。 -/
theorem modeInversionPairCard_cases (z : Qbar) :
    (z = z⁻¹ ∧ modeInversionPairCard z = 1) ∨ (z ≠ z⁻¹ ∧ modeInversionPairCard z = 2) := by
  by_cases h : z = z⁻¹
  · left
    refine ⟨h, ?_⟩
    unfold modeInversionPairCard
    rw [← h, Finset.insert_eq_of_mem (Finset.mem_singleton_self z), Finset.card_singleton]
  · right
    refine ⟨h, ?_⟩
    unfold modeInversionPairCard
    exact Finset.card_pair h

/-- 軌道は二つの二元集合の直積である（`O` の定義）。 -/
theorem modeInversionOrbit_eq_product (varpi varsigma : Qbar) :
    modeInversionOrbit varpi varsigma =
      ({varpi, varpi⁻¹} : Finset Qbar) ×ˢ ({varsigma, varsigma⁻¹} : Finset Qbar) := by
  ext ⟨u, v⟩
  simp only [modeInversionOrbit, Finset.mem_insert, Finset.mem_singleton, Finset.mem_product,
    Prod.mk.injEq]
  tauto

/-- 本文の元数の三行: `|O| = |{ϖ,ϖ⁻¹} × {ς,ς⁻¹}| = |{ϖ,ϖ⁻¹}|·|{ς,ς⁻¹}| = n(ϖ)·n(ς)`。 -/
theorem modeInversionOrbit_card (varpi varsigma : Qbar) :
    (modeInversionOrbit varpi varsigma).card =
      modeInversionPairCard varpi * modeInversionPairCard varsigma := by
  calc (modeInversionOrbit varpi varsigma).card
      = (({varpi, varpi⁻¹} : Finset Qbar) ×ˢ ({varsigma, varsigma⁻¹} : Finset Qbar)).card := by
        rw [modeInversionOrbit_eq_product]
    _ = ({varpi, varpi⁻¹} : Finset Qbar).card * ({varsigma, varsigma⁻¹} : Finset Qbar).card :=
        Finset.card_product _ _
    _ = modeInversionPairCard varpi * modeInversionPairCard varsigma := rfl

/-- 本文の四通り: `n, n' ∈ {1, 2}` なら `n·n' ∈ {1, 2, 4}`、かつ `n·n' = 1 ↔ n = 1 ∧ n' = 1`。 -/
theorem pairCard_product_cases {n n' : ℕ} (hn : n = 1 ∨ n = 2) (hn' : n' = 1 ∨ n' = 2) :
    (n * n' = 1 ∨ n * n' = 2 ∨ n * n' = 4) ∧ (n * n' = 1 ↔ n = 1 ∧ n' = 1) := by
  rcases hn with rfl | rfl <;> rcases hn' with rfl | rfl <;> decide

/-- 主張: 軌道の四点はモード集合に属し、軌道の元数は一・二・四のいずれかで、
一元であることと `ϖ, ς ∈ {1, −1}` は同値である。 -/
theorem mode_inversion_orbit_cardinality {L : ℕ} (hL : 1 ≤ L) (s : SpinStructure)
    {varpi varsigma : Qbar} (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s) :
    (∀ m ∈ modeInversionOrbit varpi varsigma,
        m.1 ∈ horizontalTwistedModes L s ∧ m.2 ∈ verticalTwistedModes L s) ∧
      ((modeInversionOrbit varpi varsigma).card = 1 ∨
        (modeInversionOrbit varpi varsigma).card = 2 ∨
        (modeInversionOrbit varpi varsigma).card = 4) ∧
      ((modeInversionOrbit varpi varsigma).card = 1 ↔
        (varpi = 1 ∨ varpi = -1) ∧ (varsigma = 1 ∨ varsigma = -1)) := by
  obtain ⟨hvarpiInv, hvarsigmaInv, -, -⟩ := dispersion_inversion_invariant hL s hvarpi hvarsigma
  have hvarpi0 : varpi ≠ 0 := twistedMode_ne_zero hL s.1 varpi hvarpi
  have hvarsigma0 : varsigma ≠ 0 := twistedMode_ne_zero hL s.2 varsigma hvarsigma
  have hn : modeInversionPairCard varpi = 1 ∨ modeInversionPairCard varpi = 2 := by
    rcases modeInversionPairCard_cases varpi with h | h
    · exact Or.inl h.2
    · exact Or.inr h.2
  have hn' : modeInversionPairCard varsigma = 1 ∨ modeInversionPairCard varsigma = 2 := by
    rcases modeInversionPairCard_cases varsigma with h | h
    · exact Or.inl h.2
    · exact Or.inr h.2
  -- `n(z) = 1 ↔ z = z⁻¹`（`n` の場合分け）
  have hone : ∀ z : Qbar, modeInversionPairCard z = 1 ↔ z = z⁻¹ := by
    intro z
    rcases modeInversionPairCard_cases z with h | h
    · exact ⟨fun _ => h.1, fun _ => h.2⟩
    · exact ⟨fun h1 => absurd (h.2.symm.trans h1) (by decide), fun h1 => absurd h1 h.1⟩
  obtain ⟨hcases, hprod⟩ := pairCard_product_cases hn hn'
  refine ⟨?_, ?_, ?_⟩
  · intro m hm
    rw [modeInversionOrbit_eq_product, Finset.mem_product] at hm
    obtain ⟨h1, h2⟩ := hm
    simp only [Finset.mem_insert, Finset.mem_singleton] at h1 h2
    refine ⟨?_, ?_⟩
    · rcases h1 with h | h <;> rw [h]
      · exact hvarpi
      · exact hvarpiInv
    · rcases h2 with h | h <;> rw [h]
      · exact hvarsigma
      · exact hvarsigmaInv
  · rw [modeInversionOrbit_card]
    exact hcases
  · calc (modeInversionOrbit varpi varsigma).card = 1
        ↔ modeInversionPairCard varpi * modeInversionPairCard varsigma = 1 := by
          rw [modeInversionOrbit_card]
      _ ↔ modeInversionPairCard varpi = 1 ∧ modeInversionPairCard varsigma = 1 := hprod
      _ ↔ varpi = varpi⁻¹ ∧ varsigma = varsigma⁻¹ := by rw [hone, hone]
      _ ↔ (varpi = 1 ∨ varpi = -1) ∧ (varsigma = 1 ∨ varsigma = -1) := by
          rw [mode_eq_inv_iff hvarpi0, mode_eq_inv_iff hvarsigma0]

end Ising2DLambda.KacWard
