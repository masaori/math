/-
「有理点での四つの符号付き偶部分グラフ多項式の符号」（`claim_signed_even_subgraph_rational_sign`）の
具体版のうち、積の符号の合成の段。因子の符号の段は `SignedEvenSubgraphRationalSignFactors.lean`、
モード `(1,1)` の所属の段は `SignedEvenSubgraphRationalSignMembership.lean` にある。

  人手証明                                                    このファイル・引く具体版
  `q² + 2q − 1 ≠ 0`（`claim_no_rational_square_two`）           主張の場合分けの前提（`q²+2q−1 < 0` か `> 0`）
  R の正の元の積は正: `u = s·s`、`v = t·t` なら
    `u·v = (s·s)(t·t) = (s·t)(s·t)`、`s·t ≠ 0`                  `rPositive_mul`
  空積は `1 = 1·1` で正                                         `rPositive_one`
  正の有理数は R で正（`claim_positive_rational_positive_in_real_closed`）
                                                              `rPositive_rat`
  二元・四元軌道の因子、代表元が `(1,1)` でない一元軌道の因子は正
                                                              `orbitDispersion_pos_at_rationalPoint`・
                                                              `oneElementOrbitFactor_eval_at_rationalPoint`
  代表元が `(1,1)` の一元軌道は `(a,b) = (0,0)` のときだけ一つ  `oneElementOrbits_filter_one_one`
  `P^{a,b}_L(q) = (1,1) の因子 · 残りの積`                       `orbitExplicitProduct_eval_split`
  `P^{a,b}_L = Q^{a,b}_L`（`claim_signed_even_subgraph_orbit_product`）
                                                              `orbitExplicitProduct_eq_signedEvenSubgraphPolynomial`
  `0 <_R r` なら `0 < r`（三分法 `claim_real_algebraic_order_trichotomy` と
    `claim_positive_rational_positive_in_real_closed`）         `rat_pos_of_rPositive`
  四つの符号                                                    `signedEvenSubgraphPolynomial_rational_sign`

`Q^{a,b}_L ∈ ℤ[x]` の有理点 `q` での値は、係数を `ℤ ↪ ℚ` で送った多項式の `q` での値と読む。
必要十分版の定理・定義は使わない。住処は Q と Qbar（実閉部分体 R ⊂ Qbar）。実数体・複素数体は現れない。
-/
import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSignFactors
import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSignMembership
import Ising2DLambda.KacWard.SignedEvenSubgraphOrbitProduct

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.CriticalExponent
open Classical

/-- `y ∈ Qbar` が R の元であって `0 <_R y` であること。 -/
def RPositive (data : RealClosedSubfieldData) (y : Qbar) : Prop :=
  ∃ D : data.carrier, (D : Qbar) = y ∧ realAlgebraicLt data 0 D

