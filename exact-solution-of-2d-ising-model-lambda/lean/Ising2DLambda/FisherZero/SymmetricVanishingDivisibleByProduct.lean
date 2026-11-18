/-
節「部分体を係数とする多変数多項式と全次数」の具体版。

  人手証明                                                          このファイル
  定義 `def_subfield_coefficient_multivariate_polynomials`          `subfieldCoefficientMvPolys`
  定義 `def_qbar_multivariate_total_degree`                         `exponentTotal`・`qbarTotalDegree`
    最大元の三つの性質                                              `exponentTotal_le_qbarTotalDegree`・
                                                                    `qbarTotalDegree_le_of_forall`・
                                                                    `exists_eq_qbarTotalDegree`
  主張 `claim_qbar_all_ones_shift_subfield_coefficient`             `allOnesShift_mem_subfieldCoefficientMvPolys`
  主張 `claim_symmetric_vanishing_last_variable_shift_total_degree` `symmetricVanishing_allOnesShift_totalDegree`
    第一の準備（sz(d + 1) = sz(d) + (n+1)。六つの等号）             `exponentTotal_add_allOnes`
    第二の準備（c が台にあれば 1 ≤ c、c - 1 は商の台にある）        `symmetricVanishing_support_shift`
    第三の準備（d が商の台にあれば d + 1 は P の台にある）          `allOnesShift_support_unshift`
    上からの評価・下からの評価                                      同じ名前の `have`
  主張 `claim_symmetric_vanishing_last_variable_divisible_by_product`
                                                                    `symmetricVanishing_divisible_by_elementarySymmetric`

本文の全次数 `max({0} ∪ {sz(a) | a ∈ spt(P)})` は、台 `P.support` の上の `Finset.sup`
（空集合の上限は `ℕ` の最小元 `0`）で書く。

