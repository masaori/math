/-
正本: content/prime-logarithm.ts の具体版。
def_prime_integer_vectors → Prime, LogVector
def_prime_vector_additive_operations → 既存 Finsupp の各点整数演算、scale
claim_prime_vectors_abelian_group → vector_assoc, vector_comm, vector_zero, vector_inverse
def_positive_rational_prime_valuation / def_prime_logarithm → valuation, logarithm
def_prime_vector_reconstruction / def_prime_vector_order → reconstruct, vectorLE
claim_prime_vector_integer_division → integer_division
claim_prime_logarithm_inverse → logarithm_reconstruct, reconstruct_logarithm
claim_prime_logarithm_product / claim_prime_logarithm_ratio → logarithm_product, logarithm_ratio
claim_prime_logarithm_ordered_group → reconstruct_add, order_reflexive, order_transitive,
  order_total, order_antisymmetric, order_translation, logarithm_order
reconstruct_nat は正整数の場合の同じ復元計算であり、CAの上界を直接受ける。
有限台を持つ素数上の整数係数という本文の対象を維持する。
-/
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Finsupp.Basic
import Mathlib.Data.Rat.Lemmas
import Mathlib.Data.Rat.Cast.Order
import Mathlib.Tactic.NormNum
import Mathlib.Algebra.Order.BigOperators.GroupWithZero.Finset

namespace CellularAutomata.PrimeLogarithm

