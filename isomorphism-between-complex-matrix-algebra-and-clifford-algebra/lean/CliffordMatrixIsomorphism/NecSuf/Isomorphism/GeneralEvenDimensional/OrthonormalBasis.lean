/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」の前半のうち、虚数単位から
互いに直交する族の線型結合での二次形式の値までの必要十分版。具体版
`Isomorphism/GeneralEvenDimensional/OrthonormalBasis.lean` と同じ calc の行を、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                              このファイル
  def_imaginary_unit                                                        宣言を置かない。平方根の主張の変数 i : K になる
  claim_imaginary_unit_squares_to_minus_one                                 宣言を置かない。平方根の主張の仮定 i · i = -1 になる
  claim_existence_of_square_root_in_complex_numbers                         realPart_map_zero・realPart_map_neg（準備）・exists_square_root
  claim_nonzero_scalar_multiples_of_basis_members_form_basis                nonzero_smul_basis_isBasis
  claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form     exists_orthonormal_basis
  claim_quadratic_form_of_linear_combination_of_orthogonal_family           polarization_partialLinearCombination_eq_zero・
                                                                            quadraticForm_partialLinearCombination_orthogonal・
                                                                            quadraticForm_linearCombination_orthogonal

平方根の主張の必要十分版: 本文の証明は、ℂ の側の計算（ρ(0) = 0、ρ(-x) = -ρ(x)、s · s の展開）と、ℝ の側の (★)
（uu − vv = a、2uv = b を満たす u、v の存在。0 以上の実数の平方根、すなわち ℝ の完備性を使う）の二つに分かれる。
必要十分版は ℝ を型の変数 R、ρ を写像 R → K、i を K の元に替え、ℂ の側の計算を具体版と同じ行で書き、
(★) は R についての仮定 `hstar` に置く（R の順序と完備性を K の主張から切り離す）。具体版の (★) は ℝ だけの主張で ℂ を含まないので、
導出版はそれをそのまま `hstar` に渡す。

主張ごとに使う K の性質（削ると通らない）:

  realPart_map_zero                           a + 0 = a、a + (-a) = 0、加法の結合法則（ρ が加法を保つことと、R の 0 + 0 = 0）
  realPart_map_neg                            上と 0 + a = a（R の (-x) + x = 0）
  exists_square_root                          `SquareRootLaws`（K の加法の四つ、a + (-a) = 0、左右の分配法則、乗法の結合法則・交換法則、
                                              (-1) · a = -a）、i · i = -1、ρ が加法・乗法を保つこと、z = ρ(a) + i·ρ(b) と書けること、
                                              R の 0 + 0 = 0・(-x) + x = 0・x + (-y) = x − y・xy + yx = 2xy、(★)
  nonzero_smul_basis_isBasis                  乗法の結合法則、a · 1 = a、0 · a = 0、0 でない t について t · t⁻¹ = 1 と t⁻¹ · t = 1
  exists_orthonormal_basis                    直交基底の存在の性質（`OrthogonalizationLaws`・(-a)·b = -(a·b)・a · 1 = a・d⁻¹ · d = 1）、
                                              K の各元が平方根をもつこと、乗法の交換法則、0 でない t について t · t⁻¹ = 1
  quadraticForm_linearCombination_orthogonal  加法の結合法則・交換法則、a + (-a) = 0、0 + a = a、a + 0 = a、a · 0 = 0、0 · a = 0

分かったこと:
- K の各元が平方根をもつこと（ℂ では ℝ の完備性への脱出）を使うのは、どの元での値も 1 の直交基底の存在だけである。
  直交基底の存在までは平方根を使わない。
- 乗法の交換法則が初めて要るのは、どの元での値も 1 の直交基底の存在（q(e_i) の計算の (t_i s_i) s_i = s_i (t_i s_i) の行）と、
  平方根の主張の s · s の展開（A·i = i·A、(i·B)·i = i·(i·B) の行）である。直交基底の存在までは交換法則を使わない。
- 互いに直交する族の線型結合での二次形式の値は、2 の可逆性も平方根も乗法の交換法則も使わない。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.OrthogonalBasis

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK uR

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {V : Type u}

