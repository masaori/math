/-
「固有ベクトルへ行列の冪を作用させると、固有値の冪のスカラー倍になる」
（`claim_qbar_eigenvector_pow`）の必要十分版。

手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.qbarAction_pow_smul`）と同じ
「出発点の 4 段・一歩の 7 段」の帰納法である。削ったのは次のもので、削っても同じ手順で通る。

- 行列であること・列ベクトルであること → 勝手な 2 つの型 `M`・`V` でよい。
- スカラーが代数的数であること → 勝手な型 `K` でよい（体であることも、可換性も、
  逆元も、零元も使わない）。
- 積・スカラー倍であること → 勝手な二項演算 `mulf : M → M → M`・`mulK : K → K → K`・
  `smul : K → V → V` でよい。
- 作用が線型であること → 使うのは「その 1 つの行列 `a` がスカラー倍と交換すること」だけで、
  和を保つことは使わない。
- 値の有限性・添字の有限性・順序 → 一切要らない（有限和が現れない）。
- 冪と冪の列が再帰で定義されていること → 2 本の列 `p : ℕ → M`・`q : ℕ → K` と、
  その再帰の式を仮定として置けばよい。

残した仮定がなぜ要るか。

- `hp0` / `hpsucc`: 出発点の第 1 段と一歩の第 1 段で使う（冪の定義）。
- `hq0` / `hqsucc`: 出発点の第 4 段と一歩の第 7 段で使う（`z^0 = 1`・`z^{k+1} = z^k z`）。
- `hact_one`: 出発点の第 2 段で使う（`act e v = v`）。単位行列の作用に当たる。
- `hsmul_one`: 出発点の第 3 段で使う（`smul one v = v`）。準備の第 1 の等式に当たる。
- `hact_mul`: 一歩の第 2 段で使う（積の作用）。
- `hact_smul`: 一歩の第 4 段で使う。**`v` と `a` を固定した形で足りる**
  （任意の行列・任意のベクトルについて交換する必要はない）。
- `heigen`: 一歩の第 5 段で使う（`act a v = smul z v`）。固有ベクトルの等式に当たる。
- `hsmul_mul`: 一歩の第 6 段で使う。**`v` を固定した形で足りる**。

すなわち、この段が要求するのは**2 本の再帰の式と、上の 6 つの等式だけ**であり、
代数構造も有限性も順序も、`v` が零でないことも一切使っていない。

住処: ここに ℝ / ℂ は現れない。
mathlib からは何も import していない（この段が既製の一般論を一切使わないことが、
import の無さとして見える。番号の型も `Nat` そのものを使う）。
-/
universe u v w

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版。再帰で作られた 2 本の列は、固有ベクトルの上で対応する。 -/
theorem action_pow_smul_necSuf {M : Type u} {V : Type v} {K : Type w}
    (mulf : M → M → M) (mulK : K → K → K) (act : M → V → V) (smul : K → V → V)
    (e a : M) (one z : K) (v : V) (p : Nat → M) (q : Nat → K)
    (hp0 : p 0 = e) (hpsucc : ∀ k, p (k + 1) = mulf a (p k))
    (hq0 : q 0 = one) (hqsucc : ∀ k, q (k + 1) = mulK (q k) z)
    (hact_one : act e v = v)
    (hsmul_one : smul one v = v)
    (hact_mul : ∀ b c : M, ∀ u : V, act (mulf b c) u = act b (act c u))
    (hact_smul : ∀ y : K, act a (smul y v) = smul y (act a v))
    (heigen : act a v = smul z v)
    (hsmul_mul : ∀ y y' : K, smul (mulK y y') v = smul y (smul y' v)) :
    ∀ k, act (p k) v = smul (q k) v := by
  intro k
  induction k with
  | zero =>
      calc act (p 0) v
          = act e v := by rw [hp0]
            -- 出発点の第 1 段。冪の定義。
        _ = v := hact_one
            -- 出発点の第 2 段。単位元の作用は動かさない。
        _ = smul one v := hsmul_one.symm
            -- 出発点の第 3 段。準備の第 1 の等式。
        _ = smul (q 0) v := by rw [hq0]
            -- 出発点の第 4 段。q 0 = one の約束。
  | succ k ih =>
      calc act (p (k + 1)) v
          = act (mulf a (p k)) v := by rw [hpsucc]
            -- 一歩の第 1 段。冪の定義。
        _ = act a (act (p k) v) := hact_mul _ _ _
            -- 一歩の第 2 段。積の作用は作用を 2 度施したものである。
        _ = act a (smul (q k) v) := by rw [ih]
            -- 一歩の第 3 段。帰納法の仮定。
        _ = smul (q k) (act a v) := hact_smul (q k)
            -- 一歩の第 4 段。作用はスカラー倍と交換する。
        _ = smul (q k) (smul z v) := by rw [heigen]
            -- 一歩の第 5 段。固有ベクトルの等式。
        _ = smul (mulK (q k) z) v := (hsmul_mul (q k) z).symm
            -- 一歩の第 6 段。準備の第 2 の等式。
        _ = smul (q (k + 1)) v := by rw [hqsucc]
            -- 一歩の第 7 段。q (k+1) = mulK (q k) z の約束。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
