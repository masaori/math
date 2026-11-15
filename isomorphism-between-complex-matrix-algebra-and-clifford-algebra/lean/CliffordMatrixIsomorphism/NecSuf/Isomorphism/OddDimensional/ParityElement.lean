/-
章「同型の証明」の系「奇数次元の二次空間」のうち、分裂した二次空間のクリフォード代数の中の符号の因子 χ_i と、
その番号順の積 ε についての定義と主張の必要十分版。具体版 `Isomorphism/OddDimensional/ParityElement.lean` と同じ def・calc の行を、
係数 ℂ を型の変数 K に、-1_ℂ を K の元 n に替えて書く（χ_i := a_i a†_i + n ∗ (a†_i a_i)）。
本文のラベルと宣言の対応は具体版の冒頭の表と同じである（宣言の名前も同じ）。

どの主張も、Cl(V,q) を K の上の代数にするための章「クリフォード代数」の仮定 `CliffordLaws K n` を持つ。
定義の二つを除く主張は、生成元の反交換関係と平方が零であることを引くので、a + (-a) = 0（`hneg`）を仮定に持つ。
そのほかに行の中で `CliffordLaws K n` の欄から使う K の性質:

  parityFactor_mul_annihilation      0 + 0 = 0（a ·_A 0_A = 0_A）、a · 0 = 0（λ ∗_A 0_A = 0_A）
  annihilation_mul_parityFactor      0 + 0 = 0（0_A ·_A a = 0_A）
  parityFactor_mul_creation          0 + 0 = 0
  creation_mul_parityFactor          0 + 0 = 0、a · 0 = 0、n · n = 1
  parityFactor_mul_self              n · n = 1
  mul_parityFactor_comm_of_ne        0 + 0 = 0（0_ℂ ∗_A 1_A = 0_A と、反交換する二元の入れ替え）、1 + n = 0（入れ替え）、n · n = 1
  parityFactor_comm_of_ne            前の主張を引くだけ
  parityElement_mul_self             前の二つの主張を引くだけ
  mul_parityElement_of_generator     前の主張を引くだけ（番号順の積の分解と交換は係数の性質を使わない）
  γ_anticommute_parityElement        n + 1 = 0（n + 1 = 1 + n と 1 + n = 0 から）、0 + 0 = 0、a · 0 = 0

分かったこと:
- ε の主張は、係数について章「クリフォード代数」の仮定と a + (-a) = 0 のほかに何も足さない。
  -1_ℂ の役をする n に要るのは、本文が「ℂ の四則」で済ませた (-1)·(-1) = 1（n · n = 1）と (-1) + 1 = 0（n + 1 = 0）だけである。
- 2 の可逆性（1 + 1 ≠ 0）と平方根は、どの主張も使わない。K の乗法の交換法則も、行の中では使わない
  （Cl(V,q) を K の上の代数にするための `CliffordLaws` の欄としてだけ持つ）。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（M = 0 でも同じ証明が通る）。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.CommutingElements
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GlobalIdentities.GlobalIdentities
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.InducedHomomorphism

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-! ### 定義 -/

/-- 本文 `def_parity_factor_of_split_clifford_algebra` の必要十分版：χ_i := a_i ·_A a†_i +_A n ∗_A (a†_i ·_A a_i)。 -/
def parityFactor (i : ℕ) : (D.space C).Cl C :=
  ((D.space C).cliffordAlgebra C).add (((D.space C).cliffordAlgebra C).mul (D.annihilation C i) (D.creation C i))
    (((D.space C).cliffordAlgebra C).smul n
      (((D.space C).cliffordAlgebra C).mul (D.creation C i) (D.annihilation C i)))

/-- 本文 `def_parity_element_of_split_clifford_algebra` の必要十分版：ε := ∏_{A,i=1}^{M} χ_i。 -/
def parityElement : (D.space C).Cl C :=
  NecSuf.AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) D.M (D.parityFactor C)

/-! ### 同じ番号の生成元との積 -/

