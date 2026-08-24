/-
人手証明「点数乗表示の底の既約分母は破れ数ゼロの配位数を割らない素数では割り切れない」
（ラベル `claim_rational_power_base_den_no_prime_missing_zero_mult`）の Lean 具体版。

人手証明と同じ順で進む。
第一段: `p ∣ v` を仮定する。`v` の素因子は `b` の素因子なので `p ∣ b`、
        `a` と `b` の互いに素性から `p ∤ a`、`u` と `v` の互いに素性から `p ∤ u`。
第二段: 回文性から得た法 `b` の合同式 `P_M ≡ Ω_M(0) * a^(#E_M)` を法 `p` へ移し、
        `p ∤ Ω_M(0)` と `p ∤ a` から `p ∤ P_M` を出す。
第三段: 整数の等式 `P_M * v^(#V_M) = u^(#V_M) * b^(#E_M)` の両辺で `p` の指数を取り、
        点数と辺数を代入して `M * e_v = 3 * (M-1) * e_b` を得る。
第四段: 隣接する二つの箱 `M = L, L+1` の指数等式を比べると `e_b = 0` となり、
        `p ∣ b` から得た `1 ≤ e_b` に矛盾する。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenominatorCoprime

namespace Ising3DCut.LimitQuantity

/-- 人手証明の第二段。法 `b` の合同式と `p ∣ b`、`p ∤ Ω0`、`p ∤ a` から `p ∤ P`。 -/
theorem not_dvd_bridge_integer_of_not_dvd_zero_multiplicity
    (P Ω0 a b E : ℕ) (p : ℕ) (hp : p.Prime) (hpb : p ∣ b)
    (hpΩ : ¬ p ∣ Ω0) (hpa : ¬ p ∣ a)
    (hcong : (P : ℤ) ≡ (Ω0 : ℤ) * (a : ℤ) ^ E [ZMOD (b : ℤ)]) :
    ¬ p ∣ P := by
  intro hpP
  -- 法 b を法 p へ移す
  have hpbZ : (p : ℤ) ∣ (b : ℤ) := Int.natCast_dvd_natCast.mpr hpb
  have hcongp : (P : ℤ) ≡ (Ω0 : ℤ) * (a : ℤ) ^ E [ZMOD (p : ℤ)] :=
    Int.ModEq.of_dvd hpbZ hcong
  -- 左辺は法 p で 0 なので、右辺も p で割り切れる
  have hPzero : (P : ℤ) ≡ 0 [ZMOD (p : ℤ)] :=
    (Int.modEq_zero_iff_dvd).mpr (Int.natCast_dvd_natCast.mpr hpP)
  have hdvdZ : (p : ℤ) ∣ (Ω0 : ℤ) * (a : ℤ) ^ E :=
    (Int.modEq_zero_iff_dvd).mp (hcongp.symm.trans hPzero)
  have hdvd : p ∣ Ω0 * a ^ E := by
    have : (p : ℤ) ∣ ((Ω0 * a ^ E : ℕ) : ℤ) := by push_cast; exact hdvdZ
    exact Int.ofNat_dvd.mp this
  -- p は素数なので Ω0 か a を割る。どちらも仮定に反する
  rcases (Nat.Prime.dvd_mul hp).mp hdvd with h | h
  · exact hpΩ h
  · exact hpa (hp.dvd_of_dvd_pow h)

/-- 人手証明の第三段の前半。整数の等式の両辺で `p` の指数を取ると
`#V * v_p(v) = #E * v_p(b)` が従う。 -/
theorem exponent_equation_of_integer_identity
    (P u v b V E : ℕ) (p : ℕ) (hp : p.Prime)
    (hP : 0 < P) (hu : 0 < u) (hv : 0 < v) (hb : 0 < b)
    (hpP : ¬ p ∣ P) (hpu : ¬ p ∣ u)
    (hid : P * v ^ V = u ^ V * b ^ E) :
    V * v.factorization p = E * b.factorization p := by
  have hPfac : P.factorization p = 0 := Nat.factorization_eq_zero_of_not_dvd hpP
  have hufac : u.factorization p = 0 := Nat.factorization_eq_zero_of_not_dvd hpu
  have hleft : (P * v ^ V).factorization p = V * v.factorization p := by
    rw [Nat.factorization_mul hP.ne' (pow_ne_zero _ hv.ne'), Nat.factorization_pow]
    simp [hPfac]
  have hright : (u ^ V * b ^ E).factorization p = E * b.factorization p := by
    rw [Nat.factorization_mul (pow_ne_zero _ hu.ne') (pow_ne_zero _ hb.ne'),
      Nat.factorization_pow, Nat.factorization_pow]
    simp [hufac]
  rw [← hleft, ← hright, hid]

/-- 人手証明の第三段の後半。点数 `#V_M = M*M*M`、辺数 `#E_M = 3*M*M*(M-1)` を代入し、
正の自然数 `M*M` で割って `M * e_v = 3 * (M-1) * e_b` を得る（`M = K+1` として書く）。 -/
theorem box_exponent_equation_cancel
    (K ev eb : ℕ)
    (h : ((K + 1) * (K + 1) * (K + 1)) * ev = (3 * ((K + 1) * (K + 1)) * K) * eb) :
    (K + 1) * ev = 3 * K * eb := by
  have hcancel : ((K + 1) * (K + 1)) * ((K + 1) * ev) =
      ((K + 1) * (K + 1)) * (3 * K * eb) := by ring_nf; ring_nf at h; linarith
  exact Nat.eq_of_mul_eq_mul_left (by positivity) hcancel

