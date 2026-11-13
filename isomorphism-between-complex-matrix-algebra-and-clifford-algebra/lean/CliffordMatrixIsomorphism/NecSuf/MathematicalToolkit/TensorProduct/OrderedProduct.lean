/-
節「テンソル積」のうち、ℂ の中の番号順の積とその五つの主張の必要十分版。具体版
`MathematicalToolkit/TensorProduct/OrderedProduct.lean` と同じ calc の行で、係数 ℂ を型の変数 K に替えて書く。

各主張が実際に使う K の性質:

  orderedProduct_add_in_one_factor        左右の分配法則（m = r の段で左、m > r の段で右）
  orderedProduct_smul_in_one_factor       乗法の結合法則と、λ がどの元とも交換すること（m = r の段の P_{r-1} ·_K λ = λ ·_K P_{r-1}）
  orderedProduct_mul                      1 · 1 = 1、乗法の結合法則、乗法の交換法則（α_m と Q_{m-1} の入れ替え）
  orderedProduct_of_unit_factors_after    a · 1 = a
  orderedProduct_of_zero_factor           0 · a = 0、乗法の結合法則、0 がどの元とも交換すること

0 の因子の主張は、本文どおりスカラー倍の主張を λ := 0 で当てるので、スカラー倍の主張の仮定（結合法則と λ の交換）を連れてくる。
P_k を直接帰納法で開けば 0 · a = 0 と a · 0 = 0 だけで済むが、本文と同じ手順を保つために置き換えない。
-/
import Mathlib.Data.Complex.Basic

namespace CliffordMatrixIsomorphism.NecSuf

universe uK

variable {K : Type uK} [Mul K] [One K]

/-- 本文 `def_ordered_product_in_complex_numbers` の P_m：P_0 := 1_ℂ、P_m := P_{m-1} ·_ℂ α_m。 -/
def partialOrderedProduct (a : ℕ → K) : ℕ → K
  | 0 => 1
  | m + 1 => partialOrderedProduct a m * a (m + 1)

/-- 本文 `def_ordered_product_in_complex_numbers`：Π_{ℂ,r=1}^{k} α_r := P_k。 -/
def orderedProduct (k : ℕ) (a : ℕ → K) : K :=
  partialOrderedProduct a k