/-- 本文 `claim_parity_factor_times_annihilation_generator` の必要十分版：χ_i ·_A a_i = a_i。 -/
theorem parityFactor_mul_annihilation (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.parityFactor C i) (D.annihilation C i) = D.annihilation C i := by
  let A := (D.space C).cliffordAlgebra C
  let a := D.annihilation C i
  let c := D.creation C i
  calc A.mul (D.parityFactor C i) a
      = A.mul (A.add (A.mul a c) (A.smul n (A.mul c a))) a := rfl
    _ = A.add (A.mul (A.mul a c) a) (A.mul (A.smul n (A.mul c a)) a) := A.right_distrib _ _ _
    _ = A.add (A.mul (D.vacuumFactor C i) a) (A.mul (A.smul n (A.mul c a)) a) := rfl
    _ = A.add a (A.mul (A.smul n (A.mul c a)) a) := by rw [D.vacuumFactor_mul_annihilation C hneg hi]
    _ = A.add a (A.smul n (A.mul (A.mul c a) a)) := by rw [A.smul_mul_left n (A.mul c a) a]
    _ = A.add a (A.smul n (A.mul c (A.mul a a))) := by rw [A.mul_assoc c a a]
    _ = A.add a (A.smul n (A.mul c A.zero)) := by rw [D.annihilation_mul_self C hneg i]
    _ = A.add a (A.smul n A.zero) := by rw [mul_zero_eq_zero C.congruence.zero_add_zero A c]
    _ = A.add a A.zero := by rw [smul_zero_eq_zero A C.congruence.zero_add_zero C.uniqueness.mul_zero n]
    _ = a := A.add_zero a

/-- 本文 `claim_annihilation_generator_anticommutes_with_parity_factor` の必要十分版：a_i ·_A χ_i = n ∗_A (χ_i ·_A a_i)。 -/
theorem annihilation_mul_parityFactor (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.annihilation C i) (D.parityFactor C i)
      = ((D.space C).cliffordAlgebra C).smul n
          (((D.space C).cliffordAlgebra C).mul (D.parityFactor C i) (D.annihilation C i)) := by
  let A := (D.space C).cliffordAlgebra C
  let a := D.annihilation C i
  let c := D.creation C i
  calc A.mul a (D.parityFactor C i)
      = A.mul a (A.add (A.mul a c) (A.smul n (A.mul c a))) := rfl
    _ = A.add (A.mul a (A.mul a c)) (A.mul a (A.smul n (A.mul c a))) := A.left_distrib _ _ _
    _ = A.add (A.mul (A.mul a a) c) (A.mul a (A.smul n (A.mul c a))) := by rw [A.mul_assoc a a c]
    _ = A.add (A.mul A.zero c) (A.mul a (A.smul n (A.mul c a))) := by rw [D.annihilation_mul_self C hneg i]
    _ = A.add A.zero (A.mul a (A.smul n (A.mul c a))) := by rw [zero_mul_eq_zero C.congruence.zero_add_zero A c]
    _ = A.add (A.mul a (A.smul n (A.mul c a))) A.zero := A.add_comm _ _
    _ = A.mul a (A.smul n (A.mul c a)) := A.add_zero _
    _ = A.smul n (A.mul a (A.mul c a)) := (A.smul_mul_right n a (A.mul c a)).symm
    _ = A.smul n (A.mul (A.mul a c) a) := by rw [A.mul_assoc a c a]
    _ = A.smul n (A.mul (D.vacuumFactor C i) a) := rfl
    _ = A.smul n a := by rw [D.vacuumFactor_mul_annihilation C hneg hi]
    _ = A.smul n (A.mul (D.parityFactor C i) a) := by rw [D.parityFactor_mul_annihilation C hneg hi]

