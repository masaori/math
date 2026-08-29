/-
章「安定ファイバー間の一段発展」の必要十分版。

具体版と同じ手順（安定像上の添字写像 σ(q) := F(q)、E ∘ F = F ∘ E、ファイバーの完全逆像
F⁻¹(B(σ q)) = B(q) の両方向、像の包含 F(B(q)) ⊆ B(σ q)、定値写像による真の包含の反例、
有限走査表）を保ち、実際に使う構造だけを残す。

* 一般層（型 X と二つの自己写像 F, E : X → X）: 添字写像の定義には
  「F が像 range E を range E へ写すこと」だけが要る。順方向（y ∈ B(q) ⇒ F y ∈ B(σ q)）と
  像の包含には点ごとの可換性 E (F y) = F (E y) だけが要る。逆方向（F y ∈ B(σ q) ⇒ y ∈ B(q)）には
  可換性に加えて F の range E 上での単射性が要る。E の冪等性、E が F の反復であること、
  衝突開始位置の存在、σ の全射性はこの章のどの主張にも要らない。
* 反復層（E := E_F = F^{e_F}）: 可換性は加法則から従い、F が range E_F を保つことは可換性から
  従い、range E_F 上の単射性は S_F ∘ F = E_F と E_F の恒等性（前々章）から従う。
  したがって型 X・自己写像 F・衝突開始位置の存在だけで σ_F と完全逆像が定まる。
  前々章の `stableStep` は `DecidableEq (X → X)` を経由して定義されていたが、この章の
  σ_F にはそれが要らないことが分かった（両者が一致することは等号判定のもとで別に示す）。
* 反例: 相異なる二点 a ≠ b をもつ型と定値写像 F := (fun _ => a) だけで、
  具体版と同じ順に μ_F = λ_F = e_F = 1、E_F = F を導き、F(B(a)) ⊂ B(σ a) を得る。
  二値状態、一元舞台、局所規則は不要である。
* X の有限性と等号判定は、σ_F の表・像・完全逆像の有限走査表にだけ要る。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidStableImage
import CellularAutomata.NecSuf.IterateMonoidStablePartition

namespace CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidStabilizationIndex
open CellularAutomata.NecSuf.IterateMonoidMinimalPeriod
open CellularAutomata.NecSuf.IterateMonoidCycleIdempotent
open CellularAutomata.NecSuf.IterateMonoidStableImage
open CellularAutomata.NecSuf.IterateMonoidStablePartition

/-! ## 一般層: 二つの自己写像 F, E だけで成り立つ部分 -/

section General

variable {X : Type} (F E : X → X)

/-- `σ(q) := F(q)`。F が像 `range E` を保つことだけを要する。 -/
def stableIndexMap
    (hmaps : ∀ z ∈ IterateMonoidStablePartition.stableImage E,
      F z ∈ IterateMonoidStablePartition.stableImage E) :
    IterateMonoidStablePartition.stableImage E →
      IterateMonoidStablePartition.stableImage E :=
  fun q => ⟨F q.1, hmaps q.1 q.2⟩

theorem stableIndexMap_val
    (hmaps : ∀ z ∈ IterateMonoidStablePartition.stableImage E,
      F z ∈ IterateMonoidStablePartition.stableImage E)
    (q : IterateMonoidStablePartition.stableImage E) :
    (stableIndexMap F E hmaps q).1 = F q.1 := rfl

/-- 順方向（点ごと）: `E y = q` ならば `E (F y) = F q`。可換性だけを使う。 -/
theorem index_forward_pointwise (hcomm : ∀ y, E (F y) = F (E y))
    {q y : X} (hy : E y = q) : E (F y) = F q := by
  calc
    E (F y) = F (E y) := hcomm y
    _ = F q := congrArg F hy

/-- 逆方向（点ごと）: `q ∈ range E` かつ `E (F y) = F q` ならば `E y = q`。
    可換性と `range E` 上の単射性を使う。 -/
