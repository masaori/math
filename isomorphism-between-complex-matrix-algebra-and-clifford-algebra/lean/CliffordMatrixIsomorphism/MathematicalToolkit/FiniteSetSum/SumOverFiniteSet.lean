/-
節「有限集合の上の和」のうち、番号の付いていない有限集合の上の和の定義と、一重の和についての主張の具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                                           このファイル
  def_sum_over_finite_set                                                sumOverFiniteSet・
                                                                         sumOverFiniteSet_eq（番号付けの取り方によらないこと）・
                                                                         sumOverFiniteSet_of_isEmpty（X が空集合なら 0_V）
  claim_sum_of_sums_over_finite_set_with_same_family                     sumOverFiniteSet_add_of_same_family
  claim_scalar_multiple_of_sum_over_finite_set                           smul_sumOverFiniteSet
  claim_sum_of_sums_over_finite_set_with_same_coefficients               sumOverFiniteSet_add_of_same_coefficients
  claim_linear_map_maps_sum_over_finite_set_to_sum_of_values             IsComplexLinearMap.map_partialLinearCombination（帰納法の主張）・
                                                                         IsComplexLinearMap.map_sumOverFiniteSet
  claim_linear_map_maps_linear_combination_to_linear_combination_of_values
                                                                         IsComplexLinearMap.map_linearCombination
  claim_sum_over_finite_set_with_kronecker_delta_picks_term              sumOverFiniteSet_kroneckerDelta
  claim_sum_over_finite_set_depends_only_on_terms                        sumOverFiniteSet_congr
  claim_double_sums_over_finite_sets_with_equal_terms_are_equal          sumOverFiniteSet_double_congr
  claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values
                                                                         IsComplexLinearMap.map_double_sumOverFiniteSet

和 Σ_{x∈X} λ_x ·_V v_x は、X が有限集合であることの証明 hX から番号付け (n, e) を `Classical.choose` で一つ選び、
線型結合 Σ_{k=1}^{n} λ_{e(k)} ·_V v_{e(k)} として定める（`sumOverFiniteSet`）。本文が「番号付け (n, e) で定義を開く」行は、
選んだ番号付けによらないこと `sumOverFiniteSet_eq` を (n, e) に当てる行である。

本文が「族が各 k で同じ値をとり、線型結合の定義が同じ漸化式で決まるので等しい」とする行と、
係数・元の族を番号付けで引き戻した族と、本文がその場で置いた族（ν_{e(k)}、b_k など）とを入れ替える行は、
1,…,n の項だけを比べる `linearCombination_eq_of_terms_eq` で書く（`ℕ` の族としては 1,…,n の外の値が違いうるため）。

本文の三つの主張（同じ係数の和の和・線型写像の像・各項の値だけで決まること）は、証明の中で線型結合の部分和 L_m の
帰納法を書く。同じ帰納法（同じ式変形の行）が `LinearCombination.lean` の
`partialLinearCombination_add_of_same_coefficients`・`partialLinearCombination_eq_of_terms_eq` に既にあるので、
そこを引く。線型写像の帰納法は既に無いので、`IsComplexLinearMap.map_partialLinearCombination` として書く。