/-- 本文 `claim_parity_factor_times_creation_generator` の必要十分版：χ_i ·_A a†_i = n ∗_A a†_i。 -/
theorem parityFactor_mul_creation (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.parityFactor C i) (D.creation C i)
      = ((D.space C).cliffordAlgebra C).smul n (D.creation C i) := by
  let A := (D.space C).cliffordAlgebra C
  let a := D.annihilation C i
  let c := D.creation C i
  calc A.mul (D.parityFactor C i) c
      = A.mul (A.add (A.mul a c) (A.smul n (A.mul c a))) c := rfl
    _ = A.add (A.mul (A.mul a c) c) (A.mul (A.smul n (A.mul c a)) c) := A.right_distrib _ _ _
    _ = A.add (A.mul a (A.mul c c)) (A.mul (A.smul n (A.mul c a)) c) := by rw [A.mul_assoc a c c]
    _ = A.add (A.mul a A.zero) (A.mul (A.smul n (A.mul c a)) c) := by rw [D.creation_mul_self C hneg i]
    _ = A.add A.zero (A.mul (A.smul n (A.mul c a)) c) := by rw [mul_zero_eq_zero C.congruence.zero_add_zero A a]
    _ = A.add (A.mul (A.smul n (A.mul c a)) c) A.zero := A.add_comm _ _
    _ = A.mul (A.smul n (A.mul c a)) c := A.add_zero _
    _ = A.smul n (A.mul (A.mul c a) c) := (A.smul_mul_left n (A.mul c a) c).symm
    _ = A.smul n (A.mul c (A.mul a c)) := by rw [A.mul_assoc c a c]
    _ = A.smul n (A.mul c (D.vacuumFactor C i)) := rfl
    _ = A.smul n c := by rw [D.creation_mul_vacuumFactor C hneg hi]

/-- 本文 `claim_creation_generator_anticommutes_with_parity_factor` の必要十分版：a†_i ·_A χ_i = n ∗_A (χ_i ·_A a†_i)。 -/
theorem creation_mul_parityFactor (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.creation C i) (D.parityFactor C i)
      = ((D.space C).cliffordAlgebra C).smul n
          (((D.space C).cliffordAlgebra C).mul (D.parityFactor C i) (D.creation C i)) := by
  let A := (D.space C).cliffordAlgebra C
  let a := D.annihilation C i
  let c := D.creation C i
  calc A.mul c (D.parityFactor C i)
      = A.mul c (A.add (A.mul a c) (A.smul n (A.mul c a))) := rfl
    _ = A.add (A.mul c (A.mul a c)) (A.mul c (A.smul n (A.mul c a))) := A.left_distrib _ _ _
    _ = A.add (A.mul c (D.vacuumFactor C i)) (A.mul c (A.smul n (A.mul c a))) := rfl
    _ = A.add c (A.mul c (A.smul n (A.mul c a))) := by rw [D.creation_mul_vacuumFactor C hneg hi]
    _ = A.add c (A.smul n (A.mul c (A.mul c a))) := by rw [← A.smul_mul_right n c (A.mul c a)]
    _ = A.add c (A.smul n (A.mul (A.mul c c) a)) := by rw [A.mul_assoc c c a]
    _ = A.add c (A.smul n (A.mul A.zero a)) := by rw [D.creation_mul_self C hneg i]
    _ = A.add c (A.smul n A.zero) := by rw [zero_mul_eq_zero C.congruence.zero_add_zero A a]
    _ = A.add c A.zero := by rw [smul_zero_eq_zero A C.congruence.zero_add_zero C.uniqueness.mul_zero n]
    _ = c := A.add_zero c
    _ = A.smul 1 c := (A.one_smul c).symm
    -- 本文の「ℂ の四則」(-1_ℂ)·(-1_ℂ) = 1_ℂ の行
    _ = A.smul (n * n) c := by rw [C.congruence.n_mul_n]
    _ = A.smul n (A.smul n c) := A.smul_assoc n n c
    _ = A.smul n (A.mul (D.parityFactor C i) c) := by rw [D.parityFactor_mul_creation C hneg hi]

