/-
節「テンソル代数」のうち、代数の中の積についての補題の必要十分版。具体版
`MathematicalToolkit/TensorAlgebra/MultiplicationInAlgebra.lean` と同じ帰納法と calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                              このファイル                          K に要るもの
  claim_subalgebra_is_closed_under_sums_over_finite_sets                    IsSubalgebra.sumOverFiniteSet_mem     0 + 0 = 0
  claim_left_multiplication_in_algebra_is_linear_map                        leftMul_isLinearMap                   なし
  claim_right_multiplication_in_algebra_is_linear_map                       rightMul_isLinearMap                  なし
  claim_zero_times_element_in_algebra_is_zero                               zero_mul_eq_zero                      0 + 0 = 0
  claim_element_times_zero_in_algebra_is_zero                               mul_zero_eq_zero                      0 + 0 = 0
  claim_anticommutator_with_linear_combination_in_algebra                   anticommutator_linearCombination      0 + 0 = 0
  claim_square_of_linear_combination_of_anticommuting_square_zero_elements_is_zero
                                                                            square_linearCombination_eq_zero      0 + 0 = 0、a · 0 = 0
  claim_ordered_products_with_equal_factors_are_equal                       orderedProduct_congr                  なし
  claim_ordered_product_in_algebra_is_additive_in_one_factor                orderedProduct_add_in_one_factor      なし
  claim_ordered_product_in_algebra_is_homogeneous_in_one_factor             orderedProduct_smul_in_one_factor     なし
  claim_ordered_product_in_algebra_splits_into_first_and_last_factors       orderedProduct_split                  なし
  claim_ordered_product_in_algebra_with_one_factor_singled_out              orderedProduct_singleOut              なし
  claim_element_commuting_with_each_factor_commutes_with_ordered_product    commute_orderedProduct                なし
  claim_anticommuting_elements_swap_with_sign                               mul_eq_neg_one_smul_swap              1 + n = 0 となる n、0 + 0 = 0

分かったこと:
- 左右から掛ける写像が線型写像であることと、番号順の積の六つの主張は、係数の性質を一つも使わない
  （代数の公理のうち、分配法則・結合法則・単位元と、スカラー倍と乗法の両立だけを使う）。
- 零との積が零であることと、線型結合との反交換子は、線型写像が零を零へ移すこと（または線型結合を移すこと）を通して
  0 + 0 = 0 だけを使う。部分代数が有限集合の上の和で閉じていることも、L_0 = 0_ℂ ∗_A 1_A の行で 0 + 0 = 0 だけを使う。
- 平方が零の元の線型結合の平方が零であることは、λ ∗_A 0_A = 0_A の行で a · 0 = 0 を足して使う。
- 反交換する二元の入れ替えは、本文の -1_ℂ を「1 + n = 0 を満たす K の元 n」に替えて示せる。乗法の性質は要らない。

本文の `def_underlying_ring_and_vector_space_of_algebra` の U_vec(A) は `SA.toVectorSpace` である。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexAlgebra.Definitions
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

open VectorSpace

universe u w uK

variable {K : Type uK} [Add K] [Mul K] [One K] {A : Type u}

/-- 本文 `claim_subalgebra_is_closed_under_sums_over_finite_sets`：部分代数 B の元の族 v について、
U_vec(A) の中の有限集合の上の和 Σ_{x∈X} λ_x ∗_A v_x は B の元である。番号付け (n, e) で和を L_n に開き、
L_m ∈ B（m ≤ n）を m の帰納法で示す。 -/
theorem IsSubalgebra.sumOverFiniteSet_mem [Zero K] (h00 : (0 : K) + 0 = 0) {SA : AlgebraOver K A}
    {B : Set A} (hB : IsSubalgebra SA B) {X : Type w} (hX : IsFiniteSet X) (c : X → K) (v : X → A)
    (hv : ∀ x : X, v x ∈ B) : sumOverFiniteSet SA.toVectorSpace hX c v ∈ B := by
  obtain ⟨n, e, he⟩ := id hX
  have hL : ∀ m : ℕ, m ≤ n →
      partialLinearCombination SA.toVectorSpace (numberedFamily e c 0)
        (numberedFamily e v SA.zero) m ∈ B := by
    intro m
    induction m with
    | zero =>
      intro _
      -- L_0 = 0_A = 0_ℂ ∗_A 1_A
      have h0 : SA.zero = SA.smul 0 SA.one :=
        (zero_smul_eq_zero SA.toVectorSpace h00 SA.one).symm
      show SA.zero ∈ B
      rw [h0]
      exact hB.smul_mem 0 SA.one hB.one_mem
    | succ m ih =>
      intro hm
      -- L_m = L_{m-1} +_A (μ_m ∗_A y_m)
      show SA.add (partialLinearCombination SA.toVectorSpace (numberedFamily e c 0)
          (numberedFamily e v SA.zero) m)
        (SA.smul (numberedFamily e c 0 (m + 1)) (numberedFamily e v SA.zero (m + 1))) ∈ B
      apply hB.add_mem _ _ (ih (Nat.le_of_succ_le hm))
      apply hB.smul_mem
      rw [numberedFamily_of_le e v SA.zero (m + 1) (Nat.succ_pos m) hm]
      exact hv _
  rw [sumOverFiniteSet_eq SA.toVectorSpace hX c v n e he]
  exact hL n le_rfl