theorem index_backward_pointwise (hcomm : ∀ y, E (F y) = F (E y))
    (hinj : ∀ z ∈ IterateMonoidStablePartition.stableImage E,
      ∀ w ∈ IterateMonoidStablePartition.stableImage E, F z = F w → z = w)
    {q y : X} (hq : q ∈ IterateMonoidStablePartition.stableImage E)
    (hy : E (F y) = F q) : E y = q := by
  have hFE : F (E y) = F q := by
    calc
      F (E y) = E (F y) := (hcomm y).symm
      _ = F q := hy
  exact hinj (E y) ⟨y, rfl⟩ q hq hFE

/-- 点ごとの完全逆像の同値。 -/
theorem globalMap_mem_stableFiber_index_iff (hcomm : ∀ y, E (F y) = F (E y))
    (hinj : ∀ z ∈ IterateMonoidStablePartition.stableImage E,
      ∀ w ∈ IterateMonoidStablePartition.stableImage E, F z = F w → z = w)
    (hmaps : ∀ z ∈ IterateMonoidStablePartition.stableImage E,
      F z ∈ IterateMonoidStablePartition.stableImage E)
    (q : IterateMonoidStablePartition.stableImage E) (y : X) :
    F y ∈ IterateMonoidStablePartition.stableFiber E (stableIndexMap F E hmaps q) ↔
      y ∈ IterateMonoidStablePartition.stableFiber E q := by
  constructor
  · intro hy
    exact index_backward_pointwise F E hcomm hinj q.2 hy
  · intro hy
    exact index_forward_pointwise F E hcomm hy

/-- `F⁻¹(B(σ q)) = B(q)`。 -/
theorem stableFiber_exact_preimage (hcomm : ∀ y, E (F y) = F (E y))
    (hinj : ∀ z ∈ IterateMonoidStablePartition.stableImage E,
      ∀ w ∈ IterateMonoidStablePartition.stableImage E, F z = F w → z = w)
    (hmaps : ∀ z ∈ IterateMonoidStablePartition.stableImage E,
      F z ∈ IterateMonoidStablePartition.stableImage E)
    (q : IterateMonoidStablePartition.stableImage E) :
    F ⁻¹' IterateMonoidStablePartition.stableFiber E (stableIndexMap F E hmaps q) =
      IterateMonoidStablePartition.stableFiber E q := by
  ext y
  exact globalMap_mem_stableFiber_index_iff F E hcomm hinj hmaps q y

/-- 常に `F(B(q)) ⊆ B(σ q)`。可換性だけを使う。 -/
theorem stableFiber_image_subset (hcomm : ∀ y, E (F y) = F (E y))
    (hmaps : ∀ z ∈ IterateMonoidStablePartition.stableImage E,
      F z ∈ IterateMonoidStablePartition.stableImage E)
    (q : IterateMonoidStablePartition.stableImage E) :
    F '' IterateMonoidStablePartition.stableFiber E q ⊆
      IterateMonoidStablePartition.stableFiber E (stableIndexMap F E hmaps q) := by
  rintro z ⟨y, hy, rfl⟩
  exact index_forward_pointwise F E hcomm hy

end General

/-! ## 反復層: E := E_F = F^{e_F} のとき、必要な三性質が衝突開始位置の存在だけから従う -/

section Iterate

variable {X : Type} (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n)

/-- `E_F ∘ F = F ∘ E_F`。加法則を両方向に使う。 -/
theorem cycleIdempotent_commutes (y : X) :
    cycleIdempotent F hex (F y) = F (cycleIdempotent F hex y) := by
  change (iterateMap F (minStablePeriodMultiple F hex) ∘ iterateMap F 1) y =
    (iterateMap F 1 ∘ iterateMap F (minStablePeriodMultiple F hex)) y
  rw [iterateMap_comp_add, iterateMap_comp_add, Nat.add_comm]

