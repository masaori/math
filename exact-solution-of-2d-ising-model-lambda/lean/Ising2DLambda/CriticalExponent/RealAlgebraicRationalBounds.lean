/-
人手証明 `claim_real_algebraic_rational_bounds`（実閉部分体の各元は有理数で上下から挟める）の具体版。

  人手証明                                                         このファイル
  準備: p ≠ 0、p(a) = 0、d = 次数、c_d ≠ 0、d ≥ 1                   本定理の冒頭、`realAlgebraic_polynomial_value`
  α_j := c_j/c_d、S := Σ_{j<d}|α_j|、B := 1 + S                      `rootBoundSum`
  順序の事実 (i)  u <_R v ⇔ 0 <_R v − u                              `realAlgebraicLt_iff_pos_sub`
  順序の事実 (ii) 正の和は正（推移律）、非負の和は非負                `realAlgebraic_pos_add`、`realAlgebraic_pos_add_nonneg`、
                                                                     `realAlgebraic_nonneg_add`、`realAlgebraic_sum_nonneg`
  順序の事実 (iii) 正の積は正、非負の積は非負                         `realAlgebraic_pos_mul`、`realAlgebraic_nonneg_mul`
  順序の事実 (iv) 非負の有理数は非負                                   `realAlgebraic_rat_pos`、`realAlgebraic_rat_nonneg`
  順序の事実 (v)  正の元は零でない（三分法）                           `realAlgebraic_pos_ne_zero`
  0 ≤ x − 1、0 < x − S、0 < x、0 < x^m、0 ≤ x^m − 1                  `realAlgebraic_monic_pos_of_rootBound_le` の冒頭、
                                                                     `realAlgebraic_pow_pos`、`realAlgebraic_pow_sub_one_nonneg`
  各項 |α_j|x^{d−1} + α_j x^j の分解と非負性                          `realAlgebraic_rootBound_term_nonneg`
  主鎖 x^d + Σα_j x^j = x^{d−1}(x−S) + Σ(…) >_R 0                    `realAlgebraic_monic_pos_of_rootBound_le`
  p(x) = c_d·(x^d + Σα_j x^j) ≠ 0、B ≤_R a の矛盾と三分法で a <_R B   `realAlgebraic_root_lt_rootBound`
  p(−X) の係数比の絶対値の和は S、−a <_R B から −B <_R a              `realAlgebraic_rational_bounds`

必要十分版の定理・定義は使わない。住処: Q と Qbar（実閉部分体 R ⊂ Qbar）。実数体・複素数体は現れない。
-/
import Ising2DLambda.CriticalExponent.PositiveRationalPositiveInRealClosed
import Ising2DLambda.FisherZero.RealAlgebraicOrderTransitive
import Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Finset

/-- 有理数 q を実閉部分体の元として読む（`claim_rationals_are_real_algebraic` による所属）。 -/
noncomputable def realClosedRat (data : RealClosedSubfieldData) (q : ℚ) : data.carrier :=
  ⟨(q : Qbar), rational_mem_realClosedCarrier data q⟩

/-- 所属の元は、部分体の中での有理数の像に等しい。 -/
theorem realClosedRat_eq_cast (data : RealClosedSubfieldData) (q : ℚ) :
    realClosedRat data q = (q : data.carrier) := by
  apply Subtype.ext
  show (q : Qbar) = ((q : data.carrier) : Qbar)
  push_cast
  rfl

/-- 順序の事実 (i): `u <_R v` は `0 <_R v − u` と同じ（狭義順序の定義）。 -/
theorem realAlgebraicLt_iff_pos_sub (data : RealClosedSubfieldData) (u v : data.carrier) :
    realAlgebraicLt data u v ↔ realAlgebraicLt data 0 (v - u) := by
  simp only [realAlgebraicLt, sub_zero]