必要十分版は `NecSuf/MathematicalToolkit/FiniteSetSum/SumOverFiniteSet.lean`、導出版は `FiniteSetSumFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.Reindexing
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.CoordinatesAndDualBasis

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v w w'

variable {V : Type u} {U : Type v}

/-- 本文 `def_sum_over_finite_set`：Σ_{x∈X} λ_x ·_V v_x := Σ_{k=1}^{n} λ_{e(k)} ·_V v_{e(k)}（(n, e) は選んだ番号付け）。 -/
noncomputable def sumOverFiniteSet (S : ComplexVectorSpace V) {X : Type w} (hX : IsFiniteSet X)
    (c : X → ℂ) (v : X → V) : V :=
  linearCombination S (Classical.choose hX)
    (numberedFamily (Classical.choose (Classical.choose_spec hX)) c 0)
    (numberedFamily (Classical.choose (Classical.choose_spec hX)) v S.zero)

/-- 本文 `def_sum_over_finite_set` の「番号付けの取り方によらないこと」：どの番号付け (n', e') で開いても同じ。
σ(k) := e'^{-1}(e(k)) で番号を付け替える。 -/
theorem sumOverFiniteSet_eq (S : ComplexVectorSpace V) {X : Type w} (hX : IsFiniteSet X)
    (c : X → ℂ) (v : X → V) (n' : ℕ) (e' : Idx n' → X) (he' : IsNumbering n' e') :
    sumOverFiniteSet S hX c v
      = linearCombination S n' (numberedFamily e' c 0) (numberedFamily e' v S.zero) := by
  set n := Classical.choose hX with hn
  set e := Classical.choose (Classical.choose_spec hX) with he_def
  have he : IsNumbering n e := Classical.choose_spec (Classical.choose_spec hX)
  -- σ(k) := e'^{-1}(e(k))
  let σ : Idx n → Idx n' := fun k => he'.inv (e k)
  -- （e' ∘ σ = e）
  have hσe : ∀ k : Idx n, e' (σ k) = e k := fun k => he'.apply_inv (e k)
  -- （σ は単射）
  have hσinj : ∀ k l : Idx n, σ k = σ l → k = l := by
    intro k l h
    apply he.injective
    calc e k = e' (σ k) := (hσe k).symm
      _ = e' (σ l) := by rw [h]
      _ = e l := hσe l
  -- （σ は全射）
  have hσsurj : ∀ i : Idx n', ∃ k : Idx n, σ k = i := by
    intro i
    refine ⟨he.inv (e' i), ?_⟩
    calc σ (he.inv (e' i)) = he'.inv (e (he.inv (e' i))) := rfl
      _ = he'.inv (e' i) := by rw [he.apply_inv (e' i)]
      _ = i := he'.inv_apply i
  have hσ : IsNumbering n σ := ⟨hσinj, hσsurj⟩
  -- （付け替えの主張を当てる族）y_i := v_{e'(i)}、μ_i := λ_{e'(i)}、y_{σ(k)} = v_{e(k)}、μ_{σ(k)} = λ_{e(k)}
  have hterms : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      S.smul (numberedFamily e c 0 k) (numberedFamily e v S.zero k)
        = S.smul (numberedFamily σ (fun i => numberedFamily e' c 0 i.1) 0 k)
            (numberedFamily σ (fun i => numberedFamily e' v S.zero i.1) S.zero k) := by
    intro k hk1 hkn
    rw [numberedFamily_of_le e c 0 k hk1 hkn, numberedFamily_of_le e v S.zero k hk1 hkn,
      numberedFamily_of_le σ _ 0 k hk1 hkn, numberedFamily_of_le σ _ S.zero k hk1 hkn,
      numberedFamily_of_le e' c 0 _ (σ ⟨k, hk1, hkn⟩).2.1 (σ ⟨k, hk1, hkn⟩).2.2,
      numberedFamily_of_le e' v S.zero _ (σ ⟨k, hk1, hkn⟩).2.1 (σ ⟨k, hk1, hkn⟩).2.2]
    have hsub : (⟨(σ ⟨k, hk1, hkn⟩).1, (σ ⟨k, hk1, hkn⟩).2.1, (σ ⟨k, hk1, hkn⟩).2.2⟩ : Idx n')
        = σ ⟨k, hk1, hkn⟩ := rfl
    rw [hsub, hσe ⟨k, hk1, hkn⟩]
  calc sumOverFiniteSet S hX c v
      = linearCombination S n (numberedFamily e c 0) (numberedFamily e v S.zero) := rfl
    _ = linearCombination S n (numberedFamily σ (fun i => numberedFamily e' c 0 i.1) 0)
          (numberedFamily σ (fun i => numberedFamily e' v S.zero i.1) S.zero) :=
        linearCombination_eq_of_terms_eq S n _ _ _ _ hterms
    _ = linearCombination S n' (numberedFamily e' c 0) (numberedFamily e' v S.zero) :=
        linearCombination_reindex S n n' _ _ σ hσ

/-- 本文 `def_sum_over_finite_set`：X が空集合なら、番号付けは n = 0 のものに限られ、和は 0_V。 -/
theorem sumOverFiniteSet_of_isEmpty (S : ComplexVectorSpace V) {X : Type w} (hX : IsFiniteSet X)
    (hempty : X → False) (c : X → ℂ) (v : X → V) : sumOverFiniteSet S hX c v = S.zero := by
  set n := Classical.choose hX with hn
  set e := Classical.choose (Classical.choose_spec hX) with he_def
  have hn0 : n = 0 := by
    rcases Nat.eq_zero_or_pos n with h | h
    · exact h
    · exact (hempty (e ⟨1, le_refl 1, h⟩)).elim
  show linearCombination S n (numberedFamily e c 0) (numberedFamily e v S.zero) = S.zero
  rw [hn0]
  rfl

/-- 本文 `claim_sum_of_sums_over_finite_set_with_same_family`：
(Σ_{x∈X} λ_x ·_V v_x) +_V (Σ_{x∈X} μ_x ·_V v_x) = Σ_{x∈X} (λ_x +_ℂ μ_x) ·_V v_x。 -/
theorem sumOverFiniteSet_add_of_same_family (S : ComplexVectorSpace V) {X : Type w}
    (hX : IsFiniteSet X) (v : X → V) (c d : X → ℂ) :
    S.add (sumOverFiniteSet S hX c v) (sumOverFiniteSet S hX d v)
      = sumOverFiniteSet S hX (fun x => c x + d x) v := by
  obtain ⟨n, e, he⟩ := id hX
  -- ν_{e(k)} = α_k +_ℂ β_k（α_k := λ_{e(k)}、β_k := μ_{e(k)}、b_k := v_{e(k)}）
  have hν : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      S.smul (numberedFamily e c 0 k + numberedFamily e d 0 k) (numberedFamily e v S.zero k)
        = S.smul (numberedFamily e (fun x => c x + d x) 0 k) (numberedFamily e v S.zero k) := by
    intro k hk1 hkn
    rw [numberedFamily_of_le e c 0 k hk1 hkn, numberedFamily_of_le e d 0 k hk1 hkn,
      numberedFamily_of_le e (fun x => c x + d x) 0 k hk1 hkn]
  calc S.add (sumOverFiniteSet S hX c v) (sumOverFiniteSet S hX d v)
      = S.add (linearCombination S n (numberedFamily e c 0) (numberedFamily e v S.zero))
          (linearCombination S n (numberedFamily e d 0) (numberedFamily e v S.zero)) := by
        rw [sumOverFiniteSet_eq S hX c v n e he, sumOverFiniteSet_eq S hX d v n e he]
    _ = linearCombination S n (fun k => numberedFamily e c 0 k + numberedFamily e d 0 k)
          (numberedFamily e v S.zero) :=
        linearCombination_add_of_same_family S n _ _ _
    _ = linearCombination S n (numberedFamily e (fun x => c x + d x) 0)
          (numberedFamily e v S.zero) :=
        linearCombination_eq_of_terms_eq S n _ _ _ _ hν
    _ = sumOverFiniteSet S hX (fun x => c x + d x) v :=
        (sumOverFiniteSet_eq S hX (fun x => c x + d x) v n e he).symm

/-- 本文 `claim_scalar_multiple_of_sum_over_finite_set`：
ρ ·_V (Σ_{x∈X} λ_x ·_V v_x) = Σ_{x∈X} (ρ ·_ℂ λ_x) ·_V v_x。 -/
theorem smul_sumOverFiniteSet (S : ComplexVectorSpace V) {X : Type w} (hX : IsFiniteSet X)
    (v : X → V) (c : X → ℂ) (ρ : ℂ) :
    S.smul ρ (sumOverFiniteSet S hX c v) = sumOverFiniteSet S hX (fun x => ρ * c x) v := by
  obtain ⟨n, e, he⟩ := id hX
  -- ν_{e(k)} = ρ ·_ℂ α_k
  have hν : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      S.smul (ρ * numberedFamily e c 0 k) (numberedFamily e v S.zero k)
        = S.smul (numberedFamily e (fun x => ρ * c x) 0 k) (numberedFamily e v S.zero k) := by
    intro k hk1 hkn
    rw [numberedFamily_of_le e c 0 k hk1 hkn, numberedFamily_of_le e (fun x => ρ * c x) 0 k hk1 hkn]
  calc S.smul ρ (sumOverFiniteSet S hX c v)
      = S.smul ρ (linearCombination S n (numberedFamily e c 0) (numberedFamily e v S.zero)) := by
        rw [sumOverFiniteSet_eq S hX c v n e he]
    _ = linearCombination S n (fun k => ρ * numberedFamily e c 0 k) (numberedFamily e v S.zero) :=
        smul_linearCombination S n _ _ ρ
    _ = linearCombination S n (numberedFamily e (fun x => ρ * c x) 0) (numberedFamily e v S.zero) :=
        linearCombination_eq_of_terms_eq S n _ _ _ _ hν
    _ = sumOverFiniteSet S hX (fun x => ρ * c x) v :=
        (sumOverFiniteSet_eq S hX (fun x => ρ * c x) v n e he).symm

/-- 本文 `claim_sum_of_sums_over_finite_set_with_same_coefficients`：
(Σ_{x∈X} λ_x ·_V v_x) +_V (Σ_{x∈X} λ_x ·_V w_x) = Σ_{x∈X} λ_x ·_V (v_x +_V w_x)。
本文の帰納法 L^b_m +_V L^c_m = L^d_m は `partialLinearCombination_add_of_same_coefficients`（同じ式変形の行）。 -/
theorem sumOverFiniteSet_add_of_same_coefficients (S : ComplexVectorSpace V) {X : Type w}
    (hX : IsFiniteSet X) (v w : X → V) (c : X → ℂ) :
    S.add (sumOverFiniteSet S hX c v) (sumOverFiniteSet S hX c w)
      = sumOverFiniteSet S hX c (fun x => S.add (v x) (w x)) := by
  obtain ⟨n, e, he⟩ := id hX
  -- d_k = b_k +_V c_k
  have hd : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      S.smul (numberedFamily e c 0 k)
          (S.add (numberedFamily e v S.zero k) (numberedFamily e w S.zero k))
        = S.smul (numberedFamily e c 0 k) (numberedFamily e (fun x => S.add (v x) (w x)) S.zero k) := by
    intro k hk1 hkn
    rw [numberedFamily_of_le e v S.zero k hk1 hkn, numberedFamily_of_le e w S.zero k hk1 hkn,
      numberedFamily_of_le e (fun x => S.add (v x) (w x)) S.zero k hk1 hkn]
  calc S.add (sumOverFiniteSet S hX c v) (sumOverFiniteSet S hX c w)
      = S.add (linearCombination S n (numberedFamily e c 0) (numberedFamily e v S.zero))
          (linearCombination S n (numberedFamily e c 0) (numberedFamily e w S.zero)) := by
        rw [sumOverFiniteSet_eq S hX c v n e he, sumOverFiniteSet_eq S hX c w n e he]
    _ = linearCombination S n (numberedFamily e c 0)
          (fun k => S.add (numberedFamily e v S.zero k) (numberedFamily e w S.zero k)) :=
        partialLinearCombination_add_of_same_coefficients S _ _ _ n
    _ = linearCombination S n (numberedFamily e c 0)
          (numberedFamily e (fun x => S.add (v x) (w x)) S.zero) :=
        linearCombination_eq_of_terms_eq S n _ _ _ _ hd
    _ = sumOverFiniteSet S hX c (fun x => S.add (v x) (w x)) :=
        (sumOverFiniteSet_eq S hX c (fun x => S.add (v x) (w x)) n e he).symm

/-- 本文 `claim_linear_map_maps_sum_over_finite_set_to_sum_of_values` の帰納法の主張 f(L^b_m) = L^c_m（c_k = f(b_k)）。 -/
theorem IsComplexLinearMap.map_partialLinearCombination {SV : ComplexVectorSpace V}
    {SU : ComplexVectorSpace U} {f : V → U} (hf : IsComplexLinearMap SV SU f) (a : ℕ → ℂ)
    (b : ℕ → V) (m : ℕ) :
    f (partialLinearCombination SV a b m) = partialLinearCombination SU a (fun k => f (b k)) m := by
  induction m with
  | zero => calc
      f (partialLinearCombination SV a b 0) = f SV.zero := rfl
      _ = f (SV.smul 0 SV.zero) := by rw [zero_smul_eq_zero SV SV.zero]
      _ = SU.smul 0 (f SV.zero) := hf.map_smul 0 SV.zero
      _ = SU.zero := zero_smul_eq_zero SU (f SV.zero)
      _ = partialLinearCombination SU a (fun k => f (b k)) 0 := rfl
  | succ m ih => calc
      f (partialLinearCombination SV a b (m + 1))
          = f (SV.add (partialLinearCombination SV a b m) (SV.smul (a (m + 1)) (b (m + 1)))) := rfl
      _ = SU.add (f (partialLinearCombination SV a b m)) (f (SV.smul (a (m + 1)) (b (m + 1)))) :=
          hf.map_add _ _
      _ = SU.add (partialLinearCombination SU a (fun k => f (b k)) m)
            (f (SV.smul (a (m + 1)) (b (m + 1)))) := by rw [ih]
      _ = SU.add (partialLinearCombination SU a (fun k => f (b k)) m)
            (SU.smul (a (m + 1)) (f (b (m + 1)))) := by rw [hf.map_smul (a (m + 1)) (b (m + 1))]
      _ = partialLinearCombination SU a (fun k => f (b k)) (m + 1) := rfl

/-- 本文 `claim_linear_map_maps_sum_over_finite_set_to_sum_of_values`：
f(Σ_{x∈X} λ_x ·_V v_x) = Σ_{x∈X} λ_x ·_U f(v_x)。 -/
theorem IsComplexLinearMap.map_sumOverFiniteSet {SV : ComplexVectorSpace V}
    {SU : ComplexVectorSpace U} {f : V → U} (hf : IsComplexLinearMap SV SU f) {X : Type w}
    (hX : IsFiniteSet X) (c : X → ℂ) (v : X → V) :
    f (sumOverFiniteSet SV hX c v) = sumOverFiniteSet SU hX c (fun x => f (v x)) := by
  obtain ⟨n, e, he⟩ := id hX
  -- c_k = f(b_k)（c_k := u_{e(k)}、u_x := f(v_x)）
  have hc : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      SU.smul (numberedFamily e c 0 k) (f (numberedFamily e v SV.zero k))
        = SU.smul (numberedFamily e c 0 k) (numberedFamily e (fun x => f (v x)) SU.zero k) := by
    intro k hk1 hkn
    rw [numberedFamily_of_le e v SV.zero k hk1 hkn,
      numberedFamily_of_le e (fun x => f (v x)) SU.zero k hk1 hkn]
  calc f (sumOverFiniteSet SV hX c v)
      = f (linearCombination SV n (numberedFamily e c 0) (numberedFamily e v SV.zero)) := by
        rw [sumOverFiniteSet_eq SV hX c v n e he]
    _ = linearCombination SU n (numberedFamily e c 0) (fun k => f (numberedFamily e v SV.zero k)) :=
        hf.map_partialLinearCombination _ _ n
    _ = linearCombination SU n (numberedFamily e c 0) (numberedFamily e (fun x => f (v x)) SU.zero) :=
        linearCombination_eq_of_terms_eq SU n _ _ _ _ hc
    _ = sumOverFiniteSet SU hX c (fun x => f (v x)) :=
        (sumOverFiniteSet_eq SU hX c (fun x => f (v x)) n e he).symm

/-- {1,…,n} は番号付け (n, id_n) をもつ有限集合である。 -/
theorem isNumbering_id (n : ℕ) : IsNumbering n (fun k : Idx n => k) :=
  ⟨fun _ _ h => h, fun i => ⟨i, rfl⟩⟩

theorem isFiniteSet_idx (n : ℕ) : IsFiniteSet (Idx n) := ⟨n, fun k => k, isNumbering_id n⟩

/-- 番号付け (n, id_n) で開いた {1,…,n} の上の和は、線型結合 Σ_{k=1}^{n} λ_k ·_V x_k である。 -/
theorem sumOverFiniteSet_idx (S : ComplexVectorSpace V) (n : ℕ) (c : ℕ → ℂ) (x : ℕ → V) :
    sumOverFiniteSet S (isFiniteSet_idx n) (fun k => c k.1) (fun k => x k.1)
      = linearCombination S n c x := by
  rw [sumOverFiniteSet_eq S (isFiniteSet_idx n) _ _ n (fun k => k) (isNumbering_id n)]
  apply linearCombination_eq_of_terms_eq
  intro k hk1 hkn
  rw [numberedFamily_of_le (fun k : Idx n => k) (fun k => c k.1) 0 k hk1 hkn,
    numberedFamily_of_le (fun k : Idx n => k) (fun k => x k.1) S.zero k hk1 hkn]

/-- 本文 `claim_linear_map_maps_linear_combination_to_linear_combination_of_values`：
f(Σ_{k=1}^{n} λ_k ·_V x_k) = Σ_{k=1}^{n} λ_k ·_U f(x_k)。番号付け (n, id_n) の和を通す。 -/
theorem IsComplexLinearMap.map_linearCombination {SV : ComplexVectorSpace V}
    {SU : ComplexVectorSpace U} {f : V → U} (hf : IsComplexLinearMap SV SU f) (n : ℕ) (c : ℕ → ℂ)
    (x : ℕ → V) :
    f (linearCombination SV n c x) = linearCombination SU n c (fun k => f (x k)) := calc
  f (linearCombination SV n c x)
      = f (sumOverFiniteSet SV (isFiniteSet_idx n) (fun k => c k.1) (fun k => x k.1)) := by
        rw [sumOverFiniteSet_idx SV n c x]
  _ = sumOverFiniteSet SU (isFiniteSet_idx n) (fun k => c k.1) (fun k => f (x k.1)) :=
        hf.map_sumOverFiniteSet (isFiniteSet_idx n) _ _
  _ = linearCombination SU n c (fun k => f (x k)) :=
        sumOverFiniteSet_idx SU n c (fun k => f (x k))

/-- 本文 `claim_sum_over_finite_set_with_kronecker_delta_picks_term`：Σ_{y∈X} δ_{x,y} ·_V v_y = v_x。 -/
theorem sumOverFiniteSet_kroneckerDelta (S : ComplexVectorSpace V) {X : Type w} [DecidableEq X]
    (hX : IsFiniteSet X) (v : X → V) (x : X) :
    sumOverFiniteSet S hX (fun y => kroneckerDelta x y) v = v x := by
  obtain ⟨n, e, he⟩ := id hX
  -- j := e^{-1}(x)、e(j) = x
  set j : ℕ := (he.inv x).1 with hj
  have hj1 : 1 ≤ j := (he.inv x).2.1
  have hjn : j ≤ n := (he.inv x).2.2
  -- δ_{x,e(k)} = δ_{k,j}
  have hδ : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      S.smul (numberedFamily e (fun y => kroneckerDelta x y) 0 k) (numberedFamily e v S.zero k)
        = S.smul (kroneckerDelta k j) (numberedFamily e v S.zero k) := by
    intro k hk1 hkn
    rw [numberedFamily_of_le e (fun y => kroneckerDelta x y) 0 k hk1 hkn]
    by_cases hkj : k = j
    · -- k = j のとき：e(k) = e(j) = x
      have hek : e ⟨k, hk1, hkn⟩ = x := by
        have : (⟨k, hk1, hkn⟩ : Idx n) = he.inv x := Subtype.ext hkj
        rw [this, he.apply_inv x]
      rw [kroneckerDelta, kroneckerDelta, if_pos hek.symm, if_pos hkj]
    · -- k ≠ j のとき：e(k) = x なら k = e^{-1}(e(k)) = e^{-1}(x) = j
      have hek : x ≠ e ⟨k, hk1, hkn⟩ := by
        intro h
        apply hkj
        have := he.inv_apply ⟨k, hk1, hkn⟩
        rw [← h] at this
        exact (congrArg Subtype.val this).symm
      rw [kroneckerDelta, kroneckerDelta, if_neg hek, if_neg hkj]
  calc sumOverFiniteSet S hX (fun y => kroneckerDelta x y) v
      = linearCombination S n (numberedFamily e (fun y => kroneckerDelta x y) 0)
          (numberedFamily e v S.zero) := sumOverFiniteSet_eq S hX _ v n e he
    _ = linearCombination S n (fun k => kroneckerDelta k j) (numberedFamily e v S.zero) :=
        linearCombination_eq_of_terms_eq S n _ _ _ _ hδ
    _ = numberedFamily e v S.zero j := linearCombination_kroneckerDelta S n _ j hj1 hjn
    _ = v (e (he.inv x)) := numberedFamily_of_le e v S.zero j hj1 hjn
    _ = v x := by rw [he.apply_inv x]

/-- 本文 `claim_sum_over_finite_set_depends_only_on_terms`：すべての x で λ_x ·_V v_x = μ_x ·_V u_x なら
Σ_{x∈X} λ_x ·_V v_x = Σ_{x∈X} μ_x ·_V u_x。本文の帰納法 L^b_m = L^c_m は
`partialLinearCombination_eq_of_terms_eq`（同じ式変形の行）。 -/
theorem sumOverFiniteSet_congr (S : ComplexVectorSpace V) {X : Type w} (hX : IsFiniteSet X)
    (c d : X → ℂ) (v u : X → V) (h : ∀ x : X, S.smul (c x) (v x) = S.smul (d x) (u x)) :
    sumOverFiniteSet S hX c v = sumOverFiniteSet S hX d u := by
  obtain ⟨n, e, he⟩ := id hX
  -- α_k ·_V b_k = β_k ·_V c_k（仮定を x = e(k) に当てる）
  have hab : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      S.smul (numberedFamily e c 0 k) (numberedFamily e v S.zero k)
        = S.smul (numberedFamily e d 0 k) (numberedFamily e u S.zero k) := by
    intro k hk1 hkn
    rw [numberedFamily_of_le e c 0 k hk1 hkn, numberedFamily_of_le e v S.zero k hk1 hkn,
      numberedFamily_of_le e d 0 k hk1 hkn, numberedFamily_of_le e u S.zero k hk1 hkn]
    exact h (e ⟨k, hk1, hkn⟩)
  calc sumOverFiniteSet S hX c v
      = linearCombination S n (numberedFamily e c 0) (numberedFamily e v S.zero) :=
        sumOverFiniteSet_eq S hX c v n e he
    _ = linearCombination S n (numberedFamily e d 0) (numberedFamily e u S.zero) :=
        linearCombination_eq_of_terms_eq S n _ _ _ _ hab
    _ = sumOverFiniteSet S hX d u := (sumOverFiniteSet_eq S hX d u n e he).symm

/-- 本文 `claim_double_sums_over_finite_sets_with_equal_terms_are_equal`：
Σ_{x∈X} 1_ℂ ·_V (Σ_{y∈Y} λ_{x,y} ·_V v_{x,y}) = Σ_{x∈X} 1_ℂ ·_V (Σ_{y∈Y} μ_{x,y} ·_V u_{x,y})。 -/
theorem sumOverFiniteSet_double_congr (S : ComplexVectorSpace V) {X : Type w} {Y : Type w'}
    (hX : IsFiniteSet X) (hY : IsFiniteSet Y) (c d : X → Y → ℂ) (v u : X → Y → V)
    (h : ∀ (x : X) (y : Y), S.smul (c x y) (v x y) = S.smul (d x y) (u x y)) :
    sumOverFiniteSet S hX (fun _ => 1) (fun x => sumOverFiniteSet S hY (c x) (v x))
      = sumOverFiniteSet S hX (fun _ => 1) (fun x => sumOverFiniteSet S hY (d x) (u x)) := by
  -- 準備：各 x で内側の和が等しい
  have hinner : ∀ x : X, sumOverFiniteSet S hY (c x) (v x) = sumOverFiniteSet S hY (d x) (u x) :=
    fun x => sumOverFiniteSet_congr S hY (c x) (d x) (v x) (u x) (h x)
  calc sumOverFiniteSet S hX (fun _ => 1) (fun x => sumOverFiniteSet S hY (c x) (v x))
      = sumOverFiniteSet S hX (fun _ => 1) (fun x => sumOverFiniteSet S hY (d x) (u x)) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun x => by rw [hinner x])

/-- 本文 `claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values`：
f(Σ_{x∈X} 1_ℂ ·_V (Σ_{y∈Y} λ_{x,y} ·_V v_{x,y})) = Σ_{x∈X} 1_ℂ ·_U (Σ_{y∈Y} λ_{x,y} ·_U f(v_{x,y}))。 -/
theorem IsComplexLinearMap.map_double_sumOverFiniteSet {SV : ComplexVectorSpace V}
    {SU : ComplexVectorSpace U} {f : V → U} (hf : IsComplexLinearMap SV SU f) {X : Type w}
    {Y : Type w'} (hX : IsFiniteSet X) (hY : IsFiniteSet Y) (c : X → Y → ℂ) (v : X → Y → V) :
    f (sumOverFiniteSet SV hX (fun _ => 1) (fun x => sumOverFiniteSet SV hY (c x) (v x)))
      = sumOverFiniteSet SU hX (fun _ => 1)
          (fun x => sumOverFiniteSet SU hY (c x) (fun y => f (v x y))) := by
  -- 準備：f(s_x) = Σ_{y∈Y} λ_{x,y} ·_U f(v_{x,y})（s_x := Σ_{y∈Y} λ_{x,y} ·_V v_{x,y}）
  have hs : ∀ x : X, f (sumOverFiniteSet SV hY (c x) (v x))
      = sumOverFiniteSet SU hY (c x) (fun y => f (v x y)) :=
    fun x => hf.map_sumOverFiniteSet hY (c x) (v x)
  calc f (sumOverFiniteSet SV hX (fun _ => 1) (fun x => sumOverFiniteSet SV hY (c x) (v x)))
      = sumOverFiniteSet SU hX (fun _ => 1) (fun x => f (sumOverFiniteSet SV hY (c x) (v x))) :=
        hf.map_sumOverFiniteSet hX _ _
    _ = sumOverFiniteSet SU hX (fun _ => 1)
          (fun x => sumOverFiniteSet SU hY (c x) (fun y => f (v x y))) :=
        sumOverFiniteSet_congr SU hX _ _ _ _ (fun x => by rw [hs x])

end CliffordMatrixIsomorphism.ComplexVectorSpace