/-- `F` は `range E_F` を保つ。可換性から従い、等号判定は要らない。 -/
theorem globalMap_maps_range_cycleIdempotent :
    ∀ z ∈ IterateMonoidStablePartition.stableImage (cycleIdempotent F hex),
      F z ∈ IterateMonoidStablePartition.stableImage (cycleIdempotent F hex) := by
  rintro z ⟨y, rfl⟩
  exact ⟨F y, cycleIdempotent_commutes F hex y⟩

/-- `F` は `range E_F` 上で単射である。`S_F ∘ F = E_F` と `E_F` の恒等性から従う。 -/
theorem globalMap_injOn_range_cycleIdempotent :
    ∀ z ∈ IterateMonoidStablePartition.stableImage (cycleIdempotent F hex),
      ∀ w ∈ IterateMonoidStablePartition.stableImage (cycleIdempotent F hex),
        F z = F w → z = w := by
  intro z hz w hw hzw
  have hR := (stableInverse_two_sided F hex).2
  calc
    z = cycleIdempotent F hex z := (cycleIdempotent_retracts_stableImage F hex hz).symm
    _ = stableInverse F hex (F z) := (congrFun hR z).symm
    _ = stableInverse F hex (F w) := congrArg (stableInverse F hex) hzw
    _ = cycleIdempotent F hex w := congrFun hR w
    _ = w := cycleIdempotent_retracts_stableImage F hex hw

/-- `σ_F(q) := F(q)`。 -/
noncomputable def iterateStableIndexMap :
    IterateMonoidStablePartition.stableImage (cycleIdempotent F hex) →
      IterateMonoidStablePartition.stableImage (cycleIdempotent F hex) :=
  stableIndexMap F (cycleIdempotent F hex) (globalMap_maps_range_cycleIdempotent F hex)

theorem iterateStableIndexMap_val
    (q : IterateMonoidStablePartition.stableImage (cycleIdempotent F hex)) :
    (iterateStableIndexMap F hex q).1 = F q.1 := rfl

/-- 等号判定があれば、前々章の制限写像 `stableStep` と一致する。 -/
theorem iterateStableIndexMap_eq_stableStep [DecidableEq (X → X)]
    (q : IterateMonoidStablePartition.stableImage (cycleIdempotent F hex)) :
    (iterateStableIndexMap F hex q).1 = (stableStep F hex q).1 := rfl

/-- 点ごとの完全逆像の同値（反復層）。 -/
theorem iterate_globalMap_mem_stableFiber_index_iff
    (q : IterateMonoidStablePartition.stableImage (cycleIdempotent F hex)) (y : X) :
    F y ∈ IterateMonoidStablePartition.stableFiber (cycleIdempotent F hex)
        (iterateStableIndexMap F hex q) ↔
      y ∈ IterateMonoidStablePartition.stableFiber (cycleIdempotent F hex) q :=
  globalMap_mem_stableFiber_index_iff F (cycleIdempotent F hex)
    (cycleIdempotent_commutes F hex) (globalMap_injOn_range_cycleIdempotent F hex)
    (globalMap_maps_range_cycleIdempotent F hex) q y

/-- `F⁻¹(B_F(σ_F q)) = B_F(q)`（反復層）。 -/
theorem iterate_stableFiber_exact_preimage
    (q : IterateMonoidStablePartition.stableImage (cycleIdempotent F hex)) :
    F ⁻¹' IterateMonoidStablePartition.stableFiber (cycleIdempotent F hex)
        (iterateStableIndexMap F hex q) =
      IterateMonoidStablePartition.stableFiber (cycleIdempotent F hex) q :=
  stableFiber_exact_preimage F (cycleIdempotent F hex)
    (cycleIdempotent_commutes F hex) (globalMap_injOn_range_cycleIdempotent F hex)
    (globalMap_maps_range_cycleIdempotent F hex) q

