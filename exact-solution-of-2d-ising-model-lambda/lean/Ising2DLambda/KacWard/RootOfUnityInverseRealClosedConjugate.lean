/-
章「有限 Fourier 分解と分散関係」の「1 の冪根の逆元は実閉部分体上の共役である」
（`claim_root_of_unity_inverse_is_real_closed_conjugate`）の具体版。

  人手証明                                                          このファイル
  conj_R(α+βω) := α−βω（第 4 条件の一意表示で一意に定まる）         `realClosedConj`、`realClosedConj_eq`
  conj_R(z+w) の二行                                                 `realClosedConj_add`
  zw の一意表示、conj_R(zw) の三行                                   `realClosedConj_mul`
  r ∈ R の表示 r+0ω と conj_R(r) = r の二行                          `realClosedConj_of_mem`、`realClosedConj_one`
  conj_R(conj_R(z)) = z の三行、従って全単射                         `realClosedConj_involutive`、`realClosedConj_bijective`
  N := ζ conj_R(ζ) = α²+β² の二行                                    `realClosedConj_norm`
  N^n = (ζ conj_R ζ)^n = ζ^n conj_R(ζ)^n = ζ^n conj_R(ζ^n) = 1        `realClosedConj_pow`、`realClosedNorm_pow_eq_one`
  α²+β² = c·c（二つの平方の和は平方）、c ≠ 0、0 <_R N                `rootOfUnity_realClosedNorm_pos`
  1 <_R N なら 1 <_R N^m（帰納法の四行）                             `realClosedNorm_one_lt_pow`
  N <_R 1 なら N^m <_R 1（帰納法の四行）                             `realClosedNorm_pow_lt_one`
  三分法で N = 1                                                     `rootOfUnity_realClosedNorm_eq_one`
  α²+β² = 1、ζ^{-1} = conj_R(ζ) = α−βω の四行                         `rootOfUnity_inverse_realClosedConj`

順序の事実は本文の定義・主張（狭義順序の定義、推移律、三分法、二つの平方の和は平方）の具体版を引く。
必要十分版の定理・定義は使わない。住処: Qbar（実閉部分体 R ⊂ Qbar）。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.RealAlgebraicOrderTransitive
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- `conj_R`。一意表示 `z = α + βω` の係数から `α − βω` を作る。 -/
noncomputable def realClosedConj (data : RealClosedSubfieldData) (z : Qbar) : Qbar :=
  let ab := Classical.choose (data.unique_decomposition z)
  (ab.1 : Qbar) - (ab.2 : Qbar) * data.omega

/-- 定義: 表示 `z = α + βω` を一つ与えれば `conj_R(z) = α − βω`（第 4 条件の一意性）。 -/
theorem realClosedConj_eq (data : RealClosedSubfieldData) (z : Qbar) (a b : data.carrier)
    (h : z = (a : Qbar) + (b : Qbar) * data.omega) :
    realClosedConj data z = (a : Qbar) - (b : Qbar) * data.omega := by
  have hab := (Classical.choose_spec (data.unique_decomposition z)).2 (a, b) h
  simp only [realClosedConj, ← hab]

/-- 加法の保存。`z+w = (α+γ) + (β+δ)ω` の表示から二行。 -/
theorem realClosedConj_add (data : RealClosedSubfieldData) (z w : Qbar) :
    realClosedConj data (z + w) = realClosedConj data z + realClosedConj data w := by
  obtain ⟨⟨a, b⟩, hz, _⟩ := data.unique_decomposition z
  obtain ⟨⟨c, d⟩, hw, _⟩ := data.unique_decomposition w
  have hzw : z + w = ((a + c : data.carrier) : Qbar) + ((b + d : data.carrier) : Qbar) * data.omega := by
    rw [hz, hw]; push_cast; ring
  calc realClosedConj data (z + w)
      = ((a + c : data.carrier) : Qbar) - ((b + d : data.carrier) : Qbar) * data.omega :=
        realClosedConj_eq data _ _ _ hzw
    _ = realClosedConj data z + realClosedConj data w := by
        rw [realClosedConj_eq data z a b hz, realClosedConj_eq data w c d hw]; push_cast; ring

