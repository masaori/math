/-
節「対称式の基本定理」の本体 `claim_symmetric_polynomial_fundamental_theorem` の必要十分版。

具体版（`Ising2DLambda.FisherZero.symmetricPolynomialFundamental`）と同じ段で示す。変数の個数についての帰納法の
中で全次数についての強い帰納法を行い、帰納の段では末尾の変数への零代入 `P_0`、外側の帰納法の仮定による `Q_0`、
持ち上げ `Q_1 = ex(Q_0)`、`R := P + C(−1)·se(Q_1)`、`R` を全変数の積で割った商 `S`、内側の帰納法の仮定による `Q_2`、
`Q := Q_1 + X_n·Q_2` の順に置く。各段は具体版の段の必要十分版（このディレクトリの各ファイル）を引く。

- 係数は可換環 `K` でよい。体であること・零因子が無いことは使わない。可換「環」が要るのは `C(−1)` を作るため
  （可換半環では `R` を作れない。`ℕ` 係数では `X_0^2 + X_1^2 = e_1^2 − 2e_2` の右辺の係数が `ℕ` に無い）。
- 部分体 `F` の代わりに、`0`・`1`・`−1` を含み和と積で閉じた任意の部分集合 `S ⊆ K` でよい（部分環であること）。
  逆元で閉じていることは使わない。`0` は係数の集合の所属の定義に、`1` は変数と基本対称式の所属に、`−1` は
  `C(−1)` の所属に、和と積は和と積の所属に要る。
- 対称性は、任意の全単射 `e : Fin n ≃ Fin n` による変数の置換 `aeval (X ∘ e)` で不変なことであり、具体版と同じ式。
-/
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricLastVariableZero
import Ising2DLambda.NecSuf.FisherZero.SymmetricVanishingDivisibleByProduct
import Ising2DLambda.NecSuf.FisherZero.LastVariableZeroPreservesSymmetry
import Ising2DLambda.NecSuf.FisherZero.LastVariableZeroSubfieldCoefficientDegree
import Ising2DLambda.NecSuf.FisherZero.LastVariableExtension
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionSymmetric
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionLastVariableZero
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionDegreeBound
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionSubfieldCoefficient
import Ising2DLambda.NecSuf.FisherZero.WeightedDegreeSumAndLastVariableProduct

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {K : Type} [CommRing K]

/-- 基本対称式 `es_{n,j}`（具体版と同じ式）。 -/
noncomputable def esNecSuf (n j : ℕ) : MvPolynomial (Fin n) K :=
  ∑ T ∈ Finset.powersetCard j (Finset.univ : Finset (Fin n)), ∏ k ∈ T, X k

/-- 代入する値 `ee_n(j) = es_{n,j+1}`。 -/
noncomputable def esValuesNecSuf (n : ℕ) : Fin n → MvPolynomial (Fin n) K :=
  fun j => esNecSuf n (j.val + 1)

/-- 基本対称式への代入 `se_n`。 -/
noncomputable def seNecSuf (n : ℕ) : MvPolynomial (Fin n) K →ₐ[K] MvPolynomial (Fin n) K :=
  aeval (esValuesNecSuf n)

/-- 対称であること（任意の全単射による変数の置換で不変）。 -/
def IsSymNecSuf {n : ℕ} (P : MvPolynomial (Fin n) K) : Prop :=
  ∀ e : Fin n ≃ Fin n, aeval (fun k => (X (e k) : MvPolynomial (Fin n) K)) P = P

/-- 重み付きの指数の総和 `wsz_n(a) = Σ_k (k+1)·a(k)`。 -/
def wszNecSuf {n : ℕ} (a : Fin n →₀ ℕ) : ℕ :=
  ∑ k : Fin n, (k.val + 1) * a k

/-- 置換の末尾を固定する延長。 -/
def lastFixedPermNecSuf (n : ℕ) (ϱ : Fin n ≃ Fin n) : Fin (n + 1) ≃ Fin (n + 1) :=
  (finSuccEquiv' (Fin.last n)).trans ((Equiv.optionCongr ϱ).trans (finSuccEquiv' (Fin.last n)).symm)

