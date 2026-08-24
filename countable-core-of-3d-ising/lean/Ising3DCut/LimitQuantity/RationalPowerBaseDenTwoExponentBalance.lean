/-
人手証明「点数乗表示の底の既約分母が偶数なら素数 2 の指数について釣り合い式が成り立つ」
（ラベル `claim_rational_power_base_den_two_exponent_balance`）の Lean 具体版。

人手証明と同じ順で進む。
第一段: `v` の素因子が `b` の素因子であることから `2 ∣ b`、
        `a` と `b` の互いに素性から `2 ∤ a`、`u` と `v` の互いに素性から `2 ∤ u`。
第二段: 整数の等式 `P_M * v^(#V_M) = u^(#V_M) * b^(#E_M)` の両辺で素数 2 の指数を取る。
        奇素数の場合と違い `v_2(P_M)` は 0 と言えないので、消さずに左辺へ残す。
第三段: 積と冪の指数の法則で両辺を展開し、`2 ∤ u` により `u` の寄与だけが消える。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenNoPrimeMissingZeroMultiplicity

namespace Ising3DCut.LimitQuantity

/-- 人手証明の第一段。`2 ∣ b` と `a` `b` の互いに素性から `2 ∤ a`。 -/
theorem not_two_dvd_numerator_of_two_dvd_denominator
    (a b : ℕ) (hab : Nat.Coprime a b) (hb : 2 ∣ b) : ¬ 2 ∣ a := by
  intro ha
  have : (2 : ℕ) ∣ 1 := hab ▸ Nat.dvd_gcd ha hb
  omega

/-- 人手証明の第二段と第三段。整数の等式の両辺で素数 2 の指数を取り、
`2 ∤ u` により `u` の寄与を消して釣り合い式を得る。
`v_2(P)` は左辺に残したままである（奇素数の場合と違い 0 とは言えない）。 -/
theorem two_exponent_balance_of_integer_identity
    (P u v b V E : ℕ)
    (hP : 0 < P) (hu : 0 < u) (hv : 0 < v) (hb : 0 < b)
    (hu2 : ¬ 2 ∣ u)
    (hid : P * v ^ V = u ^ V * b ^ E) :
    P.factorization 2 + V * v.factorization 2 = E * b.factorization 2 := by
  have hufac : u.factorization 2 = 0 := Nat.factorization_eq_zero_of_not_dvd hu2
  have hleft : (P * v ^ V).factorization 2 = P.factorization 2 + V * v.factorization 2 := by
    rw [Nat.factorization_mul hP.ne' (pow_ne_zero _ hv.ne'), Nat.factorization_pow]
    simp
  have hright : (u ^ V * b ^ E).factorization 2 = E * b.factorization 2 := by
    rw [Nat.factorization_mul (pow_ne_zero _ hu.ne') (pow_ne_zero _ hb.ne'),
      Nat.factorization_pow, Nat.factorization_pow]
    simp [hufac]
  rw [← hleft, ← hright, hid]

/-- 人手証明の全体。底の既約分母が偶数のとき、素数 2 の指数についての釣り合い式
`v_2(P_M) + #V_M * e_v = #E_M * e_b` が成り立ち、さらに `e_v` と `e_b` はともに正である。 -/
theorem rational_power_base_den_two_exponent_balance
    (a b u v P V E : ℕ)
    (ha : 0 < a) (hb : 0 < b) (hu : 0 < u) (hv : 0 < v) (hP : 0 < P)
    (hab : Nat.Coprime a b) (huv : Nat.Coprime u v)
    (hv2 : 2 ∣ v) (hb2 : 2 ∣ b)
    (hid : P * v ^ V = u ^ V * b ^ E) :
    ¬ 2 ∣ a ∧ ¬ 2 ∣ u ∧ 0 < v.factorization 2 ∧ 0 < b.factorization 2 ∧
      P.factorization 2 + V * v.factorization 2 = E * b.factorization 2 := by
  have ha2 : ¬ 2 ∣ a := not_two_dvd_numerator_of_two_dvd_denominator a b hab hb2
  have hu2 : ¬ 2 ∣ u := not_two_dvd_numerator_of_two_dvd_denominator u v huv hv2
  refine ⟨ha2, hu2, ?_, ?_, ?_⟩
  · exact Nat.Prime.factorization_pos_of_dvd Nat.prime_two hv.ne' hv2
  · exact Nat.Prime.factorization_pos_of_dvd Nat.prime_two hb.ne' hb2
  · exact two_exponent_balance_of_integer_identity P u v b V E hP hu hv hb hu2 hid

end Ising3DCut.LimitQuantity
