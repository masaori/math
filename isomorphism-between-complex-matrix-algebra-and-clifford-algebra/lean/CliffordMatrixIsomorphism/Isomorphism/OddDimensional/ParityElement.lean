/-
章「同型の証明」の系「奇数次元の二次空間」のうち、分裂した二次空間のクリフォード代数 A := Cl(V,q) の中の
符号の因子 χ_i と、その番号順の積 ε についての定義と主張の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                  このファイル
  def_parity_factor_of_split_clifford_algebra                                   parityFactor（χ_i）
  def_parity_element_of_split_clifford_algebra                                  parityElement（ε）
  claim_parity_factor_times_annihilation_generator                              parityFactor_mul_annihilation
  claim_annihilation_generator_anticommutes_with_parity_factor                  annihilation_mul_parityFactor
  claim_parity_factor_times_creation_generator                                  parityFactor_mul_creation
  claim_creation_generator_anticommutes_with_parity_factor                      creation_mul_parityFactor
  claim_square_of_parity_factor_is_one                                          parityFactor_mul_self
  claim_generators_commute_with_parity_factor_of_other_number                   mul_parityFactor_comm_of_ne
  claim_parity_factors_with_different_numbers_commute                           parityFactor_comm_of_ne
  claim_square_of_parity_element_is_one                                         parityElement_mul_self
  claim_generators_anticommute_with_parity_element                              mul_parityElement_of_generator
  claim_image_of_split_space_anticommutes_with_parity_element                   γ_anticommute_parityElement

表し方:
- 本文の奇数次元の系の記号のうち、ここで使うのは def_clifford_algebra_of_split_space_in_odd_corollary の A := Cl(V,q)（分裂した二次空間の
  クリフォード代数 `D.space.cliffordAlgebra`）だけである。奇数次元の拡大 V'・A'（`def_clifford_algebra_of_odd_extension`）は
  どの主張も使わない。-1_ℂ（`def_minus_one_in_complex_numbers`）は ℂ の `-1` で書く。
  宣言は名前空間 `Clifford.SplitData` に置き、前提の組 D から `D.parityFactor i`・`D.parityElement` のように引く。
- 番号付けた族 χ は `ℕ → Cl` で表し、{1,…,M} の外の値は使わない。i ∈ {1,…,M} は `1 ≤ i ∧ i ≤ D.M` で書く。
  i ∈ {1,…,M} は、反交換関係 a_i a†_j + a†_j a_i = δ_{i,j} ∗ 1 を引く主張（x_i a_i = a_i・a†_i x_i = a†_i を経由するものを含む）だけが使う。
- 本文の「y = a_k と y = a†_k のそれぞれについて」は、仮定 y = a_k ∨ y = a†_k で書く。
- 本文の「族を {1,…,m-1} に制限した番号順の積」は、Lean では同じ族の `orderedProduct A (m-1)` で、部分積 Π_{m-1} と定義で一致する
  （本文 claim_partial_product_is_ordered_product_of_restricted_family）。帰納法の段 m は Lean では m + 1 と書く。
