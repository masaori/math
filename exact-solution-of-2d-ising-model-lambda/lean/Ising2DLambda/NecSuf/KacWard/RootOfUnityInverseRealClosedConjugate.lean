/-
「1 の冪根の逆元は実閉部分体上の共役である」の必要十分版。

具体版と同じ手順（共役の加法・乗法・単位元の保存、`R` の固定、対合、`N := ζ conj ζ = α²+β²`、
`N^n = 1`、`N = c·c` で `c ≠ 0`、二つの帰納法と三分法で `N = 1`、`ζ conj ζ = 1`）を、次の仮定だけで行う。

- `R`: 可換環で零因子を持たず、`0 ≠ 1`。零因子が無いことは帰納段の `cu ≠ 0` と `1 <_R 1` の否定
  （`0 = w·w ⇒ w = 0`）で使う。`0 ≠ 1` は `N = 0` なら `N^n = 0 ≠ 1` の段で使う。体であることは使わない。
- `K`: 可換環。`ι : R →+* K` は包含にあたる環準同型で、`ω·ω = −1` と各元の一意表示
  `z = ι α + ι β · ω` だけを仮定する。代数閉性は二つの平方の和が平方であることの証明にだけ効くので、
  その結論 `sum_is_square` を仮定に置く。`ι` の単射性は一意表示から従うので仮定しない。
- 順序は差が零でない平方であること。推移律 `lt_trans` と三分法の選言 `lt_trichotomy` だけを仮定する
  （三分法の排他性は使わない）。
- 結論の `ζ^{-1} = conj ζ` は、`K` が体でなくても述べられる形 `ζ · conj ζ = 1` にした。
  具体版の `ζ^{-1}` はこの両側逆元の一意性から得る（導出版）。

住処: 一般の可換環。実数体・複素数体は現れない。
-/
import Mathlib.Algebra.Ring.Hom.Defs
import Mathlib.Algebra.GroupWithZero.Basic
import Mathlib.Tactic.LinearCombination
import Mathlib.Order.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.KacWard

variable {R K : Type*} [CommRing R] [CommRing K]

/-- 差が零でない平方であること。 -/
def sqLt (a b : R) : Prop := ∃ w : R, w ≠ 0 ∧ b - a = w * w

/-- 一意表示の係数から `α − βω` を作る写像。 -/
noncomputable def conjOf (ι : R →+* K) (ω : K)
    (hdec : ∀ z : K, ∃! ab : R × R, z = ι ab.1 + ι ab.2 * ω) (z : K) : K :=
  let ab := Classical.choose (hdec z)
  ι ab.1 - ι ab.2 * ω

section

variable (ι : R →+* K) (ω : K) (hω : ω * ω = -1)
  (hdec : ∀ z : K, ∃! ab : R × R, z = ι ab.1 + ι ab.2 * ω)

include hdec in
theorem conjOf_eq (z : K) (a b : R) (h : z = ι a + ι b * ω) :
    conjOf ι ω hdec z = ι a - ι b * ω := by
  have hab := (Classical.choose_spec (hdec z)).2 (a, b) h
  simp only [conjOf, ← hab]

include hdec in
theorem conjOf_add (z w : K) :
    conjOf ι ω hdec (z + w) = conjOf ι ω hdec z + conjOf ι ω hdec w := by
  obtain ⟨⟨a, b⟩, hz, _⟩ := hdec z
  obtain ⟨⟨c, d⟩, hw, _⟩ := hdec w
  have hzw : z + w = ι (a + c) + ι (b + d) * ω := by
    rw [hz, hw, map_add, map_add]; ring
  calc conjOf ι ω hdec (z + w) = ι (a + c) - ι (b + d) * ω := conjOf_eq ι ω hdec _ _ _ hzw
    _ = conjOf ι ω hdec z + conjOf ι ω hdec w := by
        rw [conjOf_eq ι ω hdec z a b hz, conjOf_eq ι ω hdec w c d hw, map_add, map_add]; ring

