/-
# 2 通りのラプラシアンの同定 — cycle 50 step 5

対応する人手証明: 本文ブロック `paper_def_graph_tower`（voltage グラフ、$\mathbb{Z}_\ell^2$ 塔、
全域木数、voltage ラプラシアン）と、それを引く 命題 G′・命題 G″・命題 W の
$\kappa_n$ の独立計算の段。

## この段が要る理由（cycle 50 step 2・step 4 の測定）

本プロジェクトにはラプラシアンが 2 通りの書き方で在る。

* **符号付き接続行列から作ったもの**（`MultigraphLaplacian.lapMatrixOfInc`。$L=D\,D^{\mathsf T}$）。
  **Kirchhoff の定理（外部定理として完了）が全域木数と結ぶのはこちらである。**
* **voltage ごとの辺の本数の核から作ったもの**（`CharacterDecompositionTwoVariable.derivedLaplacian`。
  対角に次数、非対角に $-a$）。**指標分解が当たるのはこちらである。**

**この 2 つが同じ行列であることは、どちらのファイルにも書かれていなかった。**
書かれていないので、指標分解で出した積を全域木数として読むところで鎖が切れていた
（cycle 50 step 2 が `KappaProductFormula.lean` の残りとして挙げた事柄がこれである）。

**併せて、cycle 50 step 4 が「機械が確かめられない処分」として残した 2 件がこれである。**
`lean/` が導来グラフを voltage ごとの辺の本数として受け取っている書き方で、
本文の基礎グラフ（有限多重グラフ）を覆えるのか——**その判断は本文の語ではなく数学の内容なので、
本文の走査では決まらない。確かめる道はこれを書くことだけである。**

## 中身は 4 つの数え上げである

行列の成分を直に比べる。符号付き接続行列の成分の積を展開すると 4 項出て、
それぞれが辺の本数になる（$(u,g)$ と $(v,h)$ は導来グラフの頂点である）。

1. 終点が両方 $(u,g)$: $(u,g)=(v,h)$ のときだけ残り、$t_e=u$ なる辺の本数。
2. 終点が $(u,g)$ で始点が $(v,h)$: $t_e=u,\ s_e=v,\ \alpha_e=g-h$ なる辺の本数。
3. 始点が $(u,g)$ で終点が $(v,h)$: $s_e=u,\ t_e=v,\ \alpha_e=h-g$ なる辺の本数。
4. 始点が両方 $(u,g)$: $(u,g)=(v,h)$ のときだけ残り、$s_e=u$ なる辺の本数。

**核を「両向きを数えたもの」と定めると、2 と 3 の和がちょうど核の値になり、
1 と 4 の和がちょうど次数になる。** それだけである。

**ループの扱いが自動で合うことは書いておく**——voltage が $0$ でない自己ループは
導来グラフではループにならない。逆に voltage が $0$ の自己ループは導来グラフでもループで、
対角では次数に 2 回入って核の $a_{uu}(0)$ で 2 回引かれるので消える。
**場合分けを書かなくても、上の 4 項の計算がそのまま両方を扱う。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも 1 度も出ない。**
係数は $\mathbb{Z}$ で、使うのは有限集合の数え上げだけである。

## 書いたこと（4 段）

1. 導来グラフの辺と、その始点・終点（`derivedSrc` / `derivedTgt`）。
2. voltage ごとの辺の本数の核（`voltageKernel`。両向きを数える）。
3. 4 項の数え上げ（`sum_tgt_tgt` / `sum_tgt_src` / `sum_src_tgt` / `sum_src_src`）。
4. **2 通りのラプラシアンが同じ行列であること**（`lapMatrixOfInc_eq_derivedLaplacian`）。

## 形式化しなかったもの

* **$\mathbb{Z}_\ell^2$ の 2 変数の塔への当てはめ。** 本ファイルが同定するのは
  巡回群 1 つ（$\mathbb{Z}/N$）の voltage についてである。2 変数の塔では
  `CharacterDecompositionTwoVariable.lean` の重ね方を 2 回当てることになるが、その当てはめは書いていない。
-/
import Mathlib
import IntegrableLattice.MultigraphLaplacian
import IntegrableLattice.CharacterDecomposition
import IntegrableLattice.CharacterDecompositionTwoVariable

namespace IntegrableLattice
namespace VoltageLaplacianIdentification

