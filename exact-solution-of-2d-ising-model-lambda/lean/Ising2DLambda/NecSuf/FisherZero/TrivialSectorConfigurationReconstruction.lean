/-
「自明セクターの偶部分グラフから配位を復元できる」のスピン値域・行和と列和の不変性・周期和・横辺差・縦辺差・所属・双対像・個数部分の必要十分版。
周期和では、出発点からの歩みが全点を覆い、一歩で値が変わらないことだけを残す。
自然数の帰納法という人手証明の手順を保ち、格子・有限和・剰余類・標数を仮定しない。
格子・辺・スピンを外し、値を保ち不動点を持たない対を与える写像と、同じ値を持つ元が
その対だけであることだけから、実現された値の原像が二元であることを示す
（写像が対合であることは使わないので仮定しない）。
-/
import Mathlib.Data.Finset.Card
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- 面の四項和から行和・列和の不変性を導く、本文の局所十七等号と有限和十六等号。
格子・巻き数・環は使わず、加法可換モノイド、有限添字とその全単射だけを残す。
自己和零は、局所で補う三項和と、再添字付け後に消す周期和だけに要求する。
これらを外すと対応する重複項が残る。全単射は有限和を同じ添字へ戻すために使う。 -/
theorem row_column_sum_invariant_necSuf {I J M : Type*}
    [Fintype I] [Fintype J] [AddCommMonoid M]
    (rowStep : I ≃ I) (columnStep : J ≃ J) (bh bv : I → J → M)
    (hface : ∀ i j, ((bv i j + bh i j) + bv i (columnStep j)) + bh (rowStep i) j = 0)
    (hrowFaceDouble : ∀ i j,
      ((bv i j + bh i j) + bv i (columnStep j)) +
        ((bv i j + bh i j) + bv i (columnStep j)) = 0)
    (hcolumnFaceDouble : ∀ i j,
      ((bv i j + bh i j) + bh (rowStep i) j) +
        ((bv i j + bh i j) + bh (rowStep i) j) = 0)
    (hrowSumDouble : ∀ i, (∑ j, bv i j) + (∑ j, bv i j) = 0)
    (hcolumnSumDouble : ∀ j, (∑ i, bh i j) + (∑ i, bh i j) = 0) :
    (∀ i, (∑ j, bh (rowStep i) j) = ∑ j, bh i j) ∧
      (∀ j, (∑ i, bv i (columnStep j)) = ∑ i, bv i j) := by
  have hrowFace (i : I) (j : J) : bh (rowStep i) j =
      (bv i j + bh i j) + bv i (columnStep j) := by
    let α := bv i j
    let β := bh i j
    let γ := bv i (columnStep j)
    let δ := bh (rowStep i) j
    calc
      bh (rowStep i) j = δ := rfl
      _ = δ + 0 := (add_zero _).symm
      _ = δ + (((α + β) + γ) + ((α + β) + γ)) :=
        congrArg (δ + ·) (hrowFaceDouble i j).symm
      _ = (δ + ((α + β) + γ)) + ((α + β) + γ) := (add_assoc _ _ _).symm
      _ = (((α + β) + γ) + δ) + ((α + β) + γ) := by
        rw [add_comm δ ((α + β) + γ)]
      _ = 0 + ((α + β) + γ) :=
        congrArg (· + ((α + β) + γ)) (hface i j)
      _ = (α + β) + γ := zero_add _
      _ = (bv i j + bh i j) + bv i (columnStep j) := rfl
  have hcolumnFace (i : I) (j : J) : bv i (columnStep j) =
      (bv i j + bh i j) + bh (rowStep i) j := by
    let α := bv i j
    let β := bh i j
    let γ := bv i (columnStep j)
    let δ := bh (rowStep i) j
    calc
      bv i (columnStep j) = γ := rfl
      _ = γ + 0 := (add_zero _).symm
      _ = γ + (((α + β) + δ) + ((α + β) + δ)) :=
        congrArg (γ + ·) (hcolumnFaceDouble i j).symm
      _ = (γ + ((α + β) + δ)) + ((α + β) + δ) := (add_assoc _ _ _).symm
      _ = ((γ + (α + β)) + δ) + ((α + β) + δ) := by
        rw [← add_assoc γ (α + β) δ]
      _ = (((α + β) + γ) + δ) + ((α + β) + δ) := by
        rw [add_comm γ (α + β)]
      _ = 0 + ((α + β) + δ) :=
        congrArg (· + ((α + β) + δ)) (hface i j)
      _ = (α + β) + δ := zero_add _
      _ = (bv i j + bh i j) + bh (rowStep i) j := rfl
  have hrowShift (j : J) : (∑ i, bh (rowStep i) j) = ∑ i, bh i j := by
    exact Fintype.sum_bijective rowStep rowStep.bijective
      (fun i => bh (rowStep i) j) (fun i => bh i j) (fun _ => rfl)
  have hcolumnShift (i : I) : (∑ j, bv i (columnStep j)) = ∑ j, bv i j := by
    exact Fintype.sum_bijective columnStep columnStep.bijective
      (fun j => bv i (columnStep j)) (fun j => bv i j) (fun _ => rfl)
  constructor
  · intro i
    calc
      (∑ j, bh (rowStep i) j) = ∑ j, ((bv i j + bh i j) + bv i (columnStep j)) :=
        Finset.sum_congr rfl (fun j _ => hrowFace i j)
      _ = (∑ j, (bv i j + bh i j)) + ∑ j, bv i (columnStep j) :=
        Finset.sum_add_distrib
      _ = ((∑ j, bv i j) + ∑ j, bh i j) + ∑ j, bv i (columnStep j) := by
        rw [Finset.sum_add_distrib]
      _ = ((∑ j, bv i j) + ∑ j, bh i j) + ∑ j, bv i j := by rw [hcolumnShift]
      _ = (∑ j, bv i j) + ((∑ j, bh i j) + ∑ j, bv i j) := add_assoc _ _ _
      _ = (∑ j, bv i j) + ((∑ j, bv i j) + ∑ j, bh i j) := by
        rw [add_comm (∑ j, bh i j) (∑ j, bv i j)]
      _ = ((∑ j, bv i j) + ∑ j, bv i j) + ∑ j, bh i j := (add_assoc _ _ _).symm
      _ = 0 + ∑ j, bh i j := by rw [hrowSumDouble]
      _ = ∑ j, bh i j := zero_add _
  · intro j
    calc
      (∑ i, bv i (columnStep j)) = ∑ i, ((bv i j + bh i j) + bh (rowStep i) j) :=
        Finset.sum_congr rfl (fun i _ => hcolumnFace i j)
      _ = (∑ i, (bv i j + bh i j)) + ∑ i, bh (rowStep i) j :=
        Finset.sum_add_distrib
      _ = ((∑ i, bv i j) + ∑ i, bh i j) + ∑ i, bh (rowStep i) j := by
        rw [Finset.sum_add_distrib]
      _ = ((∑ i, bv i j) + ∑ i, bh i j) + ∑ i, bh i j := by rw [hrowShift]
      _ = (∑ i, bv i j) + ((∑ i, bh i j) + ∑ i, bh i j) := add_assoc _ _ _
      _ = (∑ i, bv i j) + 0 := by rw [hcolumnSumDouble]
      _ = ∑ i, bv i j := add_zero _

