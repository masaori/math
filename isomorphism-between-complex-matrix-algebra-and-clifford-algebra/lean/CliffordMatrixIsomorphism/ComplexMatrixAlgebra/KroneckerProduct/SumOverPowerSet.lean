/-
章「複素行列環」の、部分集合ごとに因子を選んだ ℂ の中の番号順の積を部分集合全体の上で足すと因子の和の番号順の積になる、
という主張の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                  このファイル
  claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers      selectedFactor（v^R_k）・
                                                                                selectedFactor_of_mem・selectedFactor_of_not_mem・
                                                                                partialOrderedProduct_selectedFactor_congr（（一））・
                                                                                linearCombination_mul_right（（二））・
                                                                                sumOverBinaryNumbering_selected（帰納法の主張）・
                                                                                sumOverPowerSet_selected

和はどれも ℂ^vec（`complexNumbersVectorSpace`、証明の中では S と書く）の中の線型結合・有限集合の上の和である。
番号付けた族 x_k・y_k は `ℕ → ℂ` で表し、1,…,M の外の値は使わない。

本文の v^R_k と F_m(R) は R ∈ P_M について定めるが、帰納法では R := e_m(j) ∈ P_m を P_m ⊆ P_M によって P_M の元として使う。
この包含は「R を {1,…,M} の部分集合として読む」写像で、R の下の集合（ℕ の部分集合）を変えない。
Lean では v^R_k を R の下の集合 R.1 : Set ℕ について `selectedFactor x y R.1 k` と定め、P_m の元と P_M の元のどちらからも
下の集合を通して同じ式で引く。F_m(R) は `partialOrderedProduct (selectedFactor x y R) m` である。

本文の帰納法 m ∈ {0,…,M} と主張は M ≥ 1 を前提に置くが、証明は m ≤ M も M ≥ 1 も使わないので、
帰納法の主張 `sumOverBinaryNumbering_selected` はすべての m : ℕ について、主張は任意の M について書く。
Lean の帰納法は m + 1 の段を m の段から作るので、本文の m・m - 1 は m + 1・m と読む（`BinaryNumbering.lean` と同じ）。

本文の線型結合 Σ_{j=1}^{2^m} 1_ℂ ·_{ℂ^vec} F_m(e_m(j)) は、係数の族を定数 1（`fun _ => 1`）、元の族を
`numberedFamily (binaryNumbering m) (fun R => F_m(R.1)) S.zero`（{1,…,2^m} の外の値は使わない）とした `linearCombination` である。
最後の行「番号付け (2^M, e_M) で開く」は、`sumOverFiniteSet_eq` が与える係数の族 `numberedFamily e (fun _ => 1) 0` を、
1,…,2^M で値の等しい定数 1 の族に `linearCombination_eq_of_terms_eq` で替える（`ℕ` の族としては外の値が違うため）。

必要十分版は `NecSuf/ComplexMatrixAlgebra/KroneckerProduct/SumOverPowerSet.lean`、導出版は `KroneckerProductFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorProduct.OrderedProduct
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ComplexNumbersAsVectorSpace

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

open Classical in
/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers` の v^R_k：
k ∈ R なら x_k、k ∉ R なら y_k。 -/
noncomputable def selectedFactor (x y : ℕ → ℂ) (R : Set ℕ) (k : ℕ) : ℂ :=
  if k ∈ R then x k else y k

theorem selectedFactor_of_mem (x y : ℕ → ℂ) (R : Set ℕ) (k : ℕ) (hk : k ∈ R) :
    selectedFactor x y R k = x k := by
  unfold selectedFactor
  rw [if_pos hk]

theorem selectedFactor_of_not_mem (x y : ℕ → ℂ) (R : Set ℕ) (k : ℕ) (hk : k ∉ R) :
    selectedFactor x y R k = y k := by
  unfold selectedFactor
  rw [if_neg hk]