abbrev Prime := {p : ℕ // p.Prime}
abbrev LogVector := Prime →₀ ℤ
abbrev PositiveRational := {q : ℚ // 0 < q}

noncomputable def scale (d : ℤ) (a : LogVector) : LogVector :=
  a.mapRange (fun z => d * z) (mul_zero d)

theorem scale_apply (d : ℤ) (a : LogVector) (p : Prime) :
    scale d a p = d * a p := rfl

theorem add_support (a b : LogVector) : (a + b).support ⊆ a.support ∪ b.support := by
  intro p hp
  by_contra h
  have ha : a p = 0 := Finsupp.notMem_support_iff.mp (fun hpa => h (Finset.mem_union_left _ hpa))
  have hb : b p = 0 := Finsupp.notMem_support_iff.mp (fun hpb => h (Finset.mem_union_right _ hpb))
  exact (Finsupp.mem_support_iff.mp hp) (by simp [ha, hb])

theorem neg_support (a : LogVector) : (-a).support ⊆ a.support := by
  intro p hp
  by_contra h
  have ha := Finsupp.notMem_support_iff.mp h
  exact (Finsupp.mem_support_iff.mp hp) (by simp [ha])

theorem scale_support (d : ℤ) (a : LogVector) : (scale d a).support ⊆ a.support := by
  intro p hp
  by_contra h
  have ha := Finsupp.notMem_support_iff.mp h
  exact (Finsupp.mem_support_iff.mp hp) (by rw [scale_apply, ha, mul_zero])

theorem vector_assoc (a b c : LogVector) : (a + b) + c = a + (b + c) := by
  ext p
  calc
    ((a + b) + c) p = (a p + b p) + c p := rfl
    _ = a p + (b p + c p) := Int.add_assoc _ _ _
    _ = (a + (b + c)) p := rfl

theorem vector_comm (a b : LogVector) : a + b = b + a := by
  ext p
  calc
    (a + b) p = a p + b p := rfl
    _ = b p + a p := Int.add_comm _ _
    _ = (b + a) p := rfl

theorem vector_zero (a : LogVector) : a + 0 = a := by
  ext p
  calc
    (a + 0) p = a p + 0 := rfl
    _ = a p := Int.add_zero _

theorem vector_inverse (a : LogVector) : a + (-a) = 0 := by
  ext p
  calc
    (a + (-a)) p = a p + (-a p) := rfl
    _ = 0 := add_neg_cancel _
    _ = (0 : LogVector) p := rfl

def valuation (q : PositiveRational) (p : Prime) : ℤ :=
  (q.val.num.natAbs.factorization p.val : ℤ) - (q.val.den.factorization p.val : ℤ)

noncomputable def logarithm (q : PositiveRational) : LogVector :=
  (q.val.num.natAbs.factorization.mapRange (fun n : ℕ => (n : ℤ)) (by rfl)).subtypeDomain Nat.Prime -
  (q.val.den.factorization.mapRange (fun n : ℕ => (n : ℤ)) (by rfl)).subtypeDomain Nat.Prime

theorem logarithm_apply (q : PositiveRational) (p : Prime) :
    logarithm q p = valuation q p := rfl

def numeratorProduct (a : LogVector) : ℕ :=
  a.support.prod (fun p => p.val ^ (a p).toNat)

def denominatorProduct (a : LogVector) : ℕ :=
  a.support.prod (fun p => p.val ^ (-a p).toNat)

theorem numerator_positive (a : LogVector) : 0 < numeratorProduct a := by
  apply Finset.prod_pos
  intro p _
  exact pow_pos p.property.pos _

theorem denominator_positive (a : LogVector) : 0 < denominatorProduct a := by
  apply Finset.prod_pos
  intro p _
  exact pow_pos p.property.pos _

def reconstruct (a : LogVector) : PositiveRational :=
  ⟨(numeratorProduct a : ℚ) / (denominatorProduct a : ℚ),
    div_pos (by exact_mod_cast numerator_positive a) (by exact_mod_cast denominator_positive a)⟩

def vectorLE (a b : LogVector) : Prop := (reconstruct a).val ≤ (reconstruct b).val

theorem order_cross_multiply (a b : LogVector) : vectorLE a b ↔
    numeratorProduct a * denominatorProduct b ≤ numeratorProduct b * denominatorProduct a := by
  unfold vectorLE reconstruct
  rw [div_le_div_iff₀ (by exact_mod_cast denominator_positive a)
    (by exact_mod_cast denominator_positive b)]
  norm_cast

theorem integer_division (a : LogVector) (d : ℤ) (hd : d ≠ 0) :
    (∃! b : LogVector, scale d b = a) ↔ ∀ p ∈ a.support, d ∣ a p := by
  constructor
  · rintro ⟨b, hb, _⟩ p _
    refine ⟨b p, ?_⟩
    exact (congrArg (fun v : LogVector => v p) hb).symm
  · intro h
    let b : LogVector := a.mapRange (fun z => z / d) (Int.zero_ediv d)
    have hb_support : b.support ⊆ a.support := by
      intro p hp
      by_contra hn
      have ha := Finsupp.notMem_support_iff.mp hn
      exact (Finsupp.mem_support_iff.mp hp) (by simp [b, ha])
    have hb : scale d b = a := by
      ext p
      by_cases hp : p ∈ a.support
      · calc
          scale d b p = d * (a p / d) := rfl
          _ = a p := Int.mul_ediv_cancel' (h p hp)
      · have ha := Finsupp.notMem_support_iff.mp hp
        have hz := Finsupp.notMem_support_iff.mp (fun hpb => hp (hb_support hpb))
        rw [scale_apply, hz, mul_zero, ha]
    refine ⟨b, hb, ?_⟩
    intro c hc
    ext p
    have hc' : d * c p = a p := congrArg (fun v : LogVector => v p) hc
    have hb' : d * b p = a p := congrArg (fun v : LogVector => v p) hb
    exact mul_left_cancel₀ hd (hc'.trans hb'.symm)


def positiveNat (n : ℕ) (hn : 0 < n) : PositiveRational :=
  ⟨(n : ℚ) / 1, by rw [div_one]; exact_mod_cast hn⟩

theorem logarithm_nat_apply (n : ℕ) (hn : 0 < n) (p : Prime) :
    logarithm (positiveNat n hn) p = (n.factorization p.val : ℤ) := by
  simp [logarithm_apply, valuation, positiveNat]

theorem logarithm_one : logarithm (positiveNat 1 (by decide)) = 0 := by
  ext p
  rw [logarithm_nat_apply]
  simp

theorem logarithm_two_at_two :
    logarithm (positiveNat 2 (by decide)) ⟨2, by decide⟩ = 1 := by
  rw [logarithm_nat_apply]
  rw [Nat.Prime.factorization_self (by decide : Nat.Prime 2)]
  rfl

def positiveMul (q t : PositiveRational) : PositiveRational :=
  ⟨q.val * t.val, mul_pos q.property t.property⟩

def positiveInv (q : PositiveRational) : PositiveRational :=
  ⟨q.val⁻¹, inv_pos.mpr q.property⟩

def positiveDiv (q t : PositiveRational) : PositiveRational :=
  ⟨q.val / t.val, div_pos q.property t.property⟩

theorem logarithm_product (q t : PositiveRational) :
    logarithm (positiveMul q t) = logarithm q + logarithm t := by
  ext p
  let r := q.val.num.natAbs
  let s := q.val.den
  let u := t.val.num.natAbs
  let v := t.val.den
  let g := (r * u).gcd (s * v)
  have hr : r ≠ 0 := by
    dsimp [r]
    simpa only [Int.natAbs_ne_zero, Rat.num_ne_zero] using ne_of_gt q.property
  have hu : u ≠ 0 := by
    dsimp [u]
    simpa only [Int.natAbs_ne_zero, Rat.num_ne_zero] using ne_of_gt t.property
  have hs : s ≠ 0 := q.val.den_ne_zero
  have hv : v ≠ 0 := t.val.den_ne_zero
  have hg : g ≠ 0 := Nat.gcd_ne_zero_left (mul_ne_zero hr hu)
  have hnum : r * u = (q.val * t.val).num.natAbs * g := by
    have h := congrArg Int.natAbs (Rat.num_mul_num_eq_num_mul_gcd q.val t.val)
    simpa [Int.natAbs_mul, r, u, s, v, g] using h
  have hden : s * v = (q.val * t.val).den * g := by
    simpa [r, s, u, v, g, Int.natAbs_mul] using Rat.den_mul_den_eq_den_mul_gcd q.val t.val
  have hprod : (q.val * t.val).num.natAbs ≠ 0 := by
    simpa only [Int.natAbs_ne_zero, Rat.num_ne_zero] using
      ne_of_gt (mul_pos q.property t.property)
  -- 既約化で除く同じ g の指数を分子・分母の双方で分離する。
  have hnf := congrArg (fun m : ℕ => m.factorization p.val) hnum
  have hdf := congrArg (fun m : ℕ => m.factorization p.val) hden
  simp only [Nat.factorization_mul hr hu, Nat.factorization_mul hprod hg,
    Finsupp.add_apply] at hnf
  simp only [Nat.factorization_mul hs hv,
    Nat.factorization_mul (q.val * t.val).den_ne_zero hg, Finsupp.add_apply] at hdf
  have hni : ((q.val * t.val).num.natAbs.factorization p.val : ℤ) =
      (r.factorization p.val : ℤ) + (u.factorization p.val : ℤ) - (g.factorization p.val : ℤ) := by
    omega
  have hdi : ((q.val * t.val).den.factorization p.val : ℤ) =
      (s.factorization p.val : ℤ) + (v.factorization p.val : ℤ) - (g.factorization p.val : ℤ) := by
    omega
  change ((q.val * t.val).num.natAbs.factorization p.val : ℤ) -
      ((q.val * t.val).den.factorization p.val : ℤ) =
    ((r.factorization p.val : ℤ) - (s.factorization p.val : ℤ)) +
      ((u.factorization p.val : ℤ) - (v.factorization p.val : ℤ))
  rw [hni, hdi]
  omega

theorem logarithm_inverse (q : PositiveRational) :
    logarithm (positiveInv q) = -logarithm q := by
  ext p
  have hq := ne_of_gt q.property
  have hsign : q.val.num.sign = 1 := Int.sign_eq_one_iff_pos.mpr (Rat.num_pos.mpr q.property)
  simp [logarithm_apply, valuation, positiveInv, Rat.num_inv, Rat.den_inv, hq, hsign]

theorem logarithm_ratio (q t : PositiveRational) :
    logarithm (positiveDiv q t) = logarithm q - logarithm t := by
  calc
    logarithm (positiveDiv q t) = logarithm (positiveMul q (positiveInv t)) := by
      congr 1
    _ = logarithm q + logarithm (positiveInv t) := logarithm_product q (positiveInv t)
    _ = logarithm q + (-logarithm t) := by rw [logarithm_inverse]
    _ = logarithm q - logarithm t := by rw [sub_eq_add_neg]


-- 正整数の場合の復元。一般の相互逆性に用いる分子・分母の計算の特殊例。
theorem logarithm_nat_vector (n : ℕ) (hn : 0 < n) :
    logarithm (positiveNat n hn) =
      (n.factorization.subtypeDomain Nat.Prime).mapRange (fun z : ℕ => (z : ℤ)) (by rfl) := by
  ext p
  rw [logarithm_nat_apply]
  rfl

theorem reconstruct_nat (n : ℕ) (hn : 0 < n) :
    reconstruct (logarithm (positiveNat n hn)) = positiveNat n hn := by
  have hnum : numeratorProduct (logarithm (positiveNat n hn)) = n := by
    rw [logarithm_nat_vector]
    change ((n.factorization.subtypeDomain Nat.Prime).mapRange (fun z : ℕ => (z : ℤ))
      (by rfl)).prod (fun p z => p.val ^ z.toNat) = n
    rw [Finsupp.prod_mapRange_index (by intro p; simp)]
    simp only [Int.toNat_natCast]
    rw [Finsupp.prod_subtypeDomain_index (fun p hp => Nat.prime_of_mem_primeFactors hp)]
    exact Nat.prod_factorization_pow_eq_self (ne_of_gt hn)
  have hden : denominatorProduct (logarithm (positiveNat n hn)) = 1 := by
    unfold denominatorProduct
    apply Finset.prod_eq_one
    intro p _
    rw [logarithm_nat_apply]
    simp
  apply Subtype.ext
  change (numeratorProduct (logarithm (positiveNat n hn)) : ℚ) /
    (denominatorProduct (logarithm (positiveNat n hn)) : ℚ) = (n : ℚ) / 1
  rw [hnum, hden]
  rfl

theorem natural_log_order (m n : ℕ) (hm : 0 < m) (hn : 0 < n) :
    vectorLE (logarithm (positiveNat m hm)) (logarithm (positiveNat n hn)) ↔ m ≤ n := by
  unfold vectorLE
  rw [reconstruct_nat, reconstruct_nat]
  simp only [positiveNat, div_one]
  exact Nat.cast_le


-- 復元の各素数指数を、有限積の素因数分解として直接計算する。
theorem product_factorization (a : LogVector) (e : Prime → ℕ)
    (he : ∀ p, p ∉ a.support → e p = 0) (p : Prime) :
    (a.support.prod (fun r => r.val ^ e r)).factorization p.val = e p := by
  classical
  rw [Nat.factorization_prod_apply (fun r _ => pow_ne_zero _ r.property.ne_zero)]
  calc
    ∑ r ∈ a.support, (r.val ^ e r).factorization p.val =
        ∑ r ∈ a.support, if r = p then e r else 0 := by
      apply Finset.sum_congr rfl
      intro r _
      rw [r.property.factorization_pow]
      by_cases h : r = p
      · subst r; simp
      · have hv : r.val ≠ p.val := fun hh => h (Subtype.ext hh)
        simp [h, hv]
    _ = e p := by
      by_cases hp : p ∈ a.support
      · simp [hp]
      · simp [hp, he p hp]

theorem numerator_factorization (a : LogVector) (p : Prime) :
    (numeratorProduct a).factorization p.val = (a p).toNat := by
  exact product_factorization a (fun r => (a r).toNat)
    (fun r hr => by rw [Finsupp.notMem_support_iff.mp hr]; rfl) p

theorem denominator_factorization (a : LogVector) (p : Prime) :
    (denominatorProduct a).factorization p.val = (-a p).toNat := by
  exact product_factorization a (fun r => (-a r).toNat)
    (fun r hr => by rw [Finsupp.notMem_support_iff.mp hr]; rfl) p

theorem reconstruction_coprime (a : LogVector) :
    (numeratorProduct a).Coprime (denominatorProduct a) := by
  by_contra h
  obtain ⟨p, hp, hnum, hden⟩ := Nat.Prime.not_coprime_iff_dvd.mp h
  have hn := hp.factorization_pos_of_dvd (ne_of_gt (numerator_positive a)) hnum
  have hd := hp.factorization_pos_of_dvd (ne_of_gt (denominator_positive a)) hden
  rw [numerator_factorization a ⟨p, hp⟩] at hn
  rw [denominator_factorization a ⟨p, hp⟩] at hd
  omega

theorem logarithm_reconstruct (a : LogVector) : logarithm (reconstruct a) = a := by
  have hp : (0 : ℤ) < denominatorProduct a := by exact_mod_cast denominator_positive a
  have hc : (Int.natAbs (numeratorProduct a : ℤ)).Coprime
      (Int.natAbs (denominatorProduct a : ℤ)) := by simpa using reconstruction_coprime a
  have hn : (reconstruct a).val.num.natAbs = numeratorProduct a := by
    have h := Rat.num_div_eq_of_coprime hp hc
    simpa [reconstruct] using congrArg Int.natAbs h
  have hd : (reconstruct a).val.den = denominatorProduct a := by
    have h := Rat.den_div_eq_of_coprime hp hc
    have hcast : ((reconstruct a).val.den : ℤ) = (denominatorProduct a : ℤ) := by
      simpa only [reconstruct, Int.cast_natCast] using h
    exact Int.ofNat_inj.mp hcast
  ext p
  calc
    logarithm (reconstruct a) p = valuation (reconstruct a) p := rfl
    _ = ((numeratorProduct a).factorization p.val : ℤ) -
        ((denominatorProduct a).factorization p.val : ℤ) := by unfold valuation; rw [hn, hd]
    _ = ((a p).toNat : ℤ) - ((-a p).toNat : ℤ) := by
      rw [numerator_factorization, denominator_factorization]
    _ = a p := by omega

theorem reduced_exponents_disjoint (q : PositiveRational) (p : Prime) :
    q.val.num.natAbs.factorization p.val = 0 ∨ q.val.den.factorization p.val = 0 := by
  by_contra h
  push Not at h
  have hn : p.val ∣ q.val.num.natAbs := by
    by_contra hn
    exact h.1 (Nat.factorization_eq_zero_of_not_dvd hn)
  have hd : p.val ∣ q.val.den := by
    by_contra hd
    exact h.2 (Nat.factorization_eq_zero_of_not_dvd hd)
  exact (Nat.Prime.not_coprime_iff_dvd.mpr ⟨p.val, p.property, hn, hd⟩) q.val.reduced

theorem reconstruct_logarithm (q : PositiveRational) : reconstruct (logarithm q) = q := by
  have hnq : q.val.num.natAbs ≠ 0 := by
    simpa only [Int.natAbs_ne_zero, Rat.num_ne_zero] using ne_of_gt q.property
  have hn : numeratorProduct (logarithm q) = q.val.num.natAbs := by
    apply Nat.eq_of_factorization_eq (ne_of_gt (numerator_positive _)) hnq
    intro p
    by_cases hp : Nat.Prime p
    swap
    · simp [Nat.factorization_eq_zero_of_not_prime _ hp]
    rw [numerator_factorization _ ⟨p, hp⟩, logarithm_apply]
    have h := reduced_exponents_disjoint q ⟨p, hp⟩
    unfold valuation
    rcases h with h | h <;> simp [h]
  have hd : denominatorProduct (logarithm q) = q.val.den := by
    apply Nat.eq_of_factorization_eq (ne_of_gt (denominator_positive _)) q.val.den_ne_zero
    intro p
    by_cases hp : Nat.Prime p
    swap
    · simp [Nat.factorization_eq_zero_of_not_prime _ hp]
    rw [denominator_factorization _ ⟨p, hp⟩, logarithm_apply]
    have h := reduced_exponents_disjoint q ⟨p, hp⟩
    unfold valuation
    rcases h with h | h <;> simp [h]
  apply Subtype.ext
  calc
    (reconstruct (logarithm q)).val =
        (numeratorProduct (logarithm q) : ℚ) / (denominatorProduct (logarithm q) : ℚ) := rfl
    _ = (q.val.num.natAbs : ℚ) / (q.val.den : ℚ) := by rw [hn, hd]
    _ = (q.val.num : ℚ) / (q.val.den : ℚ) := by
      congr 1
      exact congrArg (fun z : ℤ => (z : ℚ)) (Int.natAbs_of_nonneg (Rat.num_pos.mpr q.property).le)
    _ = q.val := q.val.num_div_den


theorem reconstruction_injective : Function.Injective reconstruct := by
  intro a b hab
  calc
    a = logarithm (reconstruct a) := (logarithm_reconstruct a).symm
    _ = logarithm (reconstruct b) := congrArg logarithm hab
    _ = b := logarithm_reconstruct b

theorem reconstruct_add (a c : LogVector) :
    reconstruct (a + c) = positiveMul (reconstruct a) (reconstruct c) := by
  calc
    reconstruct (a + c) = reconstruct (logarithm (reconstruct a) + logarithm (reconstruct c)) := by
      rw [logarithm_reconstruct, logarithm_reconstruct]
    _ = reconstruct (logarithm (positiveMul (reconstruct a) (reconstruct c))) := by
      rw [logarithm_product]
    _ = positiveMul (reconstruct a) (reconstruct c) := reconstruct_logarithm _

theorem order_reflexive (a : LogVector) : vectorLE a a := le_refl _

theorem order_transitive (a b c : LogVector) (hab : vectorLE a b) (hbc : vectorLE b c) :
    vectorLE a c := by
  exact le_trans hab hbc

theorem order_total (a b : LogVector) : vectorLE a b ∨ vectorLE b a := le_total _ _

theorem order_antisymmetric (a b : LogVector) (hab : vectorLE a b) (hba : vectorLE b a) : a = b := by
  have h : (reconstruct a).val = (reconstruct b).val := le_antisymm hab hba
  exact reconstruction_injective (Subtype.ext h)

theorem order_translation (a b c : LogVector) : vectorLE (a + c) (b + c) ↔ vectorLE a b := by
  calc
    vectorLE (a + c) (b + c) ↔
        (reconstruct (a + c)).val ≤ (reconstruct (b + c)).val := Iff.rfl
    _ ↔ (reconstruct a).val * (reconstruct c).val ≤
        (reconstruct b).val * (reconstruct c).val := by rw [reconstruct_add, reconstruct_add]; rfl
    _ ↔ (reconstruct a).val ≤ (reconstruct b).val := mul_le_mul_iff_left₀ (reconstruct c).property
    _ ↔ vectorLE a b := Iff.rfl

theorem logarithm_order (q t : PositiveRational) :
    vectorLE (logarithm q) (logarithm t) ↔ q.val ≤ t.val := by
  calc
    vectorLE (logarithm q) (logarithm t) ↔
        (reconstruct (logarithm q)).val ≤ (reconstruct (logarithm t)).val := Iff.rfl
    _ ↔ q.val ≤ t.val := by rw [reconstruct_logarithm, reconstruct_logarithm]

end CellularAutomata.PrimeLogarithm