/-- 周期境界では末尾の和へ一項を足すと周期和となる。使うのは加法モノイドの法則と、
二点の道和表示、次の代表が零であること、末尾分離、周期和零、基点と末尾項の自己和零だけ。
自己和零はそれぞれ二重の基点と末尾項を消すため、周期和零は末尾の和を一項へ戻すために要る。
交換則、逆元、環、格子は使わない。 -/
theorem periodic_path_prefix_difference_necSuf {X M : Type*} [AddMonoid M]
    (path : X → M) (index : X → ℕ) (partialSum f : ℕ → M) (base : M)
    (x y : X) (length : ℕ)
    (hpathX : path x = base + partialSum (index x))
    (hpathY : path y = base + partialSum (index y))
    (hindex : index y = 0) (hlast : index x + 1 = length)
    (hzero : partialSum 0 = 0)
    (hsucc : partialSum (index x + 1) = partialSum (index x) + f (index x))
    (hperiod : partialSum length = 0)
    (hbase : base + base = 0) (hterm : f (index x) + f (index x) = 0) :
    path y + path x = f (index x) := by
  have hprefix : partialSum (index x) = f (index x) := by
    calc
      partialSum (index x) = partialSum (index x) + 0 := (add_zero _).symm
      _ = partialSum (index x) + (f (index x) + f (index x)) :=
        congrArg (partialSum (index x) + ·) hterm.symm
      _ = (partialSum (index x) + f (index x)) + f (index x) :=
        (add_assoc _ _ _).symm
      _ = partialSum (index x + 1) + f (index x) :=
        congrArg (· + f (index x)) hsucc.symm
      _ = partialSum length + f (index x) := by rw [hlast]
      _ = 0 + f (index x) := congrArg (· + f (index x)) hperiod
      _ = f (index x) := zero_add _
  calc
    path y + path x = (base + partialSum (index y)) + (base + partialSum (index x)) :=
      congrArg₂ (· + ·) hpathY hpathX
    _ = (base + partialSum 0) + (base + partialSum (index x)) := by rw [hindex]
    _ = (base + 0) + (base + partialSum (index x)) := by rw [hzero]
    _ = base + (base + partialSum (index x)) := by rw [add_zero]
    _ = (base + base) + partialSum (index x) := (add_assoc _ _ _).symm
    _ = 0 + partialSum (index x) := congrArg (· + partialSum (index x)) hbase
    _ = partialSum (index x) := zero_add _
    _ = f (index x) := hprefix

