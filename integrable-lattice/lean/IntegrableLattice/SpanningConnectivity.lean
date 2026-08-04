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

## 形式化しなかったもの

* **逆向き（連結なら小行列式が $\pm1$）**。葉に沿った展開の帰納法になる。書いていない。
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

end SpanningConnectivity
end IntegrableLattice
