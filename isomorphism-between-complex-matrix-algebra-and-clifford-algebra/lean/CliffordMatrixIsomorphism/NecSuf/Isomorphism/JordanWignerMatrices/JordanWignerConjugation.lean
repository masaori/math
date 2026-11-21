/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、Z_m・Y_m・U・U' と、生成作用素・消滅作用素の行列を
U と U' で挟んだ行列の必要十分版。具体版 `Isomorphism/JordanWignerMatrices/JordanWignerConjugation.lean` と同じ def と
calc の行で、係数 ℂ を型の変数 K に、i・h・-1_ℂ を K の元の変数 i・h・n に替えて書く。

  本文のラベル                                                       このファイル                             使う K の性質
  def_jordan_wigner_z_matrix・def_jordan_wigner_y_matrix             jordanWignerZ・jordanWignerY             なし
  def_kronecker_power_of_matrix_exchanging_pauli_z_and_x・…_half_…   kroneckerPowerOfExchange・…HalfExchange  なし
  claim_kronecker_power_of_k_times_that_of_its_half_is_identity      kroneckerPowerOfExchange_mul_half        P と (1 + 1) · h = 1
  claim_kronecker_power_of_half_of_k_times_that_of_k_is_identity     kroneckerPowerOfHalfExchange_mul         P と (1 + 1) · h = 1
  claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix
                                                                     conjugation_creation_add_annihilation    P、(1 + 1) · h = 1、-1 = n
  claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix
                                                                     conjugation_imaginary_combination        P、(1 + 1) · h = 1、-1 = n

P はどの主張にも共通の組で、L : `ValuedMapsLaws K`（積を定めるため）、乗法の交換法則、a · 0 = 0、a + (-a) = 0、
(-a) · b = -(a · b)、-(-a) = a である。a · 1 = a・0 · a = 0・a · (-b) = -(a · b)・0 と 1 と -1 の交換は、交換法則と L の 1 · a = a・
a · 0 = 0 から出るので（`mul_one_of_comm` など）、仮定に重ねて置かない。

削れなかった仮定:
- 乗法の交換法則: 二つのクロネッカー積の積の主張（`mul_kroneckerProduct`）と行列の積の結合法則（`mat_mul_assoc`）が要る
  （`NecSuf/ComplexMatrixAlgebra/KroneckerProduct/KroneckerProduct.lean` の冒頭）。U・U' の主張も、Z_m・Y_m の主張も、
  この二つを経由するので外せない。
- (1 + 1) · h = 1: K K' = 1 と K' K = 1（U U' = 1 と U' U = 1）の準備 h + h = 1。h · (1 + 1) = 1 は使わない。
- -1 = n: 生成作用素・消滅作用素の行列をクロネッカー積で書く主張（`CreationMatricesAsKroneckerProducts.lean` の冒頭）。
- a + (-a) = 0・(-a) · b = -(a · b)・-(-a) = a: K K' = 1、K' K = 1、K σz = σx K、K G = σz K、K G' = σy K の「四則」の行。
- i · i = -1 は、どの主張も使わない（Y_m の主張は i が K のどの元でも成り立つ）。
- 本文の前提 M ≥ 1 は、U・U' の主張が使わない。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.CreationMatricesAsKroneckerProducts
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.KroneckerProduct.Conjugation

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet idxOne idxTwo isFiniteSet_two)

universe uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K]

/-! ### 交換法則から出る性質 -/

omit [Neg K] in
/-- a · 1 = a（乗法の交換法則と 1 · a = a から）。 -/
theorem mul_one_of_comm (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a) (a : K) : a * 1 = a := by
  rw [hcomm a 1, L.one_mul a]

