/-
人手証明の定義「有限個の変数の多項式の点での値」（ラベル `def_qbar_multivariate_point_value`）、
主張「末尾の値を分けると基本対称式の値は二つの和になる」
（ラベル `claim_point_value_elementary_symmetric_last_split`）、
「一次因子の積の係数は根の基本対称式の値に符号を付けたものである」
（ラベル `claim_linear_factor_product_coefficient_elementary_symmetric`）の具体版。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ElementarySymmetricLastVariableZero
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorProductCoeffBound

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_qbar_multivariate_point_value` の具体版。各変数 `X^{(n)}_k` に `α k` を代入した値 `mev_{n,α}`。 -/
noncomputable def qbarMvValue {n : ℕ} (α : Fin n → Qbar) : QbarMvPoly n →ₐ[Qbar] Qbar :=
  MvPolynomial.aeval α

/-- `mev_{n,α}(es_{n,j}) = Σ_{S ⊆ ℕ_{<n}, |S| = j} ∏_{k ∈ S} α(k)`（値が和と積を保つこと）。 -/
theorem qbarMvValue_elementarySymmetric {n : ℕ} (α : Fin n → Qbar) (j : ℕ) :
    qbarMvValue α (qbarElementarySymmetric n j)
      = ∑ S ∈ Finset.powersetCard j (Finset.univ : Finset (Fin n)), ∏ k ∈ S, α k := by
  simp [qbarMvValue, qbarElementarySymmetric, map_sum, map_prod]

/-- `claim_point_value_elementary_symmetric_last_split` の具体版。
`α' := α ∘ castSucc`（`ℕ_{<n}` への制限）について
`mev_{n+1,α}(es_{n+1,j+1}) = mev_{n,α'}(es_{n,j+1}) + α(n)·mev_{n,α'}(es_{n,j})`。
人手証明の式鎖: 値を部分集合の和に開く → 末尾 `n` を含まない部分集合と含む部分集合に分ける →
前者は `ℕ_{<n}` の部分集合、後者は `T ↦ T ∪ {n}` で `ℕ_{<n}` の `j` 元部分集合と一対一 →
積から `α(n)` を取り出す → 分配則。 -/
theorem qbarMvValue_elementarySymmetric_last_split {n : ℕ} (α : Fin (n + 1) → Qbar) (j : ℕ) :
    qbarMvValue α (qbarElementarySymmetric (n + 1) (j + 1))
      = qbarMvValue (fun k : Fin n => α (Fin.castSucc k)) (qbarElementarySymmetric n (j + 1))
        + α (Fin.last n) * qbarMvValue (fun k : Fin n => α (Fin.castSucc k)) (qbarElementarySymmetric n j) := by
  rw [qbarMvValue_elementarySymmetric, qbarMvValue_elementarySymmetric, qbarMvValue_elementarySymmetric]
  -- ℕ_{<n+1} = ℕ_{<n} の像 ∪ {n}
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
  -- 末尾を含まない部分集合と含む部分集合に分ける（交わらない）
  rw [Finset.sum_union]
  · -- 含む側: T ↦ insert n T は単射
    rw [Finset.sum_image]
    · -- ℕ_{<n} の像の部分集合を ℕ_{<n} の部分集合へ引き戻す
      rw [Finset.powersetCard_map, Finset.powersetCard_map, Finset.sum_map, Finset.sum_map,
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

/-- 一次因子を右から掛けた積の係数（番号が一以上）。`def_qbar_polynomial_ring` の積の係数と
`def_qbar_constant_embedding` の係数。 -/
theorem coeff_mul_linearFactor_succ (C : QbarPoly) (w : Qbar) (k : ℕ) :
    (C * (Polynomial.X - qbarConst w)).coeff (k + 1) = C.coeff k - w * C.coeff (k + 1) := by
  rw [qbarConst, Polynomial.coeff_mul_X_sub_C, mul_comm]

/-- 一次因子を右から掛けた積の番号零の係数。 -/
theorem coeff_mul_linearFactor_zero (C : QbarPoly) (w : Qbar) :
    (C * (Polynomial.X - qbarConst w)).coeff 0 = -(w * C.coeff 0) := by
  rw [Polynomial.mul_coeff_zero, qbarConst]
  simp [mul_comm]

/-- `claim_linear_factor_product_coefficient_elementary_symmetric` の具体版。
`F_n := ∏_{i<n} (t - ŵ(i))`、`w_{<n} : ℕ_{<n} → Qbar` について、`j ≤ n` なら
`ac_{n-j}(F_n) = (-1)^j · mev_{n,w_{<n}}(es_{n,j})`。人手証明と同じく `n` の帰納法で、
一歩は `j = 0`、`1 ≤ j ≤ n`、`j = n+1` の三つの場合に分ける。 -/
theorem linearFactorProduct_coeff_elementarySymmetric (w : ℕ → Qbar) :
    ∀ n j : ℕ, j ≤ n →
      (∏ i ∈ Finset.range n, (Polynomial.X - qbarConst (w i))).coeff (n - j)
        = (-1) ^ j * qbarMvValue (fun k : Fin n => w k) (qbarElementarySymmetric n j) := by
  intro n
  induction n with
  | zero =>
      intro j hj
      have hj0 : j = 0 := Nat.le_zero.mp hj
      subst hj0
      -- ac_0(1) = 1 = (-1)^0 · mev(es_{0,0})、es_{0,0} = 1
      rw [qbarMvValue_elementarySymmetric]
      simp
  | succ n ih =>
      intro j hj
      rw [Finset.prod_range_succ]
      rcases Nat.eq_zero_or_pos j with rfl | hjpos
      · -- j = 0: ac_{n+1}(F_n (t - ŵ(n))) = ac_n(F_n) - w(n)·ac_{n+1}(F_n) = 1 - 0
        rw [Nat.sub_zero, coeff_mul_linearFactor_succ,
          qbarPolyLinearFactorProductCoeffBound w n (n + 1) (Nat.lt_succ_self n), mul_zero, sub_zero]
        have h0 := ih 0 (Nat.zero_le n)
        rw [Nat.sub_zero] at h0
        rw [h0, qbarMvValue_elementarySymmetric, qbarMvValue_elementarySymmetric]
        simp
      · obtain ⟨i, rfl⟩ : ∃ i, j = i + 1 := ⟨j - 1, by omega⟩
        rcases Nat.lt_or_ge i n with hin | hin
        · -- 1 ≤ j ≤ n: ac_{n-i}(F_n (t - ŵ(n))) = ac_{n-(i+1)}(F_n) - w(n)·ac_{n-i}(F_n)
          have hsub : n + 1 - (i + 1) = (n - (i + 1)) + 1 := by omega
          have hsub' : n - (i + 1) + 1 = n - i := by omega
          rw [hsub, coeff_mul_linearFactor_succ, hsub', ih (i + 1) (by omega), ih i (by omega)]
          rw [qbarMvValue_elementarySymmetric_last_split]
          simp only [Fin.val_castSucc, Fin.val_last]
          ring
        · -- j = n+1: ac_0(F_n (t - ŵ(n))) = -w(n)·ac_0(F_n)
          have hin' : i = n := by omega
          subst hin'
          rw [Nat.sub_self, coeff_mul_linearFactor_zero]
          have h0 := ih i le_rfl
          rw [Nat.sub_self] at h0
          rw [h0, qbarMvValue_elementarySymmetric_last_split]
          -- es_{i,i+1} = 0（i 元集合に i+1 元部分集合は無い）
          have hzero : qbarMvValue (fun k : Fin i => w k) (qbarElementarySymmetric i (i + 1)) = 0 := by
            rw [qbarMvValue_elementarySymmetric, Finset.powersetCard_eq_empty.mpr (by simp)]
            simp
          simp only [Fin.val_castSucc, Fin.val_last] at hzero ⊢
          rw [hzero]
          ring

end Ising2DLambda.FisherZero
