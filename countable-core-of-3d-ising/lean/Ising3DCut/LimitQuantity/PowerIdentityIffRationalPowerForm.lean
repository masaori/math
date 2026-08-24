/-
人手証明の主張「冪等式が末尾で成り立つことは、分配多項式の値が一つの正の有理数の点数乗である
ことに同値である」（ラベル `claim_power_identity_iff_rational_power_form`）の具体版の前半。

このファイルが担うのは人手証明の次の三段である（後半＝有限素集合からの正の有理数の復元は
続きのファイルで扱う）。

  十分性:  Z_L(q)^{#V_{L+1}} = (c^{#V_L})^{#V_{L+1}}       仮定した表示
                              = c^{#V_L #V_{L+1}}           正の有理数の冪の指数法則
                              = (c^{#V_{L+1}})^{#V_L}       正の有理数の冪の指数法則
                              = Z_{L+1}(q)^{#V_L}           仮定した表示
  必要性の第一段: (L+1)^3 e_L = L^3 e_{L+1} と gcd(L^3,(L+1)^3)=1 から L^3 ∣ e_L
  必要性の第二段: e_L = L^3 t_L, e_{L+1} = (L+1)^3 t_{L+1} を入れて t_{L+1} = t_L

いずれも ℚ と ℤ の等式だけであり、正の実数乗根も箱の大きさの極限も現れない。
-/
import Ising3DCut.LimitQuantity.PartitionValuePositive
import Ising3DCut.LimitQuantity.FinitelyManyPrimesNotSufficient

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 有理点 `q` での有限箱値を有理数のまま並べた列 `L ↦ Z_L(q)`。 -/
noncomputable def rationalValueSeq (q : ℚ) : ℕ → ℚ :=
  fun L => evalAtRational q (partitionPolynomial L)

/-- 人手証明の十分性の段。値が一つの正の有理数の点数乗で書けていれば交差冪等式が成り立つ。 -/
theorem cross_power_identity_of_rational_power_form
    (q c : ℚ) (L0 : ℕ) (siteCount : ℕ → ℕ)
    (h : ∀ L, L0 ≤ L → rationalValueSeq q L = c ^ siteCount L) :
    ∀ L, L0 ≤ L →
      rationalValueSeq q L ^ siteCount (L + 1)
        = rationalValueSeq q (L + 1) ^ siteCount L := by
  intro L hL
  calc
    rationalValueSeq q L ^ siteCount (L + 1)
        = (c ^ siteCount L) ^ siteCount (L + 1) := by rw [h L hL]
    _ = c ^ (siteCount L * siteCount (L + 1)) := by rw [← pow_mul]
    _ = c ^ (siteCount (L + 1) * siteCount L) := by rw [Nat.mul_comm]
    _ = (c ^ siteCount (L + 1)) ^ siteCount L := by rw [← pow_mul]
    _ = rationalValueSeq q (L + 1) ^ siteCount L := by
          rw [h (L + 1) (le_trans hL (Nat.le_succ L))]

/-- 隣接する立方数は互いに素である。 -/
theorem coprime_succ_self (L : ℕ) : Nat.Coprime L (L + 1) := by
  simp [Nat.Coprime, Nat.gcd_self_add_right]

/-- 隣接する立方数は互いに素である。 -/
theorem coprime_cube_succ (L : ℕ) : Nat.Coprime (L ^ 3) ((L + 1) ^ 3) :=
  Nat.Coprime.pow _ _ (coprime_succ_self L)

/-- 人手証明の必要性の第一段。素指数の交差等式から `L^3` が `e_L` を割る。 -/
theorem cube_dvd_of_cross_exponent_eq {L : ℕ} (e f : ℤ)
    (h : ((L : ℤ) + 1) ^ 3 * e = (L : ℤ) ^ 3 * f) :
    ((L : ℤ) ^ 3) ∣ e := by
  have hcop' : IsCoprime ((L : ℤ) ^ 3) (((L : ℤ) + 1) ^ 3) := by
    have h0 := Nat.isCoprime_iff_coprime.mpr (coprime_cube_succ L)
    push_cast at h0
    exact h0
  have hdvd : ((L : ℤ) ^ 3) ∣ ((L : ℤ) + 1) ^ 3 * e := ⟨f, h⟩
  exact (hcop'.dvd_of_dvd_mul_left hdvd)

/-- 人手証明の必要性の第二段。商は隣接する箱で変わらない。 -/
theorem quotient_eq_of_cross_exponent_eq {L : ℕ} (hL : 0 < L) (t t' : ℤ)
    (h : ((L : ℤ) + 1) ^ 3 * ((L : ℤ) ^ 3 * t) = (L : ℤ) ^ 3 * (((L : ℤ) + 1) ^ 3 * t')) :
    t' = t := by
  have hL0 : ((L : ℤ) ^ 3) ≠ 0 := by
    have : (0 : ℤ) < (L : ℤ) := by exact_mod_cast hL
    positivity
  have hL1 : (((L : ℤ) + 1) ^ 3) ≠ 0 := by
    have : (0 : ℤ) < (L : ℤ) + 1 := by
      have : (0 : ℤ) ≤ (L : ℤ) := Int.natCast_nonneg L
      linarith
    positivity
  have h' : ((L : ℤ) + 1) ^ 3 * (L : ℤ) ^ 3 * t
      = ((L : ℤ) + 1) ^ 3 * (L : ℤ) ^ 3 * t' := by ring_nf; ring_nf at h; linarith [h]
  have hne : ((L : ℤ) + 1) ^ 3 * (L : ℤ) ^ 3 ≠ 0 := mul_ne_zero hL1 hL0
  exact (mul_left_cancel₀ hne h').symm

/-- 人手証明の必要性の第三段の前半。正の有理数の非零素指数は有限集合に収まる。 -/
theorem finite_prime_support_of_rat (a : ℚ) :
    ∃ S : Finset ℕ, ∀ p : ℕ, p.Prime → p ∉ S → padicValRat p a = 0 := by
  refine ⟨a.num.natAbs.factorization.support ∪ a.den.factorization.support, ?_⟩
  intro p hp hpS
  have hpNum : p ∉ a.num.natAbs.factorization.support := by
    exact fun hmem => hpS (Finset.mem_union_left _ hmem)
  have hpDen : p ∉ a.den.factorization.support := by
    exact fun hmem => hpS (Finset.mem_union_right _ hmem)
  have hnum : padicValNat p a.num.natAbs = 0 := by
    rw [← Nat.factorization_def _ hp]
    exact Finsupp.notMem_support_iff.mp hpNum
  have hden : padicValNat p a.den = 0 := by
    rw [← Nat.factorization_def _ hp]
    exact Finsupp.notMem_support_iff.mp hpDen
  rw [padicValRat, padicValInt, hnum, hden]
  simp

/-- 人手証明の必要性の第三段の後半で用いる復元の有限積。非零な素指数を持つ素数の有限集合 `S`
と整数値の指数 `t` から、正の有理数の候補 `∏_{p∈S} p^{t p}` を作る。指数は負でもよいので
整数冪（`zpow`）を使う。 -/
noncomputable def primePowerProduct (S : Finset ℕ) (t : ℕ → ℤ) : ℚ :=
  ∏ p ∈ S, (p : ℚ) ^ (t p)

/-- 復元の有限積は正の有理数である。各因子は正の素数の整数冪だからである。 -/
theorem primePowerProduct_pos {S : Finset ℕ} (t : ℕ → ℤ)
    (hS : ∀ p ∈ S, Nat.Prime p) : 0 < primePowerProduct S t := by
  refine Finset.prod_pos ?_
  intro p hp
  have hp0 : (0 : ℚ) < (p : ℚ) := by
    exact_mod_cast (hS p hp).pos
  exact zpow_pos hp0 _

/-- 復元の有限積の素数 `r` における素指数は、`r` が有限集合に属するとき指定値 `t r`、
属さないとき零である。有限積の各因子へ付値の積法則を一つずつ適用する。 -/
theorem padicValRat_primePowerProduct {S : Finset ℕ} (t : ℕ → ℤ)
    (hS : ∀ p ∈ S, Nat.Prime p) (r : ℕ) (hr : Nat.Prime r) :
    padicValRat r (primePowerProduct S t) = if r ∈ S then t r else 0 := by
  letI : Fact (Nat.Prime r) := ⟨hr⟩
  classical
  induction S using Finset.induction_on with
  | empty => simp [primePowerProduct]
  | @insert p S hpS ih =>
      have hpPrime : Nat.Prime p := hS p (Finset.mem_insert_self p S)
      have hp0 : (p : ℚ) ≠ 0 := by exact_mod_cast hpPrime.ne_zero
      have hProd0 : primePowerProduct S t ≠ 0 := by
        apply Finset.prod_ne_zero_iff.mpr
        intro s hs
        exact zpow_ne_zero _ (by exact_mod_cast (hS s (Finset.mem_insert_of_mem hs)).ne_zero)
      have hrec : primePowerProduct (insert p S) t =
          (p : ℚ) ^ (t p) * primePowerProduct S t := by
        simp [primePowerProduct, hpS]
      rw [hrec, padicValRat.mul (zpow_ne_zero _ hp0) hProd0, padicValRat.zpow]
      rw [ih (fun s hs => hS s (Finset.mem_insert_of_mem hs))]
      by_cases hpr : p = r
      · subst p
        simp [hpS, hr.one_lt]
      · have hval : padicValRat r (p : ℚ) = 0 :=
          padicValRat_prime_ne r p hr hpPrime (Ne.symm hpr)
        simp [Ne.symm hpr, hval]

end Ising3DCut.LimitQuantity
