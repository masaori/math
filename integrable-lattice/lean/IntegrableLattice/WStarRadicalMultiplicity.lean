/-
# 命題 W\* の残り 2 件（$\rho=\mathrm{rad}(\chi)$ の構成と $\mu$ の構成）— cycle 39 step 3

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の
  $\chi=\prod_i f_i^{a_i}$、$\rho=\mathrm{rad}(\chi)=\prod_i f_i$、
  $\chi'/h=\sum_i a_i f_i'\,\rho/f_i$ の段

## このファイルが埋めるもの

cycle 38 step 1 は「$\rho$ が無平方かつ $\mu$ が零因子でないならば $\det G\neq0$」という
含意を書いた。**その 2 つの仮定はどちらも本文が構成で与えているもの**であり、
台帳はそれを残り 2 件として数えていた。

1. $\rho=\mathrm{rad}(\chi)$（$\chi$ の相異なる既約因子の積）の構成と、それが無平方であること。
2. $\chi'/h=\sum_i a_i f_i'\,\rho/f_i$ の構成と、その $\theta$ での値が零因子でないこと。

**記号の対応について（cycle 40 step 1 の実測で分かったこと。ここは cycle 39 の記述が誤っていた）。**
本ファイルが `multWeight` と呼んでいるものは $\chi'/h$ であり、**本文の記号では $\eta$ である。**
本文の $\mu$ はこれとは別の元で、成分 $K_i=\mathbb{Q}[x]/(f_i)$ ごとに重複度 $a_i$ をとる元であり、
両者は $\eta=\mu\,\rho'(\theta)$ で結ばれる（本文の証明の第 1 段落がそう書いている）。
cycle 39 はこの 2 つを同じものとして書いていた。**したがって本ファイルが $\det G\neq0$ を言っている
$G$ は、重みを $\eta$ にとった Gram 行列であって、本文の $G$（重みは $\mu$）ではない。**
本文の $G$ についての主張は未形式化である。そう書く。

本ファイルはこの 2 つを書く。

## 因子の族を受け取る形にした理由

本文は $\chi=\prod_i f_i^{a_i}$ と**因子分解を明示して書いている**ので、
ここでも相異なる素元の族 $f_i$ と重複度 $a_i$ を受け取る形にした。
mathlib の `radical`（正規化因子の積）を経由しない。理由は 2 つある。

* 人手証明と 1 対 1 に対応させるため。本文が書いているのは族と重複度であって、
  正規化因子ではない。
* $\mu$ の構成には結局その族が要る。$\mu$ は成分ごとに $a_i$ をとる元なので、
  重複度を個別に見ない書き方はできない。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。扱うのは $R[x]$（本論文では $\mathbb{Z}[x]$）の中の
整除と次数の比較だけで、どちらも可算側で決定可能である。

## 書いたこと（4 段）

1. **$\rho$ が無平方でモニックであること**（`squarefree_rad` / `rad_monic`）。
   素元は無平方であり、相異なる素元は互いに素なので、その積も無平方である。
2. **$\chi=h\,\rho$**（`chi_eq_lower_mul_rad`）。$a_i\ge1$ から各因子で $1$ 本ずつ取り出す。
3. **$\chi'=h\,\mu$**（`derivative_chi_eq_lower_mul_multWeight`）。
   本文の $\chi'/h=\sum_i a_i f_i'\,\rho/f_i$ がこれである。
   積の微分公式を当て、各項で $f_i^{a_i-1}$ を括り出すと $h$ が全体から出る。
4. **$\mu(\theta)$ が零因子でないこと**（`multWeight_mem_nonZeroDivisors`）。
   $f_i$ を法にとると $\mu\equiv a_i f_i'\,(\rho/f_i)$ で、
   $f_i$ は $a_i$ にも $f_i'$ にも $f_j\ (j\neq i)$ にも割り切られない。
5. **仕上げ**（`det_weightedGram_ne_zero_of_factorization`）。段 1 と段 4 を
   cycle 38 step 1 の `det_weightedGram_ne_zero_of_squarefree` へ入れる。
   これで $\det G\neq0$ は、族と重複度だけから仮定を残さずに出る。

## 形式化しなかったもの