/-- 人手証明の第四段。隣接する二つの箱の指数等式は `eb = 0` を強いる。 -/
theorem zero_exponent_of_two_adjacent_boxes
    (K ev eb : ℕ)
    (hL : (K + 1) * ev = 3 * K * eb)
    (hL1 : (K + 2) * ev = 3 * (K + 1) * eb) :
    eb = 0 := by
  -- 両式を交差して掛け、非線形部分を A = K*K + 2*K として消す
  have h1 : (K + 2) * ((K + 1) * ev) = (K + 2) * (3 * K * eb) := by rw [hL]
  have h2 : (K + 1) * ((K + 2) * ev) = (K + 1) * (3 * (K + 1) * eb) := by rw [hL1]
  have hcross : (K + 2) * (3 * K * eb) = (K + 1) * (3 * (K + 1) * eb) := by
    rw [← h1, ← h2]; ring
  have hA : 3 * (K * K + 2 * K) * eb = 3 * (K * K + 2 * K + 1) * eb := by
    ring_nf; ring_nf at hcross; linarith
  -- 非線形部分を共通の項として括り出し、残った `3 * eb = 0` から結論する
  have hR : 3 * (K * K + 2 * K + 1) * eb = 3 * (K * K + 2 * K) * eb + 3 * eb := by ring
  rw [hR] at hA
  omega

/-- 人手証明の全体。破れ数ゼロの配位数を割らない素数は、点数乗表示の底の既約分母を割らない。
`L = K + 1` として、隣接する二つの箱の整数等式と法 `b` の合同式だけを前提に置く。 -/
theorem rational_power_base_den_no_prime_missing_zero_multiplicity
    (K : ℕ) (a b u v : ℕ) (ΩL ΩL1 PL PL1 : ℕ) (p : ℕ) (hp : p.Prime)
    (ha : 0 < a) (hb : 0 < b) (hu : 0 < u) (hv : 0 < v)
    (hPL : 0 < PL) (hPL1 : 0 < PL1)
    (hab : Nat.Coprime a b) (huv : Nat.Coprime u v)
    (hpb : p ∣ b)
    (hpΩL : ¬ p ∣ ΩL) (hpΩL1 : ¬ p ∣ ΩL1)
    (hcongL : (PL : ℤ) ≡ (ΩL : ℤ) * (a : ℤ) ^ (3 * ((K + 1) * (K + 1)) * K)
      [ZMOD (b : ℤ)])
    (hcongL1 : (PL1 : ℤ) ≡ (ΩL1 : ℤ) * (a : ℤ) ^ (3 * ((K + 2) * (K + 2)) * (K + 1))
      [ZMOD (b : ℤ)])
    (hidL : PL * v ^ ((K + 1) * (K + 1) * (K + 1))
      = u ^ ((K + 1) * (K + 1) * (K + 1)) * b ^ (3 * ((K + 1) * (K + 1)) * K))
    (hidL1 : PL1 * v ^ ((K + 2) * (K + 2) * (K + 2))
      = u ^ ((K + 2) * (K + 2) * (K + 2)) * b ^ (3 * ((K + 2) * (K + 2)) * (K + 1))) :
    ¬ p ∣ v := by
  intro hpv
  -- 第一段: p ∤ a と p ∤ u
  have hpa : ¬ p ∣ a := fun h => Nat.Prime.one_lt hp |>.ne'
    (Nat.dvd_one.mp (hab ▸ Nat.dvd_gcd h hpb))
  have hpu : ¬ p ∣ u := fun h => Nat.Prime.one_lt hp |>.ne'
    (Nat.dvd_one.mp (huv ▸ Nat.dvd_gcd h hpv))
  -- 第二段: p ∤ P_M
  have hpPL : ¬ p ∣ PL :=
    not_dvd_bridge_integer_of_not_dvd_zero_multiplicity PL ΩL a b _ p hp hpb hpΩL hpa hcongL
  have hpPL1 : ¬ p ∣ PL1 :=
    not_dvd_bridge_integer_of_not_dvd_zero_multiplicity PL1 ΩL1 a b _ p hp hpb hpΩL1 hpa hcongL1
  -- 第三段: 指数等式と点数・辺数の代入
  have hexpL := exponent_equation_of_integer_identity PL u v b _ _ p hp hPL hu hv hb hpPL hpu hidL
  have hexpL1 :=
    exponent_equation_of_integer_identity PL1 u v b _ _ p hp hPL1 hu hv hb hpPL1 hpu hidL1
  have hL := box_exponent_equation_cancel K (v.factorization p) (b.factorization p) hexpL
  have hL1 : (K + 2) * v.factorization p = 3 * (K + 1) * b.factorization p := by
    have := box_exponent_equation_cancel (K + 1) (v.factorization p) (b.factorization p)
      (by simpa using hexpL1)
    simpa using this
  -- 第四段: 二箱の比較で e_b = 0。p ∣ b に矛盾する
  have hzero := zero_exponent_of_two_adjacent_boxes K _ _ hL hL1
  have : p ∈ b.primeFactors := Nat.mem_primeFactors.mpr ⟨hp, hpb, hb.ne'⟩
  exact (Nat.Prime.factorization_pos_of_dvd hp hb.ne' hpb).ne' hzero

end Ising3DCut.LimitQuantity
