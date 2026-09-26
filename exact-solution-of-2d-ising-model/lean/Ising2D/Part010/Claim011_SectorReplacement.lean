/-
# セクター上での `V_1` の置き換え（形式化の記録。人手の本文からは退避済み）

対応する人手の主張は、本文から参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ
退避した次の二つである（`(−)` セクターを本文から外したため）。

* もと `bridge_011_claim_sector_replacement`（ラベル `sector_replacement_of_V1`）
* もと `bridge_011a_claim_sector_replacement_pow`（ラベル `sector_replacement_pow`）

主張（複号同順）は `V_1 P^{(±)} = V_1^{(±)} P^{(±)}` と
`(V_1V_2)^n P^{(±)} = (V_1^{(±)}V_2)^n P^{(±)}` である。本ファイルはその形式化の記録として残し、
ビルドは通し続ける。本文の主張の Lean は本ファイルに依存しない。

## `sector_replacement_of_V1` の根拠となる命題

ノートの証明は 004 章の `V_1` の固有空間への制限から導いている。その一般形の補題
（`V1_mulVec_eq_V1pm` ほか）は `Part004/ClaimV1RestrictionToEigenspaces.lean` にあり、
本文の `(+)` だけの主張 `V1_restriction_to_eigenspaces` も同じファイルにある。
`V1_restrictsOnSector_of_opposite_sign` は一般形の補題からセクターごとの制限を導く。Lean の符号引数では
`ηsign = -η` であり、偶セクターは `(η, ηsign) = (1, -1)`、奇セクターは `(-1, 1)` である。

`sector_replacement_pow` は `sector_replacement_of_V1` から純代数的に従う
（必要十分版 `Ising2D.NecSuf.pow_mul_proj`、`Ising2D/NecSuf/Projector.lean`）。
冪の置き換えに効いているのは「`P` が冪等」「`P` が `V_1, V_2, V_1^{(±)}` と可換」
「`V_1 P = V_1^{(±)} P`」の 3 点だけで、`P` が射影子の形をしていることすら使わない。
-/
import Ising2D.Part004.ClaimV1RestrictionToEigenspaces
import Ising2D.Part004.ClaimV2InZY

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 符号つきのセクターごとの制限:
`ε` の固有値 `η` の固有ベクトルの上では `V_1`（`def_transfer_matrix` の `V_1`）と
`V_1^{(η)}` の作用が一致する。 -/
def RestrictsOnSector (M : ℕ) (K1 : ℝ) (ηsign η : ℂ) : Prop :=
  ∀ f : Conf M → ℂ, epsilon M *ᵥ f = η • f →
    V1 M K1 *ᵥ f = V1pm M K1 ηsign *ᵥ f

/-- `M ≥ 2` と `η² = 1` の下で、`ηsign = -η` の符号対応が
セクターごとの制限を与える。 -/
theorem V1_restrictsOnSector_of_opposite_sign {K1 : ℝ} {η : ℂ} (hM : 2 ≤ M)
    (_hη : η * η = 1) : RestrictsOnSector M K1 (-η) η := by
  intro f hf
  exact V1_mulVec_eq_V1pm hM rfl hf

/-- 偶セクター `η = 1` では、境界符号は `ηsign = -1`。 -/
theorem V1_restrictsOnEvenSector (hM : 2 ≤ M) (K1 : ℝ) :
    RestrictsOnSector M K1 (-1) 1 := by
  simpa using V1_restrictsOnSector_of_opposite_sign (M := M) (K1 := K1) (η := (1 : ℂ))
    hM (by norm_num)

/-- 奇セクター `η = -1` では、境界符号は `ηsign = 1`。 -/
theorem V1_restrictsOnOddSector (hM : 2 ≤ M) (K1 : ℝ) :
    RestrictsOnSector M K1 1 (-1) := by
  simpa using V1_restrictsOnSector_of_opposite_sign (M := M) (K1 := K1) (η := (-1 : ℂ))
    hM (by norm_num)

/-- **ノートへ退避した `sector_replacement_of_V1`: `V_1 P^{(±)} = V_1^{(±)} P^{(±)}`。** -/
theorem sector_replacement_of_V1 {K1 : ℝ} {η : ℂ} (hM : 2 ≤ M) (hη : η * η = 1) :
    V1 M K1 * epsProj M η = V1pm M K1 (-η) * epsProj M η := by
  refine Matrix.ext_of_mulVec_single fun i => ?_
  rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec]
  exact V1_restrictsOnSector_of_opposite_sign hM hη _ (epsProj_mulVec_mem hη _)

/-- **ノートへ退避した `sector_replacement_pow`: `(V_1V_2)^n P^{(±)} = (V_1^{(±)}V_2)^n P^{(±)}`**
（`V_1, V_2` は `def_transfer_matrix` の転送行列。必要十分版 `Ising2D.NecSuf.pow_mul_proj` の系）。 -/
theorem sector_replacement_pow {K1 K2 : ℝ} {η : ℂ} (hM : 2 ≤ M) (hK2 : 0 < K2)
    (hη : η * η = 1) (n : ℕ) :
    (V1 M K1 * V2 M K2) ^ n * epsProj M η
      = (V1pm M K1 (-η) * V2 M K2) ^ n * epsProj M η :=
  NecSuf.pow_mul_proj (epsProj_sq hη) (commute_V1_epsProj K1 η)
    (commute_V2_epsProj hK2 η) (commute_V1pm_epsProj K1 (-η) η)
    (sector_replacement_of_V1 hM hη) n

end Ising2D
