/-
節「テンソル代数」のうち代数の中の積についての補題の具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルは必要十分版を引かない。このファイルだけが両方を引き、具体版の主張と同じ形の主張 `…_of_necSuf` を、
必要十分版の主張に ℂ の性質（mathlib の補題）を渡して示す。

  具体版                                   必要十分版の特殊化
  各主張                                   …_of_necSuf

ℂ-代数・線型結合・有限集合の上の和・番号順の積・部分代数の読み替えは、`ComplexAlgebraFromNecSuf.lean`・
`ComplexVectorSpaceFromNecSuf.lean`・`FiniteSetSumFromNecSuf.lean` のものを使う。
0 + 0 = 0 には `add_zero 0`、a · 0 = 0 には `mul_zero`、本文の -1_ℂ（1 + n = 0 を満たす n）には -1 と `add_neg_cancel 1` を渡す。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.ComplexAlgebraFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.FiniteSetSumFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebra

namespace CliffordMatrixIsomorphism.ComplexAlgebra

open ComplexVectorSpace

universe u w

variable {A : Type u}

theorem IsSubalgebra.sumOverFiniteSet_mem_of_necSuf {SA : ComplexAlgebra A} {B : Set A}
    (hB : IsSubalgebra SA B) {X : Type w} (hX : IsFiniteSet X) (c : X → ℂ) (v : X → A)
    (hv : ∀ x : X, v x ∈ B) : sumOverFiniteSet SA.toComplexVectorSpace hX c v ∈ B := by
  rw [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.AlgebraOver.IsSubalgebra.sumOverFiniteSet_mem (_root_.add_zero 0)
    ((isSubalgebra_iff_necSuf SA B).1 hB) hX c v hv

theorem leftMul_isLinearMap_of_necSuf (SA : ComplexAlgebra A) (a : A) :
    IsComplexLinearMap SA.toComplexVectorSpace SA.toComplexVectorSpace (fun x => SA.mul a x) :=
  (isComplexLinearMap_iff_necSuf _ _ _).2 (NecSuf.AlgebraOver.leftMul_isLinearMap SA.toNecSuf a)

theorem rightMul_isLinearMap_of_necSuf (SA : ComplexAlgebra A) (a : A) :
    IsComplexLinearMap SA.toComplexVectorSpace SA.toComplexVectorSpace (fun x => SA.mul x a) :=
  (isComplexLinearMap_iff_necSuf _ _ _).2 (NecSuf.AlgebraOver.rightMul_isLinearMap SA.toNecSuf a)

theorem zero_mul_eq_zero_of_necSuf (SA : ComplexAlgebra A) (w : A) :
    SA.mul SA.zero w = SA.zero :=
  NecSuf.AlgebraOver.zero_mul_eq_zero (_root_.add_zero 0) SA.toNecSuf w

theorem mul_zero_eq_zero_of_necSuf (SA : ComplexAlgebra A) (w : A) :
    SA.mul w SA.zero = SA.zero :=
  NecSuf.AlgebraOver.mul_zero_eq_zero (_root_.add_zero 0) SA.toNecSuf w

theorem anticommutator_linearCombination_of_necSuf (SA : ComplexAlgebra A) (a : A) (n : ℕ)
    (μ : ℕ → ℂ) (r : ℕ → A) :
    SA.add (SA.mul (linearCombination SA.toComplexVectorSpace n μ r) a)
        (SA.mul a (linearCombination SA.toComplexVectorSpace n μ r))
      = linearCombination SA.toComplexVectorSpace n μ
          (fun l => SA.add (SA.mul (r l) a) (SA.mul a (r l))) := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf]
  exact NecSuf.AlgebraOver.anticommutator_linearCombination (_root_.add_zero 0) SA.toNecSuf a n μ r

theorem square_linearCombination_eq_zero_of_necSuf (SA : ComplexAlgebra A) (n : ℕ) (c : ℕ → ℂ)
    (p : ℕ → A) (hsq : ∀ k : ℕ, 1 ≤ k → k ≤ n → SA.mul (p k) (p k) = SA.zero)
    (hanti : ∀ k l : ℕ, 1 ≤ k → k ≤ n → 1 ≤ l → l ≤ n → k ≠ l →
      SA.add (SA.mul (p k) (p l)) (SA.mul (p l) (p k)) = SA.zero) :
    SA.mul (linearCombination SA.toComplexVectorSpace n c p)
        (linearCombination SA.toComplexVectorSpace n c p) = SA.zero := by
  rw [linearCombination_eq_necSuf]
  exact NecSuf.AlgebraOver.square_linearCombination_eq_zero (_root_.add_zero 0) mul_zero
    SA.toNecSuf n c p hsq hanti

