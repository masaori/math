/-
主張「破れボンド数は行内の破れと行間の破れに分かれる」（ラベル
`claim_broken_bond_row_decomposition`）の具体版。

人手証明の Step とこのファイルの対応:

  Step 1（破れている辺の集合を置く）  `brokenBondCount` の定義（`Finset.card_filter` で和へ直す）
  Step 2（辺の向きで 2 つに分ける）    `Fintype.sum_sum_type`（`edgeEquiv` で移したあと）
  Step 3（行ごとに分ける）             `Fintype.sum_prod_type`
  Step 4（横向きの 1 行分を数える）    `edgeOfRow_boundary0` / `edgeOfRow_boundary1_horizontal`
  Step 5（縦向きの 1 行分を数える）    `edgeOfRow_boundary0` / `edgeOfRow_boundary1_vertical`
  Step 6（まとめる）                   最後の `Finset.card_filter` の逆向きの書き換え

人手証明の Step 2・Step 3・Step 4 前半・Step 5 前半で使う「行ごとの分割」と
「1 行の中の全単射」は、`Basic.lean` の `edgeEquiv`（`claim_edge_row_partition`）に
まとめてある。ここではそれを引くだけで、数え上げの一般論へ丸投げしていない。

住処: 人手証明のこのブロックは `ℕ` を宣言している。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.TransferMatrix.Basic

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 人手証明の Step 6（結論）。
`b(σ) = Σ_i b_h(ρ_i(σ)) + Σ_i b_v(ρ_i(σ), ρ_{i+1}(σ))`。 -/
theorem brokenBondCount_eq_row_decomposition (σ : Config L) :
    brokenBondCount L σ
      = (∑ i : ZMod L, intraRowBrokenCount L (rowRestriction L σ i))
        + ∑ i : ZMod L, interRowBrokenCount L (rowRestriction L σ i)
            (rowRestriction L σ (i + 1)) := by
  -- Step 1。破れている辺の個数を、辺ごとの 0/1 の和として書く。
  rw [brokenBondCount, card_filter]
  -- Step 2 の前半。辺の番号を (向き, 行番号, 列番号) へ移す（claim_edge_row_partition）。
  rw [← Equiv.sum_comp (edgeEquiv L) fun e =>
    if σ (boundary0 L e) ≠ σ (boundary1 L e) then 1 else 0]
  -- Step 2 の後半。向きで 2 つに分ける。
  rw [Fintype.sum_sum_type]
  -- Step 3。それぞれを行ごとに分ける。
  rw [Fintype.sum_prod_type, Fintype.sum_prod_type]
  -- Step 4・Step 5。1 行分の数え上げを、行配位への制限で書き直す。
  congr 1
  · refine sum_congr rfl fun i _ => ?_
    rw [intraRowBrokenCount, card_filter]
    refine sum_congr rfl fun j _ => ?_
    rw [edgeEquiv_inl, edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal]
    rfl
  · refine sum_congr rfl fun i _ => ?_
    rw [interRowBrokenCount, card_filter]
    refine sum_congr rfl fun j _ => ?_
    rw [edgeEquiv_inr, edgeOfRow_boundary0, edgeOfRow_boundary1_vertical]
    rfl

end Ising2DLambda.TransferMatrix