/-- 本文 `claim_ordered_product_is_additive_in_one_factor` の帰納法の主張：
m < r なら P_m = P'_m かつ P_m = P''_m、m ≥ r なら P_m = P'_m +_ℂ P''_m（m ≤ k）。 -/
theorem partialOrderedProduct_add_in_one_factor [Add K]
    (hldistrib : ∀ a b c : K, a * (b + c) = a * b + a * c)
    (hrdistrib : ∀ a b c : K, (a + b) * c = a * c + b * c) (k r : ℕ) (hr1 : 1 ≤ r) (a a' a'' : ℕ → K)
    (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → a s = a' s ∧ a s = a'' s)
    (hr : a r = a' r + a'' r) :
    ∀ m : ℕ, m ≤ k →
      (m < r → partialOrderedProduct a m = partialOrderedProduct a' m ∧
          partialOrderedProduct a m = partialOrderedProduct a'' m) ∧
        (r ≤ m → partialOrderedProduct a m
          = partialOrderedProduct a' m + partialOrderedProduct a'' m)
  | 0, _ =>
    -- m = 0 のとき 0 < r であり、P_0 = 1_ℂ = P'_0 = P''_0
    ⟨fun _ => ⟨rfl, rfl⟩, fun h0 => absurd (lt_of_lt_of_le (Nat.lt_of_lt_of_le Nat.zero_lt_one hr1) h0)
      (lt_irrefl 0)⟩
  | m + 1, hm => by
    have ih := partialOrderedProduct_add_in_one_factor hldistrib hrdistrib k r hr1 a a' a'' hne hr m (by omega)
    rcases Nat.lt_trichotomy (m + 1) r with hlt | heq | hgt
    · -- m < r のとき：m - 1 < r なので P_{m-1} = P'_{m-1} = P''_{m-1}、m ≠ r なので α_m = α'_m = α''_m
      have ih1 := ih.1 (by omega)
      have ha := hne (m + 1) (by omega) hm (by omega)
      refine ⟨fun _ => ⟨?_, ?_⟩, fun h => absurd h (by omega)⟩
      · calc partialOrderedProduct a (m + 1)
            = partialOrderedProduct a m * a (m + 1) := rfl
          _ = partialOrderedProduct a' m * a (m + 1) := by rw [ih1.1]
          _ = partialOrderedProduct a' m * a' (m + 1) := by rw [ha.1]
          _ = partialOrderedProduct a' (m + 1) := rfl
      · calc partialOrderedProduct a (m + 1)
            = partialOrderedProduct a m * a (m + 1) := rfl
          _ = partialOrderedProduct a'' m * a (m + 1) := by rw [ih1.2]
          _ = partialOrderedProduct a'' m * a'' (m + 1) := by rw [ha.2]
          _ = partialOrderedProduct a'' (m + 1) := rfl
    · -- m = r のとき：m - 1 = r - 1 < r なので P_{r-1} = P'_{r-1} = P''_{r-1}
      subst heq
      have ih1 := ih.1 (by omega)
      refine ⟨fun h => absurd h (lt_irrefl _), fun _ => ?_⟩
      calc partialOrderedProduct a (m + 1)
          = partialOrderedProduct a m * a (m + 1) := rfl
        _ = partialOrderedProduct a m * (a' (m + 1) + a'' (m + 1)) := by rw [hr]
        _ = partialOrderedProduct a m * a' (m + 1) + partialOrderedProduct a m * a'' (m + 1) := by
            rw [hldistrib]
        _ = partialOrderedProduct a' m * a' (m + 1) + partialOrderedProduct a'' m * a'' (m + 1) := by
            rw [← ih1.1, ← ih1.2]
        _ = partialOrderedProduct a' (m + 1) + partialOrderedProduct a'' (m + 1) := rfl
    · -- m > r のとき：m - 1 ≥ r なので P_{m-1} = P'_{m-1} +_ℂ P''_{m-1}、m ≠ r なので α_m = α'_m = α''_m
      have ih2 := ih.2 (by omega)
      have ha := hne (m + 1) (by omega) hm (by omega)
      refine ⟨fun h => absurd h (by omega), fun _ => ?_⟩
      calc partialOrderedProduct a (m + 1)
          = partialOrderedProduct a m * a (m + 1) := rfl
        _ = (partialOrderedProduct a' m + partialOrderedProduct a'' m) * a (m + 1) := by rw [ih2]
        _ = partialOrderedProduct a' m * a (m + 1) + partialOrderedProduct a'' m * a (m + 1) := by
            rw [hrdistrib]
        _ = partialOrderedProduct a' m * a' (m + 1) + partialOrderedProduct a'' m * a'' (m + 1) := by
            rw [← ha.1, ← ha.2]
        _ = partialOrderedProduct a' (m + 1) + partialOrderedProduct a'' (m + 1) := rfl

/-- 本文 `claim_ordered_product_is_additive_in_one_factor`：
s ≠ r で α_s = α'_s = α''_s、α_r = α'_r +_ℂ α''_r なら Π α_s = (Π α'_s) +_ℂ (Π α''_s)。 -/
theorem orderedProduct_add_in_one_factor [Add K]
    (hldistrib : ∀ a b c : K, a * (b + c) = a * b + a * c)
    (hrdistrib : ∀ a b c : K, (a + b) * c = a * c + b * c) (k r : ℕ) (hr1 : 1 ≤ r) (hrk : r ≤ k) (a a' a'' : ℕ → K)
    (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → a s = a' s ∧ a s = a'' s)
    (hr : a r = a' r + a'' r) :
    orderedProduct k a = orderedProduct k a' + orderedProduct k a'' :=
  -- r ≤ k なので、帰納法の主張を m = k で使う
  (partialOrderedProduct_add_in_one_factor hldistrib hrdistrib k r hr1 a a' a'' hne hr k (le_refl k)).2 hrk

/-- 本文 `claim_ordered_product_is_homogeneous_in_one_factor` の帰納法の主張：
m < r なら P_m = P'_m、m ≥ r なら P_m = λ ·_ℂ P'_m（m ≤ k）。 -/
theorem partialOrderedProduct_smul_in_one_factor (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (k r : ℕ) (hr1 : 1 ≤ r) (l : K) (hcentral : ∀ a : K, a * l = l * a) (a a' : ℕ → K)
    (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → a s = a' s) (hr : a r = l * a' r) :
    ∀ m : ℕ, m ≤ k →
      (m < r → partialOrderedProduct a m = partialOrderedProduct a' m) ∧
        (r ≤ m → partialOrderedProduct a m = l * partialOrderedProduct a' m)
  | 0, _ =>
    -- m = 0 のとき 0 < r であり、P_0 = 1_ℂ = P'_0
    ⟨fun _ => rfl, fun h0 => absurd (lt_of_lt_of_le (Nat.lt_of_lt_of_le Nat.zero_lt_one hr1) h0)
      (lt_irrefl 0)⟩
  | m + 1, hm => by
    have ih := partialOrderedProduct_smul_in_one_factor hmassoc k r hr1 l hcentral a a' hne hr m (by omega)
    rcases Nat.lt_trichotomy (m + 1) r with hlt | heq | hgt
    · -- m < r のとき
      have ih1 := ih.1 (by omega)
      have ha := hne (m + 1) (by omega) hm (by omega)
      refine ⟨fun _ => ?_, fun h => absurd h (by omega)⟩
      calc partialOrderedProduct a (m + 1)
          = partialOrderedProduct a m * a (m + 1) := rfl
        _ = partialOrderedProduct a' m * a (m + 1) := by rw [ih1]
        _ = partialOrderedProduct a' m * a' (m + 1) := by rw [ha]
        _ = partialOrderedProduct a' (m + 1) := rfl
    · -- m = r のとき：P_{r-1} = P'_{r-1}
      subst heq
      have ih1 := ih.1 (by omega)
      refine ⟨fun h => absurd h (lt_irrefl _), fun _ => ?_⟩
      calc partialOrderedProduct a (m + 1)
          = partialOrderedProduct a m * a (m + 1) := rfl
        _ = partialOrderedProduct a m * (l * a' (m + 1)) := by rw [hr]
        _ = (partialOrderedProduct a m * l) * a' (m + 1) := by rw [hmassoc]
        _ = (l * partialOrderedProduct a m) * a' (m + 1) := by rw [hcentral (partialOrderedProduct a m)]
        _ = l * (partialOrderedProduct a m * a' (m + 1)) := by rw [hmassoc]
        _ = l * (partialOrderedProduct a' m * a' (m + 1)) := by rw [ih1]
        _ = l * partialOrderedProduct a' (m + 1) := rfl
    · -- m > r のとき：P_{m-1} = λ ·_ℂ P'_{m-1}
      have ih2 := ih.2 (by omega)
      have ha := hne (m + 1) (by omega) hm (by omega)
      refine ⟨fun h => absurd h (by omega), fun _ => ?_⟩
      calc partialOrderedProduct a (m + 1)
          = partialOrderedProduct a m * a (m + 1) := rfl
        _ = (l * partialOrderedProduct a' m) * a (m + 1) := by rw [ih2]
        _ = l * (partialOrderedProduct a' m * a (m + 1)) := by rw [hmassoc]
        _ = l * (partialOrderedProduct a' m * a' (m + 1)) := by rw [ha]
        _ = l * partialOrderedProduct a' (m + 1) := rfl

/-- 本文 `claim_ordered_product_is_homogeneous_in_one_factor`：
s ≠ r で α_s = α'_s、α_r = λ ·_ℂ α'_r なら Π α_s = λ ·_ℂ Π α'_s。 -/
theorem orderedProduct_smul_in_one_factor (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (k r : ℕ) (hr1 : 1 ≤ r) (hrk : r ≤ k) (l : K) (hcentral : ∀ a : K, a * l = l * a)
    (a a' : ℕ → K) (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → a s = a' s) (hr : a r = l * a' r) :
    orderedProduct k a = l * orderedProduct k a' :=
  (partialOrderedProduct_smul_in_one_factor hmassoc k r hr1 l hcentral a a' hne hr k (le_refl k)).2 hrk

/-- 本文 `claim_product_of_two_ordered_products_in_complex_numbers` の帰納法の主張 P_m ·_ℂ Q_m = R_m。 -/
theorem partialOrderedProduct_mul (h11 : (1 : K) * 1 = 1)
    (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c)) (hcomm : ∀ a b : K, a * b = b * a)
    (a b : ℕ → K) :
    ∀ m : ℕ, partialOrderedProduct a m * partialOrderedProduct b m
      = partialOrderedProduct (fun s => a s * b s) m
  | 0 => calc
    partialOrderedProduct a 0 * partialOrderedProduct b 0 = 1 * 1 := rfl
    _ = 1 := h11
    _ = partialOrderedProduct (fun s => a s * b s) 0 := rfl
  | m + 1 => calc
    partialOrderedProduct a (m + 1) * partialOrderedProduct b (m + 1)
        = (partialOrderedProduct a m * a (m + 1)) * (partialOrderedProduct b m * b (m + 1)) := rfl
    _ = partialOrderedProduct a m * (a (m + 1) * (partialOrderedProduct b m * b (m + 1))) := by
        rw [hmassoc]
    _ = partialOrderedProduct a m * ((a (m + 1) * partialOrderedProduct b m) * b (m + 1)) := by
        rw [← hmassoc (a (m + 1))]
    _ = partialOrderedProduct a m * ((partialOrderedProduct b m * a (m + 1)) * b (m + 1)) := by
        rw [hcomm (a (m + 1)) (partialOrderedProduct b m)]
    _ = partialOrderedProduct a m * (partialOrderedProduct b m * (a (m + 1) * b (m + 1))) := by
        rw [hmassoc (partialOrderedProduct b m)]
    _ = (partialOrderedProduct a m * partialOrderedProduct b m) * (a (m + 1) * b (m + 1)) := by
        rw [← hmassoc]
    _ = partialOrderedProduct (fun s => a s * b s) m * (a (m + 1) * b (m + 1)) := by
        rw [partialOrderedProduct_mul h11 hmassoc hcomm a b m]
    _ = partialOrderedProduct (fun s => a s * b s) (m + 1) := rfl

/-- 本文 `claim_product_of_two_ordered_products_in_complex_numbers`：
(Π α_s) ·_ℂ (Π β_s) = Π (α_s ·_ℂ β_s)。 -/
theorem orderedProduct_mul (h11 : (1 : K) * 1 = 1)
    (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c)) (hcomm : ∀ a b : K, a * b = b * a)
    (k : ℕ) (a b : ℕ → K) :
    orderedProduct k a * orderedProduct k b = orderedProduct k (fun s => a s * b s) :=
  partialOrderedProduct_mul h11 hmassoc hcomm a b k

/-- 本文 `claim_ordered_product_with_unit_factors_after_index` の帰納法の主張 P_m = P_r
（m ∈ {r, r+1, …, k}。m = r + d として d についての帰納法）。 -/
theorem partialOrderedProduct_of_unit_factors (hmul1 : ∀ a : K, a * 1 = a) (k r : ℕ) (a : ℕ → K)
    (h1 : ∀ s : ℕ, r < s → s ≤ k → a s = 1) :
    ∀ d : ℕ, r + d ≤ k → partialOrderedProduct a (r + d) = partialOrderedProduct a r
  | 0, _ => rfl
  | d + 1, hd => calc
    partialOrderedProduct a (r + (d + 1))
        = partialOrderedProduct a (r + d) * a (r + d + 1) := rfl
    _ = partialOrderedProduct a (r + d) * 1 := by rw [h1 (r + d + 1) (by omega) (by omega)]
    _ = partialOrderedProduct a (r + d) := by rw [hmul1]
    _ = partialOrderedProduct a r :=
        partialOrderedProduct_of_unit_factors hmul1 k r a h1 d (by omega)

/-- 本文 `claim_ordered_product_with_unit_factors_after_index`：
r < s ≤ k で α_s = 1_ℂ なら Π_{s=1}^{k} α_s = P_r。 -/
theorem orderedProduct_of_unit_factors_after (hmul1 : ∀ a : K, a * 1 = a) (k r : ℕ) (hrk : r ≤ k) (a : ℕ → K)
    (h1 : ∀ s : ℕ, r < s → s ≤ k → a s = 1) :
    orderedProduct k a = partialOrderedProduct a r := by
  have h := partialOrderedProduct_of_unit_factors hmul1 k r a h1 (k - r) (by omega)
  rw [Nat.add_sub_cancel' hrk] at h
  exact h

/-- 本文 `claim_ordered_product_with_zero_factor_is_zero`：α_r = 0_ℂ なら Π α_s = 0_ℂ。
本文どおり、α'_s := α_s（s ≠ r）、α'_r := 1_ℂ と置き、スカラー倍の主張を λ := 0_ℂ で当てる。 -/
theorem orderedProduct_of_zero_factor [Zero K] (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (hzero_central : ∀ a : K, a * 0 = 0 * a) (hzero_mul : ∀ a : K, 0 * a = 0) (k r : ℕ) (hr1 : 1 ≤ r) (hrk : r ≤ k) (a : ℕ → K)
    (hr : a r = 0) : orderedProduct k a = 0 := by
  -- α'_s
  let a' : ℕ → K := fun s => if s = r then 1 else a s
  have hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → a s = a' s := by
    intro s _ _ hs
    show a s = if s = r then 1 else a s
    rw [if_neg hs]
  have hα : a r = 0 * a' r := calc
    a r = 0 := hr
    _ = 0 * 1 := by rw [hzero_mul]
    _ = 0 * a' r := by
        show (0 : K) * 1 = 0 * (if r = r then 1 else a r)
        rw [if_pos rfl]
  calc orderedProduct k a = 0 * orderedProduct k a' :=
        orderedProduct_smul_in_one_factor hmassoc k r hr1 hrk 0 hzero_central a a' hne hα
    _ = 0 := by rw [hzero_mul]

end CliffordMatrixIsomorphism.NecSuf