/-! ### K の元の平方根 -/

section SquareRoot

variable {R : Type uR} [Add R] [Mul R] [Zero R] [Neg R] [Sub R] [OfNat R 2]

omit [Mul K] [One K] [Mul R] [Neg R] [Sub R] [OfNat R 2] in
/-- 本文 `claim_existence_of_square_root_in_complex_numbers` の準備 ρ(0) = 0 の必要十分版。 -/
theorem realPart_map_zero (hadd_zero : ∀ a : K, a + 0 = a) (hneg : ∀ a : K, a + -a = 0)
    (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c)) (hR00 : (0 : R) + 0 = 0)
    (ρ : R → K) (hρadd : ∀ x y : R, ρ (x + y) = ρ x + ρ y) : ρ 0 = 0 := calc
  ρ 0 = ρ 0 + 0 := by rw [hadd_zero (ρ 0)]
  _ = ρ 0 + (ρ 0 + -ρ 0) := by rw [hneg (ρ 0)]
  _ = (ρ 0 + ρ 0) + -ρ 0 := by rw [← hassoc (ρ 0) (ρ 0) (-ρ 0)]
  _ = ρ (0 + 0) + -ρ 0 := by rw [hρadd 0 0]
  _ = ρ 0 + -ρ 0 := by rw [hR00]
  _ = 0 := hneg (ρ 0)

omit [Mul K] [One K] [Mul R] [Sub R] [OfNat R 2] in
/-- 本文 `claim_existence_of_square_root_in_complex_numbers` の準備 ρ(-x) = -ρ(x) の必要十分版。 -/
theorem realPart_map_neg (hadd_zero : ∀ a : K, a + 0 = a) (hneg : ∀ a : K, a + -a = 0)
    (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c)) (hzero_add : ∀ a : K, 0 + a = a)
    (hR00 : (0 : R) + 0 = 0) (hRneg : ∀ x : R, -x + x = 0)
    (ρ : R → K) (hρadd : ∀ x y : R, ρ (x + y) = ρ x + ρ y) (x : R) : ρ (-x) = -ρ x := calc
  ρ (-x) = ρ (-x) + 0 := by rw [hadd_zero (ρ (-x))]
  _ = ρ (-x) + (ρ x + -ρ x) := by rw [hneg (ρ x)]
  _ = (ρ (-x) + ρ x) + -ρ x := by rw [← hassoc (ρ (-x)) (ρ x) (-ρ x)]
  _ = ρ ((-x) + x) + -ρ x := by rw [hρadd (-x) x]
  _ = ρ 0 + -ρ x := by rw [hRneg x]
  _ = 0 + -ρ x := by rw [realPart_map_zero hadd_zero hneg hassoc hR00 ρ hρadd]
  _ = -ρ x := hzero_add (-ρ x)

/-- 平方根の主張の、K の側の計算に要る K の性質の組。 -/
structure SquareRootLaws (K : Type uK) [Add K] [Mul K] [One K] [Zero K] [Neg K] : Prop where
  add_assoc : ∀ a b c : K, (a + b) + c = a + (b + c)
  add_comm : ∀ a b : K, a + b = b + a
  add_zero : ∀ a : K, a + 0 = a
  zero_add : ∀ a : K, 0 + a = a
  add_neg : ∀ a : K, a + -a = 0
  left_distrib : ∀ a b c : K, a * (b + c) = a * b + a * c
  right_distrib : ∀ a b c : K, (a + b) * c = a * c + b * c
  mul_assoc : ∀ a b c : K, (a * b) * c = a * (b * c)
  mul_comm : ∀ a b : K, a * b = b * a
  neg_one_mul : ∀ a : K, (-1) * a = -a

