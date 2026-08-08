/-
章「転送行列」の締めくくりの具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。

  人手証明のラベル                       このファイル
  def_closed_walk                        closedRowWalks
  def_walk_of_family                     walkOfFamily / familyOfWalk
  claim_closed_walk_bijection            familyOfWalk_walkOfFamily /
                                         walkOfFamily_familyOfWalk / closedWalkEquiv
  theorem_partition_polynomial_is_trace   partitionPolynomial_eq_trace

人手証明の主張の証明は 2 つの部分（`Ξ ∘ Θ` が恒等・`Θ ∘ Ξ` が恒等）からなり、
後者は `i ≤ L-1` と `i = L` の場合分けである。このファイルの
`familyOfWalk_walkOfFamily` と `walkOfFamily_familyOfWalk` がそれぞれに対応し、
場合分けもそのまま残してある。

人手証明の定理の証明は、2 つの準備と、`Z_L` から始まり `Tr(T^L)` に着く 7 つの等号からなる。
対応は次のとおり（このファイルの `calc` は `Tr(T^L)` の側から書いて最後に向きを返しており、
等号の並びは人手証明の逆順になる。等号そのものは 1 つずつ同じものである）。

  人手証明の部分                            このファイル
  準備（閉じた道の類別）                    sum_closedRowWalks_eq_sum_between
  準備（族から作った閉じた道の重み）        walkWeight_walkOfFamily_rowsOf
  分配多項式の定義の等号                    partitionPolynomial の定義
  準備（族から作った閉じた道の重み）の等号  walkWeight_walkOfFamily_rowsOf
  rows が全単射である等号                   Equiv.sum_comp rowsEquiv
  Θ が全単射である等号                      Finset.sum_nbij'（closedWalkEquiv と同じ 2 つの写像）
  準備（閉じた道の類別）の等号              sum_closedRowWalks_eq_sum_between
  冪の成分表示の等号                        rowMatrixPow_apply
  トレースの定義の等号                      rowMatrixTrace の定義（`rfl`）

添字について。人手証明は剰余類 `\overline{a} ∈ ℤ/Lℤ` と整数 `i ∈ {0,...,L}` を書き分けており、
Lean でも `ZMod L`（族の定義域）と `Fin (L+1)`（道の定義域）で書き分ける。両者を結ぶのが
`walkOfFamily`（整数を剰余類へ移す）と `familyOfWalk`（剰余類を代表元へ移す）である。
冪の引数は `WeightProduct.lean` の約束どおり 1 つずれているので、人手証明の `T^L` は
`rowMatrixPow L T (L - 1)` である。

住処: 人手証明のこれらのブロックは可算側（ℕ および ℤ[x]）を宣言している。
したがってここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.TransferMatrix.PowerEntry

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 閉じた道の全体 `W^cl_L = { p ∈ W_{L,L} | p(0) = p(L) }`（`def_closed_walk`）。 -/
def closedRowWalks : Finset (RowWalk L L) :=
  univ.filter fun p => p 0 = p (Fin.last L)

/-- 行配位の族から閉じた道を作る写像 `Θ`（`def_walk_of_family`）。
`(Θ(c))(i) = c(\overline{i})`。整数の添字をその剰余類へ移す。 -/
def walkOfFamily (c : RowFamily L) : RowWalk L L := fun i => c ((i : ℕ) : ZMod L)

/-- 閉じた道から行配位の族を作る写像 `Ξ`（`def_walk_of_family`）。
`(Ξ(p))(\overline{a}) = p(a)`。剰余類を `{0,...,L-1}` の中の代表元へ移す。 -/
def familyOfWalk (p : RowWalk L L) : RowFamily L :=
  fun a => p ⟨a.val, (ZMod.val_lt a).trans (Nat.lt_succ_self L)⟩

/-- `Θ(c)` が閉じていること（`def_walk_of_family` の中で述べた事柄）。
`\overline{L} = \overline{0}` から出る。 -/
lemma walkOfFamily_mem_closedRowWalks (c : RowFamily L) :
    walkOfFamily L c ∈ closedRowWalks L := by
  refine mem_filter.mpr ⟨mem_univ _, ?_⟩
  show c ((((0 : Fin (L + 1)) : ℕ) : ZMod L)) = c (((Fin.last L : ℕ) : ZMod L))
  rw [Fin.val_zero, Fin.val_last, Nat.cast_zero, ZMod.natCast_self]

