/-
節「有限集合の上の和」の具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引き、
具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質（mathlib の補題）を渡して示す。

  具体版                       必要十分版の特殊化
  moveIndex                    moveIndex_eq_necSuf（同じ式。rfl）
  sumOverFiniteSet             sumOverFiniteSet_eq_necSuf（同じ番号付けを `Classical.choose` で選ぶので、線型結合の一致に帰着）
  各主張                       …_of_necSuf

番号付けの定義（`Numbering.lean`）は ℂ を含まないので、具体版と必要十分版が同じものを使う。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.DoubleSum
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ComplexVectorSpaceFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.DoubleSum

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v w w'

variable {V : Type u} {U : Type v}

/-! ### 定義の対応 -/

theorem moveIndex_eq_necSuf (j k : ℕ) : moveIndex j k = NecSuf.VectorSpace.moveIndex j k := rfl

theorem sumOverFiniteSet_eq_necSuf (S : ComplexVectorSpace V) {X : Type w} (hX : IsFiniteSet X)
    (c : X → ℂ) (v : X → V) :
    sumOverFiniteSet S hX c v = NecSuf.VectorSpace.sumOverFiniteSet S.toNecSuf hX c v :=
  linearCombination_eq_necSuf S _ _ _

/-! ### 主張 -/

theorem linearCombination_moveTermToLast_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (c : ℕ → ℂ)
    (x : ℕ → V) (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) :
    linearCombination S n c x
      = S.add (linearCombination S (n - 1) (fun k => c (moveIndex j k)) (fun k => x (moveIndex j k)))
          (S.smul (c j) (x j)) := by
  rw [linearCombination_eq_necSuf S n, linearCombination_eq_necSuf S (n - 1)]
  exact NecSuf.VectorSpace.linearCombination_moveTermToLast S.toNecSuf n c x j hj1 hjn

