/-
「行列の冪の作用は、作用を反復したものである」（`claim_qbar_action_pow`）の必要十分版。

手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.qbarAction_pow`）と同じ
「出発点の 3 段・一歩の 4 段」の帰納法である。削ったのは次のもので、削っても同じ手順で通る。

- 行列であること・列ベクトルであること → 勝手な 2 つの型 `M`・`V` でよい。
- 積であること → 勝手な二項演算 `mulf : M → M → M` でよい（結合則も可換性も単位元の
  法則も使わない）。
- 作用であること → 勝手な写像 `act : M → V → V` でよい（線型性も使わない）。
- 値が代数的数であること・添字が有限であること → 一切要らない（有限和が現れない）。
- 冪と反復が再帰で定義されていること → 2 本の列 `p : ℕ → M`・`w : ℕ → V` と、
  その再帰の式を仮定として置けばよい（定義の形には依存しない）。

残した仮定がなぜ要るか。

- `hp0` / `hw0`: 出発点の第 1 段と第 3 段でそれぞれ使う（`p 0` を `e` へ、`v` を `w 0` へ）。
- `hact_one`: 出発点の第 2 段で使う（`act e v = v`）。これが単位行列の作用に当たる。
- `hpsucc` / `hwsucc`: 一歩の第 1 段と第 4 段でそれぞれ使う。
- `hact_mul`: 一歩の第 2 段で使う（`act (mulf a b) v = act a (act b v)`）。
  これが積の作用に当たる。

すなわち、この段が要求するのは**2 本の再帰の式と、単位元の作用・積の作用の 2 つの等式だけ**
であり、代数構造も有限性も順序も一切使っていない。

住処: ここに ℝ / ℂ は現れない。
mathlib からは何も import していない（この段が既製の一般論を一切使わないことが、
import の無さとして見える。番号の型も `Nat` そのものを使う）。
-/
universe u v

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版。再帰で作られた 2 本の列は、作用を通して対応する。 -/
theorem action_pow_necSuf {M : Type u} {V : Type v}
    (mulf : M → M → M) (act : M → V → V) (e a : M) (v : V)
    (p : Nat → M) (w : Nat → V)
    (hp0 : p 0 = e) (hpsucc : ∀ k, p (k + 1) = mulf a (p k))
    (hw0 : w 0 = v) (hwsucc : ∀ k, w (k + 1) = act a (w k))
    (hact_one : act e v = v)
    (hact_mul : ∀ b c : M, ∀ u : V, act (mulf b c) u = act b (act c u)) :
    ∀ k, act (p k) v = w k := by
  intro k
  induction k with
  | zero =>
      calc act (p 0) v
          = act e v := by rw [hp0]
            -- 出発点の第 1 段。冪の定義。
        _ = v := hact_one
            -- 出発点の第 2 段。単位元の作用は動かさない。
        _ = w 0 := hw0.symm
            -- 出発点の第 3 段。反復の定義。
  | succ k ih =>
      calc act (p (k + 1)) v
          = act (mulf a (p k)) v := by rw [hpsucc]
            -- 一歩の第 1 段。冪の定義。
        _ = act a (act (p k) v) := hact_mul _ _ _
            -- 一歩の第 2 段。積の作用は作用を 2 度施したものである。
        _ = act a (w k) := by rw [ih]
            -- 一歩の第 3 段。帰納法の仮定。
        _ = w (k + 1) := (hwsucc k).symm
            -- 一歩の第 4 段。反復の定義。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
