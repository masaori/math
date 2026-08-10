/-
主張「巡回シフトは軌道を保つ置換である」「各行配位をそれ自身かその像へ送る軌道の上の全単射は、
恒等写像か巡回シフトの制限である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitBijectionIdOrShift`）の証明が実際に
使っているのは次だけである。証明手順は具体版と同じ（同じ場合分け・同じ向きの帰納法・
同じ除法の使い方）。

  主張                                使っている性質
  self_apply_mem_orbit                何も要らない（f(i) = f^[1](i) を書くだけ）
  eq_id_or_apply_of_fixed_or_apply    ψ が単射であること、i₀ が e ≥ 1 回の反復で戻ること、
                                      O が i₀ の反復で覆われること・反復が O に留まること

削れなかった仮定と、その理由は次のとおりである。

1. `ψ` が全単射であること。使うのは単射性だけである（「1 つ前の行配位について閉じている」
   ことを出す段で `ψ(τ') = ψ(τ)` から `τ' = τ` を得るのに要る）。全射性は使っていない。
2. `f` については**何も要求しない**。とくに `f` が単射である必要も全単射である必要もない。
   人手証明が `S` の全単射性（`claim_row_config_shift_bijective`）を引いているのは、
   `S↾_O` を `𝔅_O` の元として書くためであって、この主張の証明には現れない。
   そのため結論も `ψ = S↾_O` ではなく「各点で `ψ(i) = f(i)`」の形で述べてある。
3. `O` の各点が 1 回以上の反復でもとへ戻ること（`hperiod`）。**最小性は使っていない。**
   人手証明は最小周期 `e(τ₀)` を取っているが、証明が使うのは「1 以上の回数で戻ること」
   だけである（除法の余り `r < e` を作るのに `e ≥ 1` が、`f^[e q](i) = i` に周期が要る）。
   点ごとの仮定でよく、`f` が全体として周期を持つことは要求していない。
4. `O` の 2 点が反復で行き来できること（`hcover`）と、`O` が反復で閉じていること（`hmem`）。
   人手証明で `O(τ₀) = O` にあたる。`O` が軌道であることはこの 2 条件を通してしか使っていない。
   **この 2 つはどちらも他方から出ない**（片方だけへ弱められない）。
   `hmem` が `hcover`・`hperiod` から出ないこと: `ι = {a, b}`、`f(a) = b`、`f(b) = a`、
   `O = {a}` と取る。`hperiod` は `e = 2` で成り立ち、`hcover` は `O` の 2 点の組が
   `(a, a)` だけなので `k = 0` で成り立つが、`f^[1](a) = b ∉ O` なので `hmem` は破れる。
   `hcover` が `hmem`・`hperiod` から出ないこと: `ι = {a, b}`、`f = id`、`O = {a, b}` と取る。
   `hmem` は `f` が各点を動かさないので成り立ち、`hperiod` は `e = 1` で成り立つが、
   `b = f^[k](a) = a` を満たす `k` が無いので `hcover` は破れる
   （`O` が 2 つの軌道の合併になっている場合である）。
5. 型 `ι` に有限性も相等の判定も要らない（第 2 の主張のほう。第 1 の主張は `orbit` を
   `Finset` として書くために要る）。

mathlib の巡回群・置換の一般論（`Equiv.Perm.cycleOf`・`Function.IsPeriodicPt` など）は
引いていない。使ったのは ℕ の除法と `Equiv` の単射性だけである。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、回数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowShiftOrbit

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*}

/-- 人手証明の主張「巡回シフトは軌道を保つ置換である」の必要十分版。

`f(i) = f(f^[0](i)) = f^[1](i)` を書くだけであり、`f` にも `ι` にも何も要求しない
（`Finset` として軌道を書くための有限性と相等の判定を除く）。 -/
theorem self_apply_mem_orbit [Fintype ι] [DecidableEq ι] (f : ι → ι) (i : ι) :
    f i ∈ orbit f i :=
  mem_orbit.mpr ⟨1, rfl⟩

/-- 人手証明の主張「各行配位をそれ自身かその像へ送る軌道の上の全単射は、恒等写像か
巡回シフトの制限である」の必要十分版。

結論を写像の等号ではなく各点の等式で述べているのは、`f` の制限が `O` の上の全単射である
ことを仮定しないためである（具体版はそれを別に持っているので、そちらで `Equiv` の等号に直す）。 -/
theorem eq_id_or_apply_of_fixed_or_apply {O : Finset ι} (f : ι → ι)
    (ψ : {i : ι // i ∈ O} ≃ {i : ι // i ∈ O})
    (h : ∀ i : {i : ι // i ∈ O}, (ψ i).1 = i.1 ∨ (ψ i).1 = f i.1)
    (hperiod : ∀ i : ι, i ∈ O → ∃ e : ℕ, 1 ≤ e ∧ iterLeft f e i = i)
    (hcover : ∀ i : ι, i ∈ O → ∀ i' : ι, i' ∈ O → ∃ k : ℕ, i' = iterLeft f k i)
    (hmem : ∀ i : ι, i ∈ O → ∀ k : ℕ, iterLeft f k i ∈ O) :
    (∀ i : {i : ι // i ∈ O}, (ψ i).1 = i.1) ∨ (∀ i : {i : ι // i ∈ O}, (ψ i).1 = f i.1) := by
  classical
  by_cases hempty : ∀ i : ι, ∀ hi : i ∈ O, (ψ ⟨i, hi⟩).1 ≠ i
  · -- F = ∅ の場合。仮定の第 1 の場合が起こらない
    right
    intro i
    rcases h i with h1 | h2
    · exact absurd h1 (hempty i.1 i.2)
    · exact h2
  · -- F ≠ ∅ の場合。F = O を示す
    left
    push_neg at hempty
    obtain ⟨i₁, hi₁O, hi₁⟩ := hempty
    obtain ⟨e, hepos, hperiod₁⟩ := hperiod i₁ hi₁O
    -- 人手証明の F（ψ が動かさない点の全体）。所属の証明を持ち回さないよう述語として置く
    let Fix : ι → Prop := fun t => ∀ ht : t ∈ O, (ψ ⟨t, ht⟩).1 = t
    have hi₁Fix : Fix i₁ := fun _ => hi₁
    -- F は 1 つ前の点について閉じている（ψ の単射性を使う）
    have hclosed : ∀ t : ι, ∀ htO : t ∈ O, Fix t → ∀ t' : ι, ∀ ht' : t' ∈ O,
        f t' = t → Fix t' := by
      intro t htO hfix t' ht' hstep _
      rcases h ⟨t', ht'⟩ with h1 | h2
      · exact h1
      · -- ψ(t') = f(t') = t = ψ(t) なので単射性から t' = t、したがって ψ(t') = t'
        have heq : ψ ⟨t', ht'⟩ = ψ ⟨t, htO⟩ := Subtype.ext (by rw [h2, hstep, hfix htO])
        have ht't : t' = t := congrArg Subtype.val (ψ.injective heq)
        rw [h2, hstep, ← ht't]
    -- j ≤ e のとき f^[e-j](i₁) は F の元である（j についての帰納法）
    have hind : ∀ j : ℕ, j ≤ e → Fix (iterLeft f (e - j) i₁) := by
      intro j
      induction j with
      | zero =>
        intro _
        rw [Nat.sub_zero, hperiod₁]
        exact hi₁Fix
      | succ j ih =>
        intro hj1
        have hj : j ≤ e := by omega
        have ht'O : iterLeft f (e - j - 1) i₁ ∈ O := hmem i₁ hi₁O (e - j - 1)
        have hsucc : e - j - 1 + 1 = e - j := by omega
        have hstep : f (iterLeft f (e - j - 1) i₁) = iterLeft f (e - j) i₁ := by
          calc f (iterLeft f (e - j - 1) i₁)
              = iterLeft f (e - j - 1 + 1) i₁ := rfl
            _ = iterLeft f (e - j) i₁ := by rw [hsucc]
        have hj1eq : e - (j + 1) = e - j - 1 := by omega
        rw [hj1eq]
        exact hclosed _ (hmem i₁ hi₁O (e - j)) (ih hj) _ ht'O hstep
    -- F = O（任意の i ∈ O を i = f^[r](i₁)（r < e）の形へ直す）
    have hFO : ∀ i : ι, i ∈ O → Fix i := by
      intro i hi
      obtain ⟨k, hk⟩ := hcover i₁ hi₁O i hi
      have hcomm : k = k % e + e * (k / e) := by
        have := Nat.div_add_mod k e
        omega
      have hstep : iterLeft f k i₁ = iterLeft f (k % e) i₁ := by
        calc iterLeft f k i₁
            = iterLeft f (k % e + e * (k / e)) i₁ := by rw [← hcomm]
          _ = iterLeft f (k % e) (iterLeft f (e * (k / e)) i₁) := iterLeft_add f _ _ _
          _ = iterLeft f (k % e) i₁ := by rw [iterLeft_mul f i₁ e hperiod₁ (k / e)]
      have hrlt : k % e < e := Nat.mod_lt _ (by omega)
      have hback : e - (e - k % e) = k % e := by omega
      have hieq : i = iterLeft f (e - (e - k % e)) i₁ := by rw [hback, hk, hstep]
      rw [hieq]
      exact hind (e - k % e) (by omega)
    intro i
    exact hFO i.1 i.2 i.2

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
