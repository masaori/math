/-
「有限箱の量が末尾で一定となる正の有理点は 1 に限られる」の Lean 具体版へ
向けた接続の第二段。冪等式の末尾成立から正の有理数の点数乗表示を取り出し、
その底の既約分母が 1 であることを受け取って自然数の底へ移し、既に示した
三点の候補からの分岐へ渡して 1 に定める。

扱うのは有限箱の有理評価・自然数冪・有理数の既約分母だけであり、極限は使わない。
候補が三点に尽きること自体は、既約分子と既約分母がともに 2 を割ることから
この場で示す。既約分母が 2 を割ることと底の既約分母が 1 であることは、
本文の合同式による絞り込みから第三段で受け取り、既約分子が 2 を割ることは、
分母 1 と分母 2 の各場合について有限箱側の定理から第四段・第五段で受け取る。
第五段では有限箱データそのものを仮定に置き、分子についての結論を外から
受け取らない形にしてある。底の既約分母についての三つの仮定（奇素数・2・
法 q.den の整除）だけが、本文の先行主張の結論として残る。
-/
import Ising3DCut.LimitQuantity.EventuallyConstantOnlyAtOne
import Ising3DCut.LimitQuantity.CrossPowerIdentityIffRationalPowerFormFromNecSuf
import Ising3DCut.LimitQuantity.DenominatorTwoPointAndFinalCandidateSet
import Ising3DCut.LimitQuantity.RationalPowerPointDenominatorDividesTwo
import Ising3DCut.LimitQuantity.IntegerPointNumeratorDividesTwo
import Ising3DCut.LimitQuantity.DenominatorTwoNumeratorEqualsOne
import Ising3DCut.LimitQuantity.RationalPowerBaseDenominatorPrimes
import Ising3DCut.LimitQuantity.RationalPowerBaseDenTwoExponentOneImpossible
import Ising3DCut.LimitQuantity.RationalPowerBaseDenTwoExponentAtLeastTwoImpossible

namespace Ising3DCut.LimitQuantity

/-- 接続の第六段の先頭。閾値以後の一つの有限箱値を既約な有理点の分母を用いて
正整数の商として表示できれば、その分母を割らない奇素数は点数乗表示の底の
既約分母も割らない。有限箱表示と点数乗表示を同じ箱で結び、既存の素指数の
主張へ渡すだけであり、極限は使わない。 -/
theorem odd_prime_not_dvd_power_base_den_from_finite_box_representation
    {q c : ℚ} {L₀ P E L : ℕ}
    (hc : 0 < c) (hL : 0 < L) (hL₀L : L₀ ≤ L)
    (hform : ∀ K, L₀ ≤ K → rationalValueSeq q K = c ^ (K ^ 3))
    (hvalue : rationalValueSeq q L = (P : ℚ) / (q.den : ℚ) ^ E)
    (hP : 0 < P) (p : ℕ) (hp : p.Prime) (hpNotDvd : ¬ p ∣ q.den) :
    ¬ p ∣ c.den := by
  have hN : 0 < L ^ 3 := pow_pos hL 3
  have hrep : (P : ℚ) / (q.den : ℚ) ^ E = c ^ (L ^ 3) := by
    calc
      (P : ℚ) / (q.den : ℚ) ^ E = rationalValueSeq q L := hvalue.symm
      _ = c ^ (L ^ 3) := hform L hL₀L
  exact rational_power_base_den_not_dvd_of_not_dvd
    p P q.den E (L ^ 3) hp hP q.den_pos hN hpNotDvd c hc hrep

/-- 接続の第六段の第二歩。閾値以後の一つの有限箱値を既約な有理点の分母を用いて
正整数の商として表示でき、かつその分母が奇数であれば、素数 `2` も点数乗表示の底の
既約分母を割らない。前の歩と同じ有限箱表示を、素数 `2` について読み直すだけであり、
極限は使わない。点の分母が偶数の場合はこの経路では閉じないので、別の歩で扱う。 -/
theorem two_not_dvd_power_base_den_from_finite_box_representation
    {q c : ℚ} {L₀ P E L : ℕ}
    (hc : 0 < c) (hL : 0 < L) (hL₀L : L₀ ≤ L)
    (hform : ∀ K, L₀ ≤ K → rationalValueSeq q K = c ^ (K ^ 3))
    (hvalue : rationalValueSeq q L = (P : ℚ) / (q.den : ℚ) ^ E)
    (hP : 0 < P) (hodd : ¬ (2 : ℕ) ∣ q.den) :
    ¬ (2 : ℕ) ∣ c.den :=
  odd_prime_not_dvd_power_base_den_from_finite_box_representation
    hc hL hL₀L hform hvalue hP 2 Nat.prime_two hodd

