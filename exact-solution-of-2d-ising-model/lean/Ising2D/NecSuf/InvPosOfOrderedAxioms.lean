/-
# 正の元の乗法の逆元は正（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealInverseOfPositiveIsPositive.lean`
（人手 `real_inverse_of_positive_is_positive`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealInverseOfPositiveIsPositiveFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 準備の `a ≠ 0`、逆元、`a⁻¹ ≠ 0` の鎖 3 段、場合分け、第 1〜第 3 の鎖（3 段・7 段・4 段）、推移律と結び | `inv_pos_of_orderedAxioms` の同じ並び |

## 何が効いているか / 効いていないか

- 効くのは、`0 ≠ 1`、`0 < 1`、順序の全域性と反対称律（`0 < a⁻¹` か `a⁻¹ < 0` の場合分け。`LinearOrder` の `lt_or_gt_of_ne`。
  反対称律は mathlib の `<` の定め方による）、`<` の推移律と `x < y ⇒ x ≠ y`、順序と加法の両立 `x < y ⇒ x + c < y + c`、
  正の元どうしの積は正、`0` でない元の右逆元 `x·x⁻¹ = 1`、`x·0 = 0`、`(−1)·x = −x`、乗法の結合則と可換則、
  加法の逆元 `z + (−z) = 0`、左からの加法の単位元 `0 + a = a`、加法の可換則だけである。
- 型には演算と元を持つだけの `Zero`・`One`・`Add`・`Neg`・`Mul`・`Inv` を置き、使う等式はすべて仮定に書く。
  `x·0 = 0`・`(−1)·x = −x`・`0 < 1` は具体版では示した主張（`real_times_zero_is_zero`・`real_minus_one_times_is_negation`・
  `real_zero_less_than_one`）を引く段で、ここではその結論だけを仮定に置く。
- `0 ≠ 1` は `0 < 1` と `x < y ⇒ x ≠ y` からも出るが、具体版の手順（`a⁻¹ ≠ 0` を体の公理 `0 ≠ 1` で示す）に合わせて仮定に置く。
- 乗法の可換則は、人手の鎖が `a·(−1)` を `(−1)·a` に替えて `(−1)·x = −x` を当てる段にだけ効く（人手の経路のためで、主張には本質的でない）。
- 加法の結合則、右からの単位元 `a + 0 = a`・`1·a = a`・`a·1 = a`、分配則、左逆元 `x⁻¹·x = 1` は効いていない。
  実数であること、完備性も効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`real_inverse_of_positive_is_positive`** の必要十分版: 順序の全域性と反対称律（`lt_or_gt_of_ne` の中）、推移律、`x < y ⇒ x ≠ y`、順序と加法の両立、正の元どうしの積は正、
`0 ≠ 1`・`0 < 1`、右逆元、`x·0 = 0`、`(−1)·x = −x`、乗法の結合則と可換則、加法の逆元・左単位元・可換則から、
`0 < a` なら `0 < a⁻¹`。 -/
theorem inv_pos_of_orderedAxioms {R : Type*} [Zero R] [One R] [Add R] [Neg R] [Mul R] [Inv R] [LinearOrder R]
    (h01 : (0 : R) ≠ 1)
    (hzero_lt_one : (0 : R) < 1)
    (hmul_inv : ∀ x : R, x ≠ 0 → x * x⁻¹ = 1)
    (hmul_zero : ∀ x : R, x * 0 = 0)
    (hneg_one_mul : ∀ x : R, (-1) * x = -x)
    (hmul_assoc : ∀ x y z : R, x * y * z = x * (y * z))
    (hmul_comm : ∀ x y : R, x * y = y * x)
    (hadd_neg : ∀ z : R, z + -z = 0)
    (hzero_add : ∀ x : R, 0 + x = x)
    (hadd_comm : ∀ x y : R, x + y = y + x)
    (hadd : ∀ x y c : R, x < y → x + c < y + c)
    (hmul : ∀ x y : R, 0 < x → 0 < y → 0 < x * y)
    (a : R) (ha : 0 < a) : 0 < a⁻¹ := by
  have ha0 : a ≠ 0 := by
    have h0a : (0 : R) ≠ a := (lt_iff_le_and_ne.mp ha).2      -- `<` の意味の後半
    exact fun h => h0a h.symm                                -- 等号の対称律の対偶
  have hinv : a * a⁻¹ = 1 := hmul_inv a ha0                  -- 右逆元
  have hinv0 : a⁻¹ ≠ 0 := by
    intro h
    have h10 : (1 : R) = 0 :=
      calc (1 : R)
          = a * a⁻¹ := hinv.symm                              -- 右逆元を右辺から左辺へ
        _ = a * 0 := by rw [h]                                -- 仮定 `a⁻¹ = 0`
        _ = 0 := hmul_zero a                                  -- `x·0 = 0`
    exact h01 h10.symm                                       -- `0 ≠ 1` に反する
  rcases lt_or_gt_of_ne (fun h => hinv0 h.symm) with h | h   -- 全域性で `0 < a⁻¹` か `a⁻¹ < 0`
  · exact h
  · exfalso
    have h1 : (0 : R) < -a⁻¹ :=
      calc (0 : R)
          = a⁻¹ + -a⁻¹ := (hadd_neg a⁻¹).symm                 -- 加法の逆元を右辺から左辺へ
        _ < 0 + -a⁻¹ := hadd a⁻¹ 0 (-a⁻¹) h                   -- 順序と加法の両立
        _ = -a⁻¹ := hzero_add (-a⁻¹)                          -- 加法の単位元
    have h2 : (0 : R) < -1 :=
      calc (0 : R)
          < a * -a⁻¹ := hmul a (-a⁻¹) ha h1                   -- 正の元どうしの積は正
        _ = a * ((-1) * a⁻¹) := by rw [hneg_one_mul a⁻¹]      -- `(−1)·x = −x` を右辺から左辺へ
        _ = (a * (-1)) * a⁻¹ := (hmul_assoc a (-1) a⁻¹).symm  -- 乗法の結合則
        _ = ((-1) * a) * a⁻¹ := by rw [hmul_comm a (-1)]      -- 乗法の可換則
        _ = (-1) * (a * a⁻¹) := hmul_assoc (-1) a a⁻¹         -- 乗法の結合則
        _ = (-1) * 1 := by rw [hinv]                          -- 右逆元
        _ = -1 := hneg_one_mul 1                              -- `(−1)·x = −x`
    have h3 : (1 : R) < 0 :=
      calc (1 : R)
          = 0 + 1 := (hzero_add 1).symm                       -- 加法の単位元を右辺から左辺へ
        _ < -1 + 1 := hadd 0 (-1) 1 h2                        -- 順序と加法の両立
        _ = 1 + -1 := hadd_comm (-1) 1                        -- 加法の可換則
        _ = 0 := hadd_neg 1                                   -- 加法の逆元
    have h00 : (0 : R) < 0 := lt_trans hzero_lt_one h3       -- 推移律
    exact (lt_iff_le_and_ne.mp h00).2 rfl                    -- `<` の意味の後半で `0 ≠ 0`、反射律に反する

end Ising2D.NecSuf
