/-
章「固有値の代数性」の主張「軌道の上の巡回シフトの制限の符号は `(-1)^{|O|-1}` である」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_shift_restriction_sign`）に対応する。

  人手証明                                          このファイル
  準備（O は空でないので τ₀ ∈ O が取れる）          hne / obtain ⟨τ₀, hτ₀⟩
  準備（|O| = e(τ₀)、e(τ₀) ≥ 1、|O|-1 < e(τ₀)）     hcard / hepos / hlt
  第 1 の等号（Ψ_{|O|-1} = S↾_O を右辺から左辺へ）   hval / orbitPermSign_congr
  第 2 の等号（反復合成の符号が (-1)^k）             ambientComposite_sign
  主張（sgn_O(S↾_O) = (-1)^{|O|-1}）                shiftOrbitRestriction_sign

`orbitPermSign` は ambient の写像を受けるので、人手証明の `S↾_O : O → O` は ambient の
`rowShift L` として渡す（`shiftOrbitRestriction_val` がこの 2 つの値の一致である）。
第 1 の等号は、人手証明の写像としての等式を `O` の上での値の一致へ落としてから
`orbitPermSign_congr`（符号が `O` の中の値だけで決まること）で移す。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは個数（ℕ）と符号（ℤ）だけである）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionCompositeSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張。`sgn_O(S↾_O) = (-1)^{|O|-1}` である。

人手証明どおり、`O` が空でないことから基点 `τ₀ ∈ O` を取り、`|O| = e(τ₀)` と `e(τ₀) ≥ 1` から
`|O|-1 < e(τ₀)` を出したうえで、`Ψ^{O,τ₀}_{|O|-1} = S↾_O` と反復合成の符号の値をつなぐ。 -/
theorem shiftOrbitRestriction_sign {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) :
    orbitPermSign L O (rowShift L) = (-1) ^ (O.card - 1) := by
  classical
  -- 準備。O は空でないので基点 τ₀ ∈ O が取れる。
  obtain ⟨τ₁, hτ₁⟩ := mem_rowShiftOrbitSet.mp hO
  have hτ₀ : τ₁ ∈ O := hτ₁ ▸ self_mem_rowShiftOrbit τ₁
  -- 準備。O(τ₁) = O なので |O| = |O(τ₁)| = e(τ₁) であり、e(τ₁) ≥ 1 である。
  have hcard : O.card = rowShiftMinimalPeriod L τ₁ := by
    rw [← hτ₁]; exact card_rowShiftOrbit L τ₁
  have hepos : 1 ≤ rowShiftMinimalPeriod L τ₁ := rowShiftMinimalPeriod_pos τ₁
  have hlt : O.card - 1 < rowShiftMinimalPeriod L τ₁ := by omega
  -- 第 1 の等号。Ψ_{|O|-1} = S↾_O を O の上での値の一致へ落とす。
  have hval : ∀ τ ∈ O, rowShift L τ = ambientComposite L τ₁ (O.card - 1) τ := by
    intro τ hτ
    have h := congrFun (orbitTranspositionComposite_eq_rowShiftRestriction hO hτ₀)
      (⟨τ, hτ⟩ : {τ : RowConfig L // τ ∈ O})
    have h₁ : (orbitTranspositionComposite hO hτ₀ (O.card - 1) ⟨τ, hτ⟩).1
        = rowShift L τ := by
      rw [h]; exact shiftOrbitRestriction_val ⟨O, hO⟩ ⟨τ, hτ⟩
    rw [← h₁]
    exact ambientComposite_val hO hτ₀ (O.card - 1) ⟨τ, hτ⟩
  calc orbitPermSign L O (rowShift L)
      = orbitPermSign L O (ambientComposite L τ₁ (O.card - 1)) := orbitPermSign_congr hval
    _ = (-1) ^ (O.card - 1) := ambientComposite_sign hO hτ₀ (O.card - 1) hlt

end Ising2DLambda.AlgebraicEigenvalue
