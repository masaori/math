/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

`insertFamily_leftInverse` / `insertFamily_rightInverse` に
`ι := 𝒪_L の添字型`、`B := O ↦ 𝔅_O` を代入すると、具体版の 2 つの往復が得られる。

代入して分かるのは、この一歩が要求するのが**添字の相等が判定できること**と
**足す添字がもとの集合に属さないこと**だけであり、成分が全単射であることも、
添字が軌道であることも、順序 `≺` も一切使っていないことである。

さらに、**第 2 の等式は `O₀ ∉ s` すら要求しない**（必要十分版で仮定を削ったら通った）。
要るのは第 1 の等式の側だけである。

型の同一性について 1 つ断っておく。具体版の `OrbitPermFamilyOn s` と
必要十分版の `FamilyOn (fun O => OrbitBij O.1) s` は定義を展開すると同じ型であり
（どちらも `∀ O, O ∈ s → OrbitBij O.1`）、`ins` と `spl` も同じ定義である。
したがって導出は代入だけで済む。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFamilyInsert
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitFamilyInsert

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の第 1 の等式を、必要十分版から導いたもの。 -/
theorem orbitFamilyInsert_leftInverse_from_necSuf {s : Finset (OrbitIndex L)}
    {O₀ : OrbitIndex L} (hO₀ : O₀ ∉ s) (ψ : OrbitBij O₀.1) (α : OrbitPermFamilyOn s) :
    orbitSplitFamily O₀ (orbitInsertFamily O₀ ψ α) = (ψ, α) :=
  NecSuf.AlgebraicEigenvalue.insertFamily_leftInverse
    (B := fun O : OrbitIndex L => OrbitBij O.1) hO₀ ψ α

/-- 具体版の第 2 の等式を、必要十分版から導いたもの。 -/
theorem orbitFamilyInsert_rightInverse_from_necSuf {s : Finset (OrbitIndex L)}
    {O₀ : OrbitIndex L} (β : OrbitPermFamilyOn (insert O₀ s)) :
    orbitInsertFamily O₀ (orbitSplitFamily O₀ β).1 (orbitSplitFamily O₀ β).2 = β :=
  NecSuf.AlgebraicEigenvalue.insertFamily_rightInverse
    (B := fun O : OrbitIndex L => OrbitBij O.1) β

end Ising2DLambda.AlgebraicEigenvalue
