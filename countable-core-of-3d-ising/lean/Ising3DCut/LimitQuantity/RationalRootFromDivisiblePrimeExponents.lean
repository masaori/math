/-
人手証明の主張「冪等式が末尾で成り立つことは、分配多項式の値が一つの正の有理数の点数乗である
ことに同値である」（ラベル `claim_power_identity_iff_rational_power_form`）の具体版の後半で、
復元した有限積を「点数乗の底」として取り出す段。

このファイルが担うのは人手証明の次の一段である。

  正の有理数 a のすべての素指数が正整数 n で割り切れるなら、
  a = c^n を満たす正の有理数 c が存在する。

構成は人手証明と 1 対 1 に対応する。非零素指数が収まる有限素数集合 S を取り、
各素数での素指数を n で割った整数を指数とする有限積 c := ∏_{p∈S} p^{(v_p a)/n} を作り、
c^n と a の素指数が全素数で一致することから、正の有理数が素指数データで一意に決まる
ことを使って等式を結ぶ。現れるのは ℚ と ℤ の等式だけであり、正の実数乗根も
箱の大きさの極限も現れない。
-/
import Ising3DCut.LimitQuantity.PowerIdentityIffRationalPowerForm

namespace Ising3DCut.LimitQuantity

/-- 正の有理数のすべての素指数が正整数 `n` で割り切れるなら、その有理数は正の有理数の
`n` 乗として書ける。 -/
theorem rat_pow_of_prime_exponents_dvd {a : ℚ} (ha : 0 < a) {n : ℕ} (hn : 0 < n)
    (hdvd : ∀ p : ℕ, p.Prime → ((n : ℤ) ∣ padicValRat p a)) :
    ∃ c : ℚ, 0 < c ∧ c ^ n = a := by
  classical
  obtain ⟨S, hS⟩ := finite_prime_support_of_rat a
  -- 素数だけに絞った有限集合を使う（有限積の各因子が正の素数の整数冪であるため）
  set S' : Finset ℕ := S.filter Nat.Prime with hS'def
  have hS'prime : ∀ p ∈ S', Nat.Prime p := by
    intro p hp
    exact (Finset.mem_filter.mp hp).2
  have hOutside : ∀ p : ℕ, p.Prime → p ∉ S' → padicValRat p a = 0 := by
    intro p hp hpS'
    have : p ∉ S := by
      intro hmem
      exact hpS' (Finset.mem_filter.mpr ⟨hmem, hp⟩)
    exact hS p hp this
  refine ⟨primePowerProduct S' (fun p => padicValRat p a / (n : ℤ)), ?_, ?_⟩
  · exact primePowerProduct_pos _ hS'prime
  · -- 素指数が全素数で一致することから等式を結ぶ
    have hcpos : 0 < primePowerProduct S' (fun p => padicValRat p a / (n : ℤ)) :=
      primePowerProduct_pos _ hS'prime
    apply rat_eq_of_prime_exponents_eq (pow_pos hcpos n) ha
    intro p hp
    letI : Fact (Nat.Prime p) := ⟨hp⟩
    rw [padicValRat.pow _, padicValRat_primePowerProduct _ hS'prime p hp]
    by_cases hpS' : p ∈ S'
    · simp only [hpS', if_true]
      exact Int.mul_ediv_cancel' (hdvd p hp)
    · simp [hpS', hOutside p hp hpS']

end Ising3DCut.LimitQuantity
