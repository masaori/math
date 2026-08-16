/- 必要十分版を具体的な `Λ_ℚ`（`X := RationalLogOrderGroup`、`le := rationalLogOrderLE`、
`d L M := Ψ_L + (−Ψ_M)`（`L = 0`・`M = 0` では列の値 `0` を用いる）、`Γ := Γ(q)`、`R a := R_a`）へ特殊化する。
(1) は `rationalLogOrderLE_trans`、(2) は `rationalLogOrderLE_neg_le_neg`、
(3) は `one_div_smul_openSquareDensityDifferenceBoundCore`、(4)(5) は差の上下の評価、
(6) は `rationalLogOrderLE_natSmul_of_pos` と核の非負、(7) は `rationalLogOrderLE_inv_natSmul_le_of_le_natSmul`。 -/
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensitySequenceCauchy
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareDensitySequenceCauchy

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem isCauchyRationalLogOrder_openSquareDensitySequence_of_le_one_from_necSuf
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    IsCauchyRationalLogOrder (openSquareDensitySequence q) := by
  intro ε hε hne
  refine NecSuf.ThermodynamicLimit.cauchy_of_uniform_difference_bounds_necSuf rationalLogOrderLE
    (fun _x _y _z hxy hyz => rationalLogOrderLE_trans hxy hyz)
    (fun _x _y hxy => rationalLogOrderLE_neg_le_neg hxy)
    (fun L M => openSquareDensitySequence q L - openSquareDensitySequence q M)
    (openSquareDensityDifferenceBoundCore q)
    (fun a => ((((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q))) +
        -(((4 : ℚ) / (a : ℚ)) • toRational (logRat q))) +
      ((2 : ℚ) / (a : ℚ)) •
        (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))))
    ?_ ?_ ?_ ?_ ?_ ε hε hne
  · -- (3) 核の等式
    intro a ha
    haveI : NeZero a := ⟨by omega⟩
    exact one_div_smul_openSquareDensityDifferenceBoundCore a q
  · -- (4) 差の上からの評価
    intro a L M ha haL haM hsqL hsqM
    haveI : NeZero a := ⟨by omega⟩
    haveI : NeZero L := ⟨by omega⟩
    haveI : NeZero M := ⟨by omega⟩
    have h := rationalLogOrderLE_openSquareLargeSidesDensityDifference_upper_of_le_one
      a L M haL haM hsqL hsqM hq0 hq1
    rwa [openSquareDensitySequence_of_ne_zero, openSquareDensitySequence_of_ne_zero, sub_eq_add_neg]
  · -- (5) 差の下からの評価
    intro a L M ha haL haM hsqL hsqM
    haveI : NeZero a := ⟨by omega⟩
    haveI : NeZero L := ⟨by omega⟩
    haveI : NeZero M := ⟨by omega⟩
    have h := rationalLogOrderLE_openSquareLargeSidesDensityDifference_lower_of_le_one
      a L M haL haM hsqL hsqM hq0 hq1
    rwa [openSquareDensitySequence_of_ne_zero, openSquareDensitySequence_of_ne_zero, sub_eq_add_neg]
  · -- (6) 核についての Archimedes 性（核の非負を吸収）
    intro ε' hε' hne'
    exact rationalLogOrderLE_natSmul_of_pos (openSquareDensityDifferenceBoundCore q) ε'
      (rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCore_of_le_one hq0 hq1) hε' hne'
  · -- (7) 倍率以上の自然数で割れば上界を超えない
    intro ε' n a hε' hn ha hna
    exact rationalLogOrderLE_inv_natSmul_le_of_le_natSmul hε' ha hna hn

end Ising2DLambda.ThermodynamicLimit