* **$\chi$ から族 $f_i$ と重複度 $a_i$ を取り出す段は、本ファイルには無い。** 本ファイルは族を
  受け取る形で、$\rho=\prod_i f_i$ をその族から作っている。本文は $\rho=\mathrm{rad}(\chi)$ と
  $\chi$ から定義しているので、一意分解から族を取り出す段（およびモニックな $\chi$ の因子が
  モニックに取れること）が要る。**cycle 39 step 3 の時点ではこれが残りだった。
  cycle 40 step 1 で `WStarFactorExtraction.lean` に書いた**
  （`exists_monic_prime_factorization`）。
-/
import Mathlib
import IntegrableLattice.WStarSquarefreeNonzero

namespace IntegrableLattice
namespace WStarRadical

open Polynomial Finset

variable {R : Type*} [CommRing R] [IsDomain R] [UniqueFactorizationMonoid R]
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- 根基 $\rho=\mathrm{rad}(\chi)=\prod_i f_i$（相異なる既約因子の積）。 -/
noncomputable def rad (f : ι → R[X]) : R[X] := ∏ i, f i

/-- $\chi=\prod_i f_i^{a_i}$。 -/
noncomputable def chi (f : ι → R[X]) (a : ι → ℕ) : R[X] := ∏ i, (f i) ^ (a i)

/-- 本文の $h=\chi/\rho=\prod_i f_i^{a_i-1}$。 -/
noncomputable def lower (f : ι → R[X]) (a : ι → ℕ) : R[X] := ∏ i, (f i) ^ (a i - 1)

/-- 本文の $\chi'/h=\sum_i a_i\,f_i'\,(\rho/f_i)$。

**名前に反して、これは本文の $\mu$ ではない。** その $\theta$ での値が本文の $\eta$ である
（本文の $\mu$ は $\eta=\mu\,\rho'(\theta)$ で結ばれる別の元で、`WStarMuGram.mu` に書いた）。
cycle 39 がこの 2 つを取り違え、cycle 40 step 1 の実測で分かった。名前は cycle 40 のまま残してある。 -/
noncomputable def multWeight (f : ι → R[X]) (a : ι → ℕ) : R[X] :=
  ∑ i, C ((a i : R)) * derivative (f i) * ∏ j ∈ univ.erase i, f j

/-! ## 1. $\rho$ は無平方でモニックである

**互いに素（`IsCoprime`）ではなく、共通の非単元因子を持たない（`IsRelPrime`）を使う。**
$\mathbb{Z}[x]$ は単項イデアル整域ではないので、相異なる素元でも Bézout の関係は立たない
（$x$ と $x+2$ について $ux+v(x+2)=1$ を $x=0$ で見ると $\mathbb{Z}$ で $2v(0)=1$ となり不可能である）。
本論文が当てるのは $\mathbb{Z}[x]$ なので、`IsCoprime` を仮定すると仮定を満たす族が無くなる。 -/

section Radical

/-- 対ごとに共通の非単元因子を持たない族の積は、各元を割るものを割る。
`Finset.prod_dvd_of_coprime` の `IsRelPrime` 版（mathlib のものは Bézout を要求する）。 -/
theorem prod_dvd_of_pairwise_isRelPrime {s : Finset ι} {f : ι → R[X]} {g : R[X]}
    (hrel : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → IsRelPrime (f i) (f j))
    (hdvd : ∀ i ∈ s, f i ∣ g) : (∏ i ∈ s, f i) ∣ g := by
  classical
  induction s using Finset.cons_induction with
  | empty => simp
  | cons b t hb ih =>
    rw [Finset.prod_cons]
    refine IsRelPrime.mul_dvd ?_ (hdvd b (by simp)) (ih ?_ ?_)
    · refine IsRelPrime.prod_right ?_
      intro i hi
      exact hrel b (by simp) i (by simp [hi]) (fun h => hb (h ▸ hi))
    · exact fun i hi j hj hij => hrel i (Finset.mem_cons_of_mem hi) j (Finset.mem_cons_of_mem hj) hij
    · exact fun i hi => hdvd i (Finset.mem_cons_of_mem hi)