/-- R の正の元の積は正: `u = s·s`、`v = t·t`（`s, t ≠ 0`）なら `u·v = (s·t)(s·t)`、`s·t ≠ 0`
（`def_real_algebraic_strict_order`、R は体なので零因子が無い）。 -/
theorem rPositive_mul (data : RealClosedSubfieldData) {y y' : Qbar}
    (h : RPositive data y) (h' : RPositive data y') : RPositive data (y * y') := by
  obtain ⟨u, hu, s, hs0, hs⟩ := h
  obtain ⟨v, hv, t, ht0, ht⟩ := h'
  refine ⟨u * v, by rw [Subfield.coe_mul, hu, hv], s * t, mul_ne_zero hs0 ht0, ?_⟩
  calc u * v - 0 = (u - 0) * (v - 0) := by ring
    _ = (s * s) * (t * t) := by rw [hs, ht]
    _ = (s * t) * (s * t) := by ring

/-- 空積の値 `1 = 1·1` は正。 -/
theorem rPositive_one (data : RealClosedSubfieldData) : RPositive data 1 :=
  ⟨1, by simp, 1, one_ne_zero, by ring⟩

/-- 正の有理数は R で正（`claim_positive_rational_positive_in_real_closed`）。 -/
theorem rPositive_rat (data : RealClosedSubfieldData) {r : ℚ} (hr : 0 < r) :
    RPositive data (r : Qbar) :=
  ⟨⟨(r : Qbar), rational_mem_realClosedCarrier data r⟩, rfl,
    positiveRational_realAlgebraic_positive data r hr⟩

/-- 有限積: 各因子が R で正なら積も正（`rPositive_one` と `rPositive_mul` を因子の個数について繰り返す）。 -/
theorem rPositive_prod (data : RealClosedSubfieldData) {β : Type*} (A : Finset β) (f : β → Qbar)
    (h : ∀ i ∈ A, RPositive data (f i)) : RPositive data (∏ i ∈ A, f i) := by
  induction A using Finset.induction_on with
  | empty => simpa using rPositive_one data
  | insert a A ha ih =>
      rw [Finset.prod_insert ha]
      exact rPositive_mul data (h a (Finset.mem_insert_self a A))
        (ih (fun i hi => h i (Finset.mem_insert_of_mem hi)))

/-- 有理数 `r` について `0 <_R r` なら `0 < r`。`r = 0` なら `0 <_R 0` が三分法
（`claim_real_algebraic_order_trichotomy`）に反し、`r < 0` なら `0 < −r` なので
`claim_positive_rational_positive_in_real_closed` から `r <_R 0` となって三分法に反する。 -/
theorem rat_pos_of_rPositive (data : RealClosedSubfieldData) {r : ℚ}
    (h : RPositive data (r : Qbar)) : 0 < r := by
  obtain ⟨D, hD, hpos⟩ := h
  rcases lt_trichotomy r 0 with hneg | hzero | hpos'
  · exfalso
    have hnr : 0 < -r := neg_pos.mpr hneg
    obtain ⟨w, hw0, hw⟩ := positiveRational_realAlgebraic_positive data (-r) hnr
    -- `0 <_R −r` は `r <_R 0` と同じ（`0 − r = (−r) − 0`）
    have hlt : realAlgebraicLt data D 0 := by
      refine ⟨w, hw0, ?_⟩
      apply Subtype.ext
      have hwQ := congrArg (fun z : data.carrier => (z : Qbar)) hw
      simp only [Subfield.coe_sub, Subfield.coe_zero, Subfield.coe_mul] at hwQ ⊢
      rw [hD, ← hwQ]
      push_cast
      ring
    exact (realAlgebraicLt_trichotomy data 0 D).2.2.1 ⟨hpos, hlt⟩
  · exfalso
    have hD0 : D = 0 := by
      apply Subtype.ext
      rw [hD, hzero]
      simp
    exact (realAlgebraicLt_trichotomy data 0 D).2.1 ⟨hpos, hD0.symm⟩
  · exact hpos'

/-- 明示積の値の分解: `P^{a,b}_L(q)` は、代表元が `(1,1)` の一元軌道の因子の積と、残りの因子の積の積である。 -/
theorem orbitExplicitProduct_eval_split (L : ℕ) [NeZero L] (s : SpinStructure) (y : Qbar) :
    (orbitExplicitProduct L s).eval y =
      (∏ O ∈ ((modeInversionOrbits L s).filter (fun O => O.card = 1)).filter
          (fun O => orbitRepresentative O = ((1 : Qbar), (1 : Qbar))),
          (oneElementOrbitFactor O).eval y) *
        ((∏ O ∈ ((modeInversionOrbits L s).filter (fun O => O.card = 1)).filter
          (fun O => ¬orbitRepresentative O = ((1 : Qbar), (1 : Qbar))),
          (oneElementOrbitFactor O).eval y) *
        (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 2), (orbitDispersion O).eval y) *
        (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 4),
          (orbitDispersion O).eval y ^ 2)) := by
  rw [orbitExplicitProduct, eval_mul, eval_mul, eval_prod, eval_prod, eval_prod,
    ← Finset.prod_filter_mul_prod_filter_not
      ((modeInversionOrbits L s).filter (fun O => O.card = 1))
      (fun O => orbitRepresentative O = ((1 : Qbar), (1 : Qbar)))]
  simp only [eval_pow]
  ring

