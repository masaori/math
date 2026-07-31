/-
# 必要十分版: 対角行列の指数関数

対応する人手証明のラベル: **`exp_of_diagonal_matrix`**
（具体版は `Ising2D/Part010/Claim003_ExpDiagonal.lean`）

## この主張に本質的に効いている構造は何か

人手証明は
「Step 1: 対角行列の冪は成分ごとの冪 → Step 2: 部分和も対角 → Step 3: 成分ごとに収束」
という 3 段で `exp(D)_{kk} = e^{d_k}`, `exp(D)_{kl} = 0 (k ≠ l)` を示している。
この 3 段に効いているのは次の 2 点だけである。

1. **`diagonal : (ι → ℂ) → Mat(ι, ℂ)` が連続な環準同型であること。**
   Step 1（冪を保つ）と Step 2（有限和を保つ・スカラー倍を保つ）は環準同型であること、
   Step 3（極限と交換する）は連続性そのものである。
2. **有限直積 `ι → ℂ` の指数関数が成分ごとであること。**
   これは各成分への射影 `Pi.evalRingHom` がやはり連続な環準同型であることから従う。

したがって「対角行列であること」も「行列であること」も本質ではなく、
効いているのは **連続な環準同型は指数関数と可換である**（`NormedSpace.map_exp`）という
一点に集約される。行列のサイズ・複素数であること・成分の具体形はどれも効いていない
（ℚ-代数構造をもつ完備ノルム環どうしであれば何でもよい）。

なお、この「連続な環準同型は `exp` と可換」自体は mathlib の `NormedSpace.map_exp`
としてすでにある。本ファイルはそれを本プロジェクトの語彙で言い直し、
具体版がそこからの特殊化で得られることを示すためのものである。

**注意（`exact-solution-of-2d-ising-model/README.md` 4 節の要件 3）**:
本ファイルは既製定理への丸投げであり、**要件を満たす必要十分版ではない**。
人手証明 `exp_of_diagonal_matrix` の Step 1〜3（冪・有限部分和・極限）を
自前でたどる形へ書き直すことが残作業である。
-/
import Mathlib.Analysis.Normed.Algebra.Exponential

namespace Ising2D.NecSuf

open NormedSpace

variable {𝔸 𝔹 : Type*} [NormedRing 𝔸] [NormedRing 𝔹] [NormedAlgebra ℚ 𝔸] [NormedAlgebra ℚ 𝔹]
  [CompleteSpace 𝔸] [Algebra ℚ 𝔹]

/-- **連続な環準同型は行列指数関数と可換である。**

人手証明 `exp_of_diagonal_matrix` の Step 1〜3（冪・有限部分和・極限）を
1 本にまとめたもの。 -/
theorem map_exp_of_continuous {F : Type*} [FunLike F 𝔸 𝔹] [RingHomClass F 𝔸 𝔹]
    (f : F) (hf : Continuous f) (x : 𝔸) : f (exp x) = exp (f x) :=
  NormedSpace.map_exp f hf x

end Ising2D.NecSuf