theorem lastFixedPermNecSuf_last (n : ℕ) (ϱ : Fin n ≃ Fin n) :
    lastFixedPermNecSuf n ϱ (Fin.last n) = Fin.last n := by
  simp [lastFixedPermNecSuf]

theorem lastFixedPermNecSuf_castSucc (n : ℕ) (ϱ : Fin n ≃ Fin n) (k : Fin n) :
    lastFixedPermNecSuf n ϱ k.castSucc = (ϱ k).castSucc := by
  simp only [lastFixedPermNecSuf, Equiv.trans_apply, finSuccEquiv'_last_apply_castSucc,
    Equiv.optionCongr_apply, Option.map_some]
  exact finSuccEquiv'_symm_some_below (Fin.castSucc_lt_last _)

/-! ### 指数の総和についての準備（自然数だけの事実） -/

theorem exponentTotalNecSuf_zero {n : ℕ} : exponentTotalNecSuf (0 : Fin n →₀ ℕ) ≤ 0 := by
  simp [exponentTotalNecSuf]

theorem exponentTotalNecSuf_add {n : ℕ} (b c : Fin n →₀ ℕ) :
    exponentTotalNecSuf (b + c) ≤ exponentTotalNecSuf b + exponentTotalNecSuf c := by
  simp [exponentTotalNecSuf, Finset.sum_add_distrib]

theorem exponentTotalNecSuf_zeroExtension {n : ℕ} (b : Fin n →₀ ℕ) :
    exponentTotalNecSuf b ≤ exponentTotalNecSuf (exponentZeroExtension b) := by
  unfold exponentTotalNecSuf
  rw [Fin.sum_univ_castSucc, exponentZeroExtension_last, add_zero]
  exact le_of_eq (Finset.sum_congr rfl fun k _ => (exponentZeroExtension_castSucc b k).symm)

theorem wszNecSuf_of_last_eq_zero {n : ℕ} (a : Fin (n + 1) →₀ ℕ) (ha : a (Fin.last n) = 0) :
    wszNecSuf a ≤ wszNecSuf (exponentRestrictLast a) := by
  unfold wszNecSuf
  rw [Fin.sum_univ_castSucc, ha, mul_zero, add_zero]
  exact le_of_eq (Finset.sum_congr rfl fun k _ => by rw [exponentRestrictLast_apply, Fin.val_castSucc])

theorem wszNecSuf_single_last_add {n : ℕ} (c : Fin (n + 1) →₀ ℕ) :
    wszNecSuf (Finsupp.single (Fin.last n) 1 + c) ≤ (n + 1) + wszNecSuf c := by
  unfold wszNecSuf
  have h : ∀ k : Fin (n + 1),
      (k.val + 1) * (Finsupp.single (Fin.last n) 1 + c : Fin (n + 1) →₀ ℕ) k =
      (k.val + 1) * Finsupp.single (Fin.last n) 1 k + (k.val + 1) * c k := fun k => by
    rw [Finsupp.add_apply, Nat.mul_add]
  rw [Finset.sum_congr rfl fun k _ => h k, Finset.sum_add_distrib,
    Finset.sum_eq_single (Fin.last n)]
  · simp
  · intro k _ hk
    rw [Finsupp.single_apply, if_neg (Ne.symm hk), mul_zero]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-! ### 帰納の段が引く主張の、係数 `K`・集合 `S` での形 -/

section Pieces

variable {S : Set K} (h0 : (0 : K) ∈ S) (h1 : (1 : K) ∈ S)
  (hadd : ∀ x y : K, x ∈ S → y ∈ S → x + y ∈ S) (hmul : ∀ x y : K, x ∈ S → y ∈ S → x * y ∈ S)
include h0 h1 hadd hmul

theorem mul_mem_coeffIn_fin_necSuf {σ : Type} {A B : MvPolynomial σ K} (hA : A ∈ coeffIn S σ)
    (hB : B ∈ coeffIn S σ) : A * B ∈ coeffIn S σ := by
  have h := prod_mem_coeffIn_necSuf h0 h1 hadd hmul (Finset.univ : Finset (Fin 2)) ![A, B]
    (fun i _ => by fin_cases i; exacts [hA, hB])
  simpa only [Fin.prod_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one] using h

