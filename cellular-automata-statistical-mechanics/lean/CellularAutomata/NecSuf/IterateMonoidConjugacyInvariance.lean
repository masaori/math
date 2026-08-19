/-
章「有限大域写像の共役による安定ファイバー根付き木族の不変性」の必要十分版（前半）。

具体版と同じ手順（反復の帰納法、反復等号の両側同値、三つの最小指数の両側不等式、
指数の一致による冪等元・一周期写像の移送、安定像・安定ファイバーの所属の両方向）を保ち、
実際に使う構造だけを残す。

* 反復の移送には、二つの型 X, Y、自己写像 F : X → X, G : Y → Y、写像 h : X → Y と
  共役条件 h ∘ F = G ∘ h だけが要る。h の単射性・全射性・X, Y の有限性は要らない。
* 反復写像の等号の保存（F 側 → G 側）には h の全射性だけ、反映（G 側 → F 側）には
  h の単射性だけが要る。具体版が全単射を仮定するのは両方向を同時に述べるためであり、
  一方向ずつには半分ずつで足りる。
* 最小衝突開始位置・最小正周期・最小安定周期倍数指数の保存には、上の両側同値に加えて
  衝突開始位置の存在だけが要る。存在は片側に仮定すれば同値でもう片側へ移るので、
  X 側の存在だけを仮定する。X, Y の有限性はこの存在を与える側にだけあり、
  この章の定理には現れない。
* 巡回冪等元・一周期写像の移送は、反復の移送と最小指数の一致だけから従う。
* 安定像・安定ファイバーの移送は、巡回冪等元に限らず、h で共役な任意の写像対
  E : X → X, E' : Y → Y について成り立つ。E の冪等性・反復写像であることは要らない。
  所属の保存には共役条件だけ、反映には h の全射性（安定像）・単射性（ファイバー）が要る。

根付き辺・深さ・分岐個数の移送と有限表（後半）は未収録である。
二値状態、セル、近傍、局所規則、R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidCycleIdempotent
import CellularAutomata.NecSuf.IterateMonoidStablePartition

namespace CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidStabilizationIndex
open CellularAutomata.NecSuf.IterateMonoidMinimalPeriod
open CellularAutomata.NecSuf.IterateMonoidCycleIdempotent
open CellularAutomata.NecSuf.IterateMonoidStablePartition

variable {X Y : Type}
variable (F : X → X) (G : Y → Y) (h : X → Y)
variable (hconj : ∀ x, h (F x) = G (h x))

include hconj

/-- 共役写像は全ての反復を移送する。h は単なる写像で足りる。 -/
theorem conjugate_iterateMap (n : ℕ) (x : X) :
    h (iterateMap F n x) = iterateMap G n (h x) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      show h (F (iterateMap F n x)) = G (iterateMap G n (h x))
      rw [hconj, ih]

/-- 反復写像の等号の保存には h の全射性だけが要る。 -/
theorem iterateMap_eq_of_surjective (hs : Function.Surjective h) {m n : ℕ}
    (heq : iterateMap F m = iterateMap F n) :
    iterateMap G m = iterateMap G n := by
  funext z
  obtain ⟨x, rfl⟩ := hs z
  exact (conjugate_iterateMap F G h hconj m x).symm.trans <|
    congrArg h (congrFun heq x) |>.trans (conjugate_iterateMap F G h hconj n x)

/-- 反復写像の等号の反映には h の単射性だけが要る。 -/
theorem iterateMap_eq_of_injective (hi : Function.Injective h) {m n : ℕ}
    (heq : iterateMap G m = iterateMap G n) :
    iterateMap F m = iterateMap F n := by
  funext x
  apply hi
  exact (conjugate_iterateMap F G h hconj m x).trans <|
    congrFun heq (h x) |>.trans (conjugate_iterateMap F G h hconj n x).symm

/-- 全単射なら反復写像の等号は両側で同値である。 -/
theorem iterateMap_eq_iff (hb : Function.Bijective h) (m n : ℕ) :
    iterateMap F m = iterateMap F n ↔ iterateMap G m = iterateMap G n :=
  ⟨iterateMap_eq_of_surjective F G h hconj hb.2,
    iterateMap_eq_of_injective F G h hconj hb.1⟩