/-- 順序の事実 (ii): 正の元の和は正。`0 <_R u <_R u + v` に推移律を当てる。 -/
theorem realAlgebraic_pos_add (data : RealClosedSubfieldData) {u v : data.carrier}
    (hu : realAlgebraicLt data 0 u) (hv : realAlgebraicLt data 0 v) :
    realAlgebraicLt data 0 (u + v) := by
  have huv : realAlgebraicLt data u (u + v) := by
    obtain ⟨t, ht0, ht⟩ := hv
    refine ⟨t, ht0, ?_⟩
    calc u + v - u = v - 0 := by ring
      _ = t * t := ht
  exact realAlgebraicLt_trans data 0 u (u + v) hu huv

/-- 順序の事実 (ii): 正の元と非負の元の和は正。 -/
theorem realAlgebraic_pos_add_nonneg (data : RealClosedSubfieldData) {u v : data.carrier}
    (hu : realAlgebraicLt data 0 u) (hv : realAlgebraicLe data 0 v) :
    realAlgebraicLt data 0 (u + v) := by
  rcases hv with hv | hv
  · exact realAlgebraic_pos_add data hu hv
  · rw [← hv, add_zero]
    exact hu

/-- 順序の事実 (ii): 非負の元の和は非負。 -/
theorem realAlgebraic_nonneg_add (data : RealClosedSubfieldData) {u v : data.carrier}
    (hu : realAlgebraicLe data 0 u) (hv : realAlgebraicLe data 0 v) :
    realAlgebraicLe data 0 (u + v) := by
  rcases hu with hu | hu
  · exact Or.inl (realAlgebraic_pos_add_nonneg data hu hv)
  · rw [← hu, zero_add]
    exact hv

/-- 順序の事実 (ii) の有限和への反復: 非負の元の有限和は非負。 -/
theorem realAlgebraic_sum_nonneg (data : RealClosedSubfieldData) (s : Finset ℕ)
    (f : ℕ → data.carrier) (h : ∀ j ∈ s, realAlgebraicLe data 0 (f j)) :
    realAlgebraicLe data 0 (∑ j ∈ s, f j) := by
  induction s using Finset.induction_on with
  | empty =>
      right
      simp
  | insert j s hj ih =>
      rw [sum_insert hj]
      exact realAlgebraic_nonneg_add data (h j (mem_insert_self j s))
        (ih (fun i hi => h i (mem_insert_of_mem hi)))

/-- 順序の事実 (iii): 正の元の積は正。`u = s·s`、`v = t·t` なら `uv = (st)(st)`、`st ≠ 0`。 -/
theorem realAlgebraic_pos_mul (data : RealClosedSubfieldData) {u v : data.carrier}
    (hu : realAlgebraicLt data 0 u) (hv : realAlgebraicLt data 0 v) :
    realAlgebraicLt data 0 (u * v) := by
  obtain ⟨s, hs0, hs⟩ := hu
  obtain ⟨t, ht0, ht⟩ := hv
  refine ⟨s * t, mul_ne_zero hs0 ht0, ?_⟩
  calc u * v - 0 = (u - 0) * (v - 0) := by ring
    _ = (s * s) * (t * t) := by rw [hs, ht]
    _ = (s * t) * (s * t) := by ring

/-- 順序の事実 (iii): 非負の元の積は非負。 -/
theorem realAlgebraic_nonneg_mul (data : RealClosedSubfieldData) {u v : data.carrier}
    (hu : realAlgebraicLe data 0 u) (hv : realAlgebraicLe data 0 v) :
    realAlgebraicLe data 0 (u * v) := by
  rcases hu with hu | hu
  · rcases hv with hv | hv
    · exact Or.inl (realAlgebraic_pos_mul data hu hv)
    · right
      rw [← hv, mul_zero]
  · right
    rw [← hu, zero_mul]

/-- 順序の事実 (iv): 正の有理数は正（`claim_positive_rational_positive_in_real_closed`）。 -/
theorem realAlgebraic_rat_pos (data : RealClosedSubfieldData) {q : ℚ} (hq : 0 < q) :
    realAlgebraicLt data 0 (q : data.carrier) := by
  rw [← realClosedRat_eq_cast]
  exact positiveRational_realAlgebraic_positive data q hq