omit h1 hmul in
/-- 二元の和の所属（`0` と和の閉性だけを使う）。 -/
theorem add_mem_coeffIn_fin_necSuf {σ : Type} {A B : MvPolynomial σ K} (hA : A ∈ coeffIn S σ)
    (hB : B ∈ coeffIn S σ) : A + B ∈ coeffIn S σ := by
  have h := sum_mem_coeffIn_necSuf h0 hadd (Finset.univ : Finset (Fin 2)) ![A, B]
    (fun i _ => by fin_cases i; exacts [hA, hB])
  simpa only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one] using h

theorem seNecSuf_mem_coeffIn {n : ℕ} (Q : MvPolynomial (Fin n) K) (hQ : Q ∈ coeffIn S (Fin n)) :
    seNecSuf n Q ∈ coeffIn S (Fin n) :=
  aeval_mem_coeffIn_necSuf h0 h1 hadd hmul (esValuesNecSuf n)
    (fun k => elementarySymmetric_mem_coeffIn_necSuf h0 h1 hadd hmul (k.val + 1)) Q hQ

end Pieces

theorem seNecSuf_isSym {n : ℕ} (Q : MvPolynomial (Fin n) K) : IsSymNecSuf (seNecSuf n Q) := fun e =>
  mvSubst_fixed_of_values_fixed_necSuf (esValuesNecSuf n) (fun k => (X (e k) : MvPolynomial (Fin n) K))
    (fun j => elementarySymmetric_equivInvariant_necSuf e (j.val + 1)) Q

theorem lastVariableZeroNecSuf_isSym {n : ℕ} (P : MvPolynomial (Fin (n + 1)) K) (hP : IsSymNecSuf P) :
    IsSymNecSuf (lastVariableZeroNecSuf n P) := fun ϱ =>
  invariant_map_of_comm_necSuf (lastVariableZeroNecSuf n)
    (fun (j : Fin (n + 1) ≃ Fin (n + 1)) => aeval (fun k => (X (j k) : MvPolynomial (Fin (n + 1)) K)))
    (fun (i : Fin n ≃ Fin n) => aeval (fun k => (X (i k) : MvPolynomial (Fin n) K)))
    (lastFixedPermNecSuf n)
    (fun i a => lastPointZero_comm_variableMap_necSuf Fin.castSucc (Fin.last n)
      (fun x => Fin.lastCases (Or.inl rfl) (fun k => Or.inr ⟨k, rfl⟩) x)
      (lastVariableZeroValuesNecSuf n) (by rw [lastVariableZeroValuesNecSuf, Fin.lastCases_last])
      (fun k => by rw [lastVariableZeroValuesNecSuf, Fin.lastCases_castSucc])
      i (lastFixedPermNecSuf n i) (lastFixedPermNecSuf_last n i) (lastFixedPermNecSuf_castSucc n i) a)
    P hP ϱ

theorem lastVariableZeroNecSuf_esNecSuf (n j : ℕ) :
    lastVariableZeroNecSuf n (esNecSuf (n + 1) j : MvPolynomial (Fin (n + 1)) K) = esNecSuf n j := by
  classical
  have huniv : (Finset.univ : Finset (Fin (n + 1))) =
      insert (Fin.last n) ((Finset.univ : Finset (Fin n)).map Fin.castSuccEmb) := by
    ext x
    induction x using Fin.lastCases with
    | last => simp
    | cast k => simp [Fin.castSucc_ne_last]
  have h := elementarySymmetric_insert_zero_necSuf
    (lastVariableZeroNecSuf (K := K) n).toRingHom (fun k : Fin (n + 1) => (X k : MvPolynomial (Fin (n + 1)) K))
    Fin.castSuccEmb Finset.univ (Fin.last n)
    (by simp [Fin.castSucc_ne_last]) (fun k : Fin n => (X k : MvPolynomial (Fin n) K))
    (fun k => by simp [lastVariableZeroNecSuf, lastVariableZeroValuesNecSuf])
    (by simp [lastVariableZeroNecSuf, lastVariableZeroValuesNecSuf]) j
  rw [← huniv] at h
  exact h

