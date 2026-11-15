/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」の前半のうち、虚数単位から
どの元での値も 1 の直交基底の存在と、互いに直交する族の線型結合での二次形式の値までの具体版。
人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                              このファイル
  def_imaginary_unit                                                        imaginaryUnit（i）
  claim_imaginary_unit_squares_to_minus_one                                 imaginaryUnit_mul_self
  claim_existence_of_square_root_in_complex_numbers                         realToComplex（ρ）・realToComplex_add・realToComplex_mul・
                                                                            complex_eq_real_add_imaginaryUnit_mul_real（一つ目の事実）、
                                                                            real_sqrt_mul_self（二つ目の事実）、
                                                                            realToComplex_zero・realToComplex_neg（準備）、
                                                                            exists_real_pair_square_difference_double_product（(★)）、
                                                                            exists_complex_square_root（主張）
  claim_nonzero_scalar_multiples_of_basis_members_form_basis                nonzero_smul_basis_isBasis
  claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form     exists_orthonormal_basis
  claim_quadratic_form_of_linear_combination_of_orthogonal_family           polarization_partialLinearCombination_eq_zero・
                                                                            quadraticForm_partialLinearCombination_orthogonal・
                                                                            quadraticForm_linearCombination_orthogonal

ℝ への脱出: claim_existence_of_square_root_in_complex_numbers だけが ℝ を使う。本文どおり二つの事実を前提に置く。
- 一つ目の事実（ℂ を実数の組から作ることについての前提）は、ρ を mathlib の `Complex.ofReal`、
  ρ が加法・乗法を保つことを `Complex.ofReal_add`・`Complex.ofReal_mul`、z = ρ(a) + i·ρ(b) を `Complex.re_add_im` で引く。
- 二つ目の事実（0 以上の実数の平方根の存在）は mathlib の `Real.sqrt` と `Real.mul_self_sqrt` で引く。
  これは ℝ の完備性への脱出である（mathlib の `Real.sqrt` は ℝ の完備性を使って作られる）。
(★) の場合分けの中の ℝ の四則と順序の行は、本文が前提とする ℝ の四則と順序の性質を `ring`・`linarith`・`field_simp`
と mathlib の順序の補題で当てる。

本文の t_k^{-1}・s_k^{-1}（0 でない ℂ の元の乗法の逆元）は ℂ の `⁻¹` で、`mul_inv_cancel₀`・`inv_mul_cancel₀` を当てる。

