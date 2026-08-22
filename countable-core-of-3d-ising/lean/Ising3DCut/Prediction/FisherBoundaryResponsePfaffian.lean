/-
本文 `claim_two_dimensional_boundary_response_pfaffian_prediction` の証明の
「符号の括り出し」と「分母消去の有限恒等式」を束ねる段の Lean 具体版。

人手証明は次の順で進む。Kasteleyn 向き付けでは Pfaffian の有限展開に現れる
全完全マッチングの符号が一つの符号 `ε` に一致するので、符号なしの重み和 `D` は
`ε * Pf` に等しい（`ε * ε = 1` を使う）。これを、既に形式化してある分母消去の
有限恒等式へ代入すると、偶部分グラフ側の和が `ε * ((∏ (1 - x)) * Pf)` に等しくなる。

ここで形式化するのはその代入の段だけである。Kasteleyn 向き付けの存在
（符号がすべて一致すること）と、完全マッチングと偶部分グラフの全単射は、
それぞれ仮定 `hSign` と `hMatchingSum` として受け取る。
-/
import Ising3DCut.Prediction.FisherTerminalWeightSum
import Ising3DCut.Prediction.PfaffianConstantSign
import Mathlib.Tactic.Ring

namespace Ising3DCut.Prediction

open scoped BigOperators

/-- 符号が一つの `ε` に一致する Pfaffian 展開と、分母消去の有限恒等式を束ねると、
偶部分グラフ側の重み和が `ε * ((∏ (1 - x)) * Pf)` に等しくなる。 -/
theorem fisherBoundaryResponse_clearedPfaffian_eq_evenSubgraphSum
    {Edge ι K : Type*} [Field K] [DecidableEq Edge]
    (A : Finset Edge) (x : Edge → K)
    (hDenominator : ∀ edge ∈ A, 1 - x edge ≠ 0)
    (matchings : Finset ι) (matchingSign matchingWeight : ι → K) (ε : K)
    (hSign : ∀ matching ∈ matchings, matchingSign matching = ε) (hε : ε * ε = 1)
    (pfaffian : K)
    (hPfaffian : pfaffian = ∑ matching ∈ matchings,
      matchingSign matching * matchingWeight matching)
    (hMatchingSum : ∑ matching ∈ matchings, matchingWeight matching =
      ∑ S ∈ A.powerset, ∏ edge ∈ S, ((1 + x edge) / (1 - x edge))) :
    ∑ F ∈ A.powerset, (∏ edge ∈ F, (1 - x edge)) * ∏ edge ∈ A \ F, (1 + x edge) =
      ε * ((∏ edge ∈ A, (1 - x edge)) * pfaffian) := by
  -- 人手証明の「符号がすべて `ε` に一致するので Pf は符号なしの重み和の `ε` 倍」の段。
  have hPfaffianEq : pfaffian = ε * ∑ matching ∈ matchings, matchingWeight matching := by
    rw [hPfaffian]
    exact constantSign_finiteExpansion matchings matchingSign matchingWeight ε hSign
  calc
    ∑ F ∈ A.powerset, (∏ edge ∈ F, (1 - x edge)) * ∏ edge ∈ A \ F, (1 + x edge) =
        (∏ edge ∈ A, (1 - x edge)) *
          ∑ S ∈ A.powerset, ∏ edge ∈ S, ((1 + x edge) / (1 - x edge)) :=
      (fisherBoundaryResponse_clearedWeightSum_eq_evenSubgraphSum A x hDenominator).symm
    _ = (∏ edge ∈ A, (1 - x edge)) * ∑ matching ∈ matchings, matchingWeight matching := by
      rw [hMatchingSum]
    _ = (ε * ε) *
        ((∏ edge ∈ A, (1 - x edge)) * ∑ matching ∈ matchings, matchingWeight matching) := by
      rw [hε, one_mul]
    _ = ε * ((∏ edge ∈ A, (1 - x edge)) *
        (ε * ∑ matching ∈ matchings, matchingWeight matching)) := by
      ring
    _ = ε * ((∏ edge ∈ A, (1 - x edge)) * pfaffian) := by
      rw [hPfaffianEq]

end Ising3DCut.Prediction
