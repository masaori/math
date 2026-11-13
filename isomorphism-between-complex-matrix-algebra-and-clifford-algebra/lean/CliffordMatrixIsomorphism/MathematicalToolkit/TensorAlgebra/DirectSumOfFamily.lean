/-
節「テンソル代数」のうち、番号付けた ℂ-線型空間の族の直和の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                          このファイル
  def_direct_sum_of_family_of_vector_spaces                             IsZeroBound（零の境）・DirectSumOfFamily（集合 D）・
                                                                        DirectSumOfFamily.ext（成分ごとの等号）
  claim_componentwise_sum_lies_in_direct_sum_of_family                  componentwiseSum_isZeroBound
  claim_componentwise_scalar_multiple_lies_in_direct_sum_of_family      componentwiseSmul_isZeroBound
  def_operations_on_direct_sum_of_family_of_vector_spaces               DirectSumOfFamily.add・smul・zero
  claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space   directSumOfFamilyVectorSpace
  def_embedding_into_component_of_direct_sum_of_family                  embedComponent（emb_k）・embedComponent_self・
                                                                        embedComponent_of_ne（定義の二つの式）
  claim_embedding_into_component_of_direct_sum_of_family_is_linear_map  embedComponent_isLinearMap

族 (E_j)_{j ∈ ℤ_{≥0}} は `E : ℕ → Type v` と各 j の ℂ-線型空間 `S j` で表す。D の元は、族 x : (j : ℕ) → E j と、
零の境が存在することの証明の組（部分型）である。D の二つの元が等しいことは、本文どおり各成分の等式から作る
（`DirectSumOfFamily.ext`）。

emb_k(y) の第 j 成分は、j = k のとき y を E k から E j へ型の等式で運んだもの（`cast`）とする。
j と k は ℕ の元として等しいだけで、E k と E j は Lean では別の式なので、運ぶ写像に `cast` の名前が付く。
j = k の成分と j ≠ k の成分を分けて比べる本文の証明は、`DirectSumOfFamily.ext_of_component_and_others` で書く。

