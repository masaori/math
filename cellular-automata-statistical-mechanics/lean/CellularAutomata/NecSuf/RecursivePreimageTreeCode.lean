/-
章「周期成分に付随する再帰的前像木符号の完全性」の必要十分版のうち、
完全不変量と有限決定の段。

具体版（`CellularAutomata.RecursivePreimageTreeCode` の節 `CompleteInvariant`）と
同じ手順を保つ。すなわち、完全性（符号の等号から共役全単射を構成する）と
共役不変性（共役全単射から符号の等号を得る）の二つの含意を合わせて同値を作り、
その同値を通して共役全単射の存在の判定を符号の等号の判定へ移し、
等号の場合に構成した全単射を一つ固定して `Option` の値として返す。

実際に使う構造は次だけである。

* 同値の構成には、二つの型 X, Y、その上の自己写像 F, G、符号型 C の二つの値
  cX, cY、および上記二つの含意だけが要る。X, Y の有限性・等号判定、
  符号型が多重集合であること、符号が再帰的に作られたことは使わない。
* 共役全単射の存在の判定には、さらに符号型 C の等号判定だけを足す。
  具体版が使う「全単射を全数走査しないで済む」という性質は、この同値と
  C の等号判定だけから出る。X, Y の有限性はここでも要らない。
* 一致時の全単射の固定には、C の等号判定と、等号から全単射を作る写像だけが要る。
  その写像が共役条件を満たすことは、`isSome` と存在の同値には使わない
  （具体版でも使っていない）。

具体版の符号型は `Multiset (Finset (List ℕ))` であり、その等号判定は選択公理を
使わずに得られる。この事実だけが有限決定の中身であることを
`mapCodeTypeDecidableEq` で明示する。

二値状態、セル、近傍、局所規則、前像木の内部構造、周期成分、R / C は使わない。
-/

import Mathlib.Logic.Equiv.Defs
import Mathlib.Logic.Equiv.Basic
import Mathlib.Logic.Equiv.List
import Mathlib.Data.Multiset.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Image
import Mathlib.Data.Finset.Range
import Mathlib.Data.Multiset.Sort
import Mathlib.Data.Multiset.Fintype

namespace CellularAutomata.NecSuf.RecursivePreimageTreeCode

variable {X Y C : Type}

/-- 共役全単射の存在。具体版の結論と同じ形に固定する。 -/
def HasConjugacy (F : X → X) (G : Y → Y) : Prop :=
  ∃ h : X ≃ Y, ∀ x, h (F x) = G (h x)

/-- 完全不変量。要るのは完全性と不変性の二つの含意だけであり、
符号型の等号判定も型の有限性も使わない。 -/
theorem code_eq_iff_hasConjugacy (F : X → X) (G : Y → Y) (cX cY : C)
    (hcomplete : cY = cX → HasConjugacy F G)
    (hinvariant : HasConjugacy F G → cY = cX) :
    cY = cX ↔ HasConjugacy F G :=
  ⟨hcomplete, hinvariant⟩

/-- 符号の等号の判定に要るのは符号型の等号判定だけである。
自己写像も型の有限性も使わないので、引数に取らない。 -/
def codeEqualityDecidable [DecidableEq C] (cX cY : C) : Decidable (cY = cX) :=
  ‹DecidableEq C› cY cX

/-- 共役全単射の存在の判定。符号型の等号判定と完全不変量の同値だけを使い、
全単射 X ≃ Y を全数走査しない。X, Y の有限性・等号判定は使わない。 -/
def hasConjugacyDecidable [DecidableEq C] (F : X → X) (G : Y → Y) (cX cY : C)
    (hiff : cY = cX ↔ HasConjugacy F G) :
    Decidable (HasConjugacy F G) :=
  letI : Decidable (cY = cX) := codeEqualityDecidable cX cY
  decidable_of_iff (cY = cX) hiff

/-- 符号の等号の判定が一致を返したときに固定する全単射。不一致なら `none`。
要るのは C の等号判定と、等号から全単射を作る写像だけである。 -/
def conjugacyFromDecision [DecidableEq C] (cX cY : C) (mk : cY = cX → X ≃ Y) :
    Option (X ≃ Y) :=
  if hc : cY = cX then some (mk hc) else none