/-- 代表元が `(1,1)` でない一元軌道・二元軌道・四元軌道の因子の積は、有理点で R の正の元である。 -/
theorem orbitExplicitProduct_rest_pos (data : RealClosedSubfieldData) (L : ℕ) [NeZero L]
    (s : SpinStructure) (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    RPositive data
      ((∏ O ∈ ((modeInversionOrbits L s).filter (fun O => O.card = 1)).filter
          (fun O => ¬orbitRepresentative O = ((1 : Qbar), (1 : Qbar))),
          (oneElementOrbitFactor O).eval (q : Qbar)) *
        (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 2),
          (orbitDispersion O).eval (q : Qbar)) *
        (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 4),
          (orbitDispersion O).eval (q : Qbar) ^ 2)) := by
  -- 軌道 `O ∈ 𝔐` の `Δ_O(q)` は R で正（因子の符号の段）
  have hΔ : ∀ O ∈ modeInversionOrbits L s, RPositive data ((orbitDispersion O).eval (q : Qbar)) :=
    fun O hO => orbitDispersion_pos_at_rationalPoint data hO q hq0 hq1
  refine rPositive_mul data (rPositive_mul data ?_ ?_) ?_
  · -- 代表元が `(1,1)` でない一元軌道の因子は正の有理数（因子の符号の段）
    refine rPositive_prod data _ _ (fun O hO => ?_)
    have hrep := (Finset.mem_filter.mp hO).2
    rcases oneElementOrbitFactor_eval_at_rationalPoint O q hq0 hq1 with ⟨h11, -⟩ | ⟨-, r, hr, hval⟩
    · exact absurd h11 hrep
    · rw [hval]
      exact rPositive_rat data hr
  · -- 二元軌道の因子 `Δ_O(q)`
    exact rPositive_prod data _ _
      (fun O hO => hΔ O (Finset.mem_filter.mp hO).1)
  · -- 四元軌道の因子 `Δ_O(q)²`
    refine rPositive_prod data _ _ (fun O hO => ?_)
    rw [pow_two]
    exact rPositive_mul data (hΔ O (Finset.mem_filter.mp hO).1) (hΔ O (Finset.mem_filter.mp hO).1)

/-- `Q^{a,b}_L` の有理点 `q` での値（係数を `ℤ ↪ ℚ` で送った多項式の値）を Qbar へ送ると
`P^{a,b}_L(q)` に等しい（`claim_signed_even_subgraph_orbit_product`）。 -/
theorem orbitExplicitProduct_eval_eq_rat {L : ℕ} [NeZero L] (z : Qbar) (hz4 : z ^ 4 = -1)
    (s : SpinStructure) (q : ℚ) :
    (orbitExplicitProduct L s).eval (q : Qbar) =
      ((((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom ℚ)).eval q : ℚ) : Qbar) := by
  rw [orbitExplicitProduct_eq_signedEvenSubgraphPolynomial z hz4 s, eval_map, eval_map]
  have h := Polynomial.hom_eval₂
    (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2))
    (Int.castRingHom ℚ) (Rat.castHom Qbar) q
  rw [RingHom.ext_int ((Rat.castHom Qbar).comp (Int.castRingHom ℚ)) (Int.castRingHom Qbar)] at h
  simpa using h.symm