/-- 本文 `claim_left_multiplication_in_algebra_is_linear_map`：a ·_A • は U_vec(A) から U_vec(A) への線型写像。
加法は U_ring(A) の分配法則、スカラー倍は両立の右の因子の条件。 -/
theorem leftMul_isLinearMap (SA : AlgebraOver K A) (a : A) :
    IsLinearMap SA.toVectorSpace SA.toVectorSpace (fun x => SA.mul a x) where
  map_add x y := SA.left_distrib a x y
  map_smul l x := (SA.smul_mul_right l a x).symm

/-- 本文 `claim_right_multiplication_in_algebra_is_linear_map`：• ·_A a は U_vec(A) から U_vec(A) への線型写像。
加法は U_ring(A) の分配法則、スカラー倍は両立の左の因子の条件。 -/
theorem rightMul_isLinearMap (SA : AlgebraOver K A) (a : A) :
    IsLinearMap SA.toVectorSpace SA.toVectorSpace (fun x => SA.mul x a) where
  map_add x y := SA.right_distrib x y a
  map_smul l x := (SA.smul_mul_left l x a).symm

/-- 本文 `claim_zero_times_element_in_algebra_is_zero`：0_A ·_A w = 0_A。 -/
theorem zero_mul_eq_zero [Zero K] (h00 : (0 : K) + 0 = 0) (SA : AlgebraOver K A) (w : A) : SA.mul SA.zero w = SA.zero := calc
  SA.mul SA.zero w = (fun x => SA.mul x w) SA.zero := rfl
  _ = SA.zero := (rightMul_isLinearMap SA w).map_zero h00

/-- 本文 `claim_element_times_zero_in_algebra_is_zero`：w ·_A 0_A = 0_A。 -/
theorem mul_zero_eq_zero [Zero K] (h00 : (0 : K) + 0 = 0) (SA : AlgebraOver K A) (w : A) : SA.mul w SA.zero = SA.zero := calc
  SA.mul w SA.zero = (fun x => SA.mul w x) SA.zero := rfl
  _ = SA.zero := (leftMul_isLinearMap SA w).map_zero h00

/-- 本文 `claim_anticommutator_with_linear_combination_in_algebra`：R := Σ_{l=1}^{n} μ_l ∗_A r_l について
R ·_A a +_A a ·_A R = Σ_{l=1}^{n} μ_l ∗_A (r_l ·_A a +_A a ·_A r_l)。 -/
theorem anticommutator_linearCombination [Zero K] (h00 : (0 : K) + 0 = 0) (SA : AlgebraOver K A) (a : A) (n : ℕ) (μ : ℕ → K)
    (r : ℕ → A) :
    SA.add (SA.mul (linearCombination SA.toVectorSpace n μ r) a)
        (SA.mul a (linearCombination SA.toVectorSpace n μ r))
      = linearCombination SA.toVectorSpace n μ
          (fun l => SA.add (SA.mul (r l) a) (SA.mul a (r l))) := calc
  SA.add (SA.mul (linearCombination SA.toVectorSpace n μ r) a)
        (SA.mul a (linearCombination SA.toVectorSpace n μ r))
      = SA.add (linearCombination SA.toVectorSpace n μ (fun l => SA.mul (r l) a))
          (SA.mul a (linearCombination SA.toVectorSpace n μ r)) :=
        congrArg (fun t => SA.add t (SA.mul a (linearCombination SA.toVectorSpace n μ r)))
          ((rightMul_isLinearMap SA a).map_linearCombination h00 n μ r)
  _ = SA.add (linearCombination SA.toVectorSpace n μ (fun l => SA.mul (r l) a))
          (linearCombination SA.toVectorSpace n μ (fun l => SA.mul a (r l))) :=
        congrArg (SA.add _) ((leftMul_isLinearMap SA a).map_linearCombination h00 n μ r)
  _ = linearCombination SA.toVectorSpace n μ
          (fun l => SA.add (SA.mul (r l) a) (SA.mul a (r l))) :=
        linearCombination_add_of_same_coefficients SA.toVectorSpace n _ _ μ

