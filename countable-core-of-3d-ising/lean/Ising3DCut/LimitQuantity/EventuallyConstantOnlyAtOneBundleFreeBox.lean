/-
接続の第六段の第六歩。前歩で得た「有理点の既約分母は破れ数ゼロの多重度と
底の既約分母の点数乗との積を割る」を、実際の自由境界の箱へ渡す一段。

渡すのに要るのは二つだけである。一つは回文性 `Ω_L(#E_L) = Ω_L(0)`
（`NullModel.multiplicity_palindrome` を破れ数 `#E_L` で読む）。
もう一つは破れ数ゼロの多重度がちょうど `2` であること
（`NullModel.multiplicity_zero_eq_two`）。この二つを入れると、
前歩の結論の右辺が `2 * c.den ^ N` という箱に依存しない形になる。

一つの箱に固定した有限の主張であり、極限も無限和も現れない。
-/
import Ising3DCut.LimitQuantity.EventuallyConstantOnlyAtOneBundle
import Ising3DCut.LimitQuantity.NullModelEvalNeInv
import Ising3DCut.NullModel.MultiplicityPalindrome
import Ising3DCut.NullModel.ZeroBreakageConstant
import Ising3DCut.NullModel.SquareAroundEdge

namespace Ising3DCut.LimitQuantity

/-- 自由境界の箱 `L` の多重度を入れると、前歩の整除は
`q.den ∣ 2 * c.den ^ N` という箱に依存しない形になる。 -/
theorem point_den_dvd_two_mul_base_den_pow_from_free_box
    {q c : ℚ} {L N : ℕ} (hL : 0 < L) (hc : 0 < c)
    (hE : 1 ≤ Fintype.card (NullModel.Edge L))
    (hrep : (brokenCountSum (NullModel.multiplicity L) q.num.natAbs q.den
          (Fintype.card (NullModel.Edge L)) : ℚ) /
        (q.den : ℚ) ^ (Fintype.card (NullModel.Edge L)) = c ^ N) :
    q.den ∣ 2 * c.den ^ N := by
  have hpal : NullModel.multiplicity L (Fintype.card (NullModel.Edge L)) = NullModel.multiplicity L 0 := by
    have h := NullModel.multiplicity_palindrome (L := L) (m := Fintype.card (NullModel.Edge L)) (le_refl _)
    simpa using h
  have hdvd := point_den_dvd_zero_multiplicity_mul_base_den_pow_from_finite_box
    (q := q) (c := c) (E := Fintype.card (NullModel.Edge L)) (N := N)
    (NullModel.multiplicity L) hc hE hpal hrep
  rwa [NullModel.multiplicity_zero_eq_two hL] at hdvd

/-- 自由境界の箱 `L` の有理評価は、破れ辺数の多重度で書いた自然数の有限和を
点の既約分母の辺数乗で割ったものに等しい。分母を払った有限和へ展開するだけであり、
極限も無限和も現れない（和は辺数までの有限和である）。 -/
theorem rationalValueSeq_eq_brokenCountSum_div
    {q : ℚ} (hq : 0 < q) (L : ℕ) :
    rationalValueSeq q L =
      (brokenCountSum (NullModel.multiplicity L) q.num.natAbs q.den
          (Fintype.card (NullModel.Edge L)) : ℚ) /
        (q.den : ℚ) ^ (Fintype.card (NullModel.Edge L)) := by
  have hqrep : q = (q.num.natAbs : ℚ) / (q.den : ℚ) := by
    rw [Nat.cast_natAbs, abs_of_pos (Rat.num_pos.mpr hq), Rat.num_div_den]
  symm
  simp only [brokenCountSum, rationalValueSeq, NullModel.partitionPolynomial,
    evalAtRational, map_sum, Polynomial.coe_eval₂RingHom,
    Polynomial.eval₂_monomial, eq_intCast]
  rw [div_eq_iff (pow_ne_zero _ (by exact_mod_cast q.den_nz)), Finset.sum_mul]
  push_cast
  apply Finset.sum_congr rfl
  intro m hm
  have hmle : m ≤ Fintype.card (NullModel.Edge L) :=
    Nat.le_of_lt_succ (Finset.mem_range.mp hm)
  have hpow : q ^ m * (q.den : ℚ) ^ Fintype.card (NullModel.Edge L) =
      (q.num.natAbs : ℚ) ^ m * (q.den : ℚ) ^
        (Fintype.card (NullModel.Edge L) - m) := by
    nth_rewrite 1 [hqrep]
    rw [div_pow]
    field_simp
    rw [← pow_add, Nat.add_sub_of_le hmle]
  simpa [mul_assoc] using
    congrArg (fun x : ℚ => (NullModel.multiplicity L m : ℚ) * x) hpow.symm

/-- 上の有限和は正である。破れ辺数 `0` の項が多重度 `2` と点の既約分母の辺数乗の積で
あり、残りの項はすべて非負だからである。 -/
theorem brokenCountSum_multiplicity_pos
    {q : ℚ} {L : ℕ} (hL : 0 < L) :
    0 < brokenCountSum (NullModel.multiplicity L) q.num.natAbs q.den
      (Fintype.card (NullModel.Edge L)) := by
  refine Finset.sum_pos' (fun m _ => Nat.zero_le _)
    ⟨0, Finset.mem_range.mpr (Nat.succ_pos _), ?_⟩
  rw [NullModel.multiplicity_zero_eq_two hL]
  simp only [pow_zero, mul_one, Nat.sub_zero]
  exact Nat.mul_pos (by norm_num) (pow_pos q.den_pos _)