/-- 本文 `claim_square_of_parity_factor_is_one` の必要十分版：χ_i ·_A χ_i = 1_A。 -/
theorem parityFactor_mul_self (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.parityFactor C i) (D.parityFactor C i)
      = ((D.space C).cliffordAlgebra C).one := by
  let A := (D.space C).cliffordAlgebra C
  let a := D.annihilation C i
  let c := D.creation C i
  let χ := D.parityFactor C i
  calc A.mul χ χ
      = A.mul χ (A.add (A.mul a c) (A.smul n (A.mul c a))) := rfl
    _ = A.add (A.mul χ (A.mul a c)) (A.mul χ (A.smul n (A.mul c a))) := A.left_distrib _ _ _
    _ = A.add (A.mul (A.mul χ a) c) (A.mul χ (A.smul n (A.mul c a))) := by rw [A.mul_assoc χ a c]
    _ = A.add (A.mul a c) (A.mul χ (A.smul n (A.mul c a))) := by
        rw [D.parityFactor_mul_annihilation C hneg hi]
    _ = A.add (A.mul a c) (A.smul n (A.mul χ (A.mul c a))) := by
        rw [← A.smul_mul_right n χ (A.mul c a)]
    _ = A.add (A.mul a c) (A.smul n (A.mul (A.mul χ c) a)) := by rw [A.mul_assoc χ c a]
    _ = A.add (A.mul a c) (A.smul n (A.mul (A.smul n c) a)) := by rw [D.parityFactor_mul_creation C hneg hi]
    _ = A.add (A.mul a c) (A.smul n (A.smul n (A.mul c a))) := by rw [A.smul_mul_left n c a]
    _ = A.add (A.mul a c) (A.smul (n * n) (A.mul c a)) := by rw [A.smul_assoc n n (A.mul c a)]
    -- 本文の「ℂ の四則」(-1_ℂ)·(-1_ℂ) = 1_ℂ の行
    _ = A.add (A.mul a c) (A.smul 1 (A.mul c a)) := by rw [C.congruence.n_mul_n]
    _ = A.add (A.mul a c) (A.mul c a) := by rw [A.one_smul (A.mul c a)]
    _ = A.smul (kroneckerDelta i i) A.one := D.annihilation_creation_anticommute C hneg i i hi.1 hi.2 hi.1 hi.2
    _ = A.smul 1 A.one := by rw [kroneckerDelta, if_pos rfl]
    _ = A.one := A.one_smul A.one

/-! ### 番号の違う因子との交換 -/