/-- 人手証明の「`Ξ ∘ Θ` が恒等写像であること」。 -/
lemma familyOfWalk_walkOfFamily (c : RowFamily L) :
    familyOfWalk L (walkOfFamily L c) = c := by
  funext a
  show c ((a.val : ℕ) : ZMod L) = c a
  rw [ZMod.natCast_val, ZMod.cast_id]

/-- 人手証明の「`Θ ∘ Ξ` が恒等写像であること」。`i ≤ L-1` と `i = L` で場合を分ける
（人手証明と同じ分け方。前者では `i` 自身が代表元、後者では代表元が `0` になる）。 -/
lemma walkOfFamily_familyOfWalk (p : RowWalk L L) (hp : p ∈ closedRowWalks L) :
    walkOfFamily L (familyOfWalk L p) = p := by
  have hclosed : p 0 = p (Fin.last L) := (mem_filter.mp hp).2
  funext i
  show p ⟨(((i : ℕ) : ZMod L)).val, _⟩ = p i
  rcases lt_or_eq_of_le (Nat.lt_succ_iff.mp i.isLt) with hi | hi
  · -- `i ≤ L-1` の場合。`i` 自身が `\overline{i}` の代表元である。
    congr 1
    exact Fin.ext (ZMod.val_cast_of_lt hi)
  · -- `i = L` の場合。代表元は `0` であり、閉じていることで `p(0) = p(L)` を使う。
    have hival : ((i : ℕ) : ZMod L) = 0 := by rw [hi, ZMod.natCast_self]
    have hlast : i = Fin.last L := Fin.ext (by rw [hi, Fin.val_last])
    rw [hival, hlast, ← hclosed]
    congr 1
    exact Fin.ext (by simp)