/-- 非境界の道和差は、添字が一つ増すことと、加法の結合・交換・零元、
重複する道和の自己和が零であることだけを使う。格子、環、乗法、逆元は不要である。
自己和の仮定を外すと、例えば自然数の加法で重複する道和が残る。 -/
theorem path_prefix_difference_necSuf {X M : Type*} [AddCommMonoid M]
    (path : X → M) (index : X → ℕ) (f : ℕ → M) (base : M) (x y : X)
    (hpathX : path x = base + ∑ c ∈ range (index x), f c)
    (hpathY : path y = base + ∑ c ∈ range (index y), f c)
    (hindex : index y = index x + 1)
    (hdouble : (base + ∑ c ∈ range (index x), f c) +
      (base + ∑ c ∈ range (index x), f c) = 0) :
    path y + path x = f (index x) := by
  let H : ℕ → M := fun m => ∑ c ∈ range m, f c
  calc
    path y + path x = (base + H (index y)) + (base + H (index x)) :=
      congrArg₂ (· + ·) hpathY hpathX
    _ = (base + H (index x + 1)) + (base + H (index x)) := by rw [hindex]
    _ = (base + (H (index x) + f (index x))) + (base + H (index x)) := by
      rw [show H (index x + 1) = H (index x) + f (index x) from
        Finset.sum_range_succ f (index x)]
    _ = ((base + H (index x)) + f (index x)) + (base + H (index x)) := by
      rw [← add_assoc base (H (index x)) (f (index x))]
    _ = (base + H (index x)) + (f (index x) + (base + H (index x))) :=
      add_assoc _ _ _
    _ = (base + H (index x)) + ((base + H (index x)) + f (index x)) :=
      congrArg ((base + H (index x)) + ·) (add_comm (f (index x)) (base + H (index x)))
    _ = ((base + H (index x)) + (base + H (index x))) + f (index x) :=
      (add_assoc _ _ _).symm
    _ = 0 + f (index x) := congrArg (· + f (index x)) hdouble
    _ = f (index x) := zero_add _

/-- 横辺を解いた面等式へ同じ横辺を足して消す。必要なのは加法の法則とその横辺の自己和零だけ。 -/
theorem face_pair_necSuf {M : Type*} [AddCommMonoid M]
    (a b c d : M) (hface : d = (a + b) + c) (hdouble : b + b = 0) :
    d + b = c + a := by
  calc
    d + b = ((a + b) + c) + b := congrArg (· + b) hface
    _ = (a + b) + (c + b) := add_assoc _ _ _
    _ = (a + b) + (b + c) := by rw [add_comm c b]
    _ = ((a + b) + b) + c := (add_assoc _ _ _).symm
    _ = (a + (b + b)) + c := by rw [add_assoc a b b]
    _ = (a + 0) + c := by rw [hdouble]
    _ = a + c := by rw [add_zero]
    _ = c + a := add_comm _ _

