/-
人手証明「対数順序群の順序」（`def_log_order_group_order`）と
「対数順序群の順序は線形順序である」（`claim_log_order_group_linear_order`）の具体版。

λ ≤_Λ μ :⟺ rat_Λ(λ) ≤ rat_Λ(μ)（ℚ の順序）と定め、反射律・推移律・全順序性は ℚ の同名の性質へ
落とす。反対称律だけは ℚ の等号から λ = log(rat_Λ λ) = log(rat_Λ μ) = μ で Λ の等号へ戻す
（`logRat_rationalOfLog` を二度）。判定は有理数の比較なので決定可能である。

住処: ℕ・ℤ・ℚ・Λ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.RationalLogSurjective
import Mathlib

namespace Ising2DLambda.FreeEntropy

/-- `def_log_order_group_order`。正の有理数の比較を `rat_Λ` で引き戻した関係。 -/
def logOrderLE (l m : LogOrderGroup) : Prop := rationalOfLog l ≤ rationalOfLog m

/-- 判定は二つの有理数の比較で決まる。 -/
noncomputable instance : DecidableRel logOrderLE := fun l m =>
  inferInstanceAs (Decidable (rationalOfLog l ≤ rationalOfLog m))

/-- 反射律（ℚ の順序の反射律）。 -/
theorem logOrderLE_refl (l : LogOrderGroup) : logOrderLE l l := le_refl _

/-- 推移律（ℚ の順序の推移律）。 -/
theorem logOrderLE_trans {l m n : LogOrderGroup} (h1 : logOrderLE l m) (h2 : logOrderLE m n) :
    logOrderLE l n := le_trans h1 h2

/-- 反対称律。ℚ の反対称律で `rat_Λ l = rat_Λ m` を得てから、対数で `Λ` の等号へ戻す。 -/
theorem logOrderLE_antisymm {l m : LogOrderGroup} (h1 : logOrderLE l m) (h2 : logOrderLE m l) :
    l = m := by
  have hq : rationalOfLog l = rationalOfLog m := le_antisymm h1 h2
  calc
    l = logRat (rationalOfLog l) := (logRat_rationalOfLog l).symm
    _ = logRat (rationalOfLog m) := by rw [hq]
    _ = m := logRat_rationalOfLog m

/-- 全順序性（ℚ の順序の全順序性）。 -/
theorem logOrderLE_total (l m : LogOrderGroup) : logOrderLE l m ∨ logOrderLE m l :=
  le_total _ _

end Ising2DLambda.FreeEntropy
