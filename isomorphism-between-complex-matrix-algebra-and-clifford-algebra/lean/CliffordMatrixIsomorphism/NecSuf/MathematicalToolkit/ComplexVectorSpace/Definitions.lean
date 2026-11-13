/-
節「ℂ-線型空間」の定義の必要十分版。具体版
`CliffordMatrixIsomorphism/MathematicalToolkit/ComplexVectorSpace/Definitions.lean` と同じ structure と def を、
係数 ℂ を型の変数 K に替えて書く。K には、定義の式に現れる演算の記号だけを与える
（公理は一つも仮定しない。公理は使う主張の側で仮定に置く）。

  本文のラベル                          このファイル                     K に要るもの
  def_complex_vector_space              VectorSpace                      +・·・1（公理の式に現れる）
  def_linear_map                        IsLinearMap                      VectorSpace と同じ
  def_linear_combination                partialLinearCombination 等      VectorSpace と同じ
  def_linear_form                       IsLinearForm                     +・·（値の側の演算）
  def_linear_independence               IsLinearlyIndependentFamily      0（結論 λ_k = 0）
  def_spanning_family                   SpansByLinearCombination         VectorSpace と同じ
  def_basis                             IsBasisFamily                    0
  def_ordered_sum_in_complex_numbers    partialOrderedSum 等             +・0
  def_kronecker_delta                   kroneckerDelta                   0・1
-/
import Mathlib.Data.Complex.Basic

namespace CliffordMatrixIsomorphism.NecSuf

universe u v w

/-- 本文 `def_complex_vector_space` の必要十分版：係数 K の上の (V, +_V, ·_V, 0_V)。 -/
structure VectorSpace (K : Type u) [Add K] [Mul K] [One K] (V : Type v) where
  add : V → V → V
  smul : K → V → V
  zero : V
  add_assoc : ∀ x y z : V, add (add x y) z = add x (add y z)
  add_comm : ∀ x y : V, add x y = add y x
  add_zero : ∀ x : V, add x zero = x
  exists_add_inverse : ∀ x : V, ∃ x' : V, add x x' = zero
  smul_assoc : ∀ (l m : K) (x : V), smul (l * m) x = smul l (smul m x)
  one_smul : ∀ x : V, smul 1 x = x
  smul_add : ∀ (l : K) (x y : V), smul l (add x y) = add (smul l x) (smul l y)
  add_smul : ∀ (l m : K) (x : V), smul (l + m) x = add (smul l x) (smul m x)

namespace VectorSpace

variable {K : Type u} [Add K] [Mul K] [One K] {V : Type v} {U : Type w}

/-- 本文 `def_linear_map` の必要十分版。 -/
structure IsLinearMap (SV : VectorSpace K V) (SU : VectorSpace K U) (f : V → U) : Prop where
  map_add : ∀ x y : V, f (SV.add x y) = SU.add (f x) (f y)
  map_smul : ∀ (l : K) (x : V), f (SV.smul l x) = SU.smul l (f x)

/-- 本文 `def_linear_combination` の L_m の必要十分版。 -/
def partialLinearCombination (S : VectorSpace K V) (c : ℕ → K) (x : ℕ → V) : ℕ → V
  | 0 => S.zero
  | m + 1 => S.add (partialLinearCombination S c x m) (S.smul (c (m + 1)) (x (m + 1)))

/-- 本文 `def_linear_combination` の必要十分版。 -/
def linearCombination (S : VectorSpace K V) (n : ℕ) (c : ℕ → K) (x : ℕ → V) : V :=
  partialLinearCombination S c x n

/-- 本文 `def_linear_form` の必要十分版：値の側の演算は K の + と ·。 -/
structure IsLinearForm (S : VectorSpace K V) (f : V → K) : Prop where
  map_add : ∀ x y : V, f (S.add x y) = f x + f y
  map_smul : ∀ (l : K) (x : V), f (S.smul l x) = l * f x

/-- 本文 `def_linear_independence` の必要十分版。 -/
def IsLinearlyIndependentFamily [Zero K] (S : VectorSpace K V) (n : ℕ) (b : ℕ → V) : Prop :=
  ∀ c : ℕ → K, linearCombination S n c b = S.zero → ∀ k : ℕ, 1 ≤ k → k ≤ n → c k = 0

/-- 本文 `def_spanning_family` の必要十分版。 -/
def SpansByLinearCombination (S : VectorSpace K V) (n : ℕ) (b : ℕ → V) : Prop :=
  ∀ x : V, ∃ c : ℕ → K, linearCombination S n c b = x

/-- 本文 `def_basis` の必要十分版。 -/
structure IsBasisFamily [Zero K] (S : VectorSpace K V) (n : ℕ) (b : ℕ → V) : Prop where
  linearlyIndependent : IsLinearlyIndependentFamily S n b
  spans : SpansByLinearCombination S n b

end VectorSpace

/-- 本文 `def_ordered_sum_in_complex_numbers` の S_m の必要十分版。 -/
def partialOrderedSum {K : Type u} [Add K] [Zero K] (a : ℕ → K) : ℕ → K
  | 0 => 0
  | m + 1 => partialOrderedSum a m + a (m + 1)

/-- 本文 `def_ordered_sum_in_complex_numbers` の必要十分版。 -/
def orderedSum {K : Type u} [Add K] [Zero K] (n : ℕ) (a : ℕ → K) : K :=
  partialOrderedSum a n

/-- 本文 `def_kronecker_delta` の必要十分版。 -/
def kroneckerDelta {K : Type u} [Zero K] [One K] {X : Type v} [DecidableEq X] (i j : X) : K :=
  if i = j then 1 else 0

end CliffordMatrixIsomorphism.NecSuf
