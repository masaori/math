/-
対数順序群の必要十分版。正本と各算術補題の対応は具体版 PrimeLogarithm.lean と同名。
整数係数の有限台・除算は任意の添字型へ広がり、素数性も添字全体の有限性も使わない。
加法の等式は有限台さえ使わず、各係数の対応する法則だけを使う。
対数と復元の相互逆性には自然数の素因数分解の一意性が実際に必要であるため、
その算術部分は正の有理数と素数を保持し、具体版と同じ各指数の計算で証明する。
素数性を捨てて任意の基数へ置き換える一般化はしない（4と2では指数表が一意にならない）。
順序の移送では加法群の公理を要求せず、復元の単射性と正の因子の消去だけを使う。
最後の Derivation は定義の一致を介して具体版を特殊化として導く。
-/
import CellularAutomata.PrimeLogarithm

namespace CellularAutomata.NecSuf.PrimeLogarithm

namespace Vectors
variable {I : Type*}
noncomputable def scale (d : ℤ) (a : (I →₀ ℤ)) : (I →₀ ℤ) :=
  a.mapRange (fun z => d * z) (mul_zero d)

theorem scale_apply (d : ℤ) (a : (I →₀ ℤ)) (p : I) :
    scale d a p = d * a p := rfl

open Classical in
theorem add_support (a b : (I →₀ ℤ)) : (a + b).support ⊆ a.support ∪ b.support := by
  classical
  intro p hp
  by_contra h
  have ha : a p = 0 := Finsupp.notMem_support_iff.mp (fun hpa => h (Finset.mem_union_left _ hpa))
  have hb : b p = 0 := Finsupp.notMem_support_iff.mp (fun hpb => h (Finset.mem_union_right _ hpb))
  exact (Finsupp.mem_support_iff.mp hp) (by simp [ha, hb])

theorem neg_support (a : (I →₀ ℤ)) : (-a).support ⊆ a.support := by
  intro p hp
  by_contra h
  have ha := Finsupp.notMem_support_iff.mp h
  exact (Finsupp.mem_support_iff.mp hp) (by simp [ha])

theorem scale_support (d : ℤ) (a : (I →₀ ℤ)) : (scale d a).support ⊆ a.support := by
  intro p hp
  by_contra h
  have ha := Finsupp.notMem_support_iff.mp h
  exact (Finsupp.mem_support_iff.mp hp) (by rw [scale_apply, ha, mul_zero])

theorem integer_division (a : (I →₀ ℤ)) (d : ℤ) (hd : d ≠ 0) :
    (∃! b : (I →₀ ℤ), scale d b = a) ↔ ∀ p ∈ a.support, d ∣ a p := by
  constructor
  · rintro ⟨b, hb, _⟩ p _
    refine ⟨b p, ?_⟩
    exact (congrArg (fun v : (I →₀ ℤ) => v p) hb).symm
  · intro h
    let b : (I →₀ ℤ) := a.mapRange (fun z => z / d) (Int.zero_ediv d)
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
    have hc' : d * c p = a p := congrArg (fun v : (I →₀ ℤ) => v p) hc
    have hb' : d * b p = a p := congrArg (fun v : (I →₀ ℤ) => v p) hb
    exact mul_left_cancel₀ hd (hc'.trans hb'.symm)



-- Finite support is unnecessary for these equalities; each needs only its named coefficient law.
theorem pointwise_assoc {C : Type*} [AddSemigroup C] (a b c : I → C) :
    (a + b) + c = a + (b + c) := by
  funext p
  calc
    ((a + b) + c) p = (a p + b p) + c p := rfl
    _ = a p + (b p + c p) := add_assoc _ _ _
    _ = (a + (b + c)) p := rfl

theorem pointwise_comm {C : Type*} [AddCommMagma C] (a b : I → C) : a + b = b + a := by
  funext p
  calc
    (a + b) p = a p + b p := rfl
    _ = b p + a p := add_comm _ _
    _ = (b + a) p := rfl