/-- `F(B_F(q)) ⊆ B_F(σ_F q)`（反復層）。 -/
theorem iterate_stableFiber_image_subset
    (q : IterateMonoidStablePartition.stableImage (cycleIdempotent F hex)) :
    F '' IterateMonoidStablePartition.stableFiber (cycleIdempotent F hex) q ⊆
      IterateMonoidStablePartition.stableFiber (cycleIdempotent F hex)
        (iterateStableIndexMap F hex q) :=
  stableFiber_image_subset F (cycleIdempotent F hex)
    (cycleIdempotent_commutes F hex) (globalMap_maps_range_cycleIdempotent F hex) q

end Iterate

/-! ## 反例: 相異なる二点への定値写像 -/

section Counterexample

variable {X : Type} {a b : X} (hab : a ≠ b)

/-- 定値写像 `F := fun _ => a` は正の回数の反復で定値写像に等しい。 -/
theorem const_iterateMap_of_pos (n : ℕ) (hn : 0 < n) :
    iterateMap (fun _ : X => a) n = fun _ => a := by
  cases n with
  | zero => omega
  | succ n =>
      funext y
      rfl

/-- 定値写像は位置 1 で衝突を始める。 -/
theorem const_hex : ∃ n : ℕ, IsCollisionStart (fun _ : X => a) n :=
  ⟨1, 1, by omega, by
    rw [const_iterateMap_of_pos 1 (by omega), const_iterateMap_of_pos 2 (by omega)]⟩

include hab in
/-- `μ_F = 1`。0 でないことは `b ≠ a` から従う。 -/
theorem const_minCollisionStart :
    minCollisionStart (fun _ : X => a) (const_hex (a := a)) = 1 := by
  apply Nat.le_antisymm
  · exact minCollisionStart_le _ _ ⟨1, by omega, by
      rw [const_iterateMap_of_pos 1 (by omega), const_iterateMap_of_pos 2 (by omega)]⟩
  · have hpos : 0 < minCollisionStart (fun _ : X => a) (const_hex (a := a)) := by
      by_contra h
      have hzero : minCollisionStart (fun _ : X => a) (const_hex (a := a)) = 0 := by omega
      rcases minCollisionStart_spec (fun _ : X => a) (const_hex (a := a)) with ⟨p, hp, heq⟩
      rw [hzero, Nat.zero_add] at heq
      have hvalue := congrFun heq b
      rw [const_iterateMap_of_pos p hp] at hvalue
      change b = a at hvalue
      exact hab hvalue.symm
    omega

include hab in
/-- `λ_F = 1`。 -/
theorem const_minPositivePeriod :
    minPositivePeriod (fun _ : X => a) (const_hex (a := a)) = 1 := by
  have hperiod : IsPositivePeriod (fun _ : X => a) (const_hex (a := a)) 1 := by
    refine ⟨by omega, ?_⟩
    rw [const_minCollisionStart hab]
    rw [const_iterateMap_of_pos 1 (by omega), const_iterateMap_of_pos 2 (by omega)]
  exact Nat.le_antisymm (minPositivePeriod_le _ _ hperiod) (minPositivePeriod_pos _ _)

include hab in
/-- `e_F = 1`。 -/
theorem const_minStablePeriodMultiple :
    minStablePeriodMultiple (fun _ : X => a) (const_hex (a := a)) = 1 := by
  have hone : IsStablePeriodMultiple (fun _ : X => a) (const_hex (a := a)) 1 := by
    rw [IsStablePeriodMultiple, const_minCollisionStart hab, const_minPositivePeriod hab]
    exact ⟨le_rfl, dvd_refl 1⟩
  apply Nat.le_antisymm
  · exact minStablePeriodMultiple_le _ _ hone
  · rw [← const_minCollisionStart hab]
    exact (minStablePeriodMultiple_spec _ _).1

