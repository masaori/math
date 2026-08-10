/-
主張「シフト行列の固有値は 1 の L 乗根である」（`claim_shift_matrix_eigenvalue_root_of_unity`）
の必要十分版。手順は具体版と同じ（冪を運んだ等式と固有ベクトルの冪の作用を突き合わせて
`y ⊙ v = v` を出し、各点の計算で `(y + (-1)) ⊙ v = o` にしてから、
前セクションの主張でスカラーが零であることを出す）で、仮定だけを、その証明が実際に
使っているものまで削ってある。

削った結果として残ったのは次の 12 の仮定だけである。

  hpow      : An = Id                              … A^n = I（評価で運んだ等式）
  hact      : act An v = s y v                     … 冪の作用が y のスカラー倍であること
  hid       : act Id v = v                         … 単位元の作用が動かさないこと
  hs        : s z w i = mul z (w i)                … スカラー倍が各点の積であること
  ho        : o i = zero                           … 零ベクトルが各点で零であること
  hdistr    : mul (add a b) c = add (mul a c) (mul b c) … 右分配則
  honeL     : mul one x = x                        … one が積の左単位元であること
  hnegR     : add one (neg one) = zero             … neg one が one の加法についての右逆元
  hnegL     : add (neg one) one = zero             … 同じく左逆元
  hzeroL    : mul zero x = zero                    … 零元との積が零元であること
  haddzeroR : add x zero = x / hzeroaddL : add zero x = x … zero が加法の単位元であること
  haddassoc : add (add a b) c = add a (add b c)    … 加法の結合則
  hcancel   : s w v = o → w = zero                 … 前セクションの主張（`claim_qbar_smul_eq_zero`）

**指数がここに現れない。** 具体版の `z^L` は 1 つの元 `y` として扱えば足り、
それが冪であることも、`n` が何であることも使わない。

使っていないもの: 行列であること（`M` は勝手な型で、`act` は勝手な写像）、
積の可換性・結合則、加法の可換性、一般の元の加法逆元（要るのは `one` のものだけ）、
型 `K` の代数構造（体でも環でもない）、添字の型 `ι` の有限性・相等の決定可能性、
値が代数的数であること。mathlib からは何も import していない。

住処: ここに ℝ / ℂ は現れない（型 ι・K・M は任意）。
-/

universe u v w

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 固有値の冪が単位元であること（必要十分版）。 -/
theorem eigenvalue_pow_eq_one_necSuf
    {ι : Type u} {K : Type v} {M : Type w}
    (add mul : K → K → K) (neg : K → K) (one zero : K)
    (s : K → (ι → K) → (ι → K)) (o : ι → K)
    (act : M → (ι → K) → (ι → K))
    (An Id : M) (v : ι → K) (y : K)
    (hpow : An = Id)
    (hact : act An v = s y v)
    (hid : act Id v = v)
    (hs : ∀ (z : K) (w : ι → K) (i : ι), s z w i = mul z (w i))
    (ho : ∀ i : ι, o i = zero)
    (hdistr : ∀ a b c : K, mul (add a b) c = add (mul a c) (mul b c))
    (honeL : ∀ x : K, mul one x = x)
    (hnegR : add one (neg one) = zero)
    (hnegL : add (neg one) one = zero)
    (hzeroL : ∀ x : K, mul zero x = zero)
    (haddzeroR : ∀ x : K, add x zero = x)
    (hzeroaddL : ∀ x : K, add zero x = x)
    (haddassoc : ∀ a b c : K, add (add a b) c = add a (add b c))
    (hcancel : ∀ w : K, s w v = o → w = zero) :
    y = one := by
  -- 第 2 の鎖。y ⊙ v = act An v = act Id v = v。
  have hsmul : s y v = v := by
    calc s y v = act An v := hact.symm
      _ = act Id v := by rw [hpow]
      _ = v := hid
  -- 第 3 の鎖。各点で (y + neg one) ⊙ v の値が零であること。
  have hzero : s (add y (neg one)) v = o := by
    funext i
    calc s (add y (neg one)) v i
        = mul (add y (neg one)) (v i) := hs _ _ _
      _ = add (mul y (v i)) (mul (neg one) (v i)) := hdistr _ _ _
      _ = add (s y v i) (mul (neg one) (v i)) := by rw [hs]
      _ = add (v i) (mul (neg one) (v i)) := by rw [hsmul]
      _ = add (mul one (v i)) (mul (neg one) (v i)) := by rw [honeL]
      _ = mul (add one (neg one)) (v i) := (hdistr _ _ _).symm
      _ = mul zero (v i) := by rw [hnegR]
      _ = zero := hzeroL _
      _ = o i := (ho i).symm
  -- 最後の段。前セクションの主張でスカラーが零であることを出す。
  have hy : add y (neg one) = zero := hcancel _ hzero
  calc y = add y zero := (haddzeroR y).symm
    _ = add y (add (neg one) one) := by rw [hnegL]
    _ = add (add y (neg one)) one := (haddassoc _ _ _).symm
    _ = add zero one := by rw [hy]
    _ = one := hzeroaddL one

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
