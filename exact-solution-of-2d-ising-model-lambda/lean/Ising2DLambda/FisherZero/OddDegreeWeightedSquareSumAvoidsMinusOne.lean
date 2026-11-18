/-
節「奇数次の元を付け足した体では正錐を係数とする平方和が負の単位元にならない」の具体版。

  人手証明                                                  このファイル
  主張（`claim_odd_degree_weighted_square_sum_avoids_minus_one`）
                                                            `oddDegree_weightedSquareSum_ne_neg_one`
    -1 の表示と、各 y(i) の簡約した表示                    `hrep`・`g`
    （`claim_subfield_polynomial_values_reduced_representation`）
    P := 1 + ∑ ĉ(i)·(g(i)·g(i)) は F[t] の元                `hPF`
    aev_α(P) = 0                                            `hPα`
    P の最高次の番号 2m（`claim_one_plus_weighted_square_sum_polynomial_even_degree`）
                                                            `hm`・`hmz`
    m < n                                                   `hmn`
    割る（`claim_minimal_vanishing_polynomial_divides`）     `minimalVanishingPolynomial_dvd`
    h ≠ 0 と e、e + n = 2m                                  `hh0`・`hen`
    e は奇数で e < n                                        `heodd`・`hlt`
    奇数次の根（`claim_odd_degree_polynomial_has_odd_degree_root`）
                                                            `oddDegreePolynomial_hasOddDegreeRoot`
    β で -1 が平方和になり、帰納法の仮定に反する            最後の段