/-- 本文 `claim_existence_of_square_root_in_complex_numbers` の必要十分版。
ℝ を型 R、ρ を写像 R → K、虚数単位を K の元 i（`hi`：i · i = -1）に替える。一つ目の事実は `hρadd`・`hρmul`・`hrep`、
(★) は `hstar` で、R の順序と完備性（二つ目の事実）はこの仮定の中に閉じ込める。
R に要るのは、0 + 0 = 0、(-x) + x = 0、x + (-y) = x − y、xy + yx = 2xy（本文の ℝ の行）と (★) だけである。 -/
theorem exists_square_root (L : SquareRootLaws K)
    (ρ : R → K) (hρadd : ∀ x y : R, ρ (x + y) = ρ x + ρ y) (hρmul : ∀ x y : R, ρ (x * y) = ρ x * ρ y)
    (i : K) (hi : i * i = -1) (hrep : ∀ z : K, ∃ a b : R, z = ρ a + i * ρ b)
    (hR00 : (0 : R) + 0 = 0) (hRneg : ∀ x : R, -x + x = 0) (hRsub : ∀ x y : R, x + -y = x - y)
    (hRtwo : ∀ x y : R, x * y + y * x = 2 * x * y)
    (hstar : ∀ a b : R, ∃ u v : R, u * u - v * v = a ∧ 2 * u * v = b)
    (z : K) : ∃ s : K, s * s = z := by
  obtain ⟨a, b, hz⟩ := hrep z
  obtain ⟨u, v, hstar1, hstar2⟩ := hstar a b
  let A : K := ρ u
  let B : K := ρ v
  refine ⟨A + i * B, ?_⟩
  calc (A + i * B) * (A + i * B)
      = A * (A + i * B) + (i * B) * (A + i * B) := by rw [L.right_distrib A (i * B) (A + i * B)]
    _ = (A * A + A * (i * B)) + ((i * B) * A + (i * B) * (i * B)) := by
        rw [L.left_distrib A A (i * B), L.left_distrib (i * B) A (i * B)]
    _ = (A * A + (A * i) * B) + (i * (B * A) + ((i * B) * i) * B) := by
        rw [← L.mul_assoc A i B, L.mul_assoc i B A, ← L.mul_assoc (i * B) i B]
    _ = (A * A + (i * A) * B) + (i * (B * A) + (i * (i * B)) * B) := by
        rw [L.mul_comm A i, L.mul_comm (i * B) i]
    _ = (A * A + i * (A * B)) + (i * (B * A) + ((i * i) * B) * B) := by
        rw [L.mul_assoc i A B, ← L.mul_assoc i i B]
    _ = (A * A + i * (A * B)) + (i * (B * A) + (i * i) * (B * B)) := by rw [L.mul_assoc (i * i) B B]
    _ = (A * A + i * (A * B)) + (i * (B * A) + (-1) * (B * B)) := by rw [hi]
    _ = (A * A + i * (A * B)) + (i * (B * A) + -(B * B)) := by rw [L.neg_one_mul (B * B)]
    _ = A * A + (i * (A * B) + (i * (B * A) + -(B * B))) := by
        rw [L.add_assoc (A * A) (i * (A * B)) (i * (B * A) + -(B * B))]
    _ = A * A + ((i * (A * B) + i * (B * A)) + -(B * B)) := by
        rw [← L.add_assoc (i * (A * B)) (i * (B * A)) (-(B * B))]
    _ = A * A + (-(B * B) + (i * (A * B) + i * (B * A))) := by
        rw [L.add_comm (i * (A * B) + i * (B * A)) (-(B * B))]
    _ = (A * A + -(B * B)) + (i * (A * B) + i * (B * A)) := by
        rw [← L.add_assoc (A * A) (-(B * B)) (i * (A * B) + i * (B * A))]
    _ = (A * A + -(B * B)) + i * (A * B + B * A) := by rw [← L.left_distrib i (A * B) (B * A)]
    _ = (ρ (u * u) + -ρ (v * v)) + i * (ρ (u * v) + ρ (v * u)) := by
        rw [hρmul u u, hρmul v v, hρmul u v, hρmul v u]
    _ = (ρ (u * u) + ρ (-(v * v))) + i * (ρ (u * v) + ρ (v * u)) := by
        rw [realPart_map_neg L.add_zero L.add_neg L.add_assoc L.zero_add hR00 hRneg ρ hρadd (v * v)]
    _ = ρ (u * u + -(v * v)) + i * ρ (u * v + v * u) := by
        rw [hρadd (u * u) (-(v * v)), hρadd (u * v) (v * u)]
    _ = ρ (u * u - v * v) + i * ρ (u * v + v * u) := by rw [hRsub (u * u) (v * v)]
    _ = ρ (u * u - v * v) + i * ρ (2 * u * v) := by rw [hRtwo u v]
    _ = ρ a + i * ρ b := by rw [hstar1, hstar2]
    _ = z := hz.symm

