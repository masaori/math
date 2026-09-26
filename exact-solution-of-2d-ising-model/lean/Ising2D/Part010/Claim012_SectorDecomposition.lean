/-
# 分配関数の偶奇セクター分解（形式化の記録。人手の本文からは退避済み）

対応する人手の主張は、本文から参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ
退避した次の主張である（`(−)` セクターを本文から外したため）。本ファイルは形式化の記録として残し、
ビルドは通し続ける。本文の主張の Lean は本ファイルに依存しない。

* もと `bridge_012_claim_partition_function_sector_decomposition`
  （ラベル `partition_function_sector_decomposition`）

原文の主張:

  `Z(K_1,K_2) = tr(P^{(+)} (V^{(+)})^{N_row}) + tr(P^{(-)} (V^{(-)})^{N_row})`,
  `V^{(±)} = (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}`

## 原文の Step との対応

* Step 1（`tr X = tr(P^{(+)}X) + tr(P^{(-)}X)`）→ `trace_eq_sector_sum`。
  `P^{(+)} + P^{(-)} = I`（`epsProj_add_epsProj_neg`）とトレースの線型性だけ。
  これを `partition_function_via_transfer_matrix`（`Part001/ClaimPartitionFunctionViaTransferMatrix.lean`）の
  `X = (V_1V_2)^{N_row}` に適用する段は `partition_function_sector_decomposition` の中。
* Step 2（各セクターで `V_1 → V_1^{(±)}`）→ `sector_replacement_pow`
  （`Part010/Claim011_SectorReplacement.lean`）。
* Step 3（対称形 `(B V_2 B)^n` の解消）→ `trace_epsProj_sym_pow`。
  代数的な核は必要十分版 `Ising2D.NecSuf.mul_pow_conj_left`
  （`B (B V B)^n = (B B V)^n B`、結合法則のみ）。トレース側で使うのは
  巡回性 `Matrix.trace_mul_comm` と `P^{(±)}` が `B` と可換であることだけ。
* Step 4（結論）→ `partition_function_sector_decomposition`。

`V_1, V_2` は `def_transfer_matrix` の転送行列（`Ising2D.V1`, `Ising2D.V2`）である。

## 格子幅について

人手本文が Step 2 で使う `sector_replacement_of_V1` は、`M ≥ 2` の下で形式化済みの
`V1_restrictsOnEvenSector` と `V1_restrictsOnOddSector` から得られる。
以下ではこの格子幅条件を下流へ渡し、`RestrictsOnSector` を仮定として受け取らない。
-/
import Ising2D.Part010.Claim011_SectorReplacement
import Ising2D.Part001.ClaimPartitionFunctionViaTransferMatrix

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- ノートの `partition_function_sector_decomposition` の
`V^{(±)} := (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}`（`ηsign` が `∓1`、`V_2` は `def_transfer_matrix` の `V_2`）。 -/
noncomputable def Vsym (M : ℕ) (K1 : ℝ) (ηsign : ℂ) (K2 : ℝ) : TensorPow M :=
  V1pmHalf M K1 ηsign * V2 M K2 * V1pmHalf M K1 ηsign

/-- `ηsign = -1` の `Vsym` は本文 `def_V_plus` の `V^{(+)}`（`Ising2D.VPlusOfTransfer`）。 -/
theorem Vsym_neg_one_eq_VPlusOfTransfer (K1 K2 : ℝ) :
    Vsym M K1 (-1) K2 = VPlusOfTransfer M K1 K2 := rfl

/-- **原文 Step 1**: `tr X = tr(P^{(+)}X) + tr(P^{(-)}X)`。 -/
theorem trace_eq_sector_sum (η : ℂ) (X : TensorPow M) :
    X.trace = (epsProj M η * X).trace + (epsProj M (-η) * X).trace := by
  rw [← Matrix.trace_add, ← Matrix.add_mul, epsProj_add_epsProj_neg, Matrix.one_mul]

