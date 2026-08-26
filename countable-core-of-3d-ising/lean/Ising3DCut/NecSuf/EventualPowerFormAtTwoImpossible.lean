/-
人手証明「有理点 2 では点数乗表示は末尾で成り立たない」
（ラベル `claim_eventual_power_form_at_two_is_impossible`）の Lean 必要十分版。

具体版から有限箱、分配多項式、多重度、点数、素数 2、法 4 を落とすと、残るのは次の三つだけである。

1. 有限和のうち一つの添字以外の項が法で割れるなら、和はその項と合同である（項の分離）。
2. 素数 `p` について、指数が 2 以上の冪は法 `p^2` で `p` にならない（`p ∣ c` の場合分け）。
3. 上の二つを、閾値以後で冪表示が成り立つという仮定へ当てて矛盾を出す組み立て。

素数性は落とせない。`p` が素数でなければ `p ∣ c ^ n → p ∣ c` が使えず、
2 の場合分けが成立しない（例: `p = 4`, `c = 2`, `n = 2` では `c ^ n % p ^ 2 = 4 ≠ p`
だが `p ∤ c` かつ `p ∣ c ^ n` となり、この論法の分岐が両方とも閉じない）。
指数の下限 2 も落とせない（`c = p`, `n = 1` なら `c ^ n % p ^ 2 = p` になる）。
-/
import Mathlib

namespace Ising3DCut.NecSuf

open Finset

/-- 一つの添字以外の項がすべて法 `n` で割れるなら、有限和はその添字の項と合同である。 -/
theorem sum_modEq_distinguished_of_dvd_others {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (f : ι → ℕ) (n : ℕ) (i : ι) (hi : i ∈ s)
    (hother : ∀ j ∈ s, j ≠ i → n ∣ f j) :
    (∑ j ∈ s, f j) ≡ f i [MOD n] := by
  have hsplit : ∑ j ∈ s, f j = f i + ∑ j ∈ s.erase i, f j :=
    (Finset.add_sum_erase s f hi).symm
  have hdvd : n ∣ ∑ j ∈ s.erase i, f j := by
    refine Finset.dvd_sum ?_
    intro j hj
    exact hother j (Finset.mem_of_mem_erase hj) (Finset.ne_of_mem_erase hj)
  have hzero : (∑ j ∈ s.erase i, f j) ≡ 0 [MOD n] := (Nat.modEq_zero_iff_dvd).mpr hdvd
  calc
    (∑ j ∈ s, f j) = f i + ∑ j ∈ s.erase i, f j := hsplit
    _ ≡ f i + 0 [MOD n] := Nat.ModEq.add_left _ hzero
    _ = f i := by omega

/-- 素数 `p` について、指数が 2 以上の冪を `p ^ 2` で割った余りは `p` にならない。 -/
theorem pow_mod_prime_sq_ne_prime {p c n : ℕ} (hp : p.Prime) (hn : 2 ≤ n) :
    c ^ n % p ^ 2 ≠ p := by
  by_cases hdvd : p ∣ c
  · have hsq : p ^ 2 ∣ c ^ 2 := pow_dvd_pow_of_dvd hdvd 2
    have hpow : p ^ 2 ∣ c ^ n := hsq.trans (pow_dvd_pow c hn)
    rw [Nat.dvd_iff_mod_eq_zero.mp hpow]
    exact hp.pos.ne
  · intro hmod
    have hdecomp : p ^ 2 * (c ^ n / p ^ 2) + c ^ n % p ^ 2 = c ^ n := Nat.div_add_mod _ _
    have hpdvd : p ∣ c ^ n := by
      have hleft : p ∣ p ^ 2 * (c ^ n / p ^ 2) :=
        Dvd.dvd.mul_right (dvd_pow_self p (by norm_num)) _
      have hright : p ∣ c ^ n % p ^ 2 := by rw [hmod]
      have hsum : p ∣ p ^ 2 * (c ^ n / p ^ 2) + c ^ n % p ^ 2 := Nat.dvd_add hleft hright
      rwa [hdecomp] at hsum
    exact hdvd (hp.dvd_of_dvd_pow hpdvd)

/-- 閾値以後で冪表示が成り立つという仮定と、法 `p ^ 2` の剰余が `p` であることの不両立。 -/
theorem no_eventual_power_form_of_prime_sq_residue {p : ℕ} (hp : p.Prime)
    (value exponent : ℕ → ℕ) (threshold base : ℕ)
    (hresidue : ∀ L, 2 ≤ L → value L % p ^ 2 = p)
    (hexponent : ∀ L, 2 ≤ L → 2 ≤ exponent L)
    (hpower : ∀ L, threshold ≤ L → value L = base ^ exponent L) : False := by
  have hthreshold : threshold ≤ max threshold 2 := le_max_left _ _
  have htwo : 2 ≤ max threshold 2 := le_max_right _ _
  have hmod := hresidue _ htwo
  rw [hpower _ hthreshold] at hmod
  exact pow_mod_prime_sq_ne_prime hp (hexponent _ htwo) hmod

end Ising3DCut.NecSuf