/-- 相異なる素元の積は無平方である。素元は無平方で、相異なる素元は互いに素である。 -/
theorem isRelPrime_of_prime {f : ι → R[X]} (hprime : ∀ i, Prime (f i))
    (hndvd : ∀ i j, i ≠ j → ¬ f i ∣ f j) {i j : ι} (hij : i ≠ j) :
    IsRelPrime (f i) (f j) :=
  (Irreducible.isRelPrime_iff_not_dvd (hprime i).irreducible).mpr (hndvd i j hij)

theorem squarefree_rad {f : ι → R[X]} (hprime : ∀ i, Prime (f i))
    (hndvd : ∀ i j, i ≠ j → ¬ f i ∣ f j) : Squarefree (rad f) :=
  Finset.squarefree_prod_of_pairwise_isCoprime
    (fun i _ j _ hij => isRelPrime_of_prime hprime hndvd hij)
    (fun i _ => (hprime i).squarefree)

/-- モニックな因子の積はモニックである。 -/
theorem rad_monic {f : ι → R[X]} (hmonic : ∀ i, (f i).Monic) : (rad f).Monic :=
  monic_prod_of_monic _ _ fun i _ => hmonic i

end Radical

/-! ## 2. $\chi=h\,\rho$ -/

section Factorization

/-- $\chi=h\,\rho$。各因子から $1$ 本ずつ取り出すだけである（$a_i\ge1$ を使う）。 -/
theorem chi_eq_lower_mul_rad (f : ι → R[X]) {a : ι → ℕ} (ha : ∀ i, 1 ≤ a i) :
    chi f a = lower f a * rad f := by
  classical
  rw [chi, lower, rad, ← Finset.prod_mul_distrib]
  refine Finset.prod_congr rfl ?_
  intro i _
  rw [← pow_succ]
  congr 1
  have := ha i
  omega

end Factorization

/-! ## 3. $\chi'=h\,\mu$（本文の $\chi'/h=\sum_i a_i f_i'\,\rho/f_i$） -/

section Derivative

/-- **本文の $\chi'/h$ の等式。** $\chi'=h\,\mu$ である。

積の微分公式を当てると、$i$ 番目の項は $a_i f_i' f_i^{a_i-1}\prod_{j\neq i}f_j^{a_j}$ になる。
$h=\prod_j f_j^{a_j-1}$ を括り出すと、残りは $\prod_{j\neq i}f_j$ である。 -/
theorem derivative_chi_eq_lower_mul_multWeight (f : ι → R[X]) {a : ι → ℕ} (ha : ∀ i, 1 ≤ a i) :
    derivative (chi f a) = lower f a * multWeight f a := by
  classical
  rw [chi, derivative_prod_finset, multWeight, Finset.mul_sum]
  refine Finset.sum_congr rfl ?_
  intro i _
  -- 左辺の $i$ 番目の項。
  rw [derivative_pow]
  -- 右辺の $i$ 番目の項を、$f_i^{a_i-1}$ と $\prod_{j\neq i}f_j^{a_j}$ の形へ揃える。
  have hsplit : lower f a = (f i) ^ (a i - 1) * ∏ j ∈ univ.erase i, (f j) ^ (a j - 1) := by
    rw [lower, ← Finset.prod_erase_mul univ _ (mem_univ i)]
    ring
  have hcombine : (∏ j ∈ univ.erase i, (f j) ^ (a j - 1)) * ∏ j ∈ univ.erase i, f j
      = ∏ j ∈ univ.erase i, (f j) ^ (a j) := by
    rw [← Finset.prod_mul_distrib]
    refine Finset.prod_congr rfl ?_
    intro j _
    rw [← pow_succ]
    congr 1
    have := ha j
    omega
  rw [hsplit]
  calc (∏ j ∈ univ.erase i, (f j) ^ (a j)) * (C ((a i : R)) * (f i) ^ (a i - 1) * derivative (f i))
      = ((f i) ^ (a i - 1) * ((∏ j ∈ univ.erase i, (f j) ^ (a j - 1))
          * ∏ j ∈ univ.erase i, f j)) * (C ((a i : R)) * derivative (f i)) := by
        rw [hcombine]; ring
    _ = (f i) ^ (a i - 1) * (∏ j ∈ univ.erase i, (f j) ^ (a j - 1))
          * (C ((a i : R)) * derivative (f i) * ∏ j ∈ univ.erase i, f j) := by ring

