/-
章「固有値の代数性」の「軌道の元が巡回シフトで動かないことと、その軌道の元の個数が 1 で
あることは同値である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_fixed_iff_card_one`）に対応する。

  人手証明                                     このファイル
  準備の第一 |O| = |O(τ)| = e(τ)                card_eq_period_of_mem
  準備の第二 S^[1](τ) = S(τ)                    rowShiftIterate_one
  S(τ) = τ ⟺ |O| = 1                            rowShift_eq_self_iff_card_orbit_eq_one

mathlib の `Function.minimalPeriod` / `Nat.dvd_one` は引いていない。使ったのは既に示した
`rowShiftOrbit_eq_of_mem`・`card_rowShiftOrbit`・`rowShiftIterate_eq_self_iff` だけである。

住処: 人手証明のこのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（点は行配位、個数と周期は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowShiftOrbitPartition

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

-- 準備の第二は `L ≥ 1` を使わない（反復の定義を 1 段展開するだけである）。
omit [NeZero L] in
/-- 人手証明の準備の第二「`S^[1](τ) = S(τ)`」。定義の展開だけである。 -/
theorem rowShiftIterate_one (τ : RowConfig L) :
    rowShiftIterate L 1 τ = rowShift L τ := rfl

/-- 人手証明の準備の第一「`τ ∈ O` かつ `O ∈ 𝒪_L` ならば `|O| = |O(τ)| = e(τ)`」。 -/
theorem card_eq_period_of_mem {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L)
    {τ : RowConfig L} (hmem : τ ∈ O) : O.card = rowShiftMinimalPeriod L τ := by
  obtain ⟨τ₁, hτ₁⟩ := mem_rowShiftOrbitSet.mp hO
  have horb : rowShiftOrbit L τ = O := by
    rw [← hτ₁] at hmem ⊢
    exact rowShiftOrbit_eq_of_mem τ₁ hmem
  rw [← horb, card_rowShiftOrbit]

/-- 人手証明の主張「軌道の元が巡回シフトで動かないことと、その軌道の元の個数が 1 で
あることは同値である」。

証明は人手証明どおり、準備 2 つを置いてから 2 つの向きを別々に示す。 -/
theorem rowShift_eq_self_iff_card_orbit_eq_one {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ : RowConfig L} (hmem : τ ∈ O) :
    rowShift L τ = τ ↔ O.card = 1 := by
  have hcard : O.card = rowShiftMinimalPeriod L τ := card_eq_period_of_mem hO hmem
  rw [hcard]
  constructor
  · -- 第一の向き。S(τ) = τ ならば e(τ) = 1。
    intro hfix
    have h1 : rowShiftIterate L 1 τ = τ := by rw [rowShiftIterate_one]; exact hfix
    have hdvd : rowShiftMinimalPeriod L τ ∣ 1 := (rowShiftIterate_eq_self_iff τ 1).mp h1
    obtain ⟨q, hq⟩ := hdvd
    have hpos : 1 ≤ rowShiftMinimalPeriod L τ := rowShiftMinimalPeriod_pos τ
    rcases Nat.lt_or_ge (rowShiftMinimalPeriod L τ) 2 with hlt | hge
    · omega
    · exfalso
      rcases Nat.eq_zero_or_pos q with rfl | hq1
      · simp at hq
      · have hmul : 2 * 1 ≤ rowShiftMinimalPeriod L τ * q := Nat.mul_le_mul hge hq1
        rw [← hq] at hmul
        omega
  · -- 第二の向き。e(τ) = 1 ならば S(τ) = τ。
    intro he
    have hdvd : rowShiftMinimalPeriod L τ ∣ 1 := ⟨1, by rw [he]⟩
    have h1 : rowShiftIterate L 1 τ = τ := (rowShiftIterate_eq_self_iff τ 1).mpr hdvd
    rw [← rowShiftIterate_one]
    exact h1

end Ising2DLambda.AlgebraicEigenvalue
