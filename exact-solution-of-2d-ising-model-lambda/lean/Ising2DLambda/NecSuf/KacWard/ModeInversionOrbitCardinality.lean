/-
「逆元操作のモード軌道は一元・二元・四元のいずれかである」の必要十分版。

具体版と同じ手順（四点の所属、`z = z⁻¹` の同値の四行、`n(z)` の場合分け、元数の三行、
四通りの積と `|O| = 1` の同値）を、次の仮定だけで行う。

- 係数は可除環 `K`（乗法の可換性は使わない。`(z−1)(z+1) = z² − 1` は `z` と `1` の可換性だけで出る）。
  使うのは `z ≠ 0` での左からの約分、`z·z⁻¹ = 1`、零因子が無いこと、`(z⁻¹)^L = (z^L)⁻¹`。
- 有限集合の元数を数えるので `K` の等号の判定可能性。
- 符号 `t, t'` は `t·t = 1` だけを仮定する。`t ≠ 0` はこれと `K` の非自明性から出す。
- `L ≥ 1`。`L = 0` を許すと `z = 0` も `z^0 = 1 = t` を満たし、`0 = 0⁻¹` だが `0 ∉ {1,−1}` となって
  `|O| = 1` の同値が崩れる。

住処: 一般の代数系。実数体・複素数体は現れない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 逆元操作が作る軌道。 -/
def modeInversionOrbit {K : Type*} [DivisionRing K] [DecidableEq K] (varpi varsigma : K) :
    Finset (K × K) :=
  {(varpi, varsigma), (varpi⁻¹, varsigma), (varpi, varsigma⁻¹), (varpi⁻¹, varsigma⁻¹)}

/-- `n(z) := |{z, z⁻¹}|`。 -/
def modeInversionPairCard {K : Type*} [DivisionRing K] [DecidableEq K] (z : K) : ℕ :=
  ({z, z⁻¹} : Finset K).card

theorem mode_ne_zero_necSuf {K : Type*} [DivisionRing K] {L : ℕ} (hL : 1 ≤ L) (t z : K)
    (ht : t * t = 1) (hz : z ^ L = t) : z ≠ 0 := by
  intro h0
  apply left_ne_zero_of_mul_eq_one ht
  calc t = z ^ L := hz.symm
    _ = 0 ^ L := by rw [h0]
    _ = 0 := zero_pow (by omega)

theorem mode_inv_pow_necSuf {K : Type*} [DivisionRing K] (L : ℕ) (t z : K)
    (ht : t * t = 1) (hz : z ^ L = t) : z⁻¹ ^ L = t := by
  calc z⁻¹ ^ L = (z ^ L)⁻¹ := inv_pow z L
    _ = t⁻¹ := by rw [hz]
    _ = t := inv_eq_of_mul_eq_one_left ht

theorem mode_eq_inv_iff_necSuf {K : Type*} [DivisionRing K] {z : K} (hz : z ≠ 0) :
    z = z⁻¹ ↔ z = 1 ∨ z = -1 := by
  calc z = z⁻¹ ↔ z * z = z * z⁻¹ := (mul_right_injective₀ hz).eq_iff.symm
    _ ↔ z ^ 2 = 1 := by rw [mul_inv_cancel₀ hz, sq]
    _ ↔ (z - 1) * (z + 1) = 0 := by
        rw [sub_mul, mul_add, mul_add, mul_one, one_mul, mul_one, ← sq]
        constructor
        · intro h; rw [h]; abel
        · intro h
          have h' : z ^ 2 - 1 = 0 := by rw [← h]; abel
          exact sub_eq_zero.mp h'
    _ ↔ z = 1 ∨ z = -1 := by rw [mul_eq_zero, sub_eq_zero, add_eq_zero_iff_eq_neg]

theorem modeInversionPairCard_cases_necSuf {K : Type*} [DivisionRing K] [DecidableEq K] (z : K) :
    (z = z⁻¹ ∧ modeInversionPairCard z = 1) ∨ (z ≠ z⁻¹ ∧ modeInversionPairCard z = 2) := by
  by_cases h : z = z⁻¹
  · left
    refine ⟨h, ?_⟩
    unfold modeInversionPairCard
    rw [← h, Finset.insert_eq_of_mem (Finset.mem_singleton_self z), Finset.card_singleton]
  · right
    exact ⟨h, Finset.card_pair h⟩

theorem modeInversionOrbit_eq_product_necSuf {K : Type*} [DivisionRing K] [DecidableEq K]
    (varpi varsigma : K) :
    modeInversionOrbit varpi varsigma =
      ({varpi, varpi⁻¹} : Finset K) ×ˢ ({varsigma, varsigma⁻¹} : Finset K) := by
  ext ⟨u, v⟩
  simp only [modeInversionOrbit, Finset.mem_insert, Finset.mem_singleton, Finset.mem_product,
    Prod.mk.injEq]
  tauto

