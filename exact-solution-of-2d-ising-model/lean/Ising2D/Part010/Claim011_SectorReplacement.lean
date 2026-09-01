/-
# セクター上での `V_1` の置き換え

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_011_claim_sector_replacement`（ラベル **`sector_replacement_of_V1`**）
* `bridge_011a_claim_sector_replacement_pow`（ラベル **`sector_replacement_pow`**）

人手本文の二つの主張（複号同順）は、`sector_replacement_of_V1` の
`V_1 P^{(±)} = V_1^{(±)} P^{(±)}` と、`sector_replacement_pow` の
`(V_1V_2)^n P^{(±)} = (V_1^{(±)}V_2)^n P^{(±)}` である。

## `sector_replacement_of_V1` の根拠にしている命題は未形式化である

人手本文は `sector_replacement_of_V1` を **004 章の `V1_restriction_to_eigenspaces`**
（`structured-latex/content/004_transfer_matrix.ts` の
`transfer_matrix_006_claim_V1_restriction_to_eigenspaces`）から導いている。
この命題は本リポジトリの Lean 側にまだ無い（004 章の形式化は
`def_transfer_matrix_symbols` 系の定義と `V_1^{(±)}` の定義までで、
固有空間への制限は未形式化）。

そこで本ファイルでは、その主張を**仮定として明示的に受け取る**形にした
（`hres`）。仮定の内容は原文の主張そのもの
「`ε f = ±f` なる `f` については `V_1 f = V_1^{(±)} f`」である。
`sector_replacement_pow` は `sector_replacement_of_V1` から純代数的に従い、そこは無条件に証明してある
（必要十分版 `Ising2D.NecSuf.pow_mul_proj`）。

## 必要十分版

`Ising2D/NecSuf/Projector.lean`（人手本文のラベル `sector_replacement_pow` に対応）。
冪の置き換えに効いているのは「`P` が冪等」「`P` が `V_1, V_2, V_1^{(±)}` と可換」
「`V_1 P = V_1^{(±)} P`」の 3 点だけで、`P` が射影子の形をしていることすら
使わないことを確認した。
-/
import Ising2D.Part010.Claim010_EpsilonCommutes

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 原文 004 章 `V1_restriction_to_eigenspaces` の主張（Lean 未形式化のため仮定として置く）:
`ε` の固有値 `η` の固有ベクトルの上では `V_1` と `V_1^{(η)}` の作用が一致する。 -/
def RestrictsOnSector (M : ℕ) (K1 ηsign η : ℂ) : Prop :=
  ∀ f : Conf M → ℂ, epsilon M *ᵥ f = η • f →
    V1pauli M K1 *ᵥ f = V1 M K1 ηsign *ᵥ f

/-- **人手本文 `sector_replacement_of_V1`: `V_1 P^{(±)} = V_1^{(±)} P^{(±)}`。** -/
theorem sector_replacement_of_V1 {K1 ηsign η : ℂ} (hη : η * η = 1)
    (hres : RestrictsOnSector M K1 ηsign η) :
    V1pauli M K1 * epsProj M η = V1 M K1 ηsign * epsProj M η := by
  refine Matrix.ext_of_mulVec_single fun i => ?_
  rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec]
  exact hres _ (epsProj_mulVec_mem hη _)

/-- **人手本文 `sector_replacement_pow`: `(V_1V_2)^n P^{(±)} = (V_1^{(±)}V_2)^n P^{(±)}`**
（必要十分版 `Ising2D.NecSuf.pow_mul_proj` の系）。 -/
theorem sector_replacement_pow {K1 ηsign η : ℂ} {s2 : ℝ} {K2star : ℂ} (hη : η * η = 1)
    (hres : RestrictsOnSector M K1 ηsign η) (n : ℕ) :
    (V1pauli M K1 * V2pauli M s2 K2star) ^ n * epsProj M η
      = (V1 M K1 ηsign * V2pauli M s2 K2star) ^ n * epsProj M η :=
  NecSuf.pow_mul_proj (epsProj_sq hη) (commute_V1pauli_epsProj K1 η)
    (commute_V2pauli_epsProj s2 K2star η) (commute_V1_epsProj K1 ηsign η)
    (sector_replacement_of_V1 hη hres) n

end Ising2D