必要十分版は `NecSuf/Isomorphism/GeneralEvenDimensional/OrthonormalBasis.lean`、導出版は `OrthonormalBasisFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.OrthogonalBasis
import Mathlib.Analysis.Real.Sqrt
import Mathlib.Data.Complex.Basic

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {V : Type u}

/-- 本文 `def_imaginary_unit`：虚数単位 i ∈ ℂ。ℂ の前提として与えられた元で、mathlib の `Complex.I` である。 -/
abbrev imaginaryUnit : ℂ := Complex.I

/-- 本文 `claim_imaginary_unit_squares_to_minus_one`：i ·_ℂ i = -_ℂ 1_ℂ。ℂ の前提の性質の一つ。 -/
theorem imaginaryUnit_mul_self : imaginaryUnit * imaginaryUnit = -1 := Complex.I_mul_I

/-! ### ℂ の元の平方根（ℝ への脱出） -/

/-- 本文 `claim_existence_of_square_root_in_complex_numbers` の一つ目の事実の写像 ρ:ℝ→ℂ（mathlib の `Complex.ofReal`）。 -/
abbrev realToComplex (x : ℝ) : ℂ := (x : ℂ)

/-- 一つ目の事実：ρ(x + y) = ρ(x) +_ℂ ρ(y)。本文の前提（ℂ を実数の組から作ること）。 -/
theorem realToComplex_add (x y : ℝ) : realToComplex (x + y) = realToComplex x + realToComplex y :=
  Complex.ofReal_add x y

/-- 一つ目の事実：ρ(xy) = ρ(x) ·_ℂ ρ(y)。本文の前提（ℂ を実数の組から作ること）。 -/
theorem realToComplex_mul (x y : ℝ) : realToComplex (x * y) = realToComplex x * realToComplex y :=
  Complex.ofReal_mul x y

/-- 一つ目の事実：ℂ の各元 z は、実数 a、b によって z = ρ(a) +_ℂ i ·_ℂ ρ(b) と書ける。本文の前提。 -/
theorem complex_eq_real_add_imaginaryUnit_mul_real (z : ℂ) :
    ∃ a b : ℝ, z = realToComplex a + imaginaryUnit * realToComplex b :=
  ⟨z.re, z.im, by rw [mul_comm imaginaryUnit (realToComplex z.im)]; exact (Complex.re_add_im z).symm⟩

/-- 二つ目の事実：0 以上の実数 t について √t ·√t = t（√t ≥ 0）。ℝ の完備性への脱出である
（mathlib の `Real.sqrt` は ℝ の完備性から作られる）。 -/
theorem real_sqrt_mul_self (t : ℝ) (ht : 0 ≤ t) : Real.sqrt t * Real.sqrt t = t := Real.mul_self_sqrt ht

/-- 本文 `claim_existence_of_square_root_in_complex_numbers` の準備：ρ(0) = 0_ℂ。 -/
theorem realToComplex_zero : realToComplex 0 = 0 := calc
  realToComplex 0 = realToComplex 0 + 0 := by rw [_root_.add_zero (realToComplex 0)]
  _ = realToComplex 0 + (realToComplex 0 + -realToComplex 0) := by rw [add_neg_cancel (realToComplex 0)]
  _ = (realToComplex 0 + realToComplex 0) + -realToComplex 0 := by
      rw [← _root_.add_assoc (realToComplex 0) (realToComplex 0) (-realToComplex 0)]
  _ = realToComplex (0 + 0) + -realToComplex 0 := by rw [realToComplex_add 0 0]
  _ = realToComplex 0 + -realToComplex 0 := by rw [_root_.add_zero (0 : ℝ)]
  _ = 0 := add_neg_cancel (realToComplex 0)

/-- 本文 `claim_existence_of_square_root_in_complex_numbers` の準備：ρ(-x) = -_ℂ ρ(x)。 -/
theorem realToComplex_neg (x : ℝ) : realToComplex (-x) = -realToComplex x := calc
  realToComplex (-x) = realToComplex (-x) + 0 := by rw [_root_.add_zero (realToComplex (-x))]
  _ = realToComplex (-x) + (realToComplex x + -realToComplex x) := by rw [add_neg_cancel (realToComplex x)]
  _ = (realToComplex (-x) + realToComplex x) + -realToComplex x := by
      rw [← _root_.add_assoc (realToComplex (-x)) (realToComplex x) (-realToComplex x)]
  _ = realToComplex ((-x) + x) + -realToComplex x := by rw [realToComplex_add (-x) x]
  _ = realToComplex 0 + -realToComplex x := by rw [neg_add_cancel x]
  _ = 0 + -realToComplex x := by rw [realToComplex_zero]
  _ = -realToComplex x := _root_.zero_add (-realToComplex x)

/-- 本文 `claim_existence_of_square_root_in_complex_numbers` の (★)：すべての実数 a、b について
uu − vv = a、2uv = b を満たす実数 u、v がある。本文の三つの場合分けと 1 対 1 に書く。
0 以上の実数の平方根（二つ目の事実、ℝ の完備性への脱出）を使う。 -/
theorem exists_real_pair_square_difference_double_product (a b : ℝ) :
    ∃ u v : ℝ, u * u - v * v = a ∧ 2 * u * v = b := by
  by_cases hb : b = 0
  · by_cases ha : 0 ≤ a
    · -- b = 0、a ≥ 0 の場合：u := √a、v := 0
      refine ⟨Real.sqrt a, 0, ?_, ?_⟩
      · calc Real.sqrt a * Real.sqrt a - 0 * 0
            = a - 0 * 0 := by rw [real_sqrt_mul_self a ha]
          _ = a - 0 := by rw [mul_zero (0 : ℝ)]
          _ = a := sub_zero a
      · calc 2 * Real.sqrt a * 0
            = 0 := mul_zero (2 * Real.sqrt a)
          _ = b := hb.symm
    · -- b = 0、a < 0 の場合：u := 0、v := √(-a)
      have hna : 0 ≤ -a := by linarith
      refine ⟨0, Real.sqrt (-a), ?_, ?_⟩
      · calc 0 * 0 - Real.sqrt (-a) * Real.sqrt (-a)
            = 0 * 0 - (-a) := by rw [real_sqrt_mul_self (-a) hna]
          _ = 0 - (-a) := by rw [mul_zero (0 : ℝ)]
          _ = a := by rw [zero_sub (-a), neg_neg a]
      · calc 2 * 0 * Real.sqrt (-a)
            = 0 := by rw [mul_zero (2 : ℝ), zero_mul (Real.sqrt (-a))]
          _ = b := hb.symm
  · -- b ≠ 0 の場合
    have haabb : 0 ≤ a * a + b * b := add_nonneg (mul_self_nonneg a) (mul_self_nonneg b)
    let r : ℝ := Real.sqrt (a * a + b * b)
    have hr0 : 0 ≤ r := Real.sqrt_nonneg (a * a + b * b)
    have hrr : r * r = a * a + b * b := real_sqrt_mul_self (a * a + b * b) haabb
    have hbb : 0 < b * b := mul_self_pos.mpr hb
    have hrr_gt : r * r > a * a := calc
      r * r = a * a + b * b := hrr
      _ > a * a + 0 := by linarith
      _ = a * a := _root_.add_zero (a * a)
    have hra : 0 < r + a := by
      by_cases ha : 0 ≤ a
      · have hrne : r ≠ 0 := by
          intro h
          have h0 : r * r = 0 := by rw [h, mul_zero (0 : ℝ)]
          have : a * a < 0 := h0 ▸ hrr_gt
          exact absurd (mul_self_nonneg a) (not_le.mpr this)
        have hrpos : 0 < r := lt_of_le_of_ne hr0 (Ne.symm hrne)
        calc r + a ≥ r + 0 := by linarith
          _ = r := _root_.add_zero r
          _ > 0 := hrpos
      · have hna : 0 < -a := by linarith
        have hrgt : -a < r := by
          by_contra hle
          have hle : r ≤ -a := not_lt.mp hle
          have : r * r ≤ a * a := calc
            r * r ≤ r * (-a) := mul_le_mul_of_nonneg_left hle hr0
            _ ≤ (-a) * (-a) := mul_le_mul_of_nonneg_right hle (le_of_lt hna)
            _ = a * a := neg_mul_neg a a
          exact absurd hrr_gt (not_lt.mpr this)
        calc r + a > (-a) + a := by linarith
          _ = 0 := neg_add_cancel a
    have hhalf : 0 ≤ (r + a) / 2 := le_of_lt (div_pos hra two_pos)
    let u : ℝ := Real.sqrt ((r + a) / 2)
    have huu : u * u = (r + a) / 2 := real_sqrt_mul_self ((r + a) / 2) hhalf
    have hu : u ≠ 0 := by
      intro h
      have h0 : (r + a) / 2 = 0 := by rw [← huu, h, mul_zero (0 : ℝ)]
      exact absurd h0 (ne_of_gt (div_pos hra two_pos))
    have hra' : r + a ≠ 0 := ne_of_gt hra
    let v : ℝ := b / (2 * u)
    refine ⟨u, v, ?_, ?_⟩
    · calc u * u - v * v
          = (r + a) / 2 - (b / (2 * u)) * (b / (2 * u)) := by rw [huu]
        _ = (r + a) / 2 - (b * b) / (4 * (u * u)) := by field_simp; ring
        _ = (r + a) / 2 - (b * b) / (4 * ((r + a) / 2)) := by rw [huu]
        _ = (r + a) / 2 - (b * b) / (2 * (r + a)) := by rw [show (4 : ℝ) * ((r + a) / 2) = 2 * (r + a) by ring]
        _ = ((r + a) * (r + a) - b * b) / (2 * (r + a)) := by field_simp
        _ = (r * r + 2 * a * r + a * a - b * b) / (2 * (r + a)) := by ring
        _ = ((a * a + b * b) + 2 * a * r + a * a - b * b) / (2 * (r + a)) := by rw [hrr]
        _ = (2 * a * (r + a)) / (2 * (r + a)) := by ring
        _ = a := by field_simp
    · calc 2 * u * v
          = 2 * u * (b / (2 * u)) := rfl
        _ = b := by field_simp

/-- 本文 `claim_existence_of_square_root_in_complex_numbers`：すべての z ∈ ℂ について s ·_ℂ s = z を満たす s ∈ ℂ がある。
ℝ への脱出（(★) が ℝ の完備性に依る）。本文どおり û := ρ(u)、v̂ := ρ(v)、s := û +_ℂ i ·_ℂ v̂ と置く（Lean の名前は uHat・vHat）。 -/
theorem exists_complex_square_root (z : ℂ) : ∃ s : ℂ, s * s = z := by
  obtain ⟨a, b, hz⟩ := complex_eq_real_add_imaginaryUnit_mul_real z
  obtain ⟨u, v, hstar1, hstar2⟩ := exists_real_pair_square_difference_double_product a b
  let i : ℂ := imaginaryUnit
  let uHat : ℂ := realToComplex u
  let vHat : ℂ := realToComplex v
  refine ⟨uHat + i * vHat, ?_⟩
  calc (uHat + i * vHat) * (uHat + i * vHat)
      = uHat * (uHat + i * vHat) + (i * vHat) * (uHat + i * vHat) := by rw [add_mul uHat (i * vHat) (uHat + i * vHat)]
    _ = (uHat * uHat + uHat * (i * vHat)) + ((i * vHat) * uHat + (i * vHat) * (i * vHat)) := by
        rw [mul_add uHat uHat (i * vHat), mul_add (i * vHat) uHat (i * vHat)]
    _ = (uHat * uHat + (uHat * i) * vHat) + (i * (vHat * uHat) + ((i * vHat) * i) * vHat) := by
        rw [← mul_assoc uHat i vHat, mul_assoc i vHat uHat, ← mul_assoc (i * vHat) i vHat]
    _ = (uHat * uHat + (i * uHat) * vHat) + (i * (vHat * uHat) + (i * (i * vHat)) * vHat) := by
        rw [mul_comm uHat i, mul_comm (i * vHat) i]
    _ = (uHat * uHat + i * (uHat * vHat)) + (i * (vHat * uHat) + ((i * i) * vHat) * vHat) := by
        rw [mul_assoc i uHat vHat, ← mul_assoc i i vHat]
    _ = (uHat * uHat + i * (uHat * vHat)) + (i * (vHat * uHat) + (i * i) * (vHat * vHat)) := by rw [mul_assoc (i * i) vHat vHat]
    _ = (uHat * uHat + i * (uHat * vHat)) + (i * (vHat * uHat) + (-1) * (vHat * vHat)) := by rw [imaginaryUnit_mul_self]
    _ = (uHat * uHat + i * (uHat * vHat)) + (i * (vHat * uHat) + -(vHat * vHat)) := by rw [neg_one_mul (vHat * vHat)]
    _ = uHat * uHat + (i * (uHat * vHat) + (i * (vHat * uHat) + -(vHat * vHat))) := by
        rw [_root_.add_assoc (uHat * uHat) (i * (uHat * vHat)) (i * (vHat * uHat) + -(vHat * vHat))]
    _ = uHat * uHat + ((i * (uHat * vHat) + i * (vHat * uHat)) + -(vHat * vHat)) := by
        rw [← _root_.add_assoc (i * (uHat * vHat)) (i * (vHat * uHat)) (-(vHat * vHat))]
    _ = uHat * uHat + (-(vHat * vHat) + (i * (uHat * vHat) + i * (vHat * uHat))) := by
        rw [_root_.add_comm (i * (uHat * vHat) + i * (vHat * uHat)) (-(vHat * vHat))]
    _ = (uHat * uHat + -(vHat * vHat)) + (i * (uHat * vHat) + i * (vHat * uHat)) := by
        rw [← _root_.add_assoc (uHat * uHat) (-(vHat * vHat)) (i * (uHat * vHat) + i * (vHat * uHat))]
    _ = (uHat * uHat + -(vHat * vHat)) + i * (uHat * vHat + vHat * uHat) := by rw [← mul_add i (uHat * vHat) (vHat * uHat)]
    _ = (realToComplex (u * u) + -realToComplex (v * v))
          + i * (realToComplex (u * v) + realToComplex (v * u)) := by
        rw [realToComplex_mul u u, realToComplex_mul v v, realToComplex_mul u v, realToComplex_mul v u]
    _ = (realToComplex (u * u) + realToComplex (-(v * v)))
          + i * (realToComplex (u * v) + realToComplex (v * u)) := by rw [realToComplex_neg (v * v)]
    _ = realToComplex (u * u + -(v * v)) + i * realToComplex (u * v + v * u) := by
        rw [realToComplex_add (u * u) (-(v * v)), realToComplex_add (u * v) (v * u)]
    _ = realToComplex (u * u - v * v) + i * realToComplex (u * v + v * u) := by
        rw [sub_eq_add_neg (u * u) (v * v)]
    _ = realToComplex (u * u - v * v) + i * realToComplex (2 * u * v) := by
        rw [show u * v + v * u = 2 * u * v by ring]
    _ = realToComplex a + i * realToComplex b := by rw [hstar1, hstar2]
    _ = z := hz.symm

/-! ### 基底の取り替えと、どの元での値も 1 の直交基底 -/

/-- 本文 `claim_nonzero_scalar_multiples_of_basis_members_form_basis`：基底 b と 0 でない t_k について、
b'_k := t_k ·_V b_k は基底である。 -/
theorem nonzero_smul_basis_isBasis (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (t : ℕ → ℂ) (ht : ∀ k : ℕ, 1 ≤ k → k ≤ n → t k ≠ 0) :
    IsBasisFamily S n (fun k => S.smul (t k) (b k)) := by
  constructor
  · -- 一次独立
    intro ν hν k hk1 hkn
    have hterm : ∀ k : ℕ, 1 ≤ k → k ≤ n →
        S.smul (ν k) (S.smul (t k) (b k)) = S.smul (ν k * t k) (b k) :=
      fun k _ _ => (S.smul_assoc (ν k) (t k) (b k)).symm
    have h0 : linearCombination S n (fun k => ν k * t k) b = S.zero := calc
      linearCombination S n (fun k => ν k * t k) b
          = linearCombination S n ν (fun k => S.smul (t k) (b k)) :=
            (linearCombination_eq_of_terms_eq S n (fun k => S.smul (t k) (b k)) b ν
              (fun k => ν k * t k) hterm).symm
      _ = S.zero := hν
    have hνt : ν k * t k = 0 := hb.linearlyIndependent (fun k => ν k * t k) h0 k hk1 hkn
    calc ν k = ν k * (t k * (t k)⁻¹) := by rw [mul_inv_cancel₀ (ht k hk1 hkn), mul_one (ν k)]
      _ = (ν k * t k) * (t k)⁻¹ := by rw [← mul_assoc (ν k) (t k) (t k)⁻¹]
      _ = 0 * (t k)⁻¹ := by rw [hνt]
      _ = 0 := zero_mul (t k)⁻¹
  · -- 張る
    intro x
    obtain ⟨μ, hμ⟩ := hb.spans x
    refine ⟨fun k => μ k * (t k)⁻¹, ?_⟩
    have hterm : ∀ k : ℕ, 1 ≤ k → k ≤ n →
        S.smul (μ k * (t k)⁻¹) (S.smul (t k) (b k)) = S.smul (μ k) (b k) := fun k hk1 hkn => calc
      S.smul (μ k * (t k)⁻¹) (S.smul (t k) (b k)) = S.smul ((μ k * (t k)⁻¹) * t k) (b k) :=
          (S.smul_assoc (μ k * (t k)⁻¹) (t k) (b k)).symm
      _ = S.smul (μ k * ((t k)⁻¹ * t k)) (b k) := by rw [mul_assoc (μ k) (t k)⁻¹ (t k)]
      _ = S.smul (μ k * 1) (b k) := by rw [inv_mul_cancel₀ (ht k hk1 hkn)]
      _ = S.smul (μ k) (b k) := by rw [mul_one (μ k)]
    calc linearCombination S n (fun k => μ k * (t k)⁻¹) (fun k => S.smul (t k) (b k))
        = linearCombination S n μ b :=
          linearCombination_eq_of_terms_eq S n (fun k => S.smul (t k) (b k)) b _ μ hterm
      _ = x := hμ

/-- 本文 `claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form`：基底 b をもつ V の上の
非退化な二次形式 q には、i ≠ j なら B_q(e_i, e_j) = 0_ℂ、すべての i で q(e_i) = 1_ℂ を満たす基底 e がある。
平方根の存在（`exists_complex_square_root`、ℝ への脱出）を使う。 -/
theorem exists_orthonormal_basis (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsNondegenerateQuadraticForm S q) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) :
    ∃ e : ℕ → V, IsBasisFamily S n e
      ∧ (∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
      ∧ (∀ i : ℕ, 1 ≤ i → i ≤ n → q (e i) = 1) := by
  obtain ⟨e', he'b, he'orth, he'ne⟩ := exists_orthogonal_basis S q hq n b hb
  let s : ℕ → ℂ := fun k => Classical.choose (exists_complex_square_root (q (e' k)))
  have hs : ∀ k : ℕ, s k * s k = q (e' k) :=
    fun k => Classical.choose_spec (exists_complex_square_root (q (e' k)))
  have hsne : ∀ k : ℕ, 1 ≤ k → k ≤ n → s k ≠ 0 := by
    intro k hk1 hkn hs0
    apply he'ne k hk1 hkn
    calc q (e' k) = s k * s k := (hs k).symm
      _ = 0 * 0 := by rw [hs0]
      _ = 0 := mul_zero (0 : ℂ)
  let t : ℕ → ℂ := fun k => (s k)⁻¹
  have hts : ∀ k : ℕ, 1 ≤ k → k ≤ n → t k * s k = 1 := fun k hk1 hkn => inv_mul_cancel₀ (hsne k hk1 hkn)
  have htne : ∀ k : ℕ, 1 ≤ k → k ≤ n → t k ≠ 0 := by
    intro k hk1 hkn ht0
    have h1 : t k * s k = 1 := hts k hk1 hkn
    rw [ht0, zero_mul (s k)] at h1
    exact zero_ne_one h1
  refine ⟨fun k => S.smul (t k) (e' k), nonzero_smul_basis_isBasis S n e' he'b t htne, ?_, ?_⟩
  · -- 直交すること
    intro i j hi1 hin hj1 hjn hij
    calc polarization S q (S.smul (t i) (e' i)) (S.smul (t j) (e' j))
        = t i * polarization S q (e' i) (S.smul (t j) (e' j)) :=
          (hq.isQuadraticForm.polarization_isLinearForm (S.smul (t j) (e' j))).map_smul (t i) (e' i)
      _ = t i * (t j * polarization S q (e' i) (e' j)) := by
          rw [(polarization_isLinearForm_right S q hq.isQuadraticForm (e' i)).map_smul (t j) (e' j)]
      _ = t i * (t j * 0) := by rw [he'orth i j hi1 hin hj1 hjn hij]
      _ = 0 := by rw [mul_zero (t j), mul_zero (t i)]
  · -- 値が 1 であること
    intro i hi1 hin
    calc q (S.smul (t i) (e' i))
        = t i * (t i * q (e' i)) := hq.isQuadraticForm.map_smul (t i) (e' i)
      _ = t i * (t i * (s i * s i)) := by rw [hs i]
      _ = t i * ((t i * s i) * s i) := by rw [← mul_assoc (t i) (s i) (s i)]
      _ = t i * (s i * (t i * s i)) := by rw [mul_comm (t i * s i) (s i)]
      _ = (t i * s i) * (t i * s i) := by rw [← mul_assoc (t i) (s i) (t i * s i)]
      _ = 1 * 1 := by rw [hts i hi1 hin]
      _ = 1 := mul_one (1 : ℂ)

/-! ### 互いに直交する族の線型結合での二次形式の値 -/

/-- 本文 `claim_quadratic_form_of_linear_combination_of_orthogonal_family` の二つ目の準備：
1 ≤ m ≤ n、j + 1 ≤ m なら B_q(G_j, e_m) = 0_ℂ（G_j は線型結合の部分和）。j についての帰納法。 -/
theorem polarization_partialLinearCombination_eq_zero (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsQuadraticForm S q) (n : ℕ) (e : ℕ → V)
    (horth : ∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
    (ν : ℕ → ℂ) (m : ℕ) (hm1 : 1 ≤ m) (hmn : m ≤ n) :
    ∀ j : ℕ, j + 1 ≤ m → polarization S q (partialLinearCombination S ν e j) (e m) = 0 := by
  intro j
  induction j with
  | zero =>
    intro _
    exact (hq.polarization_isLinearForm (e m)).map_zero
  | succ j ih =>
    intro hj
    calc polarization S q (partialLinearCombination S ν e (j + 1)) (e m)
        = polarization S q (S.add (partialLinearCombination S ν e j) (S.smul (ν (j + 1)) (e (j + 1)))) (e m) :=
          rfl
      _ = polarization S q (partialLinearCombination S ν e j) (e m)
            + polarization S q (S.smul (ν (j + 1)) (e (j + 1))) (e m) :=
          (hq.polarization_isLinearForm (e m)).map_add _ _
      _ = polarization S q (partialLinearCombination S ν e j) (e m)
            + ν (j + 1) * polarization S q (e (j + 1)) (e m) := by
          rw [(hq.polarization_isLinearForm (e m)).map_smul (ν (j + 1)) (e (j + 1))]
      _ = 0 + ν (j + 1) * polarization S q (e (j + 1)) (e m) := by rw [ih (Nat.le_of_succ_le hj)]
      _ = 0 + ν (j + 1) * 0 := by
          rw [horth (j + 1) m (Nat.succ_pos j) (by omega) hm1 hmn (by omega)]
      _ = 0 + 0 := by rw [mul_zero (ν (j + 1))]
      _ = 0 := by rw [_root_.add_zero (0 : ℂ)]

/-- 本文 `claim_quadratic_form_of_linear_combination_of_orthogonal_family` の帰納法の主張 q(G_m) = S_m（m ≤ n）。
一つ目の準備 q(0_V) = 0_ℂ を先に置く。 -/
theorem quadraticForm_partialLinearCombination_orthogonal (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsQuadraticForm S q) (n : ℕ) (e : ℕ → V)
    (horth : ∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
    (ν : ℕ → ℂ) :
    ∀ m : ℕ, m ≤ n → q (partialLinearCombination S ν e m)
      = partialOrderedSum (fun k => ν k * (ν k * q (e k))) m := by
  have hq0 : q S.zero = 0 := calc
    q S.zero = q (S.smul 0 S.zero) := by rw [zero_smul_eq_zero S S.zero]
    _ = 0 * (0 * q S.zero) := hq.map_smul 0 S.zero
    _ = 0 := zero_mul (0 * q S.zero)
  intro m
  induction m with
  | zero =>
    intro _
    calc q (partialLinearCombination S ν e 0) = q S.zero := rfl
      _ = 0 := hq0
      _ = partialOrderedSum (fun k => ν k * (ν k * q (e k))) 0 := rfl
  | succ m ih =>
    intro hm
    let G : V := partialLinearCombination S ν e m
    let σ : ℂ := partialOrderedSum (fun k => ν k * (ν k * q (e k))) m
    let α : ℂ := ν (m + 1) * (ν (m + 1) * q (e (m + 1)))
    calc q (partialLinearCombination S ν e (m + 1))
        = q (S.add G (S.smul (ν (m + 1)) (e (m + 1)))) := rfl
      _ = (q G + ν (m + 1) * (ν (m + 1) * q (e (m + 1)))) + ν (m + 1) * polarization S q G (e (m + 1)) :=
          quadraticForm_add_smul S q hq G (e (m + 1)) (ν (m + 1))
      _ = (σ + ν (m + 1) * (ν (m + 1) * q (e (m + 1)))) + ν (m + 1) * polarization S q G (e (m + 1)) := by
          rw [show q G = σ from ih (Nat.le_of_succ_le hm)]
      _ = (σ + α) + ν (m + 1) * polarization S q G (e (m + 1)) := rfl
      _ = (σ + α) + ν (m + 1) * 0 := by
          rw [show polarization S q G (e (m + 1)) = 0 from
            polarization_partialLinearCombination_eq_zero S q hq n e horth ν (m + 1) (Nat.succ_pos m) hm m le_rfl]
      _ = (σ + α) + 0 := by rw [mul_zero (ν (m + 1))]
      _ = σ + α := _root_.add_zero (σ + α)
      _ = partialOrderedSum (fun k => ν k * (ν k * q (e k))) (m + 1) := rfl

/-- 本文 `claim_quadratic_form_of_linear_combination_of_orthogonal_family`：i ≠ j で B_q(e_i, e_j) = 0_ℂ なら
q(Σ ν_k ·_V e_k) = Σ_{ℂ} ν_k ·_ℂ (ν_k ·_ℂ q(e_k))。 -/
theorem quadraticForm_linearCombination_orthogonal (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsQuadraticForm S q) (n : ℕ) (e : ℕ → V)
    (horth : ∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
    (ν : ℕ → ℂ) :
    q (linearCombination S n ν e) = orderedSum n (fun k => ν k * (ν k * q (e k))) :=
  quadraticForm_partialLinearCombination_orthogonal S q hq n e horth ν n le_rfl

end CliffordMatrixIsomorphism.ComplexVectorSpace
