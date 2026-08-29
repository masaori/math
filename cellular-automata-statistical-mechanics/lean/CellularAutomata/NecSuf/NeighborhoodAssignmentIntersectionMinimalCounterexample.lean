/-
章「点ごとの積に対する合成の非分配反例の最小舞台」の必要十分版。

具体版（CellularAutomata.NeighborhoodAssignmentIntersectionMinimalCounterexample）と同じ順序で、
一元以下の舞台での合成と点ごとの積の一致、そこから従う左右の分配律、二元以上の舞台での
左右の反例、そして両者を合わせた同値を示す。

必要な構造の検査結果:
  - 合成と点ごとの積の一致に要るのは、舞台が subsingleton であること（相異なる二元を持たないこと）
    だけである。**舞台の有限性は要らない。** 具体版は `Fintype.card V ≤ 1` を仮定していたが、
    証明が使うのは `Fintype.card_le_one_iff_subsingleton` で取り出した `Subsingleton V` だけであり、
    元数を数える段は無い。無限だが subsingleton の型は存在しないので仮定が空になる心配もない
    （空型は subsingleton であり、そこでも主張は非自明に成り立つ）。
  - 等号判定は `Finset` の共通部分 `∩` を書くためだけに要る。合成 `hetComp` も
    `Finset.biUnion` の要求として同じ等号判定を使う。
  - 始域と終域が同じ型であることは削れない。合成 `N ⋆ M` と点ごとの積 `N ⊓ M` を等号で
    結ぶには両辺の型が一致していなければならず、`N : V → Finset W` かつ `M : W → Finset X` の
    形では `N ⊓ M` 自体が書けない。
  - 左右の反例に要るのは、舞台に相異なる二点 `a ≠ b` があることだけである。**有限性は要らない。**
    前章の必要十分版はさらに始域・中間・終域を別の型に分けてよいことまで示しているが、
    本章の主題は最小の舞台なので、同じ型の中に二点を要求する形に固定する。
  - `a ≠ b` は削れない: 削ると舞台は subsingleton になり、上の一致から左右の分配律が成り立つ。
    この二つを合わせて「左（右）分配律が全ての近傍割り当てで成り立つ ⟺ 舞台が subsingleton」
    という同値が得られる。具体版の「最小舞台元数は二」はこの同値の有限舞台への特殊化である。
  - 状態集合、局所規則、時間、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionNondistributivity

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionMinimalCounterexample

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionNondistributivity

/-! ### 相異なる二元を持たない舞台（有限性を落とした段） -/

/-- `claim_subsingleton_neighborhood_composition_equals_intersection` の必要十分版。
    人手証明どおり、合成近傍の証人を舞台の唯一の元へ同定し、逆向きでは `w` を証人に取る。
    要るのは `Subsingleton V` だけで、舞台の有限性は使わない。 -/
theorem subsingleton_hetComp_eq_hetInter {V : Type} [DecidableEq V] [Subsingleton V]
    (N M : V → Finset V) : hetComp N M = hetInter N M := by
  funext v
  ext w
  constructor
  · intro hw
    rcases Finset.mem_biUnion.mp hw with ⟨u, huN, hwM⟩
    exact Finset.mem_inter.mpr ⟨
      by simpa only [Subsingleton.elim u w] using huN,
      by simpa only [Subsingleton.elim u v] using hwM⟩
  · intro hw
    rcases Finset.mem_inter.mp hw with ⟨hwN, hwM⟩
    exact Finset.mem_biUnion.mpr ⟨w, hwN,
      by simpa only [Subsingleton.elim v w] using hwM⟩

/-- 相異なる二元を持たない舞台での左分配律。三つの合成を前定理で点ごとの積へ書き換える。 -/
theorem subsingleton_hetComp_hetInter_left {V : Type} [DecidableEq V] [Subsingleton V]
    (N M L : V → Finset V) :
    hetComp (hetInter N M) L = hetInter (hetComp N L) (hetComp M L) := by
  rw [subsingleton_hetComp_eq_hetInter]
  rw [subsingleton_hetComp_eq_hetInter]
  rw [subsingleton_hetComp_eq_hetInter]
  funext v
  exact Finset.inter_inter_distrib_right (N v) (M v) (L v)

