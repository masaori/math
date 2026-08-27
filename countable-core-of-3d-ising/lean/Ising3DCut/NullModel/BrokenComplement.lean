/-
人手証明の主張「奇数側だけ反転すると破れ数は補数になる」
（ラベル `claim_broken_complement`）の具体版。

人手証明の式変形とこのファイルの対応:

  破れている辺の集合 D_L(σ) と破れ数 m_L(σ) = #D_L(σ)   `brokenSet` と `brokenCount`
  D_L(Tσ) = E_L ∖ D_L(σ)（各辺で破れが反転するから）      `brokenSet_oddFlip`
  m_L(Tσ) = #E_L − #D_L(σ)（部分集合の補集合の元の個数）   `brokenCount_oddFlip`

辺の集合 E_L は辺の型の全体（`Finset.univ`）であり、#E_L は `Fintype.card (Edge L)` である。
そのために、点と辺の等号が決定可能であることと辺の型が有限であることを、
点を各座標が `L` 未満の値の三つ組と取り違えなく対応させる全単射から先に与える。

人手証明が根拠に挙げる「有限集合の部分集合の補集合の元の個数」には
`Finset.card_sdiff` を当てる（これはその初等的事実そのものであり、計算の委譲ではない）。

住処: `Fin`、`Nat`、`Bool`、整数 ±1、有限集合のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.BigOperators
import Ising3DCut.NullModel.OddFlipReversesEdges

namespace Ising3DCut.NullModel

/-- 配位の値 ±1 の等号は、整数の等号として決定できる。 -/
instance : DecidableEq Spin :=
  fun x y => decidable_of_iff (x.1 = y.1) Subtype.ext_iff.symm

/-- 点の等号は、三つの自然数座標の等号として決定できる。 -/
instance {L : ℕ} : DecidableEq (Site L) :=
  fun a b => decidable_of_iff (a.1 = b.1) Subtype.ext_iff.symm

/-- 点と「各座標が `L` 未満の値の三つ組」の全単射。箱の有限性はここから出す。 -/
def siteEquiv {L : ℕ} : Site L ≃ (Fin 3 → Fin L) where
  toFun a := fun i => ⟨a.1 i, a.2 i⟩
  invFun f := ⟨fun i => (f i).1, fun i => (f i).2⟩
  left_inv a := Subtype.ext rfl
  right_inv f := funext fun i => Fin.ext rfl

/-- 箱の点は有限個である。 -/
instance {L : ℕ} : Fintype (Site L) :=
  Fintype.ofEquiv _ siteEquiv.symm

/-- 辺の等号は、始点と方向の等号として決定できる（箱内条件は命題なので値を持たない）。 -/
instance {L : ℕ} : DecidableEq (Edge L) :=
  fun e f =>
    decidable_of_iff (e.start = f.start ∧ e.axis = f.axis) (by cases e; cases f; simp)