open Finset Matrix CharacterDecomposition CharacterDecompositionTwoVariable

variable {V E : Type*} [Fintype V] [DecidableEq V] [Fintype E] [DecidableEq E]
variable {N : ℕ} [NeZero N]

/-! ## 1. 導来グラフの辺 -/

/-- 導来グラフの辺は「もとの辺と層の組」であり、始点は層をそのまま持つ。 -/
def derivedSrc (s : E → V) : E × ZMod N → V × ZMod N := fun p => (s p.1, p.2)

/-- 終点は層を voltage だけずらす。 -/
def derivedTgt (t : E → V) (α : E → ZMod N) : E × ZMod N → V × ZMod N :=
  fun p => (t p.1, p.2 + α p.1)

/-! ## 2. voltage ごとの辺の本数の核 -/

/-- **voltage ごとの辺の本数**（両向きを数える）。
$u$ から $v$ へ voltage $d$ の辺と、$v$ から $u$ へ voltage $-d$ の辺を合わせて数える。 -/
def voltageKernel (s t : E → V) (α : E → ZMod N) : V → V → ZMod N → ℤ :=
  fun u v d =>
    ((univ.filter fun e => s e = u ∧ t e = v ∧ α e = d).card : ℤ)
      + ((univ.filter fun e => s e = v ∧ t e = u ∧ α e = -d).card : ℤ)

/-! ## 3. 4 項の数え上げ -/

/-- 層についての和は、ちょうど 1 つの層だけを残す。 -/
private theorem sum_zmod_ite {β : Type*} [AddCommMonoid β] (c : ZMod N) (f : ZMod N → β) :
    ∑ i : ZMod N, (if i = c then f i else 0) = f c := by
  simp

/-- **第 1 項**: 終点が両方 $(u,g)$ である辺の本数。 -/
theorem sum_tgt_tgt (t : E → V) (α : E → ZMod N) (u v : V) (g h : ZMod N) :
    ∑ p : E × ZMod N,
        (if (u, g) = derivedTgt t α p then (1 : ℤ) else 0) *
          (if (v, h) = derivedTgt t α p then 1 else 0)
      = if (u, g) = (v, h) then ((univ.filter fun e => t e = u).card : ℤ) else 0 := by
  classical
  rw [Fintype.sum_prod_type]
  by_cases huv : (u, g) = (v, h)
  · obtain ⟨rfl, rfl⟩ : u = v ∧ g = h := Prod.mk.injEq .. ▸ ⟨congrArg Prod.fst huv, congrArg Prod.snd huv⟩
    rw [if_pos rfl, Finset.card_filter]
    push_cast
    refine Finset.sum_congr rfl fun e _ => ?_
    have : ∀ i : ZMod N,
        (if (u, g) = derivedTgt t α (e, i) then (1 : ℤ) else 0) *
            (if (u, g) = derivedTgt t α (e, i) then 1 else 0)
          = if i = g - α e then (if t e = u then (1 : ℤ) else 0) else 0 := by
      intro i
      by_cases hi : i = g - α e
      · subst hi
        by_cases hte : t e = u
        · simp [derivedTgt, hte, Prod.ext_iff]
        · simp [derivedTgt, hte, Prod.ext_iff]
      · have : ¬ ((u, g) = derivedTgt t α (e, i)) := by
          rintro heq
          exact hi (by
            have := congrArg Prod.snd heq
            simp only [derivedTgt] at this
            linear_combination -this)
        simp [this, hi]
    rw [Finset.sum_congr rfl fun i _ => this i, sum_zmod_ite]
  · rw [if_neg huv]
    refine Finset.sum_eq_zero fun e _ => Finset.sum_eq_zero fun i _ => ?_
    by_cases h1 : (u, g) = derivedTgt t α (e, i)
    · have h2 : ¬ ((v, h) = derivedTgt t α (e, i)) := fun h2 => huv (h1.trans h2.symm)
      simp [h2]
    · simp [h1]