/-- 順序の事実 (iv): 非負の有理数は非負。 -/
theorem realAlgebraic_rat_nonneg (data : RealClosedSubfieldData) {q : ℚ} (hq : 0 ≤ q) :
    realAlgebraicLe data 0 (q : data.carrier) := by
  rcases hq.lt_or_eq with hq | hq
  · exact Or.inl (realAlgebraic_rat_pos data hq)
  · right
    rw [← hq]
    simp

/-- 順序の事実 (v): 正の元は零でない（`claim_real_algebraic_order_trichotomy`）。 -/
theorem realAlgebraic_pos_ne_zero (data : RealClosedSubfieldData) {u : data.carrier}
    (hu : realAlgebraicLt data 0 u) : u ≠ 0 := by
  intro h
  exact (realAlgebraicLt_trichotomy data 0 u).2.1 ⟨hu, h.symm⟩

/-- 正の元の冪は正（(iii) の帰納法）。 -/
theorem realAlgebraic_pow_pos (data : RealClosedSubfieldData) {x : data.carrier}
    (hx : realAlgebraicLt data 0 x) : ∀ m : ℕ, realAlgebraicLt data 0 (x ^ m) := by
  intro m
  induction m with
  | zero => simpa using realAlgebraic_rat_pos data (q := 1) one_pos
  | succ m ih =>
      rw [pow_succ]
      exact realAlgebraic_pos_mul data ih hx

/-- `0 ≤_R x − 1` なら `0 ≤_R x^m − 1`。帰納段は `x^{m+1} − 1 = x(x^m − 1) + (x − 1)`。 -/
theorem realAlgebraic_pow_sub_one_nonneg (data : RealClosedSubfieldData) {x : data.carrier}
    (hx : realAlgebraicLt data 0 x) (hx1 : realAlgebraicLe data 0 (x - 1)) :
    ∀ m : ℕ, realAlgebraicLe data 0 (x ^ m - 1) := by
  intro m
  induction m with
  | zero =>
      right
      simp
  | succ m ih =>
      have h : x ^ (m + 1) - 1 = x * (x ^ m - 1) + (x - 1) := by ring
      rw [h]
      exact realAlgebraic_nonneg_add data
        (realAlgebraic_nonneg_mul data (Or.inl hx) ih) hx1