/-- 衝突開始位置は両側で同値である。 -/
theorem isCollisionStart_iff (hb : Function.Bijective h) (n : ℕ) :
    IsCollisionStart F n ↔ IsCollisionStart G n := by
  constructor
  · rintro ⟨p, hp, heq⟩
    exact ⟨p, hp, iterateMap_eq_of_surjective F G h hconj hb.2 heq⟩
  · rintro ⟨p, hp, heq⟩
    exact ⟨p, hp, iterateMap_eq_of_injective F G h hconj hb.1 heq⟩

/-- X 側の衝突開始位置の存在は Y 側へ移る。有限性はここに要らない。 -/
theorem exists_collisionStart_transfer (hb : Function.Bijective h)
    (hex : ∃ n : ℕ, IsCollisionStart F n) : ∃ n : ℕ, IsCollisionStart G n := by
  rcases hex with ⟨n, hn⟩
  exact ⟨n, (isCollisionStart_iff F G h hconj hb n).mp hn⟩

/-- 共役写像は最小衝突開始位置を保存する。要るのは両側同値と存在だけである。 -/
theorem minCollisionStart_eq (hb : Function.Bijective h)
    (hex : ∃ n : ℕ, IsCollisionStart F n) :
    minCollisionStart F hex =
      minCollisionStart G (exists_collisionStart_transfer F G h hconj hb hex) := by
  apply Nat.le_antisymm
  · apply minCollisionStart_le
    exact (isCollisionStart_iff F G h hconj hb _).mpr
      (minCollisionStart_spec G (exists_collisionStart_transfer F G h hconj hb hex))
  · apply minCollisionStart_le
    exact (isCollisionStart_iff F G h hconj hb _).mp (minCollisionStart_spec F hex)

/-- 正周期は両側で同値である。 -/
theorem isPositivePeriod_iff (hb : Function.Bijective h)
    (hex : ∃ n : ℕ, IsCollisionStart F n) (p : ℕ) :
    IsPositivePeriod F hex p ↔
      IsPositivePeriod G (exists_collisionStart_transfer F G h hconj hb hex) p := by
  rw [IsPositivePeriod, IsPositivePeriod,
    ← minCollisionStart_eq F G h hconj hb hex]
  exact and_congr_right fun _ => iterateMap_eq_iff F G h hconj hb _ _

/-- 共役写像は最小正周期を保存する。 -/
theorem minPositivePeriod_eq (hb : Function.Bijective h)
    (hex : ∃ n : ℕ, IsCollisionStart F n) :
    minPositivePeriod F hex =
      minPositivePeriod G (exists_collisionStart_transfer F G h hconj hb hex) := by
  apply Nat.le_antisymm
  · apply minPositivePeriod_le
    exact (isPositivePeriod_iff F G h hconj hb hex _).mpr
      (minPositivePeriod_spec G (exists_collisionStart_transfer F G h hconj hb hex))
  · apply minPositivePeriod_le
    exact (isPositivePeriod_iff F G h hconj hb hex _).mp (minPositivePeriod_spec F hex)

/-- 安定後の周期倍数指数は両側で同値である。 -/
theorem isStablePeriodMultiple_iff (hb : Function.Bijective h)
    (hex : ∃ n : ℕ, IsCollisionStart F n) (n : ℕ) :
    IsStablePeriodMultiple F hex n ↔
      IsStablePeriodMultiple G (exists_collisionStart_transfer F G h hconj hb hex) n := by
  simp only [IsStablePeriodMultiple, ← minCollisionStart_eq F G h hconj hb hex,
    ← minPositivePeriod_eq F G h hconj hb hex]

/-- 共役写像は最小安定周期倍数指数を保存する。 -/
theorem minStablePeriodMultiple_eq (hb : Function.Bijective h)
    (hex : ∃ n : ℕ, IsCollisionStart F n) :
    minStablePeriodMultiple F hex =
      minStablePeriodMultiple G (exists_collisionStart_transfer F G h hconj hb hex) := by
  apply Nat.le_antisymm
  · apply minStablePeriodMultiple_le
    exact (isStablePeriodMultiple_iff F G h hconj hb hex _).mpr
      (minStablePeriodMultiple_spec G (exists_collisionStart_transfer F G h hconj hb hex))
  · apply minStablePeriodMultiple_le
    exact (isStablePeriodMultiple_iff F G h hconj hb hex _).mp
      (minStablePeriodMultiple_spec F hex)

