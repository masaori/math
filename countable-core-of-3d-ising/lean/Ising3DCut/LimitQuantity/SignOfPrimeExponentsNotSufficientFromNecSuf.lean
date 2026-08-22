/-
具体版「素指数の符号だけを見る粗視化は箱サイズ極限の一致に十分でない」が、
必要十分版 `Ising3DCut.NecSuf.truncated_coordinate_data_not_sufficient` の
特殊化として得られることの導出。

座標を素数、座標の値を有理数の素指数、座標の値を潰す写像を `Int.sign`、
値を二つの正の実数 `2` と `4` として取る。

**この標的のために新しい必要十分版を書いていない。** 大きさによる切り詰めのために書いた
必要十分版が、座標の値を潰す写像 `t : V → W` を何も仮定せずに取っているため、
`t` を `Int.sign` に取り替えるだけでそのまま通る。すなわち、あちらの必要十分版の仮定は
「大きさで切り詰める」ことに依存していなかった。ここではそれを実際に確かめている
（必要十分版が過剰な仮定を持っていないことの検査になる）。

具体版の定理をここで呼び直すことはしない（それでは必要十分版の検査にならない）。
使うのは、具体版の証明が使っている算術の段（素指数の計算・正の実数乗根の一意性）だけである。
-/
import Ising3DCut.LimitQuantity.SignOfPrimeExponentsNotSufficient
import Ising3DCut.NecSuf.MagnitudeTruncationNotSufficient

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 具体版の反例が、必要十分版の特殊化として得られる。 -/
theorem sign_of_prime_exponents_is_not_sufficient_for_limit_quantity_fromNecSuf :
    ∃ (A B : ℕ → ℚ) (M : ℕ → ℕ) (ℓ ℓ' : ℝ),
      (∀ L, 0 < A L) ∧ (∀ L, 0 < B L) ∧ (∀ L, M L ≠ 0) ∧
      (∀ L, ∀ p : ℕ, p.Prime →
        Int.sign (padicValRat p (A L)) = Int.sign (padicValRat p (B L))) ∧
      (∀ L, padicValRat 2 (A L) ≠ padicValRat 2 (B L)) ∧
      Tendsto (fun L => posRoot ((A L : ℝ)) (M L)) atTop (𝓝 ℓ) ∧
      Tendsto (fun L => posRoot ((B L : ℝ)) (M L)) atTop (𝓝 ℓ') ∧ ℓ ≠ ℓ' := by
  have hposAR : (0 : ℝ) < (2 : ℝ) := by norm_num
  have hposBR : (0 : ℝ) < (4 : ℝ) := by norm_num
  -- 必要十分版へ渡す三つの仮定（座標ごとの一致・ある座標での相違・二つの値の相違）。
  have hagree : ∀ p : {p : ℕ // p.Prime},
      Int.sign (padicValRat p.1 ((2 : ℚ))) = Int.sign (padicValRat p.1 ((4 : ℚ))) := by
    rintro ⟨p, hp⟩
    by_cases h2 : p = 2
    · subst h2
      rw [padicValRat_two_of_two, padicValRat_two_of_four]
      decide
    · rw [padicValRat_ne_two_of_two p hp h2, padicValRat_ne_two_of_four p hp h2]
  have hsep : padicValRat 2 ((2 : ℚ)) ≠ padicValRat 2 ((4 : ℚ)) := by
    rw [padicValRat_two_of_two, padicValRat_two_of_four]
    decide
  have hxy : (2 : ℝ) ≠ (4 : ℝ) := by norm_num
  obtain ⟨hagree', hsep', hlimA, hlimB, hne⟩ :=
    NecSuf.truncated_coordinate_data_not_sufficient
      (fun v : ℤ => Int.sign v)
      (fun p : {p : ℕ // p.Prime} => padicValRat p.1 ((2 : ℚ)))
      (fun p : {p : ℕ // p.Prime} => padicValRat p.1 ((4 : ℚ)))
      ⟨2, Nat.prime_two⟩ (2 : ℝ) (4 : ℝ) hagree hsep hxy
  -- 必要十分版が返した二つの定数列の収束を、具体版の乗根列の収束へ言い換える。
  have hfunA : (fun _ : ℕ => posRoot (((2 : ℚ) : ℝ)) 1) = fun _ : ℕ => (2 : ℝ) := by
    funext L
    have hcast : (((2 : ℚ)) : ℝ) = (2 : ℝ) := by push_cast; ring
    rw [hcast]
    exact (eq_posRoot_of_pow_eq (2 : ℝ) (2 : ℝ) hposAR hposAR 1 one_ne_zero
      (by norm_num)).symm
  have hfunB : (fun _ : ℕ => posRoot (((4 : ℚ) : ℝ)) 1) = fun _ : ℕ => (4 : ℝ) := by
    funext L
    have hcast : (((4 : ℚ)) : ℝ) = (4 : ℝ) := by push_cast; ring
    rw [hcast]
    exact (eq_posRoot_of_pow_eq (4 : ℝ) (4 : ℝ) hposBR hposBR 1 one_ne_zero
      (by norm_num)).symm
  refine ⟨fun _ => (2 : ℚ), fun _ => (4 : ℚ), fun _ => 1, (2 : ℝ), (4 : ℝ),
    fun _ => by norm_num, fun _ => by norm_num, fun _ => one_ne_zero, ?_, ?_, ?_, ?_, hne⟩
  · intro _ p hp
    exact hagree' ⟨p, hp⟩
  · intro _
    exact hsep'
  · rw [hfunA]
    exact hlimA
  · rw [hfunB]
    exact hlimB

end Ising3DCut.LimitQuantity