/-- 接続の第六段の第三歩。点の既約分母が偶数のとき、その素数 `2` の指数は
`1` か `2` 以上である。底の既約分母が偶数だと仮定したうえで、それぞれの場合を
有限箱の先行定理で排除できれば、`2` は底の既約分母を割らない。
場合分けは点の既約分母の指数について行う（先行の二つの排除定理が場合分けしているのは
点の既約分母の指数であり、底の既約分母については偶数であることだけを使う）。
この歩は場合分けだけを担い、極限は使わない。 -/
theorem two_not_dvd_power_base_den_of_point_den_exponent_cases
    {q c : ℚ} (hden : (2 : ℕ) ∣ q.den)
    (hone : (2 : ℕ) ∣ c.den → q.den.factorization 2 = 1 → False)
    (hgeTwo : (2 : ℕ) ∣ c.den → 2 ≤ q.den.factorization 2 → False) :
    ¬ (2 : ℕ) ∣ c.den := by
  intro htwo
  have hpos : 0 < q.den.factorization 2 :=
    Nat.Prime.factorization_pos_of_dvd Nat.prime_two q.den_nz hden
  by_cases hone' : q.den.factorization 2 = 1
  · exact hone htwo hone'
  · exact hgeTwo htwo (by omega)

/-- 接続の第六段の第四歩。点の既約分母が偶数のとき、閾値以後の一つの箱 `M` について
破れ辺数の多重度で書いた有限和と点数乗表示を結ぶ自然数の等式があれば、
素数 `2` は点数乗表示の底の既約分母を割らない。
点の既約分母の素数 `2` の指数が `1` の場合と `2` 以上の場合の排除定理へ、
既約性と正値性を渡して分岐させるだけであり、極限は使わない。 -/
theorem two_not_dvd_power_base_den_from_finite_box_even_point_den
    {q c : ℚ} {M : ℕ} (Omega : ℕ → ℕ)
    (hq : 0 < q) (hc : 0 < c) (hM : 2 ≤ M)
    (hden : (2 : ℕ) ∣ q.den)
    (hOmegaPen : Omega (3 * M ^ 2 * (M - 1) - 1) = 0)
    (hOmegaTop : Omega (3 * M ^ 2 * (M - 1)) = 2)
    (hid : (∑ m ∈ Finset.range (3 * M ^ 2 * (M - 1) + 1),
              Omega m * q.num.natAbs ^ m * q.den ^ (3 * M ^ 2 * (M - 1) - m))
              * c.den ^ (M ^ 3)
            = c.num.natAbs ^ (M ^ 3) * q.den ^ (3 * M ^ 2 * (M - 1))) :
    ¬ (2 : ℕ) ∣ c.den := by
  have hqnum : 0 < q.num.natAbs := Int.natAbs_pos.mpr (Rat.num_ne_zero.mpr hq.ne')
  have hcnum : 0 < c.num.natAbs := Int.natAbs_pos.mpr (Rat.num_ne_zero.mpr hc.ne')
  refine two_not_dvd_power_base_den_of_point_den_exponent_cases hden ?_ ?_
  · intro hv2 heb
    exact rational_power_base_den_two_exponent_one_impossible Omega
      q.num.natAbs q.den c.num.natAbs c.den M hqnum q.den_pos hcnum c.den_pos
      q.reduced c.reduced hv2 hM hOmegaPen hOmegaTop heb hid
  · intro hv2 heb
    exact rational_power_base_den_two_exponent_at_least_two_impossible Omega
      q.num.natAbs q.den c.num.natAbs c.den M hqnum q.den_pos hcnum c.den_pos
      q.reduced c.reduced hv2 hM hOmegaTop heb hid

/-- 正の有理点の既約分子と既約分母がともに `2` を割るなら、候補は三点に尽きる。 -/
theorem positive_rational_three_candidates_of_num_den_dvd_two
    {q : ℚ} (hq : 0 < q)
    (hnum : q.num.natAbs ∣ 2) (hden : q.den ∣ 2) :
    q = 1 / 2 ∨ q = 1 ∨ q = 2 := by
  have hnumPos : 0 < q.num.natAbs := Int.natAbs_pos.mpr (Rat.num_ne_zero.mpr hq.ne')
  have hdenPos : 0 < q.den := q.den_pos
  rcases positive_integer_dvd_two_candidates hnumPos hnum with hn | hn
  · rcases positive_integer_dvd_two_candidates hdenPos hden with hd | hd
    · right; left
      rw [← Rat.num_div_den q]
      rw [show q.num = 1 by
        have hqnum : (0 : ℤ) < q.num := Rat.num_pos.mpr hq
        omega]
      norm_num [hd]
    · left
      rw [← Rat.num_div_den q]
      rw [show q.num = 1 by
        have hqnum : (0 : ℤ) < q.num := Rat.num_pos.mpr hq
        omega]
      norm_num [hd]
  · rcases positive_integer_dvd_two_candidates hdenPos hden with hd | hd
    · right; right
      rw [← Rat.num_div_den q]
      rw [show q.num = 2 by
        have hqnum : (0 : ℤ) < q.num := Rat.num_pos.mpr hq
        omega]
      norm_num [hd]
    · exfalso
      have hnot : ¬Nat.Coprime q.num.natAbs q.den := by
        rw [hn, hd]
        norm_num
      exact hnot q.reduced

/-- 有理点の既約分母が `2` を割り、分母 `1` と分母 `2` の各場合について
有限箱側の既存定理から得た分子の結論があれば、既約分子は `2` を割る。 -/
theorem rational_point_numerator_divides_two_of_denominator_cases
    {q : ℚ} (hden : q.den ∣ 2)
    (hdenOne : q.den = 1 → q.num.natAbs ∣ 2)
    (hdenTwo : q.den = 2 → q.num.natAbs = 1) :
    q.num.natAbs ∣ 2 := by
  rcases positive_integer_dvd_two_candidates q.den_pos hden with hd | hd
  · exact hdenOne hd
  · rw [hdenTwo hd]
    exact one_dvd 2

/-- 冪等式が閾値以後で成り立ち、そこから決まる底の既約分母が 1 であり、
候補が三点に尽きているなら、有理点は 1 である。 -/
theorem eq_one_of_cross_power_identity_of_den_one
    {q : ℚ} (hq : 0 < q) {L₀ : ℕ} (hL₀ : 0 < L₀)
    (hcross : ∀ L, L₀ ≤ L →
      rationalValueSeq q L ^ ((L + 1) ^ 3) = rationalValueSeq q (L + 1) ^ (L ^ 3))
    (hden : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) → c.den = 1)
    (hqnum : q.num.natAbs ∣ 2) (hqden : q.den ∣ 2) :
    q = 1 := by
  obtain ⟨c, hcpos, hform⟩ :=
    (eventually_cross_power_identity_iff_rational_power_form_viaNecSuf q hq L₀ hL₀).mp hcross
  have hpower : EventualPowerFormAt q :=
    eventualPowerFormAt_of_rationalPowerForm_den_one hcpos (hden c hcpos hform) hL₀ hform
  exact eq_one_of_eventual_power_form hpower
    (positive_rational_three_candidates_of_num_den_dvd_two hq hqnum hqden)

/-- 接続の第三段。底の既約分母が 1 であることと、有理点の既約分母が `2` を割ることを、
既に示した「点数乗表示が成り立つ正の有理点の既約分母は 2 を割る」から同時に受け取る。

`hodd`（奇素数は底の既約分母を割らない）・`htwo`（2 も割らない）・`hdvd`（法 `q.den` の整除）は
本文の三つの先行主張の結論であり、ここではそれぞれ仮定として受け取る。
既約分子が `2` を割ることだけが未接続なので、`hqnum` として残す。 -/
theorem eq_one_of_cross_power_identity_of_base_den_conditions
    {q : ℚ} (hq : 0 < q) {L₀ : ℕ} (hL₀ : 0 < L₀)
    (hcross : ∀ L, L₀ ≤ L →
      rationalValueSeq q L ^ ((L + 1) ^ 3) = rationalValueSeq q (L + 1) ^ (L ^ 3))
    (hodd : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) →
      ∀ p : ℕ, p.Prime → p ≠ 2 → ¬ p ∣ c.den)
    (htwo : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) → ¬ (2 : ℕ) ∣ c.den)
    (hdvd : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) →
      q.den ∣ 2 * c.den ^ (L₀ ^ 3))
    (hqnum : q.num.natAbs ∣ 2) :
    q = 1 := by
  obtain ⟨c, hcpos, hform⟩ :=
    (eventually_cross_power_identity_iff_rational_power_form_viaNecSuf q hq L₀ hL₀).mp hcross
  obtain ⟨hcden, hqden⟩ :=
    rational_power_point_denominator_divides_two c q.den (L₀ ^ 3)
      (hodd c hcpos hform) (htwo c hcpos hform) (hdvd c hcpos hform)
  have hpower : EventualPowerFormAt q :=
    eventualPowerFormAt_of_rationalPowerForm_den_one hcpos hcden hL₀ hform
  exact eq_one_of_eventual_power_form hpower
    (positive_rational_three_candidates_of_num_den_dvd_two hq hqnum hqden)

