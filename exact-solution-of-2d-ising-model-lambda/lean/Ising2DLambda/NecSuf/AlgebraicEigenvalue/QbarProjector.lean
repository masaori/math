/-
主張「落とす写像への行列の作用は冪の指数を 1 つ進める」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarProjector`）と同じである
（作用を有限和の各項へ配る → 各項でスカラー倍を外へ出す → 作用を積へ直す → 冪の一歩の式）。

  使っている性質                     なぜ削れないか
  h_sum（作用が有限和を保つこと）    第 2 段そのもの。
  h_smul（作用がスカラー倍を保つ）   第 3 段そのもの。
  h_prod（作用が積と両立すること）   第 4 段そのもの。
  h_pow（冪の一歩の式）              第 5 段そのもの。

削れたもの: 行列であること（`act` は勝手な写像でよい）・値の型の代数構造・添字の型の
有限性・点の型の有限性・係数が冪の形であること（`c` は勝手な写像でよい。したがって
`z^L = 1` も要らない）・`A^L = I`・単位元・零元・分配則・積の結合則・可換性。
`sum` は「有限部分集合と族から値を作る勝手な写像」でよく、それが和であることすら使わない。

mathlib からは有限部分集合の型 `Finset` の記法だけを引いている。

住処: ここに ℝ / ℂ は現れない（値は勝手な型の元）。
-/
import Mathlib.Data.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版。人手証明の鎖の第 2 段から第 5 段までを、4 つの等式だけの仮定から出す
（第 1 段は定義そのもの）。 -/
theorem projector_action_necSuf
    {S M V : Type*}
    (act : M → V → V) (smul : S → V → V) (mul : M → M → M)
    (sum : Finset ℕ → (ℕ → V) → V)
    (A : M) (pow : ℕ → M) (v : V) (c : ℕ → S) (s : Finset ℕ)
    (h_sum : ∀ f : ℕ → V, act A (sum s f) = sum s (fun k => act A (f k)))
    (h_smul : ∀ (a : S) (w : V), act A (smul a w) = smul a (act A w))
    (h_prod : ∀ (B C : M) (w : V), act (mul B C) w = act B (act C w))
    (h_pow : ∀ k : ℕ, pow (k + 1) = mul A (pow k)) :
    act A (sum s (fun k => smul (c k) (act (pow k) v)))
      = sum s (fun k => smul (c k) (act (pow (k + 1)) v)) := by
  calc act A (sum s (fun k => smul (c k) (act (pow k) v)))
      = sum s (fun k => act A (smul (c k) (act (pow k) v))) := h_sum _
        -- 第 2 段。作用が有限和を保つこと。
    _ = sum s (fun k => smul (c k) (act A (act (pow k) v))) :=
        congrArg (sum s) (funext fun k => h_smul _ _)
        -- 第 3 段。作用がスカラー倍を保つこと。
    _ = sum s (fun k => smul (c k) (act (mul A (pow k)) v)) :=
        congrArg (sum s)
          (funext fun k => congrArg (smul (c k)) (h_prod A (pow k) v).symm)
        -- 第 4 段。作用が積と両立すること。
    _ = sum s (fun k => smul (c k) (act (pow (k + 1)) v)) :=
        congrArg (sum s)
          (funext fun k => congrArg (fun m => smul (c k) (act m v)) (h_pow k).symm)
        -- 第 5 段。冪の一歩の式。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