theorem lastVariableZeroNecSuf_seNecSuf {n : ℕ} (Q : MvPolynomial (Fin (n + 1)) K) :
    lastVariableZeroNecSuf n (seNecSuf (n + 1) Q) = seNecSuf n (lastVariableZeroNecSuf n Q) :=
  mvSubst_comm_of_values_comm_necSuf (esValuesNecSuf (n + 1)) (lastVariableZeroValuesNecSuf n)
    (lastVariableZeroValuesNecSuf n) (esValuesNecSuf n) (fun j => by
      refine Fin.lastCases ?_ (fun k => ?_) j
      · calc aeval (lastVariableZeroValuesNecSuf n) (esValuesNecSuf (n + 1) (Fin.last n))
            = lastVariableZeroNecSuf n (esNecSuf (n + 1) (n + 1) : MvPolynomial (Fin (n + 1)) K) := rfl
          _ = esNecSuf n (n + 1) := lastVariableZeroNecSuf_esNecSuf n (n + 1)
          _ = 0 := by
              rw [esNecSuf, Finset.powersetCard_eq_empty.mpr
                (by rw [Finset.card_univ, Fintype.card_fin]; exact Nat.lt_succ_self n), Finset.sum_empty]
          _ = aeval (esValuesNecSuf n) (lastVariableZeroValuesNecSuf n (Fin.last n)) := by
              rw [lastVariableZeroValuesNecSuf, Fin.lastCases_last, map_zero]
      · calc aeval (lastVariableZeroValuesNecSuf n) (esValuesNecSuf (n + 1) k.castSucc)
            = lastVariableZeroNecSuf n (esNecSuf (n + 1) (k.val + 1) : MvPolynomial (Fin (n + 1)) K) := rfl
          _ = esNecSuf n (k.val + 1) := lastVariableZeroNecSuf_esNecSuf n (k.val + 1)
          _ = aeval (esValuesNecSuf n) (lastVariableZeroValuesNecSuf n k.castSucc) := by
              rw [lastVariableZeroValuesNecSuf, Fin.lastCases_castSucc, aeval_X]
              rfl) Q

theorem totalDegree_seNecSuf_le {n : ℕ} (Q : MvPolynomial (Fin n) K) :
    totalDegreeNecSuf (seNecSuf n Q) ≤ wDeg wszNecSuf Q :=
  wDeg_aeval_le_necSuf exponentTotalNecSuf exponentTotalNecSuf_zero exponentTotalNecSuf_add
    (esValuesNecSuf n) (fun k => k.val + 1)
    (fun k => wDeg_elementarySymmetric_le_necSuf exponentTotalNecSuf exponentTotalNecSuf_zero
      exponentTotalNecSuf_add (fun i => by
        apply wDeg_le_of_forall
        intro a ha
        classical
        rw [coeff_X] at ha
        split_ifs at ha with h
        · rw [← h]; simp [exponentTotalNecSuf]
        · exact absurd rfl ha) (k.val + 1)) Q

/-! ### 帰納の段 -/

section Step

variable {S : Set K} (h0 : (0 : K) ∈ S) (h1 : (1 : K) ∈ S) (hneg : (-1 : K) ∈ S)
  (hadd : ∀ x y : K, x ∈ S → y ∈ S → x + y ∈ S) (hmul : ∀ x y : K, x ∈ S → y ∈ S → x * y ∈ S)
include h0 h1 hneg hadd hmul