omit [Add K] [One K] [Neg K] in
/-- 0 · a = 0（乗法の交換法則と a · 0 = 0 から）。 -/
theorem zero_mul_of_comm (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (a : K) : 0 * a = 0 := by
  rw [hcomm 0 a, hmul0 a]

omit [Add K] [One K] [Zero K] in
/-- a · (-b) = -(a · b)（乗法の交換法則と (-a) · b = -(a · b) から）。 -/
theorem mul_neg_of_comm (hcomm : ∀ a b : K, a * b = b * a) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (a b : K) :
    a * (-b) = -(a * b) := by
  rw [hcomm a (-b), hneg_mul b a, hcomm b a]

/-! ### Jordan–Wigner 行列 -/

section Definitions

/-- 本文 `def_jordan_wigner_z_matrix` の右辺の第 k 因子 F_k の必要十分版。 -/
def jordanWignerZFactor (m k : ℕ) : Mat K (Idx 2) :=
  if k < m then pauliX else if k = m then pauliZ else Mat.one

/-- 本文 `def_jordan_wigner_z_matrix` の必要十分版。 -/
noncomputable def jordanWignerZ (M m : ℕ) : Mat K (PowerSet M) := kroneckerProduct M (jordanWignerZFactor m)

/-- 本文 `def_jordan_wigner_y_matrix` の右辺の第 k 因子 F'_k の必要十分版（i は K の元の変数）。 -/
def jordanWignerYFactor (i : K) (m k : ℕ) : Mat K (Idx 2) :=
  if k < m then pauliX else if k = m then pauliY i else Mat.one

/-- 本文 `def_jordan_wigner_y_matrix` の必要十分版。 -/
noncomputable def jordanWignerY (i : K) (M m : ℕ) : Mat K (PowerSet M) :=
  kroneckerProduct M (jordanWignerYFactor i m)

/-- 本文 `def_kronecker_power_of_matrix_exchanging_pauli_z_and_x` の必要十分版：U := ⊠ K。 -/
noncomputable def kroneckerPowerOfExchange (M : ℕ) : Mat K (PowerSet M) :=
  kroneckerProduct M (fun _ => exchangeMatrix)

/-- 本文 `def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x` の必要十分版：U' := ⊠ K'。 -/
noncomputable def kroneckerPowerOfHalfExchange (h : K) (M : ℕ) : Mat K (PowerSet M) :=
  kroneckerProduct M (fun _ => halfExchangeMatrix h)

end Definitions

/-! ### U と U' -/

/-- 本文 `claim_kronecker_power_of_k_times_that_of_its_half_is_identity` の必要十分版。 -/
theorem kroneckerPowerOfExchange_mul_half (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (h : K) (hh : (1 + 1) * h = 1) (M : ℕ) :
    Mat.mul L (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange h M) = Mat.one := calc
  Mat.mul L (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange h M)
      = kroneckerProduct M (fun _ => Mat.mul L isFiniteSet_two exchangeMatrix (halfExchangeMatrix h)) :=
        mul_kroneckerProduct L hcomm (mul_one_of_comm L hcomm) hmul0 M _ _
  _ = kroneckerProduct M (fun _ => (Mat.one : Mat K (Idx 2))) :=
        kroneckerProduct_congr M _ _ fun _ _ _ =>
          exchangeMatrix_mul_halfExchangeMatrix L h hh hneg hneg_mul hneg_neg
  _ = Mat.one := kroneckerProduct_one (mul_one_of_comm L hcomm) L.mul_assoc (fun a => hcomm a 0)
        (zero_mul_of_comm hcomm hmul0) M

/-- 本文 `claim_kronecker_power_of_half_of_k_times_that_of_k_is_identity` の必要十分版。 -/
theorem kroneckerPowerOfHalfExchange_mul (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (h : K) (hh : (1 + 1) * h = 1) (M : ℕ) :
    Mat.mul L (isFiniteSet_powerSet M) (kroneckerPowerOfHalfExchange h M) (kroneckerPowerOfExchange M) = Mat.one := calc
  Mat.mul L (isFiniteSet_powerSet M) (kroneckerPowerOfHalfExchange h M) (kroneckerPowerOfExchange M)
      = kroneckerProduct M (fun _ => Mat.mul L isFiniteSet_two (halfExchangeMatrix h) exchangeMatrix) :=
        mul_kroneckerProduct L hcomm (mul_one_of_comm L hcomm) hmul0 M _ _
  _ = kroneckerProduct M (fun _ => (Mat.one : Mat K (Idx 2))) :=
        kroneckerProduct_congr M _ _ fun _ _ _ =>
          halfExchangeMatrix_mul_exchangeMatrix L h hh (mul_one_of_comm L hcomm) hneg hneg_mul
            (mul_neg_of_comm hcomm hneg_mul) hneg_neg
  _ = Mat.one := kroneckerProduct_one (mul_one_of_comm L hcomm) L.mul_assoc (fun a => hcomm a 0)
        (zero_mul_of_comm hcomm hmul0) M

/-! ### 生成作用素と消滅作用素の行列を U と U' で挟む -/

/-- 証明の族 G_k の必要十分版。 -/
def sumFactor (m k : ℕ) : Mat K (Idx 2) := if k = m then offDiagonalSum else creationFactor m k

/-- 証明の族 G'_k の必要十分版。 -/
def imaginarySumFactor (i : K) (m k : ℕ) : Mat K (Idx 2) :=
  if k = m then imaginaryOffDiagonalCombination i else creationFactor m k

/-- 二つの主張の（二）のうち k ≠ m の場合の必要十分版。 -/
theorem exchangeMatrix_mul_creationFactor_of_ne (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hneg_neg : ∀ a : K, -(-a) = a)
    (m k : ℕ) (hkm : k ≠ m) (F : Mat K (Idx 2)) (hF : F = if k < m then pauliX else Mat.one) :
    Mat.mul L isFiniteSet_two exchangeMatrix (creationFactor m k) = Mat.mul L isFiniteSet_two F exchangeMatrix := by
  rcases Nat.lt_or_gt_of_ne hkm with hlt | hgt
  · rw [creationFactor_of_lt hlt, hF, if_pos hlt]
    exact exchangeMatrix_mul_pauliZ L hmul0 (mul_one_of_comm L hcomm) (zero_mul_of_comm hcomm hmul0) hneg_mul hneg_neg
  · rw [creationFactor_of_gt hgt, hF, if_neg (by omega)]
    calc Mat.mul L isFiniteSet_two exchangeMatrix Mat.one
        = exchangeMatrix := mat_mul_one L (fun a => hcomm 0 a) (fun a => hcomm 1 a) isFiniteSet_two _
      _ = Mat.mul L isFiniteSet_two Mat.one exchangeMatrix := (mat_one_mul L isFiniteSet_two _).symm

/-- 本文 `claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix` の必要十分版。 -/
theorem conjugation_creation_add_annihilation (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (h : K) (hh : (1 + 1) * h = 1) (n : K) (hn : (-1 : K) = n)
    (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    conjugation L (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange h M)
      (Mat.add (creationMatrix n M m hm) (annihilationMatrix n M m hm)) = jordanWignerZ M m := by
  let hX := isFiniteSet_powerSet M
  let U : Mat K (PowerSet M) := kroneckerPowerOfExchange M
  let U' := kroneckerPowerOfHalfExchange h M
  let B := matricesVectorSpace L (PowerSet M)
  have hmul1 := mul_one_of_comm L hcomm
  have h0mul := zero_mul_of_comm hcomm hmul0
  have hcn : ∀ a : K, a * (-1) = (-1) * a := fun a => hcomm a (-1)
  -- （一）
  have h1 : Mat.add (creationMatrix n M m hm) (annihilationMatrix n M m hm) = kroneckerProduct M (sumFactor m) := calc
    Mat.add (creationMatrix n M m hm) (annihilationMatrix n M m hm)
        = Mat.add (Mat.smul 1 (creationMatrix n M m hm)) (Mat.smul 1 (annihilationMatrix n M m hm)) := by
          rw [show Mat.smul 1 (creationMatrix n M m hm) = creationMatrix n M m hm from B.one_smul _,
            show Mat.smul 1 (annihilationMatrix n M m hm) = annihilationMatrix n M m hm from B.one_smul _]
    _ = Mat.add (Mat.smul 1 (kroneckerProduct M (creationFactor m)))
          (Mat.smul 1 (kroneckerProduct M (annihilationFactor m))) := by
          rw [creationMatrix_eq_kroneckerProduct hmul1 hmul0 h0mul L.mul_assoc hcn n hn M m hm,
            annihilationMatrix_eq_kroneckerProduct hmul1 hmul0 h0mul L.mul_assoc hcn (fun a => hcomm 0 a)
              (fun a => hcomm 1 a) n hn M m hm]
    _ = kroneckerProduct M (sumFactor m) :=
        (kroneckerProduct_linear_in_one_factor L.left_distrib L.right_distrib L.mul_assoc M m hm.1 hm.2 1 1
          (fun a => hcomm a 1) (fun a => hcomm a 1) (creationFactor m) (annihilationFactor m) (sumFactor m)
          (fun k _ _ hkm => ⟨(annihilationFactor_of_ne hkm).symm, (if_neg hkm : (sumFactor m k : Mat K (Idx 2)) = _).symm⟩)
          (by
            show (if m = m then offDiagonalSum else creationFactor m m) = _
            rw [if_pos rfl, creationFactor_self, annihilationFactor_self]
            rfl)).symm
  -- （二）
  have h2 : ∀ k : ℕ, Mat.mul L isFiniteSet_two exchangeMatrix (sumFactor m k)
      = Mat.mul L isFiniteSet_two (jordanWignerZFactor m k) exchangeMatrix := by
    intro k
    by_cases hkm : k = m
    · subst hkm
      rw [show (sumFactor k k : Mat K (Idx 2)) = offDiagonalSum from if_pos rfl,
        show (jordanWignerZFactor k k : Mat K (Idx 2)) = pauliZ by
          unfold jordanWignerZFactor; rw [if_neg (lt_irrefl k), if_pos rfl]]
      exact exchangeMatrix_mul_offDiagonalSum L hmul0 hmul1 h0mul hneg_mul hneg_neg
    · rw [show (sumFactor m k : Mat K (Idx 2)) = creationFactor m k from if_neg hkm]
      apply exchangeMatrix_mul_creationFactor_of_ne L hcomm hmul0 hneg_mul hneg_neg m k hkm
      unfold jordanWignerZFactor
      by_cases hlt : k < m
      · rw [if_pos hlt, if_pos hlt]
      · rw [if_neg hlt, if_neg hlt, if_neg hkm]
  calc conjugation L hX U U' (Mat.add (creationMatrix n M m hm) (annihilationMatrix n M m hm))
      = Mat.mul L hX (Mat.mul L hX U (Mat.add (creationMatrix n M m hm) (annihilationMatrix n M m hm))) U' := rfl
    _ = Mat.mul L hX (Mat.mul L hX U (kroneckerProduct M (sumFactor m))) U' := by rw [h1]
    _ = Mat.mul L hX (Mat.mul L hX (kroneckerProduct M (fun _ => exchangeMatrix))
          (kroneckerProduct M (sumFactor m))) U' := rfl
    _ = Mat.mul L hX (kroneckerProduct M (fun k => Mat.mul L isFiniteSet_two exchangeMatrix (sumFactor m k))) U' := by
        rw [mul_kroneckerProduct L hcomm hmul1 hmul0]
    _ = Mat.mul L hX (kroneckerProduct M
          (fun k => Mat.mul L isFiniteSet_two (jordanWignerZFactor m k) exchangeMatrix)) U' := by rw [funext h2]
    _ = Mat.mul L hX (Mat.mul L hX (kroneckerProduct M (jordanWignerZFactor m))
          (kroneckerProduct M (fun _ => exchangeMatrix))) U' := by rw [mul_kroneckerProduct L hcomm hmul1 hmul0]
    _ = Mat.mul L hX (Mat.mul L hX (jordanWignerZ M m) (kroneckerProduct M (fun _ => exchangeMatrix))) U' := rfl
    _ = Mat.mul L hX (Mat.mul L hX (jordanWignerZ M m) U) U' := rfl
    _ = Mat.mul L hX (jordanWignerZ M m) (Mat.mul L hX U U') := mat_mul_assoc L hcomm hmul0 hX _ _ _
    _ = Mat.mul L hX (jordanWignerZ M m) Mat.one := by
        rw [kroneckerPowerOfExchange_mul_half L hcomm hmul0 hneg hneg_mul hneg_neg h hh M]
    _ = jordanWignerZ M m := mat_mul_one L (fun a => hcomm 0 a) (fun a => hcomm 1 a) hX _

/-- 本文 `claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix` の
必要十分版。 -/
theorem conjugation_imaginary_combination (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (h : K) (hh : (1 + 1) * h = 1) (n : K) (hn : (-1 : K) = n) (i : K)
    (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    conjugation L (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange h M)
      (Mat.add (Mat.smul (-i) (creationMatrix n M m hm)) (Mat.smul i (annihilationMatrix n M m hm)))
      = jordanWignerY i M m := by
  let hX := isFiniteSet_powerSet M
  let U : Mat K (PowerSet M) := kroneckerPowerOfExchange M
  let U' := kroneckerPowerOfHalfExchange h M
  let H := Mat.add (Mat.smul (-i) (creationMatrix n M m hm)) (Mat.smul i (annihilationMatrix n M m hm))
  have hmul1 := mul_one_of_comm L hcomm
  have h0mul := zero_mul_of_comm hcomm hmul0
  have hcn : ∀ a : K, a * (-1) = (-1) * a := fun a => hcomm a (-1)
  -- （一）
  have h1 : H = kroneckerProduct M (imaginarySumFactor i m) := calc
    H = Mat.add (Mat.smul (-i) (kroneckerProduct M (creationFactor m)))
          (Mat.smul i (kroneckerProduct M (annihilationFactor m))) := by
          show Mat.add (Mat.smul (-i) (creationMatrix n M m hm)) (Mat.smul i (annihilationMatrix n M m hm)) = _
          rw [creationMatrix_eq_kroneckerProduct hmul1 hmul0 h0mul L.mul_assoc hcn n hn M m hm,
            annihilationMatrix_eq_kroneckerProduct hmul1 hmul0 h0mul L.mul_assoc hcn (fun a => hcomm 0 a)
              (fun a => hcomm 1 a) n hn M m hm]
    _ = kroneckerProduct M (imaginarySumFactor i m) :=
        (kroneckerProduct_linear_in_one_factor L.left_distrib L.right_distrib L.mul_assoc M m hm.1 hm.2 (-i) i
          (fun a => hcomm a (-i)) (fun a => hcomm a i) (creationFactor m) (annihilationFactor m)
          (imaginarySumFactor i m)
          (fun k _ _ hkm => ⟨(annihilationFactor_of_ne hkm).symm, (if_neg hkm : imaginarySumFactor i m k = _).symm⟩)
          (by
            show (if m = m then imaginaryOffDiagonalCombination i else creationFactor m m) = _
            rw [if_pos rfl, creationFactor_self, annihilationFactor_self]
            rfl)).symm
  -- （二）
  have h2 : ∀ k : ℕ, Mat.mul L isFiniteSet_two exchangeMatrix (imaginarySumFactor i m k)
      = Mat.mul L isFiniteSet_two (jordanWignerYFactor i m k) exchangeMatrix := by
    intro k
    by_cases hkm : k = m
    · subst hkm
      rw [show imaginarySumFactor i k k = imaginaryOffDiagonalCombination i from if_pos rfl,
        show jordanWignerYFactor i k k = pauliY i by
          unfold jordanWignerYFactor; rw [if_neg (lt_irrefl k), if_pos rfl]]
      exact exchangeMatrix_mul_imaginaryOffDiagonalCombination L hmul0 hmul1 h0mul hneg_mul
        (mul_neg_of_comm hcomm hneg_mul) hneg_neg i
    · rw [show imaginarySumFactor i m k = creationFactor m k from if_neg hkm]
      apply exchangeMatrix_mul_creationFactor_of_ne L hcomm hmul0 hneg_mul hneg_neg m k hkm
      unfold jordanWignerYFactor
      by_cases hlt : k < m
      · rw [if_pos hlt, if_pos hlt]
      · rw [if_neg hlt, if_neg hlt, if_neg hkm]
  calc conjugation L hX U U' H
      = Mat.mul L hX (Mat.mul L hX U H) U' := rfl
    _ = Mat.mul L hX (Mat.mul L hX U (kroneckerProduct M (imaginarySumFactor i m))) U' := by rw [h1]
    _ = Mat.mul L hX (Mat.mul L hX (kroneckerProduct M (fun _ => exchangeMatrix))
          (kroneckerProduct M (imaginarySumFactor i m))) U' := rfl
    _ = Mat.mul L hX (kroneckerProduct M
          (fun k => Mat.mul L isFiniteSet_two exchangeMatrix (imaginarySumFactor i m k))) U' := by
        rw [mul_kroneckerProduct L hcomm hmul1 hmul0]
    _ = Mat.mul L hX (kroneckerProduct M
          (fun k => Mat.mul L isFiniteSet_two (jordanWignerYFactor i m k) exchangeMatrix)) U' := by rw [funext h2]
    _ = Mat.mul L hX (Mat.mul L hX (kroneckerProduct M (jordanWignerYFactor i m))
          (kroneckerProduct M (fun _ => exchangeMatrix))) U' := by rw [mul_kroneckerProduct L hcomm hmul1 hmul0]
    _ = Mat.mul L hX (Mat.mul L hX (jordanWignerY i M m) (kroneckerProduct M (fun _ => exchangeMatrix))) U' := rfl
    _ = Mat.mul L hX (Mat.mul L hX (jordanWignerY i M m) U) U' := rfl
    _ = Mat.mul L hX (jordanWignerY i M m) (Mat.mul L hX U U') := mat_mul_assoc L hcomm hmul0 hX _ _ _
    _ = Mat.mul L hX (jordanWignerY i M m) Mat.one := by
        rw [kroneckerPowerOfExchange_mul_half L hcomm hmul0 hneg hneg_mul hneg_neg h hh M]
    _ = jordanWignerY i M m := mat_mul_one L (fun a => hcomm 0 a) (fun a => hcomm 1 a) hX _

end CliffordMatrixIsomorphism.NecSuf.Isomorphism