/-- 各項の分解 `|α|x^e + αx^j = |α|x^j(x^{e−j} − 1) + (|α| + α)x^j`（`j ≤ e`）と、その非負性。 -/
theorem realAlgebraic_rootBound_term_nonneg (data : RealClosedSubfieldData) {x : data.carrier}
    (hx : realAlgebraicLt data 0 x) (hx1 : realAlgebraicLe data 0 (x - 1))
    (alpha : ℚ) {j e : ℕ} (hj : j ≤ e) :
    realAlgebraicLe data 0
      (((|alpha| : ℚ) : data.carrier) * x ^ e + (alpha : data.carrier) * x ^ j) := by
  have hpow : x ^ e = x ^ j * x ^ (e - j) := by
    rw [← pow_add, Nat.add_sub_cancel' hj]
  have hsplit :
      ((|alpha| : ℚ) : data.carrier) * x ^ e + (alpha : data.carrier) * x ^ j
        = ((|alpha| : ℚ) : data.carrier) * x ^ j * (x ^ (e - j) - 1)
          + ((|alpha| + alpha : ℚ) : data.carrier) * x ^ j := by
    rw [hpow]
    push_cast
    ring
  rw [hsplit]
  have hsumNonneg : 0 ≤ |alpha| + alpha := by
    have := neg_abs_le alpha
    linarith
  exact realAlgebraic_nonneg_add data
    (realAlgebraic_nonneg_mul data
      (realAlgebraic_nonneg_mul data (realAlgebraic_rat_nonneg data (abs_nonneg alpha))
        (Or.inl (realAlgebraic_pow_pos data hx j)))
      (realAlgebraic_pow_sub_one_nonneg data hx hx1 (e - j)))
    (realAlgebraic_nonneg_mul data (realAlgebraic_rat_nonneg data hsumNonneg)
      (Or.inl (realAlgebraic_pow_pos data hx j)))

/-- 係数比の絶対値の和 `S := Σ_{j<d} |α_j|`。 -/
def rootBoundSum (d : ℕ) (alpha : ℕ → ℚ) : ℚ :=
  ∑ j ∈ range d, |alpha j|

theorem rootBoundSum_nonneg (d : ℕ) (alpha : ℕ → ℚ) : 0 ≤ rootBoundSum d alpha :=
  sum_nonneg (fun j _ => abs_nonneg (alpha j))

/-- 主鎖: `B ≤_R x`（`B = 1 + S`、`d = e + 1`）なら `0 <_R x^d + Σ_{j<d} α_j x^j`。 -/
theorem realAlgebraic_monic_pos_of_rootBound_le (data : RealClosedSubfieldData)
    (e : ℕ) (alpha : ℕ → ℚ) (x : data.carrier)
    (hx : realAlgebraicLe data ((1 + rootBoundSum (e + 1) alpha : ℚ) : data.carrier) x) :
    realAlgebraicLt data 0
      (x ^ (e + 1) + ∑ j ∈ range (e + 1), (alpha j : data.carrier) * x ^ j) := by
  set S := rootBoundSum (e + 1) alpha with hSdef
  have hS : 0 ≤ S := rootBoundSum_nonneg (e + 1) alpha
  -- 0 ≤_R x − B
  have hxB : realAlgebraicLe data 0 (x - ((1 + S : ℚ) : data.carrier)) := by
    rcases hx with hx | hx
    · exact Or.inl ((realAlgebraicLt_iff_pos_sub data _ _).mp hx)
    · right
      rw [hx, sub_self]
  -- 0 ≤_R x − 1 = (x − B) + S
  have hx1 : realAlgebraicLe data 0 (x - 1) := by
    have h : x - 1 = (x - ((1 + S : ℚ) : data.carrier)) + (S : data.carrier) := by
      push_cast
      ring
    rw [h]
    exact realAlgebraic_nonneg_add data hxB (realAlgebraic_rat_nonneg data hS)
  -- 0 <_R x − S = 1 + (x − B)
  have hxS : realAlgebraicLt data 0 (x - (S : data.carrier)) := by
    have h : x - (S : data.carrier)
        = ((1 : ℚ) : data.carrier) + (x - ((1 + S : ℚ) : data.carrier)) := by
      push_cast
      ring
    rw [h]
    exact realAlgebraic_pos_add_nonneg data (realAlgebraic_rat_pos data one_pos) hxB
  -- 0 <_R x = (x − S) + S
  have hx0 : realAlgebraicLt data 0 x := by
    have h : x = (x - (S : data.carrier)) + (S : data.carrier) := by ring
    rw [h]
    exact realAlgebraic_pos_add_nonneg data hxS (realAlgebraic_rat_nonneg data hS)
  -- x^d + Σ α_j x^j = x^{d−1}(x − S) + Σ (|α_j| x^{d−1} + α_j x^j)
  have hchain :
      x ^ (e + 1) + ∑ j ∈ range (e + 1), (alpha j : data.carrier) * x ^ j
        = x ^ e * (x - (S : data.carrier))
          + ∑ j ∈ range (e + 1),
              (((|alpha j| : ℚ) : data.carrier) * x ^ e + (alpha j : data.carrier) * x ^ j) := by
    rw [sum_add_distrib, ← sum_mul, hSdef, rootBoundSum]
    push_cast
    ring
  rw [hchain]
  apply realAlgebraic_pos_add_nonneg data
  · exact realAlgebraic_pos_mul data (realAlgebraic_pow_pos data hx0 e) hxS
  · apply realAlgebraic_sum_nonneg data
    intro j hj
    exact realAlgebraic_rootBound_term_nonneg data hx0 hx1 (alpha j)
      (Nat.lt_succ_iff.mp (mem_range.mp hj))

/-- 正側: 最高次係数 `c_d ≠ 0`、`d ≥ 1` の有理係数の和 `Σ_{i≤d} c_i y^i` が零なら `y <_R B`。 -/
theorem realAlgebraic_root_lt_rootBound (data : RealClosedSubfieldData)
    (d : ℕ) (c : ℕ → ℚ) (hd : 1 ≤ d) (hc : c d ≠ 0) (y : data.carrier)
    (hroot : ∑ i ∈ range (d + 1), (c i : data.carrier) * y ^ i = 0) :
    realAlgebraicLt data y
      ((1 + rootBoundSum d (fun j => c j / c d) : ℚ) : data.carrier) := by
  obtain ⟨e, rfl⟩ : ∃ e, d = e + 1 := ⟨d - 1, by omega⟩
  have hcK : (c (e + 1) : data.carrier) ≠ 0 := by exact_mod_cast hc
  -- p(x) = c_d (x^d + Σ_{j<d} α_j x^j)
  have hfactor : ∀ x : data.carrier,
      ∑ i ∈ range (e + 1 + 1), (c i : data.carrier) * x ^ i
        = (c (e + 1) : data.carrier)
          * (x ^ (e + 1)
            + ∑ j ∈ range (e + 1), ((c j / c (e + 1) : ℚ) : data.carrier) * x ^ j) := by
    intro x
    have hterm : ∀ j : ℕ,
        (c (e + 1) : data.carrier) * (((c j / c (e + 1) : ℚ) : data.carrier) * x ^ j)
          = (c j : data.carrier) * x ^ j := by
      intro j
      push_cast
      field_simp
    rw [sum_range_succ, mul_add, mul_sum]
    simp only [hterm]
    ring
  -- B ≤_R x なら p(x) ≠ 0
  have hne : ∀ x : data.carrier,
      realAlgebraicLe data
        ((1 + rootBoundSum (e + 1) (fun j => c j / c (e + 1)) : ℚ) : data.carrier) x →
      ∑ i ∈ range (e + 1 + 1), (c i : data.carrier) * x ^ i ≠ 0 := by
    intro x hx
    rw [hfactor x]
    exact mul_ne_zero hcK (realAlgebraic_pos_ne_zero data
      (realAlgebraic_monic_pos_of_rootBound_le data e (fun j => c j / c (e + 1)) x hx))
  -- 三分法: y = B と B <_R y は p(y) = 0 に反する
  rcases (realAlgebraicLt_trichotomy data y
      ((1 + rootBoundSum (e + 1) (fun j => c j / c (e + 1)) : ℚ) : data.carrier)).1
    with h | h | h
  · exact h
  · exact absurd hroot (hne y (Or.inr h.symm))
  · exact absurd hroot (hne y (Or.inl h))

/-- 実閉部分体の元を、有理数の多項式の値として読む（`aeval` を有限和へ展開する）。 -/
theorem realAlgebraic_polynomial_value (data : RealClosedSubfieldData)
    (p : Polynomial ℚ) (x : data.carrier) :
    ((∑ i ∈ range (p.natDegree + 1), (p.coeff i : data.carrier) * x ^ i : data.carrier) : Qbar)
      = Polynomial.aeval (x : Qbar) p := by
  rw [Polynomial.aeval_eq_sum_range]
  simp [Algebra.smul_def]

/-- `claim_real_algebraic_rational_bounds` の具体版。 -/
theorem realAlgebraic_rational_bounds (data : RealClosedSubfieldData) (a : data.carrier) :
    ∃ B : ℚ, 0 < B ∧
      realAlgebraicLt data (realClosedRat data (-B)) a ∧
      realAlgebraicLt data a (realClosedRat data B) := by
  -- 準備: 代数性から零でない p ∈ Q[X] で p(a) = 0。
  obtain ⟨p, hp0, hpa⟩ : ∃ p : Polynomial ℚ, p ≠ 0 ∧ Polynomial.aeval (a : Qbar) p = 0 :=
    Algebra.IsAlgebraic.isAlgebraic (R := ℚ) (a : Qbar)
  set d := p.natDegree with hdDef
  set c : ℕ → ℚ := fun i => p.coeff i with hcDef
  have hc : c d ≠ 0 := Polynomial.leadingCoeff_ne_zero.mpr hp0
  have hroot : ∑ i ∈ range (d + 1), (c i : data.carrier) * a ^ i = 0 := by
    apply Subtype.ext
    rw [realAlgebraic_polynomial_value data p a, hpa]
    rfl
  -- 定数多項式は零点を持たないから d ≥ 1。
  have hd : 1 ≤ d := by
    by_contra hlt
    have hd0 : d = 0 := by omega
    rw [hd0] at hroot hc
    simp at hroot
    exact hc hroot
  -- B := 1 + S。
  set B : ℚ := 1 + rootBoundSum d (fun j => c j / c d) with hBdef
  have hB : 0 < B := by
    have := rootBoundSum_nonneg d (fun j => c j / c d)
    linarith
  -- 正側: a <_R B。
  have hupper : realAlgebraicLt data a (B : data.carrier) :=
    realAlgebraic_root_lt_rootBound data d c hd hc a hroot
  -- 負側: p(−X) の係数 (−1)^i c_i。最高次係数は零でなく、−a はその根。
  set c' : ℕ → ℚ := fun i => (-1) ^ i * c i with hc'Def
  have hc' : c' d ≠ 0 := mul_ne_zero (pow_ne_zero d (by norm_num)) hc
  have hroot' : ∑ i ∈ range (d + 1), (c' i : data.carrier) * (-a) ^ i = 0 := by
    have hterm : ∀ i : ℕ, (c' i : data.carrier) * (-a) ^ i = (c i : data.carrier) * a ^ i := by
      intro i
      have hsign : ((-1 : data.carrier) ^ i) * ((-1 : data.carrier) ^ i) = 1 := by
        rw [← mul_pow]
        norm_num
      rw [hc'Def, neg_pow]
      push_cast
      calc (-1 : data.carrier) ^ i * (c i : data.carrier) * ((-1) ^ i * a ^ i)
          = ((-1 : data.carrier) ^ i * (-1) ^ i) * ((c i : data.carrier) * a ^ i) := by ring
        _ = (c i : data.carrier) * a ^ i := by rw [hsign, one_mul]
    simp only [hterm]
    exact hroot
  -- 係数比の絶対値の和は S のまま。
  have hS' : rootBoundSum d (fun j => c' j / c' d) = rootBoundSum d (fun j => c j / c d) := by
    unfold rootBoundSum
    apply sum_congr rfl
    intro j _
    simp [hc'Def, abs_div, abs_mul]
  have hlowerNeg : realAlgebraicLt data (-a) (B : data.carrier) := by
    have h := realAlgebraic_root_lt_rootBound data d c' hd hc' (-a) hroot'
    rw [hS'] at h
    exact h
  -- −a <_R B から −B <_R a（差 B − (−a) = a − (−B)）。
  have hlower : realAlgebraicLt data ((-B : ℚ) : data.carrier) a := by
    rw [realAlgebraicLt_iff_pos_sub] at hlowerNeg ⊢
    have h : a - ((-B : ℚ) : data.carrier) = (B : data.carrier) - -a := by
      push_cast
      ring
    rw [h]
    exact hlowerNeg
  refine ⟨B, hB, ?_, ?_⟩
  · rw [realClosedRat_eq_cast]
    exact hlower
  · rw [realClosedRat_eq_cast]
    exact hupper

end Ising2DLambda.CriticalExponent
