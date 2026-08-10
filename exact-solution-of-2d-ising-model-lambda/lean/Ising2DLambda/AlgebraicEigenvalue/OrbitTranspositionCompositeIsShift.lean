/-
章「固有値の代数性」の主張
「巡回シフトの制限は軌道の元の個数より 1 つ少ない個数の互換の合成である」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_orbit_transposition_composite_is_shift`）に対応する。

  人手証明                                              このファイル
  準備（|O| = e(τ₀)、e ≥ 1）                            hcard / hepos
  τ ∈ O を τ = S^[r](τ₀)（r < e）の形に直す段           hr / hτval
  r < e-1 の場合と r = e-1 の場合                       rcases Nat.lt_or_ge r (e-1)
  主張（Ψ_{|O|-1} = S↾_O）                              orbitTranspositionComposite_eq_rowShiftRestriction

人手証明どおり、2 つの写像が各点で同じ値を取ることを示す。値の計算には前のセクションの
`orbitTranspositionComposite_apply_rowShiftIterate`（互換の反復合成が基点の反復に与える値）を
`k = e-1` と取って当てる。

住処: 人手証明のこのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは行配位とその部分集合、その上の写像と相等、および ℕ だけ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionCompositeValues
import Ising2DLambda.AlgebraicEigenvalue.OrbitBijectionIdOrShift

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の主張。`Ψ^{O,τ₀}_{|O|-1} = S↾_O` である。

人手証明どおり、まず `|O| = e(τ₀)` を出し（軌道の元の個数は最小周期に等しい）、
そのうえで各点 `τ ∈ O` を `τ = S^[r](τ₀)`（`r < e`）の形に直して
`r < e-1` と `r = e-1` の 2 つの場合に分ける。 -/
theorem orbitTranspositionComposite_eq_rowShiftRestriction {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) {τ₀ : RowConfig L} (hτ₀ : τ₀ ∈ O) :
    orbitTranspositionComposite hO hτ₀ (O.card - 1)
      = fun τ => shiftOrbitRestriction ⟨O, hO⟩ τ := by
  classical
  -- 準備。O(τ₀) = O なので |O| = |O(τ₀)| = e(τ₀) であり、e(τ₀) ≥ 1 である。
  have hOorb : rowShiftOrbit L τ₀ = O := rowShiftOrbit_eq_of_mem_orbitSet hO hτ₀
  have hcard : O.card = rowShiftMinimalPeriod L τ₀ := by
    rw [← hOorb]; exact card_rowShiftOrbit L τ₀
  have hepos : 1 ≤ rowShiftMinimalPeriod L τ₀ := rowShiftMinimalPeriod_pos τ₀
  funext τ
  apply Subtype.ext
  rw [shiftOrbitRestriction_val]
  -- τ ∈ O = O(τ₀) なので τ = S^[k](τ₀) と書ける。
  have hτmem : τ.1 ∈ rowShiftOrbit L τ₀ := by rw [hOorb]; exact τ.2
  obtain ⟨k, hk⟩ := mem_rowShiftOrbit.mp hτmem
  -- 自然数の除法で k = e q + r（r < e）と書き直す。
  have hmul : rowShiftIterate L (rowShiftMinimalPeriod L τ₀ * (k / rowShiftMinimalPeriod L τ₀)) τ₀
      = τ₀ := rowShiftIterate_mul τ₀ (rowShiftIterate_minimalPeriod τ₀) _
  have hr : k % rowShiftMinimalPeriod L τ₀ < rowShiftMinimalPeriod L τ₀ :=
    Nat.mod_lt k hepos
  have hkr : rowShiftIterate L (k % rowShiftMinimalPeriod L τ₀) τ₀ = rowShiftIterate L k τ₀ := by
    conv_rhs => rw [← Nat.mod_add_div k (rowShiftMinimalPeriod L τ₀)]
    rw [rowShiftIterate_add, hmul]
  have hτval : τ.1 = rowShiftIterate L (k % rowShiftMinimalPeriod L τ₀) τ₀ := by
    rw [hkr, ← hk]
  have hsub : τ = ⟨rowShiftIterate L (k % rowShiftMinimalPeriod L τ₀) τ₀,
      rowShiftIterate_mem_of_mem_orbitSet hO hτ₀ _⟩ := Subtype.ext hτval
  rw [hsub, hcard]
  -- 前のセクションの値の記述を k = e-1 と取って当てる。
  rw [orbitTranspositionComposite_apply_rowShiftIterate hO hτ₀ (by omega) hr]
  -- 右辺は S(S^[r](τ₀)) = S^[r+1](τ₀) である（S^[k+1] = S ∘ S^[k]）。
  show _ = rowShiftIterate L (k % rowShiftMinimalPeriod L τ₀ + 1) τ₀
  rcases Nat.lt_or_ge (k % rowShiftMinimalPeriod L τ₀) (rowShiftMinimalPeriod L τ₀ - 1) with
    hlt | hge
  · -- r < e-1 の場合。値はそのまま S^[r+1](τ₀) である。
    rw [if_pos hlt]
  · -- r = e-1 の場合。τ₀ = S^[e](τ₀) = S^[r+1](τ₀) である。
    have hrn : k % rowShiftMinimalPeriod L τ₀ = rowShiftMinimalPeriod L τ₀ - 1 := by omega
    have hsucc : k % rowShiftMinimalPeriod L τ₀ + 1 = rowShiftMinimalPeriod L τ₀ := by omega
    rw [if_neg (Nat.not_lt.mpr hge), if_pos hrn, hsucc, rowShiftIterate_minimalPeriod]

end Ising2DLambda.AlgebraicEigenvalue
