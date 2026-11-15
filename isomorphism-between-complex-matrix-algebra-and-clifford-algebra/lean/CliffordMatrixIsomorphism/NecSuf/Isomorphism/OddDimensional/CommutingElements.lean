/-
章「同型の証明」の系「奇数次元の二次空間」のうち、一般の代数の中で、固定した元と交換する元についての主張の必要十分版。
具体版 `Isomorphism/OddDimensional/CommutingElements.lean` と同じ def・calc の行を、係数 ℂ を型の変数 K に替えて書く。
本文の -1_ℂ は、1 + n = 0 を満たす K の元 n に替える。

  本文のラベル                                                                      このファイル                          K に要るもの
  claim_element_anticommuting_with_two_elements_commutes_with_their_product         mul_comm_of_anticommute_both          0 + 0 = 0、1 + n = 0、n · n = 1
  def_elements_commuting_with_fixed_element                                         commutingElements                     なし
  claim_elements_commuting_with_fixed_element_form_subalgebra                       commutingElements_isSubalgebra        なし
  claim_element_commuting_with_generating_subset_commutes_with_every_element        mul_comm_of_mul_comm_on_generators    なし

分かったこと:
- 二つの元のどちらとも反交換する元が積と交換することには、反交換する二元の入れ替え（0 + 0 = 0 と 1 + n = 0）と、
  符号が二度掛かって消える行の n · n = 1 だけが要る。K の乗法の結合法則・交換法則も、2 の可逆性も使わない。
- C_y が部分代数であることと、生成する部分集合のどの元とも交換する元が全体と交換することは、係数の性質を一つも使わない
  （代数の分配法則・結合法則・単位元と、スカラー倍と乗法の両立だけを使う）。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u uK

variable {K : Type uK} [Add K] [Mul K] [One K] {A : Type u}

/-- 本文 `claim_element_anticommuting_with_two_elements_commutes_with_their_product` の必要十分版。 -/
theorem mul_comm_of_anticommute_both [Zero K] (h00 : (0 : K) + 0 = 0) (n : K) (hn : 1 + n = 0)
    (hnn : n * n = 1) (SA : AlgebraOver K A) (y p r : A)
    (hp : SA.add (SA.mul y p) (SA.mul p y) = SA.zero)
    (hr : SA.add (SA.mul y r) (SA.mul r y) = SA.zero) :
    SA.mul y (SA.mul p r) = SA.mul (SA.mul p r) y := by
  -- 準備：仮定に claim_anticommuting_elements_swap_with_sign を当てる
  have hp' : SA.mul y p = SA.smul n (SA.mul p y) := mul_eq_neg_one_smul_swap h00 n hn SA y p hp
  have hr' : SA.mul y r = SA.smul n (SA.mul r y) := mul_eq_neg_one_smul_swap h00 n hn SA y r hr
  calc SA.mul y (SA.mul p r)
      = SA.mul (SA.mul y p) r := (SA.mul_assoc y p r).symm
    _ = SA.mul (SA.smul n (SA.mul p y)) r := by rw [hp']
    _ = SA.smul n (SA.mul (SA.mul p y) r) := (SA.smul_mul_left n (SA.mul p y) r).symm
    _ = SA.smul n (SA.mul p (SA.mul y r)) := by rw [SA.mul_assoc p y r]
    _ = SA.smul n (SA.mul p (SA.smul n (SA.mul r y))) := by rw [hr']
    _ = SA.smul n (SA.smul n (SA.mul p (SA.mul r y))) := by
        rw [← SA.smul_mul_right n p (SA.mul r y)]
    _ = SA.smul (n * n) (SA.mul p (SA.mul r y)) := (SA.smul_assoc n n _).symm
    -- 本文の「ℂ の四則」(-1_ℂ)·(-1_ℂ) = 1_ℂ の行。n · n = 1 はここだけで要る
    _ = SA.smul 1 (SA.mul p (SA.mul r y)) := by rw [hnn]
    _ = SA.mul p (SA.mul r y) := SA.one_smul _
    _ = SA.mul (SA.mul p r) y := (SA.mul_assoc p r y).symm

/-- 本文 `def_elements_commuting_with_fixed_element` の必要十分版。 -/
def commutingElements (SA : AlgebraOver K A) (y : A) : Set A :=
  {a | SA.mul y a = SA.mul a y}

/-- 本文 `claim_elements_commuting_with_fixed_element_form_subalgebra` の必要十分版。 -/
theorem commutingElements_isSubalgebra (SA : AlgebraOver K A) (y : A) :
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

/-- 本文 `claim_element_commuting_with_generating_subset_commutes_with_every_element` の必要十分版。 -/
theorem mul_comm_of_mul_comm_on_generators (SA : AlgebraOver K A) {X : Set A} (hX : GeneratesAlgebra SA X)
    (y : A) (h : ∀ x : A, x ∈ X → SA.mul y x = SA.mul x y) (a : A) : SA.mul y a = SA.mul a y := by
  have hC : commutingElements SA y = Set.univ :=
    hX (commutingElements SA y) (commutingElements_isSubalgebra SA y) (fun x hx => h x hx)
  have ha : a ∈ commutingElements SA y := by rw [hC]; exact Set.mem_univ a
  exact ha

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver
