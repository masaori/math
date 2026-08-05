/-
# 命題 W\* の残り 1 件（$\chi$ から相異なる既約因子の族と重複度を取り出す段）— cycle 40 step 1

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の
  「$\chi=\prod_i f_i^{a_i}$ と分解し、$\rho=\mathrm{rad}(\chi)=\prod_i f_i$ とおく」の段

## このファイルが埋めるもの

cycle 39 step 3（`WStarRadicalMultiplicity.lean`）は、相異なるモニックな素元の族 $f_i$ と
重複度 $a_i$ を**受け取って** $\rho=\prod_i f_i$ と $\chi'/h=\sum_i a_i f_i'(\rho/f_i)$ を作り、
そこから $\det G\neq0$ を出した。本文はそうではなく、$\chi$ を先に置いて
$\chi=\prod_i f_i^{a_i}$ と分解し $\rho=\mathrm{rad}(\chi)$ と定義している。
**その族を $\chi$ から取り出す段が、外側に残っていた。**

検査 E（残りを閉じる定理の両端）が「受け取る」と分類していた 3 つの束縛子
（族が素元であること・相異なること・モニックに取れること）は、すべてこの 1 件から出るものである。
本ファイルはその 3 つを $\chi$ から作る。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは一意分解と、先頭係数の可逆性と、次数の比較だけである。

## 書いたこと（3 段）

1. **モニック化**（`monicize`）。素因子の先頭係数は単元なので、その逆数を掛けるとモニックになる。
   もとの元と同伴なので素元であることは保たれる（`monicize_monic` / `associated_monicize` /
   `prime_monicize`）。
2. **モニックな素元は、相異なれば互いに割らない**（`not_dvd_of_ne_of_monic_prime`）。
   割るなら同伴であり、同伴なモニック多項式は等しい。**これが「相異なること」の中身である。**
3. **$\chi$ からの取り出し**（`exists_monic_prime_factorization`）。一意分解の因子をモニック化し、
   同じものを数え上げて重複度にする。$\chi$ と積はどちらもモニックで同伴なので等しい。

仕上げ（`exists_radical_and_multWeight`）で、$\chi$ がモニックで正の次数であることだけから
本文の $\chi=h\rho$ と $\chi'=h\,(\chi'/h)$ の分解、および重み $\chi'/h$ の Gram 行列の行列式が $0$ でないことが出る形にした。
**これで、この重みについての主張は $\chi$ の外に仮定を残さない。**

## モニック化に単元の逆数を使う理由

先頭係数が単元であることは、$\chi$ がモニックで因子が $\chi$ を割ることから出る
（整域では先頭係数が掛け算で乗るので、因子の先頭係数は $1$ を割る）。
体を仮定していないので逆数は一般には取れないが、**単元の逆数だけは取れる。**
本論文が当てるのは $\mathbb{Z}[x]$ で、そこでの単元は $\pm1$ である。

## 形式化しなかったもの

本ファイルを書く途中で、**残っているものの中身が台帳の書いていたものと違うことが分かった。そう書く。**
cycle 39 が `multWeight` と呼んでいたものは $\chi'/h$ であり、本文の記号では $\eta$ である。
本文の $\mu$ は成分ごとに重複度 $a_i$ をとる別の元で、$\eta=\mu\,\rho'(\theta)$ で結ばれる。
したがって本文の $G$（重みが $\mu$ の Gram 行列）についての主張はまだ書かれていない。

* **本文の $\mu$ の構成と $G$ の同定。** 成分ごとに $a_i$ をとる元は $A_\mathbb{Q}$ に住むので、
  $A=\mathbb{Z}[x]/(\rho)$ の中では作れない。
* **$w^*$ の等式を組み立てる段。** 部品（適合基底・$C\,G=M_\eta$・$\det C=\pm1$）は揃っているが、
  $\chi=\chi_T$ について 1 本にまとめた形にはなっていない。
-/
import Mathlib
import IntegrableLattice.WStarRadicalMultiplicity

namespace IntegrableLattice
namespace WStarFactorExtraction

open Polynomial Finset

variable {R : Type*} [CommRing R] [IsDomain R] [UniqueFactorizationMonoid R]

/-! ## 1. モニック化

先頭係数が単元なら、その逆数を掛けてモニックにできる。単元でない場合は何もしない
（全域関数にしておくと、多重集合の像として一気に扱える）。 -/

section Monicize

open Classical in
/-- 先頭係数が単元のとき、その逆数を掛けてモニックにする。

多重集合の像として一気に扱いたいので全域関数にする（単元でなければ何もしない）。
場合分けの判定は古典論理による（`IsUnit` は一般には決定可能でない）。 -/
noncomputable def monicize (g : R[X]) : R[X] :=
  if h : IsUnit g.leadingCoeff then C (↑(h.unit⁻¹) : R) * g else g