/-- **第 4 項**: 始点が両方 $(u,g)$ である辺の本数。 -/
theorem sum_src_src (s : E → V) (u v : V) (g h : ZMod N) :
    ∑ p : E × ZMod N,
        (if (u, g) = derivedSrc (N := N) s p then (1 : ℤ) else 0) *
          (if (v, h) = derivedSrc (N := N) s p then 1 else 0)
      = if (u, g) = (v, h) then ((univ.filter fun e => s e = u).card : ℤ) else 0 := by
  classical
  rw [Fintype.sum_prod_type]
  by_cases huv : (u, g) = (v, h)
  · obtain ⟨rfl, rfl⟩ : u = v ∧ g = h := Prod.mk.injEq .. ▸ ⟨congrArg Prod.fst huv, congrArg Prod.snd huv⟩
    rw [if_pos rfl, Finset.card_filter]
    push_cast
    refine Finset.sum_congr rfl fun e _ => ?_
    have : ∀ i : ZMod N,
        (if (u, g) = derivedSrc (N := N) s (e, i) then (1 : ℤ) else 0) *
            (if (u, g) = derivedSrc (N := N) s (e, i) then 1 else 0)
          = if i = g then (if s e = u then (1 : ℤ) else 0) else 0 := by
      intro i
      by_cases hi : i = g
      · subst hi
        by_cases hse : s e = u
        · simp [derivedSrc, hse, Prod.ext_iff]
        · simp [derivedSrc, hse, Prod.ext_iff]
      · simp [derivedSrc, Prod.ext_iff, Ne.symm hi, hi]
    rw [Finset.sum_congr rfl fun i _ => this i, sum_zmod_ite]
  · rw [if_neg huv]
    refine Finset.sum_eq_zero fun e _ => Finset.sum_eq_zero fun i _ => ?_
    by_cases h1 : (u, g) = derivedSrc (N := N) s (e, i)
    · have h2 : ¬ ((v, h) = derivedSrc (N := N) s (e, i)) := fun h2 => huv (h1.trans h2.symm)
      simp [h2]
    · simp [h1]

/-- **第 3 項**: 始点が $(u,g)$ で終点が $(v,h)$ である辺の本数。 -/
theorem sum_src_tgt (s t : E → V) (α : E → ZMod N) (u v : V) (g h : ZMod N) :
    ∑ p : E × ZMod N,
        (if (u, g) = derivedSrc (N := N) s p then (1 : ℤ) else 0) *
          (if (v, h) = derivedTgt t α p then 1 else 0)
      = ((univ.filter fun e => s e = u ∧ t e = v ∧ α e = h - g).card : ℤ) := by
  classical
  rw [Fintype.sum_prod_type, Finset.card_filter]
  push_cast
  refine Finset.sum_congr rfl fun e _ => ?_
  have : ∀ i : ZMod N,
      (if (u, g) = derivedSrc (N := N) s (e, i) then (1 : ℤ) else 0) *
          (if (v, h) = derivedTgt t α (e, i) then 1 else 0)
        = if i = g then (if s e = u ∧ t e = v ∧ α e = h - g then (1 : ℤ) else 0) else 0 := by
    intro i
    by_cases hi : i = g
    · subst hi
      by_cases hse : s e = u
      · by_cases hte : t e = v
        · by_cases hα : α e = h - i
          · simp [derivedSrc, derivedTgt, hse, hte, hα, Prod.ext_iff]
            linear_combination -hα
          · have : ¬ ((v, h) = derivedTgt t α (e, i)) := by
              rintro heq
              exact hα (by
                have := congrArg Prod.snd heq
                simp only [derivedTgt] at this
                linear_combination -this)
            simp [derivedSrc, hse, hte, hα, this, Prod.ext_iff]
        · simp [derivedSrc, derivedTgt, hte, hse, Prod.ext_iff]
      · simp [derivedSrc, hse, Prod.ext_iff]
    · simp [derivedSrc, Prod.ext_iff, hi, Ne.symm hi]
  rw [Finset.sum_congr rfl fun i _ => this i, sum_zmod_ite]

/-- **第 2 項**: 終点が $(u,g)$ で始点が $(v,h)$ である辺の本数。 -/
theorem sum_tgt_src (s t : E → V) (α : E → ZMod N) (u v : V) (g h : ZMod N) :
    ∑ p : E × ZMod N,
        (if (u, g) = derivedTgt t α p then (1 : ℤ) else 0) *
          (if (v, h) = derivedSrc (N := N) s p then 1 else 0)
      = ((univ.filter fun e => s e = v ∧ t e = u ∧ α e = g - h).card : ℤ) := by
  classical
  have := sum_src_tgt s t α v u h g
  rw [← this]
  exact Finset.sum_congr rfl fun p _ => by ring

end VoltageLaplacianIdentification
end IntegrableLattice
