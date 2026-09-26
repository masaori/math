/-
# 第二の双対関係 — 具体版を必要十分版の特殊化として導出する

対応する人手証明のラベル: `second_dual_coupling_relation`
（正本は `structured-latex/content/004_transfer_matrix.ts`）。

`ClaimSecondDualCouplingRelation.lean` の具体版は、人手証明の全計算列を直接たどる。
本ファイルはそれとは分けて、同じ具体的主張が必要十分版
`Ising2D.NecSuf.dualCouplingProduct_eq_one` の特殊化としても得られることを明示する。
-/
import Ising2D.NecSuf.DualCouplingRelation
import Ising2D.Part004.ClaimSecondDualCouplingRelation

namespace Ising2D

/-- 具体版 `second_dual_coupling_relation` と同じ主張を、必要十分版の特殊化として導出した形。 -/
theorem second_dual_coupling_relation_of_necSuf {K2 : ℝ} (hK2 : 0 < K2) :
    Real.sinh (2 * K2) * Real.sinh (2 * Kstar K2) = 1 := by
  have hs : Real.sinh K2 ≠ 0 := ne_of_gt (Real.sinh_pos_iff.mpr hK2)
  have hc : Real.cosh K2 ≠ 0 := ne_of_gt (Real.cosh_pos K2)
  apply NecSuf.dualCouplingProduct_eq_one
      (s := Real.sinh K2)
      (c := Real.cosh K2)
      (t := Real.tanh K2)
      (ePlus := Real.exp (2 * Kstar K2))
      (eMinus := Real.exp (-2 * Kstar K2))
      (sTwo := Real.sinh (2 * K2))
      (sStar := Real.sinh (2 * Kstar K2))
      hs hc
  · exact Real.tanh_eq_sinh_div_cosh K2
  · exact exp_two_Kstar_eq_inv_tanh hK2
  · exact exp_neg_two_Kstar_eq_tanh hK2
  · rw [Real.sinh_eq]
    ring
  · exact sinh_two_eq_two_sinh_mul_cosh K2
  · exact Real.cosh_sq_sub_sinh_sq K2

end Ising2D