/-- 人手証明の「結論」（`claim_closed_walk_bijection`）。逆写像を持つので全単射である。 -/
def closedWalkEquiv : RowFamily L ≃ {p : RowWalk L L // p ∈ closedRowWalks L} where
  toFun c := ⟨walkOfFamily L c, walkOfFamily_mem_closedRowWalks L c⟩
  invFun p := familyOfWalk L p.1
  left_inv := familyOfWalk_walkOfFamily L
  right_inv p := Subtype.ext (walkOfFamily_familyOfWalk L p.1 p.2)

/-- 人手証明の準備（閉じた道の類別）。閉じた道の全体は両端の値ごとの類の互いに素な合併なので、
その上の和は各類の上の和の和に等しい。 -/
lemma sum_closedRowWalks_eq_sum_between (A : RowMatrix L) :
    ∑ τ : RowConfig L, ∑ p ∈ rowWalksBetween L L τ τ, walkWeight L A p
      = ∑ p ∈ closedRowWalks L, walkWeight L A p := by
  rw [← sum_fiberwise (closedRowWalks L) (fun p => p 0) (fun p => walkWeight L A p)]
  refine sum_congr rfl fun τ _ => ?_
  refine sum_congr ?_ fun _ _ => rfl
  ext p
  simp only [rowWalksBetween, closedRowWalks, mem_filter, mem_univ, true_and]
  constructor
  · rintro ⟨h0, hlast⟩
    exact ⟨h0.trans hlast.symm, h0⟩
  · rintro ⟨hclosed, h0⟩
    exact ⟨h0, hclosed.symm.trans h0⟩

/-- 人手証明の準備（族から作った閉じた道の重み）。族から作った閉じた道の重みは配位の重みに等しい。
`Fin L` の添字を `ZMod L` の添字へ読み替えてから、行に沿った成分の積の主張を使う。 -/
lemma walkWeight_walkOfFamily_rowsOf (σ : Config L) :
    walkWeight L (transferMatrix L) (walkOfFamily L (rowsOf L σ))
      = Polynomial.X ^ brokenBondCount L σ := by
  -- `Fin L` と `ZMod L` の間の添字の対応（人手証明の「剰余類 `\overline{i}`」にあたる）。
  let e : Fin L ≃ ZMod L :=
    { toFun := fun i => (i.val : ZMod L)
      invFun := fun a => ⟨a.val, ZMod.val_lt a⟩
      left_inv := fun i => Fin.ext (ZMod.val_cast_of_lt i.isLt)
      right_inv := fun a => by simp [ZMod.natCast_val, ZMod.cast_id] }
  have hstep : ∀ i : Fin L,
      transferMatrix L (walkOfFamily L (rowsOf L σ) i.castSucc)
          (walkOfFamily L (rowsOf L σ) i.succ)
        = transferMatrix L (rowsOf L σ (e i)) (rowsOf L σ (e i + 1)) := by
    intro i
    show transferMatrix L (rowsOf L σ (((i.castSucc : Fin (L + 1)) : ℕ) : ZMod L))
        (rowsOf L σ (((i.succ : Fin (L + 1)) : ℕ) : ZMod L)) = _
    rw [Fin.val_castSucc, Fin.val_succ, Nat.cast_add, Nat.cast_one]
    rfl
  calc walkWeight L (transferMatrix L) (walkOfFamily L (rowsOf L σ))
      = ∏ i : Fin L, transferMatrix L (rowsOf L σ (e i)) (rowsOf L σ (e i + 1)) :=
        prod_congr rfl fun i _ => hstep i
    _ = ∏ a : ZMod L, transferMatrix L (rowsOf L σ a) (rowsOf L σ (a + 1)) :=
        e.prod_comp fun a => transferMatrix L (rowsOf L σ a) (rowsOf L σ (a + 1))
    _ = Polynomial.X ^ brokenBondCount L σ := transfer_weight_product L σ

/-- 定理「分配多項式は転送行列の冪のトレースである」の具体版。
`Z_L = Tr(T^L)`（Lean の冪の引数は 1 つずれているので `T^L` は `rowMatrixPow L T (L-1)`）。 -/
theorem partitionPolynomial_eq_trace :
    partitionPolynomial L = rowMatrixTrace L (rowMatrixPow L (transferMatrix L) (L - 1)) := by
  obtain ⟨n, rfl⟩ : ∃ n, L = n + 1 :=
    ⟨L - 1, (Nat.succ_pred_eq_of_pos (Nat.pos_of_ne_zero (NeZero.ne L))).symm⟩
  simp only [Nat.add_sub_cancel]
  symm
  calc rowMatrixTrace (n + 1) (rowMatrixPow (n + 1) (transferMatrix (n + 1)) n)
      -- トレースの定義と、冪の成分表示の等号。
      = ∑ τ : RowConfig (n + 1), ∑ p ∈ rowWalksBetween (n + 1) (n + 1) τ τ,
          walkWeight (n + 1) (transferMatrix (n + 1)) p :=
        sum_congr rfl fun τ _ => rowMatrixPow_apply (n + 1) (transferMatrix (n + 1)) n τ τ
      -- 準備（閉じた道の類別）の等号。
    _ = ∑ p ∈ closedRowWalks (n + 1), walkWeight (n + 1) (transferMatrix (n + 1)) p :=
        sum_closedRowWalks_eq_sum_between (n + 1) (transferMatrix (n + 1))
      -- Θ が全単射である等号。
    _ = ∑ c : RowFamily (n + 1),
          walkWeight (n + 1) (transferMatrix (n + 1)) (walkOfFamily (n + 1) c) := by
        refine (sum_nbij' (i := fun c => walkOfFamily (n + 1) c)
          (j := fun p => familyOfWalk (n + 1) p) ?_ ?_ ?_ ?_ ?_).symm
        · intro c _
          exact walkOfFamily_mem_closedRowWalks (n + 1) c
        · intro p _
          exact mem_univ _
        · intro c _
          exact familyOfWalk_walkOfFamily (n + 1) c
        · intro p hp
          exact walkOfFamily_familyOfWalk (n + 1) p hp
        · intro c _
          rfl
      -- rows が全単射である等号。
    _ = ∑ σ : Config (n + 1), walkWeight (n + 1) (transferMatrix (n + 1))
          (walkOfFamily (n + 1) (rowsOf (n + 1) σ)) :=
        (Equiv.sum_comp (rowsEquiv (n + 1))
          (fun c => walkWeight (n + 1) (transferMatrix (n + 1)) (walkOfFamily (n + 1) c))).symm
      -- 準備（族から作った閉じた道の重み）の等号と、分配多項式の定義の等号。
    _ = partitionPolynomial (n + 1) :=
        sum_congr rfl fun σ _ => walkWeight_walkOfFamily_rowsOf (n + 1) σ

end Ising2DLambda.TransferMatrix
