/-
# 分配関数の偶奇セクター分解

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_012_claim_partition_function_sector_decomposition`
  （ラベル **`partition_function_sector_decomposition`**）

原文の主張:

  `Z(J,J') = tr(P^{(+)} (V^{(+)})^{N_row}) + tr(P^{(-)} (V^{(-)})^{N_row})`,
  `V^{(±)} = (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}`

## 原文の Step との対応

* Step 1（`tr X = tr(P^{(+)}X) + tr(P^{(-)}X)`）→ `trace_eq_sector_sum`。
  `P^{(+)} + P^{(-)} = I`（`epsProj_add_epsProj_neg`）とトレースの線型性だけ。
* Step 2（各セクターで `V_1 → V_1^{(±)}`）→ `sector_replacement_pow`
  （`Part010/Claim011_SectorReplacement.lean`）。
* Step 3（対称形 `(B V_2 B)^n` の解消）→ `trace_epsProj_sym_pow`。
  代数的な核は必要十分版 `Ising2D.NecSuf.mul_pow_conj_left`
  （`B (B V B)^n = (B B V)^n B`、結合法則のみ）。トレース側で使うのは
  巡回性 `Matrix.trace_mul_comm` と `P^{(±)}` が `B` と可換であることだけ。
* Step 4（結論）→ `partition_function_sector_decomposition`。

## 仮定について

人手本文が Step 2 で使う `sector_replacement_of_V1` は 004 章の
`V1_restriction_to_eigenspaces` に依存しており、それは Lean 未形式化である。
そのため本ファイルの最終定理も `RestrictsOnSector`（`Claim011` 参照）を仮定に持つ。
これは**未形式化に由来する仮定**であって、数学的な穴ではない。
-/
import Ising2D.Part010.Claim011_SectorReplacement
import Ising2D.Part010.Claim007_PartitionFunction

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 原文 `V_eq_Vprime` の `V^{(±)} = (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}`。 -/
noncomputable def Vsym (M : ℕ) (K1 ηsign : ℂ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  V1half M K1 ηsign * V2pauli M s2 K2star * V1half M K1 ηsign

/-- **原文 Step 1**: `tr X = tr(P^{(+)}X) + tr(P^{(-)}X)`。 -/
theorem trace_eq_sector_sum (η : ℂ) (X : TensorPow M) :
    X.trace = (epsProj M η * X).trace + (epsProj M (-η) * X).trace := by
  rw [← Matrix.trace_add, ← Matrix.add_mul, epsProj_add_epsProj_neg, Matrix.one_mul]

/-- **原文 Step 3**: 対称形 `(B V_2 B)^n` は、トレースの中で `(V_1^{(±)} V_2)^n` に直せる。 -/
theorem trace_epsProj_sym_pow {K1 ηsign η : ℂ} {s2 : ℝ} {K2star : ℂ} (n : ℕ) :
    (epsProj M η * (Vsym M K1 ηsign s2 K2star) ^ n).trace
      = (epsProj M η * (V1 M K1 ηsign * V2pauli M s2 K2star) ^ n).trace := by
  set B : TensorPow M := V1half M K1 ηsign with hB
  set Bi : TensorPow M :=
    (((V1halfUnits M K1 ηsign)⁻¹ : (TensorPow M)ˣ) : TensorPow M) with hBi
  have hBBi : B * Bi = 1 := (V1halfUnits M K1 ηsign).mul_inv
  have hBiB : Bi * B = 1 := (V1halfUnits M K1 ηsign).inv_mul
  have hPB : epsProj M η * B = B * epsProj M η :=
    (commute_V1half_epsProj K1 ηsign η).symm.eq
  have key : B * (B * V2pauli M s2 K2star * B) ^ n
      = (V1 M K1 ηsign * V2pauli M s2 K2star) ^ n * B := by
    rw [NecSuf.mul_pow_conj_left, hB, V1half_sq]
  calc (epsProj M η * (Vsym M K1 ηsign s2 K2star) ^ n).trace
      = (Bi * (B * (epsProj M η * (B * V2pauli M s2 K2star * B) ^ n))).trace := by
        rw [← mul_assoc, hBiB, one_mul, Vsym]
    _ = ((B * (epsProj M η * (B * V2pauli M s2 K2star * B) ^ n)) * Bi).trace :=
        Matrix.trace_mul_comm _ _
    _ = ((epsProj M η * (B * (B * V2pauli M s2 K2star * B) ^ n)) * Bi).trace := by
        simp only [← mul_assoc]
        rw [← hPB]
    _ = ((epsProj M η * ((V1 M K1 ηsign * V2pauli M s2 K2star) ^ n * B)) * Bi).trace := by
        rw [key]
    _ = (epsProj M η * (V1 M K1 ηsign * V2pauli M s2 K2star) ^ n).trace := by
        rw [mul_assoc (epsProj M η), mul_assoc, hBBi, mul_one]

/-- 1 つのセクターぶんの等式（Step 2 と Step 3 を合わせたもの）。 -/
theorem trace_epsProj_sym_pow_eq_plain {K1 ηsign η : ℂ} {s2 : ℝ} {K2star : ℂ}
    (hη : η * η = 1) (hres : RestrictsOnSector M K1 ηsign η) (n : ℕ) :
    (epsProj M η * (Vsym M K1 ηsign s2 K2star) ^ n).trace
      = (epsProj M η * (V1pauli M K1 * V2pauli M s2 K2star) ^ n).trace := by
  rw [trace_epsProj_sym_pow]
  have hcomm1 : epsProj M η * (V1pauli M K1 * V2pauli M s2 K2star) ^ n
      = (V1pauli M K1 * V2pauli M s2 K2star) ^ n * epsProj M η :=
    (((commute_V1pauli_epsProj K1 η).mul_left
      (commute_V2pauli_epsProj s2 K2star η)).pow_left n).symm.eq
  have hcomm2 : epsProj M η * (V1 M K1 ηsign * V2pauli M s2 K2star) ^ n
      = (V1 M K1 ηsign * V2pauli M s2 K2star) ^ n * epsProj M η := by
    exact (((commute_V1_epsProj K1 ηsign η).mul_left
      (commute_V2pauli_epsProj s2 K2star η)).pow_left n).symm.eq
  rw [hcomm2, hcomm1, sector_replacement_pow hη hres n]

/-- **原文 `partition_function_sector_decomposition`。**

`P^{(+)}` は `epsProj M 1`、`P^{(-)}` は `epsProj M (-1)`。
Lean の `V1 M K1 η` は原文の `V_1^{(∓)}`（`η` が原文の `∓1`）なので、
セクター `P^{(±)}` に対応する `V_1` は `V1 M K1 (∓1)`、すなわち `V1 M K1 (-η)` である。 -/
theorem partition_function_sector_decomposition {J J' : ℝ} (hJ : 0 < J) (m : ℕ)
    (hresPlus : RestrictsOnSector M (J' : ℂ) (-1) 1)
    (hresMinus : RestrictsOnSector M (J' : ℂ) 1 (-1)) :
    ((partitionFunction (m + 1) M J J' : ℝ) : ℂ)
      = (epsProj M 1 *
            (Vsym M (J' : ℂ) (-1) (Real.sinh (2 * J)) ((Kstar J : ℝ) : ℂ)) ^ (m + 1)).trace
        + (epsProj M (-1) *
            (Vsym M (J' : ℂ) 1 (Real.sinh (2 * J)) ((Kstar J : ℝ) : ℂ)) ^ (m + 1)).trace := by
  have h1 : (1 : ℂ) * 1 = 1 := by norm_num
  have h2 : (-1 : ℂ) * (-1) = 1 := by norm_num
  rw [trace_epsProj_sym_pow_eq_plain h1 hresPlus, trace_epsProj_sym_pow_eq_plain h2 hresMinus,
    partition_function_in_pauli_form hJ m]
  have := trace_eq_sector_sum (M := M) 1
    ((V1pauli M (J' : ℂ) * V2pauli M (Real.sinh (2 * J)) ((Kstar J : ℝ) : ℂ)) ^ (m + 1))
  rw [this]

end Ising2D