theorem monicize_monic {g : R[X]} (h : IsUnit g.leadingCoeff) : (monicize g).Monic := by
  classical
  have hinv : (↑(h.unit⁻¹) : R) * g.leadingCoeff = 1 := h.val_inv_mul
  have hval : monicize g = C (↑(h.unit⁻¹) : R) * g := by
    simp only [monicize, dif_pos h]
  rw [Monic, hval, leadingCoeff_mul, leadingCoeff_C]
  exact hinv

theorem associated_monicize (g : R[X]) : Associated (monicize g) g := by
  classical
  by_cases h : IsUnit g.leadingCoeff
  · -- $C(u^{-1})$ は単元なので、掛けても同伴のままである。
    have hval : monicize g = C (↑(h.unit⁻¹) : R) * g := by
      simp only [monicize, dif_pos h]
    refine ⟨Units.map (C : R →+* R[X]).toMonoidHom h.unit, ?_⟩
    rw [hval]
    simp only [RingHom.toMonoidHom_eq_coe, Units.coe_map, MonoidHom.coe_coe]
    rw [mul_comm (C _) g, mul_assoc, ← map_mul, ← Units.val_mul, inv_mul_cancel, Units.val_one,
      map_one, mul_one]
  · have hval : monicize g = g := by simp only [monicize, dif_neg h]
    rw [hval]

theorem prime_monicize {g : R[X]} (hg : Prime g) : Prime (monicize g) :=
  ((associated_monicize g).symm).prime hg

end Monicize

/-! ## 2. 相異なるモニックな素元は互いに割らない

割るなら同伴であり（素元どうしなので）、**同伴なモニック多項式は等しい**
（`Polynomial.eq_of_monic_of_associated`）。**これが検査 E の 3 つ目の束縛子の中身である。** -/

section Distinct

theorem not_dvd_of_ne_of_monic_prime {p q : R[X]} (hp : Prime p) (hq : Prime q)
    (hpm : p.Monic) (hqm : q.Monic) (hne : p ≠ q) : ¬ p ∣ q := by
  rintro ⟨c, hc⟩
  -- 素元 $q$ を割る非単元 $p$ に対して、相方 $c$ は単元である。
  have hcu : IsUnit c := (hq.irreducible.isUnit_or_isUnit hc).resolve_left hp.not_unit
  have hassoc : Associated p q := ⟨hcu.unit, by rw [hc, hcu.unit_spec]⟩
  exact hne (eq_of_monic_of_associated hpm hqm hassoc)

end Distinct

/-! ## 3. $\chi$ からの取り出し -/

section Extraction

/-- モニックな素元は正の次数を持つ。次数 $0$ のモニック多項式は $1$ で、単元だからである。 -/
theorem natDegree_pos_of_monic_prime {p : R[X]} (hp : Prime p) (hpm : p.Monic) :
    0 < p.natDegree := by
  rcases Nat.eq_zero_or_pos p.natDegree with h | h
  · exact absurd (Polynomial.Monic.natDegree_eq_zero hpm |>.mp h ▸ isUnit_one) hp.not_unit
  · exact h

/-- 多重集合の各元をモニック化しても、積は同伴のままである。 -/
theorem associated_prod_map_monicize (t : Multiset R[X]) :
    Associated (t.map monicize).prod t.prod := by
  induction t using Multiset.induction_on with
  | empty => simp
  | cons a s ih =>
    rw [Multiset.map_cons, Multiset.prod_cons, Multiset.prod_cons]
    exact (associated_monicize a).mul_mul ih

/-- **$\chi$ から相異なるモニックな素元の族と重複度を取り出す。**