本文の「零でない多項式 h の係数が零でない番号の最大値 e」は `Polynomial.natDegree`
（定義の対応。`Polynomial.coeff_eq_zero_of_natDegree_lt` と `Polynomial.leadingCoeff_ne_zero`）で読む。
本文の「ある j で n = 2j+1」は `Odd n`（定義が同じ）。本文の `F(α)` は値の全体 `Val_F(α)`
（`subfieldPolynomialValuesSubfield`）で読む。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.OddDegreePolynomialHasOddDegreeRoot
import Ising2DLambda.FisherZero.OnePlusWeightedSquareSumEvenDegree
import Ising2DLambda.FisherZero.SubfieldPolynomialValuesSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_odd_degree_weighted_square_sum_avoids_minus_one` の具体版。`deg_F(α)` が奇数なら、
`-1` は `C_F` の元を係数とする `Val_F(α)` の元の平方和ではない（`deg_F(α)` についての強い帰納法）。 -/
theorem oddDegree_weightedSquareSum_ne_neg_one (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) :
    ∀ (n : ℕ) (α : Qbar), degreeOverSubfield F α = n → Odd n →
      (-1 : Qbar) ∉ positiveWeightedSquareSums (subfieldPolynomialValuesSubfield F α) CF := by
  classical
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro α hαn hodd hrep
  -- -1 の表示: -1 = ∑ c(i)·(y(i)·y(i))、c(i) ∈ C_F、y(i) ∈ Val_F(α)。
  obtain ⟨ι, hι, c, y, hc, hy, hsum⟩ := hrep
  -- 各 y(i) を、係数が番号 n 以上で零の g(i) ∈ F[t] の値として書く。
  have hred : ∀ i, ∃ g : QbarPoly, g ∈ subfieldCoefficientPolynomials F ∧
      (∀ k : ℕ, degreeOverSubfield F α ≤ k → g.coeff k = 0) ∧ qbarPolyEval α g = y i :=
    fun i => subfieldPolynomialValues_reduced F α (y i) (hy i)
  choose g hgF hgz hgy using hred
  -- P := 1 + ∑ ĉ(i)·(g(i)·g(i))。
  set P : QbarPoly := 1 + ∑ i, qbarConst (c i) * (g i * g i) with hP
  -- P の係数: ac_k(P) = ac_k(1) + ∑ c(i)·ac_k(g(i)·g(i))。
  have hcoeff : ∀ k : ℕ, P.coeff k = (1 : QbarPoly).coeff k + ∑ i, c i * (g i * g i).coeff k := by
    intro k
    rw [hP, Polynomial.coeff_add, Polynomial.finsetSum_coeff]
    simp only [qbarConst, Polynomial.coeff_C_mul]
  -- P ∈ F[t]: 1 と ĉ(i) は F[t] の元で、F[t] は和と積で閉じる。
  have hPF : P ∈ subfieldCoefficientPolynomials F := by
    have h1F : (1 : QbarPoly) ∈ subfieldCoefficientPolynomials F := by
      intro k
      rw [Polynomial.coeff_one]
      split_ifs
      · exact F.one_mem
      · exact F.zero_mem
    have hcF : ∀ i, qbarConst (c i) ∈ subfieldCoefficientPolynomials F := by
      intro i k
      rw [qbarConst, Polynomial.coeff_C]
      split_ifs
      · exact hCF.subset _ (hc i)
      · exact F.zero_mem
    have hsumF : ∀ s : Finset ι,
        (∑ i ∈ s, qbarConst (c i) * (g i * g i)) ∈ subfieldCoefficientPolynomials F := by
      intro s
      induction s using Finset.induction_on with
      | empty =>
          rw [Finset.sum_empty]
          intro k
          rw [Polynomial.coeff_zero]
          exact F.zero_mem
      | insert a s ha ihs =>
          rw [Finset.sum_insert ha]
          exact subfieldCoefficientPolynomials_add_mem F _ _
            (subfieldCoefficientPolynomials_mul_mem F _ _ (hcF a)
              (subfieldCoefficientPolynomials_mul_mem F _ _ (hgF a) (hgF a))) ihs
    exact subfieldCoefficientPolynomials_add_mem F _ _ h1F (hsumF Finset.univ)
  -- aev_α(P) = 1 + ∑ c(i)·(y(i)·y(i)) = 1 + (-1) = 0。
  have hPα : qbarPolyEval α P = 0 := by
    calc qbarPolyEval α P
        = 1 + ∑ i, c i * (qbarPolyEval α (g i) * qbarPolyEval α (g i)) := by
          simp only [hP, qbarPolyEval_eq_eval, qbarConst, Polynomial.eval_add, Polynomial.eval_one,
            Polynomial.eval_finsetSum, Polynomial.eval_mul, Polynomial.eval_C]
      _ = 1 + ∑ i, c i * (y i * y i) := by simp only [hgy]
      _ = 1 + (-1) := by rw [← hsum]
      _ = 0 := by ring
  -- P の最高次の番号 2m（`claim_one_plus_weighted_square_sum_polynomial_even_degree`）。
  obtain ⟨hP0, m, hm, hmz⟩ := onePlusWeightedSquareSum_evenDegree F CF hCF c g hc hgF
  rw [← hP] at hP0 hm hmz
  have hne : ∀ z : Qbar, z ∈ CF → z ≠ 0 := by
    intro z hz h0
    exact (hCF.trichotomy z (hCF.subset z hz)).2.1 ⟨h0, hz⟩
  have hn1 : 1 ≤ n := by obtain ⟨j, hj⟩ := hodd; omega
  -- m < n: n ≤ m なら 2m > 2(n-1) で ac_{2m}(g(i)·g(i)) = 0、m ≥ 1 で ac_{2m}(1) = 0。
  have hmn : m < n := by
    by_contra hnm
    push Not at hnm
    apply hne _ hm
    rw [hcoeff, Polynomial.coeff_one, if_neg (by omega), zero_add]
    apply Finset.sum_eq_zero
    intro i _
    rw [qbarPolyProductCoeffBound (g i) (g i) (n - 1) (n - 1)
      (fun k hk => hgz i k (by omega)) (fun k hk => hgz i k (by omega)) (2 * m) (by omega),
      mul_zero]
  -- n ∈ D_F(α) の証人 p と ac_n(p) ≠ 0。
  obtain ⟨p, hp, hp0, htop, hpα⟩ := degreeOverSubfield_spec F α
  have hpn : p.coeff (degreeOverSubfield F α) ≠ 0 :=
    minimalVanishingPolynomial_leading_ne_zero F α p hp hp0 htop hpα
  rw [hαn] at hpn htop
  -- 割る（`claim_minimal_vanishing_polynomial_divides`）: P = h·p。
  obtain ⟨h, hh, hPh⟩ := minimalVanishingPolynomial_dvd F α p hp hp0
    (by rw [hαn]; exact htop) hpα P hPF hPα
  have hh0 : h ≠ 0 := by
    intro h0
    apply hP0
    rw [hPh, h0, zero_mul]
  set e := h.natDegree with he
  have hhe : h.coeff e ≠ 0 := Polynomial.leadingCoeff_ne_zero.mpr hh0
  have hhb : ∀ k : ℕ, e < k → h.coeff k = 0 :=
    fun k hk => Polynomial.coeff_eq_zero_of_natDegree_lt hk
  -- 積の最高次の番号は和になる: e + n = 2m。
  have htopP : P.coeff (e + n) ≠ 0 := by
    rw [hPh, qbarPolyProductTopCoeff h p e n hhb htop]
    intro h0
    exact hpn (qbarNoZeroDivisors hhe h0)
  have hboundP : ∀ k : ℕ, e + n < k → P.coeff k = 0 := by
    intro k hk
    rw [hPh]
    exact qbarPolyProductCoeffBound h p e n hhb htop k hk
  have hen : e + n = 2 * m := by
    rcases lt_trichotomy (e + n) (2 * m) with hlt | heq | hgt
    · exact absurd (hboundP (2 * m) hlt) (hne _ hm)
    · exact heq
    · exact absurd (hmz (e + n) hgt) htopP
  -- e は奇数で e < n。
  obtain ⟨j, hj⟩ := hodd
  have heodd : Odd e := ⟨m - j - 1, by omega⟩
  have hlt : e < n := by omega
  -- 奇数次の根（`claim_odd_degree_polynomial_has_odd_degree_root`）。
  obtain ⟨β, hhβ, hβodd, hβle⟩ := oddDegreePolynomial_hasOddDegreeRoot F e h hh heodd hhe hhb
  -- aev_β(P) = aev_β(h)·aev_β(p) = 0。
  have hPβ : qbarPolyEval β P = 0 := by
    calc qbarPolyEval β P
        = qbarPolyEval β (h * p) := by rw [hPh]
      _ = qbarPolyEval β h * qbarPolyEval β p := by
          simp only [qbarPolyEval_eq_eval, Polynomial.eval_mul]
      _ = 0 * qbarPolyEval β p := by rw [hhβ]
      _ = 0 := zero_mul _
  -- -1 = ∑ c(i)·(aev_β(g(i))·aev_β(g(i)))、aev_β(g(i)) ∈ Val_F(β)。帰納法の仮定に反する。
  apply ih (degreeOverSubfield F β) (by omega) β rfl hβodd
  refine ⟨ι, hι, c, fun i => qbarPolyEval β (g i), hc, fun i => ⟨g i, hgF i, rfl⟩, ?_⟩
  have h1 : 1 + ∑ i, c i * (qbarPolyEval β (g i) * qbarPolyEval β (g i)) = 0 := by
    rw [← hPβ]
    simp only [hP, qbarPolyEval_eq_eval, qbarConst, Polynomial.eval_add, Polynomial.eval_one,
      Polynomial.eval_finsetSum, Polynomial.eval_mul, Polynomial.eval_C]
  calc (-1 : Qbar)
      = -1 + (1 + ∑ i, c i * (qbarPolyEval β (g i) * qbarPolyEval β (g i))) := by rw [h1, add_zero]
    _ = ∑ i, c i * (qbarPolyEval β (g i) * qbarPolyEval β (g i)) := by ring

end Ising2DLambda.FisherZero