/-- 乗法の保存。`zw = (αγ−βδ) + (αδ+βγ)ω`（`ω² = −1`）の表示から三行。 -/
theorem realClosedConj_mul (data : RealClosedSubfieldData) (z w : Qbar) :
    realClosedConj data (z * w) = realClosedConj data z * realClosedConj data w := by
  obtain ⟨⟨a, b⟩, hz, _⟩ := data.unique_decomposition z
  obtain ⟨⟨c, d⟩, hw, _⟩ := data.unique_decomposition w
  have hzw : z * w = ((a * c - b * d : data.carrier) : Qbar)
      + ((a * d + b * c : data.carrier) : Qbar) * data.omega := by
    rw [hz, hw]; push_cast
    linear_combination ((b : Qbar) * (d : Qbar)) * data.omega_sq
  calc realClosedConj data (z * w)
      = ((a * c - b * d : data.carrier) : Qbar)
          - ((a * d + b * c : data.carrier) : Qbar) * data.omega :=
        realClosedConj_eq data _ _ _ hzw
    _ = ((a : Qbar) - (b : Qbar) * data.omega) * ((c : Qbar) - (d : Qbar) * data.omega) := by
        push_cast
        linear_combination (-((b : Qbar) * (d : Qbar))) * data.omega_sq
    _ = realClosedConj data z * realClosedConj data w := by
        rw [realClosedConj_eq data z a b hz, realClosedConj_eq data w c d hw]

/-- `R` を点ごとに固定する。`r` の表示は `r + 0ω`。 -/
theorem realClosedConj_of_mem (data : RealClosedSubfieldData) (r : data.carrier) :
    realClosedConj data (r : Qbar) = r := by
  calc realClosedConj data (r : Qbar)
      = (r : Qbar) - ((0 : data.carrier) : Qbar) * data.omega :=
        realClosedConj_eq data _ r 0 (by push_cast; ring)
    _ = r := by push_cast; ring

/-- 単位元の保存（`1 ∈ R`）。 -/
theorem realClosedConj_one (data : RealClosedSubfieldData) :
    realClosedConj data 1 = 1 := by
  simpa using realClosedConj_of_mem data 1

/-- 対合性。`conj_R(α − βω) = α + βω`（表示 `α + (−β)ω`）。 -/
theorem realClosedConj_involutive (data : RealClosedSubfieldData) (z : Qbar) :
    realClosedConj data (realClosedConj data z) = z := by
  obtain ⟨⟨a, b⟩, hz, _⟩ := data.unique_decomposition z
  have hc : realClosedConj data z = (a : Qbar) + ((-b : data.carrier) : Qbar) * data.omega := by
    rw [realClosedConj_eq data z a b hz]; push_cast; ring
  calc realClosedConj data (realClosedConj data z)
      = (a : Qbar) - ((-b : data.carrier) : Qbar) * data.omega :=
        realClosedConj_eq data _ _ _ hc
    _ = (a : Qbar) + (b : Qbar) * data.omega := by push_cast; ring
    _ = z := hz.symm

/-- 対合なので全単射。 -/
theorem realClosedConj_bijective (data : RealClosedSubfieldData) :
    Function.Bijective (realClosedConj data) := by
  constructor
  · intro z w h
    calc z = realClosedConj data (realClosedConj data z) := (realClosedConj_involutive data z).symm
      _ = realClosedConj data (realClosedConj data w) := by rw [h]
      _ = w := realClosedConj_involutive data w
  · intro z
    exact ⟨realClosedConj data z, realClosedConj_involutive data z⟩

/-- 冪の保存（乗法の保存と単位元の保存の帰納法）。 -/
theorem realClosedConj_pow (data : RealClosedSubfieldData) (z : Qbar) :
    ∀ m : ℕ, realClosedConj data (z ^ m) = realClosedConj data z ^ m := by
  intro m
  induction m with
  | zero => simpa using realClosedConj_one data
  | succ m ih => rw [pow_succ, realClosedConj_mul, ih, pow_succ]

/-- `N := ζ conj_R(ζ) = α² + β²`。 -/
theorem realClosedConj_norm (data : RealClosedSubfieldData) (z : Qbar) (a b : data.carrier)
    (h : z = (a : Qbar) + (b : Qbar) * data.omega) :
    z * realClosedConj data z = ((a * a + b * b : data.carrier) : Qbar) := by
  calc z * realClosedConj data z
      = ((a : Qbar) + (b : Qbar) * data.omega) * ((a : Qbar) - (b : Qbar) * data.omega) := by
        rw [realClosedConj_eq data z a b h, ← h]
    _ = ((a * a + b * b : data.carrier) : Qbar) := by
        push_cast
        linear_combination (-((b : Qbar) * (b : Qbar))) * data.omega_sq