/-- **原文 Step 3**: 対称形 `(B V_2 B)^n` は、トレースの中で `(V_1^{(±)} V_2)^n` に直せる。 -/
theorem trace_epsProj_sym_pow {K1 K2 : ℝ} {ηsign η : ℂ} (n : ℕ) :
    (epsProj M η * (Vsym M K1 ηsign K2) ^ n).trace
      = (epsProj M η * (V1pm M K1 ηsign * V2 M K2) ^ n).trace := by
  set B : TensorPow M := V1pmHalf M K1 ηsign with hB
  set Bi : TensorPow M :=
    (((V1pmHalfUnits M K1 ηsign)⁻¹ : (TensorPow M)ˣ) : TensorPow M) with hBi
  have hBBi : B * Bi = 1 := (V1pmHalfUnits M K1 ηsign).mul_inv
  have hBiB : Bi * B = 1 := (V1pmHalfUnits M K1 ηsign).inv_mul
  have hPB : epsProj M η * B = B * epsProj M η :=
    (commute_V1pmHalf_epsProj K1 ηsign η).symm.eq
  have key : B * (B * V2 M K2 * B) ^ n
      = (V1pm M K1 ηsign * V2 M K2) ^ n * B := by
    rw [NecSuf.mul_pow_conj_left, hB, V1pmHalf_sq]
  calc (epsProj M η * (Vsym M K1 ηsign K2) ^ n).trace
      = (Bi * (B * (epsProj M η * (B * V2 M K2 * B) ^ n))).trace := by
        rw [← mul_assoc, hBiB, one_mul, Vsym]
    _ = ((B * (epsProj M η * (B * V2 M K2 * B) ^ n)) * Bi).trace :=
        Matrix.trace_mul_comm _ _
    _ = ((epsProj M η * (B * (B * V2 M K2 * B) ^ n)) * Bi).trace := by
        simp only [← mul_assoc]
        rw [← hPB]
    _ = ((epsProj M η * ((V1pm M K1 ηsign * V2 M K2) ^ n * B)) * Bi).trace := by
        rw [key]
    _ = (epsProj M η * (V1pm M K1 ηsign * V2 M K2) ^ n).trace := by
        rw [mul_assoc (epsProj M η), mul_assoc, hBBi, mul_one]

/-- 1 つのセクターぶんの等式（Step 2 と Step 3 を合わせたもの）。 -/
theorem trace_epsProj_sym_pow_eq_plain {K1 K2 : ℝ} {η : ℂ}
    (hM : 2 ≤ M) (hK2 : 0 < K2) (hη : η * η = 1) (n : ℕ) :
    (epsProj M η * (Vsym M K1 (-η) K2) ^ n).trace
      = (epsProj M η * (V1 M K1 * V2 M K2) ^ n).trace := by
  rw [trace_epsProj_sym_pow]
  have hcomm1 : epsProj M η * (V1 M K1 * V2 M K2) ^ n
      = (V1 M K1 * V2 M K2) ^ n * epsProj M η :=
    (((commute_V1_epsProj K1 η).mul_left
      (commute_V2_epsProj hK2 η)).pow_left n).symm.eq
  have hcomm2 : epsProj M η * (V1pm M K1 (-η) * V2 M K2) ^ n
      = (V1pm M K1 (-η) * V2 M K2) ^ n * epsProj M η := by
    exact (((commute_V1pm_epsProj K1 (-η) η).mul_left
      (commute_V2_epsProj hK2 η)).pow_left n).symm.eq
  rw [hcomm2, hcomm1, sector_replacement_pow hM hK2 hη n]

/-- **ノートへ退避した `partition_function_sector_decomposition`。**

`P^{(+)}` は `epsProj M 1`、`P^{(-)}` は `epsProj M (-1)`。
Lean の `V1pm M K1 η` は原文の `V_1^{(∓)}`（`η` が原文の `∓1`）なので、
セクター `P^{(±)}` に対応する `V^{(±)}` は `Vsym M K1 (∓1) K2`、すなわち `Vsym M K1 (-η) K2` である。
人手の `N_row ≥ 1`, `K_2 > 0`（`def_transfer_matrix` の設定）と `M_col ≥ 2`
（`sector_replacement_of_V1` が使う `V_1` の固有空間への制限の設定）を仮定に置く。 -/
theorem partition_function_sector_decomposition {K1 K2 : ℝ} (hM : 2 ≤ M) (hK2 : 0 < K2)
    {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    ((partitionFunction Nrow M K1 K2 : ℝ) : ℂ)
      = (epsProj M 1 * (Vsym M K1 (-1) K2) ^ Nrow).trace
        + (epsProj M (-1) * (Vsym M K1 1 K2) ^ Nrow).trace := by
  have h1 : (1 : ℂ) * 1 = 1 := by norm_num
  have h2 : (-1 : ℂ) * (-1) = 1 := by norm_num
  have hplus := trace_epsProj_sym_pow_eq_plain (M := M) (K1 := K1) (K2 := K2)
    (η := (1 : ℂ)) hM hK2 h1 Nrow
  have hminus := trace_epsProj_sym_pow_eq_plain (M := M) (K1 := K1) (K2 := K2)
    (η := (-1 : ℂ)) hM hK2 h2 Nrow
  simp only [neg_neg] at hminus
  rw [hplus, hminus, partition_function_via_transfer_matrix K1 K2 hN]
  exact trace_eq_sector_sum (M := M) 1 ((V1 M K1 * V2 M K2) ^ Nrow)

end Ising2D