include hω hdec in
theorem conjOf_mul (z w : K) :
    conjOf ι ω hdec (z * w) = conjOf ι ω hdec z * conjOf ι ω hdec w := by
  obtain ⟨⟨a, b⟩, hz, _⟩ := hdec z
  obtain ⟨⟨c, d⟩, hw, _⟩ := hdec w
  have hzw : z * w = ι (a * c - b * d) + ι (a * d + b * c) * ω := by
    rw [hz, hw, map_sub, map_add, map_mul, map_mul, map_mul, map_mul]
    linear_combination (ι b * ι d) * hω
  calc conjOf ι ω hdec (z * w) = ι (a * c - b * d) - ι (a * d + b * c) * ω :=
        conjOf_eq ι ω hdec _ _ _ hzw
    _ = (ι a - ι b * ω) * (ι c - ι d * ω) := by
        rw [map_sub, map_add, map_mul, map_mul, map_mul, map_mul]
        linear_combination (-(ι b * ι d)) * hω
    _ = conjOf ι ω hdec z * conjOf ι ω hdec w := by
        rw [conjOf_eq ι ω hdec z a b hz, conjOf_eq ι ω hdec w c d hw]

include hdec in
theorem conjOf_of_mem (r : R) : conjOf ι ω hdec (ι r) = ι r := by
  calc conjOf ι ω hdec (ι r) = ι r - ι 0 * ω := conjOf_eq ι ω hdec _ r 0 (by rw [map_zero]; ring)
    _ = ι r := by rw [map_zero]; ring

include hdec in
theorem conjOf_one : conjOf ι ω hdec 1 = 1 := by
  simpa using conjOf_of_mem ι ω hdec 1

include hdec in
theorem conjOf_involutive (z : K) : conjOf ι ω hdec (conjOf ι ω hdec z) = z := by
  obtain ⟨⟨a, b⟩, hz, _⟩ := hdec z
  have hc : conjOf ι ω hdec z = ι a + ι (-b) * ω := by
    rw [conjOf_eq ι ω hdec z a b hz, map_neg]; ring
  calc conjOf ι ω hdec (conjOf ι ω hdec z) = ι a - ι (-b) * ω := conjOf_eq ι ω hdec _ _ _ hc
    _ = ι a + ι b * ω := by rw [map_neg]; ring
    _ = z := hz.symm

include hdec in
theorem conjOf_bijective : Function.Bijective (conjOf ι ω hdec) := by
  constructor
  · intro z w h
    calc z = conjOf ι ω hdec (conjOf ι ω hdec z) := (conjOf_involutive ι ω hdec z).symm
      _ = conjOf ι ω hdec (conjOf ι ω hdec w) := by rw [h]
      _ = w := conjOf_involutive ι ω hdec w
  · intro z
    exact ⟨conjOf ι ω hdec z, conjOf_involutive ι ω hdec z⟩

include hω hdec in
theorem conjOf_pow (z : K) : ∀ m : ℕ, conjOf ι ω hdec (z ^ m) = conjOf ι ω hdec z ^ m := by
  intro m
  induction m with
  | zero => simpa using conjOf_one ι ω hdec
  | succ m ih => rw [pow_succ, conjOf_mul ι ω hω hdec, ih, pow_succ]

include hω hdec in
theorem conjOf_norm (z : K) (a b : R) (h : z = ι a + ι b * ω) :
    z * conjOf ι ω hdec z = ι (a * a + b * b) := by
  calc z * conjOf ι ω hdec z = (ι a + ι b * ω) * (ι a - ι b * ω) := by
        rw [conjOf_eq ι ω hdec z a b h, ← h]
    _ = ι (a * a + b * b) := by
        rw [map_add, map_mul, map_mul]
        linear_combination (-(ι b * ι b)) * hω