- 本文の V の元 v = (x, ξ) は `W × DualSpace D.spaceW` の元で、ξ(w_k) は `ξ.1 (D.w k)` である。
- 本文の「ℂ の四則」((-1_ℂ)·(-1_ℂ) = 1_ℂ、(-1_ℂ) + 1_ℂ = 0_ℂ）は ℂ の計算（`norm_num`）で書く。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わないので仮定に置かない（M = 0 でも同じ証明が通る）。

必要十分版は `NecSuf/Isomorphism/OddDimensional/ParityElement.lean`、導出版は `ParityElementFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.CommutingElements
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms
import CliffordMatrixIsomorphism.Isomorphism.GlobalIdentities.GlobalIdentities
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.InducedHomomorphism

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### 定義 -/

/-- 本文 `def_parity_factor_of_split_clifford_algebra`：χ_i := a_i ·_A a†_i +_A (-1_ℂ) ∗_A (a†_i ·_A a_i)。 -/
def parityFactor (i : ℕ) : D.space.Cl :=
  D.space.cliffordAlgebra.add (D.space.cliffordAlgebra.mul (D.annihilation i) (D.creation i))
    (D.space.cliffordAlgebra.smul (-1) (D.space.cliffordAlgebra.mul (D.creation i) (D.annihilation i)))

/-- 本文 `def_parity_element_of_split_clifford_algebra`：ε := ∏_{A,i=1}^{M} χ_i。 -/
def parityElement : D.space.Cl :=
  ComplexAlgebra.orderedProduct D.space.cliffordAlgebra D.M D.parityFactor

/-! ### 同じ番号の生成元との積 -/

/-- 本文 `claim_parity_factor_times_annihilation_generator`：χ_i ·_A a_i = a_i。 -/
theorem parityFactor_mul_annihilation {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.parityFactor i) (D.annihilation i) = D.annihilation i := by
  let A := D.space.cliffordAlgebra
  let a := D.annihilation i
  let c := D.creation i
  calc A.mul (D.parityFactor i) a
      = A.mul (A.add (A.mul a c) (A.smul (-1) (A.mul c a))) a := rfl
    _ = A.add (A.mul (A.mul a c) a) (A.mul (A.smul (-1) (A.mul c a)) a) := A.right_distrib _ _ _
    _ = A.add (A.mul (D.vacuumFactor i) a) (A.mul (A.smul (-1) (A.mul c a)) a) := rfl
    _ = A.add a (A.mul (A.smul (-1) (A.mul c a)) a) := by rw [D.vacuumFactor_mul_annihilation hi]
    _ = A.add a (A.smul (-1) (A.mul (A.mul c a) a)) := by rw [A.smul_mul_left (-1) (A.mul c a) a]
    _ = A.add a (A.smul (-1) (A.mul c (A.mul a a))) := by rw [A.mul_assoc c a a]
    _ = A.add a (A.smul (-1) (A.mul c A.zero)) := by rw [D.annihilation_mul_self i]
    _ = A.add a (A.smul (-1) A.zero) := by rw [mul_zero_eq_zero A c]
    _ = A.add a A.zero := by rw [smul_zero_eq_zero A (-1)]
    _ = a := A.add_zero a

/-- 本文 `claim_annihilation_generator_anticommutes_with_parity_factor`：a_i ·_A χ_i = (-1_ℂ) ∗_A (χ_i ·_A a_i)。 -/
theorem annihilation_mul_parityFactor {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.annihilation i) (D.parityFactor i)
      = D.space.cliffordAlgebra.smul (-1) (D.space.cliffordAlgebra.mul (D.parityFactor i) (D.annihilation i)) := by
  let A := D.space.cliffordAlgebra
  let a := D.annihilation i
  let c := D.creation i
  calc A.mul a (D.parityFactor i)
      = A.mul a (A.add (A.mul a c) (A.smul (-1) (A.mul c a))) := rfl
    _ = A.add (A.mul a (A.mul a c)) (A.mul a (A.smul (-1) (A.mul c a))) := A.left_distrib _ _ _
    _ = A.add (A.mul (A.mul a a) c) (A.mul a (A.smul (-1) (A.mul c a))) := by rw [A.mul_assoc a a c]
    _ = A.add (A.mul A.zero c) (A.mul a (A.smul (-1) (A.mul c a))) := by rw [D.annihilation_mul_self i]
    _ = A.add A.zero (A.mul a (A.smul (-1) (A.mul c a))) := by rw [zero_mul_eq_zero A c]
    _ = A.add (A.mul a (A.smul (-1) (A.mul c a))) A.zero := A.add_comm _ _
    _ = A.mul a (A.smul (-1) (A.mul c a)) := A.add_zero _
    _ = A.smul (-1) (A.mul a (A.mul c a)) := (A.smul_mul_right (-1) a (A.mul c a)).symm
    _ = A.smul (-1) (A.mul (A.mul a c) a) := by rw [A.mul_assoc a c a]
    _ = A.smul (-1) (A.mul (D.vacuumFactor i) a) := rfl
    _ = A.smul (-1) a := by rw [D.vacuumFactor_mul_annihilation hi]
    _ = A.smul (-1) (A.mul (D.parityFactor i) a) := by rw [D.parityFactor_mul_annihilation hi]

/-- 本文 `claim_parity_factor_times_creation_generator`：χ_i ·_A a†_i = (-1_ℂ) ∗_A a†_i。 -/
theorem parityFactor_mul_creation {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.parityFactor i) (D.creation i)
      = D.space.cliffordAlgebra.smul (-1) (D.creation i) := by
  let A := D.space.cliffordAlgebra
  let a := D.annihilation i
  let c := D.creation i
  calc A.mul (D.parityFactor i) c
      = A.mul (A.add (A.mul a c) (A.smul (-1) (A.mul c a))) c := rfl
    _ = A.add (A.mul (A.mul a c) c) (A.mul (A.smul (-1) (A.mul c a)) c) := A.right_distrib _ _ _
    _ = A.add (A.mul a (A.mul c c)) (A.mul (A.smul (-1) (A.mul c a)) c) := by rw [A.mul_assoc a c c]
    _ = A.add (A.mul a A.zero) (A.mul (A.smul (-1) (A.mul c a)) c) := by rw [D.creation_mul_self i]
    _ = A.add A.zero (A.mul (A.smul (-1) (A.mul c a)) c) := by rw [mul_zero_eq_zero A a]
    _ = A.add (A.mul (A.smul (-1) (A.mul c a)) c) A.zero := A.add_comm _ _
    _ = A.mul (A.smul (-1) (A.mul c a)) c := A.add_zero _
    _ = A.smul (-1) (A.mul (A.mul c a) c) := (A.smul_mul_left (-1) (A.mul c a) c).symm
    _ = A.smul (-1) (A.mul c (A.mul a c)) := by rw [A.mul_assoc c a c]
    _ = A.smul (-1) (A.mul c (D.vacuumFactor i)) := rfl
    _ = A.smul (-1) c := by rw [D.creation_mul_vacuumFactor hi]

/-- 本文 `claim_creation_generator_anticommutes_with_parity_factor`：a†_i ·_A χ_i = (-1_ℂ) ∗_A (χ_i ·_A a†_i)。 -/
theorem creation_mul_parityFactor {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.parityFactor i)
      = D.space.cliffordAlgebra.smul (-1) (D.space.cliffordAlgebra.mul (D.parityFactor i) (D.creation i)) := by
  let A := D.space.cliffordAlgebra
  let a := D.annihilation i
  let c := D.creation i
  calc A.mul c (D.parityFactor i)
      = A.mul c (A.add (A.mul a c) (A.smul (-1) (A.mul c a))) := rfl
    _ = A.add (A.mul c (A.mul a c)) (A.mul c (A.smul (-1) (A.mul c a))) := A.left_distrib _ _ _
    _ = A.add (A.mul c (D.vacuumFactor i)) (A.mul c (A.smul (-1) (A.mul c a))) := rfl
    _ = A.add c (A.mul c (A.smul (-1) (A.mul c a))) := by rw [D.creation_mul_vacuumFactor hi]
    _ = A.add c (A.smul (-1) (A.mul c (A.mul c a))) := by rw [← A.smul_mul_right (-1) c (A.mul c a)]
    _ = A.add c (A.smul (-1) (A.mul (A.mul c c) a)) := by rw [A.mul_assoc c c a]
    _ = A.add c (A.smul (-1) (A.mul A.zero a)) := by rw [D.creation_mul_self i]
    _ = A.add c (A.smul (-1) A.zero) := by rw [zero_mul_eq_zero A a]
    _ = A.add c A.zero := by rw [smul_zero_eq_zero A (-1)]
    _ = c := A.add_zero c
    _ = A.smul 1 c := (A.one_smul c).symm
    _ = A.smul ((-1) * (-1)) c := by rw [show ((-1 : ℂ) * (-1)) = 1 by norm_num]
    _ = A.smul (-1) (A.smul (-1) c) := A.smul_assoc (-1) (-1) c
    _ = A.smul (-1) (A.mul (D.parityFactor i) c) := by rw [D.parityFactor_mul_creation hi]

/-- 本文 `claim_square_of_parity_factor_is_one`：χ_i ·_A χ_i = 1_A。 -/
theorem parityFactor_mul_self {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.parityFactor i) (D.parityFactor i) = D.space.cliffordAlgebra.one := by
  let A := D.space.cliffordAlgebra
  let a := D.annihilation i
  let c := D.creation i
  let χ := D.parityFactor i
  calc A.mul χ χ
      = A.mul χ (A.add (A.mul a c) (A.smul (-1) (A.mul c a))) := rfl
    _ = A.add (A.mul χ (A.mul a c)) (A.mul χ (A.smul (-1) (A.mul c a))) := A.left_distrib _ _ _
    _ = A.add (A.mul (A.mul χ a) c) (A.mul χ (A.smul (-1) (A.mul c a))) := by rw [A.mul_assoc χ a c]
    _ = A.add (A.mul a c) (A.mul χ (A.smul (-1) (A.mul c a))) := by rw [D.parityFactor_mul_annihilation hi]
    _ = A.add (A.mul a c) (A.smul (-1) (A.mul χ (A.mul c a))) := by
        rw [← A.smul_mul_right (-1) χ (A.mul c a)]
    _ = A.add (A.mul a c) (A.smul (-1) (A.mul (A.mul χ c) a)) := by rw [A.mul_assoc χ c a]
    _ = A.add (A.mul a c) (A.smul (-1) (A.mul (A.smul (-1) c) a)) := by rw [D.parityFactor_mul_creation hi]
    _ = A.add (A.mul a c) (A.smul (-1) (A.smul (-1) (A.mul c a))) := by rw [A.smul_mul_left (-1) c a]
    _ = A.add (A.mul a c) (A.smul ((-1) * (-1)) (A.mul c a)) := by rw [A.smul_assoc (-1) (-1) (A.mul c a)]
    _ = A.add (A.mul a c) (A.smul 1 (A.mul c a)) := by rw [show ((-1 : ℂ) * (-1)) = 1 by norm_num]
    _ = A.add (A.mul a c) (A.mul c a) := by rw [A.one_smul (A.mul c a)]
    _ = A.smul (kroneckerDelta i i) A.one := D.annihilation_creation_anticommute i i hi.1 hi.2 hi.1 hi.2
    _ = A.smul 1 A.one := by rw [kroneckerDelta, if_pos rfl]
    _ = A.one := A.one_smul A.one

/-! ### 番号の違う因子との交換 -/

/-- 本文 `claim_generators_commute_with_parity_factor_of_other_number`：i ≠ k で y = a_k か y = a†_k なら
y ·_A χ_i = χ_i ·_A y。y が a_i とも a†_i とも反交換することを準備し、a_i a†_i・a†_i a_i が C_y に属することから
χ_i ∈ C_y を出す。 -/
theorem mul_parityFactor_comm_of_ne {i k : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hk : 1 ≤ k ∧ k ≤ D.M) (hik : i ≠ k)
    {y : D.space.Cl} (hy : y = D.annihilation k ∨ y = D.creation k) :
    D.space.cliffordAlgebra.mul y (D.parityFactor i) = D.space.cliffordAlgebra.mul (D.parityFactor i) y := by
  let A := D.space.cliffordAlgebra
  -- 準備：δ_{k,i} = δ_{i,k} = 0_ℂ
  have hδki : kroneckerDelta k i = 0 := by rw [kroneckerDelta, if_neg (Ne.symm hik)]
  have hδik : kroneckerDelta i k = 0 := by rw [kroneckerDelta, if_neg hik]
  -- 準備：y は a_i とも a†_i とも反交換する
  have hprep : A.add (A.mul y (D.annihilation i)) (A.mul (D.annihilation i) y) = A.zero ∧
      A.add (A.mul y (D.creation i)) (A.mul (D.creation i) y) = A.zero := by
    rcases hy with rfl | rfl
    · refine ⟨D.annihilation_anticommute k i, ?_⟩
      calc A.add (A.mul (D.annihilation k) (D.creation i)) (A.mul (D.creation i) (D.annihilation k))
          = A.smul (kroneckerDelta k i) A.one := D.annihilation_creation_anticommute k i hk.1 hk.2 hi.1 hi.2
        _ = A.smul 0 A.one := by rw [hδki]
        _ = A.zero := zero_smul_eq_zero A A.one
    · refine ⟨?_, D.creation_anticommute k i⟩
      calc A.add (A.mul (D.creation k) (D.annihilation i)) (A.mul (D.annihilation i) (D.creation k))
          = A.add (A.mul (D.annihilation i) (D.creation k)) (A.mul (D.creation k) (D.annihilation i)) :=
            A.add_comm _ _
        _ = A.smul (kroneckerDelta i k) A.one := D.annihilation_creation_anticommute i k hi.1 hi.2 hk.1 hk.2
        _ = A.smul 0 A.one := by rw [hδik]
        _ = A.zero := zero_smul_eq_zero A A.one
  -- C_y は部分代数で、a_i a†_i・a†_i a_i が C_y に属する
  have hC : IsSubalgebra A (commutingElements A y) := commutingElements_isSubalgebra A y
  have h1 : A.mul (D.annihilation i) (D.creation i) ∈ commutingElements A y :=
    mul_comm_of_anticommute_both A y (D.annihilation i) (D.creation i) hprep.1 hprep.2
  have h2 : A.mul (D.creation i) (D.annihilation i) ∈ commutingElements A y :=
    mul_comm_of_anticommute_both A y (D.creation i) (D.annihilation i) hprep.2 hprep.1
  -- C_y はスカラー倍と加法で閉じている
  have h3 : A.smul (-1) (A.mul (D.creation i) (D.annihilation i)) ∈ commutingElements A y :=
    hC.smul_mem (-1) _ h2
  have h4 : D.parityFactor i ∈ commutingElements A y := hC.add_mem _ _ h1 h3
  exact h4

/-- 本文 `claim_parity_factors_with_different_numbers_commute`：i ≠ k なら χ_k ·_A χ_i = χ_i ·_A χ_k。
a_i・a†_i が C_{χ_k} に属することから、χ_i ∈ C_{χ_k} を出す。 -/
theorem parityFactor_comm_of_ne {i k : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hk : 1 ≤ k ∧ k ≤ D.M) (hik : i ≠ k) :
    D.space.cliffordAlgebra.mul (D.parityFactor k) (D.parityFactor i)
      = D.space.cliffordAlgebra.mul (D.parityFactor i) (D.parityFactor k) := by
  let A := D.space.cliffordAlgebra
  have hC : IsSubalgebra A (commutingElements A (D.parityFactor k)) := commutingElements_isSubalgebra A _
  -- 前の主張を i と k の役を替えて当てる
  have ha : D.annihilation i ∈ commutingElements A (D.parityFactor k) :=
    (D.mul_parityFactor_comm_of_ne hk hi (Ne.symm hik) (Or.inl rfl)).symm
  have hc : D.creation i ∈ commutingElements A (D.parityFactor k) :=
    (D.mul_parityFactor_comm_of_ne hk hi (Ne.symm hik) (Or.inr rfl)).symm
  have h1 : A.mul (D.annihilation i) (D.creation i) ∈ commutingElements A (D.parityFactor k) :=
    hC.mul_mem _ _ ha hc
  have h2 : A.mul (D.creation i) (D.annihilation i) ∈ commutingElements A (D.parityFactor k) :=
    hC.mul_mem _ _ hc ha
  have h3 : A.smul (-1) (A.mul (D.creation i) (D.annihilation i)) ∈ commutingElements A (D.parityFactor k) :=
    hC.smul_mem (-1) _ h2
  have h4 : D.parityFactor i ∈ commutingElements A (D.parityFactor k) := hC.add_mem _ _ h1 h3
  exact h4

/-! ### ε の平方と、生成元との反交換 -/

/-- 本文 `claim_square_of_parity_element_is_one`：ε ·_A ε = 1_A。部分積 Π_m について Π_m ·_A Π_m = 1_A を
m の帰納法で示す。 -/
theorem parityElement_mul_self :
    D.space.cliffordAlgebra.mul D.parityElement D.parityElement = D.space.cliffordAlgebra.one := by
  let A := D.space.cliffordAlgebra
  have hm : ∀ m : ℕ, m ≤ D.M →
      A.mul (ComplexAlgebra.partialOrderedProduct A D.parityFactor m) (ComplexAlgebra.partialOrderedProduct A D.parityFactor m) = A.one := by
    intro m
    induction m with
    | zero =>
      intro _
      calc A.mul (ComplexAlgebra.partialOrderedProduct A D.parityFactor 0) (ComplexAlgebra.partialOrderedProduct A D.parityFactor 0)
          = A.mul A.one (ComplexAlgebra.partialOrderedProduct A D.parityFactor 0) := rfl
        _ = ComplexAlgebra.partialOrderedProduct A D.parityFactor 0 := A.one_mul _
        _ = A.one := rfl
    | succ m ih =>
      intro hmM
      let P := ComplexAlgebra.partialOrderedProduct A D.parityFactor m
      let χ := D.parityFactor (m + 1)
      -- 準備：χ_m ·_A Π_{m-1} = Π_{m-1} ·_A χ_m（Π_{m-1} は族を {1,…,m-1} に制限した番号順の積）
      have hcomm : A.mul χ P = A.mul P χ :=
        commute_orderedProduct A χ m D.parityFactor
          (fun s hs1 hsm => D.parityFactor_comm_of_ne ⟨hs1, by omega⟩ ⟨Nat.succ_pos m, hmM⟩ (by omega))
      calc A.mul (ComplexAlgebra.partialOrderedProduct A D.parityFactor (m + 1)) (ComplexAlgebra.partialOrderedProduct A D.parityFactor (m + 1))
          = A.mul (A.mul P χ) (A.mul P χ) := rfl
        _ = A.mul P (A.mul χ (A.mul P χ)) := A.mul_assoc _ _ _
        _ = A.mul P (A.mul (A.mul χ P) χ) := by rw [A.mul_assoc χ P χ]
        _ = A.mul P (A.mul (A.mul P χ) χ) := by rw [hcomm]
        _ = A.mul P (A.mul P (A.mul χ χ)) := by rw [A.mul_assoc P χ χ]
        _ = A.mul P (A.mul P A.one) := by rw [D.parityFactor_mul_self ⟨Nat.succ_pos m, hmM⟩]
        _ = A.mul P P := by rw [A.mul_one P]
        _ = A.one := ih (Nat.le_of_succ_le hmM)
  -- m = M のとき Π_M = ε
  exact hm D.M le_rfl

/-- 本文 `claim_generators_anticommute_with_parity_element`：k ∈ {1,…,M} で y = a_k か y = a†_k なら
y ·_A ε = (-1_ℂ) ∗_A (ε ·_A y)。ε = L ·_A (χ_k ·_A R) と分け、y が L・R と交換し χ_k と反交換することを使う。 -/
theorem mul_parityElement_of_generator {k : ℕ} (hk : 1 ≤ k ∧ k ≤ D.M) {y : D.space.Cl}
    (hy : y = D.annihilation k ∨ y = D.creation k) :
    D.space.cliffordAlgebra.mul y D.parityElement
      = D.space.cliffordAlgebra.smul (-1) (D.space.cliffordAlgebra.mul D.parityElement y) := by
  let A := D.space.cliffordAlgebra
  let L := ComplexAlgebra.orderedProduct A (k - 1) D.parityFactor
  let R := ComplexAlgebra.orderedProduct A (D.M - k) (fun r => D.parityFactor (k + r))
  let χ := D.parityFactor k
  -- 準備：ε = L ·_A (χ_k ·_A R)（claim_ordered_product_in_algebra_with_one_factor_singled_out）
  have hε : D.parityElement = A.mul L (A.mul χ R) := orderedProduct_singleOut A D.M k hk.1 hk.2 D.parityFactor
  -- 準備：y ·_A L = L ·_A y、y ·_A R = R ·_A y
  have hL : A.mul y L = A.mul L y :=
    commute_orderedProduct A y (k - 1) D.parityFactor
      (fun s hs1 hsk => D.mul_parityFactor_comm_of_ne ⟨hs1, by omega⟩ hk (by omega) hy)
  have hR : A.mul y R = A.mul R y :=
    commute_orderedProduct A y (D.M - k) (fun r => D.parityFactor (k + r))
      (fun r hr1 hrk => D.mul_parityFactor_comm_of_ne ⟨by omega, by omega⟩ hk (by omega) hy)
  -- 準備：y ·_A χ_k = (-1_ℂ) ∗_A (χ_k ·_A y)
  have hχ : A.mul y χ = A.smul (-1) (A.mul χ y) := by
    rcases hy with rfl | rfl
    · exact D.annihilation_mul_parityFactor hk
    · exact D.creation_mul_parityFactor hk
  calc A.mul y D.parityElement
      = A.mul y (A.mul L (A.mul χ R)) := by rw [hε]
    _ = A.mul (A.mul y L) (A.mul χ R) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul L y) (A.mul χ R) := by rw [hL]
    _ = A.mul L (A.mul y (A.mul χ R)) := A.mul_assoc _ _ _
    _ = A.mul L (A.mul (A.mul y χ) R) := by rw [A.mul_assoc y χ R]
    _ = A.mul L (A.mul (A.smul (-1) (A.mul χ y)) R) := by rw [hχ]
    _ = A.mul L (A.smul (-1) (A.mul (A.mul χ y) R)) := by rw [A.smul_mul_left (-1) (A.mul χ y) R]
    _ = A.smul (-1) (A.mul L (A.mul (A.mul χ y) R)) := (A.smul_mul_right _ _ _).symm
    _ = A.smul (-1) (A.mul L (A.mul χ (A.mul y R))) := by rw [A.mul_assoc χ y R]
    _ = A.smul (-1) (A.mul L (A.mul χ (A.mul R y))) := by rw [hR]
    _ = A.smul (-1) (A.mul L (A.mul (A.mul χ R) y)) := by rw [A.mul_assoc χ R y]
    _ = A.smul (-1) (A.mul (A.mul L (A.mul χ R)) y) := by rw [A.mul_assoc L (A.mul χ R) y]
    _ = A.smul (-1) (A.mul D.parityElement y) := by rw [hε]

/-- 本文 `claim_image_of_split_space_anticommutes_with_parity_element`：すべての v ∈ V について
γ(v) ·_A ε +_A ε ·_A γ(v) = 0_A。生成元についての反交換を準備し、γ(v) = R_1 +_A R_2 に分けて示す。 -/
theorem γ_anticommute_parityElement (v : W × ComplexVectorSpace.DualSpace D.spaceW) :
    D.space.cliffordAlgebra.add (D.space.cliffordAlgebra.mul (D.space.γ v) D.parityElement)
        (D.space.cliffordAlgebra.mul D.parityElement (D.space.γ v))
      = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  let Av := A.toComplexVectorSpace
  let ε := D.parityElement
  -- 準備：k ∈ {1,…,M}、y ∈ {a_k, a†_k} について y ·_A ε +_A ε ·_A y = 0_A
  have hprep : ∀ k : ℕ, 1 ≤ k → k ≤ D.M → ∀ y : D.space.Cl, (y = D.annihilation k ∨ y = D.creation k) →
      A.add (A.mul y ε) (A.mul ε y) = A.zero := by
    intro k hk1 hkM y hy
    calc A.add (A.mul y ε) (A.mul ε y)
        = A.add (A.smul (-1) (A.mul ε y)) (A.mul ε y) := by
          rw [D.mul_parityElement_of_generator ⟨hk1, hkM⟩ hy]
      _ = A.add (A.smul (-1) (A.mul ε y)) (A.smul 1 (A.mul ε y)) := by rw [A.one_smul (A.mul ε y)]
      _ = A.smul ((-1) + 1) (A.mul ε y) := (A.add_smul _ _ _).symm
      _ = A.smul 0 (A.mul ε y) := by rw [show ((-1 : ℂ) + 1) = 0 by norm_num]
      _ = A.zero := zero_smul_eq_zero A _
  obtain ⟨x, ξ⟩ := v
  let R₁ := ComplexVectorSpace.linearCombination Av D.M
    (fun k => ComplexVectorSpace.coordinate D.spaceW D.M D.w D.isBasis k x) D.creation
  let R₂ := ComplexVectorSpace.linearCombination Av D.M (fun k => ξ.1 (D.w k)) D.annihilation
  have h₁ : A.add (A.mul R₁ ε) (A.mul ε R₁) = A.zero := calc
    A.add (A.mul R₁ ε) (A.mul ε R₁)
        = ComplexVectorSpace.linearCombination Av D.M
            (fun k => ComplexVectorSpace.coordinate D.spaceW D.M D.w D.isBasis k x)
            (fun l => A.add (A.mul (D.creation l) ε) (A.mul ε (D.creation l))) :=
          anticommutator_linearCombination A ε D.M _ D.creation
    _ = ComplexVectorSpace.linearCombination Av D.M
            (fun k => ComplexVectorSpace.coordinate D.spaceW D.M D.w D.isBasis k x) (fun _ => A.zero) :=
          ComplexVectorSpace.linearCombination_eq_of_terms_eq Av D.M _ _ _ _
            (fun k hk1 hkM => by
              show A.smul _ (A.add (A.mul (D.creation k) ε) (A.mul ε (D.creation k))) = A.smul _ A.zero
              rw [hprep k hk1 hkM (D.creation k) (Or.inr rfl)])
    _ = A.zero :=
          ComplexVectorSpace.linearCombination_eq_zero_of_terms_eq_zero Av D.M _ _
            (fun k _ _ => smul_zero_eq_zero A _)
  have h₂ : A.add (A.mul R₂ ε) (A.mul ε R₂) = A.zero := calc
    A.add (A.mul R₂ ε) (A.mul ε R₂)
        = ComplexVectorSpace.linearCombination Av D.M (fun k => ξ.1 (D.w k))
            (fun l => A.add (A.mul (D.annihilation l) ε) (A.mul ε (D.annihilation l))) :=
          anticommutator_linearCombination A ε D.M _ D.annihilation
    _ = ComplexVectorSpace.linearCombination Av D.M (fun k => ξ.1 (D.w k)) (fun _ => A.zero) :=
          ComplexVectorSpace.linearCombination_eq_of_terms_eq Av D.M _ _ _ _
            (fun k hk1 hkM => by
              show A.smul _ (A.add (A.mul (D.annihilation k) ε) (A.mul ε (D.annihilation k))) = A.smul _ A.zero
              rw [hprep k hk1 hkM (D.annihilation k) (Or.inl rfl)])
    _ = A.zero :=
          ComplexVectorSpace.linearCombination_eq_zero_of_terms_eq_zero Av D.M _ _
            (fun k _ _ => smul_zero_eq_zero A _)
  calc A.add (A.mul (D.space.γ (x, ξ)) ε) (A.mul ε (D.space.γ (x, ξ)))
      = A.add (A.mul (A.add R₁ R₂) ε) (A.mul ε (A.add R₁ R₂)) := by
        rw [D.γ_pair_eq_creation_add_annihilation x ξ]
    _ = A.add (A.add (A.mul R₁ ε) (A.mul R₂ ε)) (A.add (A.mul ε R₁) (A.mul ε R₂)) := by
        rw [A.right_distrib R₁ R₂ ε, A.left_distrib ε R₁ R₂]
    _ = A.add (A.add (A.mul R₁ ε) (A.mul ε R₁)) (A.add (A.mul R₂ ε) (A.mul ε R₂)) :=
        ComplexVectorSpace.rearrange_sum_of_two_sums Av _ _ _ _
    _ = A.add A.zero A.zero := by rw [h₁, h₂]
    _ = A.zero := A.add_zero A.zero

end

end CliffordMatrixIsomorphism.Clifford.SplitData
