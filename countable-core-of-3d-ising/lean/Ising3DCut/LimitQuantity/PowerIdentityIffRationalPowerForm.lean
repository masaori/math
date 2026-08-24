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

end Ising3DCut.LimitQuantity