/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers` の準備（一）：
すべての i ∈ {1,…,m'} で v^R_i = v^{R'}_i なら F_{m'}(R) = F_{m'}(R')。m' についての帰納法。 -/
theorem partialOrderedProduct_selectedFactor_congr (x y : ℕ → ℂ) (R R' : Set ℕ) :
    ∀ m' : ℕ, (∀ i : ℕ, 1 ≤ i → i ≤ m' → selectedFactor x y R i = selectedFactor x y R' i) →
      partialOrderedProduct (selectedFactor x y R) m' = partialOrderedProduct (selectedFactor x y R') m'
  | 0, _ => rfl
  | m' + 1, h => by
    -- 仮定は m' についても成り立つので、帰納法の仮定から F_{m'}(R) = F_{m'}(R')
    have ih := partialOrderedProduct_selectedFactor_congr x y R R' m'
      (fun i hi1 hi2 => h i hi1 (Nat.le_succ_of_le hi2))
    calc partialOrderedProduct (selectedFactor x y R) (m' + 1)
        = partialOrderedProduct (selectedFactor x y R) m' * selectedFactor x y R (m' + 1) := rfl
      _ = partialOrderedProduct (selectedFactor x y R') m' * selectedFactor x y R (m' + 1) := by
          rw [ih]
      _ = partialOrderedProduct (selectedFactor x y R') m' * selectedFactor x y R' (m' + 1) := by
          rw [h (m' + 1) (Nat.succ_pos m') (le_refl (m' + 1))]
      _ = partialOrderedProduct (selectedFactor x y R') (m' + 1) := rfl

/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers` の準備（二）：
Σ_{k=1}^{n} 1_ℂ ·_{ℂ^vec} (p_k ·_ℂ r) = (Σ_{k=1}^{n} 1_ℂ ·_{ℂ^vec} p_k) ·_ℂ r。 -/
theorem linearCombination_mul_right (n : ℕ) (r : ℂ) (p : ℕ → ℂ) :
    linearCombination complexNumbersVectorSpace n (fun _ => 1) (fun k => p k * r)
      = linearCombination complexNumbersVectorSpace n (fun _ => 1) p * r := by
  let S := complexNumbersVectorSpace
  -- 各項で 1_ℂ ·_{ℂ^vec} (p_k ·_ℂ r) = (r ·_ℂ 1_ℂ) ·_{ℂ^vec} p_k
  have hterm : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      S.smul 1 (p k * r) = S.smul (r * 1) (p k) := fun k _ _ => calc
    S.smul 1 (p k * r) = 1 * (p k * r) := rfl
    _ = p k * r := by rw [one_mul (p k * r)]
    _ = r * p k := by rw [mul_comm (p k) r]
    _ = (r * 1) * p k := by rw [mul_one r]
    _ = S.smul (r * 1) (p k) := rfl
  calc linearCombination S n (fun _ => 1) (fun k => p k * r)
      = linearCombination S n (fun _ => r * 1) p :=
        linearCombination_eq_of_terms_eq S n _ _ _ _ hterm
    _ = S.smul r (linearCombination S n (fun _ => 1) p) :=
        (smul_linearCombination S n p (fun _ => 1) r).symm
    _ = r * linearCombination S n (fun _ => 1) p := rfl
    _ = linearCombination S n (fun _ => 1) p * r := by
        rw [mul_comm r (linearCombination S n (fun _ => 1) p)]

