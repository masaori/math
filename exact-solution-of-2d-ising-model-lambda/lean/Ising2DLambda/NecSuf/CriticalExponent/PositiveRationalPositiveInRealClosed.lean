/-
`claim_positive_rational_positive_in_real_closed` の必要十分版。

具体版が使う本質は次だけである。
  - 体の四則と逆元（分子・分母の比、零因子を持たないこと）。
  - 二つの平方の和が平方であること（帰納段の証人）。
  - 二つの平方の和が零なら各項が零であること（証人の非零性）。

実閉性・代数的数・平方の三分法・虚数単位・一意表示・有理数の分子分母表示は、
この論法自体には要らない。正の有理数は「1 以上の自然数の比 (m+1)/(n+1)」として受ける。
体の標数の仮定も要らない: 標数 p の体では sumEqZero が偽になるので、
仮定 sumEqZero 自身が標数零に相当する強さを担っている。
-/
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.CriticalExponent

/-- 帰納法: 1 以上の自然数は零元でない元の平方である。手順は具体版と同じ。 -/
theorem natSucc_eq_square_necSuf {K : Type*} [Field K]
    (sumIsSquare : ∀ a b : K, ∃ v : K, a * a + b * b = v * v)
    (sumEqZero : ∀ a b : K, a * a + b * b = 0 → a = 0 ∧ b = 0) :
    ∀ n : ℕ, ∃ c : K, c ≠ 0 ∧ ((n + 1 : ℕ) : K) = c * c := by
  intro n
  induction n with
  | zero => exact ⟨1, one_ne_zero, by norm_num⟩
  | succ n ih =>
      obtain ⟨c, hc0, hc⟩ := ih
      obtain ⟨e, he⟩ := sumIsSquare c 1
      have he0 : e ≠ 0 := by
        intro heZero
        have hsum : c * c + 1 * 1 = 0 := by rw [he, heZero]; ring
        exact one_ne_zero (sumEqZero c 1 hsum).2
      refine ⟨e, he0, ?_⟩
      rw [← he, ← hc]
      push_cast
      ring

/-- 1 以上の自然数の比は零元でない元の平方である。 -/
theorem positiveRational_positive_necSuf {K : Type*} [Field K]
    (sumIsSquare : ∀ a b : K, ∃ v : K, a * a + b * b = v * v)
    (sumEqZero : ∀ a b : K, a * a + b * b = 0 → a = 0 ∧ b = 0)
    (m n : ℕ) :
    ∃ z : K, z ≠ 0 ∧ ((m + 1 : ℕ) : K) / ((n + 1 : ℕ) : K) - 0 = z * z := by
  obtain ⟨c, hc0, hc⟩ := natSucc_eq_square_necSuf sumIsSquare sumEqZero m
  obtain ⟨d, hd0, hd⟩ := natSucc_eq_square_necSuf sumIsSquare sumEqZero n
  refine ⟨c * d⁻¹, mul_ne_zero hc0 (inv_ne_zero hd0), ?_⟩
  rw [hc, hd]
  field_simp
  ring

end Ising2DLambda.NecSuf.CriticalExponent