/-- 隣接二項の望遠鏡和を自然数の帰納法で示す。自己和零は各項にだけ要求し、
環、乗法、逆元、格子を仮定しない。自己和零を外すと中間項が残る。 -/
theorem adjacent_pairs_sum_necSuf {M : Type*} [AddCommMonoid M]
    (f : ℕ → M) (hdouble : ∀ k : ℕ, f k + f k = 0) (m : ℕ) :
    (∑ c ∈ range m, (f (c + 1) + f c)) = f m + f 0 := by
  induction m with
  | zero =>
      calc
        (∑ c ∈ range 0, (f (c + 1) + f c)) = 0 := Finset.sum_range_zero _
        _ = f 0 + f 0 := (hdouble 0).symm
  | succ k ih =>
      calc
        (∑ c ∈ range (k + 1), (f (c + 1) + f c)) =
            (∑ c ∈ range k, (f (c + 1) + f c)) + (f (k + 1) + f k) :=
          Finset.sum_range_succ _ k
        _ = (f k + f 0) + (f (k + 1) + f k) := by rw [ih]
        _ = f k + (f 0 + (f (k + 1) + f k)) := add_assoc _ _ _
        _ = f k + ((f 0 + f (k + 1)) + f k) := by rw [← add_assoc (f 0)]
        _ = f k + (f k + (f 0 + f (k + 1))) := by rw [add_comm (f 0 + f (k + 1)) (f k)]
        _ = (f k + f k) + (f 0 + f (k + 1)) := (add_assoc _ _ _).symm
        _ = 0 + (f 0 + f (k + 1)) := by rw [hdouble k]
        _ = f 0 + f (k + 1) := zero_add _
        _ = f (k + 1) + f 0 := add_comm _ _

/-- 非境界の縦辺差の二十二等号。道和表示、代表の増分、末尾分離、
隣接する横辺二項の表示、端点の評価、重複項の自己和零だけを残す。
周期和零と巻き付き偶奇は使わない。 -/
theorem vertical_path_difference_necSuf {M : Type*} [AddCommMonoid M]
    (pathNext pathCurrent : M) (V v nextRow currentRow f : ℕ → M)
    (n nextN m : ℕ) (initial terminal : M)
    (hpathNext : pathNext = V nextN + ∑ c ∈ range m, nextRow c)
    (hpathCurrent : pathCurrent = V n + ∑ c ∈ range m, currentRow c)
    (hindex : nextN = n + 1) (hsucc : V (n + 1) = V n + v n)
    (hterm : v n = initial) (hdoubleV : V n + V n = 0)
    (hpair : ∀ c : ℕ, nextRow c + currentRow c = f (c + 1) + f c)
    (hdoubleF : ∀ c : ℕ, f c + f c = 0)
    (hterminal : f m = terminal) (hinitial : f 0 = initial) :
    pathNext + pathCurrent = terminal := by
  let Hnext := ∑ c ∈ range m, nextRow c
  let Hcurrent := ∑ c ∈ range m, currentRow c
  have hdoubleInitial : initial + initial = 0 := by rw [← hinitial]; exact hdoubleF 0
  calc
    pathNext + pathCurrent = (V nextN + Hnext) + (V n + Hcurrent) :=
      congrArg₂ (· + ·) hpathNext hpathCurrent
    _ = (V (n + 1) + Hnext) + (V n + Hcurrent) := by rw [hindex]
    _ = ((V n + v n) + Hnext) + (V n + Hcurrent) := by rw [hsucc]
    _ = ((V n + initial) + Hnext) + (V n + Hcurrent) := by rw [hterm]
    _ = (V n + (initial + Hnext)) + (V n + Hcurrent) := by rw [add_assoc (V n) initial]
    _ = V n + ((initial + Hnext) + (V n + Hcurrent)) := add_assoc _ _ _
    _ = V n + (((initial + Hnext) + V n) + Hcurrent) := by rw [← add_assoc (initial + Hnext)]
    _ = V n + ((V n + (initial + Hnext)) + Hcurrent) := by rw [add_comm (initial + Hnext) (V n)]
    _ = V n + (V n + ((initial + Hnext) + Hcurrent)) := by rw [add_assoc (V n) (initial + Hnext)]
    _ = (V n + V n) + ((initial + Hnext) + Hcurrent) := (add_assoc _ _ _).symm
    _ = 0 + ((initial + Hnext) + Hcurrent) := by rw [hdoubleV]
    _ = (initial + Hnext) + Hcurrent := zero_add _
    _ = initial + (Hnext + Hcurrent) := add_assoc _ _ _
    _ = initial + ∑ c ∈ range m, (nextRow c + currentRow c) := by
      dsimp only [Hnext, Hcurrent]
      rw [← Finset.sum_add_distrib]
    _ = initial + ∑ c ∈ range m, (f (c + 1) + f c) :=
      congrArg (initial + ·) (Finset.sum_congr rfl (fun c _ => hpair c))
    _ = initial + (f m + f 0) := congrArg (initial + ·) (adjacent_pairs_sum_necSuf f hdoubleF m)
    _ = initial + (terminal + f 0) := by rw [hterminal]
    _ = initial + (terminal + initial) := by rw [hinitial]
    _ = initial + (initial + terminal) := congrArg (initial + ·) (add_comm _ _)
    _ = (initial + initial) + terminal := (add_assoc _ _ _).symm
    _ = 0 + terminal := by rw [hdoubleInitial]
    _ = terminal := zero_add _

