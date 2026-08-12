/-
「偶部分グラフは四つの巻き付きセクターへ一意に分かれる」の具体版。
人手証明と同じく、二つの周期境界を横切る辺の個数を 2 で割った余りを組にし、
その組が存在して一意であることを定義から示す。住処は有限集合と ℕ である。
-/
import Ising2DLambda.FisherZero.EvenSubgraphSpinSum
import Ising2DLambda.TransferMatrix.Basic

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 横向きの周期境界を横切る辺が `A` に入る本数の偶奇。 -/
def horizontalWindingParity (L : ℕ) [NeZero L] (A : Finset (Edge L)) : Fin 2 :=
  ⟨(A.filter fun e => e.val < L ^ 2 ∧ edgeColumn L e + 1 = L).card % 2,
    Nat.mod_lt _ (by norm_num)⟩

/-- 縦向きの周期境界を横切る辺が `A` に入る本数の偶奇。 -/
def verticalWindingParity (L : ℕ) [NeZero L] (A : Finset (Edge L)) : Fin 2 :=
  ⟨(A.filter fun e => ¬ e.val < L ^ 2 ∧ edgeRow L e + 1 = L).card % 2,
    Nat.mod_lt _ (by norm_num)⟩

/-- 二つの巻き付き偶奇が与える四つのセクターの添字。 -/
def torusHomologySector (L : ℕ) [NeZero L] (A : Finset (Edge L)) : Fin 2 × Fin 2 :=
  (horizontalWindingParity L A, verticalWindingParity L A)

/-- 偶部分グラフ `A` が、二つの巻き付き偶奇 `sector` のセクターに属すること。 -/
def IsInTorusHomologySector (L : ℕ) [NeZero L] (A : Finset (Edge L))
    (sector : Fin 2 × Fin 2) : Prop :=
  IsEvenEdgeSubset L A ∧ torusHomologySector L A = sector

/-- `claim_torus_homology_sector_partition` の具体版。 -/
theorem torusHomologySector_unique (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hEven : IsEvenEdgeSubset L A) :
    ∃! sector : Fin 2 × Fin 2, IsInTorusHomologySector L A sector := by
  refine ⟨torusHomologySector L A, ⟨hEven, rfl⟩, ?_⟩
  intro sector hsector
  exact hsector.2.symm

end Ising2DLambda.FisherZero
