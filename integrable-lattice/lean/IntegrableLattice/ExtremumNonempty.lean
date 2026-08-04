/-
# 検査 M の「構成から空でない」の裏取り

検査 M（`structured-latex/tools/verify-extremum.ts`）は、本文の $\min$ / $\max$ のうち
判断が要る出現を台帳で管理している。根拠 4 種のうち 3 種は目印の実在を機械が確かめるが、
**「構成から空でない」（17 件）だけは機械で確かめられない**——「この添字族は空でない」は
数学の判断であって tex の文字列からは出ないからである。

本ファイルは、その 17 件のうち**主張として述べられるものを Lean で証明する**。
台帳の各件は `leanTheorem` フィールドでここの定理名を指し、検査 M が
「宣言された定理名が `lean/` に実在すること」と「17 件のうち何件が裏を取れているか」を印字する。

## 裏を取れないもの（理由を名指しする）

* $\max_{\mathfrak p\mid p}$ の添字族（命題 W*）——「有理素数 $p$ の上には少なくとも 1 つ素イデアルがある」。
  Dedekind 環の素イデアル分解が要る。mathlib に素材は在るが、本論文の $A=\mathbb{Z}[x]/(\rho)$ を
  Dedekind 環として与える配線が無い（`PropWStarDifferent.lean` が残した双対の段と同じ壁）。
* $\min\{j\ge0: p^j\eta^{-1}\in A_{(p)}\}$ の 3 件（命題 W*）——同じ理由。
  $\eta\neq0$ から $j$ の存在を出すには局所化と付値の配線が要る。

**この 4 件は「難しそう」ではなく、どの配線が無いかを名指ししてある。**
-/
import Mathlib

namespace IntegrableLattice

open Finset

/-! ## 有限な添字族が空でないこと

台帳の多くはこの形である。数学的には自明だが、**自明であることと機械が確かめたことは別**なので、
主張として書いて型に通す。 -/

/-- 命題 C″: `0 ≤ N < r` を走る添字族は `r ≥ 1` なら空でない。 -/
theorem range_nonempty_of_one_le {r : ℕ} (hr : 1 ≤ r) : (Finset.range r).Nonempty :=
  Finset.nonempty_range_iff.mpr (by omega)

/-- 命題 R: 桁 `c ∈ {0, 1, …, ℓ-1}` を走る添字族は `ℓ ≥ 2` なら空でない。 -/
theorem digit_range_nonempty {l : ℕ} (hl : 2 ≤ l) : (Finset.range l).Nonempty :=
  range_nonempty_of_one_le (by omega)

/-- 命題 U: `0 ≤ k ≤ K` を走る添字族は空でない（`K ≥ 0` は `ℕ` では自動）。 -/
theorem Icc_zero_nonempty (K : ℕ) : (Finset.Icc 0 K).Nonempty :=
  ⟨0, Finset.mem_Icc.mpr ⟨le_rfl, Nat.zero_le K⟩⟩

/-- 命題 J・M: `{m ≥ 0}` や `{j ≥ 0}` を走る添字族は空でない。
`ℕ` 上の族なので、`0` が属することがそのまま根拠である。 -/
theorem nat_index_nonempty (S : Set ℕ) (h : 0 ∈ S) : S.Nonempty := ⟨0, h⟩

/-- 命題 J: 相異なる `γ_1, …, γ_k` を走る添字族は `k ≥ 1` なら空でない。 -/
theorem fin_nonempty_of_one_le {k : ℕ} (hk : 1 ≤ k) : Nonempty (Fin k) :=
  ⟨⟨0, by omega⟩⟩

/-! ## 0 でない多項式は台が空でない

命題 G の $k_{\min}=\min\{d:\varepsilon_d<\infty\}$ と、命題 M の $\min_m v(\alpha_m)$ は
どちらも「$0$ でないのだから係数が $0$ でない次数がある」に帰着する。 -/

/-- 命題 M: `α ≠ 0` なる多項式の台は空でない。
したがって `\min_m v(α_m)` の添字族は空でない。 -/
theorem support_nonempty_of_ne_zero {R : Type*} [Semiring R] {α : Polynomial R} (hα : α ≠ 0) :
    α.support.Nonempty :=
  Polynomial.nonempty_support_iff.mpr hα

/-- 命題 G: 2 変数の場合。`g ≠ 0` なら、係数が `0` でない次数の組がある。
本文の $\varepsilon_d<\infty$ なる $d$ が存在することがこれにあたる
（同次部分が `0` でない次数 `d` が存在する）。 -/
theorem mv_support_nonempty_of_ne_zero {σ R : Type*} [CommSemiring R] {g : MvPolynomial σ R}
    (hg : g ≠ 0) : g.support.Nonempty := by
  rw [Finset.nonempty_iff_ne_empty]
  intro h
  exact hg (MvPolynomial.support_eq_empty.mp h)

/-! ## 非有界性から存在を出す

命題 Q の $c_1=\min\{c\ge0: 2b<(\ell-1)\ell^{c}\}$。 -/

/-- 命題 Q: `ℓ ≥ 2` なら、どんな `b` に対しても `2b < (ℓ-1)ℓ^c` を満たす `c` がある。
したがって `c_1` を定める集合は空でない。 -/
theorem exists_pow_gt {l b : ℕ} (hl : 2 ≤ l) : ∃ c : ℕ, 2 * b < (l - 1) * l ^ c := by
  obtain ⟨c, hc⟩ := pow_unbounded_of_one_lt (2 * b) (by omega : 1 < l)
  refine ⟨c, ?_⟩
  have h1 : 1 * l ^ c ≤ (l - 1) * l ^ c := Nat.mul_le_mul (by omega) le_rfl
  rw [one_mul] at h1
  omega

/-! ## 代数閉体上、次数 1 以上の多項式は根をもつ

命題 N の $\min_i v_p(\lambda_i)$。添字 $i$ は $\chi_T$ の根（重複込みで $d$ 個）を走るので、
$d\ge1$ なら空でない。 -/

/-- 命題 N: 代数閉体上、次数 `d ≥ 1` の多項式は根をもつ。
`T ∈ M_d(ℤ)` の特性多項式は次数 `d` のモニックなので、`d ≥ 1` ならこれが使える。
すなわち固有値を走る添字族は空でない。 -/
theorem exists_root_of_one_le_natDegree {K : Type*} [Field K] [IsAlgClosed K]
    {f : Polynomial K} (hf : 1 ≤ f.natDegree) : ∃ x, f.IsRoot x := by
  refine IsAlgClosed.exists_root f ?_
  intro h
  have : f.natDegree = 0 := Polynomial.natDegree_eq_zero_iff_degree_le_zero.mpr (le_of_eq h)
  omega

end IntegrableLattice