end SquareRoot

/-! ### 基底の取り替えと、どの元での値も 1 の直交基底 -/

omit [Neg K] in
/-- 本文 `claim_nonzero_scalar_multiples_of_basis_members_form_basis` の必要十分版。
t_k⁻¹ は K の `Inv` の記号で書き、t · t⁻¹ = 1・t⁻¹ · t = 1 を 0 でない t についての仮定に置く。 -/
theorem nonzero_smul_basis_isBasis [Inv K] (hmul_assoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (hmul_one : ∀ a : K, a * 1 = a) (h0mul : ∀ a : K, 0 * a = 0)
    (hmul_inv : ∀ a : K, a ≠ 0 → a * a⁻¹ = 1) (hinv_mul : ∀ a : K, a ≠ 0 → a⁻¹ * a = 1)
    (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (t : ℕ → K) (ht : ∀ k : ℕ, 1 ≤ k → k ≤ n → t k ≠ 0) :
    IsBasisFamily S n (fun k => S.smul (t k) (b k)) := by
  constructor
  · intro ν hν k hk1 hkn
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
    calc ν k = ν k * (t k * (t k)⁻¹) := by rw [hmul_inv (t k) (ht k hk1 hkn), hmul_one (ν k)]
      _ = (ν k * t k) * (t k)⁻¹ := by rw [← hmul_assoc (ν k) (t k) (t k)⁻¹]
      _ = 0 * (t k)⁻¹ := by rw [hνt]
      _ = 0 := h0mul (t k)⁻¹
  · intro x
    obtain ⟨μ, hμ⟩ := hb.spans x
    refine ⟨fun k => μ k * (t k)⁻¹, ?_⟩
    have hterm : ∀ k : ℕ, 1 ≤ k → k ≤ n →
        S.smul (μ k * (t k)⁻¹) (S.smul (t k) (b k)) = S.smul (μ k) (b k) := fun k hk1 hkn => calc
      S.smul (μ k * (t k)⁻¹) (S.smul (t k) (b k)) = S.smul ((μ k * (t k)⁻¹) * t k) (b k) :=
          (S.smul_assoc (μ k * (t k)⁻¹) (t k) (b k)).symm
      _ = S.smul (μ k * ((t k)⁻¹ * t k)) (b k) := by rw [hmul_assoc (μ k) (t k)⁻¹ (t k)]
      _ = S.smul (μ k * 1) (b k) := by rw [hinv_mul (t k) (ht k hk1 hkn)]
      _ = S.smul (μ k) (b k) := by rw [hmul_one (μ k)]
    calc linearCombination S n (fun k => μ k * (t k)⁻¹) (fun k => S.smul (t k) (b k))
        = linearCombination S n μ b :=
          linearCombination_eq_of_terms_eq S n (fun k => S.smul (t k) (b k)) b _ μ hterm
      _ = x := hμ

/-- 本文 `claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form` の必要十分版。
直交基底の存在の仮定に、K の各元が平方根をもつこと `hsqrt`（ℂ では ℝ の完備性への脱出）、乗法の交換法則、
0 でない t についての t · t⁻¹ = 1 を足す。 -/
theorem exists_orthonormal_basis [Inv K] (L : OrthogonalizationLaws K)
    (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hmul_one : ∀ a : K, a * 1 = a)
    (hinv : ∀ a : K, a ≠ 0 → a⁻¹ * a = 1) (hmul_inv : ∀ a : K, a ≠ 0 → a * a⁻¹ = 1)
    (hmul_comm : ∀ a b : K, a * b = b * a) (hsqrt : ∀ z : K, ∃ s : K, s * s = z)
    (S : VectorSpace K V) (q : V → K)
    (hq : IsNondegenerateQuadraticForm S q) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) :
    ∃ e : ℕ → V, IsBasisFamily S n e
      ∧ (∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
      ∧ (∀ i : ℕ, 1 ≤ i → i ≤ n → q (e i) = 1) := by
  obtain ⟨e', he'b, he'orth, he'ne⟩ := exists_orthogonal_basis L hneg_mul hmul_one hinv S q hq n b hb
  let s : ℕ → K := fun k => Classical.choose (hsqrt (q (e' k)))
  have hs : ∀ k : ℕ, s k * s k = q (e' k) := fun k => Classical.choose_spec (hsqrt (q (e' k)))
  have hsne : ∀ k : ℕ, 1 ≤ k → k ≤ n → s k ≠ 0 := by
    intro k hk1 hkn hs0
    apply he'ne k hk1 hkn
    calc q (e' k) = s k * s k := (hs k).symm
      _ = 0 * 0 := by rw [hs0]
      _ = 0 := L.mul_zero (0 : K)
  let t : ℕ → K := fun k => (s k)⁻¹
  have hts : ∀ k : ℕ, 1 ≤ k → k ≤ n → t k * s k = 1 := fun k hk1 hkn => hinv (s k) (hsne k hk1 hkn)
  have htne : ∀ k : ℕ, 1 ≤ k → k ≤ n → t k ≠ 0 := by
    intro k hk1 hkn ht0
    have h1 : t k * s k = 1 := hts k hk1 hkn
    rw [ht0, L.zero_mul (s k)] at h1
    exact L.one_ne_zero h1.symm
  refine ⟨fun k => S.smul (t k) (e' k),
    nonzero_smul_basis_isBasis L.mul_assoc hmul_one L.zero_mul hmul_inv hinv S n e' he'b t htne, ?_, ?_⟩
  · intro i j hi1 hin hj1 hjn hij
    calc polarization S q (S.smul (t i) (e' i)) (S.smul (t j) (e' j))
        = t i * polarization S q (e' i) (S.smul (t j) (e' j)) :=
          (hq.isQuadraticForm.polarization_isLinearForm (S.smul (t j) (e' j))).map_smul (t i) (e' i)
      _ = t i * (t j * polarization S q (e' i) (e' j)) := by
          rw [(polarization_isLinearForm_right L.add_assoc L.add_comm S q hq.isQuadraticForm (e' i)).map_smul
            (t j) (e' j)]
      _ = t i * (t j * 0) := by rw [he'orth i j hi1 hin hj1 hjn hij]
      _ = 0 := by rw [L.mul_zero (t j), L.mul_zero (t i)]
  · intro i hi1 hin
    calc q (S.smul (t i) (e' i))
        = t i * (t i * q (e' i)) := hq.isQuadraticForm.map_smul (t i) (e' i)
      _ = t i * (t i * (s i * s i)) := by rw [hs i]
      _ = t i * ((t i * s i) * s i) := by rw [← L.mul_assoc (t i) (s i) (s i)]
      _ = t i * (s i * (t i * s i)) := by rw [hmul_comm (t i * s i) (s i)]
      _ = (t i * s i) * (t i * s i) := by rw [← L.mul_assoc (t i) (s i) (t i * s i)]
      _ = 1 * 1 := by rw [hts i hi1 hin]
      _ = 1 := hmul_one (1 : K)

/-! ### 互いに直交する族の線型結合での二次形式の値 -/

/-- 本文 `claim_quadratic_form_of_linear_combination_of_orthogonal_family` の二つ目の準備の必要十分版。 -/
theorem polarization_partialLinearCombination_eq_zero (h00 : (0 : K) + 0 = 0) (hmul0 : ∀ a : K, a * 0 = 0)
    (h0mul : ∀ a : K, 0 * a = 0)
    (S : VectorSpace K V) (q : V → K) (hq : IsQuadraticForm S q) (n : ℕ) (e : ℕ → V)
    (horth : ∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
    (ν : ℕ → K) (m : ℕ) (hm1 : 1 ≤ m) (hmn : m ≤ n) :
    ∀ j : ℕ, j + 1 ≤ m → polarization S q (partialLinearCombination S ν e j) (e m) = 0 := by
  intro j
  induction j with
  | zero =>
    intro _
    exact (hq.polarization_isLinearForm (e m)).map_zero h00 h0mul
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
      _ = 0 + 0 := by rw [hmul0 (ν (j + 1))]
      _ = 0 := h00

/-- 本文 `claim_quadratic_form_of_linear_combination_of_orthogonal_family` の帰納法の主張の必要十分版。 -/
theorem quadraticForm_partialLinearCombination_orthogonal (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a) (hneg : ∀ a : K, a + -a = 0) (hzero_add : ∀ a : K, 0 + a = a)
    (hadd_zero : ∀ a : K, a + 0 = a) (hmul0 : ∀ a : K, a * 0 = 0) (h0mul : ∀ a : K, 0 * a = 0)
    (S : VectorSpace K V) (q : V → K) (hq : IsQuadraticForm S q) (n : ℕ) (e : ℕ → V)
    (horth : ∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
    (ν : ℕ → K) :
    ∀ m : ℕ, m ≤ n → q (partialLinearCombination S ν e m)
      = partialOrderedSum (fun k => ν k * (ν k * q (e k))) m := by
  have h00 : (0 : K) + 0 = 0 := hadd_zero 0
  have hq0 : q S.zero = 0 := calc
    q S.zero = q (S.smul 0 S.zero) := by rw [zero_smul_eq_zero S h00 S.zero]
    _ = 0 * (0 * q S.zero) := hq.map_smul 0 S.zero
    _ = 0 := h0mul (0 * q S.zero)
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
    let σ : K := partialOrderedSum (fun k => ν k * (ν k * q (e k))) m
    let α : K := ν (m + 1) * (ν (m + 1) * q (e (m + 1)))
    calc q (partialLinearCombination S ν e (m + 1))
        = q (S.add G (S.smul (ν (m + 1)) (e (m + 1)))) := rfl
      _ = (q G + ν (m + 1) * (ν (m + 1) * q (e (m + 1)))) + ν (m + 1) * polarization S q G (e (m + 1)) :=
          quadraticForm_add_smul hassoc hcomm hneg hzero_add S q hq G (e (m + 1)) (ν (m + 1))
      _ = (σ + ν (m + 1) * (ν (m + 1) * q (e (m + 1)))) + ν (m + 1) * polarization S q G (e (m + 1)) := by
          rw [show q G = σ from ih (Nat.le_of_succ_le hm)]
      _ = (σ + α) + ν (m + 1) * polarization S q G (e (m + 1)) := rfl
      _ = (σ + α) + ν (m + 1) * 0 := by
          rw [show polarization S q G (e (m + 1)) = 0 from
            polarization_partialLinearCombination_eq_zero h00 hmul0 h0mul S q hq n e horth ν (m + 1)
              (Nat.succ_pos m) hm m le_rfl]
      _ = (σ + α) + 0 := by rw [hmul0 (ν (m + 1))]
      _ = σ + α := hadd_zero (σ + α)
      _ = partialOrderedSum (fun k => ν k * (ν k * q (e k))) (m + 1) := rfl

/-- 本文 `claim_quadratic_form_of_linear_combination_of_orthogonal_family` の必要十分版。 -/
theorem quadraticForm_linearCombination_orthogonal (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a) (hneg : ∀ a : K, a + -a = 0) (hzero_add : ∀ a : K, 0 + a = a)
    (hadd_zero : ∀ a : K, a + 0 = a) (hmul0 : ∀ a : K, a * 0 = 0) (h0mul : ∀ a : K, 0 * a = 0)
    (S : VectorSpace K V) (q : V → K) (hq : IsQuadraticForm S q) (n : ℕ) (e : ℕ → V)
    (horth : ∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
    (ν : ℕ → K) :
    q (linearCombination S n ν e) = orderedSum n (fun k => ν k * (ν k * q (e k))) :=
  quadraticForm_partialLinearCombination_orthogonal hassoc hcomm hneg hzero_add hadd_zero hmul0 h0mul
    S q hq n e horth ν n le_rfl

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
