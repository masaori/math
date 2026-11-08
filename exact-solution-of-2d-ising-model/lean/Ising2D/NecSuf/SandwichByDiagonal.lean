/-
# 非対角成分が 0 の行列で両側から挟んだ行列の成分（必要十分版）

人手 `W_has_positive_entries`（`structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）の Step 3 の必要十分版。
具体版: `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean`
（`physicalV1halfC_mul_V2_apply_mul_apply_of_ne`・`physicalV1halfC_apply_mul_V2_apply_of_ne`・
`physicalSymTransferC_apply_configBasisIso`・`symTransferEntryProduct_pos`・`W_has_positive_entries`）。
具体版をこのファイルの系として導出するのは `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean`。

具体版の `B := V_1^{1/2}`・`V := V_2` は複素行列（係数 `R := ℂ`）、`b(μ)`・`v(μ,μ')`・`w` は実数（`S := ℝ`）で、
`ℝ → ℂ` の埋め込みが `φ` である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| Step 3 の補助の鎖の 1 本目（`t ≠ l` で `(BV_2)_{kt}B_{tl} = 0`、2 行） | `sandwich_outer_term_of_ne`（同じ 2 段） |
| Step 3 の補助の鎖の 2 本目（`s ≠ k` で `B_{ks}(V_2)_{sl} = 0`、2 行） | `sandwich_inner_term_of_ne`（同じ 2 段） |
| Step 3 の主の鎖の 2〜9 行目（行列の積の定義 → 外側の和 `t` を潰す → 行列の積の定義 → 内側の和 `s` を潰す → `B_{kk}`・`B_{ll}` の値 → `(V_2)_{kl}` の値 → 埋め込みは積を保つ（2 回）） | `sandwich_apply_eq_map` の calc の 8 段（同じ並び） |
| Step 3 の `w := (b(μ)v(μ,μ'))b(μ') = ∏_{j=1}^{3} r_j > 0`（2 行） | `sandwich_weight_pos` の calc の 2 段 |
| 主張の形「`W_{kl} = w_φ` を満たす `w > 0` が在る」（`w := (b(μ)v(μ,μ'))b(μ')`） | `sandwich_apply_pos` |

具体版の主の鎖の 1 行目（`W_{kl} = ((BV_2)B)_{kl}`、`def_symmetrized_transfer_matrix`）は、必要十分版では `W` を初めから
`B * V * B`（Lean では左から結合して `(B * V) * B`）と書くので段は無い。

## 何が効いているか / 効いていないか

- **成分の式（`sandwich_outer_term_of_ne`・`sandwich_inner_term_of_ne`・`sandwich_apply_eq_map`）。**
  効いているのは、係数 `R` の加法が可換モノイドであること（行列の積の有限和）、`x·0 = 0`（`hz`）と `0·x = 0`（`hz0`）、
  添字が有限であること（行列の積を開く補助の鎖の 1 本目と主の鎖だけ。補助の鎖の 2 本目は積を開かないので要らない）、
  挟む行列 `B` の `l` 列の非対角成分（`hBcol`）と `k` 行の非対角成分（`hBrow`）が `0` であること、
  `B_{kk}`・`B_{ll}`・`V_{kl}` が `φ` の値であること、`φ` が積を保つこと（`hφ`）だけである。
  `hz` を削ると補助の鎖の 1 本目の最後の段（`(BV)_{kt}·0 = 0`）が、`hz0` を削ると 2 本目の最後の段（`0·V_{sl} = 0`）が閉じない。
  `hBcol`・`hBrow` を削ると、和から除く項が `0` にならない。具体版は `B` の対角性（Step 1 の `B_{pq} = 0_ℂ`）を両方へ渡す。
  `hφ` を削ると、主の鎖の最後の 2 段（`φ(b_k)φ(v_{kl}) = φ(b_k v_{kl})`・`φ(b_k v_{kl})φ(b_l) = φ((b_k v_{kl})b_l)`）が閉じない。
  `R` の分配律、`R`・`S` の乗法の結合律・可換律・単位元は効いていない
  （式の形 `(B_{kk}V_{kl})B_{ll}`・`(b_k v_{kl}) b_l` は積の並びと括弧を具体版の Step 3 のまま保つ）。
  添字の等号の判定可能性も効いていない（和を 1 項に潰すのに使うのは、除く項が `0` であることだけ）。
  `S` には乗法のほか何も要らない。`φ` が `0`・和・順序を保つことも効いていない。
  `B` の対角成分・`V` の成分が具体的に何か（具体版の `exp(½K_1 d(μ))`・`exp(K_2 e(μ,μ'))`）は効いていない。
- **正値性（`sandwich_weight_pos`・`sandwich_apply_pos`）。** 上に加えて、`S` に `0` と `<` があり、`0 < a`・`0 < b` なら
  `0 < ab`（`hmul`）であることだけが効く（`NecSuf.finProdLeft_pos'` と同じ。具体版はこれを ℝ の `mul_pos` で受ける）。
  `<` が順序であること、`R` に順序があることは効いていない。実数であること、指数関数の正値性は、
  具体版で `b(μ) > 0`・`v(μ,μ') > 0` を示すところ（準備）にだけ効いており、Step 3 には効いていない。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.FinCases
import Ising2D.NecSuf.FiniteProductOfPositiveElementsIsPositive

namespace Ising2D.NecSuf

open Matrix

variable {n R S : Type*} [Fintype n] [AddCommMonoid R] [Mul R]

/-- 具体版 Step 3 の補助の鎖の 1 本目: `B` の `l` 列の非対角成分が `0` なら、`t ≠ l` で `(BV)_{kt}B_{tl} = 0`。 -/
theorem sandwich_outer_term_of_ne (hz : ∀ x : R, x * 0 = 0) {B V : Matrix n n R} {l : n}
    (hBcol : ∀ t : n, t ≠ l → B t l = 0) (k : n) {t : n} (htl : t ≠ l) : (B * V) k t * B t l = 0 :=
  calc (B * V) k t * B t l
      = (B * V) k t * 0 := by rw [hBcol t htl]              -- `B` の非対角成分 `B_{tl} = 0`
    _ = 0 := hz _                                           -- `x·0 = 0`

omit [Fintype n] in
/-- 具体版 Step 3 の補助の鎖の 2 本目: `B` の `k` 行の非対角成分が `0` なら、`s ≠ k` で `B_{ks}V_{sl} = 0`。 -/
theorem sandwich_inner_term_of_ne (hz0 : ∀ x : R, 0 * x = 0) {B V : Matrix n n R} {k : n}
    (hBrow : ∀ s : n, s ≠ k → B k s = 0) {s : n} (l : n) (hsk : s ≠ k) : B k s * V s l = 0 :=
  calc B k s * V s l
      = 0 * V s l := by rw [hBrow s hsk]                    -- `B` の非対角成分 `B_{ks} = 0`
    _ = 0 := hz0 _                                          -- `0·x = 0`

/-- 具体版 Step 3 の主の鎖: `B` の `l` 列・`k` 行の非対角成分が `0`、`B_{kk} = φ(b_k)`・`B_{ll} = φ(b_l)`・`V_{kl} = φ(v_{kl})`、
`φ` が積を保つなら `(BVB)_{kl} = φ((b_k v_{kl}) b_l)`。外側の和 `t` を先に、内側の和 `s` を後に潰す。 -/
theorem sandwich_apply_eq_map [Mul S] (hz : ∀ x : R, x * 0 = 0) (hz0 : ∀ x : R, 0 * x = 0)
    (φ : S → R) (hφ : ∀ x y : S, φ x * φ y = φ (x * y))
    {B V : Matrix n n R} (k l : n) (hBcol : ∀ t : n, t ≠ l → B t l = 0)
    (hBrow : ∀ s : n, s ≠ k → B k s = 0) (bk vkl bl : S)
    (hBk : B k k = φ bk) (hVkl : V k l = φ vkl) (hBl : B l l = φ bl) :
    (B * V * B) k l = φ ((bk * vkl) * bl) :=
  calc (B * V * B) k l
      = ∑ t : n, (B * V) k t * B t l := Matrix.mul_apply   -- 行列の積の定義
    _ = (B * V) k l * B l l :=
        Finset.sum_eq_single l (fun _t _ htl => sandwich_outer_term_of_ne hz hBcol k htl)
          (fun h => absurd (Finset.mem_univ _) h)           -- 和の 1 項以外が `0`（補助の鎖の 1 本目）
    _ = (∑ s : n, B k s * V s l) * B l l := by
        rw [Matrix.mul_apply]                               -- 行列の積の定義
    _ = (B k k * V k l) * B l l := by
        rw [Finset.sum_eq_single k (fun _s _ hsk => sandwich_inner_term_of_ne hz0 hBrow l hsk)
          (fun h => absurd (Finset.mem_univ _) h)]          -- 和の 1 項以外が `0`（補助の鎖の 2 本目）
    _ = (φ bk * V k l) * φ bl := by rw [hBk, hBl]           -- `B_{kk} = φ(b_k)`・`B_{ll} = φ(b_l)`
    _ = (φ bk * φ vkl) * φ bl := by rw [hVkl]               -- `V_{kl} = φ(v_{kl})`
    _ = φ (bk * vkl) * φ bl := congrArg (· * φ bl) (hφ bk vkl)
                                                            -- `φ` は積を保つ
    _ = φ ((bk * vkl) * bl) := hφ (bk * vkl) bl              -- `φ` は積を保つ

/-- 具体版 Step 3 の `w > 0` の鎖: `hmul` の下で、`0 < b_k`・`0 < v_{kl}`・`0 < b_l` なら
`(b_k v_{kl}) b_l = ∏_{j=1}^{3} r_j > 0`（`r := ![b_k, v_{kl}, b_l]`、積は左から掛ける `finProdLeft`）。 -/
theorem sandwich_weight_pos [Mul S] [Zero S] [LT S] (hmul : ∀ a b : S, 0 < a → 0 < b → 0 < a * b)
    {bk vkl bl : S} (hbk : 0 < bk) (hvkl : 0 < vkl) (hbl : 0 < bl) : 0 < (bk * vkl) * bl :=
  calc (bk * vkl) * bl
      = finProdLeft 2 ![bk, vkl, bl] := rfl                -- 有限積の定義（左から掛ける）
    _ > 0 :=
        finProdLeft_pos' hmul 2 _ (fun j => by
          fin_cases j
          · exact hbk                                       -- `b_k > 0`
          · exact hvkl                                      -- `v_{kl} > 0`
          · exact hbl)                                      -- `b_l > 0`
                                                            -- 正の元の有限積は正（`m := 3`）

