/-
節「テンソル積」のうち、組・k 重線型写像・k 重テンソル積の定義と、k 重線型写像の後に線型写像を合成する主張の具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                          このファイル
  def_tuples_of_vector_space_elements                   Tuple（V^{1,…,k} := Idx k → V）
  def_tuple_with_one_component_replaced                 replaceComponent（v[r ↦ x]）・
                                                        replaceComponent_self・replaceComponent_of_ne（定義の二つの式）
  def_k_multilinear_map                                 IsMultilinearMap
  def_k_fold_tensor_product                             IsTensorProduct
  claim_linear_map_after_k_multilinear_map_is_k_multilinear
                                                        IsMultilinearMap.comp_linearMap

{1,…,k} は `Idx k`（`FiniteSetSum/Numbering.lean`）で表す。k = 0 のとき `Idx 0` は空で、組はただ一つである。
k 重テンソル積の普遍性は「任意の ℂ-線型空間 U」を量化するので、U の宇宙 w を `IsTensorProduct` の引数にする。

必要十分版は `NecSuf/MathematicalToolkit/TensorProduct/MultilinearMap.lean`、導出版は `TensorProductFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.Numbering
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v v' w

variable {V : Type u} {U : Type v} {U' : Type v'}

/-- 本文 `def_tuples_of_vector_space_elements`：V の元の k 個の組の集合 V^{1,…,k}。 -/
abbrev Tuple (V : Type u) (k : ℕ) : Type u := Idx k → V

/-- 本文 `def_tuple_with_one_component_replaced`：第 r 成分を x に置き換えた組 v[r ↦ x]。 -/
def replaceComponent {k : ℕ} (v : Tuple V k) (r : Idx k) (x : V) : Tuple V k :=
  fun s => if s = r then x else v s

/-- 本文 `def_tuple_with_one_component_replaced` の一つ目の式 v[r ↦ x](r) = x。 -/
theorem replaceComponent_self {k : ℕ} (v : Tuple V k) (r : Idx k) (x : V) :
    replaceComponent v r x r = x := by
  unfold replaceComponent
  rw [if_pos rfl]

/-- 本文 `def_tuple_with_one_component_replaced` の二つ目の式 v[r ↦ x](s) = v(s)（s ≠ r）。 -/
theorem replaceComponent_of_ne {k : ℕ} (v : Tuple V k) (r : Idx k) (x : V) (s : Idx k)
    (h : s ≠ r) : replaceComponent v r x s = v s := by
  unfold replaceComponent
  rw [if_neg h]

/-- 本文 `def_k_multilinear_map`：各成分について加法とスカラー倍を保つ写像 h : V^{1,…,k} → U。 -/
structure IsMultilinearMap (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U) (k : ℕ)
    (h : Tuple V k → U) : Prop where
  /-- r 番目の成分について加法を保つ -/
  map_add : ∀ (v : Tuple V k) (r : Idx k) (x y : V),
    h (replaceComponent v r (SV.add x y)) = SU.add (h (replaceComponent v r x)) (h (replaceComponent v r y))
  /-- r 番目の成分についてスカラー倍を保つ -/
  map_smul : ∀ (v : Tuple V k) (r : Idx k) (l : ℂ) (x : V),
    h (replaceComponent v r (SV.smul l x)) = SU.smul l (h (replaceComponent v r x))

/-- 本文 `def_k_fold_tensor_product`：(T, τ) が V の k 重テンソル積であること。
τ が k 重線型写像であり、任意の ℂ-線型空間 U と k 重線型写像 h について、h̄ ∘ τ = h を満たす線型写像 h̄ がただ一つある。 -/
structure IsTensorProduct (SV : ComplexVectorSpace V) (k : ℕ) {T : Type v} (ST : ComplexVectorSpace T)
    (τ : Tuple V k → T) : Prop where
  /-- τ は k 重線型写像 -/
  multilinear : IsMultilinearMap SV ST k τ
  /-- k 重テンソル積の普遍性 -/
  universal : ∀ (U : Type w) (SU : ComplexVectorSpace U) (h : Tuple V k → U),
    IsMultilinearMap SV SU k h →
      ∃ hbar : T → U, (IsComplexLinearMap ST SU hbar ∧ ∀ v : Tuple V k, hbar (τ v) = h v) ∧
        ∀ g : T → U, (IsComplexLinearMap ST SU g ∧ ∀ v : Tuple V k, g (τ v) = h v) → g = hbar

/-- 本文 `claim_linear_map_after_k_multilinear_map_is_k_multilinear`：f ∘ h は k 重線型写像である。 -/
theorem IsMultilinearMap.comp_linearMap {SV : ComplexVectorSpace V} {SU : ComplexVectorSpace U}
    {SU' : ComplexVectorSpace U'} {k : ℕ} {h : Tuple V k → U} (hh : IsMultilinearMap SV SU k h)
    {f : U → U'} (hf : IsComplexLinearMap SU SU' f) :
    IsMultilinearMap SV SU' k (fun v => f (h v)) where
  map_add v r x y := calc
    f (h (replaceComponent v r (SV.add x y)))
        = f (SU.add (h (replaceComponent v r x)) (h (replaceComponent v r y))) := by
          rw [hh.map_add v r x y]
    _ = SU'.add (f (h (replaceComponent v r x))) (f (h (replaceComponent v r y))) :=
          hf.map_add _ _
  map_smul v r l x := calc
    f (h (replaceComponent v r (SV.smul l x)))
        = f (SU.smul l (h (replaceComponent v r x))) := by rw [hh.map_smul v r l x]
    _ = SU'.smul l (f (h (replaceComponent v r x))) := hf.map_smul _ _

end CliffordMatrixIsomorphism.ComplexVectorSpace