theorem pointwise_zero {C : Type*} [AddZeroClass C] (a : I → C) : a + 0 = a := by
  funext p
  calc
    (a + 0) p = a p + 0 := rfl
    _ = a p := add_zero _

theorem pointwise_inverse {C : Type*} [AddGroup C] (a : I → C) : a + (-a) = 0 := by
  funext p
  calc
    (a + (-a)) p = a p + (-a p) := rfl
    _ = 0 := add_neg_cancel _
    _ = (0 : I → C) p := rfl

end Vectors

abbrev Prime := {p : ℕ // p.Prime}
abbrev LogVector := Prime →₀ ℤ
abbrev PositiveRational := {q : ℚ // 0 < q}

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


namespace OrderTransport
variable {L : Type*} (R : L → PositiveRational)

def relation (a b : L) : Prop := (R a).val ≤ (R b).val

theorem reflexive (a : L) : relation R a a := by
  exact le_refl (R a).val

theorem transitive (a b c : L) (hab : relation R a b) (hbc : relation R b c) :
    relation R a c := by
  exact le_trans hab hbc

theorem total (a b : L) : relation R a b ∨ relation R b a := by
  exact le_total (R a).val (R b).val

theorem antisymmetric (hinj : Function.Injective R) (a b : L)
    (hab : relation R a b) (hba : relation R b a) : a = b := by
  have h : (R a).val = (R b).val := le_antisymm hab hba
  exact hinj (Subtype.ext h)

-- Only these two product identities and positivity of R c enter the cancellation step.
theorem translation (addL : L → L → L) (a b c : L)
    (ha : R (addL a c) = positiveMul (R a) (R c))
    (hb : R (addL b c) = positiveMul (R b) (R c)) :
    relation R (addL a c) (addL b c) ↔ relation R a b := by
  calc
    relation R (addL a c) (addL b c) ↔
        (R (addL a c)).val ≤ (R (addL b c)).val := Iff.rfl
    _ ↔ (R a).val * (R c).val ≤ (R b).val * (R c).val := by rw [ha, hb]; rfl
    _ ↔ (R a).val ≤ (R b).val := mul_le_mul_iff_left₀ (R c).property
    _ ↔ relation R a b := Iff.rfl
end OrderTransport

namespace Derivation

theorem scale_agrees (d : ℤ) (a : CellularAutomata.PrimeLogarithm.LogVector) : Vectors.scale d a = CellularAutomata.PrimeLogarithm.scale d a := by
  ext p
  rfl

theorem associativity (a b c : CellularAutomata.PrimeLogarithm.LogVector) : (a+b)+c = a+(b+c) := by
  ext p
  exact congrFun (Vectors.pointwise_assoc (fun i => a i) (fun i => b i) (fun i => c i)) p

theorem commutativity (a b : CellularAutomata.PrimeLogarithm.LogVector) : a+b = b+a := by
  ext p
  exact congrFun (Vectors.pointwise_comm (fun i => a i) (fun i => b i)) p

theorem zero (a : CellularAutomata.PrimeLogarithm.LogVector) : a+0 = a := by
  ext p
  exact congrFun (Vectors.pointwise_zero (fun i => a i)) p

theorem inverse (a : CellularAutomata.PrimeLogarithm.LogVector) : a+(-a) = 0 := by
  ext p
  exact congrFun (Vectors.pointwise_inverse (fun i => a i)) p

theorem division (a : CellularAutomata.PrimeLogarithm.LogVector) (d : ℤ) (hd : d ≠ 0) :
    (∃! b : CellularAutomata.PrimeLogarithm.LogVector, CellularAutomata.PrimeLogarithm.scale d b = a) ↔ ∀ p ∈ a.support, d ∣ a p := by
  have h := Vectors.integer_division a d hd
  simpa only [scale_agrees] using h

theorem log_agrees (q : CellularAutomata.PrimeLogarithm.PositiveRational) : logarithm q = CellularAutomata.PrimeLogarithm.logarithm q := by
  ext p
  rfl

theorem reconstruction_agrees (a : CellularAutomata.PrimeLogarithm.LogVector) : reconstruct a = CellularAutomata.PrimeLogarithm.reconstruct a := by
  apply Subtype.ext
  rfl

theorem log_reconstruction (a : CellularAutomata.PrimeLogarithm.LogVector) : CellularAutomata.PrimeLogarithm.logarithm (CellularAutomata.PrimeLogarithm.reconstruct a) = a := by
  have h := logarithm_reconstruct a
  simpa only [log_agrees, reconstruction_agrees] using h

theorem reconstruction_log (q : CellularAutomata.PrimeLogarithm.PositiveRational) : CellularAutomata.PrimeLogarithm.reconstruct (CellularAutomata.PrimeLogarithm.logarithm q) = q := by
  have h := reconstruct_logarithm q
  simpa only [log_agrees, reconstruction_agrees] using h

theorem product (q t : CellularAutomata.PrimeLogarithm.PositiveRational) :
    CellularAutomata.PrimeLogarithm.logarithm (CellularAutomata.PrimeLogarithm.positiveMul q t) = CellularAutomata.PrimeLogarithm.logarithm q + CellularAutomata.PrimeLogarithm.logarithm t := by
  exact logarithm_product q t

theorem ratio (q t : CellularAutomata.PrimeLogarithm.PositiveRational) :
    CellularAutomata.PrimeLogarithm.logarithm (CellularAutomata.PrimeLogarithm.positiveDiv q t) = CellularAutomata.PrimeLogarithm.logarithm q - CellularAutomata.PrimeLogarithm.logarithm t := by
  exact logarithm_ratio q t

theorem order_refl (a : CellularAutomata.PrimeLogarithm.LogVector) : CellularAutomata.PrimeLogarithm.vectorLE a a := by
  exact OrderTransport.reflexive CellularAutomata.PrimeLogarithm.reconstruct a

theorem order_trans (a b c : CellularAutomata.PrimeLogarithm.LogVector) (hab : CellularAutomata.PrimeLogarithm.vectorLE a b) (hbc : CellularAutomata.PrimeLogarithm.vectorLE b c) :
    CellularAutomata.PrimeLogarithm.vectorLE a c := by
  exact OrderTransport.transitive CellularAutomata.PrimeLogarithm.reconstruct a b c hab hbc

theorem order_tot (a b : CellularAutomata.PrimeLogarithm.LogVector) : CellularAutomata.PrimeLogarithm.vectorLE a b ∨ CellularAutomata.PrimeLogarithm.vectorLE b a := by
  exact OrderTransport.total CellularAutomata.PrimeLogarithm.reconstruct a b

theorem order_antisymm (a b : CellularAutomata.PrimeLogarithm.LogVector) (hab : CellularAutomata.PrimeLogarithm.vectorLE a b) (hba : CellularAutomata.PrimeLogarithm.vectorLE b a) : a = b := by
  exact OrderTransport.antisymmetric CellularAutomata.PrimeLogarithm.reconstruct reconstruction_injective a b hab hba

theorem order_add (a b c : CellularAutomata.PrimeLogarithm.LogVector) : CellularAutomata.PrimeLogarithm.vectorLE (a+c) (b+c) ↔ CellularAutomata.PrimeLogarithm.vectorLE a b := by
  exact OrderTransport.translation CellularAutomata.PrimeLogarithm.reconstruct (fun x y => x+y) a b c
    (reconstruct_add a c) (reconstruct_add b c)

theorem order_log (q t : CellularAutomata.PrimeLogarithm.PositiveRational) :
    CellularAutomata.PrimeLogarithm.vectorLE (CellularAutomata.PrimeLogarithm.logarithm q) (CellularAutomata.PrimeLogarithm.logarithm t) ↔ q.val ≤ t.val := by
  exact logarithm_order q t

end Derivation
end CellularAutomata.NecSuf.PrimeLogarithm