/-- 本文 `claim_generators_commute_with_parity_factor_of_other_number` の必要十分版：
i ≠ k で y = a_k か y = a†_k なら y ·_A χ_i = χ_i ·_A y。 -/
theorem mul_parityFactor_comm_of_ne (hneg : ∀ a : K, a + -a = 0) {i k : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (hk : 1 ≤ k ∧ k ≤ D.M) (hik : i ≠ k) {y : (D.space C).Cl C}
    (hy : y = D.annihilation C k ∨ y = D.creation C k) :
    ((D.space C).cliffordAlgebra C).mul y (D.parityFactor C i)
      = ((D.space C).cliffordAlgebra C).mul (D.parityFactor C i) y := by
  let A := (D.space C).cliffordAlgebra C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  -- 準備：δ_{k,i} = δ_{i,k} = 0
  have hδki : (kroneckerDelta k i : K) = 0 := by rw [kroneckerDelta, if_neg (Ne.symm hik)]
  have hδik : (kroneckerDelta i k : K) = 0 := by rw [kroneckerDelta, if_neg hik]
  -- 準備：y は a_i とも a†_i とも反交換する
  have hprep : A.add (A.mul y (D.annihilation C i)) (A.mul (D.annihilation C i) y) = A.zero ∧
      A.add (A.mul y (D.creation C i)) (A.mul (D.creation C i) y) = A.zero := by
    rcases hy with rfl | rfl
    · refine ⟨D.annihilation_anticommute C hneg k i, ?_⟩
      calc A.add (A.mul (D.annihilation C k) (D.creation C i)) (A.mul (D.creation C i) (D.annihilation C k))
          = A.smul (kroneckerDelta k i) A.one := D.annihilation_creation_anticommute C hneg k i hk.1 hk.2 hi.1 hi.2
        _ = A.smul 0 A.one := by rw [hδki]
        _ = A.zero := zero_smul_eq_zero A h00 A.one
    · refine ⟨?_, D.creation_anticommute C hneg k i⟩
      calc A.add (A.mul (D.creation C k) (D.annihilation C i)) (A.mul (D.annihilation C i) (D.creation C k))
          = A.add (A.mul (D.annihilation C i) (D.creation C k)) (A.mul (D.creation C k) (D.annihilation C i)) :=
            A.add_comm _ _
        _ = A.smul (kroneckerDelta i k) A.one := D.annihilation_creation_anticommute C hneg i k hi.1 hi.2 hk.1 hk.2
        _ = A.smul 0 A.one := by rw [hδik]
        _ = A.zero := zero_smul_eq_zero A h00 A.one
  -- C_y は部分代数で、a_i a†_i・a†_i a_i が C_y に属する
  have hC : IsSubalgebra A (commutingElements A y) := commutingElements_isSubalgebra A y
  have h1 : A.mul (D.annihilation C i) (D.creation C i) ∈ commutingElements A y :=
    mul_comm_of_anticommute_both h00 n C.congruence.one_add_n C.congruence.n_mul_n A y
      (D.annihilation C i) (D.creation C i) hprep.1 hprep.2
  have h2 : A.mul (D.creation C i) (D.annihilation C i) ∈ commutingElements A y :=
    mul_comm_of_anticommute_both h00 n C.congruence.one_add_n C.congruence.n_mul_n A y
      (D.creation C i) (D.annihilation C i) hprep.2 hprep.1
  -- C_y はスカラー倍と加法で閉じている
  have h3 : A.smul n (A.mul (D.creation C i) (D.annihilation C i)) ∈ commutingElements A y :=
    hC.smul_mem n _ h2
  have h4 : D.parityFactor C i ∈ commutingElements A y := hC.add_mem _ _ h1 h3
  exact h4

/-- 本文 `claim_parity_factors_with_different_numbers_commute` の必要十分版：i ≠ k なら χ_k ·_A χ_i = χ_i ·_A χ_k。 -/
theorem parityFactor_comm_of_ne (hneg : ∀ a : K, a + -a = 0) {i k : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (hk : 1 ≤ k ∧ k ≤ D.M) (hik : i ≠ k) :
    ((D.space C).cliffordAlgebra C).mul (D.parityFactor C k) (D.parityFactor C i)
      = ((D.space C).cliffordAlgebra C).mul (D.parityFactor C i) (D.parityFactor C k) := by
  let A := (D.space C).cliffordAlgebra C
  have hC : IsSubalgebra A (commutingElements A (D.parityFactor C k)) := commutingElements_isSubalgebra A _
  -- 前の主張を i と k の役を替えて当てる
  have ha : D.annihilation C i ∈ commutingElements A (D.parityFactor C k) :=
    (D.mul_parityFactor_comm_of_ne C hneg hk hi (Ne.symm hik) (Or.inl rfl)).symm
  have hc : D.creation C i ∈ commutingElements A (D.parityFactor C k) :=
    (D.mul_parityFactor_comm_of_ne C hneg hk hi (Ne.symm hik) (Or.inr rfl)).symm
  have h1 : A.mul (D.annihilation C i) (D.creation C i) ∈ commutingElements A (D.parityFactor C k) :=
    hC.mul_mem _ _ ha hc
  have h2 : A.mul (D.creation C i) (D.annihilation C i) ∈ commutingElements A (D.parityFactor C k) :=
    hC.mul_mem _ _ hc ha
  have h3 : A.smul n (A.mul (D.creation C i) (D.annihilation C i)) ∈ commutingElements A (D.parityFactor C k) :=
    hC.smul_mem n _ h2
  have h4 : D.parityFactor C i ∈ commutingElements A (D.parityFactor C k) := hC.add_mem _ _ h1 h3
  exact h4

/-! ### ε の平方と、生成元との反交換 -/

/-- 本文 `claim_square_of_parity_element_is_one` の必要十分版：ε ·_A ε = 1_A。 -/
theorem parityElement_mul_self (hneg : ∀ a : K, a + -a = 0) :
    ((D.space C).cliffordAlgebra C).mul (D.parityElement C) (D.parityElement C)
      = ((D.space C).cliffordAlgebra C).one := by
  let A := (D.space C).cliffordAlgebra C
  have hm : ∀ m : ℕ, m ≤ D.M →
      A.mul (NecSuf.AlgebraOver.partialOrderedProduct A (D.parityFactor C) m)
        (NecSuf.AlgebraOver.partialOrderedProduct A (D.parityFactor C) m) = A.one := by
    intro m
    induction m with
    | zero =>
      intro _
      calc A.mul (NecSuf.AlgebraOver.partialOrderedProduct A (D.parityFactor C) 0)
            (NecSuf.AlgebraOver.partialOrderedProduct A (D.parityFactor C) 0)
          = A.mul A.one (NecSuf.AlgebraOver.partialOrderedProduct A (D.parityFactor C) 0) := rfl
        _ = NecSuf.AlgebraOver.partialOrderedProduct A (D.parityFactor C) 0 := A.one_mul _
        _ = A.one := rfl
    | succ m ih =>
      intro hmM
      let P := NecSuf.AlgebraOver.partialOrderedProduct A (D.parityFactor C) m
      let χ := D.parityFactor C (m + 1)
      -- 準備：χ_m ·_A Π_{m-1} = Π_{m-1} ·_A χ_m
      have hcomm : A.mul χ P = A.mul P χ :=
        commute_orderedProduct A χ m (D.parityFactor C)
          (fun s hs1 hsm => D.parityFactor_comm_of_ne C hneg ⟨hs1, by omega⟩ ⟨Nat.succ_pos m, hmM⟩ (by omega))
      calc A.mul (NecSuf.AlgebraOver.partialOrderedProduct A (D.parityFactor C) (m + 1))
            (NecSuf.AlgebraOver.partialOrderedProduct A (D.parityFactor C) (m + 1))
          = A.mul (A.mul P χ) (A.mul P χ) := rfl
        _ = A.mul P (A.mul χ (A.mul P χ)) := A.mul_assoc _ _ _
        _ = A.mul P (A.mul (A.mul χ P) χ) := by rw [A.mul_assoc χ P χ]
        _ = A.mul P (A.mul (A.mul P χ) χ) := by rw [hcomm]
        _ = A.mul P (A.mul P (A.mul χ χ)) := by rw [A.mul_assoc P χ χ]
        _ = A.mul P (A.mul P A.one) := by rw [D.parityFactor_mul_self C hneg ⟨Nat.succ_pos m, hmM⟩]
        _ = A.mul P P := by rw [A.mul_one P]
        _ = A.one := ih (Nat.le_of_succ_le hmM)
  exact hm D.M le_rfl

/-- 本文 `claim_generators_anticommute_with_parity_element` の必要十分版：
k ∈ {1,…,M} で y = a_k か y = a†_k なら y ·_A ε = n ∗_A (ε ·_A y)。 -/
theorem mul_parityElement_of_generator (hneg : ∀ a : K, a + -a = 0) {k : ℕ} (hk : 1 ≤ k ∧ k ≤ D.M)
    {y : (D.space C).Cl C} (hy : y = D.annihilation C k ∨ y = D.creation C k) :
    ((D.space C).cliffordAlgebra C).mul y (D.parityElement C)
      = ((D.space C).cliffordAlgebra C).smul n (((D.space C).cliffordAlgebra C).mul (D.parityElement C) y) := by
  let A := (D.space C).cliffordAlgebra C
  let L := NecSuf.AlgebraOver.orderedProduct A (k - 1) (D.parityFactor C)
  let R := NecSuf.AlgebraOver.orderedProduct A (D.M - k) (fun r => D.parityFactor C (k + r))
  let χ := D.parityFactor C k
  -- 準備：ε = L ·_A (χ_k ·_A R)
  have hε : D.parityElement C = A.mul L (A.mul χ R) :=
    orderedProduct_singleOut A D.M k hk.1 hk.2 (D.parityFactor C)
  -- 準備：y ·_A L = L ·_A y、y ·_A R = R ·_A y
  have hL : A.mul y L = A.mul L y :=
    commute_orderedProduct A y (k - 1) (D.parityFactor C)
      (fun s hs1 hsk => D.mul_parityFactor_comm_of_ne C hneg ⟨hs1, by omega⟩ hk (by omega) hy)
  have hR : A.mul y R = A.mul R y :=
    commute_orderedProduct A y (D.M - k) (fun r => D.parityFactor C (k + r))
      (fun r hr1 hrk => D.mul_parityFactor_comm_of_ne C hneg ⟨by omega, by omega⟩ hk (by omega) hy)
  -- 準備：y ·_A χ_k = n ∗_A (χ_k ·_A y)
  have hχ : A.mul y χ = A.smul n (A.mul χ y) := by
    rcases hy with rfl | rfl
    · exact D.annihilation_mul_parityFactor C hneg hk
    · exact D.creation_mul_parityFactor C hneg hk
  calc A.mul y (D.parityElement C)
      = A.mul y (A.mul L (A.mul χ R)) := by rw [hε]
    _ = A.mul (A.mul y L) (A.mul χ R) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul L y) (A.mul χ R) := by rw [hL]
    _ = A.mul L (A.mul y (A.mul χ R)) := A.mul_assoc _ _ _
    _ = A.mul L (A.mul (A.mul y χ) R) := by rw [A.mul_assoc y χ R]
    _ = A.mul L (A.mul (A.smul n (A.mul χ y)) R) := by rw [hχ]
    _ = A.mul L (A.smul n (A.mul (A.mul χ y) R)) := by rw [A.smul_mul_left n (A.mul χ y) R]
    _ = A.smul n (A.mul L (A.mul (A.mul χ y) R)) := (A.smul_mul_right _ _ _).symm
    _ = A.smul n (A.mul L (A.mul χ (A.mul y R))) := by rw [A.mul_assoc χ y R]
    _ = A.smul n (A.mul L (A.mul χ (A.mul R y))) := by rw [hR]
    _ = A.smul n (A.mul L (A.mul (A.mul χ R) y)) := by rw [A.mul_assoc χ R y]
    _ = A.smul n (A.mul (A.mul L (A.mul χ R)) y) := by rw [A.mul_assoc L (A.mul χ R) y]
    _ = A.smul n (A.mul (D.parityElement C) y) := by rw [hε]

/-- 本文 `claim_image_of_split_space_anticommutes_with_parity_element` の必要十分版：
すべての v ∈ V について γ(v) ·_A ε +_A ε ·_A γ(v) = 0_A。 -/
theorem γ_anticommute_parityElement (hneg : ∀ a : K, a + -a = 0) (v : W × DualSpace D.spaceW) :
    ((D.space C).cliffordAlgebra C).add (((D.space C).cliffordAlgebra C).mul ((D.space C).γ C v) (D.parityElement C))
        (((D.space C).cliffordAlgebra C).mul (D.parityElement C) ((D.space C).γ C v))
      = ((D.space C).cliffordAlgebra C).zero := by
  let A := (D.space C).cliffordAlgebra C
  let Av := A.toVectorSpace
  let ε := D.parityElement C
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  -- 準備：k ∈ {1,…,M}、y ∈ {a_k, a†_k} について y ·_A ε +_A ε ·_A y = 0_A
  have hprep : ∀ k : ℕ, 1 ≤ k → k ≤ D.M → ∀ y : (D.space C).Cl C,
      (y = D.annihilation C k ∨ y = D.creation C k) → A.add (A.mul y ε) (A.mul ε y) = A.zero := by
    intro k hk1 hkM y hy
    calc A.add (A.mul y ε) (A.mul ε y)
        = A.add (A.smul n (A.mul ε y)) (A.mul ε y) := by
          rw [D.mul_parityElement_of_generator C hneg ⟨hk1, hkM⟩ hy]
      _ = A.add (A.smul n (A.mul ε y)) (A.smul 1 (A.mul ε y)) := by rw [A.one_smul (A.mul ε y)]
      _ = A.smul (n + 1) (A.mul ε y) := (A.add_smul _ _ _).symm
      -- 本文の「ℂ の四則」(-1_ℂ) + 1_ℂ = 0_ℂ の行
      _ = A.smul 0 (A.mul ε y) := by rw [C.congruence.n_add_one, C.congruence.one_add_n]
      _ = A.zero := zero_smul_eq_zero A h00 _
  obtain ⟨x, ξ⟩ := v
  let R₁ := linearCombination Av D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k x) (D.creation C)
  let R₂ := linearCombination Av D.M (fun k => ξ.1 (D.w k)) (D.annihilation C)
  have h₁ : A.add (A.mul R₁ ε) (A.mul ε R₁) = A.zero := calc
    A.add (A.mul R₁ ε) (A.mul ε R₁)
        = linearCombination Av D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k x)
            (fun l => A.add (A.mul (D.creation C l) ε) (A.mul ε (D.creation C l))) :=
          anticommutator_linearCombination h00 A ε D.M _ (D.creation C)
    _ = linearCombination Av D.M (fun k => coordinate D.spaceW D.M D.w D.isBasis k x) (fun _ => A.zero) :=
          linearCombination_eq_of_terms_eq Av D.M _ _ _ _
            (fun k hk1 hkM => by
              show A.smul _ (A.add (A.mul (D.creation C k) ε) (A.mul ε (D.creation C k))) = A.smul _ A.zero
              rw [hprep k hk1 hkM (D.creation C k) (Or.inr rfl)])
    _ = A.zero :=
          linearCombination_eq_zero_of_terms_eq_zero Av D.M _ _
            (fun k _ _ => smul_zero_eq_zero A h00 C.uniqueness.mul_zero _)
  have h₂ : A.add (A.mul R₂ ε) (A.mul ε R₂) = A.zero := calc
    A.add (A.mul R₂ ε) (A.mul ε R₂)
        = linearCombination Av D.M (fun k => ξ.1 (D.w k))
            (fun l => A.add (A.mul (D.annihilation C l) ε) (A.mul ε (D.annihilation C l))) :=
          anticommutator_linearCombination h00 A ε D.M _ (D.annihilation C)
    _ = linearCombination Av D.M (fun k => ξ.1 (D.w k)) (fun _ => A.zero) :=
          linearCombination_eq_of_terms_eq Av D.M _ _ _ _
            (fun k hk1 hkM => by
              show A.smul _ (A.add (A.mul (D.annihilation C k) ε) (A.mul ε (D.annihilation C k))) = A.smul _ A.zero
              rw [hprep k hk1 hkM (D.annihilation C k) (Or.inl rfl)])
    _ = A.zero :=
          linearCombination_eq_zero_of_terms_eq_zero Av D.M _ _
            (fun k _ _ => smul_zero_eq_zero A h00 C.uniqueness.mul_zero _)
  calc A.add (A.mul ((D.space C).γ C (x, ξ)) ε) (A.mul ε ((D.space C).γ C (x, ξ)))
      = A.add (A.mul (A.add R₁ R₂) ε) (A.mul ε (A.add R₁ R₂)) := by
        rw [D.γ_pair_eq_creation_add_annihilation C x ξ]
    _ = A.add (A.add (A.mul R₁ ε) (A.mul R₂ ε)) (A.add (A.mul ε R₁) (A.mul ε R₂)) := by
        rw [A.right_distrib R₁ R₂ ε, A.left_distrib ε R₁ R₂]
    _ = A.add (A.add (A.mul R₁ ε) (A.mul ε R₁)) (A.add (A.mul R₂ ε) (A.mul ε R₂)) :=
        rearrange_sum_of_two_sums Av _ _ _ _
    _ = A.add A.zero A.zero := by rw [h₁, h₂]
    _ = A.zero := A.add_zero A.zero

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