/-- 相異なる二元を持たない舞台での右分配律。 -/
theorem subsingleton_hetComp_hetInter_right {V : Type} [DecidableEq V] [Subsingleton V]
    (L N M : V → Finset V) :
    hetComp L (hetInter N M) = hetInter (hetComp L N) (hetComp L M) := by
  rw [subsingleton_hetComp_eq_hetInter]
  rw [subsingleton_hetComp_eq_hetInter]
  rw [subsingleton_hetComp_eq_hetInter]
  funext v
  exact Finset.inter_inter_distrib_left (L v) (N v) (M v)

/-- `claim_subsingleton_neighborhood_composition_distributes_over_intersection` の必要十分版。 -/
theorem subsingleton_hetComp_hetInter_distributive {V : Type} [DecidableEq V] [Subsingleton V]
    (N M L : V → Finset V) :
    hetComp (hetInter N M) L = hetInter (hetComp N L) (hetComp M L) ∧
      hetComp L (hetInter N M) = hetInter (hetComp L N) (hetComp L M) :=
  ⟨subsingleton_hetComp_hetInter_left N M L, subsingleton_hetComp_hetInter_right L N M⟩

/-! ### 相異なる二元を持つ舞台（有限性を落とした反例の段）

具体版は舞台を `Fin 2` に固定していたが、実際に使うのは相異なる二点だけである。 -/

/-- 左の反例の第一近傍割り当て。`b` でだけ `{a}` を返す。 -/
def leftWitnessN {V : Type} [DecidableEq V] (a b : V) : V → Finset V :=
  fun v => if v = b then {a} else ∅

/-- 左の反例の第二近傍割り当て。`b` でだけ `{b}` を返す。 -/
def leftWitnessM {V : Type} [DecidableEq V] (b : V) : V → Finset V :=
  fun v => if v = b then {b} else ∅

/-- 左の反例の第三近傍割り当て。どこでも `{a}` を返す。 -/
def leftWitnessL {V : Type} [DecidableEq V] (a : V) : V → Finset V := fun _ => {a}

/-- 左辺は `b` で空集合になる。`a ≠ b` から `{a} ∩ {b} = ∅` を使う。 -/
theorem leftWitness_lhs_at_b {V : Type} [DecidableEq V] {a b : V} (hab : a ≠ b) :
    hetComp (hetInter (leftWitnessN a b) (leftWitnessM b)) (leftWitnessL a) b = ∅ := by
  have hinter : hetInter (leftWitnessN a b) (leftWitnessM b) b = (∅ : Finset V) := by
    ext w
    simp only [hetInter, leftWitnessN, leftWitnessM]
    constructor
    · intro hw
      rcases Finset.mem_inter.mp hw with ⟨h1, h2⟩
      exact absurd ((Finset.mem_singleton.mp h1).symm.trans (Finset.mem_singleton.mp h2)) hab
    · intro hw
      exact absurd hw (Finset.notMem_empty w)
  simp [hetComp, hinter]

/-- 右辺は `b` で `{a}` になる。 -/
theorem leftWitness_rhs_at_b {V : Type} [DecidableEq V] {a b : V} :
    hetInter (hetComp (leftWitnessN a b) (leftWitnessL a))
      (hetComp (leftWitnessM b) (leftWitnessL a)) b = {a} := by
  simp [hetInter, hetComp, leftWitnessN, leftWitnessM, leftWitnessL]

/-- `claim_two_element_composition_intersection_nondistributivity` の左側の必要十分版。
    要るのは相異なる二点だけで、舞台の有限性は要らない。 -/
theorem leftWitness_failure {V : Type} [DecidableEq V] {a b : V} (hab : a ≠ b) :
    hetComp (hetInter (leftWitnessN a b) (leftWitnessM b)) (leftWitnessL a) ≠
      hetInter (hetComp (leftWitnessN a b) (leftWitnessL a))
        (hetComp (leftWitnessM b) (leftWitnessL a)) := by
  intro h
  have hAtB := congrFun h b
  rw [leftWitness_lhs_at_b hab, leftWitness_rhs_at_b] at hAtB
  exact absurd (hAtB ▸ Finset.mem_singleton_self a) (Finset.notMem_empty a)

/-- 右の反例の第一近傍割り当て。`b` でだけ `{a, b}` を返す。 -/
def rightWitnessL {V : Type} [DecidableEq V] (a b : V) : V → Finset V :=
  fun v => if v = b then {a, b} else ∅

