/-
# 全域木の同定へ入る第一歩（連結でなければ小行列式は $0$）— cycle 34 step 2

対応する人手証明: Kirchhoff の matrix-tree 定理（外部定理。台帳は
`structured-latex/tools/external-theorem-coverage.ts`）。

## この file が担当する範囲

`KirchhoffCounting.lean`（cycle 33 step 3）は
$\det(D_0D_0^{\mathsf T})$ が「小行列式が $0$ でない辺集合」の**個数**に等しいことまで書いた。
残っていたのは、その性質が「全域木であること」だと同定する組合せの側である。

**その同定を、連結性の側から半分書く。** すなわち

> 辺集合 $S$ が $V$ を連結にしないなら、$S$ に対応する小行列式は $0$ である。

を証明する。対偶を取ると「小行列式が $0$ でない辺集合は連結である」なので、
`KirchhoffCounting.lean` が数えている集合が**全域連結部分グラフの中に収まる**ことが言える。
辺の本数が $|V|-1$ に固定されているので、連結であることと全域木であることは同値であり、
残るのは逆向き（連結なら小行列式が $\pm1$）だけになる。

## 着手時に見立てが 1 つ外れた（正直に書く）

cycle 33 総括は「全域木の同定へ入ると、**グラフの連結性と閉路を型に用意することになる**」と
書いていた。実際に書いてみると、**閉路は要らない。**
辺の本数を $|V|-1$ に固定すると「閉路を持たない」と「連結」は同値なので、
連結性だけを型に用意すれば足りる。連結性は `Relation.ReflTransGen` で書けるので、
閉路・道・長さといった型を新しく作る必要が無かった。

## 証明の中身（人手証明の 1 行に対応）

人手証明でいう「連結でなければ、根を含まない連結成分の行の和が $0$ になる」である。
成分 $C$ の外へ出る辺が無いので、$C$ の行を足すと各辺の寄与が $+1$ と $-1$ で打ち消し合う。
行が一次従属なので行列式は $0$ になる。

## 逆向きへの入口（cycle 35 step 3 で書いた）

逆向き（連結なら小行列式が $\pm1$）は葉に沿った展開の帰納法になる。
その**入口にあたる葉の存在**を段 4 に書いた。

**書いてみると、葉の存在に連結性はほとんど要らない。** 効くのは握手補題
（次数の総和は辺の本数の 2 倍）ひとつで、辺の本数が頂点数より少なければ
次数 $\le1$ の頂点が必ずある（`exists_degOn_le_one`）。
連結性が要るのは「次数が $0$ でない」を言うところだけで、そこも
到達可能性の鎖の最後の 1 歩を取り出すだけである（`one_le_degOn_of_reach`）。
2 つを合わせると、辺の本数が $|V|-1$ で連結なら**根でない葉が必ずある**
（`exists_leaf_ne_root`）。閉路も道も長さも使わない。

## 葉の行に沿った展開（cycle 36 step 2 で書いた）

逆向きの帰納法は 2 つの部品からなる——**葉の行に沿った展開**と、
**葉を除いた小さいグラフへの帰納**である。段 5 に前者を書いた。

まず一般の行列の補題として、行に $0$ でない成分が 1 つしかなければ
行列式が符号つきでその小行列式に落ちること（`det_eq_of_row_single_entry`）を書き、
次にグラフの側から、葉の行がその形をしていること
（`incMatrixSigned_eq_zero_of_degOn_one`）と、その 1 つの成分が $\pm1$ であること
（`incMatrixSigned_leaf_eq_one_or_neg_one`）を与える。
合わせたものが `det_submatrix_eq_of_leaf` で、**帰納法の 1 歩ぶんである。**

**ここでも見立てが外れた（4 サイクル連続）。** 葉の行が単項であることに連結性は要らない——
効くのは次数が $1$ 以下であることだけで、他の辺が接していれば次数が $2$ 以上になる、
という数え上げ 1 つで出る（`two_le_degOn_of_two_incidences`）。
自己ループが除かれるのも同じ数え上げからで、始点と終点が同時に $v$ なら次数は $2$ になる。

## 形式化しなかったもの

* **葉を除いた小さいグラフへの帰納は cycle 37 step 2 で書いた**（段 6）。
  cycle 36 step 2 は「頂点の型 $V$ を固定して `Fintype.card V` で数え上げているので、
  葉を取り除くと型が変わり帰納法の仮定を当てられない」と書いて止めていた。
  **頂点集合を引数に持つ形へ書き直したら当たった**。書き直しは破壊的ではなく、
  段 4 までの主張は頂点集合として全体を取った特別な場合として出る。
* **指標分解**（塔の各レベルへ分ける段）は書いていない。
  **ただしこれは Kirchhoff の定理の内容ではない**——本文は
  「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いている。
  したがってこの段は本文の主張の側の残りである（検査 F の 命題 T ほかの欄を見よ）。
-/
import Mathlib
import IntegrableLattice.MultigraphLaplacian

namespace IntegrableLattice
namespace SpanningConnectivity

open Finset Matrix

variable {V E : Type*} [Fintype V] [DecidableEq V] [Fintype E] [DecidableEq E]

/-! ## 段 1: 辺集合が定める到達可能性 -/

/-- 辺 `e ∈ S` が `u` と `v` を直接つなぐ（向きは問わない）。 -/
def AdjOn (s t : E → V) (S : Finset E) (u v : V) : Prop :=
  ∃ e ∈ S, (s e = u ∧ t e = v) ∨ (s e = v ∧ t e = u)

/-- `S` の辺だけを使って `u` から `v` へ到達できる。 -/
def ReachOn (s t : E → V) (S : Finset E) : V → V → Prop :=
  Relation.ReflTransGen (AdjOn s t S)

omit [Fintype V] [DecidableEq V] [Fintype E] [DecidableEq E] in
/-- 到達可能性は対称である（辺の向きを問わない定義にしてあるため）。 -/
theorem adjOn_symm {s t : E → V} {S : Finset E} {u v : V} (h : AdjOn s t S u v) :
    AdjOn s t S v u := by
  obtain ⟨e, he, h1 | h1⟩ := h
  · exact ⟨e, he, Or.inr h1⟩
  · exact ⟨e, he, Or.inl h1⟩

omit [Fintype V] [DecidableEq V] [Fintype E] [DecidableEq E] in
/-- 到達可能性そのものも対称である。 -/
theorem reachOn_symm {s t : E → V} {S : Finset E} {u v : V} (h : ReachOn s t S u v) :
    ReachOn s t S v u := by
  induction h with
  | refl => exact Relation.ReflTransGen.refl
  | tail _ hstep ih => exact (Relation.ReflTransGen.single (adjOn_symm hstep)).trans ih

open Classical in
/-- `r` から到達できる頂点の集合（根 `r` の連結成分）。 -/
noncomputable def component (s t : E → V) (S : Finset E) (r : V) : Finset V :=
  Finset.univ.filter fun v => ReachOn s t S r v