必要十分版は `NecSuf/MathematicalToolkit/TensorAlgebra/DirectSumOfFamily.lean`、導出版は `TensorAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ZeroVector

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe v

variable {E : ℕ → Type v} (S : ∀ j : ℕ, ComplexVectorSpace (E j))

/-- 本文 `def_direct_sum_of_family_of_vector_spaces`：N が族 x の零の境であること（j > N なら x_j = 0_{E_j}）。 -/
def IsZeroBound (x : (j : ℕ) → E j) (N : ℕ) : Prop :=
  ∀ j : ℕ, N < j → x j = (S j).zero

/-- 本文 `def_direct_sum_of_family_of_vector_spaces`：零の境をもつ族の全体の集合 D = ⊕_j E_j。 -/
def DirectSumOfFamily : Type v :=
  {x : (j : ℕ) → E j // ∃ N : ℕ, IsZeroBound S x N}

namespace DirectSumOfFamily

variable {S}

/-- 本文 `def_direct_sum_of_family_of_vector_spaces`：D の二つの元は、すべての成分が等しいとき等しい。 -/
theorem ext {x y : DirectSumOfFamily S} (h : ∀ j : ℕ, x.1 j = y.1 j) : x = y :=
  Subtype.ext (funext h)

/-- D の二つの元は、第 k 成分が等しく、k でないすべての成分が等しいとき等しい（本文の j = k と j ≠ k の場合分け）。 -/
theorem ext_of_component_and_others {x y : DirectSumOfFamily S} (k : ℕ) (hk : x.1 k = y.1 k)
    (hne : ∀ j : ℕ, j ≠ k → x.1 j = y.1 j) : x = y := by
  apply ext
  intro j
  by_cases h : j = k
  · subst h
    exact hk
  · exact hne j h

end DirectSumOfFamily

/-- 本文 `claim_componentwise_sum_lies_in_direct_sum_of_family`：成分ごとの和は零の境 max(N_x, N_y) をもつ。 -/
theorem componentwiseSum_isZeroBound (x y : DirectSumOfFamily S) :
    ∃ N : ℕ, IsZeroBound S (fun j => (S j).add (x.1 j) (y.1 j)) N := by
  obtain ⟨Nx, hx⟩ := x.2
  obtain ⟨Ny, hy⟩ := y.2
  refine ⟨max Nx Ny, fun j hj => ?_⟩
  have hjx : Nx < j := lt_of_le_of_lt (le_max_left Nx Ny) hj
  have hjy : Ny < j := lt_of_le_of_lt (le_max_right Nx Ny) hj
  calc (S j).add (x.1 j) (y.1 j)
      = (S j).add (S j).zero (y.1 j) := by rw [hx j hjx]
    _ = (S j).add (S j).zero (S j).zero := by rw [hy j hjy]
    _ = (S j).zero := (S j).add_zero (S j).zero

/-- 本文 `claim_componentwise_scalar_multiple_lies_in_direct_sum_of_family`：成分ごとのスカラー倍は x の零の境をもつ。 -/
theorem componentwiseSmul_isZeroBound (l : ℂ) (x : DirectSumOfFamily S) :
    ∃ N : ℕ, IsZeroBound S (fun j => (S j).smul l (x.1 j)) N := by
  obtain ⟨N, hx⟩ := x.2
  refine ⟨N, fun j hj => ?_⟩
  calc (S j).smul l (x.1 j)
      = (S j).smul l (S j).zero := by rw [hx j hj]
    _ = (S j).zero := smul_zero_eq_zero (S j) l

namespace DirectSumOfFamily

/-- 本文 `def_operations_on_direct_sum_of_family_of_vector_spaces`：成分ごとの加法 +_D。 -/
def add (x y : DirectSumOfFamily S) : DirectSumOfFamily S :=
  ⟨fun j => (S j).add (x.1 j) (y.1 j), componentwiseSum_isZeroBound S x y⟩

/-- 本文 `def_operations_on_direct_sum_of_family_of_vector_spaces`：成分ごとのスカラー倍 ∗_D。 -/
def smul (l : ℂ) (x : DirectSumOfFamily S) : DirectSumOfFamily S :=
  ⟨fun j => (S j).smul l (x.1 j), componentwiseSmul_isZeroBound S l x⟩

/-- 本文 `def_operations_on_direct_sum_of_family_of_vector_spaces`：成分ごとの零 0_D（零の境 0）。 -/
def zero : DirectSumOfFamily S :=
  ⟨fun j => (S j).zero, ⟨0, fun _ _ => rfl⟩⟩

end DirectSumOfFamily

open DirectSumOfFamily in
/-- 本文 `claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space`：(D, +_D, ∗_D, 0_D) は ℂ-線型空間である。
各条件は第 j 成分の等式を本文の式変形のとおりに示し、`DirectSumOfFamily.ext` で D の等式にする。 -/
def directSumOfFamilyVectorSpace : ComplexVectorSpace (DirectSumOfFamily S) where
  add := DirectSumOfFamily.add S
  smul := DirectSumOfFamily.smul S
  zero := DirectSumOfFamily.zero S
  add_assoc x y z := ext fun j => calc
    (DirectSumOfFamily.add S (DirectSumOfFamily.add S x y) z).1 j = (S j).add ((DirectSumOfFamily.add S x y).1 j) (z.1 j) := rfl
    _ = (S j).add ((S j).add (x.1 j) (y.1 j)) (z.1 j) := rfl
    _ = (S j).add (x.1 j) ((S j).add (y.1 j) (z.1 j)) := (S j).add_assoc (x.1 j) (y.1 j) (z.1 j)
    _ = (S j).add (x.1 j) ((DirectSumOfFamily.add S y z).1 j) := rfl
    _ = (DirectSumOfFamily.add S x (DirectSumOfFamily.add S y z)).1 j := rfl
  add_comm x y := ext fun j => calc
    (DirectSumOfFamily.add S x y).1 j = (S j).add (x.1 j) (y.1 j) := rfl
    _ = (S j).add (y.1 j) (x.1 j) := (S j).add_comm (x.1 j) (y.1 j)
    _ = (DirectSumOfFamily.add S y x).1 j := rfl
  add_zero x := ext fun j => calc
    (DirectSumOfFamily.add S x (DirectSumOfFamily.zero S)).1 j = (S j).add (x.1 j) ((DirectSumOfFamily.zero S).1 j) := rfl
    _ = (S j).add (x.1 j) (S j).zero := rfl
    _ = x.1 j := (S j).add_zero (x.1 j)
  exists_add_inverse x := ⟨DirectSumOfFamily.smul S (-1) x, ext fun j => calc
    (DirectSumOfFamily.add S x (DirectSumOfFamily.smul S (-1) x)).1 j = (S j).add (x.1 j) ((DirectSumOfFamily.smul S (-1) x).1 j) := rfl
    _ = (S j).add (x.1 j) ((S j).smul (-1) (x.1 j)) := rfl
    _ = (S j).add ((S j).smul 1 (x.1 j)) ((S j).smul (-1) (x.1 j)) := by
          rw [(S j).one_smul (x.1 j)]
    _ = (S j).smul (1 + -1) (x.1 j) := ((S j).add_smul 1 (-1) (x.1 j)).symm
    _ = (S j).smul 0 (x.1 j) := by rw [add_neg_cancel (1 : ℂ)]
    _ = (S j).zero := zero_smul_eq_zero (S j) (x.1 j)
    _ = (DirectSumOfFamily.zero S).1 j := rfl⟩
  smul_assoc l m x := ext fun j => calc
    (DirectSumOfFamily.smul S (l * m) x).1 j = (S j).smul (l * m) (x.1 j) := rfl
    _ = (S j).smul l ((S j).smul m (x.1 j)) := (S j).smul_assoc l m (x.1 j)
    _ = (S j).smul l ((DirectSumOfFamily.smul S m x).1 j) := rfl
    _ = (DirectSumOfFamily.smul S l (DirectSumOfFamily.smul S m x)).1 j := rfl
  one_smul x := ext fun j => calc
    (DirectSumOfFamily.smul S 1 x).1 j = (S j).smul 1 (x.1 j) := rfl
    _ = x.1 j := (S j).one_smul (x.1 j)
  smul_add l x y := ext fun j => calc
    (DirectSumOfFamily.smul S l (DirectSumOfFamily.add S x y)).1 j = (S j).smul l ((DirectSumOfFamily.add S x y).1 j) := rfl
    _ = (S j).smul l ((S j).add (x.1 j) (y.1 j)) := rfl
    _ = (S j).add ((S j).smul l (x.1 j)) ((S j).smul l (y.1 j)) := (S j).smul_add l (x.1 j) (y.1 j)
    _ = (S j).add ((DirectSumOfFamily.smul S l x).1 j) ((DirectSumOfFamily.smul S l y).1 j) := rfl
    _ = (DirectSumOfFamily.add S (DirectSumOfFamily.smul S l x) (DirectSumOfFamily.smul S l y)).1 j := rfl
  add_smul l m x := ext fun j => calc
    (DirectSumOfFamily.smul S (l + m) x).1 j = (S j).smul (l + m) (x.1 j) := rfl
    _ = (S j).add ((S j).smul l (x.1 j)) ((S j).smul m (x.1 j)) := (S j).add_smul l m (x.1 j)
    _ = (S j).add ((DirectSumOfFamily.smul S l x).1 j) ((DirectSumOfFamily.smul S m x).1 j) := rfl
    _ = (DirectSumOfFamily.add S (DirectSumOfFamily.smul S l x) (DirectSumOfFamily.smul S m x)).1 j := rfl

/-- 本文 `def_embedding_into_component_of_direct_sum_of_family`：emb_k(y) の第 j 成分は、j = k なら y、
j ≠ k なら 0_{E_j}。k が零の境である。 -/
def embedComponent (k : ℕ) (y : E k) : DirectSumOfFamily S :=
  ⟨fun j => if h : j = k then cast (congrArg E h).symm y else (S j).zero,
    ⟨k, fun _ hj => dif_neg (Nat.ne_of_gt hj)⟩⟩

/-- 本文 `def_embedding_into_component_of_direct_sum_of_family` の一つ目の式 (emb_k(y))_k = y。 -/
theorem embedComponent_self (k : ℕ) (y : E k) : (embedComponent S k y).1 k = y := by
  show (if h : k = k then cast (congrArg E h).symm y else (S k).zero) = y
  rw [dif_pos rfl]
  rfl

/-- 本文 `def_embedding_into_component_of_direct_sum_of_family` の二つ目の式 (emb_k(y))_j = 0_{E_j}（j ≠ k）。 -/
theorem embedComponent_of_ne (k : ℕ) (y : E k) (j : ℕ) (h : j ≠ k) :
    (embedComponent S k y).1 j = (S j).zero := by
  show (if h : j = k then cast (congrArg E h).symm y else (S j).zero) = (S j).zero
  rw [dif_neg h]

open DirectSumOfFamily in
/-- 本文 `claim_embedding_into_component_of_direct_sum_of_family_is_linear_map`：emb_k は E_k から D への線型写像である。
第 k 成分と、k でない第 j 成分を、本文の四つの式変形のとおりに比べる。 -/
theorem embedComponent_isLinearMap (k : ℕ) :
    IsComplexLinearMap (S k) (directSumOfFamilyVectorSpace S) (embedComponent S k) where
  map_add y z := ext_of_component_and_others k
    (calc (embedComponent S k ((S k).add y z)).1 k
        = (S k).add y z := embedComponent_self S k _
      _ = (S k).add ((embedComponent S k y).1 k) ((embedComponent S k z).1 k) := by
            rw [embedComponent_self S k y, embedComponent_self S k z]
      _ = (DirectSumOfFamily.add S (embedComponent S k y) (embedComponent S k z)).1 k := rfl)
    (fun j h => calc (embedComponent S k ((S k).add y z)).1 j
        = (S j).zero := embedComponent_of_ne S k _ j h
      _ = (S j).add (S j).zero (S j).zero := ((S j).add_zero (S j).zero).symm
      _ = (S j).add ((embedComponent S k y).1 j) ((embedComponent S k z).1 j) := by
            rw [embedComponent_of_ne S k y j h, embedComponent_of_ne S k z j h]
      _ = (DirectSumOfFamily.add S (embedComponent S k y) (embedComponent S k z)).1 j := rfl)
  map_smul l y := ext_of_component_and_others k
    (calc (embedComponent S k ((S k).smul l y)).1 k
        = (S k).smul l y := embedComponent_self S k _
      _ = (S k).smul l ((embedComponent S k y).1 k) := by rw [embedComponent_self S k y]
      _ = (DirectSumOfFamily.smul S l (embedComponent S k y)).1 k := rfl)
    (fun j h => calc (embedComponent S k ((S k).smul l y)).1 j
        = (S j).zero := embedComponent_of_ne S k _ j h
      _ = (S j).smul l (S j).zero := (smul_zero_eq_zero (S j) l).symm
      _ = (S j).smul l ((embedComponent S k y).1 j) := by rw [embedComponent_of_ne S k y j h]
      _ = (DirectSumOfFamily.smul S l (embedComponent S k y)).1 j := rfl)

end CliffordMatrixIsomorphism.ComplexVectorSpace
