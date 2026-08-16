/-
「対数順序群から有理係数の対数順序群への写像は加法を保ち単射である」の具体版が
必要十分版の特殊化として得られることを明示する。

添字型を素数、値の型を `ℤ` と `ℚ`、値ごとの写像を整数の有理数への読み替えに特殊化する。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroup
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroup

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

private theorem lift_spec :
    (∀ l m : LogOrderGroup, toRational (l + m) = toRational l + toRational m) ∧
    (∀ l m : LogOrderGroup, toRational l = toRational m → l = m) :=
  NecSuf.ThermodynamicLimit.pointwise_lift_add_and_injective_necSuf
    (fun n : ℤ => (n : ℚ)) (by simp) (fun a b => Int.cast_add a b)
    (fun a b h => Int.cast_injective h)

/-- 具体版（加法）を必要十分版から導いたもの。 -/
theorem toRational_add_from_necSuf (l m : LogOrderGroup) :
    toRational (l + m) = toRational l + toRational m :=
  lift_spec.1 l m

/-- 具体版（単射）を必要十分版から導いたもの。 -/
theorem toRational_injective_from_necSuf (l m : LogOrderGroup)
    (h : toRational l = toRational m) : l = m :=
  lift_spec.2 l m h

/-- 具体版（整数倍との交換 `n·ι(ν) = ι(nν)`）を必要十分版から導いたもの。
係数 `(n : ℚ)` の有理数倍は整数 `n` の `zsmul` と一致する（`Int.cast_smul_eq_zsmul`）。 -/
theorem toRational_intSmul_from_necSuf (n : ℤ) (l : LogOrderGroup) :
    ((n : ℚ)) • toRational l = toRational (n • l) := by
  rw [Int.cast_smul_eq_zsmul]
  exact NecSuf.ThermodynamicLimit.pointwise_lift_intSmul_necSuf
    (fun m : ℤ => (m : ℚ)) (by simp)
    (fun k a => by simp [zsmul_eq_mul]) n l

end Ising2DLambda.ThermodynamicLimit
