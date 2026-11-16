/-
「半格子ずれた四つのモード和は同じ積分へ収束する」（`claim_shifted_mode_riemann_sums`）の合成の段の必要十分版。
具体版 `Ising2DLambda.RealEscape.modeLogDensity_tendsto_of_realLogSum` と同じ手順で示す:
1. 最初の式鎖の一行目 `u_L = a_L • S_L`（具体版の `claim_dispersion_product_real_log_sum`、仮定 `hu`）、
2. 再添字付けと角表示 `S_L = T_L`（具体版の `modeSum_realizedDispersionLog_eq_sampleSum`、仮定 `hST`）、
3. 極限の書き換え `a_L • T_L → c • I`（具体版の `halfInvSq_sampleSum_tendsto`。手順は `scaled_tendsto_necSuf`）、
4. 十分大きい `L` で `u_L = a_L • T_L` なので `u_L → c • I`。

仮定は次だけである。
- 係数はモノイド `R`、値は位相空間 `M` で、`R` の作用が各定数倍について連続（`scaled_tendsto_necSuf` と同じ）。
  `M` の加法も順序も使わない（具体版は `R = M = ℝ`）。
- `hu`・`hST` は `L ≥ 1` でだけ要る（具体版で `L = 0` の和は添字の型が定まらない）。どちらかを外すと
  `u` と極限を知っている列 `a • T` とが結び付かない。
- `hab` は十分大きい `L` で `a_L = c * b_L`（具体版の `1/(2L²) = (1/(8π²))·h_L²`）、`hlim` は `b_L • T_L → I`
  （具体版の小区画の誤差評価）。
住処: 一般のモノイドと位相空間。実数体への脱出: 実数列の極限（具体版で）。
-/
import Ising2DLambda.NecSuf.RealEscape.ShiftedModeSumReindex

namespace Ising2DLambda.NecSuf.RealEscape

open Filter Topology

/-- 必要十分版: `u_L = a_L • S_L`、`S_L = T_L`（`L ≥ 1`）、`a_L = c * b_L`（十分大きい `L`）、
`b_L • T_L → I` から `u_L → c • I`。 -/
theorem tendsto_of_finiteSumEq_necSuf {R M : Type*} [Monoid R] [TopologicalSpace M] [MulAction R M]
    [ContinuousConstSMul R M] (u S T : ℕ → M) (a b : ℕ → R) (c : R) (I : M)
    (hu : ∀ L : ℕ, 1 ≤ L → u L = a L • S L) (hST : ∀ L : ℕ, 1 ≤ L → S L = T L)
    (hab : ∀ᶠ L in atTop, a L = c * b L) (hlim : Tendsto (fun L => b L • T L) atTop (𝓝 I)) :
    Tendsto u atTop (𝓝 (c • I)) := by
  -- 極限の書き換え
  have h := scaled_tendsto_necSuf a b c T I hab hlim
  refine h.congr' ?_
  filter_upwards [eventually_ge_atTop 1] with L hL
  symm
  calc u L
      -- 最初の式鎖の一行目
      = a L • S L := hu L hL
    -- 再添字付けと角表示
    _ = a L • T L := by rw [hST L hL]

end Ising2DLambda.NecSuf.RealEscape