/-- 本文 `claim_square_of_linear_combination_of_anticommuting_square_zero_elements_is_zero`：
p_k ·_A p_k = 0_A と p_k ·_A p_l +_A p_l ·_A p_k = 0_A（k ≠ l）なら、
(Σ_{k=1}^{n} λ_k ∗_A p_k) ·_A (Σ_{k=1}^{n} λ_k ∗_A p_k) = 0_A。
部分和 L_m は、族を {1,…,m} に制限した線型結合と同じ式（Lean では定義で一致する）なので、
L_m ·_A L_m = 0_A（m ≤ n）を m の帰納法で示す。 -/
theorem square_linearCombination_eq_zero [Zero K] (h00 : (0 : K) + 0 = 0)
    (hmul0 : ∀ a : K, a * 0 = 0) (SA : AlgebraOver K A) (n : ℕ) (c : ℕ → K) (p : ℕ → A)
    (hsq : ∀ k : ℕ, 1 ≤ k → k ≤ n → SA.mul (p k) (p k) = SA.zero)
    (hanti : ∀ k l : ℕ, 1 ≤ k → k ≤ n → 1 ≤ l → l ≤ n → k ≠ l →
      SA.add (SA.mul (p k) (p l)) (SA.mul (p l) (p k)) = SA.zero) :
    SA.mul (linearCombination SA.toVectorSpace n c p)
        (linearCombination SA.toVectorSpace n c p) = SA.zero := by
  have hm : ∀ m : ℕ, m ≤ n →
      SA.mul (partialLinearCombination SA.toVectorSpace c p m)
        (partialLinearCombination SA.toVectorSpace c p m) = SA.zero := by
    intro m
    induction m with
    | zero =>
      intro _
      calc SA.mul (partialLinearCombination SA.toVectorSpace c p 0)
            (partialLinearCombination SA.toVectorSpace c p 0) = SA.mul SA.zero SA.zero := rfl
        _ = SA.zero := mul_zero_eq_zero h00 SA SA.zero
    | succ m ih =>
      intro hmn
      -- 準備：e := λ_m ∗_A p_m、L := L_{m-1}
      set L := partialLinearCombination SA.toVectorSpace c p m with hL
      set e := SA.smul (c (m + 1)) (p (m + 1)) with he
      -- 各項 λ_k ∗_A (p_k ·_A e +_A e ·_A p_k) = 0_A（k ∈ {1,…,m-1}）
      have hterm : ∀ k : ℕ, 1 ≤ k → k ≤ m →
          SA.toVectorSpace.smul (c k)
              (SA.add (SA.mul (p k) e) (SA.mul e (p k))) = SA.toVectorSpace.zero := by
        intro k hk1 hkm
        calc SA.toVectorSpace.smul (c k) (SA.add (SA.mul (p k) e) (SA.mul e (p k)))
            = SA.smul (c k) (SA.add (SA.mul (p k) (SA.smul (c (m + 1)) (p (m + 1))))
                (SA.mul (SA.smul (c (m + 1)) (p (m + 1))) (p k))) := rfl
          _ = SA.smul (c k) (SA.add (SA.smul (c (m + 1)) (SA.mul (p k) (p (m + 1))))
                (SA.mul (SA.smul (c (m + 1)) (p (m + 1))) (p k))) := by
              rw [← SA.smul_mul_right (c (m + 1)) (p k) (p (m + 1))]
          _ = SA.smul (c k) (SA.add (SA.smul (c (m + 1)) (SA.mul (p k) (p (m + 1))))
                (SA.smul (c (m + 1)) (SA.mul (p (m + 1)) (p k)))) := by
              rw [← SA.smul_mul_left (c (m + 1)) (p (m + 1)) (p k)]
          _ = SA.smul (c k) (SA.smul (c (m + 1))
                (SA.add (SA.mul (p k) (p (m + 1))) (SA.mul (p (m + 1)) (p k)))) := by
              rw [SA.smul_add (c (m + 1)) (SA.mul (p k) (p (m + 1))) (SA.mul (p (m + 1)) (p k))]
          _ = SA.smul (c k) (SA.smul (c (m + 1)) SA.zero) := by
              rw [hanti k (m + 1) hk1 (by omega) (Nat.succ_pos m) hmn (by omega)]
          _ = SA.smul (c k) SA.zero :=
              congrArg (SA.smul (c k)) (smul_zero_eq_zero SA.toVectorSpace h00 hmul0 (c (m + 1)))
          _ = SA.zero := smul_zero_eq_zero SA.toVectorSpace h00 hmul0 (c k)
      -- （⋆）L_{m-1} ·_A e +_A e ·_A L_{m-1} = 0_A
      have hstar : SA.add (SA.mul L e) (SA.mul e L) = SA.zero := calc
        SA.add (SA.mul L e) (SA.mul e L)
            = linearCombination SA.toVectorSpace m c
                (fun k => SA.add (SA.mul (p k) e) (SA.mul e (p k))) :=
              anticommutator_linearCombination h00 SA e m c p
        _ = SA.zero := linearCombination_eq_zero_of_terms_eq_zero SA.toVectorSpace m _ c hterm
      calc SA.mul (partialLinearCombination SA.toVectorSpace c p (m + 1))
            (partialLinearCombination SA.toVectorSpace c p (m + 1))
          = SA.mul (SA.add L e) (SA.add L e) := rfl
        _ = SA.add (SA.mul L (SA.add L e)) (SA.mul e (SA.add L e)) :=
            SA.right_distrib L e (SA.add L e)
        _ = SA.add (SA.add (SA.mul L L) (SA.mul L e)) (SA.add (SA.mul e L) (SA.mul e e)) := by
            rw [SA.left_distrib L L e, SA.left_distrib e L e]
        _ = SA.add (SA.add SA.zero (SA.mul L e)) (SA.add (SA.mul e L) (SA.mul e e)) := by
            rw [ih (Nat.le_of_succ_le hmn)]
        _ = SA.add (SA.add (SA.mul L e) SA.zero) (SA.add (SA.mul e L) (SA.mul e e)) := by
            rw [SA.add_comm SA.zero (SA.mul L e)]
        _ = SA.add (SA.mul L e) (SA.add (SA.mul e L) (SA.mul e e)) := by
            rw [SA.add_zero (SA.mul L e)]
        _ = SA.add (SA.add (SA.mul L e) (SA.mul e L)) (SA.mul e e) := by
            rw [SA.add_assoc (SA.mul L e) (SA.mul e L) (SA.mul e e)]
        _ = SA.add SA.zero (SA.mul e e) := by rw [hstar]
        _ = SA.add (SA.mul e e) SA.zero := SA.add_comm SA.zero (SA.mul e e)
        _ = SA.mul e e := SA.add_zero (SA.mul e e)
        _ = SA.mul (SA.smul (c (m + 1)) (p (m + 1))) (SA.smul (c (m + 1)) (p (m + 1))) := rfl
        _ = SA.smul (c (m + 1)) (SA.mul (p (m + 1)) (SA.smul (c (m + 1)) (p (m + 1)))) :=
            (SA.smul_mul_left (c (m + 1)) (p (m + 1)) (SA.smul (c (m + 1)) (p (m + 1)))).symm
        _ = SA.smul (c (m + 1)) (SA.smul (c (m + 1)) (SA.mul (p (m + 1)) (p (m + 1)))) := by
            rw [← SA.smul_mul_right (c (m + 1)) (p (m + 1)) (p (m + 1))]
        _ = SA.smul (c (m + 1)) (SA.smul (c (m + 1)) SA.zero) := by
            rw [hsq (m + 1) (Nat.succ_pos m) hmn]
        _ = SA.smul (c (m + 1)) SA.zero :=
            congrArg (SA.smul (c (m + 1))) (smul_zero_eq_zero SA.toVectorSpace h00 hmul0 (c (m + 1)))
        _ = SA.zero := smul_zero_eq_zero SA.toVectorSpace h00 hmul0 (c (m + 1))
  exact hm n le_rfl