/-- 閾値の箱が少なくとも二点幅なら、末尾の点数乗表示そのものから
束ね定理が要求する法 `q.den` の整除が得られる。 -/
theorem point_den_dvd_two_mul_base_den_pow_of_rational_value_form
    {q c : ℚ} {L₀ : ℕ} (hq : 0 < q) (hL₀ : 2 ≤ L₀) (hc : 0 < c)
    (hform : ∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) :
    q.den ∣ 2 * c.den ^ (L₀ ^ 3) := by
  apply point_den_dvd_two_mul_base_den_pow_from_free_box
    (L := L₀) (N := L₀ ^ 3) (lt_of_lt_of_le (by norm_num) hL₀) hc
    (one_le_card_edge hL₀)
  rw [← rationalValueSeq_eq_brokenCountSum_div hq L₀]
  exact hform L₀ (le_refl _)

/-- 束ね定理が要求する第一の仮定への接続。点の既約分母を割らない素数は、
末尾の点数乗表示の底の既約分母も割らない。閾値の箱の有理評価を有限和の商へ
展開し、既存の素指数の主張へ渡すだけであり、極限は使わない。 -/
theorem prime_not_dvd_base_den_of_rational_value_form
    {q c : ℚ} {L₀ : ℕ} (hq : 0 < q) (hL₀ : 0 < L₀) (hc : 0 < c)
    (hform : ∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3))
    (p : ℕ) (hp : p.Prime) (hpNotDvd : ¬ p ∣ q.den) :
    ¬ p ∣ c.den :=
  odd_prime_not_dvd_power_base_den_from_finite_box_representation
    (L := L₀) hc hL₀ (le_refl _) hform
    (rationalValueSeq_eq_brokenCountSum_div hq L₀)
    (brokenCountSum_multiplicity_pos hL₀) p hp hpNotDvd

/-- 上の系として、点の既約分母が奇数であれば素数 `2` も底の既約分母を割らない。
束ね定理が要求する第二の仮定のうち、点の既約分母が奇数である場合を埋める。 -/
theorem two_not_dvd_base_den_of_rational_value_form_of_odd_point_den
    {q c : ℚ} {L₀ : ℕ} (hq : 0 < q) (hL₀ : 0 < L₀) (hc : 0 < c)
    (hform : ∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3))
    (hodd : ¬ (2 : ℕ) ∣ q.den) :
    ¬ (2 : ℕ) ∣ c.den :=
  prime_not_dvd_base_den_of_rational_value_form hq hL₀ hc hform 2 Nat.prime_two hodd

/-- 偶数分母の場合の接続の第一歩。末尾の点数乗表示を一つの箱 `L` で読み、
有理点と底の既約分子・分母だけで書いた自然数の等式へ移す。
有理数の分母を払う一段だけであり、極限は使わない。 -/
theorem integer_equation_of_rational_value_form
    {q c : ℚ} {L₀ L : ℕ} (hq : 0 < q) (hc : 0 < c) (hL₀L : L₀ ≤ L)
    (hform : ∀ K, L₀ ≤ K → rationalValueSeq q K = c ^ (K ^ 3)) :
    brokenCountSum (NullModel.multiplicity L) q.num.natAbs q.den
          (Fintype.card (NullModel.Edge L)) * c.den ^ (L ^ 3) =
      c.num.natAbs ^ (L ^ 3) * q.den ^ (Fintype.card (NullModel.Edge L)) := by
  have hcRep : c = (c.num.natAbs : ℚ) / (c.den : ℚ) := by
    rw [Nat.cast_natAbs, abs_of_pos (Rat.num_pos.mpr hc), Rat.num_div_den]
  have hrep := (rationalValueSeq_eq_brokenCountSum_div hq L).symm.trans
    (hform L hL₀L)
  rw [hcRep] at hrep
  have hInt := integer_equation_of_rational_representation
    (brokenCountSum (NullModel.multiplicity L) q.num.natAbs q.den
      (Fintype.card (NullModel.Edge L))) q.den c.num.natAbs c.den
      (Fintype.card (NullModel.Edge L)) (L ^ 3) q.den_pos c.den_pos hrep
  exact_mod_cast hInt

/-- 偶数分母の場合の接続の第二歩。自由境界の箱 `L` について、破れ辺数が
辺数から `1` を引いた数である配位は存在しない。回文性で破れ辺数 `1` の場合へ移し、
破れ辺数がちょうど `1` の配位が無いこと（`brokenCount_ne_one`）を使う。
一つの箱に固定した有限の主張であり、極限は使わない。 -/
theorem multiplicity_card_edge_sub_one_eq_zero {L : ℕ} (hL : 2 ≤ L) :
    NullModel.multiplicity L (Fintype.card (NullModel.Edge L) - 1) = 0 := by
  have hE : 1 ≤ Fintype.card (NullModel.Edge L) := one_le_card_edge hL
  have hpal := NullModel.multiplicity_palindrome (L := L) (m := 1) hE
  have hone : NullModel.multiplicity L 1 = 0 := by
    rw [NullModel.multiplicity, Fintype.card_eq_zero_iff]
    constructor
    intro σ
    exact NullModel.brokenCount_ne_one hL σ.1 ((Finset.mem_filter.mp σ.2).2)
  exact hpal ▸ hone

end Ising3DCut.LimitQuantity