/-- 右の反例の第二近傍割り当て。`b` でだけ `{a}` を返す。 -/
def rightWitnessN {V : Type} [DecidableEq V] (a b : V) : V → Finset V :=
  fun v => if v = b then {a} else ∅

/-- 右の反例の第三近傍割り当て。`a` でだけ `{a}` を返す。 -/
def rightWitnessM {V : Type} [DecidableEq V] (a : V) : V → Finset V :=
  fun v => if v = a then {a} else ∅

/-- 左辺は `b` で空集合になる。`L'(b) = {a, b}` のどちらの元でも積が空だからである。 -/
theorem rightWitness_lhs_at_b {V : Type} [DecidableEq V] {a b : V} (hab : a ≠ b) :
    hetComp (rightWitnessL a b) (hetInter (rightWitnessN a b) (rightWitnessM a)) b = ∅ := by
  have hAtA : hetInter (rightWitnessN a b) (rightWitnessM a) a = (∅ : Finset V) := by
    simp [hetInter, rightWitnessN, rightWitnessM, hab]
  have hAtB : hetInter (rightWitnessN a b) (rightWitnessM a) b = (∅ : Finset V) := by
    simp [hetInter, rightWitnessN, rightWitnessM, Ne.symm hab]
  simp [hetComp, rightWitnessL, hAtA, hAtB]

/-- 右辺は `b` で `{a}` になる。 -/
theorem rightWitness_rhs_at_b {V : Type} [DecidableEq V] {a b : V} (hab : a ≠ b) :
    hetInter (hetComp (rightWitnessL a b) (rightWitnessN a b))
      (hetComp (rightWitnessL a b) (rightWitnessM a)) b = {a} := by
  simp [hetInter, hetComp, rightWitnessL, rightWitnessN, rightWitnessM, hab, Ne.symm hab]

/-- `claim_two_element_composition_intersection_nondistributivity` の右側の必要十分版。 -/
theorem rightWitness_failure {V : Type} [DecidableEq V] {a b : V} (hab : a ≠ b) :
    hetComp (rightWitnessL a b) (hetInter (rightWitnessN a b) (rightWitnessM a)) ≠
      hetInter (hetComp (rightWitnessL a b) (rightWitnessN a b))
        (hetComp (rightWitnessL a b) (rightWitnessM a)) := by
  intro h
  have hAtB := congrFun h b
  rw [rightWitness_lhs_at_b hab, rightWitness_rhs_at_b hab] at hAtB
  exact absurd (hAtB ▸ Finset.mem_singleton_self a) (Finset.notMem_empty a)

/-! ### 最小性の必要十分な形

具体版の「最小舞台元数は二」は、次の同値の有限舞台への特殊化である。 -/

/-- 左分配律が全ての近傍割り当てで成り立つことと、舞台が相異なる二元を持たないことは同値である。 -/
theorem forall_left_distributive_iff_subsingleton {V : Type} [DecidableEq V] :
    (∀ N M L : V → Finset V,
        hetComp (hetInter N M) L = hetInter (hetComp N L) (hetComp M L)) ↔
      ∀ x y : V, x = y := by
  constructor
  · intro hdist x y
    by_contra hxy
    exact leftWitness_failure hxy (hdist _ _ _)
  · intro hsub
    letI : Subsingleton V := ⟨hsub⟩
    exact fun N M L => subsingleton_hetComp_hetInter_left N M L

/-- 右分配律が全ての近傍割り当てで成り立つことと、舞台が相異なる二元を持たないことは同値である。 -/
theorem forall_right_distributive_iff_subsingleton {V : Type} [DecidableEq V] :
    (∀ L N M : V → Finset V,
        hetComp L (hetInter N M) = hetInter (hetComp L N) (hetComp L M)) ↔
      ∀ x y : V, x = y := by
  constructor
  · intro hdist x y
    by_contra hxy
    exact rightWitness_failure hxy (hdist _ _ _)
  · intro hsub
    letI : Subsingleton V := ⟨hsub⟩
    exact fun L N M => subsingleton_hetComp_hetInter_right L N M

end CellularAutomata.NecSuf.NeighborhoodAssignmentIntersectionMinimalCounterexample