/-- `claim_signed_even_subgraph_rational_sign` の具体版: `0 < q < 1` の有理点で、
`q² + 2q − 1 < 0` なら四つの `Q^{a,b}_L(q)` は正、`q² + 2q − 1 > 0` なら `Q^{0,0}_L(q)` は負で、
他の三つは正である。 -/
theorem signedEvenSubgraphPolynomial_rational_sign (data : RealClosedSubfieldData) {L : ℕ}
    [NeZero L] (z : Qbar) (hz4 : z ^ 4 = -1) (s : SpinStructure) (q : ℚ) (hq0 : 0 < q)
    (hq1 : q < 1) :
    (q ^ 2 + 2 * q - 1 < 0 →
        0 < ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
          (Int.castRingHom ℚ)).eval q) ∧
      (0 < q ^ 2 + 2 * q - 1 →
        (s = (false, false) →
            ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
              (Int.castRingHom ℚ)).eval q < 0) ∧
          (s ≠ (false, false) →
            0 < ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
              (Int.castRingHom ℚ)).eval q)) := by
  set Qq := ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
    (Int.castRingHom ℚ)).eval q with hQq
  set c : ℚ := q ^ 2 + 2 * q - 1 with hc
  -- `P^{a,b}_L(q) = (Q^{a,b}_L(q) : Qbar)`
  have hPQ := orbitExplicitProduct_eval_eq_rat (L := L) z hz4 s q
  -- `P^{a,b}_L(q) = (1,1) の因子 · 残りの積`
  have hsplit := orbitExplicitProduct_eval_split L s (q : Qbar)
  have hrest := orbitExplicitProduct_rest_pos data L s q hq0 hq1
  -- 代表元が `(1,1)` の一元軌道の集合（モード `(1,1)` の所属の段）
  rw [oneElementOrbits_filter_one_one L s] at hsplit
  -- `(1,1)` の因子 `F_{(1,1)}(q) = −(q² + 2q − 1)`
  have hF11 : (oneElementOrbitFactor {((1 : Qbar), (1 : Qbar))}).eval (q : Qbar) =
      ((-c : ℚ) : Qbar) := by
    rcases oneElementOrbitFactor_eval_at_rationalPoint {((1 : Qbar), (1 : Qbar))} q hq0 hq1 with
      ⟨-, hval⟩ | ⟨hne, -⟩
    · rw [hval]
    · exact absurd (by
        have hne' : ({((1 : Qbar), (1 : Qbar))} : Finset (Qbar × Qbar)).Nonempty :=
          Finset.singleton_nonempty _
        have := orbitRepresentative_mem hne'
        exact Finset.mem_singleton.mp this) hne
  by_cases hs : s = (false, false)
  · rw [if_pos hs, Finset.prod_singleton, hF11] at hsplit
    refine ⟨fun hcneg => ?_, fun hcpos => ⟨fun _ => ?_, fun hs' => absurd hs hs'⟩⟩
    · -- `q² + 2q − 1 < 0`: `−(q² + 2q − 1) > 0` も正なので全因子が正
      apply rat_pos_of_rPositive data
      rw [← hPQ, hsplit]
      exact rPositive_mul data (rPositive_rat data (neg_pos.mpr hcneg)) hrest
    · -- `q² + 2q − 1 > 0`: `−P(q) = (q² + 2q − 1) · 残りの積` が正
      have hneg : RPositive data ((-Qq : ℚ) : Qbar) := by
        have : ((-Qq : ℚ) : Qbar) = (c : Qbar) * ((∏ O ∈ ((modeInversionOrbits L s).filter
            (fun O => O.card = 1)).filter
            (fun O => ¬orbitRepresentative O = ((1 : Qbar), (1 : Qbar))),
            (oneElementOrbitFactor O).eval (q : Qbar)) *
          (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 2),
            (orbitDispersion O).eval (q : Qbar)) *
          (∏ O ∈ (modeInversionOrbits L s).filter (fun O => O.card = 4),
            (orbitDispersion O).eval (q : Qbar) ^ 2)) := by
          rw [Rat.cast_neg, ← hPQ, hsplit, Rat.cast_neg]
          ring
        rw [this]
        exact rPositive_mul data (rPositive_rat data hcpos) hrest
      exact neg_pos.mp (rat_pos_of_rPositive data hneg)
  · rw [if_neg hs, Finset.prod_empty, one_mul] at hsplit
    -- `(a,b) ≠ (0,0)`: 負の因子が無いので全因子が正
    have hpos : 0 < Qq := by
      apply rat_pos_of_rPositive data
      rw [← hPQ, hsplit]
      exact hrest
    exact ⟨fun _ => hpos, fun _ => ⟨fun hs' => absurd hs' hs, fun _ => hpos⟩⟩

end Ising2DLambda.KacWard
