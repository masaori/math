/-
章「複素行列環」の、部分集合ごとに因子を選んだ番号順の積を部分集合全体の上で足すと因子の和の番号順の積になる、
という主張の必要十分版。具体版 `ComplexMatrixAlgebra/KroneckerProduct/SumOverPowerSet.lean` と同じ def と calc の行で、
係数 ℂ を型の変数 K に替えて書く。和は K を自分自身の上の線型空間にした `coefficientsVec L`（具体版の ℂ^vec。証明の中では S）の中の和である。
P_M・2 進の番号付け e_m（`PowerSetNumbering/`）は ℂ を含まないので、具体版と同じものを引く。

  本文のラベル                                                                  このファイル                               使う K の性質
  claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers      selectedFactor                             なし
                                                                                partialOrderedProduct_selectedFactor_congr なし（（一））
                                                                                linearCombination_mul_right                L・乗法の交換法則・a · 1 = a・a · 0 = 0（（二））
                                                                                sumOverBinaryNumbering_selected            L・乗法の交換法則・a · 1 = a・a · 0 = 0
                                                                                sumOverPowerSet_selected                   同上

L : `ValuedMapsLaws K` は和をとる線型空間 K^vec を作るのに要る。行の中で L から使うのは、1 · a = a（（二）の 1_K ·_K (p_k ·_K r) = p_k ·_K r と
m = 0 の段の 1_K ·_K 1_K = 1_K）、0 + 0 = 0（和のスカラー倍の主張 `smul_linearCombination` の仮定。`L.add_zero 0`）、
左分配法則（帰納法の段の Π_{m-1} ·_K y_m + Π_{m-1} ·_K x_m = Π_{m-1} ·_K (y_m + x_m)）と、
m = 0 の段の 0_K +_K 1_K = 1_K の行の 0 + a = a である。0 + a = a は L の加法の交換法則と a + 0 = a から
`zero_add_of_valuedMapsLaws` で示して引くので、仮定に重ねて置かない。

削れなかった仮定:
- 乗法の交換法則（（二））: 本文の経路は、和のスカラー倍の主張（スカラーを係数の左から掛ける）を使うために、
  p_k ·_K r を r ·_K p_k に、r ·_K (Σ …) を (Σ …) ·_K r に入れ替える。交換法則が無ければ、右から掛ける r を和の外へ出す主張が別に要る。
- a · 1 = a（（二））: r を (r ·_K 1_K) に書き直す行。和のスカラー倍の主張が係数を μ ·_K λ_k の形で返すので、係数 1_K に合わせる。
- a · 0 = 0（（二））: 和のスカラー倍の主張 `smul_linearCombination` の仮定（ρ ·_V 0_V = 0_V を経由する）。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Definitions

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet twoPower twoPower_succ binaryNumbering
  binaryNumbering_isNumbering isFiniteSet_powerSet binaryNumbering_succ_of_le sub_twoPower_mem
  not_mem_binaryNumbering_succ_of_le mem_binaryNumbering_succ_of_gt mem_binaryNumbering_succ_iff_of_gt)

universe uK

variable {K : Type uK}