/-- 符号が等しい場合に返る値は、与えた構成そのものである。 -/
theorem conjugacyFromDecision_eq_some [DecidableEq C] (cX cY : C)
    (mk : cY = cX → X ≃ Y) (hc : cY = cX) :
    conjugacyFromDecision cX cY mk = some (mk hc) := by
  simp [conjugacyFromDecision, hc]

/-- 判定が値を返すことと共役全単射の存在は同値である。
`mk` が共役条件を満たすことは使わない（具体版でも使っていない）。 -/
theorem conjugacyFromDecision_isSome_iff [DecidableEq C] (F : X → X) (G : Y → Y)
    (cX cY : C) (mk : cY = cX → X ≃ Y) (hiff : cY = cX ↔ HasConjugacy F G) :
    (conjugacyFromDecision cX cY mk).isSome ↔ HasConjugacy F G := by
  rw [← hiff]
  by_cases hc : cY = cX
  · simp [conjugacyFromDecision, hc]
  · simp [conjugacyFromDecision, hc]

/-- 具体版の符号型 `Multiset (Finset (List ℕ))` の等号判定。
上の判定はこの一つの性質しか使わず、選択公理を使わずに得られる。 -/
def mapCodeTypeDecidableEq : DecidableEq (Multiset (Finset (List ℕ))) :=
  inferInstance

end CellularAutomata.NecSuf.RecursivePreimageTreeCode

namespace CellularAutomata.NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance

/-!
共役不変性のうち、再帰的前像木符号を深さごとに保存する段の必要十分版。

具体版の証明が実際に使うのは、二つの有限子表、両表を全単射に移す写像、
および「子の符号を重複込みで集め、整列した有限列を自然数へ符号化する」
同一の再帰だけである。自己写像、周期点、最小前周期、二値状態、セル、
近傍、局所規則、型全体の有限性、R / C はこの段では使わない。
-/

variable {X Y : Type} [DecidableEq X] [DecidableEq Y]

/-- 有限子表だけから作る、深さを打ち切った再帰符号。 -/
noncomputable def codeAtDepth (children : X → Finset X) : ℕ → X → ℕ
  | 0, _ => Encodable.encode ([] : List ℕ)
  | depth + 1, x =>
      Encodable.encode
        (((children x).val.map (codeAtDepth children depth)).sort (· ≤ ·))