住処: Qbar（全次数と指数の総和は ℕ）。R / C は現れない。
-/
import Ising2DLambda.FisherZero.AllOnesShiftSymmetry

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_subfield_coefficient_multivariate_polynomials` の具体版。全ての係数が `F` に属する元の全体 `F[X_{<n}]`。 -/
def subfieldCoefficientMvPolys (F : Subfield Qbar) (n : ℕ) : Set (QbarMvPoly n) :=
  {P | ∀ a : Fin n →₀ ℕ, coeff a P ∈ F}

/-- `def_qbar_multivariate_total_degree` の指数の総和 `sz_n(a)`。 -/
def exponentTotal {n : ℕ} (a : Fin n →₀ ℕ) : ℕ :=
  ∑ k, a k

/-- `def_qbar_multivariate_total_degree` の全次数 `tdeg_n(P)`。 -/
noncomputable def qbarTotalDegree {n : ℕ} (P : QbarMvPoly n) : ℕ :=
  P.support.sup exponentTotal

/-- `def_qbar_multivariate_total_degree` の最大元の性質の一つ目。台の元の指数の総和は全次数以下。 -/
theorem exponentTotal_le_qbarTotalDegree {n : ℕ} (P : QbarMvPoly n) (a : Fin n →₀ ℕ)
    (ha : coeff a P ≠ 0) : exponentTotal a ≤ qbarTotalDegree P :=
  Finset.le_sup (mem_support_iff.mpr ha)

/-- `def_qbar_multivariate_total_degree` の最大元の性質の二つ目。台の全ての元で総和が `m` 以下なら全次数も `m` 以下。 -/
theorem qbarTotalDegree_le_of_forall {n : ℕ} (P : QbarMvPoly n) (m : ℕ)
    (h : ∀ a : Fin n →₀ ℕ, coeff a P ≠ 0 → exponentTotal a ≤ m) : qbarTotalDegree P ≤ m :=
  Finset.sup_le fun a ha => h a (mem_support_iff.mp ha)

/-- `def_qbar_multivariate_total_degree` の最大元の性質の三つ目。台が空でなければ、全次数はある台の元の総和である。 -/
theorem exists_eq_qbarTotalDegree {n : ℕ} (P : QbarMvPoly n) (a₀ : Fin n →₀ ℕ) (ha₀ : coeff a₀ P ≠ 0) :
    ∃ a : Fin n →₀ ℕ, coeff a P ≠ 0 ∧ qbarTotalDegree P = exponentTotal a := by
  obtain ⟨a, ha, heq⟩ := Finset.exists_mem_eq_sup P.support ⟨a₀, mem_support_iff.mpr ha₀⟩ exponentTotal
  exact ⟨a, mem_support_iff.mp ha, heq⟩

/-- `claim_qbar_all_ones_shift_subfield_coefficient` の具体版。`P ∈ F[X_{<n}]` なら `sd_n(P) ∈ F[X_{<n}]`。 -/
theorem allOnesShift_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ} (P : QbarMvPoly n)
    (hP : P ∈ subfieldCoefficientMvPolys F n) : allOnesShift P ∈ subfieldCoefficientMvPolys F n := by
  intro d
  -- mco_d(sd_n(P)) = mco_{d+1_n}(P) ∈ F。
  rw [allOnesShift_coeff]
  exact hP (d + allOnesExponent n)

/-- `claim_symmetric_vanishing_last_variable_shift_total_degree` の第一の準備。`sz(d + 1) = sz(d) + (n+1)`。 -/
theorem exponentTotal_add_allOnes {n : ℕ} (d : Fin (n + 1) →₀ ℕ) :
    exponentTotal (d + allOnesExponent (n + 1)) = exponentTotal d + (n + 1) := by
  calc exponentTotal (d + allOnesExponent (n + 1))
      -- 第一の等号: sz の定義。
      = ∑ k, (d + allOnesExponent (n + 1)) k := rfl
      -- 第二の等号: 指数の和。
    _ = ∑ k, (d k + allOnesExponent (n + 1) k) :=
        Finset.sum_congr rfl fun k _ => Finsupp.add_apply _ _ _
      -- 第三の等号: 1_{n+1}(k) = 1。
    _ = ∑ k : Fin (n + 1), (d k + 1) :=
        Finset.sum_congr rfl fun k _ => by rw [allOnesExponent_apply]
      -- 第四の等号: ℕ の有限和は項ごとの和に分かれる。
    _ = ∑ k, d k + ∑ _k : Fin (n + 1), 1 := Finset.sum_add_distrib
      -- 第五の等号: sz の定義。
    _ = exponentTotal d + ∑ _k : Fin (n + 1), 1 := rfl
      -- 第六の等号: ℕ_{<n+1} の元は n+1 個。
    _ = exponentTotal d + (n + 1) := by
        rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul, mul_one]

/-- `claim_symmetric_vanishing_last_variable_shift_total_degree` の第二の準備。
`c` が `P` の台にあれば `1 ≤ c` で、`c - 1` は `sd(P)` の台にある。 -/
theorem symmetricVanishing_support_shift {n : ℕ} (P : QbarMvPoly (n + 1))
    (hsym : IsQbarSymmetric P) (hlz : lastVariableZero n P = 0) (c : Fin (n + 1) →₀ ℕ)
    (hc : coeff c P ≠ 0) :
    allOnesExponent (n + 1) ≤ c ∧ coeff (c - allOnesExponent (n + 1)) (allOnesShift P) ≠ 0 := by
  -- 1 ≤ c でなければ c(k) = 0 の k があり、mco_c(P) = 0 となって矛盾する。
  have hle : allOnesExponent (n + 1) ≤ c := by
    by_contra h
    obtain ⟨k, hk⟩ := exists_eq_zero_of_not_allOnes_le c h
    exact hc (symmetricVanishing_coeff_eq_zero P hsym hlz c k hk)
  refine ⟨hle, ?_⟩
  have heq : coeff (c - allOnesExponent (n + 1)) (allOnesShift P) = coeff c P :=
    calc coeff (c - allOnesExponent (n + 1)) (allOnesShift P)
        -- 第一の等号: 指数を一つ下げた多項式の係数。
        = coeff (c - allOnesExponent (n + 1) + allOnesExponent (n + 1)) P := allOnesShift_coeff _ _
        -- 第二の等号: (c - 1) + 1 = c。
      _ = coeff c P := by rw [tsub_add_cancel_of_le hle]
  -- 最後の行: c は台にある。
  rw [heq]
  exact hc

/-- `claim_symmetric_vanishing_last_variable_shift_total_degree` の第三の準備。
`d` が `sd(P)` の台にあれば `d + 1` は `P` の台にある。 -/
theorem allOnesShift_support_unshift {n : ℕ} (P : QbarMvPoly n) (d : Fin n →₀ ℕ)
    (hd : coeff d (allOnesShift P) ≠ 0) : coeff (d + allOnesExponent n) P ≠ 0 := by
  rw [← allOnesShift_coeff]
  exact hd

/-- `claim_symmetric_vanishing_last_variable_shift_total_degree` の具体版。
対称で `lz_n(P) = 0`、`P ≠ 0` なら `tdeg(sd(P)) + (n+1) = tdeg(P)`。 -/
theorem symmetricVanishing_allOnesShift_totalDegree {n : ℕ} (P : QbarMvPoly (n + 1))
    (hsym : IsQbarSymmetric P) (hlz : lastVariableZero n P = 0) (hP : P ≠ 0) :
    qbarTotalDegree (allOnesShift P) + (n + 1) = qbarTotalDegree P := by
  -- 上からの評価: tdeg(P) ≤ tdeg(sd(P)) + (n+1)。
  have hupper : qbarTotalDegree P ≤ qbarTotalDegree (allOnesShift P) + (n + 1) := by
    apply qbarTotalDegree_le_of_forall
    intro c hc
    obtain ⟨hle, hd⟩ := symmetricVanishing_support_shift P hsym hlz c hc
    calc exponentTotal c
        -- 第一の行: (c - 1) + 1 = c。
        = exponentTotal (c - allOnesExponent (n + 1) + allOnesExponent (n + 1)) := by
          rw [tsub_add_cancel_of_le hle]
        -- 第二の行: 第一の準備。
      _ = exponentTotal (c - allOnesExponent (n + 1)) + (n + 1) := exponentTotal_add_allOnes _
        -- 第三の行: c - 1 は商の台にある。
      _ ≤ qbarTotalDegree (allOnesShift P) + (n + 1) :=
          Nat.add_le_add_right (exponentTotal_le_qbarTotalDegree _ _ hd) _
  -- 下からの評価: tdeg(sd(P)) + (n+1) ≤ tdeg(P)。
  have hlower : qbarTotalDegree (allOnesShift P) + (n + 1) ≤ qbarTotalDegree P := by
    -- P ≠ 0 なので台の元 c₀ があり、c₀ - 1 は商の台にある。
    obtain ⟨c₀, hc₀⟩ := MvPolynomial.ne_zero_iff.mp hP
    obtain ⟨d, hd, hdeq⟩ := exists_eq_qbarTotalDegree (allOnesShift P) _
      (symmetricVanishing_support_shift P hsym hlz c₀ hc₀).2
    calc qbarTotalDegree (allOnesShift P) + (n + 1)
        -- 第一の行: d_* の取り方。
        = exponentTotal d + (n + 1) := by rw [hdeq]
        -- 第二の行: 第一の準備。
      _ = exponentTotal (d + allOnesExponent (n + 1)) := (exponentTotal_add_allOnes d).symm
        -- 第三の行: 第三の準備と最大元の性質。
      _ ≤ qbarTotalDegree P :=
          exponentTotal_le_qbarTotalDegree P _ (allOnesShift_support_unshift P d hd)
  exact le_antisymm hlower hupper

/-- `claim_symmetric_vanishing_last_variable_divisible_by_product` の具体版。
`Q := sd_{n+1}(P)` が、`F` 係数・対称・`P = es_{n+1,n+1} · Q`・全次数の等式を満たす。 -/
theorem symmetricVanishing_divisible_by_elementarySymmetric (F : Subfield Qbar) {n : ℕ}
    (P : QbarMvPoly (n + 1)) (hF : P ∈ subfieldCoefficientMvPolys F (n + 1))
    (hsym : IsQbarSymmetric P) (hlz : lastVariableZero n P = 0) :
    ∃ Q ∈ subfieldCoefficientMvPolys F (n + 1), IsQbarSymmetric Q ∧
      P = qbarElementarySymmetric (n + 1) (n + 1) * Q ∧
      (P ≠ 0 → qbarTotalDegree Q + (n + 1) = qbarTotalDegree P) :=
  ⟨allOnesShift P, allOnesShift_mem_subfieldCoefficientMvPolys F P hF,
    allOnesShift_isQbarSymmetric P hsym,
    symmetricVanishing_eq_elementarySymmetric_mul_allOnesShift P hsym hlz,
    fun hP => symmetricVanishing_allOnesShift_totalDegree P hsym hlz hP⟩

end Ising2DLambda.FisherZero