omit [DecidableEq V] [Fintype E] [DecidableEq E] in
theorem mem_component_iff {s t : E → V} {S : Finset E} {r v : V} :
    v ∈ component s t S r ↔ ReachOn s t S r v := by
  classical
  simp [component]

omit [DecidableEq V] [Fintype E] [DecidableEq E] in
/-- 成分の外へ出る辺は無い。`e ∈ S` の端点の片方が成分にあれば、もう片方も成分にある。 -/
theorem mem_component_of_edge {s t : E → V} {S : Finset E} {r : V} {e : E} (he : e ∈ S)
    (h : s e ∈ component s t S r) : t e ∈ component s t S r := by
  rw [mem_component_iff] at h ⊢
  exact h.tail ⟨e, he, Or.inl ⟨rfl, rfl⟩⟩

omit [DecidableEq V] [Fintype E] [DecidableEq E] in
theorem mem_component_of_edge' {s t : E → V} {S : Finset E} {r : V} {e : E} (he : e ∈ S)
    (h : t e ∈ component s t S r) : s e ∈ component s t S r := by
  rw [mem_component_iff] at h ⊢
  exact h.tail ⟨e, he, Or.inr ⟨rfl, rfl⟩⟩

/-! ## 段 2: 成分の行を足すと消える

これが人手証明の「$C$ の外へ出る辺が無いので、$C$ の行の和が $0$ になる」である。 -/