include hab in
/-- `E_F = F`。 -/
theorem const_cycleIdempotent_eq :
    cycleIdempotent (fun _ : X => a) (const_hex (a := a)) = fun _ => a := by
  rw [cycleIdempotent, const_minStablePeriodMultiple hab]
  rfl

include hab in
/-- 定値写像ではファイバーの像が次のファイバーの真部分集合になる。 -/
theorem const_stableFiber_image_strict :
    ∃ q : IterateMonoidStablePartition.stableImage
        (cycleIdempotent (fun _ : X => a) (const_hex (a := a))),
      (fun _ : X => a) '' IterateMonoidStablePartition.stableFiber
          (cycleIdempotent (fun _ : X => a) (const_hex (a := a))) q ⊂
        IterateMonoidStablePartition.stableFiber
          (cycleIdempotent (fun _ : X => a) (const_hex (a := a)))
          (iterateStableIndexMap (fun _ : X => a) (const_hex (a := a)) q) := by
  have hE := const_cycleIdempotent_eq hab
  let q : IterateMonoidStablePartition.stableImage
      (cycleIdempotent (fun _ : X => a) (const_hex (a := a))) :=
    ⟨a, ⟨a, congrFun hE a⟩⟩
  refine ⟨q, iterate_stableFiber_image_subset _ _ q, ?_⟩
  intro hreverse
  have hbTarget : b ∈ IterateMonoidStablePartition.stableFiber
      (cycleIdempotent (fun _ : X => a) (const_hex (a := a)))
      (iterateStableIndexMap (fun _ : X => a) (const_hex (a := a)) q) := by
    change cycleIdempotent (fun _ : X => a) (const_hex (a := a)) b = (fun _ : X => a) q.1
    exact congrFun hE b
  have hbImage : b ∈ (fun _ : X => a) '' IterateMonoidStablePartition.stableFiber
      (cycleIdempotent (fun _ : X => a) (const_hex (a := a))) q := hreverse hbTarget
  rcases hbImage with ⟨y, _hy, hy⟩
  exact hab hy

end Counterexample

/-! ## 有限走査表 -/

section FiniteScan

variable {X : Type} [Fintype X] [DecidableEq X]
variable (F : X → X) (hex : ∃ n : ℕ, IsCollisionStart F n)

/-- `σ_F` の有限な表。 -/
noncomputable def iterateStableIndexMapTable :
    Finset (IterateMonoidStablePartition.stableImage (cycleIdempotent F hex) ×
      IterateMonoidStablePartition.stableImage (cycleIdempotent F hex)) :=
  Finset.univ.image (fun q => (q, iterateStableIndexMap F hex q))

/-- `F(B_F(q))` の有限走査表。 -/
noncomputable def iterateStableFiberImageTable
    (q : IterateMonoidStablePartition.stableImage (cycleIdempotent F hex)) : Finset X :=
  (stableFiberTable (cycleIdempotent F hex) q).image F

/-- `F⁻¹(B_F(σ_F q))` の有限走査表。 -/
noncomputable def iterateStableFiberPreimageTable
    (q : IterateMonoidStablePartition.stableImage (cycleIdempotent F hex)) : Finset X :=
  Finset.univ.filter (fun y =>
    F y ∈ stableFiberTable (cycleIdempotent F hex) (iterateStableIndexMap F hex q))

theorem mem_iterateStableFiberPreimageTable_iff
    (q : IterateMonoidStablePartition.stableImage (cycleIdempotent F hex)) (y : X) :
    y ∈ iterateStableFiberPreimageTable F hex q ↔
      y ∈ IterateMonoidStablePartition.stableFiber (cycleIdempotent F hex) q := by
  simp only [iterateStableFiberPreimageTable, Finset.mem_filter, Finset.mem_univ, true_and]
  rw [mem_stableFiberTable_iff]
  exact iterate_globalMap_mem_stableFiber_index_iff F hex q y

end FiniteScan

end CellularAutomata.NecSuf.IterateMonoidStableFiberDynamics
