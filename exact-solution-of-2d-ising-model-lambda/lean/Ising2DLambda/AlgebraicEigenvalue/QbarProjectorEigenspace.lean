/-
章「固有値の代数性」の主張「落とす写像の像は固有空間に入る」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_projector_image_eigenspace`）に対応する。

  人手証明                                        このファイル
  準備 1（a_k := (A^k·v)(τ)）                     a
  準備 2（a_L = a_0）                             h_prep2（hA と qbarIdentity_action）
  準備 3（z^{L+1} = z）                           h_prep3（hz と pow_succ）
  鎖の第 1 段（前の主張の右辺）                   qbarProjector_action
  添字のずらしと k=0 の項の分離                   Finset.sum_range_succ'
  j=L の項の分離                                  Finset.sum_range_succ
  準備 2・3 を当てて境界の 2 項を消す             add_right_cancel
  分配則で z を外へ出す                           Finset.mul_sum

mathlib の一般論へは委ねず、人手証明の鎖をそのまま書く（引いているのは有限和の
最初／最後の項を取り出す 2 つの補題と、元と有限和の積についての分配則だけである）。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（成分は ℚ の代数閉包の元、添字は行配位）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarProjector
import Ising2DLambda.AlgebraicEigenvalue.QbarIdentityAction

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

/-- 人手証明の本体。`A^L = I` と `z^L = 1` のもとで `P_{A,z}(v) ∈ E_A(z)`
（`claim_qbar_projector_image_eigenspace`）。 -/
theorem qbarProjector_mem_eigenspace (L : ℕ) [NeZero L]
    (A : QbarRowMatrix L) (z : Qbar) (v : QbarRowVector L)
    (hA : qbarMatrixPow L A L = qbarIdentityMatrix L) (hz : z ^ L = 1) :
    qbarProjector L A z v ∈ qbarEigenspace L A z := by
  obtain ⟨n, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (NeZero.ne L)
  show qbarAction (n + 1) A (qbarProjector (n + 1) A z v)
      = qbarVectorSmul (n + 1) z (qbarProjector (n + 1) A z v)
  rw [qbarProjector_action (n + 1) A z v]
    -- 鎖の第 1 段。前の主張の右辺。
  funext τ
  -- 準備 1。a_k := (A^k · v)(τ)。
  set a : ℕ → Qbar := fun k => qbarAction (n + 1) (qbarMatrixPow (n + 1) A k) v τ with ha
  -- 境界の 2 項を比べるための族 g i := z^{L+1-i} a_i。
  set g : ℕ → Qbar := fun i => z ^ (n + 1 + 1 - i) * a i with hg
  -- 準備 2。a_L = v(τ) = a_0。
  have h_aL : a (n + 1) = v τ := by
    have : qbarAction (n + 1) (qbarMatrixPow (n + 1) A (n + 1)) v = v := by
      rw [hA]; exact qbarIdentity_action (n + 1) v
    simpa [ha] using congrFun this τ
  have h_a0 : a 0 = v τ := by
    have : qbarAction (n + 1) (qbarMatrixPow (n + 1) A 0) v = v :=
      qbarIdentity_action (n + 1) v
    simpa [ha] using congrFun this τ
  -- 準備 3。z^{L+1} = z^L z = 1 z = z。
  have h_prep3 : z ^ (n + 1 + 1) = z := by
    rw [pow_succ, hz, one_mul]
  -- 境界の 2 項が等しいこと（準備 2 と準備 3）。
  have h_bdry : g (n + 1) = g 0 := by
    have h1 : g (n + 1) = z * v τ := by
      simp [hg, h_aL]
    have h2 : g 0 = z * v τ := by
      simp [hg, h_a0, h_prep3]
    rw [h1, h2]
  -- 左辺の各項が g (k+1) であること（n+2-(k+1) = n+1-k）。
  have h_left : ∀ k, z ^ (n + 1 - k) * a (k + 1) = g (k + 1) := by
    intro k
    simp [hg, Nat.succ_sub_succ]
  -- 右辺の各項が g k であること（k ≤ n なので n+2-k = (n+1-k)+1）。
  have h_right : ∀ k ∈ range (n + 1), z * (z ^ (n + 1 - k) * a k) = g k := by
    intro k hk
    have hk' : k ≤ n + 1 := Nat.le_of_lt_succ (Nat.lt_succ_of_lt (mem_range.mp hk))
    have : n + 1 + 1 - k = (n + 1 - k) + 1 := Nat.succ_sub hk'
    rw [hg]
    simp only [this, pow_succ]
    ring
  calc ∑ k ∈ range (n + 1), z ^ (n + 1 - k) * a (k + 1)
      = ∑ k ∈ range (n + 1), g (k + 1) := sum_congr rfl fun k _ => h_left k
        -- 準備 1 と、左辺の項の書き換え。
    _ = ∑ k ∈ range (n + 1), g k := by
        -- 添字のずらし・境界の 2 項の分離・準備 2・3・k=0 の項の復帰。
        have h_shift : (∑ k ∈ range (n + 1), g (k + 1)) + g 0
            = ∑ i ∈ range (n + 1 + 1), g i := (sum_range_succ' g (n + 1)).symm
        have h_last : (∑ k ∈ range (n + 1), g k) + g (n + 1)
            = ∑ i ∈ range (n + 1 + 1), g i := (sum_range_succ g (n + 1)).symm
        refine add_right_cancel (b := g 0) ?_
        rw [h_shift, ← h_last, h_bdry]
    _ = ∑ k ∈ range (n + 1), z * (z ^ (n + 1 - k) * a k) :=
        sum_congr rfl fun k hk => (h_right k hk).symm
        -- 各項へ準備 1 を戻す。
    _ = z * ∑ k ∈ range (n + 1), z ^ (n + 1 - k) * a k := (mul_sum _ _ _).symm
        -- 元と有限和の積についての分配則（z を外へ出す）。

end Ising2DLambda.AlgebraicEigenvalue
