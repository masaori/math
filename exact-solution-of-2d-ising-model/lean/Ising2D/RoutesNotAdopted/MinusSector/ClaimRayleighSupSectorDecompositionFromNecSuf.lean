/-
# 符号つきのセクターの上限 `c_±(M)` と `c(M) = max(c_+(M), c_-(M))`（必要十分版からの導出。形式化の記録）

具体版 `ClaimRayleighSupSectorDecomposition.lean` の `Ising2D.sectorSet`・`sectorRayleighSup`（退避した人手
`sector_decomposition_of_rayleigh_sup` の `𝓡_±`・`c_±(M)`）と、必要十分版
`Ising2D/NecSuf/SignedSectorRayleighSupDecomposition.lean` の `NecSuf.sectorSet'`・`sectorRayleighSup'` は、
同じ式で定義した同じ集合・同じ値である（ノルムと `c(M)` の一致は `vecNorm_eq_vecNorm_necSuf`・`rayleighSup_eq_rayleighSup_necSuf`）。
具体版の `sector_decomposition_of_rayleigh_sup` は、必要十分版 `NecSuf.sector_decomposition_of_rayleigh_sup'` を
この一致で読み替えたものである（下の `sector_decomposition_of_rayleigh_sup_of_necSuf`。具体版のファイルはこれを import せず、
自前の証明を持つ）。
-/
import Ising2D.RoutesNotAdopted.MinusSector.ClaimRayleighSupSectorDecomposition
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.DefinitionRayleighSupFromNecSuf
import Ising2D.NecSuf.SignedSectorRayleighSupDecomposition

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- 具体版の `𝓡_±` は、必要十分版の `𝓡_±` と一致する（同じ式の定義）。 -/
theorem sectorSet_eq_sectorSet_necSuf (W ε : Matrix n n ℝ) (s : ℝ) :
    sectorSet W ε s = NecSuf.sectorSet' W ε s :=
  rfl

/-- 具体版の `c_±(M) = sup 𝓡_±` は、必要十分版の `sup 𝓡_±` と一致する（同じ式の定義）。 -/
theorem sectorRayleighSup_eq_sectorRayleighSup_necSuf (W ε : Matrix n n ℝ) (s : ℝ) :
    sectorRayleighSup W ε s = NecSuf.sectorRayleighSup' W ε s :=
  rfl

/-- 具体版 `sector_decomposition_of_rayleigh_sup` は、必要十分版
`NecSuf.sector_decomposition_of_rayleigh_sup'` を上の一致で読み替えたもの。 -/
theorem sector_decomposition_of_rayleigh_sup_of_necSuf {W ε : Matrix n n ℝ}
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hε : ε.IsSymm) (hεε : ε * ε = 1)
    (hcomm : ε * W = W * ε) :
    rayleighSup W = max (sectorRayleighSup W ε 1) (sectorRayleighSup W ε (-1)) := by
  rw [rayleighSup_eq_rayleighSup_necSuf, sectorRayleighSup_eq_sectorRayleighSup_necSuf,
    sectorRayleighSup_eq_sectorRayleighSup_necSuf]
  exact NecSuf.sector_decomposition_of_rayleigh_sup' hpsd hε hεε hcomm

end Ising2D
