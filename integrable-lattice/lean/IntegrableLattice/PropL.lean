/-
# 命題 L（1 変数最小例の完全形, $P(z)=z-c$）

対応する人手証明:
`integrable-lattice/outputs/paper-plans/002_R_Lambda_duality.md` §2 **命題 L**、
根拠 report `integrable-lattice/outputs/reports/cycle8_T1_lte_proposition.md` 命題 Λ。

人手証明の主張（$c\in\mathbb{Z}_{\ge2}$、$|a_L|=c^L-1$）:

- **$p\mid c$**: $v_p(c^L-1)=0$。
- **$p$ 奇, $p\nmid c$**、$d:=\operatorname{ord}_p(c)$（$c$ の $\bmod p$ での乗法的位数）として
  $$v_p(c^L-1)=\begin{cases}0,& d\nmid L,\\ v_p(c^{d}-1)+v_p(L),& d\mid L.\end{cases}$$
- **$p=2$, $c$ 奇**:
  $$v_2(c^L-1)=\begin{cases}v_2(c-1),& L\ \text{奇},\\
    v_2(c-1)+v_2(c+1)+v_2(L)-1,& L\ \text{偶}.\end{cases}$$

本ファイルはこの 3 つをすべて $\mathbb{N}$ 上の `padicValNat` で形式化する（$\mathbb{R}$ 不使用）。

**人手証明との差（形式化のうえで明示したこと）**:

- $d\mid L$ の場合に $v_p(L)$ がそのまま現れるのは $d\mid p-1$ ゆえ $p\nmid d$ だからである。
  人手証明はこれを暗黙に使っている。ここでは `multOrder_dvd_sub_one` として明示的に証明し、使う。
- $p=2$・$L$ 偶の分岐は人手証明が $\cdots+v_2(L)-1$ と自然数の引き算で書いているので、
  形式化では両辺に $1$ を足した形（mathlib の `padicValNat.pow_two_sub_one` と同じ形）で述べる。
  $\mathbb{N}$ の切り捨て引き算による曖昧さを避けるためであり、主張は同値である。

**新規性は主張しない**（LTE は初等整数論の標準補題。report も同旨）。
-/
import Mathlib

namespace IntegrableLattice

open Finset

/-- **命題 L の $p \mid c$ の場合**: $v_p(c^L-1)=0$。 -/
theorem padicValNat_pow_sub_one_of_dvd {p c L : ℕ} [hp : Fact p.Prime]
    (hc : p ∣ c) (hc1 : 1 ≤ c) (hL : L ≠ 0) :
    padicValNat p (c ^ L - 1) = 0 := by
  refine padicValNat.eq_zero_of_not_dvd ?_
  intro hdvd
  have hcL : p ∣ c ^ L := hc.trans (dvd_pow_self c hL)
  have h1 : (1 : ℕ) ≤ c ^ L := Nat.one_le_pow _ _ (by omega)
  have hsub : c ^ L - (c ^ L - 1) = 1 := by omega
  have : p ∣ 1 := hsub ▸ Nat.dvd_sub hcL hdvd
  exact hp.out.one_lt.ne' (Nat.dvd_one.mp this)

/-- $c$ の $\bmod p$ での乗法的位数 $d$ は $p-1$ を割る。とくに $d\neq0$ かつ $p\nmid d$。
人手証明が暗黙に使っている事実。 -/
theorem multOrder_dvd_sub_one {p c : ℕ} [hp : Fact p.Prime] (hc : ¬ p ∣ c) :
    orderOf ((c : ZMod p)) ∣ p - 1 := by
  have hne : (c : ZMod p) ≠ 0 := by
    rwa [Ne, ZMod.natCast_eq_zero_iff]
  exact orderOf_dvd_of_pow_eq_one (ZMod.pow_card_sub_one_eq_one hne)

/-- **命題 L の $p$ 奇・$d \nmid L$ の場合**: $v_p(c^L-1)=0$。 -/
theorem padicValNat_pow_sub_one_of_not_dvd_order {p c L : ℕ} [hp : Fact p.Prime]
    (hc : ¬ p ∣ c) (hc1 : 1 ≤ c) (hL : ¬ orderOf ((c : ZMod p)) ∣ L) :
    padicValNat p (c ^ L - 1) = 0 := by
  refine padicValNat.eq_zero_of_not_dvd ?_
  intro hdvd
  apply hL
  rw [orderOf_dvd_iff_pow_eq_one]
  have h1 : (1 : ℕ) ≤ c ^ L := Nat.one_le_pow _ _ (by omega)
  have : ((c ^ L - 1 : ℕ) : ZMod p) = 0 := by
    rwa [ZMod.natCast_eq_zero_iff]
  rw [Nat.cast_sub h1] at this
  push_cast at this
  linear_combination (norm := ring_nf) this

