/-
節「根の対の整数倍のずらしの基本対称式」の二つの主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.pairShiftElementarySymmetric_isQbarSymmetric`・
`pairShiftElementarySymmetric_mem_subfieldCoefficientMvPolys`）と同じ段
（対の集合の全単射、番号の全単射、各値の付け替え、代入の合成を二回、基本対称式の不変性／
値の係数、展開した有限和の各項）で示し、各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `K` でよい。体であること・零因子が無いこと・符号反転はどの段でも使わない。
  積の可換性は、`ϱ(j) < ϱ(i)` のときに `X_{ϱ(i)} X_{ϱ(j)} = X_{ϱ(j)} X_{ϱ(i)}` と並べ替える段で使う
  （和の可換性も同じ段）。
- 根の番号の集合 `σ` は全順序でよく、有限でなくてよい。全順序は対を `(min, max)` に並べる段で使う。
  `ϱ` が単射であることは `ϱ(i) ≠ ϱ(j)`（`min < max`）に、逆写像を持つことは対の写像の逆写像に使う。
- 対の番号の集合 `ι` は有限であることを使う（基本対称式が全ての `k` 元部分集合の和であること、
  代入の合成で全変数の有限積に展開する段）。具体版の `ι = ℕ_{<N}` と同じ個数であることは使わない。
- 係数の主張では、部分体 `F` の代わりに部分集合 `S ⊆ K` を置く。使うのは零元・単位元を含むこと、
  和と積で閉じること、ずらしの倍数 `c` を含むことだけで、逆元で閉じていることは使わない。
-/
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionSymmetric
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionSubfieldCoefficient

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommSemiring K]

/-- 根の番号の対の集合 `{(i,j) | i < j}`（具体版の `RootIndexPair d` の一般化）。 -/
abbrev OrderedPair (σ : Type) [LinearOrder σ] : Type := {p : σ × σ // p.1 < p.2}

/-- 具体版の `pairShiftValues` の一般化。`π(r) = (i,j)` に `X_i + X_j + C(c) X_i X_j`。 -/
noncomputable def pairShiftValuesNecSuf {σ ι : Type} [LinearOrder σ] (c : K)
    (π : ι ≃ OrderedPair σ) : ι → MvPolynomial σ K :=
  fun r => X (π r).1.1 + X (π r).1.2 + C c * X (π r).1.1 * X (π r).1.2

/-- 第一の準備の写像 `σ_ϱ(i,j) = (min(ϱ(i),ϱ(j)), max(ϱ(i),ϱ(j)))`。 -/
def orderedPairPermFun {σ : Type} [LinearOrder σ] (ϱ : σ ≃ σ) (p : OrderedPair σ) :
    OrderedPair σ :=
  ⟨(min (ϱ p.1.1) (ϱ p.1.2), max (ϱ p.1.1) (ϱ p.1.2)),
    min_lt_max.mpr (fun h => (ne_of_lt p.2) (ϱ.injective h))⟩

/-- 第一の準備: `σ_{ϱ^{-1}}(σ_ϱ(p)) = p`。 -/
theorem orderedPairPermFun_symm {σ : Type} [LinearOrder σ] (ϱ : σ ≃ σ) (p : OrderedPair σ) :
    orderedPairPermFun ϱ.symm (orderedPairPermFun ϱ p) = p := by
  obtain ⟨⟨i, j⟩, hij⟩ := p
  apply Subtype.ext
  simp only [orderedPairPermFun]
  rcases lt_or_ge (ϱ i) (ϱ j) with h | h
  · rw [min_eq_left h.le, max_eq_right h.le]
    simp only [Equiv.symm_apply_apply]
    rw [min_eq_left hij.le, max_eq_right hij.le]
  · rw [min_eq_right h, max_eq_left h]
    simp only [Equiv.symm_apply_apply]
    rw [min_eq_right hij.le, max_eq_left hij.le]

/-- 第一の準備: `σ_ϱ` は対の集合の全単射。 -/
def orderedPairPerm {σ : Type} [LinearOrder σ] (ϱ : σ ≃ σ) : OrderedPair σ ≃ OrderedPair σ where
  toFun := orderedPairPermFun ϱ
  invFun := orderedPairPermFun ϱ.symm
  left_inv := orderedPairPermFun_symm ϱ
  right_inv := by
    intro p
    have h := orderedPairPermFun_symm ϱ.symm p
    rwa [Equiv.symm_symm] at h

/-- 第三の準備: `ϱ` による変数の付け替えは `y(r)` を `y(τ_ϱ(r))` へ送る
（`τ_ϱ = π^{-1} ∘ σ_ϱ ∘ π`）。 -/
theorem aeval_perm_pairShiftValues_necSuf {σ ι : Type} [LinearOrder σ] (c : K)
    (π : ι ≃ OrderedPair σ) (ϱ : σ ≃ σ) (r : ι) :
    aeval (fun k => (X (ϱ k) : MvPolynomial σ K)) (pairShiftValuesNecSuf c π r) =
      pairShiftValuesNecSuf c π (π.trans ((orderedPairPerm ϱ).trans π.symm) r) := by
  have hπ : π (π.trans ((orderedPairPerm ϱ).trans π.symm) r) = orderedPairPermFun ϱ (π r) := by
    simp [orderedPairPerm]
  have hlhs : aeval (fun k => (X (ϱ k) : MvPolynomial σ K)) (pairShiftValuesNecSuf c π r) =
      X (ϱ (π r).1.1) + X (ϱ (π r).1.2) + C c * X (ϱ (π r).1.1) * X (ϱ (π r).1.2) := by
    have hC : aeval (fun k => (X (ϱ k) : MvPolynomial σ K)) (C c) = C c := by
      rw [← algebraMap_eq]
      exact AlgHom.commutes _ _
    simp only [pairShiftValuesNecSuf, map_add, map_mul, hC, aeval_X]
  rw [hlhs, pairShiftValuesNecSuf, hπ]
  simp only [orderedPairPermFun]
  rcases le_total (ϱ (π r).1.1) (ϱ (π r).1.2) with h | h
  · rw [min_eq_left h, max_eq_right h]
  · rw [min_eq_right h, max_eq_left h]
    ring

/-- `claim_pair_shift_elementary_symmetric_is_symmetric` の必要十分版（具体版と同じ段）。 -/
theorem pairShiftElementarySymmetric_equivInvariant_necSuf {σ ι : Type} [LinearOrder σ]
    [Fintype ι] [DecidableEq ι] (c : K) (π : ι ≃ OrderedPair σ) (ϱ : σ ≃ σ) (k : ℕ) :
    aeval (fun i => (X (ϱ i) : MvPolynomial σ K))
        (aeval (pairShiftValuesNecSuf c π)
          (∑ T ∈ Finset.powersetCard k (Finset.univ : Finset ι), ∏ r ∈ T, (X r : MvPolynomial ι K))) =
      aeval (pairShiftValuesNecSuf c π)
        (∑ T ∈ Finset.powersetCard k (Finset.univ : Finset ι), ∏ r ∈ T, (X r : MvPolynomial ι K)) := by
  set τ : ι ≃ ι := π.trans ((orderedPairPerm ϱ).trans π.symm)
  set E := ∑ T ∈ Finset.powersetCard k (Finset.univ : Finset ι), ∏ r ∈ T, (X r : MvPolynomial ι K)
  calc aeval (fun i => (X (ϱ i) : MvPolynomial σ K)) (aeval (pairShiftValuesNecSuf c π) E)
      -- 第二の等号: 代入の合成。
      = aeval (fun r => aeval (fun i => (X (ϱ i) : MvPolynomial σ K))
          (pairShiftValuesNecSuf c π r)) E := mvSubst_comp_necSuf _ _ _
    -- 第三の等号: 第三の準備。
    _ = aeval (fun r => pairShiftValuesNecSuf c π (τ r)) E := by
        exact congrArg (fun y => aeval y E)
          (funext fun r => aeval_perm_pairShiftValues_necSuf c π ϱ r)
    -- 第四の等号: 変数の値。
    _ = aeval (fun r => aeval (pairShiftValuesNecSuf c π) (X (τ r) : MvPolynomial ι K)) E := by
        exact congrArg (fun y => aeval y E) (funext fun r => (aeval_X _ _).symm)
    -- 第五の等号: 代入の合成を逆に。
    _ = aeval (pairShiftValuesNecSuf c π) (aeval (fun r => (X (τ r) : MvPolynomial ι K)) E) :=
        (mvSubst_comp_necSuf _ _ _).symm
    -- 第六・第七の等号: 基本対称式の不変性。
    _ = aeval (pairShiftValuesNecSuf c π) E := by
        rw [elementarySymmetric_equivInvariant_necSuf τ k]

/-- `claim_pair_shift_elementary_symmetric_subfield_coefficient` の必要十分版（具体版と同じ段）。 -/
theorem pairShiftElementarySymmetric_mem_coeffIn_necSuf {S : Set K} {σ ι : Type} [LinearOrder σ]
    [Fintype ι] (h0 : (0 : K) ∈ S) (h1 : (1 : K) ∈ S)
    (hadd : ∀ x y : K, x ∈ S → y ∈ S → x + y ∈ S) (hmul : ∀ x y : K, x ∈ S → y ∈ S → x * y ∈ S)
    {c : K} (hc : c ∈ S) (π : ι ≃ OrderedPair σ) (k : ℕ) :
    aeval (pairShiftValuesNecSuf c π)
        (∑ T ∈ Finset.powersetCard k (Finset.univ : Finset ι), ∏ r ∈ T, (X r : MvPolynomial ι K)) ∈
      coeffIn S σ := by
  set E := ∑ T ∈ Finset.powersetCard k (Finset.univ : Finset ι), ∏ r ∈ T, (X r : MvPolynomial ι K)
  -- 二元の積と冪、二元の和。
  have hmul2 : ∀ A B : MvPolynomial σ K, A ∈ coeffIn S σ → B ∈ coeffIn S σ →
      A * B ∈ coeffIn S σ := fun A B hA hB => by
    have h := prod_mem_coeffIn_necSuf h0 h1 hadd hmul (Finset.univ : Finset (Fin 2)) ![A, B]
      (fun i _ => by fin_cases i <;> simpa)
    rwa [Fin.prod_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one,
      Matrix.cons_val_fin_one] at h
  have hpow : ∀ A : MvPolynomial σ K, A ∈ coeffIn S σ → ∀ e : ℕ, A ^ e ∈ coeffIn S σ :=
    fun A hA e => by
      have h := prod_mem_coeffIn_necSuf h0 h1 hadd hmul (Finset.range e) (fun _ => A)
        (fun _ _ => hA)
      rwa [Finset.prod_const, Finset.card_range] at h
  have hadd2 : ∀ A B : MvPolynomial σ K, A ∈ coeffIn S σ → B ∈ coeffIn S σ →
      A + B ∈ coeffIn S σ := fun A B hA hB => by
    have h := sum_mem_coeffIn_necSuf h0 hadd (Finset.univ : Finset (Fin 2)) ![A, B]
      (fun i _ => by fin_cases i <;> simpa)
    rwa [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one,
      Matrix.cons_val_fin_one] at h
  -- 第一の準備: y(r) ∈ S[X]。
  have hy : ∀ r, pairShiftValuesNecSuf c π r ∈ coeffIn S σ := fun r => by
    have hi := X_mem_coeffIn_necSuf (R := K) (σ := σ) h0 h1 (π r).1.1
    have hj := X_mem_coeffIn_necSuf (R := K) (σ := σ) h0 h1 (π r).1.2
    exact hadd2 _ _ (hadd2 _ _ hi hj) (hmul2 _ _ (hmul2 _ _ (C_mem_coeffIn_necSuf h0 hc) hi) hj)
  -- 基本対称式の係数。
  have hes : E ∈ coeffIn S ι := elementarySymmetric_mem_coeffIn_necSuf h0 h1 hadd hmul k
  -- T_a ∈ S[X]。
  have hT : ∀ a ∈ E.support, C (coeff a E) * ∏ r, pairShiftValuesNecSuf c π r ^ a r ∈
      coeffIn S σ := fun a _ =>
    hmul2 _ _ (C_mem_coeffIn_necSuf h0 (hes a))
      (prod_mem_coeffIn_necSuf h0 h1 hadd hmul Finset.univ _ (fun r _ => hpow _ (hy r) (a r)))
  have hexp : aeval (pairShiftValuesNecSuf c π) E =
      ∑ a ∈ E.support, C (coeff a E) * ∏ r, pairShiftValuesNecSuf c π r ^ a r := by
    rw [aeval_def, eval₂_eq', algebraMap_eq]
  rw [hexp]
  exact sum_mem_coeffIn_necSuf h0 hadd E.support _ hT

end Ising2DLambda.NecSuf.FisherZero