/-- 縦辺の周期境界では、末尾の和を周期和零で一項へ戻した後、横辺二項の望遠鏡和を使う。
必要なのは加法可換モノイド、二点の道和表示、次の代表が零であること、空和・末尾分離・
周期和零・端点の評価・各項の自己和零である。周期和零を外すと末尾の和に周期の寄与が残り、
自己和零を外すと望遠鏡和の中間項が残る。環・乗法・逆元・格子は使わない。 -/
theorem vertical_periodic_path_difference_necSuf {M : Type*} [AddCommMonoid M]
    (pathNext pathCurrent : M) (V v nextRow currentRow f : ℕ → M)
    (n nextN m length : ℕ) (initial terminal : M)
    (hpathNext : pathNext = V nextN + ∑ c ∈ range m, nextRow c)
    (hpathCurrent : pathCurrent = V n + ∑ c ∈ range m, currentRow c)
    (hindex : nextN = 0) (hlast : n + 1 = length) (hzero : V 0 = 0)
    (hsucc : V (n + 1) = V n + v n) (hperiod : V length = 0)
    (hterm : v n = initial)
    (hpair : ∀ c : ℕ, nextRow c + currentRow c = f (c + 1) + f c)
    (hdoubleF : ∀ c : ℕ, f c + f c = 0)
    (hterminal : f m = terminal) (hinitial : f 0 = initial) :
    pathNext + pathCurrent = terminal := by
  let Hnext := ∑ c ∈ range m, nextRow c
  let Hcurrent := ∑ c ∈ range m, currentRow c
  have hdoubleInitial : initial + initial = 0 := by rw [← hinitial]; exact hdoubleF 0
  have hdoubleTerm : v n + v n = 0 := by rw [hterm]; exact hdoubleInitial
  have hprefix : V n = initial := by
    calc
      V n = V n + 0 := (add_zero _).symm
      _ = V n + (v n + v n) := congrArg (V n + ·) hdoubleTerm.symm
      _ = (V n + v n) + v n := (add_assoc _ _ _).symm
      _ = V (n + 1) + v n := congrArg (· + v n) hsucc.symm
      _ = V length + v n := by rw [hlast]
      _ = 0 + v n := congrArg (· + v n) hperiod
      _ = v n := zero_add _
      _ = initial := hterm
  calc
    pathNext + pathCurrent = (V nextN + Hnext) + (V n + Hcurrent) :=
      congrArg₂ (· + ·) hpathNext hpathCurrent
    _ = (V 0 + Hnext) + (V n + Hcurrent) := by rw [hindex]
    _ = (0 + Hnext) + (V n + Hcurrent) := by rw [hzero]
    _ = Hnext + (V n + Hcurrent) := by rw [zero_add]
    _ = Hnext + (initial + Hcurrent) := by rw [hprefix]
    _ = (Hnext + initial) + Hcurrent := (add_assoc _ _ _).symm
    _ = (initial + Hnext) + Hcurrent := by rw [add_comm Hnext initial]
    _ = initial + (Hnext + Hcurrent) := add_assoc _ _ _
    _ = initial + ∑ c ∈ range m, (nextRow c + currentRow c) := by
      dsimp only [Hnext, Hcurrent]
      rw [← Finset.sum_add_distrib]
    _ = initial + ∑ c ∈ range m, (f (c + 1) + f c) :=
      congrArg (initial + ·) (Finset.sum_congr rfl (fun c _ => hpair c))
    _ = initial + (f m + f 0) :=
      congrArg (initial + ·) (adjacent_pairs_sum_necSuf f hdoubleF m)
    _ = initial + (terminal + f 0) := by rw [hterminal]
    _ = initial + (terminal + initial) := by rw [hinitial]
    _ = initial + (initial + terminal) := congrArg (initial + ·) (add_comm _ _)
    _ = (initial + initial) + terminal := (add_assoc _ _ _).symm
    _ = 0 + terminal := by rw [hdoubleInitial]
    _ = terminal := zero_add _