/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers` の帰納法の主張：
Σ_{j=1}^{2^m} 1_ℂ ·_{ℂ^vec} F_m(e_m(j)) = Π_m（Π_m は族 y_k +_ℂ x_k の部分積）。 -/
theorem sumOverBinaryNumbering_selected (x y : ℕ → ℂ) :
    ∀ m : ℕ, linearCombination complexNumbersVectorSpace (twoPower m) (fun _ => 1)
        (numberedFamily (binaryNumbering m)
          (fun R => partialOrderedProduct (selectedFactor x y R.1) m) complexNumbersVectorSpace.zero)
      = partialOrderedProduct (fun k => y k + x k) m
  | 0 => by
    let S := complexNumbersVectorSpace
    -- F_0(e_0(1)) = 1_ℂ
    have hF : numberedFamily (binaryNumbering 0)
        (fun R => partialOrderedProduct (selectedFactor x y R.1) 0) S.zero 1 = 1 := by
      rw [numberedFamily_of_le (binaryNumbering 0) _ S.zero 1 (le_refl 1) (le_refl 1)]
      rfl
    calc linearCombination S (twoPower 0) (fun _ => 1)
          (numberedFamily (binaryNumbering 0)
            (fun R => partialOrderedProduct (selectedFactor x y R.1) 0) S.zero)
        = S.add S.zero (S.smul 1 (numberedFamily (binaryNumbering 0)
            (fun R => partialOrderedProduct (selectedFactor x y R.1) 0) S.zero 1)) := rfl
      _ = S.add S.zero (S.smul 1 1) := by rw [hF]
      _ = 0 + 1 * 1 := rfl
      _ = 0 + 1 := by rw [one_mul (1 : ℂ)]
      _ = 1 := by rw [zero_add (1 : ℂ)]
      _ = partialOrderedProduct (fun k => y k + x k) 0 := rfl
  | m + 1 => by
    let S := complexNumbersVectorSpace
    -- 帰納法の仮定
    have ih := sumOverBinaryNumbering_selected x y m
    -- n := 2^{m-1}（Lean では twoPower m）
    set n := twoPower m with hn
    -- 本文の G_m(j) := F_m(e_m(j))（{1,…,2^m} の外の値は使わない）
    set G : ℕ → ℂ := numberedFamily (binaryNumbering m)
      (fun R => partialOrderedProduct (selectedFactor x y R.1) m) S.zero with hG
    set G' : ℕ → ℂ := numberedFamily (binaryNumbering (m + 1))
      (fun R => partialOrderedProduct (selectedFactor x y R.1) (m + 1)) S.zero with hG'
    have h2 : twoPower (m + 1) = n + n := twoPower_succ m
    -- （三）k ∈ {1,…,n} なら F_m(e_m(k)) = F_{m-1}(e_{m-1}(k)) ·_ℂ y_m
    have h3 : ∀ k : ℕ, 1 ≤ k → k ≤ n → G' k = G k * y (m + 1) := by
      intro k hk1 hkn
      have hk2 : k ≤ twoPower (m + 1) := by omega
      let E : Idx (twoPower (m + 1)) := ⟨k, hk1, hk2⟩
      have hE : E.1 ≤ twoPower m := hkn
      rw [hG', numberedFamily_of_le _ _ S.zero k hk1 hk2, hG, numberedFamily_of_le _ _ S.zero k hk1 hkn]
      calc partialOrderedProduct (selectedFactor x y (binaryNumbering (m + 1) E).1) (m + 1)
          = partialOrderedProduct (selectedFactor x y (binaryNumbering (m + 1) E).1) m
              * selectedFactor x y (binaryNumbering (m + 1) E).1 (m + 1) := rfl
        _ = partialOrderedProduct (selectedFactor x y (binaryNumbering (m + 1) E).1) m * y (m + 1) := by
            rw [selectedFactor_of_not_mem x y _ (m + 1) (not_mem_binaryNumbering_succ_of_le m E hE)]
        _ = partialOrderedProduct (selectedFactor x y (binaryNumbering m ⟨k, hk1, hkn⟩).1) m * y (m + 1) := by
            rw [binaryNumbering_succ_of_le m E hE]
    -- （四）j ∈ {1,…,n} なら F_m(e_m(n+j)) = F_{m-1}(e_{m-1}(j)) ·_ℂ x_m
    have h4 : ∀ j : ℕ, 1 ≤ j → j ≤ n → G' (n + j) = G j * x (m + 1) := by
      intro j hj1 hjn
      have hk1 : 1 ≤ n + j := by omega
      have hk2 : n + j ≤ twoPower (m + 1) := by omega
      let E : Idx (twoPower (m + 1)) := ⟨n + j, hk1, hk2⟩
      have hE : ¬ E.1 ≤ twoPower m := by show ¬ n + j ≤ n; omega
      -- e_{m-1}((n+j) - n) = e_{m-1}(j)
      have hsub : (⟨E.1 - twoPower m, sub_twoPower_mem E hE⟩ : Idx (twoPower m)) = ⟨j, hj1, hjn⟩ :=
        Subtype.ext (by show n + j - n = j; omega)
      -- i ∈ {1,…,m-1} なら v^{e_m(n+j)}_i = v^{e_{m-1}(j)}_i
      have hv : ∀ i : ℕ, 1 ≤ i → i ≤ m →
          selectedFactor x y (binaryNumbering (m + 1) E).1 i
            = selectedFactor x y (binaryNumbering m ⟨j, hj1, hjn⟩).1 i := by
        intro i _ him
        have hiff := mem_binaryNumbering_succ_iff_of_gt m E hE i him
        rw [hsub] at hiff
        by_cases hi : i ∈ (binaryNumbering m ⟨j, hj1, hjn⟩).1
        · rw [selectedFactor_of_mem x y _ i (hiff.mpr hi), selectedFactor_of_mem x y _ i hi]
        · rw [selectedFactor_of_not_mem x y _ i (fun h => hi (hiff.mp h)),
            selectedFactor_of_not_mem x y _ i hi]
      rw [hG', numberedFamily_of_le _ _ S.zero (n + j) hk1 hk2, hG,
        numberedFamily_of_le _ _ S.zero j hj1 hjn]
      calc partialOrderedProduct (selectedFactor x y (binaryNumbering (m + 1) E).1) (m + 1)
          = partialOrderedProduct (selectedFactor x y (binaryNumbering (m + 1) E).1) m
              * selectedFactor x y (binaryNumbering (m + 1) E).1 (m + 1) := rfl
        _ = partialOrderedProduct (selectedFactor x y (binaryNumbering (m + 1) E).1) m * x (m + 1) := by
            rw [selectedFactor_of_mem x y _ (m + 1) (mem_binaryNumbering_succ_of_gt m E hE)]
        _ = partialOrderedProduct (selectedFactor x y (binaryNumbering m ⟨j, hj1, hjn⟩).1) m * x (m + 1) := by
            rw [partialOrderedProduct_selectedFactor_congr x y _ _ m hv]
    -- 各項で（三）と（四）
    have h34 : linearCombination S n (fun _ => 1) G'
          = linearCombination S n (fun _ => 1) (fun k => G k * y (m + 1)) ∧
        linearCombination S n (fun j => (fun _ => (1 : ℂ)) (n + j)) (fun j => G' (n + j))
          = linearCombination S n (fun _ => 1) (fun j => G j * x (m + 1)) :=
      ⟨linearCombination_eq_of_terms_eq S n _ _ _ _ (fun k hk1 hkn => by rw [h3 k hk1 hkn]),
        linearCombination_eq_of_terms_eq S n _ _ _ _ (fun j hj1 hjn => by rw [h4 j hj1 hjn])⟩
    calc linearCombination S (twoPower (m + 1)) (fun _ => 1) G'
        = S.add (linearCombination S n (fun _ => 1) G')
            (linearCombination S n (fun j => (fun _ => (1 : ℂ)) (n + j)) (fun j => G' (n + j))) :=
          (congrArg (fun N => linearCombination S N (fun _ => 1) G') h2).trans
            (linearCombination_split S n n G' (fun _ => 1))
      _ = S.add (linearCombination S n (fun _ => 1) (fun k => G k * y (m + 1)))
            (linearCombination S n (fun _ => 1) (fun j => G j * x (m + 1))) := by
          rw [h34.1, h34.2]
      _ = S.add (linearCombination S n (fun _ => 1) G * y (m + 1))
            (linearCombination S n (fun _ => 1) G * x (m + 1)) := by
          rw [linearCombination_mul_right n (y (m + 1)) G, linearCombination_mul_right n (x (m + 1)) G]
      _ = S.add (partialOrderedProduct (fun k => y k + x k) m * y (m + 1))
            (partialOrderedProduct (fun k => y k + x k) m * x (m + 1)) := by
          rw [ih]
      _ = partialOrderedProduct (fun k => y k + x k) m * y (m + 1)
            + partialOrderedProduct (fun k => y k + x k) m * x (m + 1) := rfl
      _ = partialOrderedProduct (fun k => y k + x k) m * (y (m + 1) + x (m + 1)) := by
          rw [mul_add]
      _ = partialOrderedProduct (fun k => y k + x k) (m + 1) := rfl

/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers`：
Σ_{R∈P_M} 1_ℂ ·_{ℂ^vec} Π_{ℂ,k=1}^{M} v^R_k = Π_{ℂ,k=1}^{M} (y_k +_ℂ x_k)。 -/
theorem sumOverPowerSet_selected (M : ℕ) (x y : ℕ → ℂ) :
    sumOverFiniteSet complexNumbersVectorSpace (isFiniteSet_powerSet M) (fun _ => 1)
        (fun R => orderedProduct M (selectedFactor x y R.1))
      = orderedProduct M (fun k => y k + x k) := by
  let S := complexNumbersVectorSpace
  -- 番号付け (2^M, e_M) で開いたときの係数の族は、1,…,2^M で 1_ℂ
  have hcoef : ∀ k : ℕ, 1 ≤ k → k ≤ twoPower M →
      S.smul (numberedFamily (binaryNumbering M) (fun _ => (1 : ℂ)) 0 k)
          (numberedFamily (binaryNumbering M) (fun R => orderedProduct M (selectedFactor x y R.1)) S.zero k)
        = S.smul 1 (numberedFamily (binaryNumbering M)
            (fun R => partialOrderedProduct (selectedFactor x y R.1) M) S.zero k) := by
    intro k hk1 hk2
    rw [numberedFamily_of_le (binaryNumbering M) (fun _ => (1 : ℂ)) 0 k hk1 hk2]
    rfl
  calc sumOverFiniteSet S (isFiniteSet_powerSet M) (fun _ => 1)
        (fun R => orderedProduct M (selectedFactor x y R.1))
      = linearCombination S (twoPower M) (fun _ => 1)
          (numberedFamily (binaryNumbering M)
            (fun R => partialOrderedProduct (selectedFactor x y R.1) M) S.zero) := by
        rw [sumOverFiniteSet_eq S (isFiniteSet_powerSet M) _ _ (twoPower M) (binaryNumbering M)
          (binaryNumbering_isNumbering M)]
        exact linearCombination_eq_of_terms_eq S (twoPower M) _ _ _ _ hcoef
    _ = partialOrderedProduct (fun k => y k + x k) M := sumOverBinaryNumbering_selected x y M
    _ = orderedProduct M (fun k => y k + x k) := rfl

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