end Derivative

/-! ## 4. $\mu(\theta)$ は零因子でない

$f_i$ を法にとると $\mu\equiv a_i\,f_i'\,(\rho/f_i)$ である。
$f_i$ が素元なので、$f_i\mid\mu$ なら $a_i$・$f_i'$・$f_j\ (j\neq i)$ のどれかを割ることになるが、
次数と互いに素性からどれも起こらない。 -/

section NonZeroDivisor

variable [CharZero R]

/-- 素元 $f_i$ は定数 $a_i\neq0$ を割らない（次数の比較）。 -/
theorem not_dvd_natCast {f : R[X]} (hdeg : 0 < f.natDegree) {n : ℕ} (hn : n ≠ 0) :
    ¬ f ∣ C ((n : R)) := by
  intro hdvd
  have hne : (C ((n : R)) : R[X]) ≠ 0 := by
    simp only [ne_eq, C_eq_zero]
    exact_mod_cast hn
  have := Polynomial.natDegree_le_of_dvd hdvd hne
  rw [natDegree_C] at this
  omega

/-- 素元 $f_i$ は自分の微分を割らない（次数が真に下がり、標数 $0$ なので $0$ でない）。 -/
theorem not_dvd_derivative {f : R[X]} (hdeg : 0 < f.natDegree) : ¬ f ∣ derivative f := by
  intro hdvd
  have hne : derivative f ≠ 0 := fun h => by
    have : f.natDegree = 0 := Polynomial.derivative_eq_zero.mp h
    omega
  have hle := Polynomial.natDegree_le_of_dvd hdvd hne
  have hlt : (derivative f).natDegree < f.natDegree :=
    Polynomial.natDegree_derivative_lt (by omega)
  omega

/-- **$f_i\nmid\mu$。** $f_i$ を法にとると $j\neq i$ の項は消え、残るのは
$a_i\,f_i'\,\prod_{j\neq i}f_j$ である。$f_i$ は素元なので、割るならその因子のどれかを割る。 -/
theorem not_dvd_multWeight {f : ι → R[X]} {a : ι → ℕ} (hprime : ∀ i, Prime (f i))
    (hndvd : ∀ i j, i ≠ j → ¬ f i ∣ f j)
    (hdeg : ∀ i, 0 < (f i).natDegree) (ha : ∀ i, a i ≠ 0) (i : ι) :
    ¬ f i ∣ multWeight f a := by
  classical
  intro hdvd
  -- $j\neq i$ の項は $\prod_{k\neq j}f_k$ に $f_i$ を含むので割り切れる。
  have hother : f i ∣ ∑ j ∈ univ.erase i,
      C ((a j : R)) * derivative (f j) * ∏ k ∈ univ.erase j, f k := by
    refine Finset.dvd_sum ?_
    intro j hj
    refine Dvd.dvd.mul_left ?_ _
    exact Finset.dvd_prod_of_mem _ (Finset.mem_erase.mpr
      ⟨fun h => (Finset.mem_erase.mp hj).1 h.symm, mem_univ i⟩)
  -- 残る $i$ 番目の項も割り切れることになる。
  have hi : f i ∣ C ((a i : R)) * derivative (f i) * ∏ j ∈ univ.erase i, f j := by
    have hsplit : multWeight f a
        = C ((a i : R)) * derivative (f i) * (∏ j ∈ univ.erase i, f j)
          + ∑ j ∈ univ.erase i, C ((a j : R)) * derivative (f j) * ∏ k ∈ univ.erase j, f k := by
      rw [multWeight, ← Finset.sum_erase_add univ _ (mem_univ i)]
      ring
    rw [hsplit] at hdvd
    exact (dvd_add_right hother).mp (by rwa [add_comm] at hdvd)
  -- 素元なので因子のどれかを割る。どれも起こらない。
  rcases (hprime i).dvd_mul.mp hi with h | h
  · rcases (hprime i).dvd_mul.mp h with h' | h'
    · exact not_dvd_natCast (hdeg i) (ha i) h'
    · exact not_dvd_derivative (hdeg i) h'
  · obtain ⟨j, hj, hij⟩ := (hprime i).exists_mem_finset_dvd h
    have hne : i ≠ j := fun h => (Finset.mem_erase.mp hj).1 h.symm
    exact hndvd i j hne hij

