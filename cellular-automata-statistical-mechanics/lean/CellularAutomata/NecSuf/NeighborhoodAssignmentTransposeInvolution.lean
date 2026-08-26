/-
章「近傍割り当ての転置対合」の必要十分版。

具体版（CellularAutomata.NeighborhoodAssignmentTransposeInvolution）と同じ順序で、
転置の所属同値、対合性、合成順序の反転、点ごとの和・積と自己近傍割り当ての保存、
有限表と全単射を示す。

必要な構造の検査結果:
  - **転置そのものに要る構造は何も無い。** 値を `Set` で表せば、転置
    `Nᵀ(w) = {v | w ∈ N(v)}` は型にいかなるインスタンスも要求せず、所属同値・対合性・
    合成順序の反転・点ごとの和と積の保存・自己近傍割り当ての保存がすべて成り立つ
    （`setTranspose_*`）。人手証明が使うのは所属の向きの反転と外延性だけであり、
    有限性も等号判定もそこには現れない。
  - **始域と終域が同じ型である必要も無い。** 転置は `V → Finset W` を `W → Finset V` へ
    移す型の入れ替えであり、合成順序の反転は三つの異なる型 `V, W, X` の上で成り立つ
    （`hetTranspose_hetComp`）。同じ型に固定しているのは具体版の都合である。
  - **有限性と等号判定が要るのは `Finset` 表現を選んだ段だけである。**
    `hetTranspose N w = Finset.univ.filter (fun v => w ∈ N v)` と書くには、
    走る先の型の有限性 `Fintype V` と、所属判定に要る `DecidableEq W` が要る。
    これは転置の性質ではなく、部分集合を有限表現するための要求である。
    `Set` 版と `Finset` 版の対応は橋渡し定理 `coe_hetTranspose` で示す。
  - したがって対合性 `(Nᵀ)ᵀ = N` の `Finset` 版だけが両側の有限性と等号判定を要求する。
    二回目の転置で始域と終域が入れ替わるためであり、片側だけでは二回目が書けない。
  - 自己近傍割り当ての保存にだけ、始域と終域が同じ型であることが要る。
    `identityNeighborhood V : V → Finset V` の型が閉じていなければ主張が書けない。
  - 有限性は転置の全演算表と全単射の段でも使うが、全単射性の証明そのものは
    対合性だけから従い、有限性を追加で使わない。
  - 状態集合、局所規則、時間、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionMinimalCounterexample

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.NeighborhoodAssignmentUnionDistributivity
open CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionNondistributivity

/-! ### 何のインスタンスも要らない段（`Set` 表現）

`def_neighborhood_assignment_transpose` と、そこから従う人手証明の全ての等式は、
値を `Set` で表せば型にいかなる構造も要求せずに成り立つ。 -/

/-- `Set` 値の転置。始域と終域が入れ替わる。インスタンスを一つも要求しない。 -/
def setTranspose {V W : Type} (N : V → Set W) : W → Set V :=
  fun w => {v | w ∈ N v}

/-- `claim_neighborhood_assignment_transpose_membership` の必要十分版。
    所属の向きの反転は転置の定義そのものである。 -/
theorem mem_setTranspose {V W : Type} (N : V → Set W) (v : V) (w : W) :
    v ∈ setTranspose N w ↔ w ∈ N v := Iff.rfl

/-- `claim_neighborhood_assignment_transpose_involutive` の必要十分版。
    人手証明と同じく所属の向きの反転を二回使い、外延性で等号を得る。 -/
theorem setTranspose_setTranspose {V W : Type} (N : V → Set W) :
    setTranspose (setTranspose N) = N := by
  funext v
  ext w
  rw [mem_setTranspose, mem_setTranspose]

/-- `claim_neighborhood_assignment_transpose_reverses_composition` の必要十分版。
    始域・中間・終域は互いに異なる型でよい。合成の証人 `u` の二つの所属条件を
    転置で反転し、合成順序を逆にする。 -/
theorem setTranspose_setComp {V W X : Type} (N : V → Set W) (M : W → Set X) :
    setTranspose (setComp N M) = setComp (setTranspose M) (setTranspose N) := by
  funext x
  ext v
  rw [mem_setTranspose]
  constructor
  · rintro ⟨u, huN, hxM⟩
    exact ⟨u, (mem_setTranspose M u x).2 hxM, (mem_setTranspose N v u).2 huN⟩
  · rintro ⟨u, huMT, hvNT⟩
    exact ⟨u, (mem_setTranspose N v u).1 hvNT, (mem_setTranspose M u x).1 huMT⟩

/-- `claim_neighborhood_assignment_transpose_preserves_lattice_operations` の点ごとの和。 -/
theorem setTranspose_setUnion {V W : Type} (N M : V → Set W) :
    setTranspose (setUnion N M) = setUnion (setTranspose N) (setTranspose M) := by
  funext w
  ext v
  simp [setTranspose, setUnion]

/-- `claim_neighborhood_assignment_transpose_preserves_lattice_operations` の点ごとの積。 -/
theorem setTranspose_setInter {V W : Type} (N M : V → Set W) :
    setTranspose (setInter N M) = setInter (setTranspose N) (setTranspose M) := by
  funext w
  ext v
  simp [setTranspose, setInter]

/-- `claim_neighborhood_assignment_transpose_preserves_lattice_operations` の自己近傍割り当て。
    ここで初めて始域と終域が同じ型であることが要る。等号判定は要らない。 -/
theorem setTranspose_setIdentity {V : Type} :
    setTranspose (setIdentity V) = setIdentity V := by
  funext w
  ext v
  simp [setTranspose, setIdentity, eq_comm]