open Classical in
/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers` の v^R_k の必要十分版。 -/
noncomputable def selectedFactor (x y : ℕ → K) (R : Set ℕ) (k : ℕ) : K :=
  if k ∈ R then x k else y k

theorem selectedFactor_of_mem (x y : ℕ → K) (R : Set ℕ) (k : ℕ) (hk : k ∈ R) :
    selectedFactor x y R k = x k := by
  unfold selectedFactor
  rw [if_pos hk]

theorem selectedFactor_of_not_mem (x y : ℕ → K) (R : Set ℕ) (k : ℕ) (hk : k ∉ R) :
    selectedFactor x y R k = y k := by
  unfold selectedFactor
  rw [if_neg hk]

/-- 本文の準備（一）の必要十分版：すべての i ∈ {1,…,m'} で v^R_i = v^{R'}_i なら F_{m'}(R) = F_{m'}(R')。 -/
theorem partialOrderedProduct_selectedFactor_congr [Mul K] [One K] (x y : ℕ → K) (R R' : Set ℕ) :
    ∀ m' : ℕ, (∀ i : ℕ, 1 ≤ i → i ≤ m' → selectedFactor x y R i = selectedFactor x y R' i) →
      partialOrderedProduct (selectedFactor x y R) m' = partialOrderedProduct (selectedFactor x y R') m'
  | 0, _ => rfl
  | m' + 1, h => by
    have ih := partialOrderedProduct_selectedFactor_congr x y R R' m'
      (fun i hi1 hi2 => h i hi1 (Nat.le_succ_of_le hi2))
    calc partialOrderedProduct (selectedFactor x y R) (m' + 1)
        = partialOrderedProduct (selectedFactor x y R) m' * selectedFactor x y R (m' + 1) := rfl
      _ = partialOrderedProduct (selectedFactor x y R') m' * selectedFactor x y R (m' + 1) := by
          rw [ih]
      _ = partialOrderedProduct (selectedFactor x y R') m' * selectedFactor x y R' (m' + 1) := by
          rw [h (m' + 1) (Nat.succ_pos m') (le_refl (m' + 1))]
      _ = partialOrderedProduct (selectedFactor x y R') (m' + 1) := rfl

variable [Add K] [Mul K] [One K] [Zero K]

/-- `ValuedMapsLaws K` から出る 0 + a = a（加法の交換法則と a + 0 = a による）。 -/
theorem zero_add_of_valuedMapsLaws (L : ValuedMapsLaws K) (a : K) : 0 + a = a := calc
  0 + a = a + 0 := L.add_comm 0 a
  _ = a := L.add_zero a

/-- 本文の準備（二）の必要十分版：Σ_{k=1}^{n} 1 ·_{K^vec} (p_k ·_K r) = (Σ_{k=1}^{n} 1 ·_{K^vec} p_k) ·_K r。 -/
theorem linearCombination_mul_right (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul1 : ∀ a : K, a * 1 = a) (hmul0 : ∀ a : K, a * 0 = 0) (n : ℕ) (r : K) (p : ℕ → K) :
    linearCombination (coefficientsVec L) n (fun _ => 1) (fun k => p k * r)
      = linearCombination (coefficientsVec L) n (fun _ => 1) p * r := by
  let S := coefficientsVec L
  have hterm : ∀ k : ℕ, 1 ≤ k → k ≤ n →
      S.smul 1 (p k * r) = S.smul (r * 1) (p k) := fun k _ _ => calc
    S.smul 1 (p k * r) = 1 * (p k * r) := rfl
    _ = p k * r := by rw [L.one_mul (p k * r)]
    _ = r * p k := by rw [hcomm (p k) r]
    _ = (r * 1) * p k := by rw [hmul1 r]
    _ = S.smul (r * 1) (p k) := rfl
  calc linearCombination S n (fun _ => 1) (fun k => p k * r)
      = linearCombination S n (fun _ => r * 1) p :=
        linearCombination_eq_of_terms_eq S n _ _ _ _ hterm
    _ = S.smul r (linearCombination S n (fun _ => 1) p) :=
        (smul_linearCombination S (L.add_zero 0) hmul0 n p (fun _ => 1) r).symm
    _ = r * linearCombination S n (fun _ => 1) p := rfl
    _ = linearCombination S n (fun _ => 1) p * r := by
        rw [hcomm r (linearCombination S n (fun _ => 1) p)]

/-- 本文の帰納法の主張の必要十分版：Σ_{j=1}^{2^m} 1 ·_{K^vec} F_m(e_m(j)) = Π_m。 -/
theorem sumOverBinaryNumbering_selected (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul1 : ∀ a : K, a * 1 = a) (hmul0 : ∀ a : K, a * 0 = 0)
    (x y : ℕ → K) :
    ∀ m : ℕ, linearCombination (coefficientsVec L) (twoPower m) (fun _ => 1)
        (numberedFamily (binaryNumbering m)
          (fun R => partialOrderedProduct (selectedFactor x y R.1) m) (coefficientsVec L).zero)
      = partialOrderedProduct (fun k => y k + x k) m
  | 0 => by
    let S := coefficientsVec L
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
      _ = 0 + 1 := by rw [L.one_mul (1 : K)]
      _ = 1 := zero_add_of_valuedMapsLaws L (1 : K)
      _ = partialOrderedProduct (fun k => y k + x k) 0 := rfl
  | m + 1 => by
    let S := coefficientsVec L
    have ih := sumOverBinaryNumbering_selected L hcomm hmul1 hmul0 x y m
    set n := twoPower m with hn
    set G : ℕ → K := numberedFamily (binaryNumbering m)
      (fun R => partialOrderedProduct (selectedFactor x y R.1) m) S.zero with hG
    set G' : ℕ → K := numberedFamily (binaryNumbering (m + 1))
      (fun R => partialOrderedProduct (selectedFactor x y R.1) (m + 1)) S.zero with hG'
    have h2 : twoPower (m + 1) = n + n := twoPower_succ m
    -- （三）
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
    -- （四）
    have h4 : ∀ j : ℕ, 1 ≤ j → j ≤ n → G' (n + j) = G j * x (m + 1) := by
      intro j hj1 hjn
      have hk1 : 1 ≤ n + j := by omega
      have hk2 : n + j ≤ twoPower (m + 1) := by omega
      let E : Idx (twoPower (m + 1)) := ⟨n + j, hk1, hk2⟩
      have hE : ¬ E.1 ≤ twoPower m := by show ¬ n + j ≤ n; omega
      have hsub : (⟨E.1 - twoPower m, sub_twoPower_mem E hE⟩ : Idx (twoPower m)) = ⟨j, hj1, hjn⟩ :=
        Subtype.ext (by show n + j - n = j; omega)
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
    have h34 : linearCombination S n (fun _ => 1) G'
          = linearCombination S n (fun _ => 1) (fun k => G k * y (m + 1)) ∧
        linearCombination S n (fun j => (fun _ => (1 : K)) (n + j)) (fun j => G' (n + j))
          = linearCombination S n (fun _ => 1) (fun j => G j * x (m + 1)) :=
      ⟨linearCombination_eq_of_terms_eq S n _ _ _ _ (fun k hk1 hkn => by rw [h3 k hk1 hkn]),
        linearCombination_eq_of_terms_eq S n _ _ _ _ (fun j hj1 hjn => by rw [h4 j hj1 hjn])⟩
    calc linearCombination S (twoPower (m + 1)) (fun _ => 1) G'
        = S.add (linearCombination S n (fun _ => 1) G')
            (linearCombination S n (fun j => (fun _ => (1 : K)) (n + j)) (fun j => G' (n + j))) :=
          (congrArg (fun N => linearCombination S N (fun _ => 1) G') h2).trans
            (linearCombination_split S n n G' (fun _ => 1))
      _ = S.add (linearCombination S n (fun _ => 1) (fun k => G k * y (m + 1)))
            (linearCombination S n (fun _ => 1) (fun j => G j * x (m + 1))) := by
          rw [h34.1, h34.2]
      _ = S.add (linearCombination S n (fun _ => 1) G * y (m + 1))
            (linearCombination S n (fun _ => 1) G * x (m + 1)) := by
          rw [linearCombination_mul_right L hcomm hmul1 hmul0 n (y (m + 1)) G,
            linearCombination_mul_right L hcomm hmul1 hmul0 n (x (m + 1)) G]
      _ = S.add (partialOrderedProduct (fun k => y k + x k) m * y (m + 1))
            (partialOrderedProduct (fun k => y k + x k) m * x (m + 1)) := by
          rw [ih]
      _ = partialOrderedProduct (fun k => y k + x k) m * y (m + 1)
            + partialOrderedProduct (fun k => y k + x k) m * x (m + 1) := rfl
      _ = partialOrderedProduct (fun k => y k + x k) m * (y (m + 1) + x (m + 1)) := by
          rw [L.left_distrib]
      _ = partialOrderedProduct (fun k => y k + x k) (m + 1) := rfl

/-- 本文 `claim_sum_over_power_set_of_selected_ordered_products_in_complex_numbers` の必要十分版：
Σ_{R∈P_M} 1 ·_{K^vec} Π_{k=1}^{M} v^R_k = Π_{k=1}^{M} (y_k + x_k)。 -/
theorem sumOverPowerSet_selected (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul1 : ∀ a : K, a * 1 = a) (hmul0 : ∀ a : K, a * 0 = 0)
    (M : ℕ) (x y : ℕ → K) :
    sumOverFiniteSet (coefficientsVec L) (isFiniteSet_powerSet M) (fun _ => 1)
        (fun R => orderedProduct M (selectedFactor x y R.1))
      = orderedProduct M (fun k => y k + x k) := by
  let S := coefficientsVec L
  have hcoef : ∀ k : ℕ, 1 ≤ k → k ≤ twoPower M →
      S.smul (numberedFamily (binaryNumbering M) (fun _ => (1 : K)) 0 k)
          (numberedFamily (binaryNumbering M) (fun R => orderedProduct M (selectedFactor x y R.1)) S.zero k)
        = S.smul 1 (numberedFamily (binaryNumbering M)
            (fun R => partialOrderedProduct (selectedFactor x y R.1) M) S.zero k) := by
    intro k hk1 hk2
    rw [numberedFamily_of_le (binaryNumbering M) (fun _ => (1 : K)) 0 k hk1 hk2]
    rfl
  calc sumOverFiniteSet S (isFiniteSet_powerSet M) (fun _ => 1)
        (fun R => orderedProduct M (selectedFactor x y R.1))
      = linearCombination S (twoPower M) (fun _ => 1)
          (numberedFamily (binaryNumbering M)
            (fun R => partialOrderedProduct (selectedFactor x y R.1) M) S.zero) := by
        rw [sumOverFiniteSet_eq S (isFiniteSet_powerSet M) _ _ (twoPower M) (binaryNumbering M)
          (binaryNumbering_isNumbering M)]
        exact linearCombination_eq_of_terms_eq S (twoPower M) _ _ _ _ hcoef
    _ = partialOrderedProduct (fun k => y k + x k) M :=
        sumOverBinaryNumbering_selected L hcomm hmul1 hmul0 x y M
    _ = orderedProduct M (fun k => y k + x k) := rfl

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