include hdec in
/-- 一意表示から `ι` は単射（`ι x = ι x + ι 0·ω` の表示の一意性）。 -/
theorem iota_injective_of_dec : Function.Injective ι := by
  intro x y hxy
  obtain ⟨ab, _, huniq⟩ := hdec (ι x)
  have hx : (x, (0 : R)) = ab := huniq (x, 0) (by show ι x = ι x + ι 0 * ω; rw [map_zero]; ring)
  have hy : (y, (0 : R)) = ab := huniq (y, 0) (by show ι x = ι y + ι 0 * ω; rw [map_zero, ← hxy]; ring)
  exact congrArg Prod.fst (hx.trans hy.symm)

include hω hdec in
theorem norm_pow_eq_one (n : ℕ) (z : K) (hz : z ^ n = 1) (a b : R) (h : z = ι a + ι b * ω) :
    (a * a + b * b) ^ n = 1 := by
  apply iota_injective_of_dec ι ω hdec
  calc ι ((a * a + b * b) ^ n) = ι (a * a + b * b) ^ n := map_pow _ _ _
    _ = (z * conjOf ι ω hdec z) ^ n := by rw [conjOf_norm ι ω hω hdec z a b h]
    _ = z ^ n * conjOf ι ω hdec z ^ n := mul_pow _ _ _
    _ = z ^ n * conjOf ι ω hdec (z ^ n) := by rw [conjOf_pow ι ω hω hdec]
    _ = 1 * conjOf ι ω hdec 1 := by rw [hz]
    _ = 1 := by rw [conjOf_one ι ω hdec, one_mul]
    _ = ι 1 := (map_one ι).symm

end

