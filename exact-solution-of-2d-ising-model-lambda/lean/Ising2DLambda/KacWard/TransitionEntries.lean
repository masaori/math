/-
章「トーラス上の Kac--Ward 行列式」の「遷移行列の成分は零か 1 の 8 乗根である」
（`claim_transition_entries_in_mu8`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                      このファイル
  代数的数の全体 Qbar と μ₈                     `Qbar` / `RootOfUnity 8`
  ζ₈⁴ = -1（`def_rotation_phase` の約束）        仮定 `hz : z ^ 4 = -1`
  ねじれ符号 ε ∈ {-1, 1}                        仮定 `hs : s = 1 ∨ s = -1`
  回転位相 ρ ∈ {1, ζ₈, ζ₈⁻¹}                    仮定 `hr : r = 1 ∨ r = z ∨ r = z⁻¹`
  (ε ρ)⁸ = ρ⁸ の鎖と三つの場合                   `signed_phase_pow_eight` と同じ手順

成分が 0 の場合は定義の場合分けそのものなので、非零成分（第二の場合）を形式化する。
住処: 人手証明のこのブロックは Qbar を宣言している。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.KacWard.TransitionEntries

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の第二の場合。ねじれ符号と回転位相の積は μ₈ に属する。 -/
theorem transitionEntry_mem_mu8 {z s r : Qbar} (hz : z ^ 4 = -1)
    (hs : s = 1 ∨ s = -1) (hr : r = 1 ∨ r = z ∨ r = z⁻¹) :
    s * r ∈ RootOfUnity 8 := by
  rw [mem_rootOfUnity]
  -- ε ∈ {-1, 1} から ε² = 1 を出す（(-1)² = 1² = 1）。
  have hs2 : s ^ 2 = 1 := by
    rcases hs with h1 | hneg
    · rw [h1, one_pow]
    · rw [hneg]; exact neg_one_sq
  exact Ising2DLambda.NecSuf.KacWard.signed_phase_pow_eight hz hs2 hr

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem transitionEntry_mem_mu8_from_necSuf {z s r : Qbar} (hz : z ^ 4 = -1)
    (hs2 : s ^ 2 = 1) (hr : r = 1 ∨ r = z ∨ r = z⁻¹) :
    (s * r) ^ 8 = 1 :=
  Ising2DLambda.NecSuf.KacWard.signed_phase_pow_eight hz hs2 hr

end Ising2DLambda.KacWard