/-- 辺と「始点と方向の組のうち次の点も箱内にあるもの」の全単射。 -/
def edgeEquiv {L : ℕ} : Edge L ≃ {p : Site L × Fin 3 // p.1.1 p.2 + 1 < L} where
  toFun e := ⟨(e.start, e.axis), e.next_lt⟩
  invFun p := ⟨p.1.1, p.1.2, p.2⟩
  left_inv e := rfl
  right_inv _ := rfl

/-- 辺は有限個である。#E_L は `Fintype.card (Edge L)` と書く。 -/
instance {L : ℕ} : Fintype (Edge L) :=
  Fintype.ofEquiv _ edgeEquiv.symm

/-- 方向を一つ固定したとき、その方向へ一つ進める始点座標は
`L - 1` 通りである。箱の辺数を数える最初の因子である。 -/
theorem card_forward_start_coordinates (L : ℕ) :
    Fintype.card {i : Fin L // i.1 + 1 < L} = L - 1 := by
  let f : {i : Fin L // i.1 + 1 < L} → Fin (L - 1) := fun i =>
    ⟨i.1.1, by omega⟩
  have hf : Function.Bijective f := by
    constructor
    · intro i j hij
      apply Subtype.ext
      apply Fin.ext
      simpa [f] using congrArg Fin.val hij
    · intro j
      have hj : j.1 < L - 1 := j.2
      have hpred : 0 < L - 1 := lt_of_le_of_lt (Nat.zero_le _) hj
      have hL : 1 < L := Nat.sub_pos_iff_lt.mp hpred
      have hjL : j.1 < L := by omega
      have hnext : j.1 + 1 < L := by omega
      refine ⟨⟨⟨j.1, hjL⟩, hnext⟩, ?_⟩
      apply Fin.ext
      rfl
  simpa using Fintype.card_congr (Equiv.ofBijective f hf)

/-- 方向を一つ固定したとき、その方向へ辺を出せる始点は `(L - 1) * L ^ 2` 個である。
固定した方向の座標だけが `L - 1` 通りに制限され、残る二つの座標は自由に `L` 通りである。 -/
theorem card_fixed_axis_edge_starts (L : ℕ) (j : Fin 3) :
    Fintype.card {f : Fin 3 → Fin L // (f j).1 + 1 < L} = (L - 1) * L ^ 2 := by
  have e : {f : Fin 3 → Fin L // (f j).1 + 1 < L}
      ≃ {i : Fin L // i.1 + 1 < L} × ({k : Fin 3 // k ≠ j} → Fin L) := by
    refine
      { toFun := fun f => (⟨f.1 j, f.2⟩, fun k => f.1 k.1)
        invFun := fun p => ⟨fun k => if h : k = j then p.1.1 else p.2 ⟨k, h⟩, by simpa using p.1.2⟩
        left_inv := ?_
        right_inv := ?_ }
    · intro f
      apply Subtype.ext
      funext k
      by_cases h : k = j
      · subst h; simp
      · simp [h]
    · intro p
      refine Prod.ext ?_ ?_
      · apply Subtype.ext
        simp
      · funext k
        simp [k.2]
  have hsub : Fintype.card {k : Fin 3 // k ≠ j} = 2 := by
    simpa using Fintype.card_subtype_compl (fun k : Fin 3 => k = j)
  have hfun : Fintype.card ({k : Fin 3 // k ≠ j} → Fin L) = L ^ 2 := by
    rw [Fintype.card_fun, hsub, Fintype.card_fin]
  rw [Fintype.card_congr e, Fintype.card_prod, card_forward_start_coordinates, hfun]

/-- 破れている辺の集合 D_L(σ)（`def_broken_count` の前半）。 -/
def brokenSet {L : ℕ} (σ : Config L) : Finset (Edge L) :=
  Finset.univ.filter (fun e => σ (endpoint0 e) ≠ σ (endpoint1 e))

/-- 破れ数 m_L(σ) = #D_L(σ)（`def_broken_count` の後半）。 -/
def brokenCount {L : ℕ} (σ : Config L) : ℕ := (brokenSet σ).card

/-- 人手証明の前段。D_L(Tσ) = E_L ∖ D_L(σ)。 -/
theorem brokenSet_oddFlip {L : ℕ} (σ : Config L) :
    brokenSet (oddFlip σ) = Finset.univ \ brokenSet σ := by
  ext e
  simp [brokenSet, oddFlip_reverses_edge σ e]

/-- `claim_broken_complement` の具体版。m_L(Tσ) = #E_L − m_L(σ)。 -/
theorem brokenCount_oddFlip {L : ℕ} (σ : Config L) :
    brokenCount (oddFlip σ) = Fintype.card (Edge L) - brokenCount σ := by
  rw [brokenCount, brokenSet_oddFlip, Finset.card_sdiff, Finset.inter_univ,
    Finset.card_univ, brokenCount]

end Ising3DCut.NullModel
