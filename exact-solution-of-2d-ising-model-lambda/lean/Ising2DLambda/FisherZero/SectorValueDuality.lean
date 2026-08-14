/-
「セクター多項式の値の双対関係」の具体版。
人手証明と同じく、整数係数多項式を有理点で評価し、各偶部分グラフの項について
双対変換の等式、積の冪、冪の指数法則を順に適用して共通因子を括り出す。
住処は有限集合、Z[x]、Q であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.HighTemperatureSectorDecomposition
import Ising2DLambda.FisherZero.KwDualPreservesUnitInterval
import Ising2DLambda.FisherZero.LowTemperatureTrivialSectorExpression

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- 整数係数多項式を有理点で評価した値。 -/
noncomputable def intPolynomialEval (q : ℚ) (f : Polynomial ℤ) : ℚ :=
  Polynomial.eval₂RingHom (Int.castRingHom ℚ) q f

@[simp] lemma intPolynomialEval_one (q : ℚ) :
    intPolynomialEval q 1 = 1 := by simp [intPolynomialEval]

@[simp] lemma intPolynomialEval_X (q : ℚ) :
    intPolynomialEval q Polynomial.X = q := by simp [intPolynomialEval]

@[simp] lemma intPolynomialEval_add (q : ℚ) (f g : Polynomial ℤ) :
    intPolynomialEval q (f + g) = intPolynomialEval q f + intPolynomialEval q g := by
  exact map_add (Polynomial.eval₂RingHom (Int.castRingHom ℚ) q) f g

@[simp] lemma intPolynomialEval_sub (q : ℚ) (f g : Polynomial ℤ) :
    intPolynomialEval q (f - g) = intPolynomialEval q f - intPolynomialEval q g := by
  exact map_sub (Polynomial.eval₂RingHom (Int.castRingHom ℚ) q) f g

@[simp] lemma intPolynomialEval_mul (q : ℚ) (f g : Polynomial ℤ) :
    intPolynomialEval q (f * g) = intPolynomialEval q f * intPolynomialEval q g := by
  exact map_mul (Polynomial.eval₂RingHom (Int.castRingHom ℚ) q) f g

@[simp] lemma intPolynomialEval_pow (q : ℚ) (f : Polynomial ℤ) (n : ℕ) :
    intPolynomialEval q (f ^ n) = intPolynomialEval q f ^ n := by
  exact map_pow (Polynomial.eval₂RingHom (Int.castRingHom ℚ) q) f n

@[simp] lemma intPolynomialEval_sum {α : Type*} (q : ℚ) (S : Finset α)
    (f : α → Polynomial ℤ) :
    intPolynomialEval q (∑ a ∈ S, f a) = ∑ a ∈ S, intPolynomialEval q (f a) := by
  simp only [intPolynomialEval, map_sum]

/-- `claim_sector_value_duality` の具体版。 -/
theorem sectorValueDuality (L : ℕ) [NeZero L] (sector : Fin 2 × Fin 2)
    {q : ℚ} (hq : q ∈ unitIntervalRationals) :
    intPolynomialEval q (highTemperatureSectorPolynomial L sector) =
      (1 + q) ^ (2 * L ^ 2) *
        intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L sector) := by
  classical
  rcases hq with ⟨hqPositive, hqLtOne⟩
  have hOnePlusPositive : 0 < 1 + q := by linarith
  have hOnePlusNe : 1 + q ≠ 0 := ne_of_gt hOnePlusPositive
  have hDual : (1 + q) * kwDualRational q = 1 - q := by
    calc
      (1 + q) * kwDualRational q =
          (1 + q) * ((1 - q) * (1 + q)⁻¹) := by
        rw [kwDualRational]
      _ = (1 - q) * ((1 + q) * (1 + q)⁻¹) := by ring
      _ = (1 - q) * 1 := by rw [mul_inv_cancel₀ hOnePlusNe]
      _ = 1 - q := by rw [mul_one]
  rw [highTemperatureSectorPolynomial, sectorGeneratingPolynomial]
  simp only [intPolynomialEval_sum, intPolynomialEval_mul, intPolynomialEval_pow,
    intPolynomialEval_add, intPolynomialEval_sub, intPolynomialEval_one,
    intPolynomialEval_X]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro A hA
  have hCard : A.card ≤ 2 * L ^ 2 := by
    calc
      A.card ≤ Fintype.card (Edge L) := Finset.card_le_univ A
      _ = 2 * L ^ 2 := card_edge L
  calc
    (1 + q) ^ (2 * L ^ 2 - A.card) * (1 - q) ^ A.card =
        (1 + q) ^ (2 * L ^ 2 - A.card) *
          ((1 + q) * kwDualRational q) ^ A.card := by rw [hDual]
    _ = (1 + q) ^ (2 * L ^ 2 - A.card) *
          ((1 + q) ^ A.card * kwDualRational q ^ A.card) := by rw [mul_pow]
    _ = (1 + q) ^ (2 * L ^ 2) * kwDualRational q ^ A.card := by
      rw [← mul_assoc, ← pow_add, Nat.sub_add_cancel hCard]

end Ising2DLambda.FisherZero