omit [Fintype E] [DecidableEq E] in
/-- **成分の行の和は消える。** `S` の各辺について、その列を成分の行にわたって足すと $0$ になる。 -/
theorem sum_incMatrixSigned_component (s t : E → V) (S : Finset E) (r : V) {e : E} (he : e ∈ S) :
    ∑ v ∈ component s t S r, incMatrixSigned s t v e = 0 := by
  classical
  -- 列 `e` は `t e` の行で `+1`、`s e` の行で `-1`、それ以外は `0`（ループなら全体が `0`）。
  by_cases hloop : s e = t e
  · refine Finset.sum_eq_zero fun v _ => ?_
    exact incMatrixSigned_loop s t hloop v
  · by_cases hs : s e ∈ component s t S r
    · have ht : t e ∈ component s t S r := mem_component_of_edge he hs
      have hne : t e ≠ s e := fun h => hloop h.symm
      rw [Finset.sum_eq_add_of_mem (t e) (s e) ht hs hne ?_]
      · simp [incMatrixSigned, hloop, Ne.symm hloop]
      · intro v _ hvne
        simp [incMatrixSigned, hvne.1, hvne.2]
    · have ht : t e ∉ component s t S r := fun h => hs (mem_component_of_edge' he h)
      refine Finset.sum_eq_zero fun v hv => ?_
      have h1 : v ≠ t e := fun h => ht (h ▸ hv)
      have h2 : v ≠ s e := fun h => hs (h ▸ hv)
      simp [incMatrixSigned, h1, h2]

/-! ## 段 3: 連結でなければ小行列式は $0$

根 `r0` を落とした行の集合から作った小行列を考える。`S` が全体を連結にしないなら、
`r0` から到達できない頂点 `w` があり、`w` の成分は根を含まない。
その成分の行の和が消えるので、行は一次従属になり行列式は $0$ になる。 -/

omit [Fintype E] [DecidableEq E] in
/-- **連結でなければ行は一次従属である。**
根 `r0` から到達できない頂点 `w` があれば、`w` の成分の指示ベクトルが左核に入る。 -/
theorem exists_ne_zero_vecMul_of_not_reach (s t : E → V) (S : Finset E) (r0 w : V)
    (hw : ¬ ReachOn s t S r0 w) :
    ∃ c : V → ℤ, c w ≠ 0 ∧ (∀ v, c v ≠ 0 → ¬ ReachOn s t S r0 v) ∧
      ∀ e ∈ S, ∑ v : V, c v * incMatrixSigned s t v e = 0 := by
  classical
  -- `w` の成分の指示ベクトルを取る。
  refine ⟨fun v => if v ∈ component s t S w then 1 else 0, ?_, ?_, ?_⟩
  · simp [mem_component_iff]
    exact Relation.ReflTransGen.refl
  · intro v hv hreach
    -- `v` が `w` の成分にあり、かつ `r0` から到達できるなら、`r0` から `w` へも到達できる。
    have hvw : ReachOn s t S w v := by
      by_contra hc
      exact hv (by simp [mem_component_iff, hc])
    exact hw (hreach.trans (reachOn_symm hvw))
  · intro e he
    -- 成分の外の行は寄与しないので、和は成分の上の和に等しい。
    have hpoint : ∀ v : V,
        (if v ∈ component s t S w then (1 : ℤ) else 0) * incMatrixSigned s t v e
          = if v ∈ component s t S w then incMatrixSigned s t v e else 0 := by
      intro v; split <;> simp
    rw [Finset.sum_congr rfl fun v _ => hpoint v, Finset.sum_ite_mem, Finset.univ_inter]
    exact sum_incMatrixSigned_component s t S w he

omit [Fintype E] [DecidableEq E] in
/-- **連結でなければ小行列式は $0$。**

`r` は根 `r0` を除いた頂点の並べ方（単射で、`r0` を取らず、`r0` 以外を全部取る）、
`c` は `S` の中から取った辺の並べ方である。`S` が `r0` から全体へ届かないなら
小行列式は $0$ になる。

対偶が `KirchhoffCounting.lean` の数え上げに効く——
**小行列式が $0$ でない辺集合は、必ず全体を連結にする。** -/
theorem det_submatrix_eq_zero_of_not_reach (s t : E → V) (S : Finset E) (r0 w : V)
    (hw : ¬ ReachOn s t S r0 w) {k : ℕ} (r : Fin k → V) (hr : Function.Injective r)
    (hr0 : ∀ i, r i ≠ r0) (hsurj : ∀ v : V, v ≠ r0 → ∃ i, r i = v)
    (c : Fin k → E) (hc : ∀ j, c j ∈ S) :
    ((incMatrixSigned s t).submatrix r c).det = 0 := by
  classical
  obtain ⟨d, hdw, hdreach, hdsum⟩ := exists_ne_zero_vecMul_of_not_reach s t S r0 w hw
  have hdr0 : d r0 = 0 := by
    by_contra hne
    exact hdreach r0 hne Relation.ReflTransGen.refl
  -- 行の並べ方 `r` の像はちょうど「根を除いた頂点全体」である。
  have himage : Finset.image r Finset.univ = Finset.univ.erase r0 := by
    refine Finset.Subset.antisymm ?_ ?_
    · intro v hv
      obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hv
      exact Finset.mem_erase.mpr ⟨hr0 i, Finset.mem_univ _⟩
    · intro v hv
      obtain ⟨i, hi⟩ := hsurj v (Finset.mem_erase.mp hv).1
      exact Finset.mem_image.mpr ⟨i, Finset.mem_univ _, hi⟩
  refine Matrix.exists_vecMul_eq_zero_iff.mp ⟨fun i => d (r i), ?_, ?_⟩
  · intro hzero
    have hwne : w ≠ r0 := fun h => hw (h ▸ Relation.ReflTransGen.refl)
    obtain ⟨i, hi⟩ := hsurj w hwne
    exact hdw (by rw [← hi]; exact congrFun hzero i)
  · funext j
    have hfull : ∑ i : Fin k, d (r i) * incMatrixSigned s t (r i) (c j)
        = ∑ v : V, d v * incMatrixSigned s t v (c j) := by
      rw [← Finset.sum_image (f := fun v => d v * incMatrixSigned s t v (c j))
        (fun x _ y _ h => hr h), himage,
        Finset.sum_erase _ (by simp [hdr0])]
    simp only [Matrix.vecMul, dotProduct, Matrix.submatrix_apply, Pi.zero_apply]
    rw [hfull]
    exact hdsum (c j) (hc j)

/-! ## 段 4: 逆向きへの入口 — 葉の存在（cycle 35 step 3）

逆向き（連結なら小行列式が $\pm1$）は葉に沿った展開の帰納法になる。
その入口にあたる「葉が存在すること」を、**握手補題ひとつ**で出す。 -/

section Leaf

/-- 辺集合 `S` における頂点 `v` の次数。両端を別々に数えるので、自己ループは 2 と数える。 -/
def degOn (s t : E → V) (S : Finset E) (v : V) : ℕ :=
  (S.filter (fun e => s e = v)).card + (S.filter (fun e => t e = v)).card

omit [Fintype E] [DecidableEq E] in
/-- **握手補題**。次数の総和は辺の本数の 2 倍である。
各辺が始点で 1 回・終点で 1 回数えられることしか使わない。 -/
theorem sum_degOn (s t : E → V) (S : Finset E) :
    ∑ v, degOn s t S v = 2 * S.card := by
  classical
  have hs : S.card = ∑ v : V, (S.filter (fun e => s e = v)).card :=
    Finset.card_eq_sum_card_fiberwise fun e _ => Finset.mem_univ (s e)
  have ht : S.card = ∑ v : V, (S.filter (fun e => t e = v)).card :=
    Finset.card_eq_sum_card_fiberwise fun e _ => Finset.mem_univ (t e)
  simp only [degOn, Finset.sum_add_distrib]
  omega

omit [Fintype E] [DecidableEq E] in
/-- **葉の存在（数え上げだけで出る）**。辺の本数が頂点数より少なければ、
次数が $1$ 以下の頂点が必ずある。**連結性も閉路も使わない。** -/
theorem exists_degOn_le_one (s t : E → V) (S : Finset E) (h : S.card < Fintype.card V) :
    ∃ v : V, degOn s t S v ≤ 1 := by
  classical
  by_contra hcon
  push_neg at hcon
  have h1 : 2 * Fintype.card V ≤ ∑ v, degOn s t S v := by
    calc 2 * Fintype.card V = ∑ _v : V, 2 := by
          rw [Finset.sum_const, Finset.card_univ, smul_eq_mul, mul_comm]
      _ ≤ ∑ v, degOn s t S v := Finset.sum_le_sum fun v _ => hcon v
  rw [sum_degOn] at h1
  omega

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- 到達可能性の鎖の最後の 1 歩が、$v$ に接する辺を与える。
したがって根から到達できる根以外の頂点は次数が $1$ 以上である。 -/
theorem one_le_degOn_of_reach (s t : E → V) (S : Finset E) {r v : V}
    (hreach : ReachOn s t S r v) (hv : v ≠ r) : 1 ≤ degOn s t S v := by
  classical
  rcases Relation.ReflTransGen.cases_tail hreach with h | ⟨b, _, hadj⟩
  · exact absurd h hv
  · obtain ⟨e, heS, hcase⟩ := hadj
    rcases hcase with ⟨_, hte⟩ | ⟨hse, _⟩
    · have : e ∈ S.filter (fun e => t e = v) := Finset.mem_filter.mpr ⟨heS, hte⟩
      have := Finset.card_pos.mpr ⟨e, this⟩
      simp only [degOn]
      omega
    · have : e ∈ S.filter (fun e => s e = v) := Finset.mem_filter.mpr ⟨heS, hse⟩
      have := Finset.card_pos.mpr ⟨e, this⟩
      simp only [degOn]
      omega

omit [Fintype E] [DecidableEq E] in
/-- **逆向きの帰納法の入口**。辺の本数が $|V|-1$ で、根から全頂点へ到達できるなら、
**根でない頂点の中に次数がちょうど $1$ のもの（葉）がある。**

数え上げは次のとおり。根以外がすべて次数 $2$ 以上だとすると、
次数の総和は $2(|V|-1)$ 以上に根の次数（$1$ 以上）を足したものになり $2|V|-1$ 以上。
ところが握手補題から総和は $2(|V|-1)=2|V|-2$ である。 -/
theorem exists_leaf_ne_root (s t : E → V) (S : Finset E) (r : V)
    (hcard : S.card + 1 = Fintype.card V) (hreach : ∀ v : V, ReachOn s t S r v)
    (hV : 2 ≤ Fintype.card V) :
    ∃ v : V, v ≠ r ∧ degOn s t S v = 1 := by
  classical
  by_contra hcon
  push_neg at hcon
  -- 根以外はすべて次数 2 以上（次数 1 以下は連結性から次数 1 になるので排除される）。
  have hge : ∀ v : V, v ≠ r → 2 ≤ degOn s t S v := by
    intro v hv
    have h1 : 1 ≤ degOn s t S v := one_le_degOn_of_reach s t S (hreach v) hv
    have h2 : degOn s t S v ≠ 1 := hcon v hv
    omega
  -- 根の次数も 1 以上（頂点が 2 つ以上あるので根と異なる頂点が取れる）。
  obtain ⟨w, hw⟩ : ∃ w : V, w ≠ r := by
    by_contra hall
    push_neg at hall
    have : Fintype.card V ≤ 1 := Fintype.card_le_one_iff.mpr fun a b => by
      rw [hall a, hall b]
    omega
  have hr : 1 ≤ degOn s t S r := by
    have h1 : 1 ≤ degOn s t S w := one_le_degOn_of_reach s t S (hreach w) hw
    -- `w` に接する辺は `r` 側にも端点をもつとは限らないので、根の次数は別に押さえる。
    -- 根から `w` へ到達できるので、根から出る最初の 1 歩がある。
    rcases Relation.ReflTransGen.cases_head (hreach w) with h | ⟨b, hadj, _⟩
    · exact absurd h.symm hw
    · obtain ⟨e, heS, hcase⟩ := hadj
      rcases hcase with ⟨hse, _⟩ | ⟨_, hte⟩
      · have hmem : e ∈ S.filter (fun e => s e = r) := Finset.mem_filter.mpr ⟨heS, hse⟩
        have := Finset.card_pos.mpr ⟨e, hmem⟩
        simp only [degOn]; omega
      · have hmem : e ∈ S.filter (fun e => t e = r) := Finset.mem_filter.mpr ⟨heS, hte⟩
        have := Finset.card_pos.mpr ⟨e, hmem⟩
        simp only [degOn]; omega
  -- 総和を下から押さえると握手補題と矛盾する。
  have hsum : 2 * (Fintype.card V - 1) + 1 ≤ ∑ v, degOn s t S v := by
    have hsplit : ∑ v, degOn s t S v
        = degOn s t S r + ∑ v ∈ Finset.univ.erase r, degOn s t S v := by
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ r)]
    have hcard' : (Finset.univ.erase r).card = Fintype.card V - 1 := by
      rw [Finset.card_erase_of_mem (Finset.mem_univ r), Finset.card_univ]
    have hlow : 2 * (Fintype.card V - 1) ≤ ∑ v ∈ Finset.univ.erase r, degOn s t S v := by
      calc 2 * (Fintype.card V - 1)
          = ∑ _v ∈ Finset.univ.erase r, 2 := by
            rw [Finset.sum_const, hcard', smul_eq_mul, mul_comm]
        _ ≤ ∑ v ∈ Finset.univ.erase r, degOn s t S v :=
            Finset.sum_le_sum fun v hv => hge v (Finset.ne_of_mem_erase hv)
    omega
  rw [sum_degOn] at hsum
  omega

end Leaf

/-! ## 段 5: 葉の行に沿った行列式の展開（cycle 36 step 2）

逆向きの帰納法は 2 つの部品からなる。

1. **葉の行に沿った展開** — 葉の行には $0$ でない成分が 1 つしかないので、
   行列式は符号つきでその小行列式に落ちる。
2. **葉を除いた小さいグラフへの帰納** — 落ちた小行列式が、葉と葉に接する辺を取り除いた
   グラフの小行列式であることを言う。

本段は 1 を書く。まず一般の行列の補題として書き、次にグラフの側から
「葉の行は $0$ でない成分を 1 つしか持たず、その値は $\pm1$ である」を与える。 -/

section LeafExpansion

/-- **行に $0$ でない成分が 1 つしかないときの展開**。一般の行列の補題で、グラフは出てこない。
mathlib の `Matrix.det_succ_row` の和が 1 項に潰れるだけである。 -/
theorem det_eq_of_row_single_entry {n : ℕ} (M : Matrix (Fin (n + 1)) (Fin (n + 1)) ℤ)
    (i0 j0 : Fin (n + 1)) (hzero : ∀ j, j ≠ j0 → M i0 j = 0) :
    M.det = (-1) ^ ((i0 : ℕ) + (j0 : ℕ)) * M i0 j0 *
      (M.submatrix i0.succAbove j0.succAbove).det := by
  classical
  rw [Matrix.det_succ_row M i0]
  refine Finset.sum_eq_single j0 ?_ ?_
  · intro j _ hj
    rw [hzero j hj]
    ring
  · intro h
    exact absurd (Finset.mem_univ j0) h

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- 頂点 `v` に接する辺が `S` の中に 2 本あれば、次数は $2$ 以上である。 -/
theorem two_le_degOn_of_two_incidences (s t : E → V) (S : Finset E) {v : V} {e e' : E}
    (heS : e ∈ S) (he'S : e' ∈ S) (hne : e ≠ e')
    (hinc : s e = v ∨ t e = v) (hinc' : s e' = v ∨ t e' = v) :
    2 ≤ degOn s t S v := by
  classical
  have hs : ∀ {a : E}, a ∈ S → s a = v → a ∈ S.filter (fun x => s x = v) :=
    fun ha hsa => Finset.mem_filter.mpr ⟨ha, hsa⟩
  have ht : ∀ {a : E}, a ∈ S → t a = v → a ∈ S.filter (fun x => t x = v) :=
    fun ha hta => Finset.mem_filter.mpr ⟨ha, hta⟩
  rcases hinc with h1 | h1 <;> rcases hinc' with h2 | h2
  · -- どちらも始点側: 始点側の filter に 2 元ある。
    have := Finset.one_lt_card.mpr ⟨e, hs heS h1, e', hs he'S h2, hne⟩
    simp only [degOn]; omega
  · -- 始点側と終点側に 1 つずつ。
    have h3 := Finset.card_pos.mpr ⟨e, hs heS h1⟩
    have h4 := Finset.card_pos.mpr ⟨e', ht he'S h2⟩
    simp only [degOn]; omega
  · have h3 := Finset.card_pos.mpr ⟨e, ht heS h1⟩
    have h4 := Finset.card_pos.mpr ⟨e', hs he'S h2⟩
    simp only [degOn]; omega
  · have := Finset.one_lt_card.mpr ⟨e, ht heS h1, e', ht he'S h2, hne⟩
    simp only [degOn]; omega

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- **葉の行は、接する 1 本の辺のところ以外はすべて $0$ である。**
次数が $1$ なので、他の辺は `v` に接することができない。 -/
theorem incMatrixSigned_eq_zero_of_degOn_one (s t : E → V) (S : Finset E) {v : V}
    (hdeg : degOn s t S v ≤ 1) {e e' : E} (heS : e ∈ S) (he'S : e' ∈ S)
    (hinc : s e = v ∨ t e = v) (hne : e' ≠ e) :
    incMatrixSigned s t v e' = 0 := by
  classical
  by_contra hnz
  -- 成分が $0$ でないなら `v` は `e'` に接している。
  have hinc' : s e' = v ∨ t e' = v := by
    by_contra hc
    push_neg at hc
    simp [incMatrixSigned, Ne.symm hc.1, Ne.symm hc.2] at hnz
  have := two_le_degOn_of_two_incidences s t S heS he'S (Ne.symm hne) hinc hinc'
  omega

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- **葉の行の、接する辺のところの成分は $\pm1$ である。**
自己ループでなければ、$v$ は始点か終点のどちらか一方だけである。 -/
theorem incMatrixSigned_leaf_eq_one_or_neg_one (s t : E → V) (S : Finset E) {v : V}
    (hdeg : degOn s t S v ≤ 1) {e : E} (heS : e ∈ S) (hinc : s e = v ∨ t e = v) :
    incMatrixSigned s t v e = 1 ∨ incMatrixSigned s t v e = -1 := by
  classical
  -- 自己ループなら次数が 2 になるので、始点と終点が同時に `v` になることはない。
  have hnot : ¬ (s e = v ∧ t e = v) := by
    rintro ⟨hse, hte⟩
    have h3 : 0 < (S.filter (fun x => s x = v)).card :=
      Finset.card_pos.mpr ⟨e, Finset.mem_filter.mpr ⟨heS, hse⟩⟩
    have h4 : 0 < (S.filter (fun x => t x = v)).card :=
      Finset.card_pos.mpr ⟨e, Finset.mem_filter.mpr ⟨heS, hte⟩⟩
    simp only [degOn] at hdeg
    omega
  rcases hinc with h | h
  · right
    have hte : v ≠ t e := fun hc => hnot ⟨h, hc.symm⟩
    simp [incMatrixSigned, hte, h]
  · left
    have hse : v ≠ s e := fun hc => hnot ⟨hc.symm, h⟩
    simp [incMatrixSigned, hse, h]

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- **葉の行に沿った展開（グラフの言葉で）**。
行の並べ方 `r` の `i0` 番目が葉 `v`、列の並べ方 `c` の `j0` 番目がその葉に接する辺 `e` なら、
小行列式は符号つきで、その行と列を落とした小行列式に等しい。

**これが逆向きの帰納法の 1 歩ぶんである。** 残っているのは、落ちた小行列式が
「葉と葉に接する辺を取り除いたグラフの小行列式」だと言う段である（下記「形式化しなかったもの」）。 -/
theorem det_submatrix_eq_of_leaf {n : ℕ} (s t : E → V) (S : Finset E) {v : V}
    (hdeg : degOn s t S v ≤ 1) {e : E} (heS : e ∈ S) (hinc : s e = v ∨ t e = v)
    (r : Fin (n + 1) → V) (c : Fin (n + 1) → E) (hc : ∀ j, c j ∈ S)
    (hcinj : Function.Injective c) (i0 j0 : Fin (n + 1)) (hr : r i0 = v) (hcj : c j0 = e) :
    ((incMatrixSigned s t).submatrix r c).det
      = (-1) ^ ((i0 : ℕ) + (j0 : ℕ)) * incMatrixSigned s t v e *
        (((incMatrixSigned s t).submatrix r c).submatrix
          i0.succAbove j0.succAbove).det := by
  classical
  have hrow : ∀ j, j ≠ j0 → ((incMatrixSigned s t).submatrix r c) i0 j = 0 := by
    intro j hj
    simp only [Matrix.submatrix_apply, hr]
    exact incMatrixSigned_eq_zero_of_degOn_one s t S hdeg heS (hc j) hinc
      (by rw [← hcj]; exact fun hcontra => hj (hcinj hcontra))
  rw [det_eq_of_row_single_entry _ i0 j0 hrow]
  simp [Matrix.submatrix_apply, hr, hcj]

end LeafExpansion

/-! ## 段 6: 頂点の部分集合を引数に持つ形と、逆向きの帰納法の後半（cycle 37 step 2）

cycle 36 step 2 は帰納法の後半を書かなかった。理由は技術的な壁ではなく、
段 1 から段 4 までが頂点の型 $V$ を固定して `Fintype.card V` で数え上げていたことである。
葉を取り除くと頂点の型が変わるので、帰納法の仮定を当てられない。

本段は**頂点集合を引数に持つ形へ書き直す**。書き直しは破壊的ではない——
段 4 までの主張は、頂点集合として全体を取った特別な場合として出る。

帰納法の芯は次の 2 つである。

1. **葉を取り除いても、残りの頂点は根から届く**（`reachOn_erase_of_leaf`）。
   葉の次数が $1$ なので、葉に接する辺は 1 本しかない。歩みが葉へ入ったなら、
   その 1 本で入って同じ 1 本で出るしかないので、葉を経由する迂回は取り除ける。
2. **葉の行に沿って展開すると、残るのは葉と葉の辺を取り除いたグラフの小行列式である**。
   段 5 の展開に、行と列の並べ方が `succAbove` でちょうど 1 つずつ縮むことを合わせる。 -/

section OnSubset

/-- 辺集合 `S` の辺の両端が、頂点集合 `W` に入っていること。 -/
def EdgesWithin (s t : E → V) (S : Finset E) (W : Finset V) : Prop :=
  ∀ e ∈ S, s e ∈ W ∧ t e ∈ W

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- **握手補題（頂点集合の版）**。次数の総和は辺の本数の 2 倍である。 -/
theorem sum_degOn_on (s t : E → V) (S : Finset E) (W : Finset V)
    (hW : EdgesWithin s t S W) :
    ∑ v ∈ W, degOn s t S v = 2 * S.card := by
  classical
  have hs : S.card = ∑ v ∈ W, (S.filter (fun e => s e = v)).card :=
    Finset.card_eq_sum_card_fiberwise fun e he => (hW e he).1
  have ht : S.card = ∑ v ∈ W, (S.filter (fun e => t e = v)).card :=
    Finset.card_eq_sum_card_fiberwise fun e he => (hW e he).2
  simp only [degOn, Finset.sum_add_distrib]
  omega

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- **葉の存在（頂点集合の版）**。辺の本数が頂点数より少なければ、
`W` の中に次数が $1$ 以下の頂点がある。連結性も閉路も使わない。 -/
theorem exists_degOn_le_one_on (s t : E → V) (S : Finset E) (W : Finset V)
    (hW : EdgesWithin s t S W) (h : S.card < W.card) :
    ∃ v ∈ W, degOn s t S v ≤ 1 := by
  classical
  by_contra hcon
  push_neg at hcon
  have h1 : 2 * W.card ≤ ∑ v ∈ W, degOn s t S v := by
    calc 2 * W.card = ∑ _v ∈ W, 2 := by
          rw [Finset.sum_const, smul_eq_mul, mul_comm]
      _ ≤ ∑ v ∈ W, degOn s t S v := Finset.sum_le_sum fun v hv => hcon v hv
  rw [sum_degOn_on s t S W hW] at h1
  omega

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- **逆向きの帰納法の入口（頂点集合の版）**。
辺の本数が $|W|-1$ で、根から `W` の全頂点へ届くなら、根でない葉が `W` の中にある。 -/
theorem exists_leaf_ne_root_on (s t : E → V) (S : Finset E) (W : Finset V) (r : V)
    (hW : EdgesWithin s t S W) (hrW : r ∈ W) (hcard : S.card + 1 = W.card)
    (hreach : ∀ v ∈ W, ReachOn s t S r v) (hWcard : 2 ≤ W.card) :
    ∃ v ∈ W, v ≠ r ∧ degOn s t S v = 1 := by
  classical
  by_contra hcon
  push_neg at hcon
  have hge : ∀ v ∈ W, v ≠ r → 2 ≤ degOn s t S v := by
    intro v hv hvr
    have h1 : 1 ≤ degOn s t S v := one_le_degOn_of_reach s t S (hreach v hv) hvr
    have h2 : degOn s t S v ≠ 1 := hcon v hv hvr
    omega
  -- 根の次数も 1 以上（`W` に根と異なる頂点があるので、根から出る最初の 1 歩がある）。
  obtain ⟨w, hwW, hw⟩ : ∃ w ∈ W, w ≠ r := by
    by_contra hall
    push_neg at hall
    have hsub : W ⊆ {r} := fun x hx => Finset.mem_singleton.mpr (hall x hx)
    have := Finset.card_le_card hsub
    simp at this
    omega
  have hr : 1 ≤ degOn s t S r := by
    rcases Relation.ReflTransGen.cases_head (hreach w hwW) with h | ⟨b, hadj, _⟩
    · exact absurd h.symm hw
    · obtain ⟨e, heS, hcase⟩ := hadj
      rcases hcase with ⟨hse, _⟩ | ⟨_, hte⟩
      · have hmem : e ∈ S.filter (fun e => s e = r) := Finset.mem_filter.mpr ⟨heS, hse⟩
        have := Finset.card_pos.mpr ⟨e, hmem⟩
        simp only [degOn]; omega
      · have hmem : e ∈ S.filter (fun e => t e = r) := Finset.mem_filter.mpr ⟨heS, hte⟩
        have := Finset.card_pos.mpr ⟨e, hmem⟩
        simp only [degOn]; omega
  have hsum : 2 * (W.card - 1) + 1 ≤ ∑ v ∈ W, degOn s t S v := by
    have hsplit : ∑ v ∈ W, degOn s t S v
        = degOn s t S r + ∑ v ∈ W.erase r, degOn s t S v := by
      rw [← Finset.add_sum_erase _ _ hrW]
    have hcard' : (W.erase r).card = W.card - 1 := Finset.card_erase_of_mem hrW
    have hlow : 2 * (W.card - 1) ≤ ∑ v ∈ W.erase r, degOn s t S v := by
      calc 2 * (W.card - 1)
          = ∑ _v ∈ W.erase r, 2 := by
            rw [Finset.sum_const, hcard', smul_eq_mul, mul_comm]
        _ ≤ ∑ v ∈ W.erase r, degOn s t S v :=
            Finset.sum_le_sum fun v hv =>
              hge v (Finset.mem_of_mem_erase hv) (Finset.ne_of_mem_erase hv)
    omega
  rw [sum_degOn_on s t S W hW] at hsum
  omega

omit [Fintype V] [Fintype E] [DecidableEq E] in
/-- 次数が $1$ の頂点には、接する辺がちょうど 1 本ある。 -/
theorem exists_unique_incident_of_degOn_one (s t : E → V) (S : Finset E) {v : V}
    (hdeg : degOn s t S v = 1) :
    ∃ e ∈ S, (s e = v ∨ t e = v) ∧ ∀ f ∈ S, (s f = v ∨ t f = v) → f = e := by
  classical
  have hpos : 0 < (S.filter (fun e => s e = v)).card + (S.filter (fun e => t e = v)).card := by
    simp only [degOn] at hdeg; omega
  obtain ⟨e, heS, hinc⟩ : ∃ e ∈ S, s e = v ∨ t e = v := by
    by_contra hc
    push_neg at hc
    have h1 : S.filter (fun e => s e = v) = ∅ :=
      Finset.filter_eq_empty_iff.mpr fun e he hse => ((hc e he).1 hse).elim
    have h2 : S.filter (fun e => t e = v) = ∅ :=
      Finset.filter_eq_empty_iff.mpr fun e he hte => ((hc e he).2 hte).elim
    rw [h1, h2] at hpos
    simp at hpos
  refine ⟨e, heS, hinc, fun f hfS hincf => ?_⟩
  by_contra hne
  have := two_le_degOn_of_two_incidences s t S hfS heS hne hincf hinc
  omega

omit [Fintype V] [Fintype E] in
/-- **葉を取り除いても、残りの頂点は根から届く。**

葉 `v` の次数が $1$ なので、`v` に接する辺は `e` 1 本しかない。したがって歩みが `v` を通るときは
`e` で入って `e` で出るしかなく、その迂回は取り除ける。
形にするために「`v` へ着いたときは `e` のもう一方の端 `w` まで戻せる」という形で帰納法を回す。 -/
theorem reachOn_erase_of_leaf (s t : E → V) (S : Finset E) {r0 v w : V} {e : E}
    (heS : e ∈ S) (hdeg : degOn s t S v = 1)
    (hunique : ∀ f ∈ S, (s f = v ∨ t f = v) → f = e)
    (hends : (s e = v ∧ t e = w) ∨ (s e = w ∧ t e = v))
    (hr0 : r0 ≠ v) {u : V} (hreach : ReachOn s t S r0 u) :
    ReachOn s t (S.erase e) r0 (if u = v then w else u) := by
  classical
  induction hreach with
  | refl => simp [hr0]; exact Relation.ReflTransGen.refl
  | @tail b u hrb hadj ih =>
    obtain ⟨f, hfS, hcase⟩ := hadj
    by_cases hbv : b = v
    · -- `b` が葉なら、その辺は `e` しかない。`u` は `e` のもう一方の端である。
      have hincb : s f = v ∨ t f = v := by
        rcases hcase with ⟨hsf, _⟩ | ⟨_, htf⟩
        · exact Or.inl (hbv ▸ hsf)
        · exact Or.inr (hbv ▸ htf)
      have hfe : f = e := hunique f hfS hincb
      subst hfe
      -- `e` の端は `v` と `w` なので、`u = w` である（自己ループは次数 2 になるので除かれる）。
      have huw : u = w := by
        rcases hends with ⟨hse, hte⟩ | ⟨hse, hte⟩ <;> rcases hcase with ⟨h1, h2⟩ | ⟨h1, h2⟩
        · rw [← h2, hte]
        · exfalso
          have hnot : ¬ (s f = v ∧ t f = v) := by
            rintro ⟨hs1, ht1⟩
            have h3 : 0 < (S.filter (fun x => s x = v)).card :=
              Finset.card_pos.mpr ⟨f, Finset.mem_filter.mpr ⟨hfS, hs1⟩⟩
            have h4 : 0 < (S.filter (fun x => t x = v)).card :=
              Finset.card_pos.mpr ⟨f, Finset.mem_filter.mpr ⟨hfS, ht1⟩⟩
            simp only [degOn] at hdeg; omega
          exact hnot ⟨hse, by rw [h2, hbv]⟩
        · exfalso
          have hnot : ¬ (s f = v ∧ t f = v) := by
            rintro ⟨hs1, ht1⟩
            have h3 : 0 < (S.filter (fun x => s x = v)).card :=
              Finset.card_pos.mpr ⟨f, Finset.mem_filter.mpr ⟨hfS, hs1⟩⟩
            have h4 : 0 < (S.filter (fun x => t x = v)).card :=
              Finset.card_pos.mpr ⟨f, Finset.mem_filter.mpr ⟨hfS, ht1⟩⟩
            simp only [degOn] at hdeg; omega
          exact hnot ⟨by rw [h1, hbv], hte⟩
        · rw [← h1, hse]
      have hivb : (if b = v then w else b) = w := by simp [hbv]
      rw [hivb] at ih
      by_cases huv : u = v
      · simp [huv]
        -- `u = v` かつ `u = w` なら `v = w`。ih がそのまま使える。
        rw [← huw] at ih ⊢
        exact ih
      · simp [huv, huw]
        exact ih
    · -- `b` が葉でないなら、辺 `f` は `e` ではない（`e` の端の一方は `v` である）。
      have hivb : (if b = v then w else b) = b := by simp [hbv]
      rw [hivb] at ih
      by_cases huv : u = v
      · -- `u` が葉なら、辺は `e` しかなく、`b` はもう一方の端 `w` である。
        have hincu : s f = v ∨ t f = v := by
          rcases hcase with ⟨_, h2⟩ | ⟨h1, _⟩
          · exact Or.inr (huv ▸ h2)
          · exact Or.inl (huv ▸ h1)
        have hfe : f = e := hunique f hfS hincu
        subst hfe
        have hbw : b = w := by
          rcases hends with ⟨hse, hte⟩ | ⟨hse, hte⟩ <;> rcases hcase with ⟨h1, h2⟩ | ⟨h1, h2⟩
          · exact absurd (hse.symm.trans h1).symm hbv
          · rw [← h2, hte]
          · rw [← h1, hse]
          · exact absurd (hte.symm.trans h2).symm hbv
        simp [huv]
        rw [← hbw]
        exact ih
      · -- どちらの端も葉でないので `f ≠ e`。そのまま 1 歩伸ばす。
        have hfe : f ≠ e := by
          intro hfe
          subst hfe
          rcases hends with ⟨hse, hte⟩ | ⟨hse, hte⟩ <;> rcases hcase with ⟨h1, h2⟩ | ⟨h1, h2⟩
          · exact hbv (h1.symm.trans hse)
          · exact huv (h1.symm.trans hse)
          · exact huv (h2.symm.trans hte)
          · exact hbv (h2.symm.trans hte)
        simp [huv]
        exact ih.tail ⟨f, Finset.mem_erase.mpr ⟨hfe, hfS⟩, hcase⟩

/-- **逆向きの帰納法（matrix-tree の残っていた段）**。

辺の本数が $|W|-1$ で、根 `r0` から `W` の全頂点へ届くなら、
根の行を落とした小行列式は $\pm1$ である。

帰納法は辺の本数についてで、1 歩は次のとおり。葉 `v` とその 1 本の辺 `e` を取り
（`exists_leaf_ne_root_on` と `exists_unique_incident_of_degOn_one`）、
葉の行に沿って展開する（`det_submatrix_eq_of_leaf`）。
残る小行列式は、葉と葉の辺を取り除いたグラフのものになっており
（行と列の並べ方が `Fin.succAbove` でちょうど 1 つずつ縮む）、
取り除いても残りは根から届く（`reachOn_erase_of_leaf`）ので帰納法の仮定が当たる。

`det_submatrix_eq_zero_of_not_reach` と合わせると、
**小行列式は、辺集合が全体を連結にするときちょうど $\pm1$、しないとき $0$ である。**
これが Kirchhoff の右辺を全域木の個数として数え上げるために要っていた同定である。 -/
theorem det_submatrix_eq_one_or_neg_one (s t : E → V) :
    ∀ (k : ℕ) (W : Finset V) (S : Finset E) (r0 : V) (r : Fin k → V) (c : Fin k → E),
      EdgesWithin s t S W → r0 ∈ W → S.card + 1 = W.card →
      (∀ u ∈ W, ReachOn s t S r0 u) →
      Function.Injective r → (∀ i, r i ∈ W.erase r0) → (∀ u ∈ W.erase r0, ∃ i, r i = u) →
      Function.Injective c → (∀ j, c j ∈ S) →
      ((incMatrixSigned s t).submatrix r c).det = 1 ∨
        ((incMatrixSigned s t).submatrix r c).det = -1 := by
  classical
  intro k
  induction k with
  | zero =>
    intro _ _ _ _ _ _ _ _ _ _ _ _ _ _
    left
    exact Matrix.det_fin_zero
  | succ n ih =>
    intro W S r0 r c hEW hr0W hcard hreach hrinj hrmem hrsurj hcinj hcmem
    -- 行の並べ方が全単射なので、辺の本数は `n + 1` である。
    have hWerase : (W.erase r0).card = W.card - 1 := Finset.card_erase_of_mem hr0W
    have hk : n + 1 = (W.erase r0).card := by
      have hsub : Finset.image r Finset.univ = W.erase r0 := by
        refine Finset.Subset.antisymm ?_ ?_
        · intro u hu
          obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hu
          exact hrmem i
        · intro u hu
          obtain ⟨i, hi⟩ := hrsurj u hu
          exact Finset.mem_image.mpr ⟨i, Finset.mem_univ _, hi⟩
      have := Finset.card_image_of_injective (Finset.univ : Finset (Fin (n + 1))) hrinj
      rw [hsub, Finset.card_univ, Fintype.card_fin] at this
      exact this.symm
    have hScard : S.card = n + 1 := by omega
    have hWcard : 2 ≤ W.card := by omega
    -- 葉とその 1 本の辺を取る。
    obtain ⟨v, hvW, hvr0, hdeg1⟩ :=
      exists_leaf_ne_root_on s t S W r0 hEW hr0W hcard hreach hWcard
    obtain ⟨e, heS, hinc, hunique⟩ := exists_unique_incident_of_degOn_one s t S hdeg1
    have hdegle : degOn s t S v ≤ 1 := by omega
    obtain ⟨i0, hi0⟩ := hrsurj v (Finset.mem_erase.mpr ⟨hvr0, hvW⟩)
    -- 列の並べ方は単射で本数が一致するので、全単射である。
    have hcsurj : ∀ f ∈ S, ∃ j, c j = f := by
      have hsub : Finset.image c Finset.univ ⊆ S := by
        intro f hf
        obtain ⟨j, -, rfl⟩ := Finset.mem_image.mp hf
        exact hcmem j
      have hcardim : (Finset.image c Finset.univ).card = n + 1 := by
        rw [Finset.card_image_of_injective _ hcinj, Finset.card_univ, Fintype.card_fin]
      have himg : Finset.image c Finset.univ = S :=
        Finset.eq_of_subset_of_card_le hsub (by omega)
      intro f hf
      obtain ⟨j, -, hj⟩ := Finset.mem_image.mp (himg ▸ hf)
      exact ⟨j, hj⟩
    obtain ⟨j0, hj0⟩ := hcsurj e heS
    -- 葉の行に沿って展開する。
    rw [det_submatrix_eq_of_leaf s t S hdegle heS hinc r c hcmem hcinj i0 j0 hi0 hj0,
      Matrix.submatrix_submatrix]
    -- 葉の辺のもう一方の端。
    obtain ⟨w, hends⟩ : ∃ w : V, (s e = v ∧ t e = w) ∨ (s e = w ∧ t e = v) := by
      by_cases h : s e = v
      · exact ⟨t e, Or.inl ⟨h, rfl⟩⟩
      · exact ⟨s e, Or.inr ⟨rfl, hinc.resolve_left h⟩⟩
    -- 葉に接する辺は `e` だけなので、他の辺は葉に触れない。
    have hother : ∀ f ∈ S, f ≠ e → s f ≠ v ∧ t f ≠ v := by
      intro f hfS hfe
      constructor <;> intro hcontra
      · exact hfe (hunique f hfS (Or.inl hcontra))
      · exact hfe (hunique f hfS (Or.inr hcontra))
    -- 小さいグラフの側の仮定をそろえる。
    have hEW' : EdgesWithin s t (S.erase e) (W.erase v) := by
      intro f hf
      obtain ⟨hfe, hfS⟩ := Finset.mem_erase.mp hf
      obtain ⟨h1, h2⟩ := hother f hfS hfe
      exact ⟨Finset.mem_erase.mpr ⟨h1, (hEW f hfS).1⟩,
        Finset.mem_erase.mpr ⟨h2, (hEW f hfS).2⟩⟩
    have hr0W' : r0 ∈ W.erase v := Finset.mem_erase.mpr ⟨fun h => hvr0 h.symm, hr0W⟩
    have hScard' : (S.erase e).card = n := by
      rw [Finset.card_erase_of_mem heS, hScard]
      omega
    have hWcard' : (W.erase v).card = W.card - 1 := Finset.card_erase_of_mem hvW
    have hcard' : (S.erase e).card + 1 = (W.erase v).card := by omega
    have hreach' : ∀ u ∈ W.erase v, ReachOn s t (S.erase e) r0 u := by
      intro u hu
      obtain ⟨huv, huW⟩ := Finset.mem_erase.mp hu
      have := reachOn_erase_of_leaf s t S heS hdeg1 hunique hends
        (fun h => hvr0 h.symm) (hreach u huW)
      simpa [huv] using this
    -- 行と列の並べ方が `succAbove` でちょうど 1 つずつ縮む。
    have hrinj' : Function.Injective (r ∘ i0.succAbove) :=
      hrinj.comp (Fin.succAbove_right_injective)
    have hcinj' : Function.Injective (c ∘ j0.succAbove) :=
      hcinj.comp (Fin.succAbove_right_injective)
    have hrmem' : ∀ i, (r ∘ i0.succAbove) i ∈ (W.erase v).erase r0 := by
      intro i
      obtain ⟨hne, hmem⟩ := Finset.mem_erase.mp (hrmem (i0.succAbove i))
      refine Finset.mem_erase.mpr ⟨hne, Finset.mem_erase.mpr ⟨?_, hmem⟩⟩
      intro hcontra
      exact (Fin.succAbove_ne i0 i)
        (hrinj (by rw [show r (i0.succAbove i) = v from hcontra, hi0]))
    have hrsurj' : ∀ u ∈ (W.erase v).erase r0, ∃ i, (r ∘ i0.succAbove) i = u := by
      intro u hu
      obtain ⟨hur0, hu'⟩ := Finset.mem_erase.mp hu
      obtain ⟨huv, huW⟩ := Finset.mem_erase.mp hu'
      obtain ⟨i, hi⟩ := hrsurj u (Finset.mem_erase.mpr ⟨hur0, huW⟩)
      have hii0 : i ≠ i0 := by
        intro hcontra
        exact huv (by rw [← hi, hcontra, hi0])
      obtain ⟨i', hi'⟩ := Fin.exists_succAbove_eq hii0
      exact ⟨i', by simp [Function.comp, hi', hi]⟩
    have hcmem' : ∀ j, (c ∘ j0.succAbove) j ∈ S.erase e := by
      intro j
      refine Finset.mem_erase.mpr ⟨?_, hcmem _⟩
      intro hcontra
      exact (Fin.succAbove_ne j0 j)
        (hcinj (by rw [show c (j0.succAbove j) = e from hcontra, hj0]))
    have hsmall := ih (W.erase v) (S.erase e) r0 (r ∘ i0.succAbove) (c ∘ j0.succAbove)
      hEW' hr0W' hcard' hreach' hrinj' hrmem' hrsurj' hcinj' hcmem'
    -- 符号 3 つの積なので、全体も ±1 である。
    have hentry := incMatrixSigned_leaf_eq_one_or_neg_one s t S hdegle heS hinc
    rcases Nat.even_or_odd ((i0 : ℕ) + (j0 : ℕ)) with hpar | hpar
    · rcases hentry with h1 | h1 <;> rcases hsmall with h2 | h2 <;>
        rw [h1, h2, hpar.neg_one_pow] <;> simp
    · rcases hentry with h1 | h1 <;> rcases hsmall with h2 | h2 <;>
        rw [h1, h2, hpar.neg_one_pow] <;> simp

/-- **頂点全体を取った場合**（段 3 と同じ形の仮定で述べたもの）。 -/
theorem det_submatrix_eq_one_or_neg_one_of_reach (s t : E → V) (S : Finset E) (r0 : V)
    (hcard : S.card + 1 = Fintype.card V) (hreach : ∀ u : V, ReachOn s t S r0 u)
    {k : ℕ} (r : Fin k → V) (hrinj : Function.Injective r) (hr0 : ∀ i, r i ≠ r0)
    (hrsurj : ∀ v : V, v ≠ r0 → ∃ i, r i = v)
    (c : Fin k → E) (hcinj : Function.Injective c) (hc : ∀ j, c j ∈ S) :
    ((incMatrixSigned s t).submatrix r c).det = 1 ∨
      ((incMatrixSigned s t).submatrix r c).det = -1 := by
  classical
  refine det_submatrix_eq_one_or_neg_one s t k Finset.univ S r0 r c
    (fun e _ => ⟨Finset.mem_univ _, Finset.mem_univ _⟩) (Finset.mem_univ _)
    (by rw [Finset.card_univ]; exact hcard) (fun u _ => hreach u) hrinj
    (fun i => Finset.mem_erase.mpr ⟨hr0 i, Finset.mem_univ _⟩)
    (fun u hu => hrsurj u (Finset.mem_erase.mp hu).1) hcinj hc

/-- **全域木の同定（matrix-tree の右辺が数えているものの正体）**。

辺の本数が $|V|-1$ のとき、根の行を落とした小行列式は
**辺集合が全体を連結にするならちょうど $\pm1$、しないなら $0$ である。**
したがって $\det(D_0D_0^{\mathsf T})=\sum_S\det(D_S)^2$ の各項は、
全域木のとき $1$、そうでないとき $0$ になる。

`KirchhoffCounting.det_mul_transpose_eq_card` が数えている
「小行列式が $0$ でない辺集合」は、これでちょうど全域木の集合だと同定される。 -/
theorem det_submatrix_ne_zero_iff_reach (s t : E → V) (S : Finset E) (r0 : V)
    (hcard : S.card + 1 = Fintype.card V)
    {k : ℕ} (r : Fin k → V) (hrinj : Function.Injective r) (hr0 : ∀ i, r i ≠ r0)
    (hrsurj : ∀ v : V, v ≠ r0 → ∃ i, r i = v)
    (c : Fin k → E) (hcinj : Function.Injective c) (hc : ∀ j, c j ∈ S) :
    ((incMatrixSigned s t).submatrix r c).det ≠ 0 ↔ ∀ u : V, ReachOn s t S r0 u := by
  constructor
  · intro hne u
    by_contra hcon
    exact hne (det_submatrix_eq_zero_of_not_reach s t S r0 u hcon r hrinj hr0 hrsurj c hc)
  · intro hreach
    rcases det_submatrix_eq_one_or_neg_one_of_reach s t S r0 hcard hreach
      r hrinj hr0 hrsurj c hcinj hc with h | h <;> rw [h] <;> norm_num

end OnSubset

end SpanningConnectivity
end IntegrableLattice
