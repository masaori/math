/-
節「テンソル代数」のうち、番号付けた線型空間の族の直和の必要十分版。具体版
`MathematicalToolkit/TensorAlgebra/DirectSumOfFamily.lean` と同じ structure と calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                          このファイル                         K に要るもの
  def_direct_sum_of_family_of_vector_spaces                             IsZeroBound・DirectSumOfFamily       なし
  claim_componentwise_sum_lies_in_direct_sum_of_family                  componentwiseSum_isZeroBound         なし
  claim_componentwise_scalar_multiple_lies_in_direct_sum_of_family      componentwiseSmul_isZeroBound        0 + 0 = 0、a · 0 = 0
  def_operations_on_direct_sum_of_family_of_vector_spaces               DirectSumOfFamily.add・smul・zero    smul は上の二つ
  claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space   directSumOfFamilyVectorSpace         上の二つと、1 + n = 0 となる n
  def_embedding_into_component_of_direct_sum_of_family                  embedComponent 等                    なし
  claim_embedding_into_component_of_direct_sum_of_family_is_linear_map  embedComponent_isLinearMap           0 + 0 = 0、a · 0 = 0

0 + 0 = 0 と a · 0 = 0 は、どれも λ ·_{E_j} 0_{E_j} = 0_{E_j}（`smul_zero_eq_zero`）から来る。スカラー倍の値が零の境をもつことに要るので、
∗_D を定めるところで既に要る。加法の逆元は本文どおり x' := (-1_ℂ) ∗_D x で作るので、-1_ℂ を 1 + n = 0 を満たす K の元 n に替える。
emb_k が線型写像であることの証明は 0 + 0 = 0 と a · 0 = 0 しか使わないが、主張の行き先の D を線型空間として書くために
`directSumOfFamilyVectorSpace` の引数 n と 1 + n = 0 も主張に現れる。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.ZeroVector

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe v uK

variable {K : Type uK} [Add K] [Mul K] [One K]

/-- 族の直和のスカラー倍が定まることと、成分への埋め込みがスカラー倍を保つことに要る K の性質
（どちらも `smul_zero_eq_zero` の λ ·_{E_j} 0_{E_j} = 0_{E_j} から来る）。 -/
structure ScalarMultipleOfZeroLaws (K : Type uK) [Add K] [Mul K] [One K] [Zero K] : Prop where
  zero_add_zero : (0 : K) + 0 = 0
  mul_zero : ∀ a : K, a * 0 = 0

variable {E : ℕ → Type v} (S : ∀ j : ℕ, VectorSpace K (E j))

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
theorem componentwiseSmul_isZeroBound [Zero K] (L : ScalarMultipleOfZeroLaws K) (l : K) (x : DirectSumOfFamily S) :
    ∃ N : ℕ, IsZeroBound S (fun j => (S j).smul l (x.1 j)) N := by
  obtain ⟨N, hx⟩ := x.2
  refine ⟨N, fun j hj => ?_⟩
  calc (S j).smul l (x.1 j)
      = (S j).smul l (S j).zero := by rw [hx j hj]
    _ = (S j).zero := smul_zero_eq_zero (S j) L.zero_add_zero L.mul_zero l

namespace DirectSumOfFamily

/-- 本文 `def_operations_on_direct_sum_of_family_of_vector_spaces`：成分ごとの加法 +_D。 -/
def add (x y : DirectSumOfFamily S) : DirectSumOfFamily S :=
  ⟨fun j => (S j).add (x.1 j) (y.1 j), componentwiseSum_isZeroBound S x y⟩

/-- 本文 `def_operations_on_direct_sum_of_family_of_vector_spaces`：成分ごとのスカラー倍 ∗_D。 -/
def smul [Zero K] (L : ScalarMultipleOfZeroLaws K) (l : K) (x : DirectSumOfFamily S) : DirectSumOfFamily S :=
  ⟨fun j => (S j).smul l (x.1 j), componentwiseSmul_isZeroBound S L l x⟩

/-- 本文 `def_operations_on_direct_sum_of_family_of_vector_spaces`：成分ごとの零 0_D（零の境 0）。 -/
def zero : DirectSumOfFamily S :=
  ⟨fun j => (S j).zero, ⟨0, fun _ _ => rfl⟩⟩

end DirectSumOfFamily

