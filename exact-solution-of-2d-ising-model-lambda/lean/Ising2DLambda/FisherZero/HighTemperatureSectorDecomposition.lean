/-
「高温展開の多項式は四つのセクター多項式の和である」の具体版。
人手証明と同じく、偶部分グラフの全体を二つの巻き付き偶奇の値で分け、
その四つのファイバーごとに有限和を分割する。住処は有限集合と Z[x] である。
-/
import Ising2DLambda.FisherZero.HighTemperaturePolynomial
import Ising2DLambda.FisherZero.TorusHomologySector
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- セクター `sector` に属する偶部分グラフだけにわたる高温展開の多項式。 -/
noncomputable def highTemperatureSectorPolynomial (L : ℕ) [NeZero L]
    (sector : Fin 2 × Fin 2) : Polynomial ℤ := by
  classical
  exact ∑ A ∈ (univ : Finset (Finset (Edge L))).filter
      (fun A => IsInTorusHomologySector L A sector),
    ((1 : Polynomial ℤ) + Polynomial.X) ^ (2 * L ^ 2 - A.card) *
      ((1 : Polynomial ℤ) - Polynomial.X) ^ A.card

/-- 偶部分グラフの有限和は、四つの巻き付きセクターの和に等しい。 -/
theorem highTemperaturePolynomial_eq_sum_sectors (L : ℕ) [NeZero L] :
    highTemperaturePolynomial L =
      ∑ sector : Fin 2 × Fin 2, highTemperatureSectorPolynomial L sector := by
  classical
  let source := (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L)
  let weight := fun A : Finset (Edge L) =>
      ((1 : Polynomial ℤ) + Polynomial.X) ^ (2 * L ^ 2 - A.card) *
        ((1 : Polynomial ℤ) - Polynomial.X) ^ A.card
  -- 本文の有限和の分割: 各 A は、その巻き付き偶奇の組でだけ重みを寄与する。
  have hpartition :
      ∑ A ∈ source, weight A =
        ∑ sector : Fin 2 × Fin 2,
          ∑ A ∈ source.filter (fun A => torusHomologySector L A = sector), weight A := by
    calc
      ∑ A ∈ source, weight A =
          ∑ A ∈ source, ∑ sector : Fin 2 × Fin 2,
            if torusHomologySector L A = sector then weight A else 0 := by
        apply Finset.sum_congr rfl
        intro A _
        exact (Fintype.sum_ite_eq (torusHomologySector L A)
          (fun _ : Fin 2 × Fin 2 => weight A)).symm
      _ = ∑ sector : Fin 2 × Fin 2, ∑ A ∈ source,
            if torusHomologySector L A = sector then weight A else 0 :=
        Finset.sum_comm
      _ = ∑ sector : Fin 2 × Fin 2,
            ∑ A ∈ source.filter (fun A => torusHomologySector L A = sector), weight A := by
        apply Finset.sum_congr rfl
        intro sector _
        exact (Finset.sum_filter (s := source)
          (fun A => torusHomologySector L A = sector) weight).symm
  calc
    -- 本文の最初の等号: H_L の定義。
    highTemperaturePolynomial L = ∑ A ∈ source, weight A := rfl
    -- 二つ目の等号: 巻き付き偶奇の組による有限和の分割。
    _ = ∑ sector : Fin 2 × Fin 2,
          ∑ A ∈ source.filter (fun A => torusHomologySector L A = sector), weight A :=
      hpartition
    -- 三つ目の等号: セクターの所属条件。
    _ = ∑ sector : Fin 2 × Fin 2,
          ∑ A ∈ (univ : Finset (Finset (Edge L))).filter
            (fun A => IsInTorusHomologySector L A sector), weight A := by
      simp only [source, Finset.filter_filter, IsInTorusHomologySector]
    -- 四つ目の等号: H_L^{a,b} の定義。
    _ = ∑ sector : Fin 2 × Fin 2, highTemperatureSectorPolynomial L sector := rfl

/-- `claim_high_temperature_sector_decomposition` の具体版。 -/
theorem highTemperatureSectorDecomposition (L : ℕ) [NeZero L] :
    highTemperaturePolynomial L =
      highTemperatureSectorPolynomial L (0, 0) +
      highTemperatureSectorPolynomial L (0, 1) +
      highTemperatureSectorPolynomial L (1, 0) +
      highTemperatureSectorPolynomial L (1, 1) := by
  rw [highTemperaturePolynomial_eq_sum_sectors]
  -- 本文の最後の等号: 二つの偶奇をそれぞれ 0, 1 と列挙する。
  simp only [Fintype.sum_prod_type, Fin.sum_univ_two, add_assoc]

end Ising2DLambda.FisherZero