/-- 接続の第四段。底と有理点の既約分母についての三条件に加え、
有理点の分母が `1` の場合と `2` の場合に既存の有限箱定理が与える結論を束ね、
外から既約分子の整除を仮定せずに有理点を `1` に定める。 -/
theorem eq_one_of_cross_power_identity_of_finite_box_numerator_conditions
    {q : ℚ} (hq : 0 < q) {L₀ : ℕ} (hL₀ : 0 < L₀)
    (hcross : ∀ L, L₀ ≤ L →
      rationalValueSeq q L ^ ((L + 1) ^ 3) = rationalValueSeq q (L + 1) ^ (L ^ 3))
    (hodd : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) →
      ∀ p : ℕ, p.Prime → p ≠ 2 → ¬ p ∣ c.den)
    (htwo : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) → ¬ (2 : ℕ) ∣ c.den)
    (hdvd : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) →
      q.den ∣ 2 * c.den ^ (L₀ ^ 3))
    (hdenOne : q.den = 1 → q.num.natAbs ∣ 2)
    (hdenTwo : q.den = 2 → q.num.natAbs = 1) :
    q = 1 := by
  obtain ⟨c, hcpos, hform⟩ :=
    (eventually_cross_power_identity_iff_rational_power_form_viaNecSuf q hq L₀ hL₀).mp hcross
  obtain ⟨hcden, hqden⟩ :=
    rational_power_point_denominator_divides_two c q.den (L₀ ^ 3)
      (hodd c hcpos hform) (htwo c hcpos hform) (hdvd c hcpos hform)
  have hqnum : q.num.natAbs ∣ 2 :=
    rational_point_numerator_divides_two_of_denominator_cases hqden hdenOne hdenTwo
  have hpower : EventualPowerFormAt q :=
    eventualPowerFormAt_of_rationalPowerForm_den_one hcpos hcden hL₀ hform
  exact eq_one_of_eventual_power_form hpower
    (positive_rational_three_candidates_of_num_den_dvd_two hq hqnum hqden)

