/-
「辺の重複がない閉歩道の位相は二次符号と横断数で決まる」（`claim_edge_distinct_walk_quadratic_sign`）の
証明の二つの式鎖の最後から二行目「`claim_torus_quadratic_sign_polarization` の反復と切断線偶奇」と
「`claim_even_edge_chain_intersection`」を合わせた段の具体版:
閉じた非後退辺列の族 `(δ_i)_{1≤i≤n}`（各列の辺の標識は相異なる）について、`𝔽₂` で
`χ_{a,b}(⊕_i h(δ_i), ⊕_i v(δ_i)) = (−1)^{Σ_{i<j} I_L(C_i, C_j)} Π_i χ_{a,b}(h(δ_i), v(δ_i))`。

族は横断消去・接触消去の具体版と同じく `ClosedNonbacktrackingWalkData L` のリストで表し、
`Σ_{i<j} I_L(C_i, C_j)` は `chainPairIntersectionSum`、符号の指数は `ZMod 2` の値の整数代表 `ZMod.val` で読む。
切断線偶奇（二未満の自然数）は、二次符号の真偽値の引数へ `decide (· % 2 = 1)` で渡す。

人手証明との対応:
- 「切断線偶奇」: 辺の標識が相異なる閉歩道の台 `C_δ` の切断線上の係数和は、歩道の切断線偶奇に等しい
  （`horizontalCutSum_closedWalkSupport`・`verticalCutSum_closedWalkSupport`。台の元を歩道の添字で数え直す
  有限和の再添字付けで、添字の単射性を使う）。
- `claim_even_edge_chain_intersection`: 台は偶辺鎖（`closedWalkSupport_even`）なので
  `I_L(C, D) = h_C v_D + v_C h_D`（`evenEdgeChainIntersection_eq_cutParity`）。
  一つの台と残りの台の交差形式の和: `evenEdgeChainIntersection_sum_walkSupport`。
- 「`claim_torus_quadratic_sign_polarization` の反復」: 族の長さについての帰納法
  `torusQuadraticSign_walkFamily`。帰納の一歩は先頭の列と残りの族の和へ `torusQuadraticSign_polarization` を当て、
  `chainPairIntersectionSum` の定義（先頭と残りの交差形式の和＋残りの対の和）と `(−1)` の冪の指数の
  `𝔽₂` での和（`neg_one_pow_zmod_two_val_add`）で整理する。
住処は有限集合・`ℕ`・`𝔽₂`・`ℤ`、および `Qbar` の `(−1)` の冪だけで、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.CrossingFreeContactEliminationPhase
import Ising2DLambda.KacWard.DisjointWalkMutualCrossing
import Ising2DLambda.KacWard.TorusQuadraticSignPolarization
import Ising2DLambda.KacWard.EvenEdgeChainIntersectionValue

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

variable {L : ℕ} [NeZero L]

/-- 辺の列番号は `L` 未満である（除法の余り）。 -/
theorem edgeColumn_lt_side (e : Edge L) : edgeColumn L e < L := by
  unfold edgeColumn
  exact Nat.mod_lt _ (Nat.pos_of_ne_zero (NeZero.ne L))

/-- 辺の行番号は `L` 未満である（横・縦それぞれの中での番号は `L²` 未満）。 -/
theorem edgeRow_lt_side (e : Edge L) : edgeRow L e < L := by
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  have he : e.val < 2 * L ^ 2 := e.isLt
  have hidx : edgeIndex L e < L * L := by
    unfold edgeIndex
    split_ifs with h
    · nlinarith
    · rw [← pow_two]; omega
  unfold edgeRow
  exact Nat.div_lt_of_lt_mul hidx

omit [NeZero L] in
/-- `L` 未満の自然数 `n` について、`ZMod L` で `n = −1` であることと `n = L − 1` は同値である。 -/
theorem natCast_eq_neg_one_iff_of_lt {n : ℕ} (hn : n < L) :
    ((n : ZMod L) = -1) ↔ n = L - 1 := by
  constructor
  · intro h
    have h0 : ((n + 1 : ℕ) : ZMod L) = 0 := by push_cast; rw [h]; ring
    rw [ZMod.natCast_eq_zero_iff] at h0
    obtain ⟨k, hk⟩ := h0
    rcases k with _ | _ | k
    · omega
    · omega
    · nlinarith
  · intro h
    have hL : L = n + 1 := by omega
    subst hL
    have : ((n + 1 : ℕ) : ZMod (n + 1)) = 0 := ZMod.natCast_self _
    push_cast at this
    exact eq_neg_of_add_eq_zero_left this

