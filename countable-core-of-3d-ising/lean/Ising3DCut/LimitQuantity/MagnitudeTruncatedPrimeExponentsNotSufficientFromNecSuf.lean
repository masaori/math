/-
具体版「素指数を大きさで切り詰める粗視化は箱サイズ極限の一致に十分でない」が、
必要十分版 `Ising3DCut.NecSuf.truncated_coordinate_data_not_sufficient` の
特殊化として得られることの導出。

座標を素数、座標の値を整数の素指数、切り詰めを高さ `N` での `min`、
値を二つの正の実数 `2^N` と `2^(N+1)` として取る。

具体版の定理をここで呼び直すことはしない（それでは必要十分版の検査にならない）。
使うのは、具体版の証明が使っている算術の段（素指数の計算・正の実数乗根の一意性）だけである。
-/
import Ising3DCut.LimitQuantity.MagnitudeTruncatedPrimeExponentsNotSufficient
import Ising3DCut.NecSuf.MagnitudeTruncationNotSufficient

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版の反例が、必要十分版の特殊化として得られる。 -/
theorem magnitude_truncated_prime_exponents_are_not_sufficient_for_limit_quantity_fromNecSuf
    (N : ℕ) (_hN : N ≠ 0) :
    ∃ (A B : ℕ → ℚ) (M : ℕ → ℕ) (ℓ ℓ' : ℝ),
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, M L ≠ 0) ∧
      (∀ L, ∀ p : ℕ, p.Prime →
        min (padicValRat p (A L)) (N : ℤ) = min (padicValRat p (B L)) (N : ℤ)) ∧
      (∀ L, padicValRat 2 (A L) ≠ padicValRat 2 (B L)) ∧
      Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  have hposAR : (0 : ℝ) < ((2 : ℝ) ^ N) := by positivity
  have hposBR : (0 : ℝ) < ((2 : ℝ) ^ (N + 1)) := by positivity
  -- 必要十分版へ渡す三つの仮定（座標ごとの一致・ある座標での相違・二つの値の相違）。
  have hagree : ∀ p : {p : ℕ // p.Prime},
      min (padicValRat p.1 (((2 ^ N : ℕ) : ℚ))) (N : ℤ)
        = min (padicValRat p.1 (((2 ^ (N + 1) : ℕ) : ℚ))) (N : ℤ) := by
    rintro ⟨p, hp⟩
    by_cases h2 : p = 2
    · subst h2
      rw [padicValRat_two_pow N, padicValRat_two_pow (N + 1)]
      have h1 : min (N : ℤ) (N : ℤ) = (N : ℤ) := min_self _
      have h2 : min (((N + 1 : ℕ)) : ℤ) (N : ℤ) = (N : ℤ) := by
        rw [min_eq_right]
        push_cast
        omega
      rw [h1, h2]
    · rw [padicValRat_ne_two_pow p N hp h2, padicValRat_ne_two_pow p (N + 1) hp h2]
  have hsep : padicValRat 2 (((2 ^ N : ℕ) : ℚ)) ≠ padicValRat 2 (((2 ^ (N + 1) : ℕ) : ℚ)) := by
    rw [padicValRat_two_pow N, padicValRat_two_pow (N + 1)]
    push_cast
    omega
  have hxy : ((2 : ℝ) ^ N) ≠ ((2 : ℝ) ^ (N + 1)) := by
    have hlt : ((2 : ℝ) ^ N) < ((2 : ℝ) ^ (N + 1)) := by
      have h1 : (1 : ℝ) < 2 := by norm_num
      exact pow_lt_pow_right₀ h1 (Nat.lt_succ_self N)
    exact ne_of_lt hlt
  obtain ⟨hagree', hsep', hlimA, hlimB, hne⟩ :=
    NecSuf.truncated_coordinate_data_not_sufficient
      (fun v : ℤ => min v (N : ℤ))
      (fun p : {p : ℕ // p.Prime} => padicValRat p.1 (((2 ^ N : ℕ) : ℚ)))
      (fun p : {p : ℕ // p.Prime} => padicValRat p.1 (((2 ^ (N + 1) : ℕ) : ℚ)))
      ⟨2, Nat.prime_two⟩ ((2 : ℝ) ^ N) ((2 : ℝ) ^ (N + 1)) hagree hsep hxy
  -- 必要十分版が返した二つの定数列の収束を、具体版の乗根列の収束へ言い換える。
  have hfunA : (fun _ : ℕ => posRoot ((((2 ^ N : ℕ) : ℚ) : ℝ)) 1)
      = fun _ : ℕ => ((2 : ℝ) ^ N) := by
    funext L
    have hcast : ((((2 ^ N : ℕ) : ℚ)) : ℝ) = ((2 : ℝ) ^ N) := by push_cast; ring
    rw [hcast]
    exact (eq_posRoot_of_pow_eq ((2 : ℝ) ^ N) ((2 : ℝ) ^ N) hposAR hposAR 1 one_ne_zero
      (by norm_num)).symm
  have hfunB : (fun _ : ℕ => posRoot ((((2 ^ (N + 1) : ℕ) : ℚ) : ℝ)) 1)
      = fun _ : ℕ => ((2 : ℝ) ^ (N + 1)) := by
    funext L
    have hcast : ((((2 ^ (N + 1) : ℕ) : ℚ)) : ℝ) = ((2 : ℝ) ^ (N + 1)) := by push_cast; ring
    rw [hcast]
    exact (eq_posRoot_of_pow_eq ((2 : ℝ) ^ (N + 1)) ((2 : ℝ) ^ (N + 1)) hposBR hposBR 1
      one_ne_zero (by norm_num)).symm
  refine ⟨fun _ => ((2 ^ N : ℕ) : ℚ), fun _ => ((2 ^ (N + 1) : ℕ) : ℚ), fun _ => 1,
    (2 : ℝ) ^ N, (2 : ℝ) ^ (N + 1),
    fun _ => by positivity, fun _ => by positivity, fun _ => one_ne_zero, ?_, ?_, ?_, ?_, hne⟩
  · intro _ p hp
    exact hagree' ⟨p, hp⟩
  · intro _
    exact hsep'
  · rw [hfunA]
    exact hlimA
  · rw [hfunB]
    exact hlimB

end Ising3DCut.LimitQuantity
