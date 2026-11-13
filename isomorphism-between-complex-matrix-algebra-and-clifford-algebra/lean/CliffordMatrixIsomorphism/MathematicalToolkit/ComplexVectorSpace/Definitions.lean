/-
節「ℂ-線型空間」の定義の具体版。mathlib の `Module`・`LinearMap`・`Basis` を使わず、
本文の組 (V, +_V, ·_V, 0_V) のとおりに structure と def で書く。ℂ の四則は mathlib の `ℂ` のものを使う。

  本文のラベル                          このファイル
  def_complex_vector_space              ComplexVectorSpace
  def_linear_map                        IsComplexLinearMap
  def_linear_combination                partialLinearCombination（L_m）・linearCombination（L_n）
  def_linear_form                       IsComplexLinearForm
  def_linear_independence               IsLinearlyIndependentFamily
  def_spanning_family                   SpansByLinearCombination
  def_basis                             IsBasisFamily
  def_ordered_sum_in_complex_numbers    partialOrderedSum（S_m）・orderedSum（S_n）
  def_kronecker_delta                   kroneckerDelta

番号付けた族 b:{1,…,n}→V は、Lean では `ℕ → V` で表し、1,…,n の外の値は使わない。
線型結合・一次独立・張ること・番号順の和は、どれも 1,…,n での値だけを見る形に書いてある
（一次独立と張ることの係数も `ℕ → ℂ` で与えるが、1,…,n の外の係数は線型結合に現れない）。
クロネッカーのデルタは、本文では X := {1,…,n} の上で使うところを Lean では X := ℕ の上で使う。
値は等号だけで決まるので、1,…,n の二元では一致する。

必要十分版は `NecSuf/MathematicalToolkit/ComplexVectorSpace/` の同じ名前のファイル、
導出版は `ComplexVectorSpaceFromNecSuf.lean`。
-/
import Mathlib.Data.Complex.Basic

namespace CliffordMatrixIsomorphism

universe u v

/-- 本文 `def_complex_vector_space`：ℂ-線型空間 (V, +_V, ·_V, 0_V)。
スカラー倍 `smul` は ℂ の乗法 `*` とは別の写像である。有限次元は仮定しない。 -/
structure ComplexVectorSpace (V : Type u) where
  add : V → V → V
  smul : ℂ → V → V
  zero : V
  /-- 加法の結合法則 -/
  add_assoc : ∀ x y z : V, add (add x y) z = add x (add y z)
  /-- 加法の交換法則 -/
  add_comm : ∀ x y : V, add x y = add y x
  /-- 加法の単位元 -/
  add_zero : ∀ x : V, add x zero = x
  /-- 加法の逆元 -/
  exists_add_inverse : ∀ x : V, ∃ x' : V, add x x' = zero
  /-- スカラー倍の結合法則 -/
  smul_assoc : ∀ (l m : ℂ) (x : V), smul (l * m) x = smul l (smul m x)
  /-- スカラー倍の単位元 -/
  one_smul : ∀ x : V, smul 1 x = x
  /-- ベクトルの加法についての分配法則 -/
  smul_add : ∀ (l : ℂ) (x y : V), smul l (add x y) = add (smul l x) (smul l y)
  /-- スカラーの加法についての分配法則 -/
  add_smul : ∀ (l m : ℂ) (x : V), smul (l + m) x = add (smul l x) (smul m x)

namespace ComplexVectorSpace

variable {V : Type u} {U : Type v}

/-- 本文 `def_linear_map`：加法とスカラー倍を保つ写像。零を保つことは条件に含めない。 -/
structure IsComplexLinearMap (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U)
    (f : V → U) : Prop where
  /-- 加法を保つ -/
  map_add : ∀ x y : V, f (SV.add x y) = SU.add (f x) (f y)
  /-- スカラー倍を保つ -/
  map_smul : ∀ (l : ℂ) (x : V), f (SV.smul l x) = SU.smul l (f x)

/-- 本文 `def_linear_combination` の L_m：L_0 = 0_V、L_m = L_{m-1} +_V (λ_m ·_V x_m)。 -/
def partialLinearCombination (S : ComplexVectorSpace V) (c : ℕ → ℂ) (x : ℕ → V) : ℕ → V
  | 0 => S.zero
  | m + 1 => S.add (partialLinearCombination S c x m) (S.smul (c (m + 1)) (x (m + 1)))

/-- 本文 `def_linear_combination`：Σ_{k=1}^{n} λ_k ·_V x_k := L_n。 -/
def linearCombination (S : ComplexVectorSpace V) (n : ℕ) (c : ℕ → ℂ) (x : ℕ → V) : V :=
  partialLinearCombination S c x n

/-- 本文 `def_linear_form`：値の側の演算を ℂ の加法と乗法で直接書く。 -/
structure IsComplexLinearForm (S : ComplexVectorSpace V) (f : V → ℂ) : Prop where
  /-- 加法を保つ -/
  map_add : ∀ x y : V, f (S.add x y) = f x + f y
  /-- スカラー倍を保つ -/
  map_smul : ∀ (l : ℂ) (x : V), f (S.smul l x) = l * f x

/-- 本文 `def_linear_independence`。 -/
def IsLinearlyIndependentFamily (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) : Prop :=
  ∀ c : ℕ → ℂ, linearCombination S n c b = S.zero → ∀ k : ℕ, 1 ≤ k → k ≤ n → c k = 0

/-- 本文 `def_spanning_family`。 -/
def SpansByLinearCombination (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) : Prop :=
  ∀ x : V, ∃ c : ℕ → ℂ, linearCombination S n c b = x

/-- 本文 `def_basis`：一次独立で、かつ線型結合で張る族。 -/
structure IsBasisFamily (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) : Prop where
  linearlyIndependent : IsLinearlyIndependentFamily S n b
  spans : SpansByLinearCombination S n b

end ComplexVectorSpace

/-- 本文 `def_ordered_sum_in_complex_numbers` の S_m：S_0 = 0_ℂ、S_m = S_{m-1} +_ℂ α_m。 -/
def partialOrderedSum (a : ℕ → ℂ) : ℕ → ℂ
  | 0 => 0
  | m + 1 => partialOrderedSum a m + a (m + 1)

/-- 本文 `def_ordered_sum_in_complex_numbers`：Σ_{ℂ,k=1}^{n} α_k := S_n。 -/
def orderedSum (n : ℕ) (a : ℕ → ℂ) : ℂ :=
  partialOrderedSum a n

/-- 本文 `def_kronecker_delta`：値は 1_ℂ か 0_ℂ。X の上の等号だけを使う。 -/
def kroneckerDelta {X : Type u} [DecidableEq X] (i j : X) : ℂ :=
  if i = j then 1 else 0

end CliffordMatrixIsomorphism