theorem orderedProduct_congr_of_necSuf (SA : ComplexAlgebra A) (n : ℕ) (x y : ℕ → A)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → x k = y k) : orderedProduct SA n x = orderedProduct SA n y := by
  rw [orderedProduct_eq_necSuf, orderedProduct_eq_necSuf]
  exact NecSuf.AlgebraOver.orderedProduct_congr SA.toNecSuf n x y h

theorem orderedProduct_add_in_one_factor_of_necSuf (SA : ComplexAlgebra A) (k r : ℕ)
    (hr1 : 1 ≤ r) (hrk : r ≤ k) (w w' w'' : ℕ → A)
    (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → w s = w' s ∧ w s = w'' s)
    (hr : w r = SA.add (w' r) (w'' r)) :
    orderedProduct SA k w = SA.add (orderedProduct SA k w') (orderedProduct SA k w'') := by
  rw [orderedProduct_eq_necSuf, orderedProduct_eq_necSuf, orderedProduct_eq_necSuf]
  exact NecSuf.AlgebraOver.orderedProduct_add_in_one_factor SA.toNecSuf k r hr1 hrk w w' w'' hne hr

theorem orderedProduct_smul_in_one_factor_of_necSuf (SA : ComplexAlgebra A) (k r : ℕ)
    (hr1 : 1 ≤ r) (hrk : r ≤ k) (l : ℂ) (w w' : ℕ → A)
    (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → w s = w' s) (hr : w r = SA.smul l (w' r)) :
    orderedProduct SA k w = SA.smul l (orderedProduct SA k w') := by
  rw [orderedProduct_eq_necSuf, orderedProduct_eq_necSuf]
  exact NecSuf.AlgebraOver.orderedProduct_smul_in_one_factor SA.toNecSuf k r hr1 hrk l w w' hne hr

theorem orderedProduct_split_of_necSuf (SA : ComplexAlgebra A) (k l : ℕ) (w : ℕ → A) :
    orderedProduct SA (k + l) w
      = SA.mul (orderedProduct SA k w) (orderedProduct SA l (fun t => w (k + t))) := by
  rw [orderedProduct_eq_necSuf, orderedProduct_eq_necSuf, orderedProduct_eq_necSuf]
  exact NecSuf.AlgebraOver.orderedProduct_split SA.toNecSuf k l w

theorem orderedProduct_singleOut_of_necSuf (SA : ComplexAlgebra A) (n p : ℕ) (hp1 : 1 ≤ p)
    (hpn : p ≤ n) (x : ℕ → A) :
    orderedProduct SA n x
      = SA.mul (orderedProduct SA (p - 1) x)
          (SA.mul (x p) (orderedProduct SA (n - p) (fun r => x (p + r)))) := by
  rw [orderedProduct_eq_necSuf, orderedProduct_eq_necSuf, orderedProduct_eq_necSuf]
  exact NecSuf.AlgebraOver.orderedProduct_singleOut SA.toNecSuf n p hp1 hpn x

theorem commute_orderedProduct_of_necSuf (SA : ComplexAlgebra A) (u : A) (n : ℕ) (x : ℕ → A)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → SA.mul u (x k) = SA.mul (x k) u) :
    SA.mul u (orderedProduct SA n x) = SA.mul (orderedProduct SA n x) u := by
  rw [orderedProduct_eq_necSuf]
  exact NecSuf.AlgebraOver.commute_orderedProduct SA.toNecSuf u n x h

theorem mul_eq_neg_one_smul_swap_of_necSuf (SA : ComplexAlgebra A) (p q : A)
    (h : SA.add (SA.mul p q) (SA.mul q p) = SA.zero) :
    SA.mul p q = SA.smul (-1) (SA.mul q p) :=
  NecSuf.AlgebraOver.mul_eq_neg_one_smul_swap (_root_.add_zero 0) (-1) (add_neg_cancel 1)
    SA.toNecSuf p q h

end CliffordMatrixIsomorphism.ComplexAlgebra