/-- **命題 L の $p$ 奇・$d \mid L$ の場合**（LTE）:
$v_p(c^L-1)=v_p(c^{d}-1)+v_p(L)$。 -/
theorem padicValNat_pow_sub_one_odd {p c L : ℕ} [hp : Fact p.Prime] (hp1 : Odd p)
    (hc : ¬ p ∣ c) (hc2 : 2 ≤ c) (hL : L ≠ 0)
    (hdL : orderOf ((c : ZMod p)) ∣ L) :
    padicValNat p (c ^ L - 1)
      = padicValNat p (c ^ orderOf ((c : ZMod p)) - 1) + padicValNat p L := by
  set d := orderOf ((c : ZMod p)) with hd
  -- `d ∣ p - 1` から `d ≠ 0` と `¬ p ∣ d`。
  have hdp : d ∣ p - 1 := multOrder_dvd_sub_one hc
  have hp1' : p - 1 ≠ 0 := by have := hp.out.two_le; omega
  have hd0 : d ≠ 0 := by rintro h; rw [h] at hdp; exact hp1' (Nat.eq_zero_of_zero_dvd hdp)
  have hdlt : d ≤ p - 1 := Nat.le_of_dvd (Nat.pos_of_ne_zero hp1') hdp
  have hpd : ¬ p ∣ d := fun h => by
    have := Nat.le_of_dvd (Nat.pos_of_ne_zero hd0) h; omega
  -- `p ∣ c^d - 1`
  have hcd1 : (1 : ℕ) ≤ c ^ d := Nat.one_le_pow _ _ (by omega)
  have hxy : p ∣ c ^ d - 1 := by
    rw [← ZMod.natCast_eq_zero_iff, Nat.cast_sub hcd1]
    push_cast
    have hpow : ((c : ZMod p)) ^ d = 1 := by rw [hd]; exact pow_orderOf_eq_one _
    rw [hpow, sub_self]
  have hx : ¬ p ∣ c ^ d := fun h => hc (hp.out.dvd_of_dvd_pow h)
  obtain ⟨m, rfl⟩ := hdL
  have hm0 : m ≠ 0 := by rintro rfl; simp at hL
  -- LTE 本体（mathlib）
  have hyx : (1 : ℕ) < c ^ d := by
    have : 2 ^ 1 ≤ c ^ d := Nat.pow_le_pow_left hc2 1 |>.trans (Nat.pow_le_pow_right (by omega)
      (Nat.one_le_iff_ne_zero.mpr hd0))
    omega
  have hlte := padicValNat.pow_sub_pow (p := p) hp1 (x := c ^ d) (y := 1) hyx
    (by simpa using hxy) hx (n := m) hm0
  simp only [one_pow, ← pow_mul] at hlte
  rw [hlte]
  -- `v_p(d*m) = v_p(m)`（`p ∤ d`）
  congr 1
  rw [padicValNat.mul hd0 hm0, padicValNat.eq_zero_of_not_dvd hpd, zero_add]

/-- **命題 L の $p=2$・$L$ 奇の場合**: $v_2(c^L-1)=v_2(c-1)$。 -/
theorem padicValNat_two_pow_sub_one_odd_exp {c L : ℕ} (hc : ¬ 2 ∣ c) (hc2 : 2 ≤ c)
    (hL : Odd L) :
    padicValNat 2 (c ^ L - 1) = padicValNat 2 (c - 1) := by
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have hcL : (1 : ℕ) ≤ c ^ L := Nat.one_le_pow _ _ (by omega)
  -- `c^L - 1 = (c - 1) * ∑_{i<L} c^i`
  have key : c ^ L - 1 = (c - 1) * ∑ i ∈ range L, c ^ i := by
    have : ((c ^ L - 1 : ℕ) : ℤ) = (((c - 1) * ∑ i ∈ range L, c ^ i : ℕ) : ℤ) := by
      push_cast [Nat.cast_sub hcL, Nat.cast_sub (by omega : (1:ℕ) ≤ c)]
      rw [mul_comm]
      exact (geom_sum_mul (c : ℤ) L).symm
    exact_mod_cast this
  -- `∑_{i<L} c^i` は奇数（`c` 奇、`L` 奇）
  have hodd : ¬ 2 ∣ ∑ i ∈ range L, c ^ i := by
    intro h
    -- `c` は奇なので `mod 2` で `c ≡ 1`、よって和は `L ≡ 1` に等しく、`2 ∤ L` と矛盾。
    have hz : ((∑ i ∈ range L, c ^ i : ℕ) : ZMod 2) = 0 :=
      (ZMod.natCast_eq_zero_iff _ 2).mpr h
    have hcm : c % 2 = 1 := by omega
    have hc1 : ((c : ℕ) : ZMod 2) = 1 := by
      conv_lhs => rw [← ZMod.natCast_mod c 2]
      rw [hcm]
      norm_num
    rw [Nat.cast_sum] at hz
    simp only [Nat.cast_pow, hc1, one_pow, Finset.sum_const, Finset.card_range,
      nsmul_eq_mul, mul_one] at hz
    rw [ZMod.natCast_eq_zero_iff] at hz
    have h1 : L % 2 = 1 := Nat.odd_iff.mp hL
    omega
  rw [key, padicValNat.mul (by omega) (by
    rintro h; rw [h] at hodd; exact hodd ⟨0, rfl⟩),
    padicValNat.eq_zero_of_not_dvd hodd, add_zero]

/-- **命題 L の $p=2$・$L$ 偶の場合**:
$v_2(c^L-1)+1=v_2(c+1)+v_2(c-1)+v_2(L)$。
人手証明の $v_2(c-1)+v_2(c+1)+v_2(L)-1$ を、$\mathbb{N}$ の切り捨て引き算を避けて述べたもの。 -/
theorem padicValNat_two_pow_sub_one_even_exp {c L : ℕ} (hc : ¬ 2 ∣ c) (hc2 : 2 ≤ c)
    (hL0 : L ≠ 0) (hL : Even L) :
    padicValNat 2 (c ^ L - 1) + 1
      = padicValNat 2 (c + 1) + padicValNat 2 (c - 1) + padicValNat 2 L :=
  padicValNat.pow_two_sub_one (by omega) hc hL0 hL

end IntegrableLattice