/-- 本文 `claim_ordered_products_with_equal_factors_are_equal`：すべての k ∈ {1,…,n} で x_k = y_k なら
∏_{A,k=1}^{n} x_k = ∏_{A,k=1}^{n} y_k。Π^x_m = Π^y_m（m ≤ n）を m の帰納法で示す。 -/
theorem orderedProduct_congr (SA : AlgebraOver K A) (n : ℕ) (x y : ℕ → A)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → x k = y k) : orderedProduct SA n x = orderedProduct SA n y := by
  have hm : ∀ m : ℕ, m ≤ n → partialOrderedProduct SA x m = partialOrderedProduct SA y m := by
    intro m
    induction m with
    | zero => intro _; calc
        partialOrderedProduct SA x 0 = SA.one := rfl
        _ = partialOrderedProduct SA y 0 := rfl
    | succ m ih =>
      intro hmn
      calc partialOrderedProduct SA x (m + 1)
          = SA.mul (partialOrderedProduct SA x m) (x (m + 1)) := rfl
        _ = SA.mul (partialOrderedProduct SA y m) (x (m + 1)) := by
            rw [ih (Nat.le_of_succ_le hmn)]
        _ = SA.mul (partialOrderedProduct SA y m) (y (m + 1)) := by
            rw [h (m + 1) (Nat.succ_pos m) hmn]
        _ = partialOrderedProduct SA y (m + 1) := rfl
  exact hm n le_rfl