/-- `claim_symmetric_polynomial_fundamental_theorem` の帰納の段の必要十分版（具体版
`symmetricPolynomialFundamental_succ` と同じ段）。 -/
theorem symmetricPolynomialFundamental_succ_necSuf (n : ℕ)
    (ih : ∀ P : MvPolynomial (Fin n) K, P ∈ coeffIn S (Fin n) → IsSymNecSuf P →
      ∃ Q ∈ coeffIn S (Fin n), P = seNecSuf n Q ∧ wDeg wszNecSuf Q ≤ totalDegreeNecSuf P) (d : ℕ) :
    ∀ P : MvPolynomial (Fin (n + 1)) K, totalDegreeNecSuf P = d → P ∈ coeffIn S (Fin (n + 1)) →
      IsSymNecSuf P → ∃ Q ∈ coeffIn S (Fin (n + 1)),
        P = seNecSuf (n + 1) Q ∧ wDeg wszNecSuf Q ≤ d := by
  induction d using Nat.strong_induction_on with
  | _ d ihd =>
  intro P hdeg hF hsym
  -- P_0 := lz(P) の所属・対称性・全次数と、外側の帰納法の仮定による Q_0。
  have hP₀F := lastVariableZero_mem_coeffIn_necSuf (S := S) P hF
  have hP₀sym := lastVariableZeroNecSuf_isSym P hsym
  have hP₀deg : totalDegreeNecSuf (lastVariableZeroNecSuf n P) ≤ d :=
    hdeg ▸ wDeg_lastVariableZero_le_necSuf exponentTotalNecSuf exponentTotalNecSuf
      exponentTotalNecSuf_zeroExtension P
  obtain ⟨Q₀, hQ₀F, hQ₀eq, hQ₀deg⟩ := ih _ hP₀F hP₀sym
  -- Q_1 := ex(Q_0) の所属と重み付き次数。
  have hQ₁F := lastVariableExtension_mem_coeffIn_necSuf h0 Q₀ hQ₀F
  have hQ₁deg : wDeg wszNecSuf (lastVariableExtensionNecSuf Q₀) ≤ d :=
    calc wDeg wszNecSuf (lastVariableExtensionNecSuf Q₀)
        ≤ wDeg wszNecSuf Q₀ :=
          wDeg_lastVariableExtension_le_necSuf wszNecSuf wszNecSuf wszNecSuf_of_last_eq_zero Q₀
      _ ≤ totalDegreeNecSuf (lastVariableZeroNecSuf n P) := hQ₀deg
      _ ≤ d := hP₀deg
  set Q₁ := lastVariableExtensionNecSuf Q₀ with hQ₁def
  set R := P + C (-1) * seNecSuf (n + 1) Q₁ with hRdef
  -- R の所属。
  have hRF : R ∈ coeffIn S (Fin (n + 1)) :=
    add_mem_coeffIn_fin_necSuf h0 hadd hF
      (mul_mem_coeffIn_fin_necSuf h0 h1 hadd hmul (C_mem_coeffIn_necSuf h0 hneg)
        (seNecSuf_mem_coeffIn h0 h1 hadd hmul Q₁ hQ₁F))
  -- R の対称性。
  have hRsym : IsSymNecSuf R := fun e => by
    calc aeval (R := K) (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K)) R
        = aeval (R := K) (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K)) P +
            aeval (R := K) (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K)) (C (-1)) *
              aeval (R := K) (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K)) (seNecSuf (n + 1) Q₁) := by
          rw [hRdef, map_add, map_mul]
      _ = P + aeval (R := K) (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K)) (C (-1)) *
              aeval (R := K) (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K)) (seNecSuf (n + 1) Q₁) := by
          rw [hsym e]
      _ = P + C (-1) *
              aeval (R := K) (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K)) (seNecSuf (n + 1) Q₁) := by
          rw [show aeval (R := K) (fun k => (X (e k) : MvPolynomial (Fin (n + 1)) K))
            (C (-1) : MvPolynomial (Fin (n + 1)) K) = C (-1) from aeval_C _ _]
      _ = P + C (-1) * seNecSuf (n + 1) Q₁ := by rw [seNecSuf_isSym Q₁ e]
      _ = R := rfl
  -- lz(R) = 0。
  have hRlz : lastVariableZeroNecSuf n R = 0 := by
    calc lastVariableZeroNecSuf n R
        = lastVariableZeroNecSuf n P + lastVariableZeroNecSuf n (C (-1)) *
            lastVariableZeroNecSuf n (seNecSuf (n + 1) Q₁) := by rw [hRdef, map_add, map_mul]
      _ = lastVariableZeroNecSuf n P + C (-1) * lastVariableZeroNecSuf n (seNecSuf (n + 1) Q₁) := by
          rw [show lastVariableZeroNecSuf n (C (-1) : MvPolynomial (Fin (n + 1)) K) = C (-1) from
            aeval_C _ _]
      _ = lastVariableZeroNecSuf n P + C (-1) * seNecSuf n (lastVariableZeroNecSuf n Q₁) := by
          rw [lastVariableZeroNecSuf_seNecSuf]
      _ = lastVariableZeroNecSuf n P + C (-1) * seNecSuf n Q₀ := by
          rw [hQ₁def, lastVariableZero_lastVariableExtension_necSuf]
      _ = lastVariableZeroNecSuf n P + C (-1) * lastVariableZeroNecSuf n P := by rw [← hQ₀eq]
      _ = C 1 * lastVariableZeroNecSuf n P + C (-1) * lastVariableZeroNecSuf n P := by
          rw [C_1, one_mul]
      _ = (C 1 + C (-1)) * lastVariableZeroNecSuf n P := (add_mul _ _ _).symm
      _ = C 0 * lastVariableZeroNecSuf n P := by rw [← C_add, add_neg_cancel]
      _ = 0 := by rw [C_0, zero_mul]
  -- tdeg(R) ≤ d。
  have hterm : totalDegreeNecSuf (C (-1) * seNecSuf (n + 1) Q₁) ≤ d :=
    calc totalDegreeNecSuf (C (-1) * seNecSuf (n + 1) Q₁)
        ≤ totalDegreeNecSuf (C (-1) : MvPolynomial (Fin (n + 1)) K) +
            totalDegreeNecSuf (seNecSuf (n + 1) Q₁) :=
          wDeg_mul_le_necSuf exponentTotalNecSuf exponentTotalNecSuf_add _ _
      _ = 0 + totalDegreeNecSuf (seNecSuf (n + 1) Q₁) := by
          rw [show totalDegreeNecSuf (C (-1) : MvPolynomial (Fin (n + 1)) K) = 0 from
            wDeg_C_necSuf exponentTotalNecSuf exponentTotalNecSuf_zero _]
      _ ≤ 0 + wDeg wszNecSuf Q₁ := Nat.add_le_add_left (totalDegree_seNecSuf_le Q₁) _
      _ ≤ d := by rw [Nat.zero_add]; exact hQ₁deg
  have hRdeg : totalDegreeNecSuf R ≤ d := by
    have h := wDeg_sum_le_necSuf exponentTotalNecSuf (Finset.univ : Finset (Fin 2))
      ![P, C (-1) * seNecSuf (n + 1) Q₁] d (fun i _ => by fin_cases i; exacts [hdeg.le, hterm])
    simp only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one] at h
    exact h
  -- P = se(Q_1) + R。
  have hPR : P = seNecSuf (n + 1) Q₁ + R := by
    calc P = P + 0 := (add_zero P).symm
      _ = P + C 0 * seNecSuf (n + 1) Q₁ := by rw [C_0, zero_mul]
      _ = P + (C 1 + C (-1)) * seNecSuf (n + 1) Q₁ := by rw [← C_add, add_neg_cancel]
      _ = P + (C 1 * seNecSuf (n + 1) Q₁ + C (-1) * seNecSuf (n + 1) Q₁) := by rw [add_mul]
      _ = P + (seNecSuf (n + 1) Q₁ + C (-1) * seNecSuf (n + 1) Q₁) := by rw [C_1, one_mul]
      _ = seNecSuf (n + 1) Q₁ + R := by rw [hRdef, ← add_assoc, add_comm P, add_assoc]
  -- R を全変数の積で割る。
  obtain ⟨T, hTF, hTsym, hRT, hTdeg⟩ := symmetricVanishing_divisible_by_product_necSuf S R hRF hRsym hRlz
  by_cases hR0 : R = 0
  · refine ⟨Q₁, hQ₁F, ?_, hQ₁deg⟩
    calc P = seNecSuf (n + 1) Q₁ + R := hPR
      _ = seNecSuf (n + 1) Q₁ + 0 := by rw [hR0]
      _ = seNecSuf (n + 1) Q₁ := add_zero _
  · have hTdeg' := hTdeg hR0
    have hTlt : totalDegreeNecSuf T < d :=
      calc totalDegreeNecSuf T < totalDegreeNecSuf T + (n + 1) := Nat.lt_add_of_pos_right (Nat.succ_pos n)
        _ = totalDegreeNecSuf R := hTdeg'
        _ ≤ d := hRdeg
    obtain ⟨Q₂, hQ₂F, hQ₂eq, hQ₂deg⟩ := ihd _ hTlt T rfl hTF hTsym
    have hQF : Q₁ + X (Fin.last n) * Q₂ ∈ coeffIn S (Fin (n + 1)) :=
      add_mem_coeffIn_fin_necSuf h0 hadd hQ₁F
        (mul_mem_coeffIn_fin_necSuf h0 h1 hadd hmul (X_mem_coeffIn_necSuf h0 h1 _) hQ₂F)
    refine ⟨Q₁ + X (Fin.last n) * Q₂, hQF, ?_, ?_⟩
    · calc P = seNecSuf (n + 1) Q₁ + R := hPR
        _ = seNecSuf (n + 1) Q₁ + esNecSuf (n + 1) (n + 1) * T := by rw [hRT]; rfl
        _ = seNecSuf (n + 1) Q₁ + esNecSuf (n + 1) (n + 1) * seNecSuf (n + 1) Q₂ := by rw [← hQ₂eq]
        _ = seNecSuf (n + 1) Q₁ + esValuesNecSuf (n + 1) (Fin.last n) * seNecSuf (n + 1) Q₂ := rfl
        _ = seNecSuf (n + 1) Q₁ + seNecSuf (n + 1) (X (Fin.last n)) * seNecSuf (n + 1) Q₂ := by
            rw [show seNecSuf (n + 1) (X (Fin.last n) : MvPolynomial (Fin (n + 1)) K) =
              esValuesNecSuf (n + 1) (Fin.last n) from aeval_X _ _]
        _ = seNecSuf (n + 1) (Q₁ + X (Fin.last n) * Q₂) := by rw [map_add, map_mul]
    · calc wDeg wszNecSuf (Q₁ + X (Fin.last n) * Q₂)
          ≤ max (wDeg wszNecSuf Q₁) (wDeg wszNecSuf (X (Fin.last n) * Q₂)) := wDeg_add_le_necSuf _ _ _
        _ ≤ max d (wDeg wszNecSuf (X (Fin.last n) * Q₂)) := max_le_max hQ₁deg le_rfl
        _ ≤ max d ((n + 1) + wDeg wszNecSuf Q₂) :=
            max_le_max le_rfl (wDeg_X_mul_le_necSuf wszNecSuf (Fin.last n) (n + 1)
              wszNecSuf_single_last_add Q₂)
        _ ≤ max d ((n + 1) + totalDegreeNecSuf T) := max_le_max le_rfl (Nat.add_le_add_left hQ₂deg _)
        _ = max d (totalDegreeNecSuf R) := by rw [Nat.add_comm, hTdeg']
        _ = d := max_eq_left hRdeg

/-- `claim_symmetric_polynomial_fundamental_theorem` の必要十分版（係数は可換環 `K`、係数の集合は
`0`・`1`・`−1` を含み和と積で閉じた `S`）。 -/
theorem symmetricPolynomialFundamental_necSuf :
    ∀ (n : ℕ) (P : MvPolynomial (Fin n) K), P ∈ coeffIn S (Fin n) → IsSymNecSuf P →
      ∃ Q ∈ coeffIn S (Fin n), P = seNecSuf n Q ∧ wDeg wszNecSuf Q ≤ totalDegreeNecSuf P
  | 0, P, hF, _ => by
      have hP : P = C (coeff 0 P) := by
        ext a
        rw [Subsingleton.elim a 0, coeff_C, if_pos rfl]
      refine ⟨P, hF, ?_, ?_⟩
      · calc P = C (coeff 0 P) := hP
          _ = seNecSuf 0 (C (coeff 0 P)) := (aeval_C _ _).symm
          _ = seNecSuf 0 P := by rw [← hP]
      · apply Finset.sup_le
        intro a _
        simp [wszNecSuf]
  | n + 1, P, hF, hsym =>
      symmetricPolynomialFundamental_succ_necSuf h0 h1 hneg hadd hmul n
        (symmetricPolynomialFundamental_necSuf n) (totalDegreeNecSuf P) P rfl hF hsym

end Step

end Ising2DLambda.NecSuf.FisherZero