/-- 指数の二場合を、それぞれの値へ代入する本文と同じ計算。
必要なのは代表が零か一であることと、評価写像のその二点での値だけである。
格子・剰余環・整数・乗法の構造は使わない。二場合の仮定を外すと他の指数の値を制限できない。 -/
theorem two_exponent_values_necSuf {M : Type*}
    (evaluate : ℕ → M) (zeroValue oneValue : M) (n : ℕ)
    (hcases : n = 0 ∨ n = 1)
    (hzero : evaluate 0 = zeroValue) (hone : evaluate 1 = oneValue) :
    evaluate n = zeroValue ∨ evaluate n = oneValue := by
  rcases hcases with hqzero | hqone
  · left
    calc
      evaluate n = evaluate 0 := congrArg evaluate hqzero
      _ = zeroValue := hzero
  · right
    calc
      evaluate n = evaluate 1 := congrArg evaluate hqone
      _ = oneValue := hone

/-- 出発点での値と一歩の不変性を、全点を覆う歩みに沿って帰納的に運ぶ。 -/
theorem constant_on_walk_necSuf {X Y : Type*}
    (walk : ℕ → X) (step : X → X) (base : X) (index : X → ℕ)
    (hstart : walk 0 = base)
    (hstep : ∀ n : ℕ, walk (n + 1) = step (walk n))
    (hcover : ∀ x : X, walk (index x) = x)
    (f : X → Y) (value : Y)
    (hbase : f base = value) (hinvariant : ∀ x : X, f (step x) = f x) :
    ∀ x : X, f x = value := by
  have haux : ∀ n : ℕ, f (walk n) = value := by
    intro n
    induction n with
    | zero =>
      calc
        f (walk 0) = f base := congrArg f hstart
        _ = value := hbase
    | succ n ih =>
      calc
        f (walk (n + 1)) = f (step (walk n)) := congrArg f (hstep n)
        _ = f (walk n) := hinvariant (walk n)
        _ = value := ih
  intro x
  calc
    f x = f (walk (index x)) := congrArg f (hcover x).symm
    _ = value := haux (index x)

/-- 二元の四場合を代入する所属判定。必要なのは入力の二場合、出力の二点での値、
出力二値の相異性、二項演算の四値だけである。加法・環・整数冪は使わない。
対角の場合に要る入力二値の相異性は、出力二値の相異性から導く。 -/
theorem two_value_disagreement_necSuf {P S : Type*}
    (zeroValue oneValue : P) (evaluate : P → S) (sZero sOne : S)
    (combine : P → P → P)
    (hcover : ∀ a : P, a = zeroValue ∨ a = oneValue)
    (houtput : sZero ≠ sOne)
    (hevalZero : evaluate zeroValue = sZero) (hevalOne : evaluate oneValue = sOne)
    (hzz : combine zeroValue zeroValue = zeroValue)
    (hzo : combine zeroValue oneValue = oneValue)
    (hoz : combine oneValue zeroValue = oneValue)
    (hoo : combine oneValue oneValue = zeroValue)
    (a b : P) : evaluate a ≠ evaluate b ↔ combine a b = oneValue := by
  have hinput : zeroValue ≠ oneValue := by
    intro h
    apply houtput
    calc
      sZero = evaluate zeroValue := hevalZero.symm
      _ = evaluate oneValue := congrArg evaluate h
      _ = sOne := hevalOne
  rcases hcover a with rfl | rfl <;> rcases hcover b with rfl | rfl
  · simp only [hevalZero, hzz, ne_self_iff_false, hinput]
  · rw [hevalZero, hevalOne, hzo]
    exact ⟨fun _ => rfl, fun _ => houtput⟩
  · rw [hevalOne, hevalZero, hoz]
    exact ⟨fun _ => rfl, fun _ => Ne.symm houtput⟩
  · simp only [hevalOne, hoo, ne_self_iff_false, hinput]

