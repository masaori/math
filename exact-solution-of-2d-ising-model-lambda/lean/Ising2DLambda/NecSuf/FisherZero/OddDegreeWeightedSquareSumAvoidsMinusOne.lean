/-
節「奇数次の元を付け足した体では正錐を係数とする平方和が負の単位元にならない」の必要十分版。

具体版と同じ段（簡約した表示 → `P` → 偶数次 → `m < n` → 整除 → `e + n = 2m` → 奇数次の根 → 帰納法の仮定）
で示し、各段が実際に使う性質だけを仮定に置く。

- 値の全体 `Val_F(α)` は、係数が `S` に属する多項式の `α` での値の集合 `{f.eval α}` で受ける。
  部分体であること（`subfieldPolynomialValuesSubfield`）は使わない。
- 部分体上の次数は、奇数次の根の必要十分版と同じく、写像 `deg` と証人 `hspec` と最小性 `hmin` で受ける。
  根の存在 `hroot` は奇数次の根の段だけが使う。
- 係数の集合 `S` について: 零元・和・差・積・商の閉性は、簡約した表示と整除の段の除法が使う。
  単位元を含むこと（`h1S`）と `C ⊆ S`（`hCS`）は、`P = 1 + ∑ ĉ(i)·(g(i)·g(i))` の係数が `S` に属する段だけが使う。
- 正錐 `C` について: 偶数次の段が使う性質（和・積の閉性、単位元を含むこと、零元を含まないこと、`S` の零でない元の
  平方を含むこと）だけを使う。零元を含まないことは、`m < n` と `e + n = 2m` の段で最高次の係数が零でないことにも使う。
  三分法そのものは使わない（具体版では零でない元の平方と零元を含まないことを出すためだけに使う）。
- 台は体であることが要る: 除法と奇数次の根の段が体を要し、最高次の係数の積が零でないことには零因子が無いことが要る。
-/
import Ising2DLambda.NecSuf.FisherZero.OddDegreePolynomialHasOddDegreeRoot
import Ising2DLambda.NecSuf.FisherZero.OnePlusWeightedSquareSumEvenDegree
import Ising2DLambda.NecSuf.FisherZero.PositiveWeightedSquareSums

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial

/-- 主張（具体版 `oddDegree_weightedSquareSum_ne_neg_one` と同じ段）。 -/
theorem oddDegree_weightedSquareSum_ne_neg_one_necSuf {K : Type*} [Field K] (S C : Set K)
    (h0 : (0 : K) ∈ S) (h1S : (1 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hsub : ∀ a b : K, a ∈ S → b ∈ S → a - b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S)
    (hCadd : ∀ a b : K, a ∈ C → b ∈ C → a + b ∈ C)
    (hCmul : ∀ a b : K, a ∈ C → b ∈ C → a * b ∈ C)
    (h1C : (1 : K) ∈ C) (h0C : (0 : K) ∉ C) (hCS : ∀ a : K, a ∈ C → a ∈ S)
    (hsq : ∀ a : K, a ∈ S → a ≠ 0 → a * a ∈ C) (deg : K → ℕ)
    (hspec : ∀ β : K, ∃ p : K[X], (∀ k : ℕ, p.coeff k ∈ S) ∧ p ≠ 0 ∧
      (∀ k : ℕ, deg β < k → p.coeff k = 0) ∧ p.eval β = 0)
    (hmin : ∀ (β : K) (d : ℕ) (q : K[X]), (∀ k : ℕ, q.coeff k ∈ S) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval β = 0 → deg β ≤ d)
    (hroot : ∀ (f : K[X]) (n : ℕ), (∀ k : ℕ, f.coeff k ∈ S) → 1 ≤ n → f.coeff n ≠ 0 →
      ∃ β : K, f.eval β = 0) :
    ∀ (n : ℕ) (α : K), deg α = n → Odd n →
      (-1 : K) ∉ weightedSquareSums {y | ∃ f : K[X], (∀ k : ℕ, f.coeff k ∈ S) ∧ f.eval α = y} C := by
  classical
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro α hαn hodd hrep
  obtain ⟨ι, hι, c, y, hc, hy, hsum⟩ := hrep
  -- n ∈ D_F(α) の証人 p。
  obtain ⟨p, hp, hp0, htop, hpα⟩ := hspec α
  -- 簡約した表示。
  have hred : ∀ i, ∃ g : K[X], (∀ k : ℕ, g.coeff k ∈ S) ∧
      (∀ k : ℕ, deg α ≤ k → g.coeff k = 0) ∧ g.eval α = y i := by
    intro i
    obtain ⟨f, hf, hfy⟩ := hy i
    obtain ⟨g, hg, hgz, hgα⟩ := polynomialValues_reduced_necSuf S h0 hadd hsub hmul hdiv α (deg α)
      (hmin α) p hp hp0 htop hpα f hf
    exact ⟨g, hg, hgz, by rw [hgα, hfy]⟩
  choose g hgS hgz hgy using hred
  set P : K[X] := 1 + ∑ i, Polynomial.C (c i) * (g i * g i) with hP
  have hcoeff : ∀ k : ℕ, P.coeff k = (1 : K[X]).coeff k + ∑ i, c i * (g i * g i).coeff k := by
    intro k
    rw [hP, Polynomial.coeff_add, Polynomial.finsetSum_coeff]
    simp only [Polynomial.coeff_C_mul]
  -- P の係数は S に属する。
  have hPS : ∀ k : ℕ, P.coeff k ∈ S := by
    have hsumS : ∀ {τ : Type} (s : Finset τ) (u : τ → K), (∀ i ∈ s, u i ∈ S) → (∑ i ∈ s, u i) ∈ S := by
      intro τ s u hu
      induction s using Finset.induction_on with
      | empty => rw [Finset.sum_empty]; exact h0
      | insert a s ha ihs =>
          rw [Finset.sum_insert ha]
          exact hadd _ _ (hu a (Finset.mem_insert_self a s))
            (ihs (fun i hi => hu i (Finset.mem_insert_of_mem hi)))
    have hsqS : ∀ i k, (g i * g i).coeff k ∈ S := by
      intro i k
      rw [Polynomial.coeff_mul]
      exact hsumS _ _ (fun x _ => hmul _ _ (hgS i x.1) (hgS i x.2))
    intro k
    rw [hcoeff, Polynomial.coeff_one]
    refine hadd _ _ ?_ (hsumS _ _ (fun i _ => hmul _ _ (hCS _ (hc i)) (hsqS i k)))
    split_ifs
    · exact h1S
    · exact h0
  have hPα : P.eval α = 0 := by
    calc P.eval α
        = 1 + ∑ i, c i * ((g i).eval α * (g i).eval α) := by
          simp only [hP, Polynomial.eval_add, Polynomial.eval_one, Polynomial.eval_finsetSum,
            Polynomial.eval_mul, Polynomial.eval_C]
      _ = 1 + ∑ i, c i * (y i * y i) := by simp only [hgy]
      _ = 1 + (-1) := by rw [← hsum]
      _ = 0 := by ring
  obtain ⟨hP0, m, hm, hmz⟩ :=
    onePlusWeightedSquareSum_evenDegree_necSuf S C hCadd hCmul h1C h0C hsq c g hc hgS
  rw [← hP] at hP0 hm hmz
  have hne : ∀ z : K, z ∈ C → z ≠ 0 := fun z hz h0' => h0C (h0' ▸ hz)
  have hn1 : 1 ≤ n := by obtain ⟨j, hj⟩ := hodd; omega
  rw [hαn] at hgz htop
  have hmn : m < n := by
    by_contra hnm
    push Not at hnm
    apply hne _ hm
    rw [hcoeff, Polynomial.coeff_one, if_neg (by omega), zero_add]
    apply Finset.sum_eq_zero
    intro i _
    rw [productCoeffBound_necSuf (g i) (g i) (n - 1) (n - 1)
      (fun k hk => hgz i k (by omega)) (fun k hk => hgz i k (by omega)) (2 * m) (by omega),
      mul_zero]
  have hpn : p.coeff n ≠ 0 :=
    minimalVanishingPolynomial_leading_ne_zero_necSuf S α n (hαn ▸ hmin α) p hp hp0 htop hpα
  obtain ⟨h, hh, hPh⟩ := minimalVanishingPolynomial_dvd_necSuf S h0 hadd hsub hmul hdiv α n
    (hαn ▸ hmin α) p hp hp0 htop hpα P hPS hPα
  have hh0 : h ≠ 0 := by
    intro h0'
    apply hP0
    rw [hPh, h0', zero_mul]
  have hhe : h.coeff h.natDegree ≠ 0 := Polynomial.leadingCoeff_ne_zero.mpr hh0
  have hhb : ∀ k : ℕ, h.natDegree < k → h.coeff k = 0 :=
    fun k hk => Polynomial.coeff_eq_zero_of_natDegree_lt hk
  have htopP : P.coeff (h.natDegree + n) ≠ 0 := by
    rw [hPh, productTopCoeff_necSuf h p h.natDegree n hhb htop]
    exact mul_ne_zero hhe hpn
  have hboundP : ∀ k : ℕ, h.natDegree + n < k → P.coeff k = 0 := by
    intro k hk
    rw [hPh]
    exact productCoeffBound_necSuf h p h.natDegree n hhb htop k hk
  have hen : h.natDegree + n = 2 * m := by
    rcases lt_trichotomy (h.natDegree + n) (2 * m) with hlt | heq | hgt
    · exact absurd (hboundP (2 * m) hlt) (hne _ hm)
    · exact heq
    · exact absurd (hmz _ hgt) htopP
  obtain ⟨j, hj⟩ := hodd
  have heodd : Odd h.natDegree := ⟨m - j - 1, by omega⟩
  have hlt : h.natDegree < n := by omega
  obtain ⟨β, hhβ, hβodd, hβle⟩ := oddDegreePolynomial_hasOddDegreeRoot_necSuf S h0 hadd hsub hmul
    hdiv deg hspec hmin hroot h.natDegree h hh heodd hhe hhb
  have hPβ : P.eval β = 0 := by rw [hPh, Polynomial.eval_mul, hhβ, zero_mul]
  apply ih (deg β) (by omega) β rfl hβodd
  refine ⟨ι, hι, c, fun i => (g i).eval β, hc, fun i => ⟨g i, hgS i, rfl⟩, ?_⟩
  have h1 : 1 + ∑ i, c i * ((g i).eval β * (g i).eval β) = 0 := by
    rw [← hPβ]
    simp only [hP, Polynomial.eval_add, Polynomial.eval_one, Polynomial.eval_finsetSum,
      Polynomial.eval_mul, Polynomial.eval_C]
  calc (-1 : K)
      = -1 + (1 + ∑ i, c i * ((g i).eval β * (g i).eval β)) := by rw [h1, add_zero]
    _ = ∑ i, c i * ((g i).eval β * (g i).eval β) := by ring

end Ising2DLambda.NecSuf.FisherZero