/-- 接続の第五段。分母 `1` と分母 `2` の各場合について、有限箱側の定理が消費する
データそのものを仮定に置き、分子についての結論を外から受け取らずに有理点を `1` に定める。

`hdenOneData` は、有理点が正の自然数である場合に、ある有限箱の多重度表示とその値に対する
分子の整除が取れることを述べる。`hdenTwoData` は、既約分母が `2` の場合に、分母を払った
有限箱等式と分子の整除が取れることを述べる。いずれも一つの箱に固定した有限の主張であり、
極限も無限和も現れない。 -/
theorem eq_one_of_cross_power_identity_from_finite_box_data
    {q : ℚ} (hq : 0 < q) {L₀ : ℕ} (hL₀ : 0 < L₀)
    (hcross : ∀ L, L₀ ≤ L →
      rationalValueSeq q L ^ ((L + 1) ^ 3) = rationalValueSeq q (L + 1) ^ (L ^ 3))
    (hodd : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) →
      ∀ p : ℕ, p.Prime → p ≠ 2 → ¬ p ∣ c.den)
    (htwo : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) → ¬ (2 : ℕ) ∣ c.den)
    (hdvd : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) →
      q.den ∣ 2 * c.den ^ (L₀ ^ 3))
    (hdenOneData : q.den = 1 → ∃ E Z L : ℕ, 0 < L ∧
      Z = ∑ m ∈ Finset.range (E + 1), NullModel.multiplicity L m * q.num.natAbs ^ m ∧
      q.num.natAbs ∣ 2 * (Z - 1))
    (hdenTwoData : q.den = 2 → ∃ E c n L S : ℕ, 0 < L ∧
      (2 : ℤ) ^ E * (c : ℤ) ^ n =
        (2 : ℤ) ^ E * (NullModel.multiplicity L 0 : ℤ) + (q.num.natAbs : ℤ) * S ∧
      (q.num.natAbs : ℤ) ∣ 2 * ((c : ℤ) ^ n - 1)) :
    q = 1 := by
  have hdenOne : q.den = 1 → q.num.natAbs ∣ 2 := by
    intro hd
    obtain ⟨E, Z, L, hLpos, hZ, hdvdZ⟩ := hdenOneData hd
    exact integer_point_numerator_divides_two hLpos hZ hdvdZ
  have hdenTwo : q.den = 2 → q.num.natAbs = 1 := by
    intro hd
    obtain ⟨E, c, n, L, S, hLpos, hscaled, hdvdc⟩ := hdenTwoData hd
    have hcoprime : Nat.Coprime q.num.natAbs 2 := by
      have := q.reduced
      rwa [hd] at this
    exact denominator_two_numerator_eq_one_from_finite_box hLpos hcoprime hscaled hdvdc
  exact eq_one_of_cross_power_identity_of_finite_box_numerator_conditions
    hq hL₀ hcross hodd htwo hdvd hdenOne hdenTwo

end Ising3DCut.LimitQuantity