/-- `N^n = (ζ conj_R ζ)^n = ζ^n conj_R(ζ)^n = ζ^n conj_R(ζ^n) = 1·conj_R(1) = 1`。
`R` の中の等式として受け取る（包含は単射）。 -/
theorem realClosedNorm_pow_eq_one (data : RealClosedSubfieldData) (n : ℕ) (z : Qbar)
    (hz : z ∈ RootOfUnity n) (a b : data.carrier)
    (h : z = (a : Qbar) + (b : Qbar) * data.omega) :
    (a * a + b * b) ^ n = 1 := by
  have hzn : z ^ n = 1 := hz
  apply Subtype.ext
  have hchain : ((a * a + b * b : data.carrier) : Qbar) ^ n = 1 := by
    calc ((a * a + b * b : data.carrier) : Qbar) ^ n
        = (z * realClosedConj data z) ^ n := by rw [realClosedConj_norm data z a b h]
      _ = z ^ n * realClosedConj data z ^ n := mul_pow _ _ _
      _ = z ^ n * realClosedConj data (z ^ n) := by rw [realClosedConj_pow]
      _ = 1 * realClosedConj data 1 := by rw [hzn]
      _ = 1 := by rw [realClosedConj_one, one_mul]
  push_cast at hchain ⊢
  exact hchain

