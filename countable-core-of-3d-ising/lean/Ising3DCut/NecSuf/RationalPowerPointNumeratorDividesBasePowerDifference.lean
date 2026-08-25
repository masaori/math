/-
「点数乗表示が成り立つ正の有理点の分子は隣接する二つの箱の底の点数乗の差を割る」の
Lean 必要十分版で使う骨格。

有限箱・有理数・点数乗を落とすと、残るのは対象の等号と、二つの整数が同じ整数へ
法 `a` で合同であることだけである。前者を結論へ保存し、後者二つから差の整除を出す。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 同じ整数へ法 `a` で合同な二つの整数について、`a` は後者と前者の差を割る。 -/
theorem common_residue_dvd_difference
    (a x y k : ℤ)
    (hx : Int.ModEq a x k) (hy : Int.ModEq a y k) :
    a ∣ y - x := by
  have hxy : Int.ModEq a x y := hx.trans hy.symm
  exact Int.modEq_iff_dvd.mp hxy

/-- 人手証明の骨格全体。対象の等号を保存し、共通剰余から差の整除を得る。 -/
theorem equality_and_dvd_difference_of_common_residue
    {C : Type*} (c u : C) (a x y k : ℤ)
    (hcu : c = u)
    (hx : Int.ModEq a x k) (hy : Int.ModEq a y k) :
    c = u ∧ a ∣ y - x := by
  exact ⟨hcu, common_residue_dvd_difference a x y k hx hy⟩

end Ising3DCut.NecSuf
