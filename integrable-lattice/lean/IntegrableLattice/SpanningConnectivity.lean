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

## 形式化しなかったもの

* **逆向きの帰納法そのもの**（葉の行に沿った行列式の展開と、葉を除いた小さいグラフへの帰納）。
  入口（葉の存在）は段 4 に入ったが、展開と帰納は書いていない。
* **指標分解**（塔の各レベルへ分ける段）。これは別の段である。
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

end SpanningConnectivity
end IntegrableLattice