theorem modeInversionOrbit_card_necSuf {K : Type*} [DivisionRing K] [DecidableEq K]
    (varpi varsigma : K) :
    (modeInversionOrbit varpi varsigma).card =
      modeInversionPairCard varpi * modeInversionPairCard varsigma := by
  calc (modeInversionOrbit varpi varsigma).card
      = (({varpi, varpi⁻¹} : Finset K) ×ˢ ({varsigma, varsigma⁻¹} : Finset K)).card := by
        rw [modeInversionOrbit_eq_product_necSuf]
    _ = ({varpi, varpi⁻¹} : Finset K).card * ({varsigma, varsigma⁻¹} : Finset K).card :=
        Finset.card_product _ _
    _ = modeInversionPairCard varpi * modeInversionPairCard varsigma := rfl

theorem pairCard_product_cases_necSuf {n n' : ℕ} (hn : n = 1 ∨ n = 2) (hn' : n' = 1 ∨ n' = 2) :
    (n * n' = 1 ∨ n * n' = 2 ∨ n * n' = 4) ∧ (n * n' = 1 ↔ n = 1 ∧ n' = 1) := by
  rcases hn with rfl | rfl <;> rcases hn' with rfl | rfl <;> decide

/-- 可除環 `K`、`L ≥ 1`、`t·t = 1`・`t'·t' = 1` の符号について、具体版と同じ結論。 -/
theorem mode_inversion_orbit_cardinality_necSuf {K : Type*} [DivisionRing K] [DecidableEq K]
    {L : ℕ} (hL : 1 ≤ L) (t t' : K) (ht : t * t = 1) (ht' : t' * t' = 1)
    {varpi varsigma : K} (hvarpi : varpi ^ L = t) (hvarsigma : varsigma ^ L = t') :
    (∀ m ∈ modeInversionOrbit varpi varsigma, m.1 ^ L = t ∧ m.2 ^ L = t') ∧
      ((modeInversionOrbit varpi varsigma).card = 1 ∨
        (modeInversionOrbit varpi varsigma).card = 2 ∨
        (modeInversionOrbit varpi varsigma).card = 4) ∧
      ((modeInversionOrbit varpi varsigma).card = 1 ↔
        (varpi = 1 ∨ varpi = -1) ∧ (varsigma = 1 ∨ varsigma = -1)) := by
  have hvarpiInv := mode_inv_pow_necSuf L t varpi ht hvarpi
  have hvarsigmaInv := mode_inv_pow_necSuf L t' varsigma ht' hvarsigma
  have hvarpi0 : varpi ≠ 0 := mode_ne_zero_necSuf hL t varpi ht hvarpi
  have hvarsigma0 : varsigma ≠ 0 := mode_ne_zero_necSuf hL t' varsigma ht' hvarsigma
  have hn : modeInversionPairCard varpi = 1 ∨ modeInversionPairCard varpi = 2 := by
    rcases modeInversionPairCard_cases_necSuf varpi with h | h
    · exact Or.inl h.2
    · exact Or.inr h.2
  have hn' : modeInversionPairCard varsigma = 1 ∨ modeInversionPairCard varsigma = 2 := by
    rcases modeInversionPairCard_cases_necSuf varsigma with h | h
    · exact Or.inl h.2
    · exact Or.inr h.2
  have hone : ∀ z : K, modeInversionPairCard z = 1 ↔ z = z⁻¹ := by
    intro z
    rcases modeInversionPairCard_cases_necSuf z with h | h
    · exact ⟨fun _ => h.1, fun _ => h.2⟩
    · exact ⟨fun h1 => absurd (h.2.symm.trans h1) (by decide), fun h1 => absurd h1 h.1⟩
  obtain ⟨hcases, hprod⟩ := pairCard_product_cases_necSuf hn hn'
  refine ⟨?_, ?_, ?_⟩
  · intro m hm
    rw [modeInversionOrbit_eq_product_necSuf, Finset.mem_product] at hm
    obtain ⟨h1, h2⟩ := hm
    simp only [Finset.mem_insert, Finset.mem_singleton] at h1 h2
    refine ⟨?_, ?_⟩
    · rcases h1 with h | h <;> rw [h]
      · exact hvarpi
      · exact hvarpiInv
    · rcases h2 with h | h <;> rw [h]
      · exact hvarsigma
      · exact hvarsigmaInv
  · rw [modeInversionOrbit_card_necSuf]
    exact hcases
  · calc (modeInversionOrbit varpi varsigma).card = 1
        ↔ modeInversionPairCard varpi * modeInversionPairCard varsigma = 1 := by
          rw [modeInversionOrbit_card_necSuf]
      _ ↔ modeInversionPairCard varpi = 1 ∧ modeInversionPairCard varsigma = 1 := hprod
      _ ↔ varpi = varpi⁻¹ ∧ varsigma = varsigma⁻¹ := by rw [hone, hone]
      _ ↔ (varpi = 1 ∨ varpi = -1) ∧ (varsigma = 1 ∨ varsigma = -1) := by
          rw [mode_eq_inv_iff_necSuf hvarpi0, mode_eq_inv_iff_necSuf hvarsigma0]

end Ising2DLambda.NecSuf.KacWard