/-- 本文 `claim_ordered_product_in_algebra_is_additive_in_one_factor`：r ∈ {1,…,k} とし、s ∈ {1,…,k}、s ≠ r なら
w_s = w'_s = w''_s、w_r = w'_r +_A w''_r のとき、∏ w_s = ∏ w'_s +_A ∏ w''_s。
仮定は 1,…,k の番号にだけ置く。m < r なら Π_m = Π'_m = Π''_m、m ≥ r なら Π_m = Π'_m +_A Π''_m を
m ≤ k の帰納法で示す。 -/
theorem orderedProduct_add_in_one_factor (SA : AlgebraOver K A) (k r : ℕ) (hr1 : 1 ≤ r)
    (hrk : r ≤ k) (w w' w'' : ℕ → A)
    (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → w s = w' s ∧ w s = w'' s)
    (hr : w r = SA.add (w' r) (w'' r)) :
    orderedProduct SA k w = SA.add (orderedProduct SA k w') (orderedProduct SA k w'') := by
  have hm : ∀ m : ℕ, m ≤ k →
      (m < r → partialOrderedProduct SA w m = partialOrderedProduct SA w' m ∧
          partialOrderedProduct SA w m = partialOrderedProduct SA w'' m) ∧
        (r ≤ m → partialOrderedProduct SA w m
          = SA.add (partialOrderedProduct SA w' m) (partialOrderedProduct SA w'' m)) := by
    intro m
    induction m with
    | zero =>
      intro _
      -- 0 < r であり、Π_0 = 1_A = Π'_0 = Π''_0
      exact ⟨fun _ => ⟨rfl, rfl⟩, fun h => absurd h (by omega)⟩
    | succ m ih =>
      intro hmk
      have ih' := ih (Nat.le_of_succ_le hmk)
      by_cases hlt : m + 1 < r
      · -- m < r のとき
        have h1 := (ih'.1 (by omega)).1
        have h2 := (ih'.1 (by omega)).2
        have hw := hne (m + 1) (Nat.succ_pos m) hmk (by omega)
        refine ⟨fun _ => ⟨?_, ?_⟩, fun h => absurd h (by omega)⟩
        · calc partialOrderedProduct SA w (m + 1)
              = SA.mul (partialOrderedProduct SA w m) (w (m + 1)) := rfl
            _ = SA.mul (partialOrderedProduct SA w' m) (w (m + 1)) := by rw [h1]
            _ = SA.mul (partialOrderedProduct SA w' m) (w' (m + 1)) := by rw [hw.1]
            _ = partialOrderedProduct SA w' (m + 1) := rfl
        · calc partialOrderedProduct SA w (m + 1)
              = SA.mul (partialOrderedProduct SA w m) (w (m + 1)) := rfl
            _ = SA.mul (partialOrderedProduct SA w'' m) (w (m + 1)) := by rw [h2]
            _ = SA.mul (partialOrderedProduct SA w'' m) (w'' (m + 1)) := by rw [hw.2]
            _ = partialOrderedProduct SA w'' (m + 1) := rfl
      · by_cases heq : m + 1 = r
        · -- m = r のとき：r - 1 < r なので Π_{r-1} = Π'_{r-1} = Π''_{r-1}
          have h1 := (ih'.1 (by omega)).1
          have h2 := (ih'.1 (by omega)).2
          have hwr : w (m + 1) = SA.add (w' (m + 1)) (w'' (m + 1)) := by rw [heq]; exact hr
          refine ⟨fun h => absurd h (by omega), fun _ => ?_⟩
          calc partialOrderedProduct SA w (m + 1)
              = SA.mul (partialOrderedProduct SA w m) (w (m + 1)) := rfl
            _ = SA.mul (partialOrderedProduct SA w m) (SA.add (w' (m + 1)) (w'' (m + 1))) := by
                rw [hwr]
            _ = SA.add (SA.mul (partialOrderedProduct SA w m) (w' (m + 1)))
                  (SA.mul (partialOrderedProduct SA w m) (w'' (m + 1))) :=
                SA.left_distrib _ _ _
            _ = SA.add (SA.mul (partialOrderedProduct SA w' m) (w' (m + 1)))
                  (SA.mul (partialOrderedProduct SA w'' m) (w'' (m + 1))) :=
                congrArg₂ (fun a b => SA.add (SA.mul a (w' (m + 1))) (SA.mul b (w'' (m + 1)))) h1 h2
            _ = SA.add (partialOrderedProduct SA w' (m + 1)) (partialOrderedProduct SA w'' (m + 1)) :=
                rfl
        · -- m > r のとき：m - 1 ≥ r かつ m ≠ r
          have h := ih'.2 (by omega)
          have hw := hne (m + 1) (Nat.succ_pos m) hmk heq
          refine ⟨fun h => absurd h (by omega), fun _ => ?_⟩
          calc partialOrderedProduct SA w (m + 1)
              = SA.mul (partialOrderedProduct SA w m) (w (m + 1)) := rfl
            _ = SA.mul (SA.add (partialOrderedProduct SA w' m) (partialOrderedProduct SA w'' m))
                  (w (m + 1)) := by rw [h]
            _ = SA.add (SA.mul (partialOrderedProduct SA w' m) (w (m + 1)))
                  (SA.mul (partialOrderedProduct SA w'' m) (w (m + 1))) :=
                SA.right_distrib _ _ _
            _ = SA.add (SA.mul (partialOrderedProduct SA w' m) (w' (m + 1)))
                  (SA.mul (partialOrderedProduct SA w'' m) (w'' (m + 1))) :=
                congrArg₂ (fun a b => SA.add (SA.mul (partialOrderedProduct SA w' m) a)
                  (SA.mul (partialOrderedProduct SA w'' m) b)) hw.1 hw.2
            _ = SA.add (partialOrderedProduct SA w' (m + 1)) (partialOrderedProduct SA w'' (m + 1)) :=
                rfl
  exact (hm k le_rfl).2 hrk

/-- 本文 `claim_ordered_product_in_algebra_is_homogeneous_in_one_factor`：r ∈ {1,…,k} とし、s ∈ {1,…,k}、
s ≠ r なら w_s = w'_s、w_r = λ ∗_A w'_r のとき、∏ w_s = λ ∗_A ∏ w'_s。仮定は 1,…,k の番号にだけ置く。
m < r なら Π_m = Π'_m、m ≥ r なら Π_m = λ ∗_A Π'_m を m ≤ k の帰納法で示す。 -/
theorem orderedProduct_smul_in_one_factor (SA : AlgebraOver K A) (k r : ℕ) (hr1 : 1 ≤ r)
    (hrk : r ≤ k) (l : K) (w w' : ℕ → A)
    (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → w s = w' s) (hr : w r = SA.smul l (w' r)) :
    orderedProduct SA k w = SA.smul l (orderedProduct SA k w') := by
  have hm : ∀ m : ℕ, m ≤ k →
      (m < r → partialOrderedProduct SA w m = partialOrderedProduct SA w' m) ∧
        (r ≤ m → partialOrderedProduct SA w m = SA.smul l (partialOrderedProduct SA w' m)) := by
    intro m
    induction m with
    | zero =>
      intro _
      exact ⟨fun _ => rfl, fun h => absurd h (by omega)⟩
    | succ m ih =>
      intro hmk
      have ih' := ih (Nat.le_of_succ_le hmk)
      by_cases hlt : m + 1 < r
      · -- m < r のとき
        have h1 := ih'.1 (by omega)
        have hw := hne (m + 1) (Nat.succ_pos m) hmk (by omega)
        refine ⟨fun _ => ?_, fun h => absurd h (by omega)⟩
        calc partialOrderedProduct SA w (m + 1)
            = SA.mul (partialOrderedProduct SA w m) (w (m + 1)) := rfl
          _ = SA.mul (partialOrderedProduct SA w' m) (w (m + 1)) := by rw [h1]
          _ = SA.mul (partialOrderedProduct SA w' m) (w' (m + 1)) := by rw [hw]
          _ = partialOrderedProduct SA w' (m + 1) := rfl
      · by_cases heq : m + 1 = r
        · -- m = r のとき
          have h1 := ih'.1 (by omega)
          have hwr : w (m + 1) = SA.smul l (w' (m + 1)) := by rw [heq]; exact hr
          refine ⟨fun h => absurd h (by omega), fun _ => ?_⟩
          calc partialOrderedProduct SA w (m + 1)
              = SA.mul (partialOrderedProduct SA w m) (w (m + 1)) := rfl
            _ = SA.mul (partialOrderedProduct SA w m) (SA.smul l (w' (m + 1))) := by rw [hwr]
            _ = SA.smul l (SA.mul (partialOrderedProduct SA w m) (w' (m + 1))) :=
                (SA.smul_mul_right l _ _).symm
            _ = SA.smul l (SA.mul (partialOrderedProduct SA w' m) (w' (m + 1))) := by rw [h1]
            _ = SA.smul l (partialOrderedProduct SA w' (m + 1)) := rfl
        · -- m > r のとき
          have h := ih'.2 (by omega)
          have hw := hne (m + 1) (Nat.succ_pos m) hmk heq
          refine ⟨fun h => absurd h (by omega), fun _ => ?_⟩
          calc partialOrderedProduct SA w (m + 1)
              = SA.mul (partialOrderedProduct SA w m) (w (m + 1)) := rfl
            _ = SA.mul (SA.smul l (partialOrderedProduct SA w' m)) (w (m + 1)) := by rw [h]
            _ = SA.mul (SA.smul l (partialOrderedProduct SA w' m)) (w' (m + 1)) := by rw [hw]
            _ = SA.smul l (SA.mul (partialOrderedProduct SA w' m) (w' (m + 1))) :=
                (SA.smul_mul_left l _ _).symm
            _ = SA.smul l (partialOrderedProduct SA w' (m + 1)) := rfl
  exact (hm k le_rfl).2 hrk

/-- 本文 `claim_ordered_product_in_algebra_splits_into_first_and_last_factors`：
∏_{A,s=1}^{k+l} w_s = (∏_{A,s=1}^{k} w_s) ·_A (∏_{A,t=1}^{l} w_{k+t})。
∏_{s=1}^{k+j} w_s = P ·_A ∏_{t=1}^{j} w_{k+t} を j の帰納法で示す。 -/
theorem orderedProduct_split (SA : AlgebraOver K A) (k l : ℕ) (w : ℕ → A) :
    orderedProduct SA (k + l) w
      = SA.mul (orderedProduct SA k w) (orderedProduct SA l (fun t => w (k + t))) := by
  have hj : ∀ j : ℕ, partialOrderedProduct SA w (k + j)
      = SA.mul (orderedProduct SA k w) (partialOrderedProduct SA (fun t => w (k + t)) j) := by
    intro j
    induction j with
    | zero => calc
        partialOrderedProduct SA w (k + 0) = orderedProduct SA k w := rfl
        _ = SA.mul (orderedProduct SA k w) SA.one := (SA.mul_one _).symm
        _ = SA.mul (orderedProduct SA k w) (partialOrderedProduct SA (fun t => w (k + t)) 0) := rfl
    | succ j ih => calc
        partialOrderedProduct SA w (k + (j + 1))
            = SA.mul (partialOrderedProduct SA w (k + j)) (w (k + (j + 1))) := rfl
        _ = SA.mul (SA.mul (orderedProduct SA k w)
              (partialOrderedProduct SA (fun t => w (k + t)) j)) (w (k + (j + 1))) := by rw [ih]
        _ = SA.mul (orderedProduct SA k w)
              (SA.mul (partialOrderedProduct SA (fun t => w (k + t)) j) (w (k + (j + 1)))) :=
            SA.mul_assoc _ _ _
        _ = SA.mul (orderedProduct SA k w)
              (partialOrderedProduct SA (fun t => w (k + t)) (j + 1)) := rfl
  exact hj l

/-- 本文 `claim_ordered_product_in_algebra_with_one_factor_singled_out`：p ∈ {1,…,n} について
∏_{A,s=1}^{n} x_s = (∏_{A,s=1}^{p-1} x_s) ·_A (x_p ·_A ∏_{A,r=1}^{n-p} x_{p+r})。
u_t := x_{p-1+t} と置き、前の主張を k := p-1、l := 1+(n-p) と、族 u に k := 1、l := n-p で当てる。 -/
theorem orderedProduct_singleOut (SA : AlgebraOver K A) (n p : ℕ) (hp1 : 1 ≤ p) (hpn : p ≤ n)
    (x : ℕ → A) :
    orderedProduct SA n x
      = SA.mul (orderedProduct SA (p - 1) x)
          (SA.mul (x p) (orderedProduct SA (n - p) (fun r => x (p + r)))) := by
  -- u_1 = x_p、u_{1+r} = x_{p+r}
  have hu1 : x (p - 1 + 1) = x p := by rw [Nat.sub_add_cancel hp1]
  have hu : ∀ r : ℕ, 1 ≤ r → r ≤ n - p → x (p - 1 + (1 + r)) = x (p + r) :=
    fun r _ _ => congrArg x (by omega)
  have hn : n = p - 1 + (1 + (n - p)) := by omega
  calc orderedProduct SA n x
      = orderedProduct SA (p - 1 + (1 + (n - p))) x := by rw [← hn]
    _ = SA.mul (orderedProduct SA (p - 1) x)
          (orderedProduct SA (1 + (n - p)) (fun t => x (p - 1 + t))) :=
        orderedProduct_split SA (p - 1) (1 + (n - p)) x
    _ = SA.mul (orderedProduct SA (p - 1) x)
          (SA.mul (orderedProduct SA 1 (fun t => x (p - 1 + t)))
            (orderedProduct SA (n - p) (fun r => x (p - 1 + (1 + r))))) := by
        rw [orderedProduct_split SA 1 (n - p) (fun t => x (p - 1 + t))]
    _ = SA.mul (orderedProduct SA (p - 1) x)
          (SA.mul (SA.mul SA.one (x (p - 1 + 1)))
            (orderedProduct SA (n - p) (fun r => x (p - 1 + (1 + r))))) := rfl
    _ = SA.mul (orderedProduct SA (p - 1) x)
          (SA.mul (x (p - 1 + 1)) (orderedProduct SA (n - p) (fun r => x (p - 1 + (1 + r))))) := by
        rw [SA.one_mul (x (p - 1 + 1))]
    _ = SA.mul (orderedProduct SA (p - 1) x)
          (SA.mul (x p) (orderedProduct SA (n - p) (fun r => x (p - 1 + (1 + r))))) := by
        rw [hu1]
    _ = SA.mul (orderedProduct SA (p - 1) x)
          (SA.mul (x p) (orderedProduct SA (n - p) (fun r => x (p + r)))) := by
        rw [orderedProduct_congr SA (n - p) _ _ hu]

/-- 本文 `claim_element_commuting_with_each_factor_commutes_with_ordered_product`：
すべての k ∈ {1,…,n} で u ·_A x_k = x_k ·_A u なら u ·_A ∏ x_k = (∏ x_k) ·_A u。 -/
theorem commute_orderedProduct (SA : AlgebraOver K A) (u : A) (n : ℕ) (x : ℕ → A)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → SA.mul u (x k) = SA.mul (x k) u) :
    SA.mul u (orderedProduct SA n x) = SA.mul (orderedProduct SA n x) u := by
  have hm : ∀ m : ℕ, m ≤ n →
      SA.mul u (partialOrderedProduct SA x m) = SA.mul (partialOrderedProduct SA x m) u := by
    intro m
    induction m with
    | zero => intro _; calc
        SA.mul u (partialOrderedProduct SA x 0) = SA.mul u SA.one := rfl
        _ = u := SA.mul_one u
        _ = SA.mul SA.one u := (SA.one_mul u).symm
        _ = SA.mul (partialOrderedProduct SA x 0) u := rfl
    | succ m ih =>
      intro hmn
      calc SA.mul u (partialOrderedProduct SA x (m + 1))
          = SA.mul u (SA.mul (partialOrderedProduct SA x m) (x (m + 1))) := rfl
        _ = SA.mul (SA.mul u (partialOrderedProduct SA x m)) (x (m + 1)) := (SA.mul_assoc _ _ _).symm
        _ = SA.mul (SA.mul (partialOrderedProduct SA x m) u) (x (m + 1)) := by
            rw [ih (Nat.le_of_succ_le hmn)]
        _ = SA.mul (partialOrderedProduct SA x m) (SA.mul u (x (m + 1))) := SA.mul_assoc _ _ _
        _ = SA.mul (partialOrderedProduct SA x m) (SA.mul (x (m + 1)) u) := by
            rw [h (m + 1) (Nat.succ_pos m) hmn]
        _ = SA.mul (SA.mul (partialOrderedProduct SA x m) (x (m + 1))) u := (SA.mul_assoc _ _ _).symm
        _ = SA.mul (partialOrderedProduct SA x (m + 1)) u := rfl
  exact hm n le_rfl

/-- 本文 `claim_anticommuting_elements_swap_with_sign`：p ·_A q +_A q ·_A p = 0_A なら
p ·_A q = n ∗_A (q ·_A p)（n は 1 + n = 0 を満たす K の元。本文の -1_ℂ）。 -/
theorem mul_eq_neg_one_smul_swap [Zero K] (h00 : (0 : K) + 0 = 0) (n : K) (hn : 1 + n = 0)
    (SA : AlgebraOver K A) (p q : A)
    (h : SA.add (SA.mul p q) (SA.mul q p) = SA.zero) :
    SA.mul p q = SA.smul n (SA.mul q p) := by
  -- 準備：r := q ·_A p、r +_A n ∗_A r = 0_A
  set r := SA.mul q p with hr
  have hprep : SA.add r (SA.smul n r) = SA.zero := calc
    SA.add r (SA.smul n r) = SA.add (SA.smul 1 r) (SA.smul n r) := by rw [SA.one_smul r]
    _ = SA.smul (1 + n) r := (SA.add_smul 1 n r).symm
    _ = SA.smul 0 r := by rw [hn]
    _ = SA.zero := zero_smul_eq_zero SA.toVectorSpace h00 r
  calc SA.mul p q
      = SA.add (SA.mul p q) SA.zero := (SA.add_zero _).symm
    _ = SA.add (SA.mul p q) (SA.add r (SA.smul n r)) := by rw [hprep]
    _ = SA.add (SA.add (SA.mul p q) r) (SA.smul n r) := (SA.add_assoc _ _ _).symm
    _ = SA.add (SA.add (SA.mul p q) (SA.mul q p)) (SA.smul n r) := rfl
    _ = SA.add SA.zero (SA.smul n r) := by rw [h]
    _ = SA.add (SA.smul n r) SA.zero := SA.add_comm _ _
    _ = SA.smul n r := SA.add_zero _
    _ = SA.smul n (SA.mul q p) := rfl

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver
