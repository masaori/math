/-
# `εW = Wε` と、`W` が `𝓕^{(+)}` を保つこと

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_010b_claim_epsilon_commutes_with_W`、ラベル **`epsilon_commutes_with_W`**）

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| `ε` は `V_1^{1/2} = exp(½K_1D)` と可換（`epsilon_commutes_with_transfer_matrices` の Step 3 と同じ議論） | `Ising2D.epsilon_commute_V1PauliForm`（結合定数 `K_1/2`） |
| `ε` は `V_2` と可換（同 Step 2） | `Ising2D.epsilon_commute_V2` |
| `εW = εBV_2B = BεV_2B = BV_2εB = BV_2Bε = Wε` | `epsilon_commute_physicalSymTransferC` |
| `ε(Wf) = (εW)f = (Wε)f = W(εf) = Wf` | `epsilonR_mulVec_physicalSymTransferR_of_mem` |

人手の `W` と `ε` は複素行列として議論されるが、章 011 の Rayleigh 商は実行列 `W`
（`physicalSymTransferR`）と実行列 `ε`（`epsilonR`）で述べる。そこで複素行列としての等式
`εW = Wε` を示してから、両辺が実行列の成分の埋め込みであること
（`epsilon_is_real_symmetric`、`physicalSymTransferC_eq_map`）と埋め込みの単射性で実行列の等式に移す
（`epsilon_commutes_with_W`）。この最後の段は人手に無い（人手は `ℝ ⊂ ℂ` の包含を明示せずに使う）。

必要十分版は置かない。可換性の鎖は結合律だけで、置き換えた構造は章 010 の
`epsilon_commutes_with_transfer_matrices`（Pauli 行列の具体的な反交換関係）が担う。
-/
import Ising2D.Part011.PhysicalSymTransferBridge
import Ising2D.Part011.ClaimEpsilonIsRealSymmetric

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 人手の等式鎖 `εW = Wε`（複素行列 `W = V_1^{1/2}V_2V_1^{1/2}`、`K_2 > 0`）。 -/
theorem epsilon_commute_physicalSymTransferC (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    Commute (epsilon M) (physicalSymTransferC M K1 K2) := by
  have hB : Commute (epsilon M) (physicalV1halfC M K1) := epsilon_commute_V1PauliForm _
  have hV : Commute (epsilon M) (V2 M K2) := epsilon_commute_V2 hK2
  rw [physicalSymTransferC]
  exact (hB.mul_right hV).mul_right hB

/-- **人手本文 `epsilon_commutes_with_W` の前半**: `εW = Wε`（実行列として）。 -/
theorem epsilon_commutes_with_W (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) :
    epsilonR M * physicalSymTransferR M K1 K2 = physicalSymTransferR M K1 K2 * epsilonR M := by
  apply Matrix.map_injective (f := Complex.ofRealHom) Complex.ofReal_injective
  have hε : (epsilonR M).map Complex.ofRealHom = epsilon M := epsilon_is_real_symmetric.1.symm
  have hW : (physicalSymTransferR M K1 K2).map Complex.ofRealHom
      = physicalSymTransferC M K1 K2 := (physicalSymTransferC_eq_map K1 K2).symm
  show (epsilonR M * physicalSymTransferR M K1 K2).map Complex.ofRealHom
      = (physicalSymTransferR M K1 K2 * epsilonR M).map Complex.ofRealHom
  rw [Matrix.map_mul, Matrix.map_mul, hε, hW]
  exact (epsilon_commute_physicalSymTransferC K1 hK2).eq

/-- **人手本文 `epsilon_commutes_with_W` の後半**: `W` は `𝓕^{(+)}` を保つ
（`f ∈ 𝓕^{(+)} ∩ ℝ^{2^M}`、すなわち `ε f = f` なら `ε(Wf) = Wf`）。 -/
theorem epsilonR_mulVec_physicalSymTransferR_of_mem (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2)
    {f : Conf M → ℝ} (hf : epsilonR M *ᵥ f = f) :
    epsilonR M *ᵥ (physicalSymTransferR M K1 K2 *ᵥ f) = physicalSymTransferR M K1 K2 *ᵥ f := by
  calc epsilonR M *ᵥ (physicalSymTransferR M K1 K2 *ᵥ f)
      = (epsilonR M * physicalSymTransferR M K1 K2) *ᵥ f := by rw [Matrix.mulVec_mulVec]
    _ = (physicalSymTransferR M K1 K2 * epsilonR M) *ᵥ f := by
        rw [epsilon_commutes_with_W K1 hK2]
    _ = physicalSymTransferR M K1 K2 *ᵥ (epsilonR M *ᵥ f) := by rw [Matrix.mulVec_mulVec]
    _ = physicalSymTransferR M K1 K2 *ᵥ f := by rw [hf]

end Ising2D