theorem linearCombination_reindex_of_necSuf (S : ComplexVectorSpace V) (n n' : ℕ) (y : ℕ → V)
    (μ : ℕ → ℂ) (σ : Idx n → Idx n') (hσ : IsNumbering n σ) :
    linearCombination S n (numberedFamily σ (fun i => μ i.1) 0)
        (numberedFamily σ (fun i => y i.1) S.zero)
      = linearCombination S n' μ y := by
  rw [linearCombination_eq_necSuf S n, linearCombination_eq_necSuf S n']
  exact NecSuf.VectorSpace.linearCombination_reindex S.toNecSuf n n' y μ σ hσ

theorem sumOverFiniteSet_eq_of_necSuf (S : ComplexVectorSpace V) {X : Type w} (hX : IsFiniteSet X)
    (c : X → ℂ) (v : X → V) (n' : ℕ) (e' : Idx n' → X) (he' : IsNumbering n' e') :
    sumOverFiniteSet S hX c v
      = linearCombination S n' (numberedFamily e' c 0) (numberedFamily e' v S.zero) := by
  rw [sumOverFiniteSet_eq_necSuf, linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.sumOverFiniteSet_eq S.toNecSuf hX c v n' e' he'

theorem sumOverFiniteSet_of_isEmpty_of_necSuf (S : ComplexVectorSpace V) {X : Type w}
    (hX : IsFiniteSet X) (hempty : X → False) (c : X → ℂ) (v : X → V) :
    sumOverFiniteSet S hX c v = S.zero := by
  rw [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.sumOverFiniteSet_of_isEmpty S.toNecSuf hX hempty c v

theorem sumOverFiniteSet_add_of_same_family_of_necSuf (S : ComplexVectorSpace V) {X : Type w}
    (hX : IsFiniteSet X) (v : X → V) (c d : X → ℂ) :
    S.add (sumOverFiniteSet S hX c v) (sumOverFiniteSet S hX d v)
      = sumOverFiniteSet S hX (fun x => c x + d x) v := by
  simp only [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.sumOverFiniteSet_add_of_same_family S.toNecSuf hX v c d

theorem smul_sumOverFiniteSet_of_necSuf (S : ComplexVectorSpace V) {X : Type w} (hX : IsFiniteSet X)
    (v : X → V) (c : X → ℂ) (ρ : ℂ) :
    S.smul ρ (sumOverFiniteSet S hX c v) = sumOverFiniteSet S hX (fun x => ρ * c x) v := by
  simp only [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.smul_sumOverFiniteSet S.toNecSuf (_root_.add_zero 0) mul_zero hX v c ρ

theorem sumOverFiniteSet_add_of_same_coefficients_of_necSuf (S : ComplexVectorSpace V) {X : Type w}
    (hX : IsFiniteSet X) (v w : X → V) (c : X → ℂ) :
    S.add (sumOverFiniteSet S hX c v) (sumOverFiniteSet S hX c w)
      = sumOverFiniteSet S hX c (fun x => S.add (v x) (w x)) := by
  simp only [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.sumOverFiniteSet_add_of_same_coefficients S.toNecSuf hX v w c

theorem IsComplexLinearMap.map_sumOverFiniteSet_of_necSuf {SV : ComplexVectorSpace V}
    {SU : ComplexVectorSpace U} {f : V → U} (hf : IsComplexLinearMap SV SU f) {X : Type w}
    (hX : IsFiniteSet X) (c : X → ℂ) (v : X → V) :
    f (sumOverFiniteSet SV hX c v) = sumOverFiniteSet SU hX c (fun x => f (v x)) := by
  simp only [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.IsLinearMap.map_sumOverFiniteSet
    ((isComplexLinearMap_iff_necSuf SV SU f).1 hf) (_root_.add_zero 0) hX c v

theorem IsComplexLinearMap.map_linearCombination_of_necSuf {SV : ComplexVectorSpace V}
    {SU : ComplexVectorSpace U} {f : V → U} (hf : IsComplexLinearMap SV SU f) (n : ℕ) (c : ℕ → ℂ)
    (x : ℕ → V) :
    f (linearCombination SV n c x) = linearCombination SU n c (fun k => f (x k)) := by
  rw [linearCombination_eq_necSuf SV, linearCombination_eq_necSuf SU]
  exact NecSuf.VectorSpace.IsLinearMap.map_linearCombination
    ((isComplexLinearMap_iff_necSuf SV SU f).1 hf) (_root_.add_zero 0) n c x

theorem sumOverFiniteSet_kroneckerDelta_of_necSuf (S : ComplexVectorSpace V) {X : Type w}
    [DecidableEq X] (hX : IsFiniteSet X) (v : X → V) (x : X) :
    sumOverFiniteSet S hX (fun y => kroneckerDelta x y) v = v x := by
  rw [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.sumOverFiniteSet_kroneckerDelta S.toNecSuf (_root_.add_zero 0) hX v x

theorem sumOverFiniteSet_congr_of_necSuf (S : ComplexVectorSpace V) {X : Type w} (hX : IsFiniteSet X)
    (c d : X → ℂ) (v u : X → V) (h : ∀ x : X, S.smul (c x) (v x) = S.smul (d x) (u x)) :
    sumOverFiniteSet S hX c v = sumOverFiniteSet S hX d u := by
  simp only [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.sumOverFiniteSet_congr S.toNecSuf hX c d v u h

theorem sumOverFiniteSet_double_congr_of_necSuf (S : ComplexVectorSpace V) {X : Type w}
    {Y : Type w'} (hX : IsFiniteSet X) (hY : IsFiniteSet Y) (c d : X → Y → ℂ) (v u : X → Y → V)
    (h : ∀ (x : X) (y : Y), S.smul (c x y) (v x y) = S.smul (d x y) (u x y)) :
    sumOverFiniteSet S hX (fun _ => 1) (fun x => sumOverFiniteSet S hY (c x) (v x))
      = sumOverFiniteSet S hX (fun _ => 1) (fun x => sumOverFiniteSet S hY (d x) (u x)) := by
  simp only [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.sumOverFiniteSet_double_congr S.toNecSuf hX hY c d v u h

theorem IsComplexLinearMap.map_double_sumOverFiniteSet_of_necSuf {SV : ComplexVectorSpace V}
    {SU : ComplexVectorSpace U} {f : V → U} (hf : IsComplexLinearMap SV SU f) {X : Type w}
    {Y : Type w'} (hX : IsFiniteSet X) (hY : IsFiniteSet Y) (c : X → Y → ℂ) (v : X → Y → V) :
    f (sumOverFiniteSet SV hX (fun _ => 1) (fun x => sumOverFiniteSet SV hY (c x) (v x)))
      = sumOverFiniteSet SU hX (fun _ => 1)
          (fun x => sumOverFiniteSet SU hY (c x) (fun y => f (v x y))) := by
  simp only [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.IsLinearMap.map_double_sumOverFiniteSet
    ((isComplexLinearMap_iff_necSuf SV SU f).1 hf) (_root_.add_zero 0) hX hY c v

theorem sumOverFiniteSet_interchange_of_necSuf (S : ComplexVectorSpace V) {X : Type w} {Y : Type w'}
    (hX : IsFiniteSet X) (hY : IsFiniteSet Y) (c : X → Y → ℂ) (v : X → Y → V) :
    sumOverFiniteSet S hX (fun _ => 1) (fun x => sumOverFiniteSet S hY (c x) (v x))
      = sumOverFiniteSet S hY (fun _ => 1)
          (fun y => sumOverFiniteSet S hX (fun x => c x y) (fun x => v x y)) := by
  simp only [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.sumOverFiniteSet_interchange S.toNecSuf hX hY c v

end CliffordMatrixIsomorphism.ComplexVectorSpace