open DirectSumOfFamily in
/-- 本文 `claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space`：(D, +_D, ∗_D, 0_D) は K 上の線型空間である。
各条件は第 j 成分の等式を本文の式変形のとおりに示し、`DirectSumOfFamily.ext` で D の等式にする。 -/
def directSumOfFamilyVectorSpace [Zero K] (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) :
    VectorSpace K (DirectSumOfFamily S) where
  add := DirectSumOfFamily.add S
  smul := DirectSumOfFamily.smul S L
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
  exists_add_inverse x := ⟨DirectSumOfFamily.smul S L n x, ext fun j => calc
    (DirectSumOfFamily.add S x (DirectSumOfFamily.smul S L n x)).1 j = (S j).add (x.1 j) ((DirectSumOfFamily.smul S L n x).1 j) := rfl
    _ = (S j).add (x.1 j) ((S j).smul n (x.1 j)) := rfl
    _ = (S j).add ((S j).smul 1 (x.1 j)) ((S j).smul n (x.1 j)) := by
          rw [(S j).one_smul (x.1 j)]
    _ = (S j).smul (1 + n) (x.1 j) := ((S j).add_smul 1 n (x.1 j)).symm
    _ = (S j).smul 0 (x.1 j) := by rw [h1n]
    _ = (S j).zero := zero_smul_eq_zero (S j) L.zero_add_zero (x.1 j)
    _ = (DirectSumOfFamily.zero S).1 j := rfl⟩
  smul_assoc l m x := ext fun j => calc
    (DirectSumOfFamily.smul S L (l * m) x).1 j = (S j).smul (l * m) (x.1 j) := rfl
    _ = (S j).smul l ((S j).smul m (x.1 j)) := (S j).smul_assoc l m (x.1 j)
    _ = (S j).smul l ((DirectSumOfFamily.smul S L m x).1 j) := rfl
    _ = (DirectSumOfFamily.smul S L l (DirectSumOfFamily.smul S L m x)).1 j := rfl
  one_smul x := ext fun j => calc
    (DirectSumOfFamily.smul S L 1 x).1 j = (S j).smul 1 (x.1 j) := rfl
    _ = x.1 j := (S j).one_smul (x.1 j)
  smul_add l x y := ext fun j => calc
    (DirectSumOfFamily.smul S L l (DirectSumOfFamily.add S x y)).1 j = (S j).smul l ((DirectSumOfFamily.add S x y).1 j) := rfl
    _ = (S j).smul l ((S j).add (x.1 j) (y.1 j)) := rfl
    _ = (S j).add ((S j).smul l (x.1 j)) ((S j).smul l (y.1 j)) := (S j).smul_add l (x.1 j) (y.1 j)
    _ = (S j).add ((DirectSumOfFamily.smul S L l x).1 j) ((DirectSumOfFamily.smul S L l y).1 j) := rfl
    _ = (DirectSumOfFamily.add S (DirectSumOfFamily.smul S L l x) (DirectSumOfFamily.smul S L l y)).1 j := rfl
  add_smul l m x := ext fun j => calc
    (DirectSumOfFamily.smul S L (l + m) x).1 j = (S j).smul (l + m) (x.1 j) := rfl
    _ = (S j).add ((S j).smul l (x.1 j)) ((S j).smul m (x.1 j)) := (S j).add_smul l m (x.1 j)
    _ = (S j).add ((DirectSumOfFamily.smul S L l x).1 j) ((DirectSumOfFamily.smul S L m x).1 j) := rfl
    _ = (DirectSumOfFamily.add S (DirectSumOfFamily.smul S L l x) (DirectSumOfFamily.smul S L m x)).1 j := rfl

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
theorem embedComponent_isLinearMap [Zero K] (L : ScalarMultipleOfZeroLaws K) (n : K) (h1n : 1 + n = 0) (k : ℕ) :
    IsLinearMap (S k) (directSumOfFamilyVectorSpace S L n h1n) (embedComponent S k) where
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
      _ = (DirectSumOfFamily.smul S L l (embedComponent S k y)).1 k := rfl)
    (fun j h => calc (embedComponent S k ((S k).smul l y)).1 j
        = (S j).zero := embedComponent_of_ne S k _ j h
      _ = (S j).smul l (S j).zero := (smul_zero_eq_zero (S j) L.zero_add_zero L.mul_zero l).symm
      _ = (S j).smul l ((embedComponent S k y).1 j) := by rw [embedComponent_of_ne S k y j h]
      _ = (DirectSumOfFamily.smul S L l (embedComponent S k y)).1 j := rfl)

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