本文の $\chi=\prod_i f_i^{a_i}$ である。一意分解の因子をモニック化し、
同じものを数え上げて重複度にする。$\chi$ とその積はどちらもモニックで同伴なので等しい。 -/
theorem exists_monic_prime_factorization (χ : R[X]) (hχ : χ.Monic) (hdeg : 0 < χ.natDegree) :
    ∃ (s : Finset R[X]) (a : R[X] → ℕ),
      s.Nonempty ∧
      (∀ p ∈ s, Prime p) ∧ (∀ p ∈ s, p.Monic) ∧ (∀ p ∈ s, 0 < p.natDegree) ∧
      (∀ p ∈ s, a p ≠ 0) ∧
      (∀ p ∈ s, ∀ q ∈ s, p ≠ q → ¬ p ∣ q) ∧
      χ = ∏ p ∈ s, p ^ a p := by
  classical
  have hne : χ ≠ 0 := hχ.ne_zero
  obtain ⟨t, hprime, hassoc⟩ := UniqueFactorizationMonoid.exists_prime_factors χ hne
  -- 因子はいずれも $\chi$ を割るので、先頭係数は単元である。
  have hdvd : ∀ g ∈ t, g ∣ χ := by
    intro g hg
    exact dvd_trans (Multiset.dvd_prod hg) hassoc.dvd
  have hunit : ∀ g ∈ t, IsUnit g.leadingCoeff := fun g hg => hχ.isUnit_leadingCoeff_of_dvd (hdvd g hg)
  set t' := t.map monicize with ht'
  have hmem : ∀ p ∈ t', ∃ g ∈ t, p = monicize g := by
    intro p hp
    obtain ⟨g, hg, rfl⟩ := Multiset.mem_map.mp hp
    exact ⟨g, hg, rfl⟩
  have ht'monic : ∀ p ∈ t', p.Monic := by
    intro p hp
    obtain ⟨g, hg, rfl⟩ := hmem p hp
    exact monicize_monic (hunit g hg)
  have ht'prime : ∀ p ∈ t', Prime p := by
    intro p hp
    obtain ⟨g, hg, rfl⟩ := hmem p hp
    exact prime_monicize (hprime g hg)
  -- 積は $\chi$ と同伴で、どちらもモニックなので等しい。
  have ht'prodmonic : t'.prod.Monic := by
    have := monic_multiset_prod_of_monic t' id (fun p hp => ht'monic p hp)
    simpa using this
  have hprod : t'.prod = χ :=
    eq_of_monic_of_associated ht'prodmonic hχ ((associated_prod_map_monicize t).trans hassoc)
  refine ⟨t'.toFinset, fun p => t'.count p, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · -- 空なら積が $1$ になり、次数が正であることに反する。
    rcases Multiset.empty_or_exists_mem t' with h | ⟨p, hp⟩
    · rw [h] at hprod
      simp only [Multiset.prod_zero] at hprod
      rw [← hprod] at hdeg
      simp at hdeg
    · exact ⟨p, Multiset.mem_toFinset.mpr hp⟩
  · intro p hp; exact ht'prime p (Multiset.mem_toFinset.mp hp)
  · intro p hp; exact ht'monic p (Multiset.mem_toFinset.mp hp)
  · intro p hp
    exact natDegree_pos_of_monic_prime (ht'prime p (Multiset.mem_toFinset.mp hp))
      (ht'monic p (Multiset.mem_toFinset.mp hp))
  · intro p hp
    exact Multiset.count_ne_zero.mpr (Multiset.mem_toFinset.mp hp)
  · intro p hp q hq hpq
    exact not_dvd_of_ne_of_monic_prime (ht'prime p (Multiset.mem_toFinset.mp hp))
      (ht'prime q (Multiset.mem_toFinset.mp hq)) (ht'monic p (Multiset.mem_toFinset.mp hp))
      (ht'monic q (Multiset.mem_toFinset.mp hq)) hpq
  · rw [← hprod, Finset.prod_multiset_count]

end Extraction

/-! ## 4. 仕上げ: $\chi$ だけから $\det G\neq0$ が出る

cycle 39 step 3 の `det_weightedGram_ne_zero_of_factorization` は族と重複度を受け取っていた。
段 3 がそれを $\chi$ から作るので、**受け取る束縛子は無くなる。** -/

section Capstone

variable [IsIntegrallyClosed R] [CharZero R]

/-- **本文の $\chi=h\rho$・$\chi'=h\mu$ と $\det G\neq0$ を、$\chi$ だけから出す。**

受け取るのは $\chi$ がモニックで正の次数を持つことだけである。
$\rho=\mathrm{rad}(\chi)$（相異なる既約因子の積）と $\mu$（本文の $\chi'/h$）を作り、
$\rho$ が無平方であること・$\mu(\theta)$ が零因子でないこと・$\det G\neq0$ を与える。 -/
theorem exists_radical_and_multWeight (K : Type*) [Field K] [Algebra R K]
    [IsFractionRing R K] [CharZero K] (χ : R[X]) (hχ : χ.Monic) (hdeg : 0 < χ.natDegree) :
    ∃ ρ μ h : R[X],
      ρ.Monic ∧ Squarefree ρ ∧ 0 < ρ.natDegree ∧
      χ = h * ρ ∧ derivative χ = h * μ ∧
      aeval (AdjoinRoot.root ρ) μ ∈ nonZeroDivisors (AdjoinRoot ρ) ∧
      ∀ m : ℕ, ρ.natDegree = m + 1 →
        (EulerDualBasis.weightedGram (R := R) (m := m) (AdjoinRoot.root ρ)
          (aeval (AdjoinRoot.root ρ) μ)).det ≠ 0 := by
  classical
  obtain ⟨s, a, hsne, hprime, hmonic, hdegp, hane, hndvd, hfact⟩ :=
    exists_monic_prime_factorization χ hχ hdeg
  -- 添字型を $s$ の元にとる。
  let ι := {p : R[X] // p ∈ s}
  letI : Fintype ι := FinsetCoe.fintype s
  letI : DecidableEq ι := Classical.decEq ι
  let f : ι → R[X] := fun i => (i : R[X])
  let a' : ι → ℕ := fun i => a (i : R[X])
  have hprime' : ∀ i : ι, Prime (f i) := fun i => hprime i i.2
  have hmonic' : ∀ i : ι, (f i).Monic := fun i => hmonic i i.2
  have hdegp' : ∀ i : ι, 0 < (f i).natDegree := fun i => hdegp i i.2
  have hane' : ∀ i : ι, a' i ≠ 0 := fun i => hane i i.2
  have hndvd' : ∀ i j : ι, i ≠ j → ¬ f i ∣ f j := by
    intro i j hij
    exact hndvd i i.2 j j.2 (fun h => hij (Subtype.ext h))
  have ha1 : ∀ i : ι, 1 ≤ a' i := fun i => Nat.one_le_iff_ne_zero.mpr (hane' i)
  -- $\chi=\prod_i f_i^{a_i}$（添字を付け替えただけ）。
  have hchi : χ = WStarRadical.chi f a' := by
    rw [hfact, WStarRadical.chi]
    exact (Finset.prod_coe_sort s (fun p => p ^ a p)).symm
  refine ⟨WStarRadical.rad f, WStarRadical.multWeight f a', WStarRadical.lower f a', ?_, ?_, ?_,
    ?_, ?_, ?_, ?_⟩
  · exact WStarRadical.rad_monic hmonic'
  · exact WStarRadical.squarefree_rad hprime' hndvd'
  · -- 素元が 1 つはあるので、その次数だけで正になる。
    obtain ⟨p, hp⟩ := hsne
    have hdvd : f ⟨p, hp⟩ ∣ WStarRadical.rad f :=
      Finset.dvd_prod_of_mem _ (mem_univ (⟨p, hp⟩ : ι))
    have hne : WStarRadical.rad f ≠ 0 := (WStarRadical.rad_monic hmonic').ne_zero
    have := Polynomial.natDegree_le_of_dvd hdvd hne
    exact lt_of_lt_of_le (hdegp' ⟨p, hp⟩) this
  · rw [hchi]; exact WStarRadical.chi_eq_lower_mul_rad f ha1
  · rw [hchi]; exact WStarRadical.derivative_chi_eq_lower_mul_multWeight f ha1
  · exact WStarRadical.multWeight_mem_nonZeroDivisors hprime' hndvd' hdegp' hane'
  · intro m hm
    exact WStarRadical.det_weightedGram_ne_zero_of_factorization K hprime' hndvd' hmonic'
      hdegp' hane' hm

end Capstone

/-! ## 5. 当てる先（$\mathbb{Z}$ と転送行列の特性多項式）

段 4 まではモニックで正の次数の $\chi$ を**受け取る**形である。
本文が当てているのは $\chi=\chi_T$（整数行列 $T$ の特性多項式）なので、
**受け取ったものが実在することを、当てる先で確かめておく。**
特性多項式はつねにモニックで、次数は行列の大きさに等しい。 -/

section AppliedToCharpoly

/-- **本文が当てる形。** $\chi=\chi_T$（$T$ は整数行列、$n\ge1$）について、
$\rho=\mathrm{rad}(\chi)$ と $\mu=\chi'/h$ が構成でき、$\det G\neq0$ が出る。

$\mathbb{Z}$ は一意分解整域で整閉であり標数 $0$、その分数体は $\mathbb{Q}$ である。
**受け取る仮定は $n\ge1$（行列が空でないこと）だけになる。** -/
theorem exists_radical_and_multWeight_charpoly {n : ℕ} (hn : 0 < n)
    (T : Matrix (Fin n) (Fin n) ℤ) :
    ∃ ρ μ h : ℤ[X],
      ρ.Monic ∧ Squarefree ρ ∧ 0 < ρ.natDegree ∧
      T.charpoly = h * ρ ∧ derivative T.charpoly = h * μ ∧
      aeval (AdjoinRoot.root ρ) μ ∈ nonZeroDivisors (AdjoinRoot ρ) ∧
      ∀ m : ℕ, ρ.natDegree = m + 1 →
        (EulerDualBasis.weightedGram (R := ℤ) (m := m) (AdjoinRoot.root ρ)
          (aeval (AdjoinRoot.root ρ) μ)).det ≠ 0 := by
  haveI : Nonempty (Fin n) := ⟨⟨0, hn⟩⟩
  refine exists_radical_and_multWeight ℚ T.charpoly (Matrix.charpoly_monic T) ?_
  rw [Matrix.charpoly_natDegree_eq_dim]
  simpa using hn

end AppliedToCharpoly

end WStarFactorExtraction
end IntegrableLattice
