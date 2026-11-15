/-
章「同型の証明」の系「奇数次元の二次空間」のうち、一般の ℂ-代数の中で、固定した元と交換する元についての主張の具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                      このファイル
  claim_element_anticommuting_with_two_elements_commutes_with_their_product         mul_comm_of_anticommute_both
  def_elements_commuting_with_fixed_element                                         commutingElements（C_y）
  claim_elements_commuting_with_fixed_element_form_subalgebra                       commutingElements_isSubalgebra
  claim_element_commuting_with_generating_subset_commutes_with_every_element        mul_comm_of_mul_comm_on_generators

C_y は A の部分集合 `Set A` で、a ∈ C_y は y ·_A a = a ·_A y と定義で一致する。
本文の「ℂ の四則」(-1_ℂ)·(-1_ℂ) = 1_ℂ は ℂ の計算（`norm_num`）で書く。

必要十分版は `NecSuf/Isomorphism/OddDimensional/CommutingElements.lean`、導出版は `CommutingElementsFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u

variable {A : Type u}

/-- 本文 `claim_element_anticommuting_with_two_elements_commutes_with_their_product`：
y ·_A p +_A p ·_A y = 0_A と y ·_A r +_A r ·_A y = 0_A なら y ·_A (p ·_A r) = (p ·_A r) ·_A y。 -/
theorem mul_comm_of_anticommute_both (SA : ComplexAlgebra A) (y p r : A)
    (hp : SA.add (SA.mul y p) (SA.mul p y) = SA.zero)
    (hr : SA.add (SA.mul y r) (SA.mul r y) = SA.zero) :
    SA.mul y (SA.mul p r) = SA.mul (SA.mul p r) y := by
  -- 準備：仮定に claim_anticommuting_elements_swap_with_sign を当てる
  have hp' : SA.mul y p = SA.smul (-1) (SA.mul p y) := mul_eq_neg_one_smul_swap SA y p hp
  have hr' : SA.mul y r = SA.smul (-1) (SA.mul r y) := mul_eq_neg_one_smul_swap SA y r hr
  calc SA.mul y (SA.mul p r)
      = SA.mul (SA.mul y p) r := (SA.mul_assoc y p r).symm
    _ = SA.mul (SA.smul (-1) (SA.mul p y)) r := by rw [hp']
    _ = SA.smul (-1) (SA.mul (SA.mul p y) r) := (SA.smul_mul_left (-1) (SA.mul p y) r).symm
    _ = SA.smul (-1) (SA.mul p (SA.mul y r)) := by rw [SA.mul_assoc p y r]
    _ = SA.smul (-1) (SA.mul p (SA.smul (-1) (SA.mul r y))) := by rw [hr']
    _ = SA.smul (-1) (SA.smul (-1) (SA.mul p (SA.mul r y))) := by
        rw [← SA.smul_mul_right (-1) p (SA.mul r y)]
    _ = SA.smul ((-1) * (-1)) (SA.mul p (SA.mul r y)) := (SA.smul_assoc (-1) (-1) _).symm
    _ = SA.smul 1 (SA.mul p (SA.mul r y)) := by rw [show ((-1 : ℂ) * (-1)) = 1 by norm_num]
    _ = SA.mul p (SA.mul r y) := SA.one_smul _
    _ = SA.mul (SA.mul p r) y := (SA.mul_assoc p r y).symm

/-- 本文 `def_elements_commuting_with_fixed_element`：C_y := {a ∈ A : y ·_A a = a ·_A y}。 -/
def commutingElements (SA : ComplexAlgebra A) (y : A) : Set A :=
  {a | SA.mul y a = SA.mul a y}

/-- 本文 `claim_elements_commuting_with_fixed_element_form_subalgebra`：C_y は A の部分代数である。
本文の四条件（単位元・加法・乗法・スカラー倍）をそれぞれ calc で示す。 -/
theorem commutingElements_isSubalgebra (SA : ComplexAlgebra A) (y : A) :
    IsSubalgebra SA (commutingElements SA y) where
  one_mem := show SA.mul y SA.one = SA.mul SA.one y from calc
    SA.mul y SA.one = y := SA.mul_one y
    _ = SA.mul SA.one y := (SA.one_mul y).symm
  add_mem a b ha hb := by
    have ha' : SA.mul y a = SA.mul a y := ha
    have hb' : SA.mul y b = SA.mul b y := hb
    show SA.mul y (SA.add a b) = SA.mul (SA.add a b) y
    calc SA.mul y (SA.add a b)
        = SA.add (SA.mul y a) (SA.mul y b) := SA.left_distrib y a b
      _ = SA.add (SA.mul a y) (SA.mul y b) := by rw [ha']
      _ = SA.add (SA.mul a y) (SA.mul b y) := by rw [hb']
      _ = SA.mul (SA.add a b) y := (SA.right_distrib a b y).symm
  mul_mem a b ha hb := by
    have ha' : SA.mul y a = SA.mul a y := ha
    have hb' : SA.mul y b = SA.mul b y := hb
    show SA.mul y (SA.mul a b) = SA.mul (SA.mul a b) y
    calc SA.mul y (SA.mul a b)
        = SA.mul (SA.mul y a) b := (SA.mul_assoc y a b).symm
      _ = SA.mul (SA.mul a y) b := by rw [ha']
      _ = SA.mul a (SA.mul y b) := SA.mul_assoc a y b
      _ = SA.mul a (SA.mul b y) := by rw [hb']
      _ = SA.mul (SA.mul a b) y := (SA.mul_assoc a b y).symm
  smul_mem l a ha := by
    have ha' : SA.mul y a = SA.mul a y := ha
    show SA.mul y (SA.smul l a) = SA.mul (SA.smul l a) y
    calc SA.mul y (SA.smul l a)
        = SA.smul l (SA.mul y a) := (SA.smul_mul_right l y a).symm
      _ = SA.smul l (SA.mul a y) := by rw [ha']
      _ = SA.mul (SA.smul l a) y := SA.smul_mul_left l a y

/-- 本文 `claim_element_commuting_with_generating_subset_commutes_with_every_element`：X が A を生成し、
すべての x ∈ X で y ·_A x = x ·_A y なら、すべての a ∈ A で y ·_A a = a ·_A y。
C_y は部分代数で X ⊆ C_y なので C_y = A（def_subset_generates_algebra）。 -/
theorem mul_comm_of_mul_comm_on_generators (SA : ComplexAlgebra A) {X : Set A} (hX : GeneratesAlgebra SA X)
    (y : A) (h : ∀ x : A, x ∈ X → SA.mul y x = SA.mul x y) (a : A) : SA.mul y a = SA.mul a y := by
  have hC : commutingElements SA y = Set.univ :=
    hX (commutingElements SA y) (commutingElements_isSubalgebra SA y) (fun x hx => h x hx)
  have ha : a ∈ commutingElements SA y := by rw [hC]; exact Set.mem_univ a
  exact ha

end CliffordMatrixIsomorphism.ComplexAlgebra