/-- 共役写像は巡回部の冪等元を移送する。反復の移送と指数の一致だけを使う。 -/
theorem conjugate_cycleIdempotent (hb : Function.Bijective h)
    (hex : ∃ n : ℕ, IsCollisionStart F n) (x : X) :
    h (cycleIdempotent F hex x) =
      cycleIdempotent G (exists_collisionStart_transfer F G h hconj hb hex) (h x) := by
  rw [cycleIdempotent, cycleIdempotent,
    ← minStablePeriodMultiple_eq F G h hconj hb hex]
  exact conjugate_iterateMap F G h hconj _ x

/-- 共役写像は一周期写像 F^{λ} を移送する。反復の移送と最小正周期の一致だけを使う。 -/
theorem conjugate_onePeriodMap (hb : Function.Bijective h)
    (hex : ∃ n : ℕ, IsCollisionStart F n) (x : X) :
    h (iterateMap F (minPositivePeriod F hex) x) =
      iterateMap G
        (minPositivePeriod G (exists_collisionStart_transfer F G h hconj hb hex))
        (h x) := by
  rw [← minPositivePeriod_eq F G h hconj hb hex]
  exact conjugate_iterateMap F G h hconj _ x

end CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance

/-! ## 安定像・安定ファイバーの移送

巡回冪等元に限らず、h で共役な任意の写像対 E, E' について成り立つので、
反復モノイドの構造を仮定に含めない別の節として置く。 -/

namespace CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.StableFiberTransport

open CellularAutomata.NecSuf.IterateMonoidStablePartition

variable {X Y : Type}
variable (E : X → X) (E' : Y → Y) (h : X → Y)
variable (hconj : ∀ x, h (E x) = E' (h x))

include hconj

/-- 安定像の所属の保存には共役条件だけが要る。 -/
theorem mem_stableImage_of_mem (x : X) (hx : x ∈ stableImage E) :
    h x ∈ stableImage E' := by
  rcases hx with ⟨z, rfl⟩
  exact ⟨h z, (hconj z).symm⟩

/-- 安定像の所属の反映には h の全射性と単射性が要る。 -/
theorem mem_stableImage_of_image_mem (hb : Function.Bijective h) (x : X)
    (hx : h x ∈ stableImage E') : x ∈ stableImage E := by
  rcases hx with ⟨z, hz⟩
  obtain ⟨w, rfl⟩ := hb.2 z
  refine ⟨w, hb.1 ?_⟩
  rw [hconj]
  exact hz

/-- 全単射なら安定像の所属は両側で同値である。 -/
theorem mem_stableImage_iff (hb : Function.Bijective h) (x : X) :
    x ∈ stableImage E ↔ h x ∈ stableImage E' :=
  ⟨mem_stableImage_of_mem E E' h hconj x,
    mem_stableImage_of_image_mem E E' h hconj hb x⟩

/-- 安定ファイバーの所属の保存には共役条件だけが要る。 -/
theorem mem_stableFiber_of_mem (q : stableImage E) (x : X) (hx : x ∈ stableFiber E q)
    (q' : stableImage E') (hq : q'.1 = h q.1) : h x ∈ stableFiber E' q' := by
  rw [mem_stableFiber_iff] at hx ⊢
  rw [hq, ← hconj, hx]

/-- 安定ファイバーの所属の反映には h の単射性だけが要る。 -/
theorem mem_stableFiber_of_image_mem (hi : Function.Injective h)
    (q : stableImage E) (x : X) (q' : stableImage E') (hq : q'.1 = h q.1)
    (hx : h x ∈ stableFiber E' q') : x ∈ stableFiber E q := by
  rw [mem_stableFiber_iff] at hx ⊢
  apply hi
  rw [hconj]
  rw [hq] at hx
  exact hx

/-- 全単射なら安定ファイバーの所属は両側で同値である。 -/
theorem mem_stableFiber_iff_transport (hb : Function.Bijective h)
    (q : stableImage E) (x : X) (q' : stableImage E') (hq : q'.1 = h q.1) :
    x ∈ stableFiber E q ↔ h x ∈ stableFiber E' q' :=
  ⟨fun hx => mem_stableFiber_of_mem E E' h hconj q x hx q' hq,
    mem_stableFiber_of_image_mem E E' h hconj hb.1 q x q' hq⟩

end CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance.StableFiberTransport