/-- 一つの辺について、行の添字にわたる横辺係数の指示子の和は、切断線（列 `−1`）上の横辺の指示子である。 -/
theorem sum_row_indicator_horizontal (e : Edge L) :
    (∑ i' : ZMod L, (if e.val < L ^ 2 ∧ (edgeRow L e : ZMod L) = i' ∧
        (edgeColumn L e : ZMod L) = -1 then (1 : ZMod 2) else 0)) =
      ((horizontalSeamParity (e, false) : ℕ) : ZMod 2) := by
  unfold horizontalSeamParity
  have hiff := natCast_eq_neg_one_iff_of_lt (edgeColumn_lt_side e)
  simp only [hiff]
  by_cases h1 : e.val < L ^ 2 <;> by_cases h2 : edgeColumn L e = L - 1 <;>
    simp [h1, h2, Finset.sum_ite_eq]

/-- 一つの辺について、列の添字にわたる縦辺係数の指示子の和は、切断線（行 `−1`）上の縦辺の指示子である。 -/
theorem sum_column_indicator_vertical (e : Edge L) :
    (∑ j' : ZMod L, (if L ^ 2 ≤ e.val ∧ (edgeRow L e : ZMod L) = -1 ∧
        (edgeColumn L e : ZMod L) = j' then (1 : ZMod 2) else 0)) =
      ((verticalSeamParity (e, false) : ℕ) : ZMod 2) := by
  unfold verticalSeamParity
  have hiff := natCast_eq_neg_one_iff_of_lt (edgeRow_lt_side e)
  simp only [hiff]
  by_cases h1 : L ^ 2 ≤ e.val <;> by_cases h2 : edgeRow L e = L - 1 <;>
    simp [h1, h2, Finset.sum_ite_eq, Nat.not_lt.mpr, not_le.mp]

/-- 切断線偶奇: 辺の標識が相異なる閉歩道の台の横の切断線上の係数和は、歩道の横の切断線偶奇に等しい。 -/
theorem horizontalCutSum_closedWalkSupport {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hinj : Function.Injective fun k => (γ k).1) :
    (∑ i', horizontalChainCoefficient L (closedWalkSupport γ) i' (-1)) =
      (((edgeSequenceSeamParities (List.ofFn γ)).1 : ℕ) : ZMod 2) := by
  calc (∑ i', horizontalChainCoefficient L (closedWalkSupport γ) i' (-1))
      -- 係数の定義（台の元にわたる指示子の和）と有限和の順序交換
      = ∑ e ∈ closedWalkSupport γ, ∑ i' : ZMod L, (if e.val < L ^ 2 ∧
          (edgeRow L e : ZMod L) = i' ∧ (edgeColumn L e : ZMod L) = -1 then (1 : ZMod 2) else 0) := by
        unfold horizontalChainCoefficient
        exact Finset.sum_comm
      -- 行の添字にわたる和は切断線上の横辺の指示子
    _ = ∑ e ∈ closedWalkSupport γ, ((horizontalSeamParity (e, false) : ℕ) : ZMod 2) := by
        exact Finset.sum_congr rfl fun e _ => sum_row_indicator_horizontal e
      -- 台の元を歩道の添字で数え直す（辺の標識の単射性）
    _ = ∑ k, ((horizontalSeamParity ((γ k).1, false) : ℕ) : ZMod 2) := by
        unfold closedWalkSupport
        rw [Finset.sum_image fun k _ l _ h => hinj h]
      -- 切断線の指示子は向きに依らない
    _ = ∑ k, ((horizontalSeamParity (γ k) : ℕ) : ZMod 2) := rfl
      -- 切断線偶奇の定義（二を法とした和）
    _ = (((edgeSequenceSeamParities (List.ofFn γ)).1 : ℕ) : ZMod 2) := by
        rw [edgeSequenceSeamParities_apply, ZMod.natCast_mod, List.map_ofFn, List.sum_ofFn,
          Nat.cast_sum]
        rfl

/-- 切断線偶奇: 辺の標識が相異なる閉歩道の台の縦の切断線上の係数和は、歩道の縦の切断線偶奇に等しい。 -/
theorem verticalCutSum_closedWalkSupport {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hinj : Function.Injective fun k => (γ k).1) :
    (∑ j', verticalChainCoefficient L (closedWalkSupport γ) (-1) j') =
      (((edgeSequenceSeamParities (List.ofFn γ)).2 : ℕ) : ZMod 2) := by
  calc (∑ j', verticalChainCoefficient L (closedWalkSupport γ) (-1) j')
      -- 係数の定義（台の元にわたる指示子の和）と有限和の順序交換
      = ∑ e ∈ closedWalkSupport γ, ∑ j' : ZMod L, (if L ^ 2 ≤ e.val ∧
          (edgeRow L e : ZMod L) = -1 ∧ (edgeColumn L e : ZMod L) = j' then (1 : ZMod 2) else 0) := by
        unfold verticalChainCoefficient
        exact Finset.sum_comm
      -- 列の添字にわたる和は切断線上の縦辺の指示子
    _ = ∑ e ∈ closedWalkSupport γ, ((verticalSeamParity (e, false) : ℕ) : ZMod 2) := by
        exact Finset.sum_congr rfl fun e _ => sum_column_indicator_vertical e
      -- 台の元を歩道の添字で数え直す（辺の標識の単射性）
    _ = ∑ k, ((verticalSeamParity ((γ k).1, false) : ℕ) : ZMod 2) := by
        unfold closedWalkSupport
        rw [Finset.sum_image fun k _ l _ h => hinj h]
      -- 切断線の指示子は向きに依らない
    _ = ∑ k, ((verticalSeamParity (γ k) : ℕ) : ZMod 2) := rfl
      -- 切断線偶奇の定義（二を法とした和）
    _ = (((edgeSequenceSeamParities (List.ofFn γ)).2 : ℕ) : ZMod 2) := by
        rw [edgeSequenceSeamParities_apply, ZMod.natCast_mod, List.map_ofFn, List.sum_ofFn,
          Nat.cast_sum]
        rfl

/-- `claim_even_edge_chain_intersection` を閉歩道の台へ当てたもの: 一つの台 `C_δ` と族の台 `C_i` の交差形式の和は
`h(δ) Σ_i v(δ_i) + v(δ) Σ_i h(δ_i)`（`𝔽₂`）。 -/
theorem evenEdgeChainIntersection_sum_walkSupport (δ : ClosedNonbacktrackingWalkData L)
    (hδ : Function.Injective fun r => (δ.walk r).1) (δs : List (ClosedNonbacktrackingWalkData L))
    (hδs : ∀ η ∈ δs, Function.Injective fun r => (η.walk r).1) :
    ((δs.map (·.support)).map fun D => evenEdgeChainIntersection L δ.support D).sum =
      (((δ.seam.1 * (δs.map fun η => η.seam.2).sum +
          δ.seam.2 * (δs.map fun η => η.seam.1).sum : ℕ)) : ZMod 2) := by
  induction δs with
  | nil => simp
  | cons η δs ih =>
    have hη := hδs η (List.mem_cons_self ..)
    have hrest : ∀ η' ∈ δs, Function.Injective fun r => (η'.walk r).1 :=
      fun η' h => hδs η' (List.mem_cons_of_mem _ h)
    have hI : evenEdgeChainIntersection L δ.support η.support =
        ((δ.seam.1 * η.seam.2 + δ.seam.2 * η.seam.1 : ℕ) : ZMod 2) := by
      calc evenEdgeChainIntersection L δ.support η.support
          -- 台は偶辺鎖なので交差形式は切断線上の係数和で書ける
          = (∑ i', horizontalChainCoefficient L δ.support i' (-1)) *
                (∑ j', verticalChainCoefficient L η.support (-1) j') +
              (∑ j', verticalChainCoefficient L δ.support (-1) j') *
                (∑ i', horizontalChainCoefficient L η.support i' (-1)) :=
            evenEdgeChainIntersection_eq_cutParity _ _
              (closedWalkSupport_even δ.walk δ.closed hδ) (closedWalkSupport_even η.walk η.closed hη)
          -- 切断線上の係数和は歩道の切断線偶奇
        _ = ((δ.seam.1 : ℕ) : ZMod 2) * ((η.seam.2 : ℕ) : ZMod 2) +
              ((δ.seam.2 : ℕ) : ZMod 2) * ((η.seam.1 : ℕ) : ZMod 2) := by
            simp only [ClosedNonbacktrackingWalkData.support, ClosedNonbacktrackingWalkData.seam]
            rw [horizontalCutSum_closedWalkSupport _ hδ, verticalCutSum_closedWalkSupport _ hη,
              verticalCutSum_closedWalkSupport _ hδ, horizontalCutSum_closedWalkSupport _ hη]
        _ = ((δ.seam.1 * η.seam.2 + δ.seam.2 * η.seam.1 : ℕ) : ZMod 2) := by push_cast; ring
    simp only [List.map_cons, List.sum_cons]
    rw [ih hrest, hI]
    push_cast
    ring

