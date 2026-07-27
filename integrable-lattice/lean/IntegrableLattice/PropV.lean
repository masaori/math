/-
# 命題 V（$\Lambda$ 側が非自明になる条件）

対応する人手証明:
`integrable-lattice/outputs/paper-plans/002_R_Lambda_duality.md` §2 **命題 V**、
根拠 report `integrable-lattice/outputs/reports/cycle14_T1_vp_growth_two_variable.md`
§2 $(2.1)$（Frobenius）・§3.1 **補題 V0**。

人手証明の主張:
$$a_{p^n}\equiv P(1,\dots,1)^{\,p^{dn}} \pmod p,\qquad
  v_p(a_{p^n})>0 \iff p\mid P(1,\dots,1),$$
ただし $a_L=\operatorname{Res}_z(z^L-1,\operatorname{Res}_w(w^L-1,P))$（report $(1.1)$）。
証明が依拠するのは report §2 が明示するとおり
$z^{p^n}-1=(z-1)^{p^n}$ in $\mathbb{F}_p[z]$ の一点だけである。

本ファイルは $d=1$ と $d=2$ の両方を、**人手証明と同じ終結式による定義のまま**形式化する。
mathlib v4.32.1 の `Polynomial.resultant`（形式次数 $m,n$ を明示的に取る版）を使う。
report §3.1 (a) が議論している「還元と終結式の可換性」は、形式次数を固定した
`Polynomial.resultant_map_map` がそのまま与える（人手証明が (a) で行っている
「モニックだから形式次数のずれが吸収される」という議論に対応する）。

**新規性は主張しない**（Frobenius による初等的な事実。report §7 も同旨）。
-/
import Mathlib

namespace IntegrableLattice

open Polynomial

/-- **命題 V の核**（report §2 の $(2.1)$）: 標数 $p$ の可換環で $z^{p^n}-1=(z-1)^{p^n}$。 -/
theorem X_pow_char_pow_sub_one (R : Type*) [CommRing R] (p n : ℕ) [Fact p.Prime] [CharP R p] :
    (X : R[X]) ^ p ^ n - 1 = (X - 1) ^ p ^ n := by
  haveI : ExpChar R p := ExpChar.prime (Fact.out)
  haveI : ExpChar R[X] p := ExpChar.prime (Fact.out)
  simpa using (sub_pow_expChar_pow (R := R[X]) (x := (X : R[X])) (y := 1) (p := p) (n := n)).symm

/-- **補題 V0 の標数 $p$ 版（核）**: 標数 $p$ の可換環 $R$ 上で
$\operatorname{Res}(z^{p^n}-1,\ f) = f(1)^{p^n}$（形式次数は $(p^n, M)$）。

これを $R=\mathbb{F}_p$ に使えば $d=1$、$R=\mathbb{F}_p[z]$ に使えば $d=2$ が出る。 -/
theorem resultant_X_pow_char_pow_sub_one {R : Type*} [CommRing R] (p n : ℕ) [Fact p.Prime]
    [CharP R p] (f : R[X]) (M : ℕ) (hM : f.natDegree ≤ M) :
    ((X : R[X]) ^ p ^ n - 1).resultant f (p ^ n) M = (f.eval 1) ^ p ^ n := by
  rw [X_pow_char_pow_sub_one R p n]
  have h1 : (X - 1 : R[X]) = X - C 1 := by simp
  rw [h1]
  exact resultant_X_sub_C_pow_left 1 f (p ^ n) M hM

section OneVariable

/-- $d=1$ の周期点分配 $a_L=\operatorname{Res}(z^L-1,\ P)$（形式次数 $(L, M)$）。 -/
noncomputable def aOne (P : ℤ[X]) (L M : ℕ) : ℤ :=
  ((X : ℤ[X]) ^ L - 1).resultant P L M

/-- **補題 V0（$d=1$）**: $a_{p^n}\equiv P(1)^{p^n} \pmod p$。 -/
theorem aOne_cast_zmod (p n : ℕ) [Fact p.Prime] (P : ℤ[X]) (M : ℕ) (hM : P.natDegree ≤ M) :
    ((aOne P (p ^ n) M : ℤ) : ZMod p) = (((P.eval 1 : ℤ) : ZMod p)) ^ p ^ n := by
  have hmap := resultant_map_map ((X : ℤ[X]) ^ p ^ n - 1) P (p ^ n) M
    (Int.castRingHom (ZMod p))
  show (Int.castRingHom (ZMod p)) (aOne P (p ^ n) M) = _
  rw [aOne, ← hmap]
  have hX : (((X : ℤ[X]) ^ p ^ n - 1).map (Int.castRingHom (ZMod p)))
      = (X : (ZMod p)[X]) ^ p ^ n - 1 := by
    simp
  rw [hX]
  have hdeg : (P.map (Int.castRingHom (ZMod p))).natDegree ≤ M :=
    (natDegree_map_le).trans hM
  rw [resultant_X_pow_char_pow_sub_one p n _ M hdeg]
  congr 1
  simpa using (eval₂_at_one (Int.castRingHom (ZMod p)) P).symm