/-- 二つの平方の和は平方 `N = c·c`。`c = 0` なら `N^n = 0 ≠ 1` なので `c ≠ 0`、すなわち `0 <_R N`。 -/
theorem rootOfUnity_realClosedNorm_pos (data : RealClosedSubfieldData) (n : ℕ) (hn : 0 < n)
    (a b : data.carrier) (hpow : (a * a + b * b) ^ n = 1) :
    ∃ c : data.carrier, c ≠ 0 ∧ a * a + b * b = c * c := by
  obtain ⟨c, hc⟩ := realClosed_sum_of_two_squares_is_square data a b
  refine ⟨c, ?_, hc⟩
  intro hc0
  rw [hc, hc0, mul_zero, zero_pow hn.ne'] at hpow
  exact zero_ne_one hpow

/-- `1 <_R N` なら任意の `m ≥ 1` で `1 <_R N^m`。帰納段は
`(N^{m+1} − 1) − (N − 1) = N^{m+1} − N = N(N^m − 1) = (c·c)(u·u) = (cu)(cu)` と推移律。 -/
theorem realClosedNorm_one_lt_pow (data : RealClosedSubfieldData) (N c : data.carrier)
    (hc0 : c ≠ 0) (hc : N = c * c) (h1 : realAlgebraicLt data 1 N) :
    ∀ m : ℕ, 1 ≤ m → realAlgebraicLt data 1 (N ^ m) := by
  intro m hm
  induction m, hm using Nat.le_induction with
  | base => simpa using h1
  | succ m _ ih =>
      obtain ⟨u, hu0, hu⟩ := ih
      obtain ⟨s, hs0, hs⟩ := h1
      have hstep : realAlgebraicLt data (N - 1) (N ^ (m + 1) - 1) := by
        refine ⟨c * u, mul_ne_zero hc0 hu0, ?_⟩
        calc (N ^ (m + 1) - 1) - (N - 1) = N ^ (m + 1) - N := by ring
          _ = N * (N ^ m - 1) := by ring
          _ = (c * c) * (u * u) := by rw [← hc, hu]
          _ = (c * u) * (c * u) := by ring
      have h0 : realAlgebraicLt data 0 (N - 1) := ⟨s, hs0, by rw [sub_zero]; exact hs⟩
      obtain ⟨w, hw0, hw⟩ := realAlgebraicLt_trans data 0 (N - 1) (N ^ (m + 1) - 1) h0 hstep
      exact ⟨w, hw0, by rw [← hw, sub_zero]⟩

/-- `N <_R 1` なら任意の `m ≥ 1` で `N^m <_R 1`。帰納段は
`(1 − N^{m+1}) − (1 − N) = N − N^{m+1} = N(1 − N^m) = (c·c)(u·u) = (cu)(cu)` と推移律。 -/
theorem realClosedNorm_pow_lt_one (data : RealClosedSubfieldData) (N c : data.carrier)
    (hc0 : c ≠ 0) (hc : N = c * c) (h1 : realAlgebraicLt data N 1) :
    ∀ m : ℕ, 1 ≤ m → realAlgebraicLt data (N ^ m) 1 := by
  intro m hm
  induction m, hm using Nat.le_induction with
  | base => simpa using h1
  | succ m _ ih =>
      obtain ⟨u, hu0, hu⟩ := ih
      obtain ⟨s, hs0, hs⟩ := h1
      have hstep : realAlgebraicLt data (1 - N) (1 - N ^ (m + 1)) := by
        refine ⟨c * u, mul_ne_zero hc0 hu0, ?_⟩
        calc (1 - N ^ (m + 1)) - (1 - N) = N - N ^ (m + 1) := by ring
          _ = N * (1 - N ^ m) := by ring
          _ = (c * c) * (u * u) := by rw [← hc, hu]
          _ = (c * u) * (c * u) := by ring
      have h0 : realAlgebraicLt data 0 (1 - N) := ⟨s, hs0, by rw [sub_zero]; exact hs⟩
      obtain ⟨w, hw0, hw⟩ := realAlgebraicLt_trans data 0 (1 - N) (1 - N ^ (m + 1)) h0 hstep
      exact ⟨w, hw0, by rw [← hw, sub_zero]⟩

/-- `1 <_R 1` は成り立たない（`0 = w·w` なら `w = 0`）。 -/
theorem realClosed_not_one_lt_one (data : RealClosedSubfieldData) :
    ¬ realAlgebraicLt data 1 1 := by
  rintro ⟨w, hw0, hw⟩
  rw [sub_self] at hw
  exact hw0 (mul_self_eq_zero.mp hw.symm)

/-- 三分法（`claim_real_algebraic_order_trichotomy`）で `N = 1`。
`1 <_R N` と `N <_R 1` はそれぞれ `1 <_R N^n = 1` と `N^n = 1 <_R 1` を与えて矛盾する。 -/
theorem rootOfUnity_realClosedNorm_eq_one (data : RealClosedSubfieldData) (n : ℕ) (hn : 0 < n)
    (N : data.carrier) (hpow : N ^ n = 1) (c : data.carrier) (hc0 : c ≠ 0) (hc : N = c * c) :
    N = 1 := by
  rcases (realAlgebraicLt_trichotomy data 1 N).1 with h | h | h
  · have hlt := realClosedNorm_one_lt_pow data N c hc0 hc h n hn
    rw [hpow] at hlt
    exact absurd hlt (realClosed_not_one_lt_one data)
  · exact h.symm
  · have hlt := realClosedNorm_pow_lt_one data N c hc0 hc h n hn
    rw [hpow] at hlt
    exact absurd hlt (realClosed_not_one_lt_one data)

/-- `claim_root_of_unity_inverse_is_real_closed_conjugate` の具体版。
`α² + β² = N = 1`、`ζ^{-1} = ζ^{-1}·N = ζ^{-1}(ζ conj_R ζ) = conj_R(ζ) = α − βω`。 -/
theorem rootOfUnity_inverse_realClosedConj (data : RealClosedSubfieldData) (n : ℕ) (hn : 0 < n)
    (z : Qbar) (hz : z ∈ RootOfUnity n) (a b : data.carrier)
    (h : z = (a : Qbar) + (b : Qbar) * data.omega) :
    a * a + b * b = 1 ∧ z⁻¹ = realClosedConj data z ∧
      realClosedConj data z = (a : Qbar) - (b : Qbar) * data.omega := by
  have hpow := realClosedNorm_pow_eq_one data n z hz a b h
  obtain ⟨c, hc0, hc⟩ := rootOfUnity_realClosedNorm_pos data n hn a b hpow
  have hN1 : a * a + b * b = 1 :=
    rootOfUnity_realClosedNorm_eq_one data n hn (a * a + b * b) hpow c hc0 hc
  have hz0 : z ≠ 0 := by
    intro hz0
    have hzn : z ^ n = 1 := hz
    rw [hz0, zero_pow hn.ne'] at hzn
    exact zero_ne_one hzn
  have hNq : ((a * a + b * b : data.carrier) : Qbar) = 1 := by rw [hN1]; rfl
  refine ⟨hN1, ?_, realClosedConj_eq data z a b h⟩
  calc z⁻¹ = z⁻¹ * 1 := (mul_one _).symm
    _ = z⁻¹ * ((a * a + b * b : data.carrier) : Qbar) := by rw [hNq]
    _ = z⁻¹ * (z * realClosedConj data z) := by rw [realClosedConj_norm data z a b h]
    _ = realClosedConj data z := by rw [← mul_assoc, inv_mul_cancel₀ hz0, one_mul]

end Ising2DLambda.KacWard