omit [NeZero L] in
/-- 二を法とした和の真偽値の偶奇は、各項の真偽値の排他的論理和である。 -/
theorem decide_add_mod_two_eq_one (x y : ℕ) :
    decide ((x + y) % 2 = 1) = xor (decide (x % 2 = 1)) (decide (y % 2 = 1)) := by
  rcases Nat.mod_two_eq_zero_or_one x with hx | hx <;>
    rcases Nat.mod_two_eq_zero_or_one y with hy | hy <;>
    simp [Nat.add_mod, hx, hy]

omit [NeZero L] in
/-- 偶奇の真偽値を自然数へ戻すと二を法とした余りになる。 -/
theorem decide_mod_two_eq_one_toNat (x : ℕ) : (decide (x % 2 = 1)).toNat = x % 2 := by
  rcases Nat.mod_two_eq_zero_or_one x with hx | hx <;> simp [hx]

omit [NeZero L] in
/-- `(−1)` の冪の指数は二を法として読める（`𝔽₂` の値の整数代表）。 -/
theorem neg_one_pow_natCast_zmod_two_val (n : ℕ) :
    (-1 : Qbar) ^ ((n : ZMod 2)).val = (-1 : Qbar) ^ n := by
  rw [ZMod.val_natCast, ← neg_one_pow_eq_pow_mod_two]