/-- 所属の同値列で二つの有限集合を等置する。端点スピンと評価値の一致は定義の代入、
評価値の不一致の判定は四場合、端点値の演算結果は先に証明した道和差から供給する。
格子・道・環は不要で、零と一に相当する二値の相異性だけが最後の所属判定に要る。 -/
theorem reconstructed_membership_necSuf {E V P S : Type*} [DecidableEq E]
    (broken original : Finset E) (source target : E → V)
    (spin : V → S) (path : V → P) (evaluate : P → S)
    (combine : P → P → P) (zeroValue oneValue : P)
    (hvalues : zeroValue ≠ oneValue)
    (hbroken : ∀ e : E, e ∈ broken ↔ spin (source e) ≠ spin (target e))
    (hspin : ∀ v : V, spin v = evaluate (path v))
    (hdisagree : ∀ a b : P, evaluate a ≠ evaluate b ↔ combine a b = oneValue)
    (hpath : ∀ e : E, combine (path (source e)) (path (target e)) =
      if e ∈ original then oneValue else zeroValue) : broken = original := by
  ext e
  calc
    e ∈ broken ↔ spin (source e) ≠ spin (target e) := hbroken e
    _ ↔ evaluate (path (source e)) ≠ evaluate (path (target e)) := by rw [hspin, hspin]
    _ ↔ combine (path (source e)) (path (target e)) = oneValue := hdisagree _ _
    _ ↔ (if e ∈ original then oneValue else zeroValue) = oneValue := by rw [hpath]
    _ ↔ e ∈ original := by
      by_cases he : e ∈ original <;> simp [he, hvalues]

/-- 双対像の二等号。所属で得た等号を像へ運び、逆像との往復で元へ戻す。
写像の全単射性全体は使わず、この部分集合での往復等号だけを仮定する。 -/
theorem reconstructed_image_necSuf {E F : Type*} [DecidableEq F]
    (forward : E → F) (broken original : Finset E) (image : Finset F)
    (hmembership : broken = original) (hroundtrip : original.image forward = image) :
    broken.image forward = image := by
  calc
    broken.image forward = original.image forward :=
      congrArg (fun B => B.image forward) hmembership
    _ = image := hroundtrip

/-- 共通の像から二点を復元する四等号。逆写像の大域的な性質は不要で、
対象二点での往復と、その二点の像が共通であることだけを使う。 -/
theorem recover_eq_of_common_image_necSuf {X Y : Type*}
    (forward : X → Y) (backward : Y → X) (a b : X) (z : Y)
    (ha : backward (forward a) = a) (hb : backward (forward b) = b)
    (hfa : forward a = z) (hfb : forward b = z) : a = b := by
  calc
    a = backward (forward a) := ha.symm
    _ = backward z := congrArg backward hfa
    _ = backward (forward b) := congrArg backward hfb.symm
    _ = b := hb

/-- 原像を二点集合と等置して個数を計算する。必要なのは二点の相異、像の保存、
原像の二択だけであり、反転写像全体の対合性は使わない。 -/
theorem paired_fiber_card_two_necSuf {α β : Type*}
    [Fintype α] [DecidableEq α] [DecidableEq β]
    (g : α → β) (ν : α → α) (x : α)
    (hne : ν x ≠ x)
    (hpreserve : g (ν x) = g x)
    (hunique : ∀ y : α, g y = g x → y = x ∨ y = ν x) :
    (univ.filter fun y : α => g y = g x).card = 2 := by
  have hfiber :
      univ.filter (fun y : α => g y = g x) = {x, ν x} := by
    ext y
    simp only [mem_filter, mem_univ, true_and, mem_insert, mem_singleton]
    constructor
    · exact hunique y
    · intro hy
      rcases hy with rfl | rfl
      · rfl
      · exact hpreserve
  calc
    (univ.filter fun y : α => g y = g x).card = ({x, ν x} : Finset α).card :=
      congrArg card hfiber
    _ = ({ν x} : Finset α).card + 1 :=
      card_insert_of_notMem (by simpa only [mem_singleton] using hne.symm)
    _ = 1 + 1 := congrArg (fun n : ℕ => n + 1) (card_singleton _)
    _ = 2 := rfl

end Ising2DLambda.NecSuf.FisherZero
