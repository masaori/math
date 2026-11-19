/-
「有限個の変数の多項式の点での値」「末尾の値を分けると基本対称式の値は二つの和になる」
「一次因子の積の係数は根の基本対称式の値に符号を付けたものである」の必要十分版。

点での値: 係数環 `R` の可換半環上の多変数多項式から `R` への代入であればよい。
末尾の分割: 具体版の証明が使うのは、有限和の分割・再添字付け、有限積から一つの因子を取り出すこと、
分配則だけである。使うのは可換半環で、減法（加法の逆元）も逆元も代数閉性も使わない。
有限積を並べ方によらず定めるために積の可換性は要る（`Finset.prod` が `CommMonoid` を要求する）。
一次因子の積の係数: 一次因子 `t - ŵ` を作るために加法の逆元が要るので可換環である。
体であること（逆元）も、零因子が無いことも、代数閉性も使わない。
-/
import Mathlib.RingTheory.MvPolynomial.Basic
import Mathlib.Algebra.Polynomial.Coeff
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorProductCoeffBound

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

/-- 具体版 `qbarMvValue_elementarySymmetric` と同じく、値が和と積を保つことで部分集合の和に開く。 -/
theorem mvValue_elementarySymmetric_necSuf {R : Type*} [CommSemiring R] {n : ℕ} (α : Fin n → R)
    (j : ℕ) :
    MvPolynomial.aeval α
        (∑ S ∈ Finset.powersetCard j (Finset.univ : Finset (Fin n)), ∏ k ∈ S, (X k : MvPolynomial (Fin n) R))
      = ∑ S ∈ Finset.powersetCard j (Finset.univ : Finset (Fin n)), ∏ k ∈ S, α k := by
  simp [map_sum, map_prod]

/-- 具体版と同じ段（末尾を含まない部分集合と含む部分集合への分割、`T ↦ T ∪ {n}` の単射、
有限積からの因子の取り出し、分配則）で示す。 -/
theorem elementarySymmetricValue_last_split_necSuf {R : Type*} [CommSemiring R] {n : ℕ}
    (α : Fin (n + 1) → R) (j : ℕ) :
    ∑ S ∈ Finset.powersetCard (j + 1) (Finset.univ : Finset (Fin (n + 1))), ∏ k ∈ S, α k
      = ∑ S ∈ Finset.powersetCard (j + 1) (Finset.univ : Finset (Fin n)), ∏ k ∈ S, α (Fin.castSucc k)
        + α (Fin.last n) * ∑ S ∈ Finset.powersetCard j (Finset.univ : Finset (Fin n)),
            ∏ k ∈ S, α (Fin.castSucc k) := by
  have huniv : (Finset.univ : Finset (Fin (n + 1)))
      = insert (Fin.last n) ((Finset.univ : Finset (Fin n)).map Fin.castSuccEmb) := by
    ext k
    simp only [Finset.mem_univ, Finset.mem_insert, Finset.mem_map, Fin.castSuccEmb_apply, true_and,
      true_iff]
    rcases Fin.eq_castSucc_or_eq_last k with ⟨i, rfl⟩ | rfl
    · exact Or.inr ⟨i, rfl⟩
    · exact Or.inl rfl
  have hnot : Fin.last n ∉ (Finset.univ : Finset (Fin n)).map Fin.castSuccEmb := by
    simp [Fin.castSucc_ne_last]
  rw [huniv, Finset.powersetCard_succ_insert hnot]
  rw [Finset.sum_union]
  · rw [Finset.sum_image]
    · rw [Finset.powersetCard_map, Finset.powersetCard_map, Finset.sum_map, Finset.sum_map,
        Finset.mul_sum]
      congr 1
      · refine Finset.sum_congr rfl ?_
        intro T _
        simp [Finset.prod_map]
      · refine Finset.sum_congr rfl ?_
        intro T _
        have hT : Fin.last n ∉ T.map Fin.castSuccEmb := by
          simp [Fin.castSucc_ne_last]
        change ∏ k ∈ insert (Fin.last n) (T.map Fin.castSuccEmb), α k = _
        rw [Finset.prod_insert hT, Finset.prod_map]
        rfl
    · intro T hT T' hT' hTT'
      have h1 : Fin.last n ∉ T := fun h =>
        hnot (Finset.mem_powersetCard.mp hT |>.1 h)
      have h2 : Fin.last n ∉ T' := fun h =>
        hnot (Finset.mem_powersetCard.mp hT' |>.1 h)
      have := congrArg (fun S => Finset.erase S (Fin.last n)) hTT'
      simpa [Finset.erase_insert h1, Finset.erase_insert h2] using this
  · rw [Finset.disjoint_left]
    intro S hS hS'
    obtain ⟨T, _, rfl⟩ := Finset.mem_image.mp hS'
    exact hnot ((Finset.mem_powersetCard.mp hS).1 (Finset.mem_insert_self _ _))

/-- 具体版と同じく `n` の帰納法で、一歩を `j = 0`、`1 ≤ j ≤ n`、`j = n+1` に分けて示す。
係数の上界は `poly_linear_factor_product_coeff_bound_necSuf`（可換環）から取る。 -/
theorem linearFactorProduct_coeff_elementarySymmetric_necSuf {R : Type*} [CommRing R] (w : ℕ → R) :
    ∀ n j : ℕ, j ≤ n →
      (∏ i ∈ Finset.range n, (Polynomial.X - Polynomial.C (w i))).coeff (n - j)
        = (-1) ^ j * ∑ S ∈ Finset.powersetCard j (Finset.univ : Finset (Fin n)), ∏ k ∈ S, w k := by
  intro n
  induction n with
  | zero =>
      intro j hj
      have hj0 : j = 0 := Nat.le_zero.mp hj
      subst hj0
      simp
  | succ n ih =>
      intro j hj
      rw [Finset.prod_range_succ]
      rcases Nat.eq_zero_or_pos j with rfl | hjpos
      · rw [Nat.sub_zero, Polynomial.coeff_mul_X_sub_C,
          Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_linear_factor_product_coeff_bound_necSuf w n
            (n + 1) (Nat.lt_succ_self n), zero_mul, sub_zero]
        have h0 := ih 0 (Nat.zero_le n)
        rw [Nat.sub_zero] at h0
        rw [h0]
        simp
      · obtain ⟨i, rfl⟩ : ∃ i, j = i + 1 := ⟨j - 1, by omega⟩
        have hsplit := elementarySymmetricValue_last_split_necSuf (fun k : Fin (n + 1) => w k) i
        simp only [Fin.val_castSucc, Fin.val_last] at hsplit
        rcases Nat.lt_or_ge i n with hin | hin
        · have hsub : n + 1 - (i + 1) = (n - (i + 1)) + 1 := by omega
          have hsub' : n - (i + 1) + 1 = n - i := by omega
          rw [hsub, Polynomial.coeff_mul_X_sub_C, hsub', ih (i + 1) (by omega), ih i (by omega), hsplit]
          ring
        · have hin' : i = n := by omega
          subst hin'
          rw [Nat.sub_self, Polynomial.mul_coeff_zero]
          have h0 := ih i le_rfl
          rw [Nat.sub_self] at h0
          have hempty : Finset.powersetCard (i + 1) (Finset.univ : Finset (Fin i)) = ∅ :=
            Finset.powersetCard_eq_empty.mpr (by simp)
          have hlin : (Polynomial.X - Polynomial.C (w i)).coeff 0 = -w i := by simp
          rw [h0, hsplit, hempty, Finset.sum_empty, zero_add, hlin]
          ring

end Ising2DLambda.NecSuf.FisherZero