omit [NeZero L] in
/-- 切断線偶奇は二未満なので、その真偽値は二を法とした偶奇の真偽値に等しい。 -/
theorem seam_decide_eq_mod (δ : ClosedNonbacktrackingWalkData L) :
    decide (δ.seam.1 = 1) = decide (δ.seam.1 % 2 = 1) ∧
      decide (δ.seam.2 = 1) = decide (δ.seam.2 % 2 = 1) := by
  simp only [ClosedNonbacktrackingWalkData.seam, edgeSequenceSeamParities_apply, Nat.mod_mod]
  exact ⟨rfl, rfl⟩

/-- 「`claim_torus_quadratic_sign_polarization` の反復」: 各列の辺の標識が相異なる閉歩道の族について
`χ_{a,b}(⊕_i h(δ_i), ⊕_i v(δ_i)) = (−1)^{Σ_{i<j} I_L(C_i, C_j)} Π_i χ_{a,b}(h(δ_i), v(δ_i))`。 -/
theorem torusQuadraticSign_walkFamily (a b : Bool) (δs : List (ClosedNonbacktrackingWalkData L))
    (hδs : ∀ δ ∈ δs, Function.Injective fun r => (δ.walk r).1) :
    ((torusQuadraticSign a b (decide ((δs.map fun δ => δ.seam.1).sum % 2 = 1))
        (decide ((δs.map fun δ => δ.seam.2).sum % 2 = 1)) : ℤ) : Qbar) =
      (-1 : Qbar) ^ (chainPairIntersectionSum (δs.map (·.support))).val *
        (δs.map fun δ =>
          ((torusQuadraticSign a b (decide (δ.seam.1 = 1)) (decide (δ.seam.2 = 1)) : ℤ) : Qbar)).prod := by
  induction δs with
  | nil =>
    -- 空の族: χ_{a,b}(0, 0) = 1、空の和と空の積
    cases a <;> cases b <;> simp [chainPairIntersectionSum, torusQuadraticSign, torusQuadraticParity]
  | cons δ δs ih =>
    have hδ := hδs δ (List.mem_cons_self ..)
    have hrest : ∀ η ∈ δs, Function.Injective fun r => (η.walk r).1 :=
      fun η h => hδs η (List.mem_cons_of_mem _ h)
    set H := (δs.map fun η => η.seam.1).sum with hH
    set V := (δs.map fun η => η.seam.2).sum with hV
    obtain ⟨hd1, hd2⟩ := seam_decide_eq_mod δ
    calc ((torusQuadraticSign a b (decide (((δ :: δs).map fun η => η.seam.1).sum % 2 = 1))
          (decide (((δ :: δs).map fun η => η.seam.2).sum % 2 = 1)) : ℤ) : Qbar)
        -- 先頭の列と残りの族の和に分け、偶奇を排他的論理和で書く
        = ((torusQuadraticSign a b (xor (decide (δ.seam.1 % 2 = 1)) (decide (H % 2 = 1)))
            (xor (decide (δ.seam.2 % 2 = 1)) (decide (V % 2 = 1))) : ℤ) : Qbar) := by
          have e1 : decide (((δ :: δs).map fun η => η.seam.1).sum % 2 = 1) =
              xor (decide (δ.seam.1 % 2 = 1)) (decide (H % 2 = 1)) := by
            rw [← decide_add_mod_two_eq_one]
            simp [hH]
          have e2 : decide (((δ :: δs).map fun η => η.seam.2).sum % 2 = 1) =
              xor (decide (δ.seam.2 % 2 = 1)) (decide (V % 2 = 1)) := by
            rw [← decide_add_mod_two_eq_one]
            simp [hV]
          rw [e1, e2]
        -- claim_torus_quadratic_sign_polarization
      _ = ((torusQuadraticSign a b (decide (δ.seam.1 % 2 = 1)) (decide (δ.seam.2 % 2 = 1)) *
              torusQuadraticSign a b (decide (H % 2 = 1)) (decide (V % 2 = 1)) *
              (-1 : ℤ) ^ ((decide (δ.seam.1 % 2 = 1)).toNat * (decide (V % 2 = 1)).toNat +
                (decide (H % 2 = 1)).toNat * (decide (δ.seam.2 % 2 = 1)).toNat) : ℤ) : Qbar) := by
          rw [torusQuadraticSign_polarization]
        -- 指数を二を法として読み直す
      _ = ((torusQuadraticSign a b (decide (δ.seam.1 = 1)) (decide (δ.seam.2 = 1)) : ℤ) : Qbar) *
            ((torusQuadraticSign a b (decide (H % 2 = 1)) (decide (V % 2 = 1)) : ℤ) : Qbar) *
            (-1 : Qbar) ^ (δ.seam.1 * V + δ.seam.2 * H) := by
          simp only [decide_mod_two_eq_one_toNat]
          rw [← hd1, ← hd2]
          push_cast
          congr 1
          rw [neg_one_pow_eq_pow_mod_two (n := δ.seam.1 * V + δ.seam.2 * H),
            neg_one_pow_eq_pow_mod_two (n := δ.seam.1 % 2 * (V % 2) + H % 2 * (δ.seam.2 % 2))]
          congr 1
          simp only [Nat.add_mod, Nat.mul_mod, Nat.mod_mod]
          ring_nf
        -- 残りの族への帰納法の仮定
      _ = ((torusQuadraticSign a b (decide (δ.seam.1 = 1)) (decide (δ.seam.2 = 1)) : ℤ) : Qbar) *
            ((-1 : Qbar) ^ (chainPairIntersectionSum (δs.map (·.support))).val *
              (δs.map fun η =>
                ((torusQuadraticSign a b (decide (η.seam.1 = 1)) (decide (η.seam.2 = 1)) : ℤ) :
                  Qbar)).prod) *
            (-1 : Qbar) ^ (δ.seam.1 * V + δ.seam.2 * H) := by
          rw [ih hrest]
        -- claim_even_edge_chain_intersection（先頭と残りの交差形式の和）と (−1) の冪の指数の 𝔽₂ での和
      _ = (-1 : Qbar) ^ (chainPairIntersectionSum ((δ :: δs).map (·.support))).val *
            ((δ :: δs).map fun η =>
              ((torusQuadraticSign a b (decide (η.seam.1 = 1)) (decide (η.seam.2 = 1)) : ℤ) :
                Qbar)).prod := by
          simp only [List.map_cons, chainPairIntersectionSum, List.prod_cons]
          rw [evenEdgeChainIntersection_sum_walkSupport δ hδ δs hrest, neg_one_pow_zmod_two_val_add,
            neg_one_pow_natCast_zmod_two_val]
          ring

end Ising2DLambda.KacWard