theorem norm_pos [Nontrivial R] (sum_is_square : ∀ u v : R, ∃ c : R, u * u + v * v = c * c)
    (n : ℕ) (hn : 0 < n) (a b : R) (hpow : (a * a + b * b) ^ n = 1) :
    ∃ c : R, c ≠ 0 ∧ a * a + b * b = c * c := by
  obtain ⟨c, hc⟩ := sum_is_square a b
  refine ⟨c, ?_, hc⟩
  intro hc0
  rw [hc, hc0, mul_zero, zero_pow hn.ne'] at hpow
  exact zero_ne_one hpow

theorem one_lt_pow [NoZeroDivisors R] (lt_trans : ∀ a b c : R, sqLt a b → sqLt b c → sqLt a c)
    (N c : R) (hc0 : c ≠ 0) (hc : N = c * c) (h1 : sqLt 1 N) :
    ∀ m : ℕ, 1 ≤ m → sqLt 1 (N ^ m) := by
  intro m hm
  induction m, hm using Nat.le_induction with
  | base => simpa using h1
  | succ m _ ih =>
      obtain ⟨u, hu0, hu⟩ := ih
      obtain ⟨s, hs0, hs⟩ := h1
      have hstep : sqLt (N - 1) (N ^ (m + 1) - 1) := by
        refine ⟨c * u, mul_ne_zero hc0 hu0, ?_⟩
        calc (N ^ (m + 1) - 1) - (N - 1) = N ^ (m + 1) - N := by ring
          _ = N * (N ^ m - 1) := by ring
          _ = (c * c) * (u * u) := by rw [← hc, hu]
          _ = (c * u) * (c * u) := by ring
      have h0 : sqLt 0 (N - 1) := ⟨s, hs0, by rw [sub_zero]; exact hs⟩
      obtain ⟨w, hw0, hw⟩ := lt_trans 0 (N - 1) (N ^ (m + 1) - 1) h0 hstep
      exact ⟨w, hw0, by rw [← hw, sub_zero]⟩

theorem pow_lt_one [NoZeroDivisors R] (lt_trans : ∀ a b c : R, sqLt a b → sqLt b c → sqLt a c)
    (N c : R) (hc0 : c ≠ 0) (hc : N = c * c) (h1 : sqLt N 1) :
    ∀ m : ℕ, 1 ≤ m → sqLt (N ^ m) 1 := by
  intro m hm
  induction m, hm using Nat.le_induction with
  | base => simpa using h1
  | succ m _ ih =>
      obtain ⟨u, hu0, hu⟩ := ih
      obtain ⟨s, hs0, hs⟩ := h1
      have hstep : sqLt (1 - N) (1 - N ^ (m + 1)) := by
        refine ⟨c * u, mul_ne_zero hc0 hu0, ?_⟩
        calc (1 - N ^ (m + 1)) - (1 - N) = N - N ^ (m + 1) := by ring
          _ = N * (1 - N ^ m) := by ring
          _ = (c * c) * (u * u) := by rw [← hc, hu]
          _ = (c * u) * (c * u) := by ring
      have h0 : sqLt 0 (1 - N) := ⟨s, hs0, by rw [sub_zero]; exact hs⟩
      obtain ⟨w, hw0, hw⟩ := lt_trans 0 (1 - N) (1 - N ^ (m + 1)) h0 hstep
      exact ⟨w, hw0, by rw [← hw, sub_zero]⟩

theorem not_one_lt_one [NoZeroDivisors R] : ¬ sqLt (1 : R) 1 := by
  rintro ⟨w, hw0, hw⟩
  rw [sub_self] at hw
  exact hw0 (mul_self_eq_zero.mp hw.symm)

theorem norm_eq_one [NoZeroDivisors R] (lt_trans : ∀ a b c : R, sqLt a b → sqLt b c → sqLt a c)
    (lt_trichotomy : ∀ a b : R, sqLt a b ∨ a = b ∨ sqLt b a)
    (n : ℕ) (hn : 0 < n) (N : R) (hpow : N ^ n = 1) (c : R) (hc0 : c ≠ 0) (hc : N = c * c) :
    N = 1 := by
  rcases lt_trichotomy 1 N with h | h | h
  · have hlt := one_lt_pow lt_trans N c hc0 hc h n hn
    rw [hpow] at hlt
    exact absurd hlt not_one_lt_one
  · exact h.symm
  · have hlt := pow_lt_one lt_trans N c hc0 hc h n hn
    rw [hpow] at hlt
    exact absurd hlt not_one_lt_one

/-- 必要十分版の本体。`α² + β² = 1`、`ζ · conj ζ = 1`、`conj ζ = ι α − ι β · ω`。 -/
theorem rootOfUnity_inverse_conj_necSuf [NoZeroDivisors R] [Nontrivial R] (ι : R →+* K) (ω : K) (hω : ω * ω = -1)
    (hdec : ∀ z : K, ∃! ab : R × R, z = ι ab.1 + ι ab.2 * ω)
    (sum_is_square : ∀ u v : R, ∃ c : R, u * u + v * v = c * c)
    (lt_trans : ∀ a b c : R, sqLt a b → sqLt b c → sqLt a c)
    (lt_trichotomy : ∀ a b : R, sqLt a b ∨ a = b ∨ sqLt b a)
    (n : ℕ) (hn : 0 < n) (z : K) (hz : z ^ n = 1) (a b : R) (h : z = ι a + ι b * ω) :
    a * a + b * b = 1 ∧ z * conjOf ι ω hdec z = 1 ∧ conjOf ι ω hdec z = ι a - ι b * ω := by
  have hpow := norm_pow_eq_one ι ω hω hdec n z hz a b h
  obtain ⟨c, hc0, hc⟩ := norm_pos sum_is_square n hn a b hpow
  have hN1 : a * a + b * b = 1 := norm_eq_one lt_trans lt_trichotomy n hn _ hpow c hc0 hc
  refine ⟨hN1, ?_, conjOf_eq ι ω hdec z a b h⟩
  rw [conjOf_norm ι ω hω hdec z a b h, hN1, map_one]

end Ising2DLambda.NecSuf.KacWard
