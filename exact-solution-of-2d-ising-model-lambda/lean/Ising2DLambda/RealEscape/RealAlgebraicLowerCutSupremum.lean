/-
人手証明 `claim_real_algebraic_lower_cut_has_supremum`（実閉部分体の元の有理下切断は実数上限を持つ）の具体版。

  人手証明                                                         このファイル
  ε := 1 で挟み込みを当て、r <_R a <_R s を取る                       `realAlgebraic_rational_pinching`
  r ∈ C_a なので像は空でない                                          `realAlgebraicLowerCutImage_nonempty`
  t ∈ C_a なら t <_R a <_R s、推移律で t <_R s                        `realAlgebraicLt_trans`
  s < t なら s <_R t（正の有理数の正値性）、推移律で t <_R t、三分法の排他性に反する
  s = t なら t <_R t、三分法の排他性に反する。有理数の三分律で t < s   `realAlgebraic_lowerCut_lt_of_lt`
  ι(t) < ι(s)（包含写像は順序を保つ単射）                              `realAlgebraicLowerCutImage_bddAbove`
  実数の完備性で上限を取る（ℝ への脱出）                               `realAlgebraic_lower_cut_has_supremum`

必要十分版の定理・定義は使わない。住処: 前半は Q と Qbar（実閉部分体 R ⊂ Qbar）、最後の上限だけが ℝ。
-/
import Ising2DLambda.RealEscape.RealAlgebraicCutRealization
import Ising2DLambda.CriticalExponent.RealAlgebraicRationalPinching

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

/-- 有理下切断 `C_a = {r ∈ Q : r <_R a}` の包含写像 `ι_{Q→R}` による像。 -/
def realAlgebraicLowerCutImage (data : RealClosedSubfieldData) (a : data.carrier) : Set ℝ :=
  {x : ℝ | ∃ q : ℚ, realAlgebraicLt data (realClosedRat data q) a ∧ x = (q : ℝ)}

/-- `def_real_algebraic_cut_realization` の値は、この像の上限である。 -/
theorem realAlgebraicCutRealization_eq_sSup (data : RealClosedSubfieldData) (a : data.carrier) :
    realAlgebraicCutRealization data a = sSup (realAlgebraicLowerCutImage data a) := rfl

/-- 三分法の排他性: `u <_R u` は成り立たない。 -/
theorem realAlgebraicLt_irrefl (data : RealClosedSubfieldData) (u : data.carrier) :
    ¬ realAlgebraicLt data u u := fun h =>
  (realAlgebraicLt_trichotomy data u u).2.1 ⟨h, rfl⟩

/-- `t <_R s`（`t, s ∈ Q`）なら有理数の順序で `t < s`。
`s < t` なら正の有理数の正値性で `s <_R t`、推移律で `t <_R t`。`s = t` なら `t <_R t`。
どちらも三分法の排他性に反し、有理数の三分律で `t < s` が残る。 -/
theorem realAlgebraic_lowerCut_lt_of_lt (data : RealClosedSubfieldData) {t s : ℚ}
    (hts : realAlgebraicLt data (realClosedRat data t) (realClosedRat data s)) : t < s := by
  rcases lt_trichotomy t s with h | h | h
  · exact h
  · subst h
    exact absurd hts (realAlgebraicLt_irrefl data _)
  · have hst : realAlgebraicLt data (realClosedRat data s) (realClosedRat data t) :=
      realAlgebraic_rat_lt_of_sub_pos data (realAlgebraic_rat_sub_pos data h)
    exact absurd (realAlgebraicLt_trans data _ _ _ hts hst) (realAlgebraicLt_irrefl data _)

/-- 像は空でない（挟み込みの下側 `r` が `C_a` に入る）。 -/
theorem realAlgebraicLowerCutImage_nonempty (data : RealClosedSubfieldData) (a : data.carrier) :
    (realAlgebraicLowerCutImage data a).Nonempty := by
  obtain ⟨r, _, hr, _, _, _⟩ := realAlgebraic_rational_pinching data a (ε := 1) one_pos
  exact ⟨(r : ℝ), r, hr, rfl⟩

/-- 像は実数で上に有界（挟み込みの上側 `s` の像が上界）。 -/
theorem realAlgebraicLowerCutImage_bddAbove (data : RealClosedSubfieldData) (a : data.carrier) :
    BddAbove (realAlgebraicLowerCutImage data a) := by
  obtain ⟨_, s, _, hs, _, _⟩ := realAlgebraic_rational_pinching data a (ε := 1) one_pos
  refine ⟨(s : ℝ), ?_⟩
  rintro x ⟨t, ht, rfl⟩
  -- t <_R a <_R s と推移律。
  have hts : realAlgebraicLt data (realClosedRat data t) (realClosedRat data s) :=
    realAlgebraicLt_trans data _ _ _ ht hs
  -- 有理数の順序で t < s、包含写像で ι(t) < ι(s)。
  exact (Rat.cast_lt.mpr (realAlgebraic_lowerCut_lt_of_lt data hts)).le

/-- `claim_real_algebraic_lower_cut_has_supremum` の具体版:
像は空でなく上に有界で、実数の完備性によりその上限（`def_real_algebraic_cut_realization` の値）を持つ。 -/
theorem realAlgebraic_lower_cut_has_supremum (data : RealClosedSubfieldData) (a : data.carrier) :
    (realAlgebraicLowerCutImage data a).Nonempty ∧
      BddAbove (realAlgebraicLowerCutImage data a) ∧
      IsLUB (realAlgebraicLowerCutImage data a) (realAlgebraicCutRealization data a) := by
  have hne := realAlgebraicLowerCutImage_nonempty data a
  have hbdd := realAlgebraicLowerCutImage_bddAbove data a
  refine ⟨hne, hbdd, ?_⟩
  rw [realAlgebraicCutRealization_eq_sSup]
  -- 実数の完備性（ℝ への脱出）。
  exact Real.isLUB_sSup hne hbdd

end Ising2DLambda.RealEscape