/-- 子表を全単射に移す写像は、全ての打ち切り深さで再帰符号を保存する。
型全体の有限性は要らず、各点の子表が有限であることだけを使う。 -/
theorem codeAtDepth_transport (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    (h : X ≃ Y) (hchildren : ∀ x, (childrenX x).image h = childrenY (h x))
    (depth : ℕ) (x : X) :
    codeAtDepth childrenY depth (h x) = codeAtDepth childrenX depth x := by
  induction depth generalizing x with
  | zero => rfl
  | succ depth ih =>
      simp only [codeAtDepth]
      congr 1
      have hval : (childrenY (h x)).val = (childrenX x).val.map h := by
        rw [← hchildren x]
        exact Finset.image_val_of_injOn h.injective.injOn
      rw [hval, Multiset.map_map]
      congr 1
      exact Multiset.map_congr rfl fun z _ => ih z

/-- 各点に付く残り深さ `bound - level x` で打ち切って得る完成符号。 -/
noncomputable def completedCode (children : X → Finset X) (bound : ℕ)
    (level : X → ℕ) (x : X) : ℕ :=
  codeAtDepth children (bound - level x) x

/-- 残り深さ以上へ打ち切りを延ばしても完成符号は変わらない。
実際に使うのは「子では level がちょうど一つ増える」ことと
「level は bound を越えない」ことだけであり、型全体の有限性、自己写像、
周期点、level が最小前周期であることは使わない。 -/
theorem codeAtDepth_eq_completedCode_of_remaining_le
    (children : X → Finset X) (bound : ℕ) (level : X → ℕ)
    (hchild : ∀ x z, z ∈ children x → level z = level x + 1)
    (hlevel : ∀ x, level x ≤ bound)
    (x : X) (depth : ℕ) (hdepth : bound - level x ≤ depth) :
    codeAtDepth children depth x = completedCode children bound level x := by
  generalize hremaining : bound - level x = remaining at hdepth ⊢
  induction remaining using Nat.strong_induction_on generalizing x depth with
  | h remaining ih =>
      by_cases hzero : remaining = 0
      · have hchildren : children x = ∅ := by
          rw [Finset.eq_empty_iff_forall_notMem]
          intro z hz
          have hzlevel := hchild x z hz
          have hzbound := hlevel z
          omega
        cases depth with
        | zero => simp [completedCode, hremaining, hzero]
        | succ depth =>
            have hempty : codeAtDepth children (depth + 1) x
                = codeAtDepth children 0 x := by
              simp only [codeAtDepth, hchildren]
              congr 1
              simp
            rw [hempty]
            simp [completedCode, hremaining, hzero]
      · obtain ⟨remaining', hremainingSucc⟩ := Nat.exists_eq_succ_of_ne_zero hzero
        rw [hremainingSucc] at hdepth
        obtain ⟨depth', hdepthEq⟩ := Nat.exists_eq_add_of_le hdepth
        subst depth
        rw [Nat.succ_add]
        simp only [codeAtDepth, completedCode, hremaining, hremainingSucc]
        congr 1
        congr 1
        apply Multiset.map_congr rfl
        intro z hz
        have hzfin : z ∈ children x := hz
        have hzlevel := hchild x z hzfin
        have hzremaining : bound - level z = remaining' := by omega
        calc
          codeAtDepth children (remaining' + depth') z
              = completedCode children bound level z :=
            ih remaining' (by omega) z (remaining' + depth')
              hzremaining (Nat.le_add_right remaining' depth')
          _ = codeAtDepth children remaining' z := by
            rw [completedCode, hzremaining]

/-- 子表を全単射に移し、`level` を保存し、`bound` が一致するなら、
完成符号も保存される。型全体の有限性も自己写像も使わない。 -/
theorem completedCode_transport (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    (h : X ≃ Y) (hchildren : ∀ x, (childrenX x).image h = childrenY (h x))
    (boundX boundY : ℕ) (hbound : boundX = boundY)
    (levelX : X → ℕ) (levelY : Y → ℕ) (hlevel : ∀ x, levelY (h x) = levelX x)
    (x : X) :
    completedCode childrenY boundY levelY (h x)
      = completedCode childrenX boundX levelX x := by
  simp only [completedCode, hlevel x, ← hbound]
  exact codeAtDepth_transport childrenX childrenY h hchildren _ x

/-- 選んだ周期一周に沿って点符号を読み取った有限語。
定義に入るのは周期長、反復列、点符号だけである。 -/
def baseWord (period : X → ℕ) (iterate : ℕ → X → X) (code : X → ℕ)
    (x : X) : List ℕ :=
  List.ofFn fun n : Fin (period x) => code (iterate n x)

/-- 全単射が周期長、各反復、点符号を保存するなら基点語も保存する。
有限性、自己写像の反復則、周期性、点符号の再帰構成は使わない。 -/
theorem baseWord_transport (periodX : X → ℕ) (periodY : Y → ℕ)
    (iterateX : ℕ → X → X) (iterateY : ℕ → Y → Y)
    (codeX : X → ℕ) (codeY : Y → ℕ) (h : X ≃ Y)
    (hperiod : ∀ x, periodY (h x) = periodX x)
    (hiterate : ∀ n x, h (iterateX n x) = iterateY n (h x))
    (hcode : ∀ x, codeY (h x) = codeX x) (x : X) :
    baseWord periodY iterateY codeY (h x) = baseWord periodX iterateX codeX x := by
  simp only [baseWord, hperiod x]
  congr 1
  funext n
  simp only [Fin.val_cast]
  rw [← hiterate (n : ℕ) x, hcode]


/-- 周期長と反復列だけから作る、一周期分の有限表。
自己写像であること、周期性、点符号は定義に入らない。 -/
def periodicOrbit (period : X → ℕ) (iterate : ℕ → X → X) (x : X) : Finset X :=
  (Finset.range (period x)).image fun n => iterate n x

/-- 全単射が周期長と各反復を保存するなら、一周期分の有限表を全単射に移す。
型の有限性、自己写像の反復則、周期性は使わない。 -/
theorem image_periodicOrbit (periodX : X → ℕ) (periodY : Y → ℕ)
    (iterateX : ℕ → X → X) (iterateY : ℕ → Y → Y) (h : X ≃ Y)
    (hperiod : ∀ x, periodY (h x) = periodX x)
    (hiterate : ∀ n x, h (iterateX n x) = iterateY n (h x)) (x : X) :
    (periodicOrbit periodX iterateX x).image h
      = periodicOrbit periodY iterateY (h x) := by
  simp only [periodicOrbit, hperiod x, Finset.image_image]
  exact Finset.image_congr fun n _ => hiterate n x

/-- 有限表とその上の付値だけから作る成分符号。
付値の値の型に要るのは等号判定だけであり、有限列であることは使わない。 -/
def componentCode {L : Type} [DecidableEq L] (orbit : X → Finset X) (word : X → L)
    (x : X) : Finset L :=
  (orbit x).image word

/-- 全単射が有限表を移し付値を保存するなら、成分符号も保存される。
型全体の有限性、自己写像、周期性、付値が基点語であることは使わない。 -/
theorem componentCode_transport {L : Type} [DecidableEq L]
    (orbitX : X → Finset X) (orbitY : Y → Finset Y)
    (wordX : X → L) (wordY : Y → L) (h : X ≃ Y)
    (horbit : ∀ x, (orbitX x).image h = orbitY (h x))
    (hword : ∀ x, wordY (h x) = wordX x) (x : X) :
    componentCode orbitY wordY (h x) = componentCode orbitX wordX x := by
  simp only [componentCode]
  rw [← horbit x, Finset.image_image]
  exact Finset.image_congr fun r _ => hword r

omit [DecidableEq X] [DecidableEq Y] in
/-- 二つの有限表の付値の像が等しいとき、左表で指定した元の付値と
等しい付値を持つ元を右表から選べる。要るのは二つの有限表、二つの付値、
左表の元の所属、および像の等号だけである。型全体の有限性、自己写像、
周期性、付値が基点語であることは使わない。付値型の等号判定は
`Finset.image` の構成にだけ要る。 -/
theorem exists_value_eq_of_componentCode_eq {L : Type} [DecidableEq L]
    (orbitX : X → Finset X) (orbitY : Y → Finset Y)
    (wordX : X → L) (wordY : Y → L) (x : X) (y : Y)
    (hx : x ∈ orbitX x)
    (hcode : componentCode orbitY wordY y = componentCode orbitX wordX x) :
    ∃ y' : Y, y' ∈ orbitY y ∧ wordY y' = wordX x := by
  have hword : wordX x ∈ componentCode orbitX wordX x :=
    Finset.mem_image.mpr ⟨x, hx, rfl⟩
  rw [← hcode] at hword
  exact Finset.mem_image.mp hword

/-- 有限表の各元へ付けた符号を、重複度を保つ有限多重集合へ集める。
型全体の有限性、自己写像、周期軌道、符号の内部構造は使わない。 -/
def aggregateCode {O L : Type} (table : Finset O) (code : O → L) : Multiset L :=
  table.val.map code

/-- 有限表を単射で移し、表の各元に付く符号を保存するなら、
重複度を含む集約符号も保存される。要るのは有限表、単射、各元の符号保存だけである。 -/
theorem aggregateCode_transport {OX OY L : Type} [DecidableEq OX] [DecidableEq OY]
    (tableX : Finset OX) (tableY : Finset OY) (move : OX → OY)
    (hmove : Function.Injective move) (htable : tableX.image move = tableY)
    (codeX : OX → L) (codeY : OY → L)
    (hcode : ∀ o, o ∈ tableX → codeY (move o) = codeX o) :
    aggregateCode tableY codeY = aggregateCode tableX codeX := by
  rw [← htable]
  simp only [aggregateCode, Finset.image_val_of_injOn hmove.injOn, Multiset.map_map]
  exact Multiset.map_congr rfl fun o ho => hcode o ho

/-- 多重集合の出現型の元が表す値は、その多重集合に属する。
要るのは多重集合一つと、その出現型を作るための元の等号判定だけであり、
写像・符号・型全体の有限性は使わない。 -/
theorem occurrenceValue_mem {O : Type} [DecidableEq O] (s : Multiset O) (o : s) : (o : O) ∈ s :=
  Multiset.coe_mem

/-- 二つの多重集合を符号で写した結果が等しければ、出現どうしの全単射で
符号を保つものが取れる。出現型を使うので、同じ符号を持つ相異なる元の重複度を失わない。
要るのは二つの多重集合、その上の二つの符号、および写した結果の等号だけであり、
表が有限集合から来ること、符号の内部構造、型全体の有限性は使わない。
落とせなかった仮定は三つの等号判定である。両側の元の等号判定は出現型を作るために要り、
符号の等号判定は、写した二つの多重集合の出現型の間の移送に要る。 -/
theorem exists_occurrence_equiv_of_map_eq {OX OY L : Type}
    [DecidableEq OX] [DecidableEq OY] [DecidableEq L]
    (s : Multiset OX) (t : Multiset OY) (codeX : OX → L) (codeY : OY → L)
    (hmap : s.map codeX = t.map codeY) :
    ∃ e : s ≃ t, ∀ o : s, codeY (e o) = codeX o := by
  let e : s ≃ t :=
    (s.mapEquiv codeX).trans (Multiset.cast hmap) |>.trans (t.mapEquiv codeY).symm
  refine ⟨e, fun o => ?_⟩
  have happly := Multiset.mapEquiv_apply t codeY
    ((t.mapEquiv codeY).symm ((Multiset.cast hmap) (s.mapEquiv codeX o)))
  simpa [e] using happly.symm

/-- 集約符号が等しければ、二つの有限表の出現を重複度つきで対応させる全単射が取れ、
対応する出現どうしで符号が一致する。`aggregateCode_transport` の逆向きの段であり、
要るのは二つの有限表、その上の二つの符号、集約符号の等号、
および上と同じ三つの等号判定だけである。
型全体の有限性、自己写像、周期軌道、符号の内部構造は使わない。 -/
theorem exists_occurrence_equiv_of_aggregateCode_eq {OX OY L : Type}
    [DecidableEq OX] [DecidableEq OY] [DecidableEq L]
    (tableX : Finset OX) (tableY : Finset OY) (codeX : OX → L) (codeY : OY → L)
    (hcode : aggregateCode tableY codeY = aggregateCode tableX codeX) :
    ∃ e : tableX.val ≃ tableY.val, ∀ o : tableX.val, codeY (e o) = codeX o :=
  exists_occurrence_equiv_of_map_eq tableX.val tableY.val codeX codeY
    (by simpa only [aggregateCode] using hcode.symm)

/-- 打ち切り深さ `depth + 1` の再帰符号が等しい二点では、
子表の一つ浅い符号を重複込みで集めた多重集合が等しい。
使うのは二つの子表と、`codeAtDepth` の後続段が
「子符号の多重集合を整列して有限列にし、それを符号化する」ことだけである。
型全体の有限性、自己写像、周期性、最小前周期、符号の外側の打ち切り規則は使わない。
落とせなかった仮定は両側の元の等号判定で、これは子表を `Finset` として持ち、
その台多重集合を写すために要る。 -/
theorem childCodeMultiset_eq_of_codeAtDepth_succ_eq
    (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    (depth : ℕ) (x : X) (y : Y)
    (hcode : codeAtDepth childrenY (depth + 1) y
      = codeAtDepth childrenX (depth + 1) x) :
    (childrenX x).val.map (codeAtDepth childrenX depth)
      = (childrenY y).val.map (codeAtDepth childrenY depth) := by
  simp only [codeAtDepth] at hcode
  have hsorted := Encodable.encode_injective hcode
  have hcoerced := congrArg (fun xs : List ℕ => (xs : Multiset ℕ)) hsorted.symm
  simpa only [Multiset.sort_eq] using hcoerced

/-- 打ち切り深さ `depth + 1` の再帰符号が等しい二点の子の出現には、
重複度を保ち一つ浅い符号を保存する全単射がある。
`childCodeMultiset_eq_of_codeAtDepth_succ_eq` と
`exists_occurrence_equiv_of_map_eq` の合成であり、
新たに要る構造はない。型全体の有限性、自己写像、周期性、二値状態、
セル、近傍、局所規則は使わない。 -/
theorem exists_child_occurrence_equiv_of_codeAtDepth_succ_eq
    (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    (depth : ℕ) (x : X) (y : Y)
    (hcode : codeAtDepth childrenY (depth + 1) y
      = codeAtDepth childrenX (depth + 1) x) :
    ∃ e : (childrenX x).val ≃ (childrenY y).val,
      ∀ z : (childrenX x).val,
        codeAtDepth childrenY depth (e z) = codeAtDepth childrenX depth z :=
  exists_occurrence_equiv_of_map_eq (childrenX x).val (childrenY y).val
    (codeAtDepth childrenX depth) (codeAtDepth childrenY depth)
    (childCodeMultiset_eq_of_codeAtDepth_succ_eq childrenX childrenY depth x y hcode)

/-- 深さ `depth` までの有限子表の再帰的対応。深さ零では条件を置かず、
後続段では子の出現を重複度つき全単射で対応させ、対応した子ごとに
一つ浅い対応を要求する。要るのは二つの有限子表だけであり、型全体の
有限性、自己写像、周期性、二値状態、セル、近傍、局所規則は使わない。 -/
def HasTreeMatching (childrenX : X → Finset X) (childrenY : Y → Finset Y) :
    (depth : ℕ) → X → Y → Prop
  | 0, _, _ => True
  | depth + 1, x, y =>
      ∃ e : (childrenX x).val ≃ (childrenY y).val,
        ∀ z : (childrenX x).val, HasTreeMatching childrenX childrenY depth z (e z)

/-- 等しい打ち切り再帰符号から、その深さ全体にわたる有限子表の対応を
深さ帰納法で構成できる。各後続段で使うのは、直前に分離した子出現対応と
一つ浅い帰納仮定だけである。型全体の有限性、自己写像、周期性、
最小前周期、二値状態、セル、近傍、局所規則は使わない。 -/
theorem hasTreeMatching_of_codeAtDepth_eq
    (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    (depth : ℕ) (x : X) (y : Y)
    (hcode : codeAtDepth childrenY depth y = codeAtDepth childrenX depth x) :
    HasTreeMatching childrenX childrenY depth x y := by
  induction depth generalizing x y with
  | zero => trivial
  | succ depth ih =>
      obtain ⟨e, he⟩ := exists_child_occurrence_equiv_of_codeAtDepth_succ_eq
        childrenX childrenY depth x y hcode
      exact ⟨e, fun z => ih z (e z) (he z)⟩

/-- 有限子表だけから作る、深さを打ち切った節点型。深さ零では根一点、
後続段では根一点と、子の出現ごとに付く一つ浅い節点型の従属和である。
要るのは一つの有限子表だけであり、型全体の有限性、自己写像、周期性、
最小前周期、二値状態、セル、近傍、局所規則は使わない。
落とせなかった仮定は元の等号判定で、子表の台多重集合を型として使うために要る。 -/
def TruncatedTreeNode (children : X → Finset X) : (depth : ℕ) → X → Type
  | 0, _ => PUnit
  | depth + 1, x =>
      PUnit ⊕ (Σ z : (children x).val, TruncatedTreeNode children depth z)

/-- 打ち切り節点型の根。深さにかかわらず基点そのものを表す。 -/
def truncatedTreeNodeRoot (children : X → Finset X) :
    (depth : ℕ) → (x : X) → TruncatedTreeNode children depth x
  | 0, _ => PUnit.unit
  | _ + 1, _ => Sum.inl PUnit.unit

/-- 再帰的前像木対応から、打ち切り節点型どうしの全単射を構成する。
後続段では根を根へ固定し、対応が与える子出現の全単射を適用してから、
対応した子ごとに一つ浅い全単射へ再帰する。使うのは二つの有限子表と、
対応が持つ子出現全単射および一つ浅い対応だけである。型全体の有限性、
自己写像、周期性、最小前周期、二値状態、セル、近傍、局所規則は使わない。
落とせなかったのは、対応の存在文から全単射を一つ取り出すための選択である。 -/
noncomputable def treeNodeEquivOfMatching
    (childrenX : X → Finset X) (childrenY : Y → Finset Y) :
    (depth : ℕ) → (x : X) → (y : Y) → HasTreeMatching childrenX childrenY depth x y →
      TruncatedTreeNode childrenX depth x ≃ TruncatedTreeNode childrenY depth y
  | 0, _, _, _ => Equiv.refl PUnit
  | depth + 1, x, y, hmatch =>
      Equiv.sumCongr (Equiv.refl PUnit)
        (Equiv.sigmaCongr (Classical.choose hmatch) fun z =>
          treeNodeEquivOfMatching childrenX childrenY depth z (Classical.choose hmatch z)
            (Classical.choose_spec hmatch z))

/-- 構成した全単射は、後続段の根を根へ送る。 -/
theorem treeNodeEquivOfMatching_root
    (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    (depth : ℕ) (x : X) (y : Y)
    (hmatch : HasTreeMatching childrenX childrenY (depth + 1) x y) :
    treeNodeEquivOfMatching childrenX childrenY (depth + 1) x y hmatch
        (Sum.inl PUnit.unit) = Sum.inl PUnit.unit :=
  rfl

/-- 構成した全単射は、深さ零を含む全ての打ち切り深さで根を根へ送る。 -/
theorem treeNodeEquivOfMatching_root_all
    (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    (depth : ℕ) (x : X) (y : Y)
    (hmatch : HasTreeMatching childrenX childrenY depth x y) :
    treeNodeEquivOfMatching childrenX childrenY depth x y hmatch
        (truncatedTreeNodeRoot childrenX depth x) =
      truncatedTreeNodeRoot childrenY depth y := by
  cases depth <;> rfl

/-- 子分岐では、選んだ子出現対応を先に適用し、その下の部分木の全単射へ再帰する。 -/
theorem treeNodeEquivOfMatching_child
    (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    (depth : ℕ) (x : X) (y : Y)
    (hmatch : HasTreeMatching childrenX childrenY (depth + 1) x y)
    (z : (childrenX x).val) (u : TruncatedTreeNode childrenX depth z) :
    treeNodeEquivOfMatching childrenX childrenY (depth + 1) x y hmatch
        (Sum.inr ⟨z, u⟩) =
      Sum.inr ⟨Classical.choose hmatch z,
        treeNodeEquivOfMatching childrenX childrenY depth z
          (Classical.choose hmatch z) (Classical.choose_spec hmatch z) u⟩ :=
  rfl


/-- 有限子表だけから作る打ち切り節点型の親子辺。直下の子から根への辺と、
各子部分木の内部辺を再帰的に区別して記録する。要るのは一つの有限子表だけであり、
型全体の有限性、自己写像、周期性、最小前周期、二値状態、セル、近傍、局所規則は使わない。 -/
inductive TruncatedTreeParentEdge (children : X → Finset X) :
    (depth : ℕ) → (x : X) →
      TruncatedTreeNode children depth x → TruncatedTreeNode children depth x → Prop
  | rootChild (depth : ℕ) (x : X) (z : (children x).val) :
      TruncatedTreeParentEdge children (depth + 1) x
        (Sum.inr ⟨z, truncatedTreeNodeRoot children depth z⟩)
        (truncatedTreeNodeRoot children (depth + 1) x)
  | inChild (depth : ℕ) (x : X) (z : (children x).val)
      {u v : TruncatedTreeNode children depth z}
      (huv : TruncatedTreeParentEdge children depth z u v) :
      TruncatedTreeParentEdge children (depth + 1) x
        (Sum.inr ⟨z, u⟩) (Sum.inr ⟨z, v⟩)

/-- 対応から構成した節点全単射は、根直下だけでなく全ての子部分木の内部でも
親子辺を親子辺へ送る。証明は辺の深さに関する帰納法であり、各段で使うのは
根の保存と子分岐の形だけである。型全体の有限性、自己写像、周期性、最小前周期、
二値状態、セル、近傍、局所規則は使わない。 -/
theorem treeNodeEquivOfMatching_preserves_parent_edge
    (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    {depth : ℕ} {x : X} {y : Y}
    (hmatch : HasTreeMatching childrenX childrenY depth x y)
    {u v : TruncatedTreeNode childrenX depth x}
    (huv : TruncatedTreeParentEdge childrenX depth x u v) :
    TruncatedTreeParentEdge childrenY depth y
      (treeNodeEquivOfMatching childrenX childrenY depth x y hmatch u)
      (treeNodeEquivOfMatching childrenX childrenY depth x y hmatch v) := by
  induction huv generalizing y with
  | rootChild depth x z =>
      rw [treeNodeEquivOfMatching_child, treeNodeEquivOfMatching_root_all,
        treeNodeEquivOfMatching_root_all]
      exact TruncatedTreeParentEdge.rootChild depth _ (Classical.choose hmatch z)
  | inChild depth x z huv ih =>
      rw [treeNodeEquivOfMatching_child, treeNodeEquivOfMatching_child]
      exact TruncatedTreeParentEdge.inChild depth _ (Classical.choose hmatch z)
        (ih (Classical.choose_spec hmatch z))

/-- 打ち切り節点型の各節点は根そのものか、一意に定まる親節点への辺を持つ。
後続深さでは根直下と子部分木内部を分けて示す。使うのは一つの有限子表だけである。 -/
theorem truncatedTreeNode_eq_root_or_exists_parent (children : X → Finset X) :
    (depth : ℕ) → (x : X) → (u : TruncatedTreeNode children depth x) →
      u = truncatedTreeNodeRoot children depth x ∨
        ∃ v : TruncatedTreeNode children depth x,
          TruncatedTreeParentEdge children depth x u v
  | 0, _, u => by
      left
      cases u
      rfl
  | _ + 1, _, Sum.inl u => by
      left
      exact congrArg Sum.inl (Subsingleton.elim u PUnit.unit)
  | depth + 1, x, Sum.inr ⟨z, u⟩ => by
      rcases truncatedTreeNode_eq_root_or_exists_parent children depth z u with hu | ⟨v, huv⟩
      · right
        subst hu
        exact ⟨truncatedTreeNodeRoot children (depth + 1) x,
          TruncatedTreeParentEdge.rootChild depth x z⟩
      · right
        exact ⟨Sum.inr ⟨z, v⟩, TruncatedTreeParentEdge.inChild depth x z huv⟩

/-- 打ち切り節点型を別の節点表へ全単射で読み替えられるとき、
再帰的対応から作った節点全単射を二つの表の間へ接着する。
使うのは二つの有限子表、その再帰的対応、および各打ち切り節点型と
対象表を結ぶ全単射だけである。表の元の意味、自己写像、周期性、
最小前周期、二値状態、セル、近傍、局所規則は使わない。 -/
noncomputable def attachedTableEquivOfMatching
    (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    {TableX TableY : Type} (depth : ℕ) (x : X) (y : Y)
    (hmatch : HasTreeMatching childrenX childrenY depth x y)
    (attachX : TruncatedTreeNode childrenX depth x ≃ TableX)
    (attachY : TruncatedTreeNode childrenY depth y ≃ TableY) :
    TableX ≃ TableY :=
  attachX.symm |>.trans
    (treeNodeEquivOfMatching childrenX childrenY depth x y hmatch) |>.trans
      attachY

/-- 接着した表間写像は全単射である。 -/
theorem attachedTableEquivOfMatching_bijective
    (childrenX : X → Finset X) (childrenY : Y → Finset Y)
    {TableX TableY : Type} (depth : ℕ) (x : X) (y : Y)
    (hmatch : HasTreeMatching childrenX childrenY depth x y)
    (attachX : TruncatedTreeNode childrenX depth x ≃ TableX)
    (attachY : TruncatedTreeNode childrenY depth y ≃ TableY) :
    Function.Bijective
      (attachedTableEquivOfMatching childrenX childrenY depth x y hmatch attachX attachY) :=
  (attachedTableEquivOfMatching childrenX childrenY depth x y hmatch attachX attachY).bijective

end CellularAutomata.NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance
