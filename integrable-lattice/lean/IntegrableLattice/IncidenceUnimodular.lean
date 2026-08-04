/-
# 符号付き接続行列の全単模性（matrix-tree 定理の第 3 段の前半）— cycle 32 step 3

対応する人手証明:

* 本文ブロック `paper_prop_T`（命題 T）の証明が引く Kirchhoff の matrix-tree 定理
* 段取りは `outputs/reports/cycle30_ops_matrix_tree_decision.md` の「書く場合の段取り（4 段）」

## この段が何を言うか

段取りの 3 は「$D$ の $(n-1)$ 列の小行列式が、その辺集合が全域木なら $\pm1$、
そうでなければ $0$」である。これは 2 つの内容からなる。

1. **どんな正方小行列を取っても行列式は $0,1,-1$ のいずれかである**（全単模性）。
2. **どちらになるかは、選んだ辺集合が全域木かどうかで決まる**（組合せの側）。

**本ファイルは 1 を証明する。2 は書いていない。**

## 1 が単独で意味を持つ理由

Cauchy–Binet（`CauchyBinet.lean`、cycle 32 step 1 で完成）から
$\det L_0=\sum_S\det(D_S)\det(D_S^{\mathsf T})=\sum_S\det(D_S)^2$ になる。
ここに 1 を入れると**各項が $0$ か $1$** になり、
$\det L_0$ が「$\det(D_S)=\pm1$ となる $S$ の個数」に等しいことが出る。
すなわち 1 だけで **Kirchhoff の右辺が「ある性質をもつ辺集合の個数」であること**が確定し、
残るのはその性質が「全域木であること」だと同定する 2 だけになる。

## 抽象度について（人手証明と同じ具体に留める）

`docs/context/証明の書き方.md` の規律に従い、**行列の成分の形だけを条件に書く**。
グラフの言葉（連結・閉路・全域木）はこの段では 1 度も要らない——
必要なのは「各列の非零成分は高々 2 つで、2 つなら $+1$ と $-1$」というだけである。
そこで条件を `IsIncidenceColumn` として述べ、接続行列がそれを満たすことを別に示す。
**これは抽象化ではなく、証明が実際に使う性質をそのまま書いたものである**
（グラフを仮定すると、証明が使っていない連結性などを読者に要求することになる）。

## 証明の筋（古典的な 3 分岐の帰納法）

正方小行列 $M$ の大きさについての帰納法。各列の非零成分は高々 2 つである。

* ある列の非零成分が $0$ 個 → その列が $0$ なので $\det M=0$。
* ある列の非零成分が 1 個 → その列で余因子展開すると $\det M=\pm\det M'$ で、
  $M'$ は 1 つ小さい小行列（行を落としても条件は保たれる）。帰納法の仮定。
* どの列も非零成分が 2 個 → 各列で $+1$ と $-1$ が 1 つずつなので**全ての行の和が $0$**。
  行が一次従属なので $\det M=0$。
-/
import Mathlib
import IntegrableLattice.MultigraphLaplacian

namespace IntegrableLattice

open Finset Matrix

/-! ## 列の形 -/

/--
**接続行列の列の形**: 成分は $0,\pm1$ のいずれかで、非零成分は高々 2 つ、
ちょうど 2 つのときは $+1$ と $-1$ が 1 つずつ（＝成分の和が $0$）。

$\sum_i|c_i|$ は「非零成分の個数」である（成分が $0,\pm1$ しかないので）。
条件をこの形で書くのは、後で行を落としたときに保たれることが見やすいからである。
-/
def IsIncidenceColumn {m : Type*} [Fintype m] (c : m → ℤ) : Prop :=
  (∀ i, c i = 0 ∨ c i = 1 ∨ c i = -1) ∧ (∑ i, |c i|) ≤ 2 ∧ ((∑ i, |c i|) = 2 → (∑ i, c i) = 0)

/-- 行を落としても列の形は保たれる（落とすと非零成分は減りこそすれ増えない）。 -/
theorem IsIncidenceColumn.comp_injective {m m' : Type*} [Fintype m] [Fintype m']
    {c : m → ℤ} (hc : IsIncidenceColumn c) (f : m' → m) (hf : Function.Injective f) :
    IsIncidenceColumn (c ∘ f) := by
  classical
  obtain ⟨hval, hle, heq⟩ := hc
  have himgAbs : (∑ x ∈ Finset.image f Finset.univ, |c x|) = ∑ i, |c (f i)| :=
    Finset.sum_image (fun x _ y _ h => hf h)
  -- 落とした後の「非零成分の個数」は元のそれ以下である。
  have hsum : (∑ i, |c (f i)|) ≤ ∑ i, |c i| := by
    rw [← himgAbs]
    exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _) fun i _ _ => abs_nonneg _
  refine ⟨fun i => hval (f i), by simpa [Function.comp_apply] using le_trans hsum hle, fun h2 => ?_⟩
  simp only [Function.comp_apply] at h2 ⊢
  -- 個数が 2 のまま残ったなら、元の列でも 2 だった。
  have hfull : (∑ i, |c i|) = 2 := le_antisymm hle (h2 ▸ hsum)
  -- 落とされた側の成分はすべて 0 である（そうでなければ個数が 3 以上になる）。
  have hzero : ∀ j, j ∉ Finset.image f Finset.univ → c j = 0 := by
    intro j hj
    by_contra hne
    have h1 : 1 ≤ |c j| := by
      rcases hval j with h | h | h
      · exact absurd h hne
      · simp [h]
      · simp [h]
    have hins : (∑ i, |c (f i)|) + |c j| ≤ ∑ i, |c i| := by
      have hsub := Finset.sum_le_sum_of_subset_of_nonneg
        (s := insert j (Finset.image f Finset.univ)) (t := (Finset.univ : Finset m))
        (f := fun i => |c i|) (Finset.subset_univ _) fun i _ _ => abs_nonneg _
      rw [Finset.sum_insert hj, himgAbs] at hsub
      linarith
    omega
  -- したがって元の列の和と、落とした後の和は等しい。
  have himgC : (∑ x ∈ Finset.image f Finset.univ, c x) = ∑ i, c (f i) :=
    Finset.sum_image (fun x _ y _ h => hf h)
  have hcSum : (∑ x ∈ Finset.image f Finset.univ, c x) = ∑ i, c i :=
    Finset.sum_subset (Finset.subset_univ _) fun j _ hj => hzero j hj
  rw [← himgC, hcSum]
  exact heq hfull

/-! ## 全単模性 -/

/--
**全単模性**: 各列が接続行列の形をしている正方行列の行列式は $0,1,-1$ のいずれかである。

大きさについての帰納法で、上の 3 分岐をそのまま辿る。
-/
theorem det_eq_zero_or_one_or_neg_one_of_incidenceColumns :
    ∀ (n : ℕ) (M : Matrix (Fin n) (Fin n) ℤ),
      (∀ j, IsIncidenceColumn fun i => M i j) →
        M.det = 0 ∨ M.det = 1 ∨ M.det = -1 := by
  intro n
  induction n with
  | zero => intro M _; right; left; simp
  | succ n ih =>
    intro M hM
    classical
    by_cases hcol : ∃ j, (∑ i, |M i j|) ≤ 1
    · obtain ⟨j, hj⟩ := hcol
      by_cases hzero : ∀ i, M i j = 0
      · -- 非零成分 0 個: その列が 0 なので行列式は 0。
        left
        exact det_eq_zero_of_column_eq_zero j hzero
      · -- 非零成分 1 個: その 1 点で余因子展開する。
        simp only [not_forall] at hzero
        obtain ⟨i₀, hi₀⟩ := hzero
        -- i₀ 以外の成分はすべて 0 である（1 個しか無いので）。
        have hother : ∀ i, i ≠ i₀ → M i j = 0 := by
          intro i hne
          by_contra hne'
          have h1 : 1 ≤ |M i j| := by
            rcases (hM j).1 i with h | h | h
            · exact absurd h hne'
            · simp [h]
            · simp [h]
          have h2 : 1 ≤ |M i₀ j| := by
            rcases (hM j).1 i₀ with h | h | h
            · exact absurd h hi₀
            · simp [h]
            · simp [h]
          have : |M i j| + |M i₀ j| ≤ ∑ i, |M i j| := by
            have := Finset.sum_le_sum_of_subset_of_nonneg
              (s := ({i, i₀} : Finset (Fin (n + 1)))) (t := Finset.univ)
              (f := fun i => |M i j|) (Finset.subset_univ _) (fun i _ _ => abs_nonneg _)
            rwa [Finset.sum_pair hne] at this
          omega
        -- 余因子展開。i₀ の項だけが残る。
        rw [det_succ_column M j, Finset.sum_eq_single i₀]
        · -- 残った項は ±1 ×（1 つ小さい小行列の行列式）である。
          have hsub : ∀ j', IsIncidenceColumn fun i =>
              M.submatrix i₀.succAbove j.succAbove i j' := fun j' =>
            (hM (j.succAbove j')).comp_injective i₀.succAbove (Fin.succAbove_right_injective)
          have hval : M i₀ j = 1 ∨ M i₀ j = -1 := by
            rcases (hM j).1 i₀ with h | h | h
            · exact absurd h hi₀
            · exact Or.inl h
            · exact Or.inr h
          have hsign : ((-1 : ℤ)) ^ ((i₀ : ℕ) + (j : ℕ)) = 1 ∨
              ((-1 : ℤ)) ^ ((i₀ : ℕ) + (j : ℕ)) = -1 := by
            rcases Nat.even_or_odd ((i₀ : ℕ) + (j : ℕ)) with h | h
            · exact Or.inl h.neg_one_pow
            · exact Or.inr h.neg_one_pow
          rcases ih _ hsub with h | h | h <;> rcases hval with hv | hv <;>
            rcases hsign with hs | hs <;> simp [h, hv, hs]
        · intro b _ hb
          simp [hother b hb]
        · intro h
          exact absurd (Finset.mem_univ i₀) h
    · -- どの列も非零成分がちょうど 2 個: 全ての行の和が 0 なので行列式は 0。
      simp only [not_exists, not_le] at hcol
      left
      have hrows : (fun _ => (1 : ℤ)) ᵥ* M = 0 := by
        funext j
        have h2 : (∑ i, |M i j|) = 2 := le_antisymm (hM j).2.1 (hcol j)
        simpa [Matrix.vecMul, dotProduct] using (hM j).2.2 h2
      have hne : (fun _ => (1 : ℤ)) ≠ (0 : Fin (n + 1) → ℤ) := by
        intro h
        have := congrFun h ⟨0, Nat.succ_pos n⟩
        simp at this
      exact Matrix.exists_vecMul_eq_zero_iff.mp ⟨_, hne, hrows⟩

/-! ## 符号付き接続行列がこの形をしていること -/

section Multigraph

variable {V E : Type*} [Fintype V] [DecidableEq V] [Fintype E] [DecidableEq E]
variable (s t : E → V)

-- 辺の型の有限性も等号判定も使わない（見るのは 1 本の辺の列だけである）。
omit [Fintype E] [DecidableEq E] in
/--
**接続行列の列は上の形をしている。** $D_{v,e}=[v=t_e]-[v=s_e]$ の第 $e$ 列は、
ループなら $0$、そうでなければ $t_e$ に $+1$、$s_e$ に $-1$ の 2 つだけが非零である。
-/
theorem isIncidenceColumn_incMatrixSigned (e : E) :
    IsIncidenceColumn fun v => incMatrixSigned s t v e := by
  classical
  by_cases hloop : s e = t e
  · -- ループの列は 0。
    refine ⟨fun v => Or.inl ?_, ?_, ?_⟩
    · simp [incMatrixSigned, hloop]
    · simp [incMatrixSigned, hloop]
    · simp [incMatrixSigned, hloop]
  · -- ループでなければ、非零は t e の +1 と s e の −1 の 2 つだけ。
    have hval : ∀ v, incMatrixSigned s t v e = 0 ∨ incMatrixSigned s t v e = 1 ∨
        incMatrixSigned s t v e = -1 := by
      intro v
      by_cases h1 : v = t e <;> by_cases h2 : v = s e <;>
        simp [incMatrixSigned, h1, h2] <;> tauto
    have habs : (∑ v, |incMatrixSigned s t v e|) = 2 := by
      have : (fun v => |incMatrixSigned s t v e|)
          = fun v => (if v = t e then 1 else 0) + (if v = s e then 1 else 0) := by
        funext v
        by_cases h1 : v = t e <;> by_cases h2 : v = s e <;>
          simp_all [incMatrixSigned]
      rw [this, Finset.sum_add_distrib]
      simp
    have hsum : (∑ v, incMatrixSigned s t v e) = 0 := by
      simp [incMatrixSigned, Finset.sum_sub_distrib]
    exact ⟨hval, le_of_eq habs, fun _ => hsum⟩

end Multigraph

end IntegrableLattice