/-- **$\mu(\theta)$ は $A=R[x]/(\rho)$ の中で零因子でない。**

$\rho=\prod_i f_i$ で $f_i$ は互いに素なので、$\rho\mid\mu g$ から各 $i$ で $f_i\mid\mu g$ が出る。
$f_i$ は素元で $f_i\nmid\mu$（上）なので $f_i\mid g$ であり、互いに素性から $\rho\mid g$ となる。 -/
theorem multWeight_mem_nonZeroDivisors {f : ι → R[X]} {a : ι → ℕ} (hprime : ∀ i, Prime (f i))
    (hndvd : ∀ i j, i ≠ j → ¬ f i ∣ f j)
    (hdeg : ∀ i, 0 < (f i).natDegree) (ha : ∀ i, a i ≠ 0) :
    aeval (AdjoinRoot.root (rad f)) (multWeight f a) ∈ nonZeroDivisors (AdjoinRoot (rad f)) := by
  classical
  rw [mem_nonZeroDivisors_iff_left]
  intro z hz
  obtain ⟨g, rfl⟩ := AdjoinRoot.mk_surjective z
  rw [AdjoinRoot.aeval_eq, ← map_mul, AdjoinRoot.mk_eq_zero] at hz
  refine AdjoinRoot.mk_eq_zero.mpr ?_
  -- 各 $f_i$ が $g$ を割ることを言う。
  have hdvd : ∀ i, f i ∣ g := by
    intro i
    have hi : f i ∣ multWeight f a * g :=
      dvd_trans (Finset.dvd_prod_of_mem _ (mem_univ i)) hz
    rcases (hprime i).dvd_mul.mp hi with h | h
    · exact absurd h (not_dvd_multWeight hprime hndvd hdeg ha i)
    · exact h
  -- 相異なる素元は共通の非単元因子を持たないので、積も割る。
  exact prod_dvd_of_pairwise_isRelPrime
    (fun i _ j _ hij => isRelPrime_of_prime hprime hndvd hij) (fun i _ => hdvd i)

end NonZeroDivisor

/-! ## 5. 仕上げ: 構成から直接 $\det G\neq0$ が出る

cycle 38 step 1 の `det_weightedGram_ne_zero_of_squarefree` は
「$\rho$ が無平方」と「$\mu$ が零因子でない」を仮定として受け取っていた。
その 2 つを段 1 と段 4 が与えるので、**本文が構成で与えているものだけから結論が出る形になる。**
これで 命題 W\* の $\det G\neq0$ の側は、仮定を 1 つも残さずに書けたことになる。 -/

section Capstone

variable [IsIntegrallyClosed R] [CharZero R]

/-- **構成から直接出る $\det G\neq0$。**

受け取るのは本文が書いているものだけである——モニックな素元の族 $f_i$（相異なる既約因子）と
重複度 $a_i\ge1$、および $\rho=\prod_i f_i$ の次数。
$\rho$ の無平方性は段 1、$\mu(\theta)$ が零因子でないことは段 4 が与える。 -/
theorem det_weightedGram_ne_zero_of_factorization (K : Type*) [Field K] [Algebra R K]
    [IsFractionRing R K] [CharZero K] {m : ℕ} {f : ι → R[X]} {a : ι → ℕ}
    (hprime : ∀ i, Prime (f i)) (hndvd : ∀ i j, i ≠ j → ¬ f i ∣ f j)
    (hmonic : ∀ i, (f i).Monic) (hdeg : ∀ i, 0 < (f i).natDegree) (ha : ∀ i, a i ≠ 0)
    (hdegrad : (rad f).natDegree = m + 1) :
    (EulerDualBasis.weightedGram (R := R) (m := m) (AdjoinRoot.root (rad f))
      (aeval (AdjoinRoot.root (rad f)) (multWeight f a))).det ≠ 0 :=
  WStarSquarefree.det_weightedGram_ne_zero_of_squarefree K (rad_monic hmonic) hdegrad
    (squarefree_rad hprime hndvd)
    (multWeight_mem_nonZeroDivisors hprime hndvd hdeg ha)

end Capstone

end WStarRadical
end IntegrableLattice