/-! ### 有限表現を選んだ段（有限性と等号判定が要る）

`Finset` で部分集合を表すと、走る先の型の有限性と所属判定の等号判定が要る。
これは転置の性質ではなく表現の要求であることを、`Set` 版との橋渡しで示す。 -/

/-- 型をまたぐ `Finset` 値の転置。`Fintype V` は `Finset.univ` を走らせるため、
    `DecidableEq W` は所属 `w ∈ N v` を判定するために要る。 -/
def hetTranspose {V W : Type} [Fintype V] [DecidableEq W] (N : V → Finset W) :
    W → Finset V :=
  fun w => Finset.univ.filter fun v => w ∈ N v

/-- 有限表現でも所属の向きの反転は定義の一段展開である。 -/
theorem mem_hetTranspose {V W : Type} [Fintype V] [DecidableEq W]
    (N : V → Finset W) (v : V) (w : W) :
    v ∈ hetTranspose N w ↔ w ∈ N v := by
  simp [hetTranspose]

/-- 有限表現の転置は `Set` 値の転置と一致する。有限性と等号判定が表現のためだけに
    要ることの根拠である。 -/
theorem coe_hetTranspose {V W : Type} [Fintype V] [DecidableEq W]
    (N : V → Finset W) (w : W) :
    ((hetTranspose N w : Finset V) : Set V) =
      setTranspose (fun v => ((N v : Finset W) : Set W)) w := by
  ext v
  simp [hetTranspose, setTranspose]

/-- 対合性の有限表現版。二回目の転置で始域と終域が入れ替わるため、
    両側の有限性と等号判定が要る。 -/
theorem hetTranspose_hetTranspose {V W : Type} [Fintype V] [Fintype W]
    [DecidableEq V] [DecidableEq W] (N : V → Finset W) :
    hetTranspose (hetTranspose N) = N := by
  funext v
  ext w
  rw [mem_hetTranspose, mem_hetTranspose]

/-- 合成順序の反転の有限表現版。始域・中間・終域は互いに異なる型でよい。 -/
theorem hetTranspose_hetComp {V W X : Type} [Fintype V] [Fintype W]
    [DecidableEq V] [DecidableEq W] [DecidableEq X]
    (N : V → Finset W) (M : W → Finset X) :
    hetTranspose (hetComp N M) = hetComp (hetTranspose M) (hetTranspose N) := by
  funext x
  ext v
  rw [mem_hetTranspose]
  simp only [hetComp, Finset.mem_biUnion]
  constructor
  · rintro ⟨u, huN, hxM⟩
    exact ⟨u, (mem_hetTranspose M u x).2 hxM, (mem_hetTranspose N v u).2 huN⟩
  · rintro ⟨u, huMT, hvNT⟩
    exact ⟨u, (mem_hetTranspose N v u).1 hvNT, (mem_hetTranspose M u x).1 huMT⟩

/-- 点ごとの和の保存の有限表現版。 -/
theorem hetTranspose_hetUnion {V W : Type} [Fintype V] [DecidableEq V] [DecidableEq W]
    (N M : V → Finset W) :
    hetTranspose (hetUnion N M) = hetUnion (hetTranspose N) (hetTranspose M) := by
  funext w
  ext v
  simp [hetTranspose, hetUnion]

/-- 点ごとの積の保存の有限表現版。 -/
theorem hetTranspose_hetInter {V W : Type} [Fintype V] [DecidableEq V] [DecidableEq W]
    (N M : V → Finset W) :
    hetTranspose (hetInter N M) = hetInter (hetTranspose N) (hetTranspose M) := by
  funext w
  ext v
  simp [hetTranspose, hetInter]

/-- 自己近傍割り当ての保存の有限表現版。始域と終域が同じ型であることが要る。 -/
theorem hetTranspose_identityNeighborhood {V : Type} [Fintype V] [DecidableEq V] :
    hetTranspose (identityNeighborhood V) = identityNeighborhood V := by
  funext w
  ext v
  simp [hetTranspose, identityNeighborhood, eq_comm]

/-! ### 全単射と有限表（有限性が要る段）

全単射性は対合性だけから従い、有限性を追加で使わない。
有限表を作る段では、近傍割り当て全体を `Finset` として走らせるために有限性を使う。 -/

/-- 転置は全単射である。証明は対合性だけを使う。 -/
theorem hetTranspose_bijective {V W : Type} [Fintype V] [Fintype W]
    [DecidableEq V] [DecidableEq W] :
    Function.Bijective (hetTranspose : (V → Finset W) → (W → Finset V)) := by
  constructor
  · intro N M h
    have hT := congrArg hetTranspose h
    rw [hetTranspose_hetTranspose, hetTranspose_hetTranspose] at hT
    exact hT
  · intro N
    exact ⟨hetTranspose N, hetTranspose_hetTranspose N⟩

/-- 型をまたぐ転置の全演算表。 -/
def hetTransposeTable (V W : Type) [Fintype V] [Fintype W] [DecidableEq V] [DecidableEq W] :
    Finset ((V → Finset W) × (W → Finset V)) :=
  Finset.univ.image fun N : V → Finset W => (N, hetTranspose N)

/-- 転置表は任意の近傍割り当てとその転置を含む。 -/
theorem mem_hetTransposeTable {V W : Type} [Fintype V] [Fintype W]
    [DecidableEq V] [DecidableEq W] (N : V → Finset W) :
    (N, hetTranspose N) ∈ hetTransposeTable V W := by
  simp [hetTransposeTable]

end CellularAutomata.NecSuf.NeighborhoodAssignmentTransposeInvolution