/-- **命題 V（$d=1$）**: $p \mid a_{p^n} \iff p \mid P(1)$。
すなわち $\Lambda$ 側が非自明になる条件は $P(1)$ の $p$ による整除で決まり、
$\mathbb{Z}$ 上の有限手続きで判定できる。 -/
theorem dvd_aOne_iff (p n : ℕ) [Fact p.Prime] (P : ℤ[X]) (M : ℕ) (hM : P.natDegree ≤ M) :
    (p : ℤ) ∣ aOne P (p ^ n) M ↔ (p : ℤ) ∣ P.eval 1 := by
  rw [← ZMod.intCast_zmod_eq_zero_iff_dvd, ← ZMod.intCast_zmod_eq_zero_iff_dvd,
    aOne_cast_zmod p n P M hM]
  exact pow_eq_zero_iff (pow_ne_zero n (Fact.out : p.Prime).ne_zero)

end OneVariable

section TwoVariable

/-- $d=2$ の周期点分配
$a_L=\operatorname{Res}_z(z^L-1,\ \operatorname{Res}_w(w^L-1,\ P))$（report $(1.1)$）。
$P\in\mathbb{Z}[z][w]$、形式次数は内側が $(L,N)$、外側が $(L,M)$。 -/
noncomputable def aTwoInner (P : (ℤ[X])[X]) (L N : ℕ) : ℤ[X] :=
  ((X : (ℤ[X])[X]) ^ L - 1).resultant P L N

noncomputable def aTwo (P : (ℤ[X])[X]) (L M N : ℕ) : ℤ :=
  ((X : ℤ[X]) ^ L - 1).resultant (aTwoInner P L N) L M

/-- $P\in\mathbb{Z}[z][w]$ の $(1,1)$ での値。 -/
noncomputable def evalOneOne (P : (ℤ[X])[X]) : ℤ := (P.eval 1).eval 1

/-- **補題 V0（$d=2$）**: $a_{p^n}\equiv P(1,1)^{\,p^{2n}} \pmod p$。 -/
theorem aTwo_cast_zmod (p n : ℕ) [Fact p.Prime] (P : (ℤ[X])[X]) (M N : ℕ)
    (hN : P.natDegree ≤ N) (hM : (aTwoInner P (p ^ n) N).natDegree ≤ M) :
    ((aTwo P (p ^ n) M N : ℤ) : ZMod p)
      = (((evalOneOne P : ℤ) : ZMod p)) ^ p ^ (2 * n) := by
  classical
  set φ : ℤ →+* ZMod p := Int.castRingHom (ZMod p) with hφ
  set Φ : ℤ[X] →+* (ZMod p)[X] := mapRingHom φ with hΦ
  -- 内側: Φ (Res_w(w^L-1, P)) = (P(w:=1) の像)^{p^n}
  have hinner : Φ (aTwoInner P (p ^ n) N) = ((P.map Φ).eval 1) ^ p ^ n := by
    have hmap := resultant_map_map ((X : (ℤ[X])[X]) ^ p ^ n - 1) P (p ^ n) N Φ
    rw [aTwoInner, hΦ] at *
    rw [← hmap]
    have hX : (((X : (ℤ[X])[X]) ^ p ^ n - 1).map Φ)
        = (X : ((ZMod p)[X])[X]) ^ p ^ n - 1 := by simp
    rw [hX]
    exact resultant_X_pow_char_pow_sub_one p n _ N ((natDegree_map_le).trans hN)
  -- 外側
  have hmap := resultant_map_map ((X : ℤ[X]) ^ p ^ n - 1) (aTwoInner P (p ^ n) N) (p ^ n) M φ
  show φ (aTwo P (p ^ n) M N) = _
  rw [aTwo, ← hmap]
  have hX : (((X : ℤ[X]) ^ p ^ n - 1).map φ) = (X : (ZMod p)[X]) ^ p ^ n - 1 := by simp
  rw [hX]
  have hdeg : ((aTwoInner P (p ^ n) N).map φ).natDegree ≤ M := (natDegree_map_le).trans hM
  rw [resultant_X_pow_char_pow_sub_one p n _ M hdeg]
  -- 値の突き合わせ
  have hmapeq : (aTwoInner P (p ^ n) N).map φ = Φ (aTwoInner P (p ^ n) N) := rfl
  have hexp : p ^ (2 * n) = p ^ n * p ^ n := by rw [two_mul, pow_add]
  rw [hmapeq, hinner, eval_pow, ← pow_mul, hexp]
  congr 1
  -- eval 1 ((P.map Φ).eval 1) = φ (evalOneOne P)
  have h1 : ((P.map Φ).eval 1) = Φ (P.eval 1) := by
    simpa using (eval₂_at_one Φ P).symm
  rw [h1, evalOneOne, hΦ]
  simpa using (eval₂_at_one φ (P.eval 1)).symm

/-- **命題 V（$d=2$）**: $p \mid a_{p^n} \iff p \mid P(1,1)$。 -/
theorem dvd_aTwo_iff (p n : ℕ) [Fact p.Prime] (P : (ℤ[X])[X]) (M N : ℕ)
    (hN : P.natDegree ≤ N) (hM : (aTwoInner P (p ^ n) N).natDegree ≤ M) :
    (p : ℤ) ∣ aTwo P (p ^ n) M N ↔ (p : ℤ) ∣ evalOneOne P := by
  rw [← ZMod.intCast_zmod_eq_zero_iff_dvd, ← ZMod.intCast_zmod_eq_zero_iff_dvd,
    aTwo_cast_zmod p n P M N hN hM]
  exact pow_eq_zero_iff (pow_ne_zero (2 * n) (Fact.out : p.Prime).ne_zero)

end TwoVariable

end IntegrableLattice