/-- 具体版の主張の形: 上の仮定に `0 < b_k`・`0 < v_{kl}`・`0 < b_l` と `hmul` を加えると、
`(BVB)_{kl} = φ(w)` を満たす `0 < w` が在る（`w := (b_k v_{kl}) b_l`）。 -/
theorem sandwich_apply_pos [Mul S] [Zero S] [LT S] (hmul : ∀ a b : S, 0 < a → 0 < b → 0 < a * b)
    (hz : ∀ x : R, x * 0 = 0) (hz0 : ∀ x : R, 0 * x = 0) (φ : S → R) (hφ : ∀ x y : S, φ x * φ y = φ (x * y))
    {B V : Matrix n n R} (k l : n) (hBcol : ∀ t : n, t ≠ l → B t l = 0)
    (hBrow : ∀ s : n, s ≠ k → B k s = 0) {bk vkl bl : S}
    (hBk : B k k = φ bk) (hVkl : V k l = φ vkl) (hBl : B l l = φ bl)
    (hbk : 0 < bk) (hvkl : 0 < vkl) (hbl : 0 < bl) :
    ∃ w : S, 0 < w ∧ (B * V * B) k l = φ w :=
  ⟨(bk * vkl) * bl, sandwich_weight_pos hmul hbk hvkl hbl,
    sandwich_apply_eq_map hz hz0 φ hφ k l hBcol hBrow bk vkl bl hBk hVkl hBl⟩

end Ising2D.NecSuf
