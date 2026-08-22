/-
「セクター多項式の値の双対関係」の具体版。
人手証明と同じく、整数係数多項式を有理点で評価し、各偶部分グラフの項について
双対変換の等式、積の冪、冪の指数法則を順に適用して共通因子を括り出す。
住処は有限集合、Z[x]、Q であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.HighTemperatureSectorDecomposition
import Ising2DLambda.FisherZero.KwDualPreservesUnitInterval
import Ising2DLambda.FisherZero.LowTemperatureTrivialSectorExpression
import Ising2DLambda.FisherZero.Algebraicity
import Ising2DLambda.FisherZero.KwSelfDualQuadraticEquivalence
import Ising2DLambda.FisherZero.SelfDualPositiveRoot

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

@[simp] lemma qbarPolynomialEval_one (xi : Qbar) :
    qbarPolynomialEval xi 1 = 1 := by simp [qbarPolynomialEval]

@[simp] lemma qbarPolynomialEval_X (xi : Qbar) :
    qbarPolynomialEval xi Polynomial.X = xi := by simp [qbarPolynomialEval]

@[simp] lemma qbarPolynomialEval_add (xi : Qbar) (f g : Polynomial ℤ) :
    qbarPolynomialEval xi (f + g) = qbarPolynomialEval xi f + qbarPolynomialEval xi g := by
  exact map_add (Polynomial.eval₂RingHom (Int.castRingHom Qbar) xi) f g

@[simp] lemma qbarPolynomialEval_sub (xi : Qbar) (f g : Polynomial ℤ) :
    qbarPolynomialEval xi (f - g) = qbarPolynomialEval xi f - qbarPolynomialEval xi g := by
  exact map_sub (Polynomial.eval₂RingHom (Int.castRingHom Qbar) xi) f g

@[simp] lemma qbarPolynomialEval_mul (xi : Qbar) (f g : Polynomial ℤ) :
    qbarPolynomialEval xi (f * g) = qbarPolynomialEval xi f * qbarPolynomialEval xi g := by
  exact map_mul (Polynomial.eval₂RingHom (Int.castRingHom Qbar) xi) f g

@[simp] lemma qbarPolynomialEval_pow (xi : Qbar) (f : Polynomial ℤ) (n : ℕ) :
    qbarPolynomialEval xi (f ^ n) = qbarPolynomialEval xi f ^ n := by
  exact map_pow (Polynomial.eval₂RingHom (Int.castRingHom Qbar) xi) f n

@[simp] lemma qbarPolynomialEval_sum {α : Type*} (xi : Qbar) (S : Finset α)
    (f : α → Polynomial ℤ) :
    qbarPolynomialEval xi (∑ a ∈ S, f a) = ∑ a ∈ S, qbarPolynomialEval xi (f a) := by
  simp only [qbarPolynomialEval, map_sum]

/-- `claim_sector_value_duality_at_algebraic_point` の具体版。 -/
theorem sectorValueDualityAtAlgebraicPoint (L : ℕ) [NeZero L]
    (sector : Fin 2 × Fin 2) {xi : Qbar} (hDomain : 1 + xi ≠ 0) :
    qbarPolynomialEval xi (highTemperatureSectorPolynomial L sector) =
      (1 + xi) ^ (2 * L ^ 2) *
        qbarPolynomialEval (kwDualTransform xi) (sectorGeneratingPolynomial L sector) := by
  classical
  have hDual : (1 + xi) * kwDualTransform xi = 1 - xi := by
    calc
      (1 + xi) * kwDualTransform xi =
          (1 + xi) * ((1 - xi) * (1 + xi)⁻¹) := by rfl
      _ = (1 - xi) * ((1 + xi) * (1 + xi)⁻¹) := by ring
      _ = (1 - xi) * 1 := by rw [mul_inv_cancel₀ hDomain]
      _ = 1 - xi := by rw [mul_one]
  rw [highTemperatureSectorPolynomial, sectorGeneratingPolynomial]
  simp only [qbarPolynomialEval_sum, qbarPolynomialEval_mul, qbarPolynomialEval_pow,
    qbarPolynomialEval_add, qbarPolynomialEval_sub, qbarPolynomialEval_one,
    qbarPolynomialEval_X]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro A hA
  have hCard : A.card ≤ 2 * L ^ 2 := by
    calc
      A.card ≤ Fintype.card (Edge L) := Finset.card_le_univ A
      _ = 2 * L ^ 2 := card_edge L
  calc
    (1 + xi) ^ (2 * L ^ 2 - A.card) * (1 - xi) ^ A.card =
        (1 + xi) ^ (2 * L ^ 2 - A.card) *
          ((1 + xi) * kwDualTransform xi) ^ A.card := by rw [hDual]
    _ = (1 + xi) ^ (2 * L ^ 2 - A.card) *
          ((1 + xi) ^ A.card * kwDualTransform xi ^ A.card) := by rw [mul_pow]
    _ = (1 + xi) ^ (2 * L ^ 2) * kwDualTransform xi ^ A.card := by
      rw [← mul_assoc, ← pow_add, Nat.sub_add_cancel hCard]

/-- `claim_self_dual_point_low_high_sector_correspondence` の具体版。 -/
theorem selfDualPointLowHighSectorCorrespondence (L : ℕ) [NeZero L]
    (sector : Fin 2 × Fin 2) (s : Qbar) (hs : s * s = 2) :
    qbarPolynomialEval (-1 + s) (highTemperatureSectorPolynomial L sector) =
      (1 + (-1 + s)) ^ (2 * L ^ 2) *
        qbarPolynomialEval (-1 + s) (sectorGeneratingPolynomial L sector) := by
  have hsNe : s ≠ 0 := by
    intro hsZero
    rw [hsZero, zero_mul] at hs
    norm_num at hs
  have hDomain : 1 + (-1 + s) ≠ 0 := by simpa using hsNe
  have hQuadratic : (-1 + s) ^ 2 + 2 * (-1 + s) - 1 = 0 := by
    calc
      (-1 + s) ^ 2 + 2 * (-1 + s) - 1 = s * s - 2 := by ring
      _ = 2 - 2 := by rw [hs]
      _ = 0 := by ring
  have hSelfDual : kwDualTransform (-1 + s) = -1 + s :=
    (kwSelfDual_quadratic_equivalence hDomain).2 hQuadratic
  simpa [hSelfDual] using sectorValueDualityAtAlgebraicPoint L sector hDomain

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
